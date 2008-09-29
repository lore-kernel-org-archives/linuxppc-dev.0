Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id B47F7DDF18
	for <linuxppc-dev@ozlabs.org>; Tue, 30 Sep 2008 03:26:12 +1000 (EST)
Received: from mailgate02.slac.stanford.edu (mailgate02.slac.stanford.edu
	[134.79.18.92])
	by nospam3.slac.stanford.edu (8.13.8/8.13.8) with ESMTP id
	m8THQ6cr029017
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 10:26:06 -0700 (PDT)
	(envelope-from rmachet@slac.stanford.edu)
Received: from [134.79.128.151] (pcds-ts102.slac.stanford.edu [134.79.128.151])
	by mailgate02.slac.stanford.edu (8.13.8/8.13.8) with ESMTP id
	m8THQ6I2028913
	for <linuxppc-dev@ozlabs.org>; Mon, 29 Sep 2008 10:26:06 -0700 (PDT)
	(envelope-from rmachet@slac.stanford.edu)
Subject: New dma-noncoherent code, looking for comment and people to test
From: Remi Machet <rmachet@slac.stanford.edu>
To: Linux PPC <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Mon, 29 Sep 2008 10:26:05 -0700
Message-Id: <1222709165.8628.4.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi,

I rewrote dma-noncoherent.c and I am looking for people to review and test it 
on various platforms that use it to make sure I did not introduce any bug.
The platforms affected by this change are those that define
CONFIG_NOT_COHERENT_CACHE:
ppc44x
walnut
makalu
kilauea
ep405
adder875
ep88xc
taishan
warp
sam440ep
sequoia
bamboo
canyonlands
rainier
katmai
ebony
mpc885_ads
mpc866_ads
ppc40x
c2k (already tested)
prpmc2800

The old code in dma-noncoherent.c uses a memory pool at a hard coded
virtual address set by CONFIG_CONSISTENT_START (typically 0xFF100000). If not
set carefully this address can conflict with early ioremap in systems
that enable HIGHMEM, on top of that the code is overly complex because it
needs to have its own memory manager.
This is why I tried to re-implement the code using standard memory
management APIs. The new code does not require the user to set
CONFIG_CONSISTENT_START or CONFIG_CONSISTENT_SIZE, is much smaller and
simplier. It also can allocate as much memory as available in ZONE_DMA
(instead of being limited by CONFIG_CONSISTENT_SIZE).

I also removed the HIGHMEM support in dma_sync since memory allocated for
DMA transfer should always be in ZONE_DMA (ie not in ZONE_HIGHMEM).

Looking forward to any comment about why this code may not work or is not
as good as the original. If you do test this code on your platform, let me
know how it goes ... if no-one object and no bug is found I will submit
this patch in a month or so.

Thanks !

Remi

diff --git a/arch/powerpc/lib/dma-noncoherent.c b/arch/powerpc/lib/dma-noncoherent.c
index 5d83907..6827ae9 100644
--- a/arch/powerpc/lib/dma-noncoherent.c
+++ b/arch/powerpc/lib/dma-noncoherent.c
@@ -29,143 +29,28 @@
 #include <linux/types.h>
 #include <linux/highmem.h>
 #include <linux/dma-mapping.h>
