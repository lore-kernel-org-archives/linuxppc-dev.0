Date: Sun, 27 Aug 2000 15:04:31 -0700
From: Matt Porter <mmporter@home.com>
To: Gabriel Paubert <paubert@iram.es>
Cc: David Monro <davidm@amberdata.demon.co.uk>,
        Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCI resource initialisation
Message-ID: <20000827150431.A8775@cx258813-a.chnd1.az.home.com>
References: <39A826A6.D551486F@amberdata.demon.co.uk> <Pine.HPX.4.10.10008262304590.29062-100000@gra-ux1.iram.es>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <Pine.HPX.4.10.10008262304590.29062-100000@gra-ux1.iram.es>; from paubert@iram.es on Sat, Aug 26, 2000 at 11:44:21PM +0200
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, Aug 26, 2000 at 11:44:21PM +0200, Gabriel Paubert wrote:
>
> On Sat, 26 Aug 2000, David Monro wrote:
>
> >
> > Hi,
> >
> > I need to make some changes to the way we do our PCI resource allocation
> > :-)
> >
> > Currently the code goes like this (in pci.c:pcibios_init()):
> >
> >         pci_scan_bus(0, &generic_pci_ops, NULL);
> >         if (ppc_md.pcibios_fixup)
> >                 ppc_md.pcibios_fixup();
> >         pcibios_claim_resources(&pci_root_buses);
> >
> > So we find all the devices, hack any we don't like, and then grab all
> > the resources. This means that we pretty much accept whatever the
> > firmware provides, which includes leaving any uninitialised resources
> > alone. This doesn't work properly on IBM 850 machines because the
> > firmware doesn't initialise any devices it doesn't recognise, and also
> > (for example) doesn't bother initialising the memory mapped resource of
> > the built-in ethernet (presumably because they expected people to use
> > the IO resource instead, which in fact we do).
>
> For PrePboot I took the decision to reassign all PCI resources before te
> kernel even ahd a chance to run. It works quite well for me, but I had no
> choice since I basically switch from a PreP to a CHRP mapping. Actually
> given the variety of hardware we are trying to supprt, I suspect that
> pushing a few things into the bootloaders (like reading the OF tree if
> available) can only be better.

I wrote a PCI autoconfiguration library that executes during
pcibios_init() in the MontaVista 2.2 kernel to accomplish this.  It's
debatable as to where this should go but it was convenient to use
the kernel config space access methods in the library so that's one
advantage.

> >
> > Note that I can't really do this just for the PReP code; if I put the
> > pci_assign_unassigned_resources() call in the prep_pcibios_fixup()
> > function it will completely remap the bus and claim all the resources,
> > and then pcibios_claim_resources() will walk the tree trying to claim
> > each resource again and get a conflict on every resource!
> >
> > Of course we could simply make pcibios_init() another arch-dependant
> > function - what do people think?
>
> I am fed up with all these arch dependant functions, to the point that
> I am convinced that ppc_md should disappear.

I'd like to hear your plan for supporting the wide variety of PPC-based
hardware that depend on having ppc_md.  Is it preprocessor conditionals?

I made pcibios_init() a machdep in my 2.2 tree so I could properly setup
the PCI bus on a board by board basis.  There is no one size fits all
way to do this.

> > On a related, is it true to say that every driver which uses ioremap()
> > to map memory on cards into virtual space needs to have isa_mem_base
> > added to the base address before it will work? As far as I can tell
> > virtually no drivers do this at the moment; I note a rather
> > dirty-looking hack in chrp_pci.c where we hack the resource entries for
> > the matrox card so that the driver doesn't need rewriting. Or should we
> > simply do this for all memory resources on all cards?
>
> Yes, you should do it. Actually I had something like this in my tree, but
> it's now disabled since I switch the hardware to a CHRP map.

I've used the dirty hack too on one board I left in a PReP map.  The
real solution is to have a pci_to_cpu() call which should be required
for all architectures/drivers.  It actually goes further since we really
need to be able to specify a pci bus domain (due to multiple physical
PCI bus segments with their own address spaces).

> The resource code is still insufficient, there should be a way to have the
> physical address, the bus address and in some cases the kernel virtual
> address of a given resource. For I/O space, which is permanently mapped,
> the resource should contain a kernel virtual address (the existence of
> isa_io_base in itself is an aberration, have you counted how many lwz
> instructions in the kernel access it ?). For memory resources, it should
> contain a processor physical address which is the input to ioremap.

pci_to_cpu() would do this without changing the resource code, though
though maybe loading up the resource code with this information would
be a good arch independent way to provide the information to PCI drivers.
An interesting thought...

--
Matt Porter
mmporter@home.com
This is Linux Country. On a quiet night, you can hear Windows reboot.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
