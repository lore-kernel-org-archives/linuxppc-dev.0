Message-ID: <3B004003.AD18DF5B@mvista.com>
Date: Mon, 14 May 2001 16:28:51 -0400
From: Dan Malek <dan@mvista.com>
MIME-Version: 1.0
To: Ira Weiny <iweiny@acm.org>
Cc: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: Re: Walnut 405GP and SBLive sound card
References: <3AFF16E6.C715ECAE@acm.org>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Ira Weiny wrote:

> There is a cache conherentcy issue on the 405GP when doing DMA.
> Basically there is a hardware bug which does not flush the cache on
> writes.

I'm not sure it's a bug, it's the way the part is designed.  It does
not have a hardware coherent cache, you have to manage it in
software.

> I am _very_ confused by the virt_to_bus, virt_to_phys, ioremap,
> memremap, and just about every other memory related functions I walk
> through.

Me, too.  So, I rewrote them :-).  Actually, I made some minor changes
for the 4xx and 8xx processors so the functions actually look up
real page table entries every time, instead of just assuming they
can perform some simple address arithmetic.  This was necessary for
the 4xx and 8xx, because of the mapping of internal devices, and doesn't
hurt on other processors.  These functions will also work correctly
with dynamically allocated kernel memory, although they aren't expected
to do so (but, I don't know why).

> The driver calls the pci_(alloc/free)_consistent functions for the DMA
> transfer buffers.

I'm currently fixing these functions to "do the right thing" on the
PowerPCs that are not cache coherent (4xx and 8xx).  There are still
lots of PCI drivers that don't call these functions and assume a
hardware cache coherent system, so those will need to be modified if
you choose to use one.

> I need to call dma_cache_wback_inv (with the correct address and size;
> at the correct time)

Since this is a PCI device, you should probably can the PCI
version of these operations, such as pci_dma_sync_single() or
pci_dma_sync_sg(), for example.

> The kernel I have (mvista 2001-04-12) works with a Promise IDE controler
> so the PCI bridge must be setup and working ok.

Not a good assumption (because I have recently broken it :-).  Several
people have contributed to a proper PCI enumeration function for PowerPC,
and that will soon find its way into this port.  Many of the PCI
features or controllers that appear to work on the 4xx and 8xx are
unique hacks for that purpose and don't imply anything else is going
to work.  Many people are working as quickly as we can to bring the
4xx up to the same functional level as other PowerPCs, and PCI is
receiving the most attention right now.


	-- Dan

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
