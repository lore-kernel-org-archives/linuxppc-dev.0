Message-ID: <3839CF18.5D600DE@mvista.com>
Date: Mon, 22 Nov 1999 15:17:44 -0800
From: Christian Zankel <chris@mvista.com>
MIME-Version: 1.0
To: Cort Dougan <cort@fsmlabs.com>
CC: linuxppc-dev@lists.linuxppc.org, linuxppc-embedded@lists.linuxppc.org
Subject: Re: bootloader & head.S weirdness & restructuring
References: <19991122120429.031138@mailhost.mipsys.com> <19991122143732.B12973@hq.fsmlabs.com>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Hi,

It seems to me that on almost every machine linuxppc is running on
depends on having a bootloader to load the kernel. Would it be possible
to redesign all bootloaders to load the kernel to position 0, initialize
the OF path where necessary and jump to the kernel with the MMU switched
off? Then we could possibly remove all the conditional code (#if ...
#else .. #endif) in head.S mm/init.c, etc.

Right now, it is painfull to add a new machine that doesn't follow the
full PReP,CHRP specification, i.e. has no OF nor Residual Data
structures, etc.

I started to restructure the arch/ppc tree. However, I would like to
hear about your thoughts and recommendation. The goals I want to
achieve, are:

1. The bootloader gets a more active part, i.e. does some
pre-initiaization, esp. to get rid of the 'bl prom_init' and the variaty
of copying the kernel back and forth.
2. It should be possible to setup the kernel so that the same kernel
runs on all those machine that it is setup for. Of course, the more
machines you add the more overhead you get.
3. Each machine/architecture should get its own directory (pmac, prep,
chrp, apus, geminit, etc.)
4. To add a new machine, only a new directory has to be added and only a
few files have to be changed (mainly: Config.in and Makefile).
5. The _machine-ID is seperated into to fields, Vendor and Board.



Thanks,
Christian

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
