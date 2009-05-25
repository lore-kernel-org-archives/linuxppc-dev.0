Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 589D2DE38B
	for <linuxppc-dev@ozlabs.org>; Mon, 25 May 2009 14:35:29 +1000 (EST)
Subject: Re: powerpc: DMA coherent allocations broken for
	CONFIG_NOT_COHERENT_CACHE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev list <linuxppc-dev@ozlabs.org>
In-Reply-To: <200905250243.15436.arnd@arndb.de>
References: <9481.63517.qm@web28305.mail.ukl.yahoo.com>
	<1243160487.22770.59.camel@pasglop> <1243210914.24376.11.camel@pasglop>
	<200905250243.15436.arnd@arndb.de>
Content-Type: text/plain
Date: Mon, 25 May 2009 14:33:43 +1000
Message-Id: <1243226023.24376.23.camel@pasglop>
Mime-Version: 1.0
Cc: Kumar Gala <galak@gate.crashing.org>,
	Albert Herranz <albert_herranz@yahoo.es>, Ilya Yanok <yanok@emcraft.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

(Please, Kumar, have a good look, especially my change to FIXMAP_TOP,
was there any reason it wasn't a constant in the first place ?)

This is going to .30 if nobody hollers. I've done some testing here
and it seems to be fine, but more eyes at this stage are much welcome.

From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 25 May 2009 14:24:43 +1000
Subject: [PATCH] Revert "powerpc: Rework dma-noncoherent to use generic vmalloc layer"

This reverts commit 33f00dcedb0e22cdb156a23632814fc580fcfcf8

 ... sort-of, the revived dma-noncoherent is modified from the
     previous variant in a handful of ways, mostly because the
     way we lay out our address space changed and I don't want
     to revive a broken config option and try to find "safe"
     values for all platforms (hint: there's none).

The result is a lot more invasive than I would have liked at this
stage, but I felt we had little choice here.

 - We can no longer set the virtual address of the coherent mapping
   (this was a big no-no) it's now fit between vmalloc/ioremap and
   PKMAP (or 0xfe000000 for !CONFIG_HIGHMEM, this arbitrary limit
   must die but that's work for a different patch)

 - Due to the above, I had to do some small changes to various files
   to make FIXADDR_TOP a compile time constant (why wasn't it so ?)
   and cleaner definitions of where bits of the kernel address space
   are located in pgtable_ppc32.h

 - To ease debugging, we now print out the layout of the kernel
   virtual address space at boot time on ppc32

 - The code in dma-noncoherent.c was mostly lifted from ARM, though
   the later had a few updates related to checking the DMA mask we
   never brought over. This is now done.

 - To avoid wasting a whole lot more address space than needed, rather
   than keeping the old assumption that all PTEs for consistent memory
   fit in a single PTE page and do PTE pointer manipulations, I instead
   use our existing map_page() helper to create the mappings which is
   also simpler. Thus, the consistent memory area has no limitations on
   size and alignment now. This is a little bit slower but that shouldn't
   matter as dma_alloc_coherent() shouldn't be a fast path. Similar fixes
   went into the freeing path

 - Finally, because it made more sense and because i wanted to include
   headers local from that directory, I moved dma-noncoherent.c from
   arch/powerpc/lib to arch/powerpc/mm

The reason for the revert is that while it was a good idea to try to
use the mm/vmalloc.c allocator instead of our own (in fact, ours is
itself a dup on an old variant of the vmalloc one), unfortunately,
the approach is terminally busted since dma_alloc_coherent() can be
called at interrupt time or in atomic contexts and there's little
chances we'll make the code in mm/vmalloc.c cope with that :-(

Until we can get the generic code to forbid that idiocy and fix all
drivers abusing it, we pretty much have no choice but revert to
our custom virtual space allocator.

There's also a problem with SMP safety since freeing such mapping
would require an IPI which cannot be done at interrupt time.

However, right now, I don't think we support any platform that is
both SMP and has non-coherent DMA (don't laugh, I know such things
do exist !) so we can sort that out later.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/Kconfig                     |   12 +
 arch/powerpc/include/asm/dma-mapping.h   |    6 +-
 arch/powerpc/include/asm/fixmap.h        |    4 +-
 arch/powerpc/include/asm/pgtable-ppc32.h |   25 ++-
 arch/powerpc/kernel/dma.c                |    2 +-
 arch/powerpc/lib/Makefile                |    1 -
 arch/powerpc/lib/dma-noncoherent.c       |  237 ------------------
 arch/powerpc/mm/Makefile                 |    1 +
 arch/powerpc/mm/dma-noncoherent.c        |  400 ++++++++++++++++++++++++++++++
 arch/powerpc/mm/init_32.c                |    8 +-
 arch/powerpc/mm/mem.c                    |   19 ++
 arch/powerpc/mm/pgtable_32.c             |    2 -
 12 files changed, 464 insertions(+), 253 deletions(-)
 delete mode 100644 arch/powerpc/lib/dma-noncoherent.c
 create mode 100644 arch/powerpc/mm/dma-noncoherent.c

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index a0d1146..cdc9a6f 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -868,6 +868,18 @@ config TASK_SIZE
 	default "0x80000000" if PPC_PREP || PPC_8xx
 	default "0xc0000000"
 
+config CONSISTENT_SIZE_BOOL
+	bool "Set custom consistent memory pool size"
+	depends on ADVANCED_OPTIONS && NOT_COHERENT_CACHE
+	help
+	  This option allows you to set the size of the
+	  consistent memory pool.  This pool of virtual memory
+	  is used to make consistent memory allocations.
+
+config CONSISTENT_SIZE
+	hex "Size of consistent memory pool" if CONSISTENT_SIZE_BOOL
+	default "0x00200000" if NOT_COHERENT_CACHE
+
 config PIN_TLB
 	bool "Pinned Kernel TLBs (860 ONLY)"
 	depends on ADVANCED_OPTIONS && 8xx
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index c69f2b5..cb448d6 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -26,7 +26,9 @@
  * allocate the space "normally" and use the cache management functions
  * to ensure it is consistent.
  */
-extern void *__dma_alloc_coherent(size_t size, dma_addr_t *handle, gfp_t gfp);
+struct device;
+extern void *__dma_alloc_coherent(struct device *dev, size_t size,
+				  dma_addr_t *handle, gfp_t gfp);
 extern void __dma_free_coherent(size_t size, void *vaddr);
 extern void __dma_sync(void *vaddr, size_t size, int direction);
 extern void __dma_sync_page(struct page *page, unsigned long offset,
@@ -37,7 +39,7 @@ extern void __dma_sync_page(struct page *page, unsigned long offset,
  * Cache coherent cores.
  */
 
-#define __dma_alloc_coherent(gfp, size, handle)	NULL
+#define __dma_alloc_coherent(dev, gfp, size, handle)	NULL
 #define __dma_free_coherent(size, addr)		((void)0)
 #define __dma_sync(addr, size, rw)		((void)0)
 #define __dma_sync_page(pg, off, sz, rw)	((void)0)
diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
index d60fd18..f1f4e23 100644
--- a/arch/powerpc/include/asm/fixmap.h
+++ b/arch/powerpc/include/asm/fixmap.h
@@ -14,8 +14,6 @@
 #ifndef _ASM_FIXMAP_H
 #define _ASM_FIXMAP_H
 
-extern unsigned long FIXADDR_TOP;
-
 #ifndef __ASSEMBLY__
 #include <linux/kernel.h>
 #include <asm/page.h>
@@ -24,6 +22,8 @@ extern unsigned long FIXADDR_TOP;
 #include <asm/kmap_types.h>
 #endif
 
+#define FIXADDR_TOP	((unsigned long)(-PAGE_SIZE))
+
 /*
  * Here we define all the compile-time 'special' virtual
  * addresses. The point is to have a constant address at
diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
index ba45c99..4a0c08b 100644
--- a/arch/powerpc/include/asm/pgtable-ppc32.h
+++ b/arch/powerpc/include/asm/pgtable-ppc32.h
@@ -10,7 +10,7 @@
 
 extern unsigned long va_to_phys(unsigned long address);
 extern pte_t *va_to_pte(unsigned long address);
-extern unsigned long ioremap_bot, ioremap_base;
+extern unsigned long ioremap_bot;
 
 #ifdef CONFIG_44x
 extern int icache_44x_need_flush;
@@ -55,9 +55,30 @@ extern int icache_44x_need_flush;
 #define pgd_ERROR(e) \
 	printk("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
+
+/*
+ * This is the bottom of the PKMAP area with HIGHMEM or an arbitrary
+ * value (for now) on others, from where we can start layout kernel
+ * virtual space that goes below PKMAP and FIXMAP
+ */
+#ifdef CONFIG_HIGHMEM
+#define KVIRT_TOP	PKMAP_BASE
+#else
+#define KVIRT_TOP	(0xfe000000UL)	/* for now, could be FIXMAP_BASE ? */
+#endif
+
+/*
+ * This is the "top" of the ioremap space
+ */
+#ifdef CONFIG_NOT_COHERENT_CACHE
+#define IOREMAP_TOP	((KVIRT_TOP - CONFIG_CONSISTENT_SIZE) & PAGE_MASK)
+#else
+#define IOREMAP_TOP	KVIRT_TOP
+#endif
+
 /*
  * Just any arbitrary offset to the start of the vmalloc VM area: the
- * current 64MB value just means that there will be a 64MB "hole" after the
+ * current 16MB value just means that there will be a 16MB "hole" after the
  * physical memory until the kernel virtual memory starts.  That means that
  * any out-of-bounds memory accesses will hopefully be caught.
  * The vmalloc() routines leaves a hole of 4kB between each vmalloced
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 53c7788..6b02793 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -32,7 +32,7 @@ void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 {
 	void *ret;
 #ifdef CONFIG_NOT_COHERENT_CACHE
-	ret = __dma_alloc_coherent(size, dma_handle, flag);
+	ret = __dma_alloc_coherent(dev, size, dma_handle, flag);
 	if (ret == NULL)
 		return NULL;
 	*dma_handle += get_dma_direct_offset(dev);
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 8db3527..29b742b 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_PPC64)	+= copypage_64.o copyuser_64.o \
 			   memcpy_64.o usercopy_64.o mem_64.o string.o
 obj-$(CONFIG_XMON)	+= sstep.o
 obj-$(CONFIG_KPROBES)	+= sstep.o
-obj-$(CONFIG_NOT_COHERENT_CACHE)	+= dma-noncoherent.o
 
 ifeq ($(CONFIG_PPC64),y)
 obj-$(CONFIG_SMP)	+= locks.o
diff --git a/arch/powerpc/lib/dma-noncoherent.c b/arch/powerpc/lib/dma-noncoherent.c
deleted file mode 100644
index 005a28d..0000000
--- a/arch/powerpc/lib/dma-noncoherent.c
+++ /dev/null
@@ -1,237 +0,0 @@
-/*
- *  PowerPC version derived from arch/arm/mm/consistent.c
- *    Copyright (C) 2001 Dan Malek (dmalek@jlc.net)
- *
- *  Copyright (C) 2000 Russell King
- *
- * Consistent memory allocators.  Used for DMA devices that want to
- * share uncached memory with the processor core.  The function return
- * is the virtual address and 'dma_handle' is the physical address.
- * Mostly stolen from the ARM port, with some changes for PowerPC.
- *						-- Dan
- *
- * Reorganized to get rid of the arch-specific consistent_* functions
- * and provide non-coherent implementations for the DMA API. -Matt
- *
- * Added in_interrupt() safe dma_alloc_coherent()/dma_free_coherent()
- * implementation. This is pulled straight from ARM and barely
- * modified. -Matt
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/types.h>
-#include <linux/highmem.h>
-#include <linux/dma-mapping.h>
-#include <linux/vmalloc.h>
-
-#include <asm/tlbflush.h>
-
-/*
- * Allocate DMA-coherent memory space and return both the kernel remapped
- * virtual and bus address for that space.
- */
-void *
-__dma_alloc_coherent(size_t size, dma_addr_t *handle, gfp_t gfp)
-{
-	struct page *page;
-	unsigned long order;
-	int i;
-	unsigned int nr_pages = PAGE_ALIGN(size)>>PAGE_SHIFT;
-	unsigned int array_size = nr_pages * sizeof(struct page *);
-	struct page **pages;
-	struct page *end;
-	u64 mask = 0x00ffffff, limit; /* ISA default */
-	struct vm_struct *area;
-
-	BUG_ON(!mem_init_done);
-	size = PAGE_ALIGN(size);
-	limit = (mask + 1) & ~mask;
-	if (limit && size >= limit) {
-		printk(KERN_WARNING "coherent allocation too big (requested "
-				"%#x mask %#Lx)\n", size, mask);
-		return NULL;
-	}
-
-	order = get_order(size);
-
-	if (mask != 0xffffffff)
-		gfp |= GFP_DMA;
-
-	page = alloc_pages(gfp, order);
-	if (!page)
-		goto no_page;
-
-	end = page + (1 << order);
-
-	/*
-	 * Invalidate any data that might be lurking in the
-	 * kernel direct-mapped region for device DMA.
-	 */
-	{
-		unsigned long kaddr = (unsigned long)page_address(page);
-		memset(page_address(page), 0, size);
-		flush_dcache_range(kaddr, kaddr + size);
-	}
-
-	split_page(page, order);
-
-	/*
-	 * Set the "dma handle"
-	 */
-	*handle = page_to_phys(page);
-
-	area = get_vm_area_caller(size, VM_IOREMAP,
-			__builtin_return_address(1));
-	if (!area)
-		goto out_free_pages;
-
-	if (array_size > PAGE_SIZE) {
-		pages = vmalloc(array_size);
-		area->flags |= VM_VPAGES;
-	} else {
-		pages = kmalloc(array_size, GFP_KERNEL);
-	}
-	if (!pages)
-		goto out_free_area;
-
-	area->pages = pages;
-	area->nr_pages = nr_pages;
-
-	for (i = 0; i < nr_pages; i++)
-		pages[i] = page + i;
-
-	if (map_vm_area(area, pgprot_noncached(PAGE_KERNEL), &pages))
-		goto out_unmap;
-
-	/*
-	 * Free the otherwise unused pages.
-	 */
-	page += nr_pages;
-	while (page < end) {
-		__free_page(page);
-		page++;
-	}
-
-	return area->addr;
-out_unmap:
-	vunmap(area->addr);
-	if (array_size > PAGE_SIZE)
-		vfree(pages);
-	else
-		kfree(pages);
-	goto out_free_pages;
-out_free_area:
-	free_vm_area(area);
-out_free_pages:
-	if (page)
-		__free_pages(page, order);
-no_page:
-	return NULL;
-}
-EXPORT_SYMBOL(__dma_alloc_coherent);
-
-/*
- * free a page as defined by the above mapping.
- */
-void __dma_free_coherent(size_t size, void *vaddr)
-{
-	vfree(vaddr);
-
-}
-EXPORT_SYMBOL(__dma_free_coherent);
-
-/*
- * make an area consistent.
- */
-void __dma_sync(void *vaddr, size_t size, int direction)
-{
-	unsigned long start = (unsigned long)vaddr;
-	unsigned long end   = start + size;
-
-	switch (direction) {
-	case DMA_NONE:
-		BUG();
-	case DMA_FROM_DEVICE:
-		/*
-		 * invalidate only when cache-line aligned otherwise there is
-		 * the potential for discarding uncommitted data from the cache
-		 */
-		if ((start & (L1_CACHE_BYTES - 1)) || (size & (L1_CACHE_BYTES - 1)))
-			flush_dcache_range(start, end);
-		else
-			invalidate_dcache_range(start, end);
-		break;
-	case DMA_TO_DEVICE:		/* writeback only */
-		clean_dcache_range(start, end);
-		break;
-	case DMA_BIDIRECTIONAL:	/* writeback and invalidate */
-		flush_dcache_range(start, end);
-		break;
-	}
-}
-EXPORT_SYMBOL(__dma_sync);
-
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
-/*
- * __dma_sync_page makes memory consistent. identical to __dma_sync, but
- * takes a struct page instead of a virtual address
- */
-void __dma_sync_page(struct page *page, unsigned long offset,
-	size_t size, int direction)
-{
-#ifdef CONFIG_HIGHMEM
-	__dma_sync_page_highmem(page, offset, size, direction);
-#else
-	unsigned long start = (unsigned long)page_address(page) + offset;
-	__dma_sync((void *)start, size, direction);
-#endif
-}
-EXPORT_SYMBOL(__dma_sync_page);
diff --git a/arch/powerpc/mm/Makefile b/arch/powerpc/mm/Makefile
index 17290bc..fc5c4c2 100644
--- a/arch/powerpc/mm/Makefile
+++ b/arch/powerpc/mm/Makefile
@@ -26,3 +26,4 @@ obj-$(CONFIG_NEED_MULTIPLE_NODES) += numa.o
 obj-$(CONFIG_PPC_MM_SLICES)	+= slice.o
 obj-$(CONFIG_HUGETLB_PAGE)	+= hugetlbpage.o
 obj-$(CONFIG_PPC_SUBPAGE_PROT)	+= subpage-prot.o
+obj-$(CONFIG_NOT_COHERENT_CACHE)	+= dma-noncoherent.o
diff --git a/arch/powerpc/mm/dma-noncoherent.c b/arch/powerpc/mm/dma-noncoherent.c
new file mode 100644
index 0000000..36692f5
--- /dev/null
+++ b/arch/powerpc/mm/dma-noncoherent.c
@@ -0,0 +1,400 @@
+/*
+ *  PowerPC version derived from arch/arm/mm/consistent.c
+ *    Copyright (C) 2001 Dan Malek (dmalek@jlc.net)
+ *
+ *  Copyright (C) 2000 Russell King
+ *
+ * Consistent memory allocators.  Used for DMA devices that want to
+ * share uncached memory with the processor core.  The function return
+ * is the virtual address and 'dma_handle' is the physical address.
+ * Mostly stolen from the ARM port, with some changes for PowerPC.
+ *						-- Dan
+ *
+ * Reorganized to get rid of the arch-specific consistent_* functions
+ * and provide non-coherent implementations for the DMA API. -Matt
+ *
+ * Added in_interrupt() safe dma_alloc_coherent()/dma_free_coherent()
+ * implementation. This is pulled straight from ARM and barely
+ * modified. -Matt
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/highmem.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/tlbflush.h>
+
+#include "mmu_decl.h"
+
+/*
+ * This address range defaults to a value that is safe for all
+ * platforms which currently set CONFIG_NOT_COHERENT_CACHE. It
+ * can be further configured for specific applications under
+ * the "Advanced Setup" menu. -Matt
+ */
+#define CONSISTENT_BASE		(IOREMAP_TOP)
+#define CONSISTENT_END 		(CONSISTENT_BASE + CONFIG_CONSISTENT_SIZE)
+#define CONSISTENT_OFFSET(x)	(((unsigned long)(x) - CONSISTENT_BASE) >> PAGE_SHIFT)
+
+/*
+ * This is the page table (2MB) covering uncached, DMA consistent allocations
+ */
+static DEFINE_SPINLOCK(consistent_lock);
+
+/*
+ * VM region handling support.
+ *
+ * This should become something generic, handling VM region allocations for
+ * vmalloc and similar (ioremap, module space, etc).
+ *
+ * I envisage vmalloc()'s supporting vm_struct becoming:
+ *
+ *  struct vm_struct {
+ *    struct vm_region	region;
+ *    unsigned long	flags;
+ *    struct page	**pages;
+ *    unsigned int	nr_pages;
+ *    unsigned long	phys_addr;
+ *  };
+ *
+ * get_vm_area() would then call vm_region_alloc with an appropriate
+ * struct vm_region head (eg):
+ *
+ *  struct vm_region vmalloc_head = {
+ *	.vm_list	= LIST_HEAD_INIT(vmalloc_head.vm_list),
+ *	.vm_start	= VMALLOC_START,
+ *	.vm_end		= VMALLOC_END,
+ *  };
+ *
+ * However, vmalloc_head.vm_start is variable (typically, it is dependent on
+ * the amount of RAM found at boot time.)  I would imagine that get_vm_area()
+ * would have to initialise this each time prior to calling vm_region_alloc().
+ */
+struct ppc_vm_region {
+	struct list_head	vm_list;
+	unsigned long		vm_start;
+	unsigned long		vm_end;
+};
+
+static struct ppc_vm_region consistent_head = {
+	.vm_list	= LIST_HEAD_INIT(consistent_head.vm_list),
+	.vm_start	= CONSISTENT_BASE,
+	.vm_end		= CONSISTENT_END,
+};
+
+static struct ppc_vm_region *
+ppc_vm_region_alloc(struct ppc_vm_region *head, size_t size, gfp_t gfp)
+{
+	unsigned long addr = head->vm_start, end = head->vm_end - size;
+	unsigned long flags;
+	struct ppc_vm_region *c, *new;
+
+	new = kmalloc(sizeof(struct ppc_vm_region), gfp);
+	if (!new)
+		goto out;
+
+	spin_lock_irqsave(&consistent_lock, flags);
+
+	list_for_each_entry(c, &head->vm_list, vm_list) {
+		if ((addr + size) < addr)
+			goto nospc;
+		if ((addr + size) <= c->vm_start)
+			goto found;
+		addr = c->vm_end;
+		if (addr > end)
+			goto nospc;
+	}
+
+ found:
+	/*
+	 * Insert this entry _before_ the one we found.
+	 */
+	list_add_tail(&new->vm_list, &c->vm_list);
+	new->vm_start = addr;
+	new->vm_end = addr + size;
+
+	spin_unlock_irqrestore(&consistent_lock, flags);
+	return new;
+
+ nospc:
+	spin_unlock_irqrestore(&consistent_lock, flags);
+	kfree(new);
+ out:
+	return NULL;
+}
+
+static struct ppc_vm_region *ppc_vm_region_find(struct ppc_vm_region *head, unsigned long addr)
+{
+	struct ppc_vm_region *c;
+
+	list_for_each_entry(c, &head->vm_list, vm_list) {
+		if (c->vm_start == addr)
+			goto out;
+	}
+	c = NULL;
+ out:
+	return c;
+}
+
+/*
+ * Allocate DMA-coherent memory space and return both the kernel remapped
+ * virtual and bus address for that space.
+ */
+void *
+__dma_alloc_coherent(struct device *dev, size_t size, dma_addr_t *handle, gfp_t gfp)
+{
+	struct page *page;
+	struct ppc_vm_region *c;
+	unsigned long order;
+	u64 mask = ISA_DMA_THRESHOLD, limit;
+
+	if (dev) {
+		mask = dev->coherent_dma_mask;
+
+		/*
+		 * Sanity check the DMA mask - it must be non-zero, and
+		 * must be able to be satisfied by a DMA allocation.
+		 */
+		if (mask == 0) {
+			dev_warn(dev, "coherent DMA mask is unset\n");
+			goto no_page;
+		}
+
+		if ((~mask) & ISA_DMA_THRESHOLD) {
+			dev_warn(dev, "coherent DMA mask %#llx is smaller "
+				 "than system GFP_DMA mask %#llx\n",
+				 mask, (unsigned long long)ISA_DMA_THRESHOLD);
+			goto no_page;
+		}
+	}
+
+
+	size = PAGE_ALIGN(size);
+	limit = (mask + 1) & ~mask;
+	if ((limit && size >= limit) ||
+	    size >= (CONSISTENT_END - CONSISTENT_BASE)) {
+		printk(KERN_WARNING "coherent allocation too big (requested %#x mask %#Lx)\n",
+		       size, mask);
+		return NULL;
+	}
+
+	order = get_order(size);
+
+	/* Might be useful if we ever have a real legacy DMA zone... */
+	if (mask != 0xffffffff)
+		gfp |= GFP_DMA;
+
+	page = alloc_pages(gfp, order);
+	if (!page)
+		goto no_page;
+
+	/*
+	 * Invalidate any data that might be lurking in the
+	 * kernel direct-mapped region for device DMA.
+	 */
+	{
+		unsigned long kaddr = (unsigned long)page_address(page);
+		memset(page_address(page), 0, size);
+		flush_dcache_range(kaddr, kaddr + size);
+	}
+
+	/*
+	 * Allocate a virtual address in the consistent mapping region.
+	 */
+	c = ppc_vm_region_alloc(&consistent_head, size,
+			    gfp & ~(__GFP_DMA | __GFP_HIGHMEM));
+	if (c) {
+		unsigned long vaddr = c->vm_start;
+		struct page *end = page + (1 << order);
+
+		split_page(page, order);
+
+		/*
+		 * Set the "dma handle"
+		 */
+		*handle = page_to_phys(page);
+
+		do {
+			SetPageReserved(page);
+			map_page(vaddr, page_to_phys(page),
+				 pgprot_noncached(PAGE_KERNEL));
+			page++;
+			vaddr += PAGE_SIZE;
+		} while (size -= PAGE_SIZE);
+
+		/*
+		 * Free the otherwise unused pages.
+		 */
+		while (page < end) {
+			__free_page(page);
+			page++;
+		}
+
+		return (void *)c->vm_start;
+	}
+
+	if (page)
+		__free_pages(page, order);
+ no_page:
+	return NULL;
+}
+EXPORT_SYMBOL(__dma_alloc_coherent);
+
+/*
+ * free a page as defined by the above mapping.
+ */
+void __dma_free_coherent(size_t size, void *vaddr)
+{
+	struct ppc_vm_region *c;
+	unsigned long flags, addr;
+	
+	size = PAGE_ALIGN(size);
+
+	spin_lock_irqsave(&consistent_lock, flags);
+
+	c = ppc_vm_region_find(&consistent_head, (unsigned long)vaddr);
+	if (!c)
+		goto no_area;
+
+	if ((c->vm_end - c->vm_start) != size) {
+		printk(KERN_ERR "%s: freeing wrong coherent size (%ld != %d)\n",
+		       __func__, c->vm_end - c->vm_start, size);
+		dump_stack();
+		size = c->vm_end - c->vm_start;
+	}
+
+	addr = c->vm_start;
+	do {
+		pte_t *ptep;
+		unsigned long pfn;
+
+		ptep = pte_offset_kernel(pmd_offset(pud_offset(pgd_offset_k(addr),
+							       addr),
+						    addr),
+					 addr);
+		if (!pte_none(*ptep) && pte_present(*ptep)) {
+			pfn = pte_pfn(*ptep);
+			pte_clear(&init_mm, addr, ptep);
+			if (pfn_valid(pfn)) {
+				struct page *page = pfn_to_page(pfn);
+
+				ClearPageReserved(page);
+				__free_page(page);
+			}
+		}
+		addr += PAGE_SIZE;
+	} while (size -= PAGE_SIZE);
+
+	flush_tlb_kernel_range(c->vm_start, c->vm_end);
+
+	list_del(&c->vm_list);
+
+	spin_unlock_irqrestore(&consistent_lock, flags);
+
+	kfree(c);
+	return;
+
+ no_area:
+	spin_unlock_irqrestore(&consistent_lock, flags);
+	printk(KERN_ERR "%s: trying to free invalid coherent area: %p\n",
+	       __func__, vaddr);
+	dump_stack();
+}
+EXPORT_SYMBOL(__dma_free_coherent);
+
+/*
+ * make an area consistent.
+ */
+void __dma_sync(void *vaddr, size_t size, int direction)
+{
+	unsigned long start = (unsigned long)vaddr;
+	unsigned long end   = start + size;
+
+	switch (direction) {
+	case DMA_NONE:
+		BUG();
+	case DMA_FROM_DEVICE:
+		/*
+		 * invalidate only when cache-line aligned otherwise there is
+		 * the potential for discarding uncommitted data from the cache
+		 */
+		if ((start & (L1_CACHE_BYTES - 1)) || (size & (L1_CACHE_BYTES - 1)))
+			flush_dcache_range(start, end);
+		else
+			invalidate_dcache_range(start, end);
+		break;
+	case DMA_TO_DEVICE:		/* writeback only */
+		clean_dcache_range(start, end);
+		break;
+	case DMA_BIDIRECTIONAL:	/* writeback and invalidate */
+		flush_dcache_range(start, end);
+		break;
+	}
+}
+EXPORT_SYMBOL(__dma_sync);
+
+#ifdef CONFIG_HIGHMEM
+/*
+ * __dma_sync_page() implementation for systems using highmem.
+ * In this case, each page of a buffer must be kmapped/kunmapped
+ * in order to have a virtual address for __dma_sync(). This must
+ * not sleep so kmap_atomic()/kunmap_atomic() are used.
+ *
+ * Note: yes, it is possible and correct to have a buffer extend
+ * beyond the first page.
+ */
+static inline void __dma_sync_page_highmem(struct page *page,
+		unsigned long offset, size_t size, int direction)
+{
+	size_t seg_size = min((size_t)(PAGE_SIZE - offset), size);
+	size_t cur_size = seg_size;
+	unsigned long flags, start, seg_offset = offset;
+	int nr_segs = 1 + ((size - seg_size) + PAGE_SIZE - 1)/PAGE_SIZE;
+	int seg_nr = 0;
+
+	local_irq_save(flags);
+
+	do {
+		start = (unsigned long)kmap_atomic(page + seg_nr,
+				KM_PPC_SYNC_PAGE) + seg_offset;
+
+		/* Sync this buffer segment */
+		__dma_sync((void *)start, seg_size, direction);
+		kunmap_atomic((void *)start, KM_PPC_SYNC_PAGE);
+		seg_nr++;
+
+		/* Calculate next buffer segment size */
+		seg_size = min((size_t)PAGE_SIZE, size - cur_size);
+
+		/* Add the segment size to our running total */
+		cur_size += seg_size;
+		seg_offset = 0;
+	} while (seg_nr < nr_segs);
+
+	local_irq_restore(flags);
+}
+#endif /* CONFIG_HIGHMEM */
+
+/*
+ * __dma_sync_page makes memory consistent. identical to __dma_sync, but
+ * takes a struct page instead of a virtual address
+ */
+void __dma_sync_page(struct page *page, unsigned long offset,
+	size_t size, int direction)
+{
+#ifdef CONFIG_HIGHMEM
+	__dma_sync_page_highmem(page, offset, size, direction);
+#else
+	unsigned long start = (unsigned long)page_address(page) + offset;
+	__dma_sync((void *)start, size, direction);
+#endif
+}
+EXPORT_SYMBOL(__dma_sync_page);
diff --git a/arch/powerpc/mm/init_32.c b/arch/powerpc/mm/init_32.c
index 666a5e8..3de6a0d 100644
--- a/arch/powerpc/mm/init_32.c
+++ b/arch/powerpc/mm/init_32.c
@@ -168,12 +168,8 @@ void __init MMU_init(void)
 		ppc_md.progress("MMU:mapin", 0x301);
 	mapin_ram();
 
-#ifdef CONFIG_HIGHMEM
-	ioremap_base = PKMAP_BASE;
-#else
-	ioremap_base = 0xfe000000UL;	/* for now, could be 0xfffff000 */
-#endif /* CONFIG_HIGHMEM */
-	ioremap_bot = ioremap_base;
+	/* Initialize early top-down ioremap allocator */
+	ioremap_bot = IOREMAP_TOP;
 
 	/* Map in I/O resources */
 	if (ppc_md.progress)
diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
index d0602a7..1435c4b 100644
--- a/arch/powerpc/mm/mem.c
+++ b/arch/powerpc/mm/mem.c
@@ -296,6 +296,7 @@ void __init paging_init(void)
 	       (unsigned long long)top_of_ram, total_ram);
 	printk(KERN_DEBUG "Memory hole size: %ldMB\n",
 	       (long int)((top_of_ram - total_ram) >> 20));
+
 	memset(max_zone_pfns, 0, sizeof(max_zone_pfns));
 #ifdef CONFIG_HIGHMEM
 	max_zone_pfns[ZONE_DMA] = lowmem_end_addr >> PAGE_SHIFT;
@@ -380,6 +381,24 @@ void __init mem_init(void)
 		bsssize >> 10,
 		initsize >> 10);
 
+#ifdef CONFIG_PPC32
+	printk(KERN_INFO "Kernel virtual memory layout:\n");
+	printk(KERN_INFO "  * 0x%08lx..0x%08lx  : fixmap\n",
+	       FIXADDR_START, FIXADDR_TOP);
+#ifdef CONFIG_HIGHMEM
+	printk(KERN_INFO "  * 0x%08lx..0x%08lx  : highmem PTEs\n",
+	       PKMAP_BASE, PKMAP_ADDR(LAST_PKMAP));
+#endif /* CONFIG_HIGHMEM */
+#ifdef CONFIG_NOT_COHERENT_CACHE
+	printk(KERN_INFO "  * 0x%08lx..0x%08lx  : consistent mem\n",
+	       IOREMAP_TOP, IOREMAP_TOP + CONFIG_CONSISTENT_SIZE);
+#endif /* CONFIG_NOT_COHERENT_CACHE */
+	printk(KERN_INFO "  * 0x%08lx..0x%08lx  : early ioremap\n",
+	       ioremap_bot, IOREMAP_TOP);
+	printk(KERN_INFO "  * 0x%08lx..0x%08lx  : vmalloc & ioremap\n",
+	       VMALLOC_START, VMALLOC_END);
+#endif /* CONFIG_PPC32 */
+
 	mem_init_done = 1;
 }
 
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 430d090..5422169 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -399,8 +399,6 @@ void kernel_map_pages(struct page *page, int numpages, int enable)
 #endif /* CONFIG_DEBUG_PAGEALLOC */
 
 static int fixmaps;
-unsigned long FIXADDR_TOP = (-PAGE_SIZE);
-EXPORT_SYMBOL(FIXADDR_TOP);
 
 void __set_fixmap (enum fixed_addresses idx, phys_addr_t phys, pgprot_t flags)
 {
-- 
1.6.1.2.14.gf26b5

 
