Date: Thu, 20 Sep 2001 07:55:37 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Dan Malek <dan@mvista.com>
Cc: Linuxppc-Embedded <linuxppc-embedded@lists.linuxppc.org>,
	Linuxppc-Commit <linuxppc-commit@source.mvista.com>
Subject: Re: CPCI-405 port (PPC405GP)
Message-ID: <20010920075537.A13721@cpe-24-221-152-185.az.sprintbbd.net>
References: <20010918115722.A5967@cpe-24-221-152-185.az.sprintbbd.net> <EFEAIMDCOOOHIEPHDNFJCEKKDCAA.stefan.roese@esd-electronics.com> <20010919071751.B8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA8DF9E.FD235CF6@mvista.com> <20010919155742.D8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA9241B.4322817A@mvista.com> <20010919163101.E8132@cpe-24-221-152-185.az.sprintbbd.net> <3BA96CA2.20EC30C8@mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <3BA96CA2.20EC30C8@mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Sep 20, 2001 at 12:12:18AM -0400, Dan Malek wrote:
> Tom Rini wrote:
>
> > ....  We
> > now define CONFIG_TREEBOOT and CONFIG_EMBEDDEDBOOT for 4xx.
>
> Why?  The Makefile can just as easily select this based upon board
> type.  That's all the configuration script does....

Well, because it keeps us from duplicating 4 lines in the makefile.
As far as I know, you can't do ifdef CONFIG_8xx || CONFIG_EP405 for
example, in a Makefile.  CONFIG_TREEBOOT could probably die, unless
someone revives Oak or TiVo uses it.

> The only thing unique about treeboot is the way the board information
> is gathered from the boot rom, which doesn't justify configuration
> variables like this.

treeboot also needs it's own special image format.  So like I said,
CONFIG_TREEBOOT could go away if TiVo and Oak (if it gets revived)
need it.  Remember, Makefile magic isn't as extensible as cpp magic.


> > ....  Lets add in
> > CONFIG_PPCBOOT,
>
> No, let's not.  All of this stuff is on the way out.  We should be
> making modifications so the embedded boards support bi_recs....

Not in 2.4 we aren't.  We aren't forcing bi_recs upon everyone just
yet.

> The PPCboot folks are going to have to do some major revamping
> of the way it works.  I've warned them (and everyone) about the
> dependency of always using the compressed image and the bootloaders.

Eh?  As far as I know, PPCBoot takes it's own slighlty mod'ed objcopy'ed
and gzip'ed vmlinux.  What's wrong with that?  Hell, even in 2.5 as long
as we get the bi_recs, we shouldn't care what the bootloader does..

> > Or not, 8xx currently does #include <asm/ppcboot.h> in lots of its files.
>
> Crap, I hope not.....It's time for all of that to disappear, along with
> all of the board information stuff in all of the other 8xx files.....

ppcboot.h just defines the board information struct that PPCBoot passes along.
Are you talking about the board-specific stuff which is just there to be
complete or what?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