+#include <linux/vmalloc.h>
 
 #include <asm/tlbflush.h>
 
 /*
- * This address range defaults to a value that is safe for all
- * platforms which currently set CONFIG_NOT_COHERENT_CACHE. It
- * can be further configured for specific applications under
- * the "Advanced Setup" menu. -Matt
- */
-#define CONSISTENT_BASE	(CONFIG_CONSISTENT_START)
-#define CONSISTENT_END	(CONFIG_CONSISTENT_START + CONFIG_CONSISTENT_SIZE)
-#define CONSISTENT_OFFSET(x)	(((unsigned long)(x) - CONSISTENT_BASE) >> PAGE_SHIFT)
-
-/*
- * This is the page table (2MB) covering uncached, DMA consistent allocations
- */
-static pte_t *consistent_pte;
-static DEFINE_SPINLOCK(consistent_lock);
-
-/*
- * VM region handling support.
- *
- * This should become something generic, handling VM region allocations for
- * vmalloc and similar (ioremap, module space, etc).
- *
- * I envisage vmalloc()'s supporting vm_struct becoming:
- *
- *  struct vm_struct {
- *    struct vm_region	region;
- *    unsigned long	flags;
- *    struct page	**pages;
- *    unsigned int	nr_pages;
- *    unsigned long	phys_addr;
- *  };
- *
- * get_vm_area() would then call vm_region_alloc with an appropriate
- * struct vm_region head (eg):
- *
- *  struct vm_region vmalloc_head = {
- *	.vm_list	= LIST_HEAD_INIT(vmalloc_head.vm_list),
- *	.vm_start	= VMALLOC_START,
- *	.vm_end		= VMALLOC_END,
- *  };
- *
- * However, vmalloc_head.vm_start is variable (typically, it is dependent on
- * the amount of RAM found at boot time.)  I would imagine that get_vm_area()
- * would have to initialise this each time prior to calling vm_region_alloc().
- */
-struct vm_region {
-	struct list_head	vm_list;
-	unsigned long		vm_start;
-	unsigned long		vm_end;
-};
-
-static struct vm_region consistent_head = {
-	.vm_list	= LIST_HEAD_INIT(consistent_head.vm_list),
-	.vm_start	= CONSISTENT_BASE,
-	.vm_end		= CONSISTENT_END,
-};
-
-static struct vm_region *
-vm_region_alloc(struct vm_region *head, size_t size, gfp_t gfp)
-{
-	unsigned long addr = head->vm_start, end = head->vm_end - size;
-	unsigned long flags;
-	struct vm_region *c, *new;
-
-	new = kmalloc(sizeof(struct vm_region), gfp);
-	if (!new)
-		goto out;
-
-	spin_lock_irqsave(&consistent_lock, flags);
-
-	list_for_each_entry(c, &head->vm_list, vm_list) {
-		if ((addr + size) < addr)
-			goto nospc;
-		if ((addr + size) <= c->vm_start)
-			goto found;
-		addr = c->vm_end;
-		if (addr > end)
-			goto nospc;
-	}
-
- found:
-	/*
-	 * Insert this entry _before_ the one we found.
-	 */
-	list_add_tail(&new->vm_list, &c->vm_list);
-	new->vm_start = addr;
-	new->vm_end = addr + size;
-
-	spin_unlock_irqrestore(&consistent_lock, flags);
-	return new;
-
- nospc:
-	spin_unlock_irqrestore(&consistent_lock, flags);
-	kfree(new);
- out:
-	return NULL;
-}
-
-static struct vm_region *vm_region_find(struct vm_region *head, unsigned long addr)
-{
-	struct vm_region *c;
-
-	list_for_each_entry(c, &head->vm_list, vm_list) {
-		if (c->vm_start == addr)
-			goto out;
-	}
-	c = NULL;
- out:
-	return c;
-}
-
-/*
  * Allocate DMA-coherent memory space and return both the kernel remapped
  * virtual and bus address for that space.
  */
 void *
 __dma_alloc_coherent(size_t size, dma_addr_t *handle, gfp_t gfp)
 {
-	struct page *page;
-	struct vm_region *c;
+	struct page *page, *p;
 	unsigned long order;
+	unsigned long kaddr;
+	unsigned long addr;
 	u64 mask = 0x00ffffff, limit; /* ISA default */
 
-	if (!consistent_pte) {
-		printk(KERN_ERR "%s: not initialised\n", __func__);
-		dump_stack();
-		return NULL;
-	}
-
 	size = PAGE_ALIGN(size);
 	limit = (mask + 1) & ~mask;
-	if ((limit && size >= limit) || size >= (CONSISTENT_END - CONSISTENT_BASE)) {
-		printk(KERN_WARNING "coherent allocation too big (requested %#x mask %#Lx)\n",
-		       size, mask);
+	if (limit && size >= limit) {
+		printk(KERN_WARNING "coherent allocation too big " \
+			"(requested %#x mask %#Lx)\n", size, mask);
 		return NULL;
 	}
 
@@ -176,61 +61,47 @@ __dma_alloc_coherent(size_t size, dma_addr_t *handle, gfp_t gfp)
 
 	page = alloc_pages(gfp, order);
 	if (!page)
-		goto no_page;
+		return NULL;
 
 	/*
 	 * Invalidate any data that might be lurking in the
 	 * kernel direct-mapped region for device DMA.
 	 */
-	{
-		unsigned long kaddr = (unsigned long)page_address(page);
-		memset(page_address(page), 0, size);
-		flush_dcache_range(kaddr, kaddr + size);
-	}
+	kaddr = (unsigned long)page_address(page);
+	BUG_ON(kaddr == 0);
+	/* the name is confusing here: flush_dcache_range does a
+		flush + invalidate */
+	flush_dcache_range(kaddr, kaddr + size);
 
 	/*
-	 * Allocate a virtual address in the consistent mapping region.
+	 * Out of the returned page generate a table of 1<<order
+	 * PAGE_SIZE pages. This make sure each page has its own PTE.
 	 */
-	c = vm_region_alloc(&consistent_head, size,
-			    gfp & ~(__GFP_DMA | __GFP_HIGHMEM));
-	if (c) {
-		unsigned long vaddr = c->vm_start;
-		pte_t *pte = consistent_pte + CONSISTENT_OFFSET(vaddr);
-		struct page *end = page + (1 << order);
-
-		split_page(page, order);
-
-		/*
-		 * Set the "dma handle"
-		 */
-		*handle = page_to_bus(page);
-
-		do {
-			BUG_ON(!pte_none(*pte));
-
-			SetPageReserved(page);
-			set_pte_at(&init_mm, vaddr,
-				   pte, mk_pte(page, pgprot_noncached(PAGE_KERNEL)));
-			page++;
-			pte++;
-			vaddr += PAGE_SIZE;
-		} while (size -= PAGE_SIZE);
-
-		/*
-		 * Free the otherwise unused pages.
-		 */
-		while (page < end) {
-			__free_page(page);
-			page++;
-		}
+	split_page(page, order);
 
-		return (void *)c->vm_start;
+	/*
+	 * Mark the pages as Reserved: this memory is used by a DMA engine,
+	 * it cannot be swapped.
+	 * Also mark each page as un-cached. We ass ume here that a PTE
+	 * already exist (valid assumption for the DMA Zone)
+	 */
+	for (addr = kaddr, p = page; addr < kaddr+size;
+			addr += PAGE_SIZE, p++) {
+		pte_t *pte;
+		spinlock_t *ptl;
+
+		SetPageReserved(p);
+		pte = get_locked_pte(&init_mm, addr, &ptl);
+		set_pte_at(&init_mm, addr,
+			pte, mk_pte(p, pgprot_noncached(PAGE_KERNEL)));
+		pte_unmap_unlock(pte, ptl);
 	}
+	flush_tlb_kernel_range(kaddr, kaddr+size-1);
 
-	if (page)
-		__free_pages(page, order);
- no_page:
-	return NULL;
+	/* Handle is the physical address of the first page */
+	*handle = page_to_bus(page);
+
+	return (void *)kaddr;
 }
 EXPORT_SYMBOL(__dma_alloc_coherent);
 
@@ -238,125 +109,62 @@ EXPORT_SYMBOL(__dma_alloc_coherent);
  * free a page as defined by the above mapping.
  */
 void __dma_free_coherent(size_t size, void *vaddr)
-{
-	struct vm_region *c;
-	unsigned long flags, addr;
-	pte_t *ptep;
+{	struct page *page;
+	unsigned long order;
+	unsigned long addr;
 
+	/* This is safe because we do the same in __dma_alloc_coherent */
 	size = PAGE_ALIGN(size);
+	order = get_order(size);
 
-	spin_lock_irqsave(&consistent_lock, flags);
-
-	c = vm_region_find(&consistent_head, (unsigned long)vaddr);
-	if (!c)
-		goto no_area;
-
-	if ((c->vm_end - c->vm_start) != size) {
-		printk(KERN_ERR "%s: freeing wrong coherent size (%ld != %d)\n",
-		       __func__, c->vm_end - c->vm_start, size);
-		dump_stack();
-		size = c->vm_end - c->vm_start;
+	/* Retrieve the page associated with this address */
+	page = virt_to_page(vaddr);
+	BUG_ON(page == NULL);
+
+	/* Release the physical memory */
+	for (addr = (unsigned long)vaddr; addr < (unsigned long)vaddr+size;
+			addr += PAGE_SIZE, page++) {
+		pte_t *pte;
+		spinlock_t *ptl;
+
+		ClearPageReserved(page);
+		pte = get_locked_pte(&init_mm, addr, &ptl);
+		set_pte_at(&init_mm, addr, pte, mk_pte(page, PAGE_KERNEL));
+		pte_unmap_unlock(pte, ptl);
+		__free_page(page);
 	}
-
-	ptep = consistent_pte + CONSISTENT_OFFSET(c->vm_start);
-	addr = c->vm_start;
-	do {
-		pte_t pte = ptep_get_and_clear(&init_mm, addr, ptep);
-		unsigned long pfn;
-
-		ptep++;
-		addr += PAGE_SIZE;
-
-		if (!pte_none(pte) && pte_present(pte)) {
-			pfn = pte_pfn(pte);
-
-			if (pfn_valid(pfn)) {
-				struct page *page = pfn_to_page(pfn);
-				ClearPageReserved(page);
-
-				__free_page(page);
-				continue;
-			}
-		}
-
-		printk(KERN_CRIT "%s: bad page in kernel page table\n",
-		       __func__);
-	} while (size -= PAGE_SIZE);
-
-	flush_tlb_kernel_range(c->vm_start, c->vm_end);
-
-	list_del(&c->vm_list);
-
-	spin_unlock_irqrestore(&consistent_lock, flags);
-
-	kfree(c);
-	return;
-
- no_area:
-	spin_unlock_irqrestore(&consistent_lock, flags);
-	printk(KERN_ERR "%s: trying to free invalid coherent area: %p\n",
-	       __func__, vaddr);
-	dump_stack();
 }
 EXPORT_SYMBOL(__dma_free_coherent);
 
 /*
- * Initialise the consistent memory allocation.
- */
-static int __init dma_alloc_init(void)
-{
-	pgd_t *pgd;
-	pud_t *pud;
-	pmd_t *pmd;
-	pte_t *pte;
-	int ret = 0;
-
-	do {
-		pgd = pgd_offset(&init_mm, CONSISTENT_BASE);
-		pud = pud_alloc(&init_mm, pgd, CONSISTENT_BASE);
-		pmd = pmd_alloc(&init_mm, pud, CONSISTENT_BASE);
-		if (!pmd) {
-			printk(KERN_ERR "%s: no pmd tables\n", __func__);
-			ret = -ENOMEM;
-			break;
-		}
-		WARN_ON(!pmd_none(*pmd));
-
-		pte = pte_alloc_kernel(pmd, CONSISTENT_BASE);
-		if (!pte) {
-			printk(KERN_ERR "%s: no pte tables\n", __func__);
-			ret = -ENOMEM;
-			break;
-		}
-
-		consistent_pte = pte;
-	} while (0);
-
-	return ret;
-}
-
-core_initcall(dma_alloc_init);
-
-/*
  * make an area consistent.
  */
 void __dma_sync(void *vaddr, size_t size, int direction)
 {
 	unsigned long start = (unsigned long)vaddr;
 	unsigned long end   = start + size;
+	int unaligned;
 
 	switch (direction) {
 	case DMA_NONE:
 		BUG();
 	case DMA_FROM_DEVICE:
 		/*
-		 * invalidate only when cache-line aligned otherwise there is
-		 * the potential for discarding uncommitted data from the cache
+		 * if start or size is not cache aligned we flush before
+		 * invalidating.
+		 * Beware: flush_dcache_range does flush and invalidate
 		 */
-		if ((start & (L1_CACHE_BYTES - 1)) || (size & (L1_CACHE_BYTES - 1)))
-			flush_dcache_range(start, end);
-		else
-			invalidate_dcache_range(start, end);
+		unaligned = start & (L1_CACHE_BYTES - 1);
+		if (unaligned) {
+			flush_dcache_range(start, start + L1_CACHE_BYTES);
+			start += L1_CACHE_BYTES - unaligned;
+		}
+		unaligned = end & (L1_CACHE_BYTES - 1);
+		if (unaligned) {
+			end -= unaligned;
+			flush_dcache_range(end, end + L1_CACHE_BYTES);
+		}
+		invalidate_dcache_range(start, end);
 		break;
 	case DMA_TO_DEVICE:		/* writeback only */
 		clean_dcache_range(start, end);
@@ -368,48 +176,6 @@ void __dma_sync(void *vaddr, size_t size, int direction)
 }
 EXPORT_SYMBOL(__dma_sync);
 
-#ifdef CONFIG_HIGHMEM
-/*
- * __dma_sync_page() implementation for systems using highmem.
- * In this case, each page of a buffer must be kmapped/kunmapped
- * in order to have a virtual address for __dma_sync(). This must
- * not sleep so kmap_atomic()/kunmap_atomic() are used.
- *
- * Note: yes, it is possible and correct to have a buffer extend
- * beyond the first page.
- */
-static inline void __dma_sync_page_highmem(struct page *page,
-		unsigned long offset, size_t size, int direction)
-{
-	size_t seg_size = min((size_t)(PAGE_SIZE - offset), size);
-	size_t cur_size = seg_size;
-	unsigned long flags, start, seg_offset = offset;
-	int nr_segs = 1 + ((size - seg_size) + PAGE_SIZE - 1)/PAGE_SIZE;
-	int seg_nr = 0;
-
-	local_irq_save(flags);
-
-	do {
-		start = (unsigned long)kmap_atomic(page + seg_nr,
-				KM_PPC_SYNC_PAGE) + seg_offset;
-
-		/* Sync this buffer segment */
-		__dma_sync((void *)start, seg_size, direction);
-		kunmap_atomic((void *)start, KM_PPC_SYNC_PAGE);
-		seg_nr++;
-
-		/* Calculate next buffer segment size */
-		seg_size = min((size_t)PAGE_SIZE, size - cur_size);
-
-		/* Add the segment size to our running total */
-		cur_size += seg_size;
-		seg_offset = 0;
-	} while (seg_nr < nr_segs);
-
-	local_irq_restore(flags);
-}
-#endif /* CONFIG_HIGHMEM */
-
 /*
  * __dma_sync_page makes memory consistent. identical to __dma_sync, but
  * takes a struct page instead of a virtual address
@@ -417,11 +183,7 @@ static inline void __dma_sync_page_highmem(struct page *page,
 void __dma_sync_page(struct page *page, unsigned long offset,
 	size_t size, int direction)
 {
-#ifdef CONFIG_HIGHMEM
-	__dma_sync_page_highmem(page, offset, size, direction);
-#else
 	unsigned long start = (unsigned long)page_address(page) + offset;
 	__dma_sync((void *)start, size, direction);
-#endif
 }
 EXPORT_SYMBOL(__dma_sync_page);
