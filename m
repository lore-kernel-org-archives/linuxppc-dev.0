From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: <acurtis@onz.com>,
	Ppc Developers <linuxppc-dev@lists.linuxppc.org>
Subject: Re: PCI architecture enlightenment
Date: Tue, 6 Aug 2002 17:17:31 +0200
Message-Id: <20020806151731.30754@192.168.4.1>
In-Reply-To: <NCBBIINEHIPFGJPLBEIFKEGJDKAA.acurtis@onz.com>
References: <NCBBIINEHIPFGJPLBEIFKEGJDKAA.acurtis@onz.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


>Our board:
>Host phys: 0x40000000 - 0x47ffffff	=>
>PCI I/O space 0x00000000 - 0x07ffffff

You setup:

 hose->io_base_phys to 0x40000000
 hose->io_base_virt to ioremap(0x40000000, size)

Beware _NOT_ to ioremap too much space for IO space. 16Mb
shoud be plenty enough. The kernel is a bit "short" on ioremap
space, mapping too much would cause possible exhaustion of it
and collision between ioremap/vmalloc space and linear memory
mapping.

Then, you setup hose->io_resource.flags to IORESOURCE_IO
and hose->io_resource.start to the bus view start, that is 0.
and hose->io_resource->end to the end of that IO window

Then, also do isa_io_base = hose->io_base_virt for legacy
drivers doing inx/outx to go tap that IO bus.

>Host phys: 0x48000000 - 0x4fffffff =>
>PCI Memory space 0x00000000 - 0x07ffffff

Here, you setup your host->PCI memory mapping. Fill up
hose->mem_resources[0].start/end to be the start/end of the
CPU side memory space view, that is 0x48000000 & 0x4fffffff,
then set hose->pci_mem_offset to be the the offset between
that CPU side view and the PCI side view, that is 0x48000000
and hose->mem_resources[0].flags to IORESOURCE_MEM
Since that region also give access to ISA memory, set
isa_mem_base to 0x48000000 as well.


>PCI phys: 0x40000000 -  0x47ffffff =>
>Host Memory 0x00000000 - 0x07ffffff

Your host memory is visible at PCI 0x40000000, so put that
value in pci_dram_offset.

So the actual setup should look like

 hose->io_base_phys           = 0x40000000;
 hose->io_base_virt           = ioremap(0x40000000, 0x01000000);
 hose->io_resource.start      = 0;
 hose->io_resource.end        = 0x01000000;
 hose->io_resource.flags      = IORESOURCE_IO;
 isa_io_base                  = hose->io_base_virt;

 hose->mem_resources[0].start = 0x48000000;
 hose->mem_resources[0].end   = 0x4fffffff;
 hose->mem_resources[0].flags = IORESOURCE_MEM;
 hose->pci_mem_offset         = 0x48000000;
 isa_mem_base                 = 0x48000000;
 pci_dram_offset              = 0x40000000;


>Host Memory:
>phys: 0x00000000
>virt: 0xc0000000
>size: 0x08000000
>
>PCI BAR: (only 1 bus)
>Memory: 0x00000000
>I/O:    0x00000000

Beware that if your host bridge appears as a PCI device on the BUS and
his BAR may for some reasons be incorrectly considered as a device BAR
while it's actually used to configure the bridge ranges (typically what
happens with a 405gp or a CPC710), then you need to "hide" this BAR, using
a PCI quirk (see the fixups in arch/ppc/kernel/pci.c)

Ben.


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
