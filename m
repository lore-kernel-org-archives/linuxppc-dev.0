Message-ID: <39230168.72A9125E@embeddededge.com>
Date: Wed, 17 May 2000 16:30:32 -0400
From: Dan Malek <dan@netx4.com>
MIME-Version: 1.0
To: Frank Przybylski <Frank.Przybylski@vas-gmbh.de>
CC: linuxppc-embedded@lists.linuxppc.org
Subject: Re: Getting the image section of the ELF file to load w/ VxWorks boot
 ROM
References: <m12mgPF-001SyZC@bucks> <3917E2A7.6EEDDD93@vas-gmbh.de>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Frank Przybylski wrote:
>
> Hi,
> I had similar problems when loading kernel images with gdb over BDM into
> an MPC.


I'm not picking on you Frank, but with all of the recent trouble
people are having loading kernels.......well, I just can't understand
why everyone is using such complex methods for development.

>From my perspective, you need a minimum of:

	1. Processor initialization software (i.e. boot rom)
	2. Some format and method for loading the Linux kernel in
		your product
	3. The Linux kernel.

So, why don't you break your development into these more simple steps?
You need processor initialization, and the BDM tools work great for
that.  Use it and get this done and out of the way.  This has nothing
to do with Linux and can be a big time sink or saver (depending upon
your methods).

If you are going to start by debugging the Linux kernel (and I don't
know why you would), at least load vmlinux (not zImage) with the
debuggers.  It is a real ELF image with all of the symbols that
every tool, including GDB will grok just fine.

Last, determine how you are going to use this in your product, then
use the code in arch/ppc/mbxboot to build something.  Hell, if you
think about it long enough and realize that others are very successful,
you may find what is currently there will work as it is or with minimal
changes.

Trying to develop an embedded Linux kernel using standard default
BDM tools and using the zImage is.....well....just about the most
difficult method.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
