Date: Fri, 16 Nov 2001 19:15:34 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>, Dan Malek <dan@embeddededge.com>
Subject: Re: Organisation of 4xx initialization code
Message-ID: <20011116191534.A9923@cpe-24-221-152-185.az.sprintbbd.net>
References: <20011116164625.K673@zax> <20011116075917.A5410@cpe-24-221-152-185.az.sprintbbd.net> <20011117114052.F12763@zax>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011117114052.F12763@zax>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Nov 17, 2001 at 11:40:52AM +1100, David Gibson wrote:
> On Fri, Nov 16, 2001 at 07:59:17AM -0700, Tom Rini wrote:
> >
> > On Fri, Nov 16, 2001 at 04:46:26PM +1100, David Gibson wrote:
> >
> > > At the moment the initialization for each of the 4xx boards goes
> > > through the platform_init() in arch/ppc/kernel/ppc4xx_setup.c, which
> > > in turns calls a board_init() function for the specific board.
> > >
> > > It seems to me that it would make more sense to put platform_init() in
> > > the board specific files, and these functions could then call back,
> > > where appropriate, to generic 4xx setup functions.  This would mean:
> >
> > But 95% of the current 4xx platform_init is generic.  With the exception
> > of the redwood kbd init stuff, which right now we could probably move
> > into the redwood board_init (providing redwood_irkb_init sets things to
> > NULL which the previous bits set).
>
> And the common stuff can still be shared - it's just that the board
> code, which clearly knows more about the configuration than the 4xx
> generic stuff, chooses what order to do things in.

And provided things are done in the 'right' order to start with, it
should just work.  We deal with having a rather useless firmware on 7xx
by doing things under ppc_md I believe.  So why not here?  Keep in mind
that 'board_init' is calling in platform_setup and can override ppc_md
stuff set in platform_setup.

> > > 	- We should be able to remove some inconvenient header
> > > dependencies - at present lots of things are recompiled when board
> > > local defines are changed because walnut.h/ep405.h/etc are included
> > > indirectly in serial.h and some other unexpected places.
> >
> > Keep in mind <asm/ibm4xx.h> has the same exact thing.  As does
> > <asm/mpc8xx.h>.  There's lots of wierd header dependancies, and it's not
> > fixable in 2.4 anyhow.  kbuild-2.5 doesn't have this issue, and this
> > isn't even much of a problem anyhow.
>
> Um, no, this has nothing to do with the build system.  Board specific
> header files, which contain largely information which is irrelevant to
> everything except the board and 4xx setup code is being indirectly
> included in parts of the generic kernel.  That creates a dependency
> regardless of the build system.

So what were you complainging about <asm/serial.h> deps for?  It isn't
excactly nice, but it's not exactly related to this.  And supposedly
kbuild-2.5 is smarter about how it does deps, so unless you're say
CONFIG_SPRUCE, changing <asm/spruce_serial.h> won't effect
<asm/serial.h> on !CONFIG_SPRUCE.  If I understand things right.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
