Date: Mon, 27 Mar 2000 18:55:37 +0200 (CEST)
From: Michael Schmitz <schmitz@opal.biophys.uni-duesseldorf.de>
To: Geert Uytterhoeven <geert@linux-m68k.org>
cc: Gabriel Paubert <paubert@iram.es>, Benjamin Herrenschmidt <bh40@calva.net>,
        linuxppc-dev@lists.linuxppc.org
Subject: Re: LongTrail PCI resource assignment
In-Reply-To: <Pine.GSO.4.10.10003271353080.11532-100000@dandelion.sonytel.be>
Message-ID: <Pine.LNX.4.10.10003271850230.1727-100000@opal.biophys.uni-duesseldorf.de>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


> > Well, all I know is that it works.
>
> Ever tried writing to it? :-) For your own safety, please don't! But you can
> try reading the CHIP_ID register.

I should still have code around to do that, in the atyfb driver. Anyway,
this is what I found in arch/ppc/kernel/pci.c:

int pci_assign_resource(struct pci_dev *dev, int i)
{
	struct resource *r = &dev->resource[i];
	struct resource *pr = pci_find_parent_resource(dev, r);
	unsigned long size = r->end + 1;
	u32 new, check;

	if (!pr) {
	 	printk(KERN_ERR "PCI: Cannot find parent resource for device %s\n", dev->slot_name);
	 	return -EINVAL;
	}
	if (r->flags & IORESOURCE_IO) {
	        if (allocate_resource(pr, r, size, 0x100, ~0, size, NULL, NULL)) {
	         	printk(KERN_ERR "PCI: Allocation of I/O region %s/%d (%ld bytes) failed\n", de
	         	return -EBUSY;
	        }
	} else {
	 	if (allocate_resource(pr, r, size, 0x10000, ~0, size, NULL, NULL)) {
	 	 	printk(KERN_ERR "PCI: Allocation of memory region %s/%d (%ld bytes) failed\n",
	 	 	return -EBUSY;
	 	}
	}

See the 0x10000 above? Exactly what I get.

pci_assign_resource() is duplicated (sort of) in drivers/pci/setup-res.c
where the correct PCIBIOS_MIN_* limits are applied. That function calls
pcibios_update_resource() to do the actual bit twiddling. Is 2.3.48 too
dated for your patch to apply?

> > And this is my PCIBIOS_MIN_MEM:
> >
> > include/asm/pci.h:#define PCIBIOS_MIN_MEM		0x10000000
> >
> > Seems it got ignored and the resource allocator picked the next free spot.
>
> Weird, mine got assigned to 0xc0000000, which is what I expect.

Seems pci_assign_resource is no longer in the arch/ppc/kernel section in
your source. Or your linker picks up the other one.

	Michael


** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
