Message-ID: <008c01c38e2d$27feac20$2803050a@JackyLam>
From: "Jacky Lam" <jackylam@astri.org>
To: <linuxppc-embedded@lists.linuxppc.org>
References: <006e01c38e1b$5f72b500$2803050a@JackyLam> <20031008223518.A10052@home.com>
Subject: Re: General porting question
Date: Thu, 9 Oct 2003 14:18:28 +0800
MIME-Version: 1.0
Content-Type: text/plain;
	charset="iso-8859-1"
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


> A quick inspection shows that es1371 does some things that won't work on
> a 405.  It takes a pci_alloc_consistent buffer and does a virt_to_page.
> That will be bogus since the buffer's virtual address is in vmalloc
> space on 4xx.  In addition, it performs a virt_to_phys and then uses
> remap_page_range on that...that will be bogus as well.  A bus_to_virt
> on the pci_alloc_consistent buffer's dma_addr will work and then
> virt_to_page() can be used on that virtual address.  In the same
> fashion one could do a virt_to_phys(bus_to_virt(dma_addr) to get
> the correct physical address to be passed to remap_page_range.
>

    That means in short:

    pci_alloc_consistent() ->virt_to_page() should be replaced by
pci_alloc_consistent()->bus_to_virt()->virt_to_page().

    Similarly, for any PCI related memory space. Before using
virt_to_*/*_to_virt(), I should use bus_to_*/*_to_bus() on the argument
first.

    Is it right?

    Thanks for your help.

Best regards,
Jacky


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
