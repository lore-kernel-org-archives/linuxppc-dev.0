Date: Thu, 9 Oct 2003 06:38:12 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Jacky Lam <jackylam@astri.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: General porting question
Message-ID: <20031009063812.A11979@home.com>
References: <006e01c38e1b$5f72b500$2803050a@JackyLam> <20031008223518.A10052@home.com> <008c01c38e2d$27feac20$2803050a@JackyLam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <008c01c38e2d$27feac20$2803050a@JackyLam>; from jackylam@astri.org on Thu, Oct 09, 2003 at 02:18:28PM +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Oct 09, 2003 at 02:18:28PM +0800, Jacky Lam wrote:
>
> > A quick inspection shows that es1371 does some things that won't work on
> > a 405.  It takes a pci_alloc_consistent buffer and does a virt_to_page.
> > That will be bogus since the buffer's virtual address is in vmalloc
> > space on 4xx.  In addition, it performs a virt_to_phys and then uses
> > remap_page_range on that...that will be bogus as well.  A bus_to_virt
> > on the pci_alloc_consistent buffer's dma_addr will work and then
> > virt_to_page() can be used on that virtual address.  In the same
> > fashion one could do a virt_to_phys(bus_to_virt(dma_addr) to get
> > the correct physical address to be passed to remap_page_range.
> >
>
>     That means in short:
>
>     pci_alloc_consistent() ->virt_to_page() should be replaced by
> pci_alloc_consistent()->bus_to_virt()->virt_to_page().
>
>     Similarly, for any PCI related memory space. Before using
> virt_to_*/*_to_virt(), I should use bus_to_*/*_to_bus() on the argument
> first.

Almost.

You can not use virt_to_* on the address returned by
pci_alloc_consistent().

You need to hold on to the dma_addr_t returned, perform
a bus_to_virt(dma_addr_t) and then a virt_to_* will work
on that address.

However, I'm not sure of the "PCI related memory space" you
are referring to.  "PCI memory space" has a distinct meaning
and the virt_to_*/*_to_bus APIs don't work there.  Those APIs
are only valid for system memory that is accessible through
inbound transactions by a PCI bus master.

You can use virt_to_* on an address returned from kmalloc
or __get_free_pages.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
