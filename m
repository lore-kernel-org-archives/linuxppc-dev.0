From: Paul Mackerras <paulus@samba.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <15308.8725.416230.867981@cargo.ozlabs.ibm.com>
Date: Tue, 16 Oct 2001 22:03:33 +1000 (EST)
To: linuxppc-dev@lists.linuxppc.org
Subject: pci_dma_sync_single
Reply-To: paulus@samba.org
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


I'm pretty sure this comment in pci_dma_sync_single in pci.h is wrong:

	/* The bus_to_virt() can't be used here, in case dma_handle
	 * points to something that doesn't have the same cache attributes
	 * as the 1:1 mapped kernel memory.  If we used it, we could
	 * get a cache line alias with the wrong attributes.
	 * Since there isn't any Linux way to get the real VA from a PA,
	 * it is just easier to flush the whole cache.  The code to
	 * determine VA from PA would probably do the same :-).
	 * I don't know why these functions don't pass VA, since the
	 * cache operations use VA and the caller has this information.
	 *	-- Dan
	 */

There are basically two ways to get a dma_handle: through
pci_alloc_consistent, which might map some memory with caching disable
(I'm talking about the non-cache-coherent processors here), or through
mapping some memory with pci_map_single, pci_map_sg, or pci_map_page.

Now in the first instance, which is what the comment seems to be
referring to, we get the consistency by having the uncached mapping,
and you don't need to, and in fact shouldn't, call pci_dma_sync_single.

In the second instance the CPU's mapping of the page would be a
cacheable mapping since the caller would have got the memory via
kmalloc or get_free_page, and so the possibility of cache paradoxes
doesn't arise there either.

So in the absence of highmem it seems to me that pci_dma_sync_single
could just do bus_to_virt quite safely.  With highmem, the (new)
pci_map_page routine lets us do dma to highmem pages directly, and so
bus_to_virt won't work there, but it would be relatively easy to kmap
the page and flush that virtual address.

However, I have just realized that the best way of all is probably to
have a cache-flush routine which just turns off DR and flushes using
physical addresses, which will be identical to the dma addresses
(except for an offset on some platforms).

Thoughts?  Have I got the wrong end of the stick?

Paul.

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
