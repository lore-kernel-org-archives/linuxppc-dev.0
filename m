Return-Path: <owner-linuxppc-embedded@lists.linuxppc.org>
Message-ID: <3BCF580D.47B44367@kegel.com>
Date: Thu, 18 Oct 2001 15:30:37 -0700
From: Dan Kegel <dank@kegel.com>
MIME-Version: 1.0
To: "linuxppc-embedded@lists.linuxppc.org" <linuxppc-embedded@lists.linuxppc.org>
Subject: autoconf and cross-compiling?
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


I'm trying to document the right way to cross-compile
applications which use autoconf/automake.  configure
has a --target flag, but I can't see how to get it to do anything
useful.

The goat book has what looks like a helpful section
  http://sources.redhat.com/autobook/autobook/autobook_261.html#SEC261
which talks about the macros AC_CANONICAL_SYSTEM and AC_ARG_PROGRAM,
but it turns out this only affects tool names *when installing*.
It's useful when *building* cross compilers, not when using them.

My best guess at the moment is:
  Before running 'configure', set the environment variables
  CC, CXX, RANLIB, and AR to point to the cross-development
  tools you want to use, *and* tell configure the target name,
  e.g.
    CC=powerpc-linux-gcc CXX=powerpc-linux-g++ RANLIB=powerpc-linux-ranlib AR=powerpc-linux-ar ./configure --target=powerpc-linux

Is this right?

If so, this is suprisingly clumsy.  I would expect configure to let you set
both the target name and the tool names in one fell swoop, e.g.
    ./configure --with-target=powerpc-linux
but since few people do cross-development, maybe this hasn't been made easy.

- Dan

(originally posted to gnu.gcc.help, but no response there)

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
