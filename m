Date: Fri, 16 Nov 2001 09:42:10 -0700
From: Matt Porter <mporter@mvista.com>
To: Tom Rini <trini@kernel.crashing.org>
Cc: linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Organisation of 4xx initialization code
Message-ID: <20011116094210.B3473@beef.az.mvista.com>
References: <20011116164625.K673@zax> <20011116045737.A24130@cx258813-a.chnd1.az.home.com> <20011116085121.D5410@cpe-24-221-152-185.az.sprintbbd.net>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011116085121.D5410@cpe-24-221-152-185.az.sprintbbd.net>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Nov 16, 2001 at 08:51:21AM -0700, Tom Rini wrote:
> On Fri, Nov 16, 2001 at 04:57:38AM -0700, Matt Porter wrote:
> >
> > On Fri, Nov 16, 2001 at 04:46:26PM +1100, David Gibson wrote:
> > >
> > > At the moment the initialization for each of the 4xx boards goes
> > > through the platform_init() in arch/ppc/kernel/ppc4xx_setup.c, which
> > > in turns calls a board_init() function for the specific board.
> > >
> > > It seems to me that it would make more sense to put platform_init() in
> > > the board specific files, and these functions could then call back,
> > > where appropriate, to generic 4xx setup functions.  This would mean:
> > > 	- It would be easier to support wierd and wacky boards which
> > > have non-standard address setups.
> > > 	- Some ugly #ifdefs in ppc4xx_setup.c could be done away with.
> > > 	- We should be able to remove some inconvenient header
> > > dependencies - at present lots of things are recompiled when board
> > > local defines are changed because walnut.h/ep405.h/etc are included
> > > indirectly in serial.h and some other unexpected places.
> > >
> > > Thoughts?
> >
> > I've been wondering why it's architected that way as well.  It
> > seems you are looking for it to follow the model of the well
> > abstracted 7xx/74xx ports.  Examples are the ones that rely on
> > mpc10x_common and pplus_common as libraries of common initialization
> > code (MEN F1, PCore, MCPN765, MVME5100, etc.).
>
> But that's just it.  Someone else should probably speak up on this, but
> in the 403/405/stb0{3,4}xxx, and possibly 440 when it exists there are
> some things which always exist, depending on processor.  Each 750 board

Leave the 440 out of this, it should never pollute the classic PPC
tree if it's done correctly.

> for example can really have almost anything attached to it.  But for a
> 405GP, there are known things and some variable things.  I _think_ 4xx
> boards vary more like the 8xx ones do, than 750 does.

405GP specifically is similar to an 8240 in that the "system
controller" is fixed.  That is, there is a known PPC core,
memory controller, PCI bridge, and a set of peripherals.
8240 ports are using the "7xx/74xx" approach because it fits
well.  You could make the same argument that all gt64260+7xxx
ports belong in one file rather than a board specific file
that calls to a common set of library initialization routines.

> Having said that, there is room for imporvement, but I think it's more
> along the lines of moving more things into board_init which can override
> the default structs if needed.

Because it has a PCI bridge on it (which can be very flexibly
mapped, like it's CPC700 cousin) there is going to be a wide
variation in the systems it's placed in.  I can already see
that from the custom designs known internally as well as the
COTs boards that include cPCI and ATX systems.  Interestingly,
this is the same wide variation of system designs that 8240's
find themselves in.

If it was an 8xx-style SoC that didn't have a built-in standard
bus (meaning PCI(X), RapidIO, etc) I'd be thinking differently.

--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
