Subject: Re: MPC7455 DMA buffer strangeness
From: Adrian Cox <adrian@humboldt.co.uk>
To: okorpil@fh-landshut.de
Cc: linuxppc-embedded@lists.linuxppc.org
In-Reply-To: <Pine.LNX.4.58.0407051018590.388@corpster2>
References: <Pine.LNX.4.58.0407051018590.388@corpster2>
Content-Type: text/plain
Message-Id: <1089102844.937.57.camel@localhost>
Mime-Version: 1.0
Date: Tue, 06 Jul 2004 09:34:04 +0100
Sender: owner-linuxppc-embedded@lists.linuxppc.org
List-Id: <linuxppc-embedded@lists.linuxppc.org>


On Mon, 2004-07-05 at 09:31, Oliver Korpilla wrote:
> I'm mapping a DMA buffer allocated with pci_alloc_consistent() into user
> space with a mmap hook like this:
>
> int vme_mmap(struct file *file_ptr, struct vm_area_struct *vma)
> {
>         DPRINTF("Attempting to map %#lx bytes of memory at "
>                 "physical address %#lx\n", vma->vm_end - vma->vm_start,
>                 vma->vm_pgoff << PAGE_SHIFT);
>
>         vma->vm_page_prot = pgprot_noncached(vma->vm_page_prot);

The memory allocated by pci_alloc_consistent will be cacheable memory,
as PowerPC 60x is a cache coherent architecture. You've set up a
non-cacheable userspace mapping to the same address by using
pgprot_noncached(). Two mappings of the same physical memory must have
the same cache settings.

> On the MPC7455, though, write accesses seem to be applied or not applied
> in a somewhat random fashion. Sometimes an offsetted write into the buffer
> is there, and sometimes not. Writing at the begin of the buffer seems to
> disapper always.

This probably only shows on the 7455 because the caches of the 7455 are
much larger.

- Adrian Cox
Humboldt Solutions Ltd.


** Sent via the linuxppc-embedded mail list. See http://lists.linuxppc.org/
