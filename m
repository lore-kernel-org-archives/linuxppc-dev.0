Message-ID: <3BAA0C91.42E0910D@mvista.com>
Date: Thu, 20 Sep 2001 11:34:41 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
References: <20010918115722.A5967@cpe-24-221-152-185.az.sprintbbd.net> <EFEAIMDCOOOHIEPHDNFJCEKKDCAA.stefan.roese@esd-electronics.com> <20010919071751.B8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA8DF9E.FD235CF6@mvista.com> <20010919155742.D8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA9241B.4322817A@mvista.com> <20010919163101.E8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA96CA2.20EC30C8@mvista.com> <20010920075537.A13721@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> Well, because it keeps us from duplicating 4 lines in the makefile.

OK.

> .....  CONFIG_TREEBOOT could probably die, unless
> someone revives Oak or TiVo uses it.

Walnut and Spruce use it.  Get it?  TREEboot?


> Not in 2.4 we aren't.  We aren't forcing bi_recs upon everyone just
> yet.

We should.  The purpose of consolidating bootloaders was to utilize
a bunch of generic code on both sides (bootloader and Linux).  It
isn't a major change on either side, since we already have bootloaders
that do it.


> Eh?  As far as I know, PPCBoot takes it's own slighlty mod'ed objcopy'ed
> and gzip'ed vmlinux.  What's wrong with that?

We (or at least I :-) make subtle changes to the parameters passed to
the kernel from the bootloaders from time to time.  This means people
with PPCboot roms have to change them any time this is done.  One of
the purposes of the bootloader is to isolate these changes into the
bootloader.

> ....  Hell, even in 2.5 as long
> as we get the bi_recs, we shouldn't care what the bootloader does..

The bootloader is a critical part to initializing the environment for
the kernel.  With all of the MMU futzing around we do trying to get
Linux running, Ben and I have discussed yet another better bootloader
method to move some of this around between the bootloader and the
kernel start up.  There are also initrd and command line things done
by the bootloader (among other board specific initialization).  It's
more than whether or not we all use bi_recs.

> Are you talking about the board-specific stuff .....

Never mind.  Not important.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
