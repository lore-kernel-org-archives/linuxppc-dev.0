Message-ID: <3BFBF277.A05245D6@mvista.com>
Date: Wed, 21 Nov 2001 10:29:11 -0800
From: Armin Kuster <akuster@mvista.com>
MIME-Version: 1.0
To: Roman Zippel <zippel@linux-m68k.org>
Cc: ppcdevel <linuxppc-dev@lists.linuxppc.org>
Subject: Re: New API for non cache coherent ppc cpu's
References: <Pine.LNX.4.33.0111211152230.6681-100000@serv>
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


Roman Zippel wrote:
>
> Hi,
>
> On Tue, 20 Nov 2001, Armin Kuster wrote:
>
> > About a month ago a new API made its way into the ppc,
> > consistent_sync_page.
>
> Another one?
> We have now 3 APIs for this:
> - cache_(push|clear): that's the old m68k API (and also used by APUS)
> - dma_cache_(inv|wback|wback_inv): used by mips(64), parisc, sh
> - consistent_sync_page: ppc
>
> >  For CONFIG_NOT_COHERENT_CACHE  processors,
> > requires
> > proper flushing of the page being used.  Please review and provide feed
> > back
>
> Two comments:
> - I'm not sure about the page argument, although I'd like to see it, the
> problem is the drivers usually don't have a page pointer.

example as it is used today.

mapping = pci_map_page(pdev,
			       virt_to_page(cmd->request_buffer),
			       ((unsigned long)cmd->request_buffer &
				~PAGE_MASK),
			       cmd->request_bufflen, dma_dir);

/*
 * pci_{map,unmap}_single_page maps a kernel page to a dma_addr_t.
identical
 * to pci_map_single, but takes a struct page instead of a virtual
address
 */
static inline dma_addr_t pci_map_page(struct pci_dev *hwdev, struct page
*page,
				      unsigned long offset, size_t size,
				      int direction)
{
	if (direction == PCI_DMA_NONE)
		BUG();
	consistent_sync_page(page, offset, size, direction);
	return (page - mem_map) * PAGE_SIZE + PCI_DRAM_OFFSET + offset;
}

> - I think it was never defined, what should be done if offset/size isn't
> cache line aligned. That's especially a problem in the invalidate only
> case. I'd prefer to make this illegal, as it's mostly not a problem for
> drivers.
>

wouldn't it also be a problem for consistent_sync?  we don't check for
offset/size are cache line aligned.

> bye, Roman



-- armin

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
