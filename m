Date: Mon, 8 Apr 2002 20:41:51 +0200 (CEST)
From: Gabriel Paubert <paubert@iram.es>
To: Matt Porter <mporter@mvista.com>
Cc: Tom Rini <trini@kernel.crashing.org>,
	<linuxppc-dev@lists.linuxppc.org>
Subject: Re: CONFIG_GENERIC_PPC32
In-Reply-To: <20020408180754.GC23616@beef.az.mvista.com>
Message-ID: <Pine.LNX.4.33.0204082017050.7764-100000@gra-lx1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Mon, 8 Apr 2002, Matt Porter wrote:

> The cPCI boards are especially bad as well as the 2300sc.

Ah, ok. Never had the (dis)pleasure to work with them...

> > > Because the CONFIG_PPLUS port doesn't rely on residual data, the
> > > ability to create a "ROMboot" image is simplified to the point that
> > > it is generated in the kernel instead of an 18 step process involving
> > > dumping a copy of residual data that was only being used to get
> > > the memory size.  Retrieving memory size from the memory controller
> > > configuration already had been done for other MCG boards with
> > > inaccurate residual data info.
> >
> > Do the kernel tables have the right interrupt routing for MVME3600 with
> > secondary Ethernet/SCSI for example ?
>
> Unfortunately, the PReP port only ever supported the old INTA
> routing tables so anything with slots was screwy.  There was
> some route non-0 code but it was mostly a kludge.  A couple years
> ago (when I had access to a MVME3600), it had the correct bus 0
> routing tables in the PReP port.

I suspect that INTA means 8259 crap, which I only use for serial
ports. All the other interrupts use the OpenPIC.

> > Indeed, can you think of any other solution when you reprogram the whole
> > PCI<->PPCbus maps of the chipset ?
>
> Most firmwares use a lossy allocator since the recursive implementation
> is _very_ simple/compact code.  pci_auto.c is such an implementation.
> Obviously, the disadvantage is that a large 1GB BAR discovered after a
> 4KB BAR will result in 2GB of PCI mem space being consumed.  To date,
> that hasn't been too much of a problem...but will become one with the
> "crazy" shared PCI memory systems being designed. :)

I know about typical lossy allocators: they hurt my aesthetic feelings ;-)
Especially since I wanted to compact everything to get the largest
posssible area for Universe VME mappings (and preferably through the BAT
mapped area). The algorithm is not complex, actually it was rather easy
once I had written all the memory management code for the x86 ROM BIOS
emulator: I just copied some linux kernel PCI code, added a trivial sort
routine on the resource trees (I/O, MMIO and I believe that I separated
prefetchable MMIO although it is only really needed for P2P bridges) and a
last pass to perform the actual BAR allocations.

The one shortcut I took is that I assumed that all bridges/devices would
allow 32 bit I/O space addresses, so I started at 0x10000 for I/O Space
allocation which guarantees no interference with ISA whatsoever. I know
that there are devices which only have 16 bit I/O space addresses but
they are a mess to handle properly when you have ISA devices lurking
around at random addresses.

> > The only problem is that it probably does not work with PCI<->PCI bridges
> > since I never had the hardware to test (I believe I even never implemented
> > that part, or scrapped after a brief attempt).
>
> That was a focus of the pci_auto.c code since so many embedded boards
> have rotten firmware.  We've haven't turned up any new bugs in many
> months of throwing lots of complex cPCI/P2P configurations at it
> which are generally the worst case situations.
>
> I'd really like to extend it to a two pass sorting algorithm (a good
> project for somebody with some extra time!).  Someday...

Me too, actually I believe P2P bridge support would be rather easy to add
to my code.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
