Date: Sat, 17 Nov 2001 11:50:44 +1100
From: David Gibson <david@gibson.dropbear.id.au>
To: Matt Porter <mporter@mvista.com>, t@samba.org
Cc: Tom Rini <trini@kernel.crashing.org>,
	linuxppc-embedded@lists.linuxppc.org,
	Paul Mackerras <paulus@samba.org>
Subject: Re: Organisation of 4xx initialization code
Message-ID: <20011117115044.I12763@zax>
References: <20011116164625.K673@zax> <20011116045737.A24130@cx258813-a.chnd1.az.home.com> <20011116085121.D5410@cpe-24-221-152-185.az.sprintbbd.net> <20011116094210.B3473@beef.az.mvista.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20011116094210.B3473@beef.az.mvista.com>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Fri, Nov 16, 2001 at 09:42:10AM -0700, Matt Porter wrote:
>
> On Fri, Nov 16, 2001 at 08:51:21AM -0700, Tom Rini wrote:
> > On Fri, Nov 16, 2001 at 04:57:38AM -0700, Matt Porter wrote:
> > >
> > > On Fri, Nov 16, 2001 at 04:46:26PM +1100, David Gibson wrote:
> > > >
> > > > At the moment the initialization for each of the 4xx boards goes
> > > > through the platform_init() in arch/ppc/kernel/ppc4xx_setup.c, which
> > > > in turns calls a board_init() function for the specific board.
> > > >
> > > > It seems to me that it would make more sense to put platform_init() in
> > > > the board specific files, and these functions could then call back,
> > > > where appropriate, to generic 4xx setup functions.  This would mean:
> > > > 	- It would be easier to support wierd and wacky boards which
> > > > have non-standard address setups.
> > > > 	- Some ugly #ifdefs in ppc4xx_setup.c could be done away with.
> > > > 	- We should be able to remove some inconvenient header
> > > > dependencies - at present lots of things are recompiled when board
> > > > local defines are changed because walnut.h/ep405.h/etc are included
> > > > indirectly in serial.h and some other unexpected places.
> > > >
> > > > Thoughts?
> > >
> > > I've been wondering why it's architected that way as well.  It
> > > seems you are looking for it to follow the model of the well
> > > abstracted 7xx/74xx ports.  Examples are the ones that rely on
> > > mpc10x_common and pplus_common as libraries of common initialization
> > > code (MEN F1, PCore, MCPN765, MVME5100, etc.).
> >
> > But that's just it.  Someone else should probably speak up on this, but
> > in the 403/405/stb0{3,4}xxx, and possibly 440 when it exists there are
> > some things which always exist, depending on processor.  Each 750 board
>
> Leave the 440 out of this, it should never pollute the classic PPC
> tree if it's done correctly.

Yes and no.  That's probably true for the processor core, but it's
likely to have onboard peripherals which are the same as or very
similar to older 4xx designs.  It would be nice if we could share the
code for handling these devices.

--
David Gibson			| For every complex problem there is a
david@gibson.dropbear.id.au	| solution which is simple, neat and
				| wrong.  -- H.L. Mencken
http://www.ozlabs.org/people/dgibson

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
