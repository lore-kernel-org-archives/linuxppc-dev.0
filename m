Date: Wed, 8 Oct 2003 22:35:18 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: Jacky Lam <jackylam@astri.org>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: General porting question
Message-ID: <20031008223518.A10052@home.com>
References: <006e01c38e1b$5f72b500$2803050a@JackyLam>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <006e01c38e1b$5f72b500$2803050a@JackyLam>; from jackylam@astri.org on Thu, Oct 09, 2003 at 12:11:09PM +0800
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Thu, Oct 09, 2003 at 12:11:09PM +0800, Jacky Lam wrote:
>
> Dear all,
>
>     Could anyone give me some notes/idea what should be take care to port an
> x86 PCI card driver to powerpc walnut platform? I try several
> cards(ethernet, audio) which run well on my PC by cross-compiling the
> drivers. They can be recognized successfully, but none of them works. Walnut
> seems don't be able to receive any interrupt from the cards.
>
>     I guess there must be something about PCI implementation in PPC
> different from x86. Is there any expert on PPC PCI can tell me what happen?
> Or any related documentation can help?

Documentation/DMA-mapping.txt and IO-mapping.txt are of general
interest when dealing with DMA capable devices and address translation.
Unfortunately, the docs/APIs aren't yet complete with respect to some
platforms. On non cache coherent processors like PPC4xx/8xx, consistent
memory is allocated from vmalloc space.  The virt_to_*/*_to_virt family
of APIs is only valid for staticly mapped kernel system memory addresses
(KERNELBASE -> KERNELBASE+<size of sysmem>).

A quick inspection shows that es1371 does some things that won't work on
a 405.  It takes a pci_alloc_consistent buffer and does a virt_to_page.
That will be bogus since the buffer's virtual address is in vmalloc
space on 4xx.  In addition, it performs a virt_to_phys and then uses
remap_page_range on that...that will be bogus as well.  A bus_to_virt
on the pci_alloc_consistent buffer's dma_addr will work and then
virt_to_page() can be used on that virtual address.  In the same
fashion one could do a virt_to_phys(bus_to_virt(dma_addr) to get
the correct physical address to be passed to remap_page_range.

Someday we will get the DMA API to be completely cross architecture
so driver. It's much better than the situation in older kernels. :)

On the other hand, emu10k1 works out of the box...SB Live.

-Matt

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
