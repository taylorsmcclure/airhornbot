FROM alpine:3.3
MAINTAINER Taylor McClure github.com/taylorsmcclure

RUN apk update \
    && apk add --no-cache go git \
    && mkdir /airhorn \
    && export GOPATH=/airhorn \
    && go get github.com/taylorsmcclure/airhornbot/cmd/bot \
    && go install github.com/taylorsmcclure/airhornbot/cmd/bot \
    && addgroup -S airhornbot \
    && adduser -h /airhornbot -s /sbin/nologin -S airhornbot -g airhornbot \
    && chown -R airhornbot:airhornbot /airhornbot \
    && apk del git

USER airhornbot
WORKDIR "/airhorn/src/github.com/taylorsmcclure/airhornbot"
EXPOSE 6379
ENTRYPOINT ["/airhorn/bin/bot"]
