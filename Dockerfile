FROM alpine:latest AS build

WORKDIR /docs

COPY mkdocs.yml mkdocs.yml
COPY docs docs

RUN apk add --no-cache py3-pip \
    && pip install mkdocs \
    && pip install mkdocs-material \
    && mkdocs build

FROM nginx:alpine AS run

COPY --from=build /docs/site /usr/share/nginx/html

EXPOSE 80