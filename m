Date: Sat, 19 Oct 2002 12:14:24 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: Anders Blomdell <anders.blomdell@control.lth.se>
Cc: Hollis Blanchard <hollis@austin.ibm.com>,
	linuxppc embedded <linuxppc-embedded@lists.linuxppc.org>
Subject: Re: Problems with 2_4_devel & MVME2600 serial interrupts
Message-ID: <20021019191424.GB722@opus.bloom.county>
References: <1034954142.8169.91.camel@granite.austin.ibm.com> <E9EEC3C2-E2B0-11D6-8132-0003931C2BFA@control.lth.se> <20021018200355.GD6941@opus.bloom.county> <1035052555.1506.10.camel@maj.hemma>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1035052555.1506.10.camel@maj.hemma>
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Sat, Oct 19, 2002 at 08:35:52PM +0200, Anders Blomdell wrote:
> > On Fri, Oct 18, 2002 at 05:47:32PM +0200, Anders Blomdell wrote:
> > >
> > > >Seems to me that either:
> > > >a) the pci_intack value is incorrect for your board, in which case you
> > > >should correct it
> > > Shure is, question is if it really should be caught from the pci_intack
> > > register, as far as I can understand from the MVME2600 doc's, the 8259
> > > interrupt generates a MPIC-IRQ0, but one has to poll the 8259 to find out
> > > what device it was that generated the interrupt.
> >
> > Are you running this as CONFIG_ALL_PPC?  IIRC, under 2_4_devel, this
> > board should work as CONFIG_PPLUS.  Or it will need minor fixups, which
> > I have described previously on the lists (and possibly to you as well)
> > for the OpenPIC table.
> CONFIG_ALL_PPC, yes.
> >
> > > >b) your board's int-ack feature is broken and you'll need to poll
> > >
> > > Perhaps an extra field in the 'mot_info' (arch/ppc/platforms/prep_pci.c) is
> > > called for? This line in prep_init_IRQ (arch/ppc/platforms/prep_setup.c):
> > >
> > >   i8259_init(0xbffffff0); /* PCI interrupt ack address for MPC105 and 106
> > > */
> > >
> > > does not look like a general solution.
> >
> > Well, it's a correct solution for the PReP like PReP machines.  Where in
> > the continium does the MVME2600 fall exactly?
> > MPC105/MPC106/Raven/Hawk/Falcon ?  I _think_ this is an example of why
> > it would really be nice to kill PPLUS support from PReP.  But I know
> > that will upset some people, so I'm not advocating that for 2.4, and it
> > looks like we might have to do something similar to the MPC10x test in
> > the PReP bootwrapper code in 2.5 (and maybe 2.4? I'm not at home, so I
> > can't easily check).
> It's a Raven equipped card, and as far as I can find, the 8259
> interrupts acks are not accessible from any other adress. I'll look
> further into this on monday...

Any address other than what?  If i8259_init is passed 0, then we poll,
instead of asking the int-ack.

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
