Date: Mon, 8 Apr 2002 11:07:54 -0700
From: Matt Porter <mporter@mvista.com>
To: Gabriel Paubert <paubert@iram.es>
Cc: Matt Porter <mporter@mvista.com>,
	Tom Rini <trini@kernel.crashing.org>, linuxppc-dev@lists.linuxppc.org
Subject: Re: CONFIG_GENERIC_PPC32
Message-ID: <20020408180754.GC23616@beef.az.mvista.com>
References: <20020408102348.A1048@home.com> <Pine.LNX.4.33.0204081924240.12075-100000@gra-lx1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.LNX.4.33.0204081924240.12075-100000@gra-lx1.iram.es>
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, Apr 08, 2002 at 07:37:13PM +0200, Gabriel Paubert wrote:
>
>
> On Mon, 8 Apr 2002, Matt Porter wrote:
>
> > Most of the MCG's residual data are so incorrect that you spend more time
> > fixing stuff up than using this "wonderful" source of board info. I had
> > an opportunity to examine all of them in detail at my previous employer
> > to realize that it's mostly useless to use it.
>
> I did not find so many bugs myself on MVME2400 and 2600. Actually I found
> them mostly correct in my case...

The cPCI boards are especially bad as well as the 2300sc.

> > Couple that with the constant breakage of a numer of the boards by all
> > the tweaks to real legacy PReP workstations.
> >
> > The CONFIG_PPLUS port made the code clean, neat, and maintainable.
>
> Never enabled it for my boards until now, but I'm not interested at all in
> having a ROMBoot image either. Almost all my boards used dhcp/bootp, the
> other ones have a disk...

Yeah, I figured that's not what everybody wants but it is a popular
deployment option given the feedback I got on my original kludge
that was the standalone "bugboot" package.

> > Because the CONFIG_PPLUS port doesn't rely on residual data, the
> > ability to create a "ROMboot" image is simplified to the point that
> > it is generated in the kernel instead of an 18 step process involving
> > dumping a copy of residual data that was only being used to get
> > the memory size.  Retrieving memory size from the memory controller
> > configuration already had been done for other MCG boards with
> > inaccurate residual data info.
>
> Do the kernel tables have the right interrupt routing for MVME3600 with
> secondary Ethernet/SCSI for example ?

Unfortunately, the PReP port only ever supported the old INTA
routing tables so anything with slots was screwy.  There was
some route non-0 code but it was mostly a kludge.  A couple years
ago (when I had access to a MVME3600), it had the correct bus 0
routing tables in the PReP port.

The CONFIG_PPLUS port may or may not have the correct routings
for a MVME3600.  Randy, who did the work tried to get the
correct tables from the engineering docs but due to lack of
hardware it hasn't been tested.  Since the PPLUS port uses
the map_irq and swizzle kernel support it has proper A-D routing
tables that will work for add-in bridged I/O.

> > The firmware group at MCG will _never_ fix the residual data since
> > their AIX doesn't use it.  Even when they had some decent staff
> > on hand they weren't willing to fix anything related to residual
> > data.  Now, they've laid off just about everybody so it's guaranteed
> > to never happen.
> >
> > CONFIG_PPLUS also made it easy to add pci_auto support since putting
> > it in PReP would have been a complete mess...
> >
> > > > > (Who should have properly submitted his PrePboot code 3 years ago)
> >
> > Yeah, you even had a sorting autoconfiguration algorithm in prepboot,
> > IIRC.
>
> Indeed, can you think of any other solution when you reprogram the whole
> PCI<->PPCbus maps of the chipset ?

Most firmwares use a lossy allocator since the recursive implementation
is _very_ simple/compact code.  pci_auto.c is such an implementation.
Obviously, the disadvantage is that a large 1GB BAR discovered after a
4KB BAR will result in 2GB of PCI mem space being consumed.  To date,
that hasn't been too much of a problem...but will become one with the
"crazy" shared PCI memory systems being designed. :)

> The only problem is that it probably does not work with PCI<->PCI bridges
> since I never had the hardware to test (I believe I even never implemented
> that part, or scrapped after a brief attempt).

That was a focus of the pci_auto.c code since so many embedded boards
have rotten firmware.  We've haven't turned up any new bugs in many
months of throwing lots of complex cPCI/P2P configurations at it
which are generally the worst case situations.

I'd really like to extend it to a two pass sorting algorithm (a good
project for somebody with some extra time!).  Someday...

Regards,
--
Matt Porter
MontaVista Software, Inc.
mporter@mvista.com

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
