# Get the base image and pin the version
FROM ruby:3.2.2

# throw errors if Gemfile has been modified since Gemfile.lock
RUN bundle config --global frozen 1

# Set the working directory
WORKDIR /usr/src/app

RUN adduser --disabled-password my-sinatra-user

USER my-sinatra-user

# The files will be owned by my-sinatra-user
COPY --chown=my-sinatra-user ruby-sample-app-main/Gemfile ruby-sample-app-main/Gemfile.lock ./

# Install the dependencies
RUN bundle config set without "development test" && \
  bundle install --jobs=3 --retry=3

COPY --chown=my-sinatra-user ruby-sample-app-main/run.sh ruby-sample-app-main/app.rb ./

EXPOSE 8080

CMD ["./run.sh"]