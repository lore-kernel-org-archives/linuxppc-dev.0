Return-Path: <owner-linuxppc-dev@lists.linuxppc.org>
Date: Tue, 4 Sep 2001 13:49:35 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Edward Swarthout <swarthou@ibmoto.com>
Cc: paulus@samba.org, linuxppc-dev@lists.linuxppc.org
Subject: Re: Assorted patches - number one
Message-ID: <20010904134935.F11530@cpe-24-221-152-185.az.sprintbbd.net>
References: <200108311711.f7VHBxS14716@pacific.somerset.sps.mot.com> <15251.459.153586.712142@cargo.ozlabs.ibm.com> <200109041951.f84JpGA18512@pacific.somerset.sps.mot.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <200109041951.f84JpGA18512@pacific.somerset.sps.mot.com>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Tue, Sep 04, 2001 at 02:51:16PM -0500, Edward Swarthout wrote:

> For others,
> to get the most benefit with gdb on the kernel, it needs to be
> compiled with -g.  This allows the root user to peek around with
> "gdb vmlinux-g /proc/kcore".  I don't know if there is a need for
> this or how to make it configurable, but here is a simple patch:

In HHL 2.0 we do this:
ifdef CONFIG_KGDB
CFLAGS += -g
ifdef CONFIG_KGDB_MORE
  # Use sed to remove the quotes.
  CFLAGS += $(shell echo $(CONFIG_KGDB_OPTIONS) | sed -e 's/"//g')
endif
endif

And then have a question like:
   bool 'Add any additional compile options' CONFIG_KGDB_MORE
      if [ "$CONFIG_KGDB_MORE" = "y" ]; then
           string 'Additional compile arguments' CONFIG_KGDB_OPTIONS "-O1 -ggdb"
      fi

I was never sure if this was something that just worked but looked ugly, or
if it was actually useful..

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
