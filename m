Message-ID: <40EA6739.2040408@fh-landshut.de>
Date: Tue, 06 Jul 2004 10:47:53 +0200
From: Oliver Korpilla <okorpil@fh-landshut.de>
MIME-Version: 1.0
To: Adrian Cox <adrian@humboldt.co.uk>
Cc: linuxppc-embedded@lists.linuxppc.org
Subject: Re: MPC7455 DMA buffer strangeness
References: <Pine.LNX.4.58.0407051018590.388@corpster2> <1089102844.937.57.camel@localhost>
In-Reply-To: <1089102844.937.57.camel@localhost>
Content-Type: text/plain; charset=us-ascii; format=flowed
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


Hello, Adrian!

I thought of the same today, but didn't submit it because I'm not sure about
some parts of that logic.

Adrian Cox wrote:
>
> The memory allocated by pci_alloc_consistent will be cacheable
> memory, as PowerPC 60x is a cache coherent architecture. You've set
> up a non-cacheable userspace mapping to the same address by using
> pgprot_noncached(). Two mappings of the same physical memory must have
> the same cache settings.
>
>>On the MPC7455, though, write accesses seem to be applied or not
>>applied in a somewhat random fashion. Sometimes an offsetted write
>>into the buffer is there, and sometimes not. Writing at the begin of
>>the buffer seems to disapper always.
>
> This probably only shows on the 7455 because the caches of the 7455
> are much larger.

Of course the 3-layer caching of the 7455 is much more likely to interfere than
that of the 603e, and may be a reason for the flakiness in reproducing the
errors I observed. I though of that, but the following reasoning led me to
dismiss it at first:

How can a cacheable kernel mapping influence my DMA transfer?

The buffer is not written to in kernel space, but in user space. An ioctl() is
made for triggering the DMA. The user space mapping will lead to direct writes
to that physical buffer address, so the DMA engine of my PCI-VME-bridge chip
should see only what I wrote in user space, regardless of the kernel mapping.
(But it doesn't in reality!)

Or doesn't it work like that? (Maybe a flush of the kernel cache of my pages
does corrupt my writes to the same physical addresses?)

Sadly enough I found no module-compatible way yet to map my pages with the
correct G- and I-bits yet in the kernel itself. Allocation functions don't ask
for the pgprot_t, change_protection() is not exported.

Trying to rewrite pci_alloc_consistent like this produced no change in
protection bits of the PTEs (just for testing):

void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
			   dma_addr_t *dma_handle)
{
	void *ret;
	int gfp = GFP_ATOMIC;
	/* Obtain flags for guarded/non-cached */
	pgprot_t prot;
	pgprot_val(prot) = 0;
	prot = pgprot_noncached(prot);

	if (hwdev == NULL || hwdev->dma_mask != 0xffffffff)
		gfp |= GFP_DMA;

#ifdef CONFIG_NOT_COHERENT_CACHE
	ret = consistent_alloc(gfp, size, dma_handle);
#else
	ret = (void *)__get_free_pages(gfp, get_order(size));

	if (ret != NULL) {
		memset(ret, 0, size);
		*dma_handle = virt_to_bus(ret);
	}
#endif /* CONFIG_NOT_COHERENT_CACHE */

	if (ret != NULL)
	  {
	    change_protection ((unsigned long int) ret,
		(unsigned long int) (ret+size), prot);
	  }

	return ret;
}

Do you have any idea about this?

Thanks,
Oliver Korpilla

** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
