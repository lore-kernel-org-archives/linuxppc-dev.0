Date: Sat, 26 Aug 2000 23:44:21 +0200 (METDST)
From: Gabriel Paubert <paubert@iram.es>
To: David Monro <davidm@amberdata.demon.co.uk>
cc: Linux/ppc Dev List <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCI resource initialisation
In-Reply-To: <39A826A6.D551486F@amberdata.demon.co.uk>
Message-ID: <Pine.HPX.4.10.10008262304590.29062-100000@gra-ux1.iram.es>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


On Sat, 26 Aug 2000, David Monro wrote:

>
> Hi,
>
> I need to make some changes to the way we do our PCI resource allocation
> :-)
>
> Currently the code goes like this (in pci.c:pcibios_init()):
>
>         pci_scan_bus(0, &generic_pci_ops, NULL);
>         if (ppc_md.pcibios_fixup)
>                 ppc_md.pcibios_fixup();
>         pcibios_claim_resources(&pci_root_buses);
>
> So we find all the devices, hack any we don't like, and then grab all
> the resources. This means that we pretty much accept whatever the
> firmware provides, which includes leaving any uninitialised resources
> alone. This doesn't work properly on IBM 850 machines because the
> firmware doesn't initialise any devices it doesn't recognise, and also
> (for example) doesn't bother initialising the memory mapped resource of
> the built-in ethernet (presumably because they expected people to use
> the IO resource instead, which in fact we do).

For PrePboot I took the decision to reassign all PCI resources before te
kernel even ahd a chance to run. It works quite well for me, but I had no
choice since I basically switch from a PreP to a CHRP mapping. Actually
given the variety of hardware we are trying to supprt, I suspect that
pushing a few things into the bootloaders (like reading the OF tree if
available) can only be better.

>
> The 2.4 kernel does provide a function,
> pci_assign_unassigned_resources(), which will find pci resources which
> haven't been claimed yet and do the appropriate thing with them.

Not always, unfortunately.

> As I see it we have a few choices:
>
> do:
> 	pci_scan_bus(0, &generic_pci_ops, NULL);
>         if (ppc_md.pcibios_fixup)
>                 ppc_md.pcibios_fixup();
>         pcibios_claim_resources(&pci_root_buses);
> 	pci_assign_unassigned_resources();
>
> which should allocate any left alone by the original code, and does
> work, but still means we have to hack the original resources (eg on IBM
> 850s the SCSI hos adapters seem to always get allocated IO port
> resources above 0x20000000, which we relocate in a not very safe manner

You mean completely unsafe, it has caused hangs in some cases.

> down to 0x01000000). It also assumes we don't need to do any more fixups
> for the newly discovered resources.

>
> or we could do:
> 	pci_scan_bus(0, &generic_pci_ops, NULL);
> 	pci_assign_unassigned_resources();
>         if (ppc_md.pcibios_fixup)
>                 ppc_md.pcibios_fixup();
>
> which results in the kernel completely reassigning all the PCI
> resources. This should mean that the resources all get allocated in
> areas that we would like to find them in, and means that the
> pcibios_fixup code should be a little simpler. This is my preferred
> solution, but I guess might break something.
>
> Note that I can't really do this just for the PReP code; if I put the
> pci_assign_unassigned_resources() call in the prep_pcibios_fixup()
> function it will completely remap the bus and claim all the resources,
> and then pcibios_claim_resources() will walk the tree trying to claim
> each resource again and get a conflict on every resource!
>
> Of course we could simply make pcibios_init() another arch-dependant
> function - what do people think?

I am fed up with all these arch dependant functions, to the point that
I am convinced that ppc_md should disappear.

> On a related, is it true to say that every driver which uses ioremap()
> to map memory on cards into virtual space needs to have isa_mem_base
> added to the base address before it will work? As far as I can tell
> virtually no drivers do this at the moment; I note a rather
> dirty-looking hack in chrp_pci.c where we hack the resource entries for
> the matrox card so that the driver doesn't need rewriting. Or should we
> simply do this for all memory resources on all cards?

Yes, you should do it. Actually I had something like this in my tree, but
it's now disabled since I switch the hardware to a CHRP map.

The resource code is still insufficient, there should be a way to have the
physical address, the bus address and in some cases the kernel virtual
address of a given resource. For I/O space, which is permanently mapped,
the resource should contain a kernel virtual address (the existence of
isa_io_base in itself is an aberration, have you counted how many lwz
instructions in the kernel access it ?). For memory resources, it should
contain a processor physical address which is the input to ioremap.

	Regards,
	Gabriel.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
