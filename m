Message-ID: <3BA96CA2.20EC30C8@mvista.com>
Date: Thu, 20 Sep 2001 00:12:18 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Tom Rini <trini@kernel.crashing.org>
Cc: Stefan Roese <stefan.roese@esd-electronics.com>,
	Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
References: <20010918115722.A5967@cpe-24-221-152-185.az.sprintbbd.net> <EFEAIMDCOOOHIEPHDNFJCEKKDCAA.stefan.roese@esd-electronics.com> <20010919071751.B8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA8DF9E.FD235CF6@mvista.com> <20010919155742.D8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA9241B.4322817A@mvista.com> <20010919163101.E8132@cpe-24-221-152-185.az.sprintbbd.net>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Tom Rini wrote:

> ....  We
> now define CONFIG_TREEBOOT and CONFIG_EMBEDDEDBOOT for 4xx.

Why?  The Makefile can just as easily select this based upon board
type.  That's all the configuration script does....

The only thing unique about treeboot is the way the board information
is gathered from the boot rom, which doesn't justify configuration
variables like this.  Take a look at the 8xx for an example.  It
configures board information based upon board type, which could be
gathered from a variety of places.  You guys need to look at what
is currently done, understand it, and realize it has likely been
done before.  This is easy, don't keep complicating it by inventing
something new all of the time.


> ....  Lets add in
> CONFIG_PPCBOOT,

No, let's not.  All of this stuff is on the way out.  We should be
making modifications so the embedded boards support bi_recs....
All you are doing is inventing a new way to do the same thing that
has always worked.  Yes, you are _way_ over engineering.

The PPCboot folks are going to have to do some major revamping
of the way it works.  I've warned them (and everyone) about the
dependency of always using the compressed image and the bootloaders.
It's time to convert all of this stuff, not promote all of these
different boot methods and formats further into the kernel.


> Or not, 8xx currently does #include <asm/ppcboot.h> in lots of its files.

Crap, I hope not.....It's time for all of that to disappear, along with
all of the board information stuff in all of the other 8xx files.....

Thanks.


	-- Dan

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
