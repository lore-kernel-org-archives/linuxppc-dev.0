Date: Fri, 21 May 2004 15:03:28 -0700
From: Matt Porter <mporter@kernel.crashing.org>
To: paulus@samba.org, linuxppc-dev@lists.linuxppc.org
Subject: [PATCH] Reorg (PCI) DMA API and add consistent alloc from irq
Message-ID: <20040521150328.A25951@home.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The following patch reorgs the PCI DMA API and DMA API implementations
on PPC32.  It throws away the old consistent_*() routines that were
arch-specific because 2.6 drivers should be using the generic DMA
API.  It defines all previous functionality natively in terms of
the DMA API calls.  The PCI DMA API is implemented by including
asm-generic/pci-dma-compat.h. In addition, this pulls in the ARM
implemented method of performing dma_alloc_coherent()/dma_free_coherent()
(previously consistent_alloc()/consistent_free()) so that we
comply with the requirement to be able to allocate consistent
memory out of an interrupt context.  We were previously unable
to do that on CONFIG_NOT_COHERENT_CACHE, resulting in drivers
like sym53c8xx_2 that are unable to be used on 4xx, etc.

It has been tested with a bunch of PCI and on-chip DMA devices on
7xx, 74xx, and 4xx successfully.

Comments?

-Matt

diff -Nru a/arch/ppc/Kconfig b/arch/ppc/Kconfig
--- a/arch/ppc/Kconfig	Fri May 21 11:01:23 2004
+++ b/arch/ppc/Kconfig	Fri May 21 11:01:23 2004
@@ -1070,6 +1070,30 @@
 	hex "Size of user task space" if TASK_SIZE_BOOL
 	default "0x80000000"

+config CONSISTENT_START_BOOL
+	bool "Set custom consistent memory pool address"
+	depends on ADVANCED_OPTIONS && NOT_COHERENT_CACHE
+	help
+	  This option allows you to set the base virtual address
+	  of the the consistent memory pool.  This pool of virtual
+	  memory is used to make consistent memory allocations.
+
+config CONSISTENT_START
+	hex "Base virtual address of consistent memory pool" if CONSISTENT_START_BOOL
+	default "0xff100000" if NOT_COHERENT_CACHE
+
+config CONSISTENT_SIZE_BOOL
+	bool "Set custom consistent memory pool size"
+	depends on ADVANCED_OPTIONS && NOT_COHERENT_CACHE
+	help
+	  This option allows you to set the size of the the
+	  consistent memory pool.  This pool of virtual memory
+	  is used to make consistent memory allocations.
+
+config CONSISTENT_SIZE
+	hex "Size of consistent memory pool" if CONSISTENT_SIZE_BOOL
+	default "0x00200000" if NOT_COHERENT_CACHE
+
 config BOOT_LOAD_BOOL
 	bool "Set the boot link/load address"
 	depends on ADVANCED_OPTIONS && !PPC_MULTIPLATFORM
diff -Nru a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
--- a/arch/ppc/kernel/Makefile	Fri May 21 11:01:23 2004
+++ b/arch/ppc/kernel/Makefile	Fri May 21 11:01:23 2004
@@ -24,8 +24,8 @@
 obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
 obj-$(CONFIG_POWER4)		+= cpu_setup_power4.o
 obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
+obj-$(CONFIG_NOT_COHERENT_CACHE)	+= dma-mapping.o
 obj-$(CONFIG_PCI)		+= pci.o
-obj-$(CONFIG_PCI)		+= pci-dma.o
 obj-$(CONFIG_KGDB)		+= ppc-stub.o
 obj-$(CONFIG_SMP)		+= smp.o smp-tbsync.o
 obj-$(CONFIG_TAU)		+= temp.o
diff -Nru a/arch/ppc/kernel/dma-mapping.c b/arch/ppc/kernel/dma-mapping.c
--- /dev/null	Wed Dec 31 16:00:00 1969
+++ b/arch/ppc/kernel/dma-mapping.c	Fri May 21 11:01:23 2004
@@ -0,0 +1,439 @@
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
+#include <linux/config.h>
+#include <linux/module.h>
+#include <linux/signal.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/errno.h>
+#include <linux/string.h>
+#include <linux/types.h>
+#include <linux/ptrace.h>
+#include <linux/mman.h>
+#include <linux/mm.h>
+#include <linux/swap.h>
+#include <linux/stddef.h>
+#include <linux/vmalloc.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/bootmem.h>
+#include <linux/highmem.h>
+#include <linux/dma-mapping.h>
+
+#include <asm/pgalloc.h>
+#include <asm/prom.h>
+#include <asm/io.h>
+#include <asm/hardirq.h>
+#include <asm/mmu_context.h>
+#include <asm/pgtable.h>
+#include <asm/mmu.h>
+#include <asm/uaccess.h>
+#include <asm/smp.h>
+#include <asm/machdep.h>
+
+int map_page(unsigned long va, phys_addr_t pa, int flags);
+
+#include <asm/tlbflush.h>
+
+/*
+ * This address range defaults to a value that is safe for all
+ * platforms which currently set CONFIG_NOT_COHERENT_CACHE. It
+ * can be further configured for specific applications under
+ * the "Advanced Setup" menu. -Matt
+ */
+#define CONSISTENT_BASE	(CONFIG_CONSISTENT_START)
+#define CONSISTENT_END	(CONFIG_CONSISTENT_START + CONFIG_CONSISTENT_SIZE)
+#define CONSISTENT_OFFSET(x)	(((unsigned long)(x) - CONSISTENT_BASE) >> PAGE_SHIFT)
+
+/*
+ * This is the page table (2MB) covering uncached, DMA consistent allocations
+ */
+static pte_t *consistent_pte;
+static spinlock_t consistent_lock = SPIN_LOCK_UNLOCKED;
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
+struct vm_region {
+	struct list_head	vm_list;
+	unsigned long		vm_start;
+	unsigned long		vm_end;
+};
+
+static struct vm_region consistent_head = {
+	.vm_list	= LIST_HEAD_INIT(consistent_head.vm_list),
+	.vm_start	= CONSISTENT_BASE,
+	.vm_end		= CONSISTENT_END,
+};
+
+static struct vm_region *
+vm_region_alloc(struct vm_region *head, size_t size, int gfp)
+{
+	unsigned long addr = head->vm_start, end = head->vm_end - size;
+	unsigned long flags;
+	struct vm_region *c, *new;
+
+	new = kmalloc(sizeof(struct vm_region), gfp);
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
+static struct vm_region *vm_region_find(struct vm_region *head, unsigned long addr)
+{
+	struct vm_region *c;
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
+__dma_alloc_coherent(size_t size, dma_addr_t *handle, int gfp)
+{
+	struct page *page;
+	struct vm_region *c;
+	unsigned long order;
+	u64 mask = 0x00ffffff, limit; /* ISA default */
+
+	if (!consistent_pte) {
+		printk(KERN_ERR "%s: not initialised\n", __func__);
+		dump_stack();
+		return NULL;
+	}
+
+	size = PAGE_ALIGN(size);
+	limit = (mask + 1) & ~mask;
+	if ((limit && size >= limit) || size >= (CONSISTENT_END - CONSISTENT_BASE)) {
+		printk(KERN_WARNING "coherent allocation too big (requested %#x mask %#Lx)\n",
+		       size, mask);
+		return NULL;
+	}
+
+	order = get_order(size);
+
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
+	c = vm_region_alloc(&consistent_head, size,
+			    gfp & ~(__GFP_DMA | __GFP_HIGHMEM));
+	if (c) {
+		pte_t *pte = consistent_pte + CONSISTENT_OFFSET(c->vm_start);
+		struct page *end = page + (1 << order);
+
+		/*
+		 * Set the "dma handle"
+		 */
+		*handle = page_to_bus(page);
+
+		do {
+			BUG_ON(!pte_none(*pte));
+
+			set_page_count(page, 1);
+			SetPageReserved(page);
+			set_pte(pte, mk_pte(page, pgprot_noncached(PAGE_KERNEL)));
+			page++;
+			pte++;
+		} while (size -= PAGE_SIZE);
+
+		/*
+		 * Free the otherwise unused pages.
+		 */
+		while (page < end) {
+			set_page_count(page, 1);
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
+
+/*
+ * free a page as defined by the above mapping.
+ */
+void __dma_free_coherent(size_t size, void *vaddr)
+{
+	struct vm_region *c;
+	unsigned long flags;
+	pte_t *ptep;
+
+	size = PAGE_ALIGN(size);
+
+	spin_lock_irqsave(&consistent_lock, flags);
+
+	c = vm_region_find(&consistent_head, (unsigned long)vaddr);
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
+	ptep = consistent_pte + CONSISTENT_OFFSET(c->vm_start);
+	do {
+		pte_t pte = ptep_get_and_clear(ptep);
+		unsigned long pfn;
+
+		ptep++;
+
+		if (!pte_none(pte) && pte_present(pte)) {
+			pfn = pte_pfn(pte);
+
+			if (pfn_valid(pfn)) {
+				struct page *page = pfn_to_page(pfn);
+				ClearPageReserved(page);
+
+				__free_page(page);
+				continue;
+			}
+		}
+
+		printk(KERN_CRIT "%s: bad page in kernel page table\n",
+		       __func__);
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
+EXPORT_SYMBOL(dma_free_coherent);
+
+/*
+ * Initialise the consistent memory allocation.
+ */
+static int __init dma_alloc_init(void)
+{
+	pgd_t *pgd;
+	pmd_t *pmd;
+	pte_t *pte;
+	int ret = 0;
+
+	spin_lock(&init_mm.page_table_lock);
+
+	do {
+		pgd = pgd_offset(&init_mm, CONSISTENT_BASE);
+		pmd = pmd_alloc(&init_mm, pgd, CONSISTENT_BASE);
+		if (!pmd) {
+			printk(KERN_ERR "%s: no pmd tables\n", __func__);
+			ret = -ENOMEM;
+			break;
+		}
+		WARN_ON(!pmd_none(*pmd));
+
+		pte = pte_alloc_kernel(&init_mm, pmd, CONSISTENT_BASE);
+		if (!pte) {
+			printk(KERN_ERR "%s: no pte tables\n", __func__);
+			ret = -ENOMEM;
+			break;
+		}
+
+		consistent_pte = pte;
+	} while (0);
+
+	spin_unlock(&init_mm.page_table_lock);
+
+	return ret;
+}
+
+core_initcall(dma_alloc_init);
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
+	case DMA_FROM_DEVICE:	/* invalidate only */
+		invalidate_dcache_range(start, end);
+		break;
+	case DMA_TO_DEVICE:		/* writeback only */
+		clean_dcache_range(start, end);
+		break;
+	case DMA_BIDIRECTIONAL:	/* writeback and invalidate */
+		flush_dcache_range(start, end);
+		break;
+	}
+}
+
+#ifdef CONFIG_HIGHMEM
+/*
+ * __dma_sync_page() implementation for systems using highmem.
+ * In this case, each page of a buffer must be kmapped/kunmapped
+ * in order to have a virtual address for __dma_sync(). This must
+ * not sleep so kmap_atmomic()/kunmap_atomic() are used.
+ *
+ * Note: yes, it is possible and correct to have a buffer extend
+ * beyond the first page.
+ */
+static inline void __dma_sync_page_highmem(struct page *page,
+		unsigned long offset, size_t size, int direction)
+{
+	size_t seg_size = min((size_t)PAGE_SIZE, size) - offset;
+	size_t cur_size = seg_size;
+	unsigned long flags, start, seg_offset = offset;
+	int nr_segs = PAGE_ALIGN(size + (PAGE_SIZE - offset))/PAGE_SIZE;
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
diff -Nru a/arch/ppc/kernel/ppc_ksyms.c b/arch/ppc/kernel/ppc_ksyms.c
--- a/arch/ppc/kernel/ppc_ksyms.c	Fri May 21 11:01:23 2004
+++ b/arch/ppc/kernel/ppc_ksyms.c	Fri May 21 11:01:23 2004
@@ -181,9 +181,6 @@
 #endif /* CONFIG_PCI */

 #ifdef CONFIG_NOT_COHERENT_CACHE
-EXPORT_SYMBOL(consistent_alloc);
-EXPORT_SYMBOL(consistent_free);
-EXPORT_SYMBOL(consistent_sync);
 EXPORT_SYMBOL(flush_dcache_all);
 #endif

diff -Nru a/arch/ppc/mm/Makefile b/arch/ppc/mm/Makefile
--- a/arch/ppc/mm/Makefile	Fri May 21 11:01:23 2004
+++ b/arch/ppc/mm/Makefile	Fri May 21 11:01:23 2004
@@ -12,4 +12,3 @@
 obj-$(CONFIG_PPC_STD_MMU)	+= hashtable.o ppc_mmu.o tlb.o
 obj-$(CONFIG_40x)		+= 4xx_mmu.o
 obj-$(CONFIG_44x)		+= 44x_mmu.o
-obj-$(CONFIG_NOT_COHERENT_CACHE)	+= cachemap.o
diff -Nru a/arch/ppc/mm/cachemap.c b/arch/ppc/mm/cachemap.c
--- a/arch/ppc/mm/cachemap.c	Fri May 21 11:01:23 2004
+++ /dev/null	Wed Dec 31 16:00:00 1969
@@ -1,174 +0,0 @@
-/*
- *  PowerPC version derived from arch/arm/mm/consistent.c
- *    Copyright (C) 2001 Dan Malek (dmalek@jlc.net)
- *
- *  arch/ppc/mm/cachemap.c
- *
- *  Copyright (C) 2000 Russell King
- *
- * Consistent memory allocators.  Used for DMA devices that want to
- * share uncached memory with the processor core.  The function return
- * is the virtual address and 'dma_handle' is the physical address.
- * Mostly stolen from the ARM port, with some changes for PowerPC.
- *						-- Dan
- *
- * This program is free software; you can redistribute it and/or modify
- * it under the terms of the GNU General Public License version 2 as
- * published by the Free Software Foundation.
- */
-
-#include <linux/config.h>
-#include <linux/module.h>
-#include <linux/signal.h>
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/errno.h>
-#include <linux/string.h>
-#include <linux/types.h>
-#include <linux/ptrace.h>
-#include <linux/mman.h>
-#include <linux/mm.h>
-#include <linux/swap.h>
-#include <linux/stddef.h>
-#include <linux/vmalloc.h>
-#include <linux/init.h>
-#include <linux/delay.h>
-#include <linux/bootmem.h>
-#include <linux/highmem.h>
-#include <linux/dma-mapping.h>
-
-#include <asm/pgalloc.h>
-#include <asm/prom.h>
-#include <asm/io.h>
-#include <asm/hardirq.h>
-#include <asm/mmu_context.h>
-#include <asm/pgtable.h>
-#include <asm/mmu.h>
-#include <asm/uaccess.h>
-#include <asm/smp.h>
-#include <asm/machdep.h>
-
-int map_page(unsigned long va, phys_addr_t pa, int flags);
-
-/* This function will allocate the requested contiguous pages and
- * map them into the kernel's vmalloc() space.  This is done so we
- * get unique mapping for these pages, outside of the kernel's 1:1
- * virtual:physical mapping.  This is necessary so we can cover large
- * portions of the kernel with single large page TLB entries, and
- * still get unique uncached pages for consistent DMA.
- */
-void *consistent_alloc(int gfp, size_t size, dma_addr_t *dma_handle)
-{
-	int order, err;
-	struct page *page, *free, *end;
-	phys_addr_t pa;
-	unsigned long flags, offset;
-	struct vm_struct *area = NULL;
-	unsigned long va = 0;
-
-	BUG_ON(in_interrupt());
-
-	/* Only allocate page size areas */
-	size = PAGE_ALIGN(size);
-	order = get_order(size);
-
-	free = page = alloc_pages(gfp, order);
-	if (! page)
-		return NULL;
-
-	pa = page_to_phys(page);
-	*dma_handle = page_to_bus(page);
-	end = page + (1 << order);
-
-	/*
-	 * we need to ensure that there are no cachelines in use,
-	 * or worse dirty in this area.
-	 */
-	invalidate_dcache_range((unsigned long)page_address(page),
-				(unsigned long)page_address(page) + size);
-
-	/*
-	 * alloc_pages() expects the block to be handled as a unit, so
-	 * it only sets the page count on the first page.  We set the
-	 * counts on each page so they can be freed individually
-	 */
-	for (; page < end; page++)
-		set_page_count(page, 1);
-
-
-	/* Allocate some common virtual space to map the new pages*/
-	area = get_vm_area(size, VM_ALLOC);
-	if (! area)
-		goto out;
-
-	va = (unsigned long) area->addr;
-
-	flags = _PAGE_KERNEL | _PAGE_NO_CACHE;
-
-	for (offset = 0; offset < size; offset += PAGE_SIZE) {
-		err = map_page(va+offset, pa+offset, flags);
-		if (err) {
-			vfree((void *)va);
-			va = 0;
-			goto out;
-		}
-
-		free++;
-	}
-
- out:
-	/* Free pages which weren't mapped */
-	for (; free < end; free++) {
-		__free_page(free);
-	}
-
-	return (void *)va;
-}
-
-/*
- * free page(s) as defined by the above mapping.
- */
-void consistent_free(void *vaddr)
-{
-	BUG_ON(in_interrupt());
-	vfree(vaddr);
-}
-
-/*
- * make an area consistent.
- */
-void consistent_sync(void *vaddr, size_t size, int direction)
-{
-	unsigned long start = (unsigned long)vaddr;
-	unsigned long end   = start + size;
-
-	switch (direction) {
-	case DMA_NONE:
-		BUG();
-	case DMA_FROM_DEVICE:	/* invalidate only */
-		invalidate_dcache_range(start, end);
-		break;
-	case DMA_TO_DEVICE:		/* writeback only */
-		clean_dcache_range(start, end);
-		break;
-	case DMA_BIDIRECTIONAL:	/* writeback and invalidate */
-		flush_dcache_range(start, end);
-		break;
-	}
-}
-
-/*
- * consistent_sync_page make a page are consistent. identical
- * to consistent_sync, but takes a struct page instead of a virtual address
- */
-
-void consistent_sync_page(struct page *page, unsigned long offset,
-	size_t size, int direction)
-{
-	unsigned long start;
-
-	start = (unsigned long)page_address(page) + offset;
-	consistent_sync((void *)start, size, direction);
-}
-
-EXPORT_SYMBOL(consistent_sync_page);
diff -Nru a/include/asm-ppc/dma-mapping.h b/include/asm-ppc/dma-mapping.h
--- a/include/asm-ppc/dma-mapping.h	Fri May 21 11:01:23 2004
+++ b/include/asm-ppc/dma-mapping.h	Fri May 21 11:01:23 2004
@@ -6,15 +6,48 @@
 #define __ASM_PPC_DMA_MAPPING_H

 #include <linux/config.h>
-/* we implement the API below in terms of the existing PCI one,
- * so include it */
-#include <linux/pci.h>
 /* need struct page definitions */
 #include <linux/mm.h>
 #include <linux/device.h>
 #include <asm/scatterlist.h>
 #include <asm/io.h>

+#ifdef CONFIG_NOT_COHERENT_CACHE
+/*
+ * DMA-consistent mapping functions for PowerPCs that don't support
+ * cache snooping.  These allocate/free a region of uncached mapped
+ * memory space for use with DMA devices.  Alternatively, you could
+ * allocate the space "normally" and use the cache management functions
+ * to ensure it is consistent.
+ */
+extern void *__dma_alloc_coherent(size_t size, dma_addr_t *handle, int gfp);
+extern void __dma_free_coherent(size_t size, void *vaddr);
+extern void __dma_sync(void *vaddr, size_t size, int direction);
+extern void __dma_sync_page(struct page *page, unsigned long offset,
+				 size_t size, int direction);
+#define dma_cache_inv(_start,_size) \
+	invalidate_dcache_range(_start, (_start + _size))
+#define dma_cache_wback(_start,_size) \
+	clean_dcache_range(_start, (_start + _size))
+#define dma_cache_wback_inv(_start,_size) \
+	flush_dcache_range(_start, (_start + _size))
+
+#else /* ! CONFIG_NOT_COHERENT_CACHE */
+/*
+ * Cache coherent cores.
+ */
+
+#define dma_cache_inv(_start,_size)		do { } while (0)
+#define dma_cache_wback(_start,_size)		do { } while (0)
+#define dma_cache_wback_inv(_start,_size)	do { } while (0)
+
+#define __dma_alloc_coherent(gfp, size, handle)	NULL
+#define __dma_free_coherent(size, addr)		do { } while (0)
+#define __dma_sync(addr, size, rw)		do { } while (0)
+#define __dma_sync_page(pg, off, sz, rw)	do { } while (0)
+
+#endif /* ! CONFIG_NOT_COHERENT_CACHE */
+
 #define dma_supported(dev, mask)	(1)

 static inline int dma_set_mask(struct device *dev, u64 dma_mask)
@@ -28,28 +61,38 @@
 }

 static inline void *dma_alloc_coherent(struct device *dev, size_t size,
-				       dma_addr_t * dma_handle, int flag)
+				       dma_addr_t * dma_handle, int gfp)
 {
-#ifdef CONFIG_PCI
-	if (dev && dev->bus == &pci_bus_type)
-		return pci_alloc_consistent(to_pci_dev(dev), size, dma_handle);
+#ifdef CONFIG_NOT_COHERENT_CACHE
+	return __dma_alloc_coherent(size, dma_handle, gfp);
+#else
+	void *ret;
+	/* ignore region specifiers */
+	gfp &= ~(__GFP_DMA | __GFP_HIGHMEM);
+
+	if (dev == NULL || dev->coherent_dma_mask < 0xffffffff)
+		gfp |= GFP_DMA;
+
+	ret = (void *)__get_free_pages(gfp, get_order(size));
+
+	if (ret != NULL) {
+		memset(ret, 0, size);
+		*dma_handle = virt_to_bus(ret);
+	}
+
+	return ret;
 #endif
-
-	return consistent_alloc(flag, size, dma_handle);
 }

 static inline void
 dma_free_coherent(struct device *dev, size_t size, void *vaddr,
 		  dma_addr_t dma_handle)
 {
-#ifdef CONFIG_PCI
-	if (dev && dev->bus == &pci_bus_type) {
-		pci_free_consistent(to_pci_dev(dev), size, vaddr, dma_handle);
-		return;
-	}
+#ifdef CONFIG_NOT_COHERENT_CACHE
+	__dma_free_coherent(size, vaddr);
+#else
+	free_pages((unsigned long)vaddr, get_order(size));
 #endif
-
-	consistent_free(vaddr);
 }

 static inline dma_addr_t
@@ -58,7 +101,7 @@
 {
 	BUG_ON(direction == DMA_NONE);

-	consistent_sync(ptr, size, direction);
+	__dma_sync(ptr, size, direction);

 	return virt_to_bus(ptr);
 }
@@ -72,12 +115,14 @@
 	     enum dma_data_direction direction)
 {
 	BUG_ON(direction == DMA_NONE);
-	consistent_sync_page(page, offset, size, direction);
+
+	__dma_sync_page(page, offset, size, direction);
+
 	return (page - mem_map) * PAGE_SIZE + PCI_DRAM_OFFSET + offset;
 }

 /* We do nothing. */
-#define dma_unmap_page(dev, addr, size, dir)	do { } while (0)
+#define dma_unmap_page(dev, handle, size, dir)	do { } while (0)

 static inline int
 dma_map_sg(struct device *dev, struct scatterlist *sg, int nents,
@@ -89,8 +134,7 @@

 	for (i = 0; i < nents; i++, sg++) {
 		BUG_ON(!sg->page);
-		consistent_sync_page(sg->page, sg->offset,
-				     sg->length, direction);
+		__dma_sync_page(sg->page, sg->offset, sg->length, direction);
 		sg->dma_address = page_to_bus(sg->page) + sg->offset;
 	}

@@ -107,50 +151,50 @@
 {
 	BUG_ON(direction == DMA_NONE);

-	consistent_sync(bus_to_virt(dma_handle), size, direction);
+	__dma_sync(bus_to_virt(dma_handle), size, direction);
 }

 static inline void
 dma_sync_single_for_device(struct device *dev, dma_addr_t dma_handle,
-			   size_t size,
-			   enum dma_data_direction direction)
+			size_t size,
+			enum dma_data_direction direction)
 {
 	BUG_ON(direction == DMA_NONE);

-	consistent_sync(bus_to_virt(dma_handle), size, direction);
+	__dma_sync(bus_to_virt(dma_handle), size, direction);
 }

 static inline void
-dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg,
-		    int nelems, enum dma_data_direction direction)
+dma_sync_sg_for_cpu(struct device *dev, struct scatterlist *sg, int nents,
+		    enum dma_data_direction direction)
 {
 	int i;

 	BUG_ON(direction == DMA_NONE);

-	for (i = 0; i < nelems; i++, sg++)
-		consistent_sync_page(sg->page, sg->offset,
-				     sg->length, direction);
+	for (i = 0; i < nents; i++, sg++)
+		__dma_sync_page(sg->page, sg->offset, sg->length, direction);
 }

 static inline void
-dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg,
-		       int nelems, enum dma_data_direction direction)
+dma_sync_sg_for_device(struct device *dev, struct scatterlist *sg, int nents,
+		    enum dma_data_direction direction)
 {
 	int i;

 	BUG_ON(direction == DMA_NONE);

-	for (i = 0; i < nelems; i++, sg++)
-		consistent_sync_page(sg->page, sg->offset,
-				     sg->length, direction);
+	for (i = 0; i < nents; i++, sg++)
+		__dma_sync_page(sg->page, sg->offset, sg->length, direction);
 }

-/* Now for the API extensions over the pci_ one */
-
 #define dma_alloc_noncoherent(d, s, h, f) dma_alloc_coherent(d, s, h, f)
 #define dma_free_noncoherent(d, s, v, h) dma_free_coherent(d, s, v, h)
+#ifdef CONFIG_NOT_COHERENT_CACHE
+#define dma_is_consistent(d)	(0)
+#else
 #define dma_is_consistent(d)	(1)
+#endif

 static inline int dma_get_cache_alignment(void)
 {
@@ -163,26 +207,26 @@

 static inline void
 dma_sync_single_range_for_cpu(struct device *dev, dma_addr_t dma_handle,
-			      unsigned long offset, size_t size,
-			      enum dma_data_direction direction)
+		      	      unsigned long offset, size_t size,
+		      	      enum dma_data_direction direction)
 {
-	/* just sync everything, that's all the pci API can do */
+	/* just sync everything for now */
 	dma_sync_single_for_cpu(dev, dma_handle, offset + size, direction);
 }

 static inline void
 dma_sync_single_range_for_device(struct device *dev, dma_addr_t dma_handle,
-				 unsigned long offset, size_t size,
+		    		 unsigned long offset, size_t size,
 				 enum dma_data_direction direction)
 {
-	/* just sync everything, that's all the pci API can do */
+	/* just sync everything for now */
 	dma_sync_single_for_device(dev, dma_handle, offset + size, direction);
 }

 static inline void dma_cache_sync(void *vaddr, size_t size,
 				  enum dma_data_direction direction)
 {
-	consistent_sync(vaddr, size, (int)direction);
+	__dma_sync(vaddr, size, (int)direction);
 }

 static inline int dma_mapping_error(dma_addr_t dma_addr)
diff -Nru a/include/asm-ppc/io.h b/include/asm-ppc/io.h
--- a/include/asm-ppc/io.h	Fri May 21 11:01:23 2004
+++ b/include/asm-ppc/io.h	Fri May 21 11:01:23 2004
@@ -388,43 +388,5 @@
 	return 0;
 }

-#ifdef CONFIG_NOT_COHERENT_CACHE
-
-/*
- * DMA-consistent mapping functions for PowerPCs that don't support
- * cache snooping.  These allocate/free a region of uncached mapped
- * memory space for use with DMA devices.  Alternatively, you could
- * allocate the space "normally" and use the cache management functions
- * to ensure it is consistent.
- */
-extern void *consistent_alloc(int gfp, size_t size, dma_addr_t *handle);
-extern void consistent_free(void *vaddr);
-extern void consistent_sync(void *vaddr, size_t size, int rw);
-extern void consistent_sync_page(struct page *page, unsigned long offset,
-				 size_t size, int rw);
-
-#define dma_cache_inv(_start,_size) \
-	invalidate_dcache_range(_start, (_start + _size))
-#define dma_cache_wback(_start,_size) \
-	clean_dcache_range(_start, (_start + _size))
-#define dma_cache_wback_inv(_start,_size) \
-	flush_dcache_range(_start, (_start + _size))
-
-#else /* ! CONFIG_NOT_COHERENT_CACHE */
-
-/*
- * Cache coherent cores.
- */
-
-#define dma_cache_inv(_start,_size)		do { } while (0)
-#define dma_cache_wback(_start,_size)		do { } while (0)
-#define dma_cache_wback_inv(_start,_size)	do { } while (0)
-
-#define consistent_alloc(gfp, size, handle)	NULL
-#define consistent_free(addr)			do { } while (0)
-#define consistent_sync(addr, size, rw)		do { } while (0)
-#define consistent_sync_page(pg, off, sz, rw)	do { } while (0)
-
-#endif /* ! CONFIG_NOT_COHERENT_CACHE */
 #endif /* _PPC_IO_H */
 #endif /* __KERNEL__ */
diff -Nru a/include/asm-ppc/kmap_types.h b/include/asm-ppc/kmap_types.h
--- a/include/asm-ppc/kmap_types.h	Fri May 21 11:01:22 2004
+++ b/include/asm-ppc/kmap_types.h	Fri May 21 11:01:22 2004
@@ -16,6 +16,7 @@
 	KM_IRQ1,
 	KM_SOFTIRQ0,
 	KM_SOFTIRQ1,
+	KM_PPC_SYNC_PAGE,
 	KM_TYPE_NR
 };

diff -Nru a/include/asm-ppc/pci.h b/include/asm-ppc/pci.h
--- a/include/asm-ppc/pci.h	Fri May 21 11:01:23 2004
+++ b/include/asm-ppc/pci.h	Fri May 21 11:01:23 2004
@@ -9,6 +9,7 @@
 #include <asm/scatterlist.h>
 #include <asm/io.h>
 #include <asm/pci-bridge.h>
+#include <asm-generic/pci-dma-compat.h>

 struct pci_dev;

@@ -54,246 +55,17 @@
 extern unsigned long pci_phys_to_bus(unsigned long pa, int busnr);
 extern unsigned long pci_bus_to_phys(unsigned int ba, int busnr);

-/*
- * Dynamic DMA Mapping stuff
- * Originally stolen from i386 by ajoshi and updated by paulus
- * Non-consistent cache support by Dan Malek
- */
-
 /* The PCI address space does equal the physical memory
  * address space.  The networking and block device layers use
  * this boolean for bounce buffer decisions.
  */
-#define PCI_DMA_BUS_IS_PHYS	(1)
-
-/* Allocate and map kernel buffer using consistent mode DMA for a device.
- * hwdev should be valid struct pci_dev pointer for PCI devices,
- * NULL for PCI-like buses (ISA, EISA).
- * Returns non-NULL cpu-view pointer to the buffer if successful and
- * sets *dma_addrp to the pci side dma address as well, else *dma_addrp
- * is undefined.
- */
-extern void *pci_alloc_consistent(struct pci_dev *hwdev, size_t size,
-				  dma_addr_t *dma_handle);
-
-/* Free and unmap a consistent DMA buffer.
- * cpu_addr is what was returned from pci_alloc_consistent,
- * size must be the same as what as passed into pci_alloc_consistent,
- * and likewise dma_addr must be the same as what *dma_addrp was set to.
- *
- * References to the memory and mappings associated with cpu_addr/dma_addr
- * past this call are illegal.
- */
-extern void pci_free_consistent(struct pci_dev *hwdev, size_t size,
-				void *vaddr, dma_addr_t dma_handle);
-
-/* Map a single buffer of the indicated size for DMA in streaming mode.
- * The 32-bit bus address to use is returned.
- *
- * Once the device is given the dma address, the device owns this memory
- * until either pci_unmap_single or pci_dma_sync_single_for_cpu is performed.
- */
-static inline dma_addr_t pci_map_single(struct pci_dev *hwdev, void *ptr,
-					size_t size, int direction)
-{
-	BUG_ON(direction == PCI_DMA_NONE);
-
-	consistent_sync(ptr, size, direction);
-
-	return virt_to_bus(ptr);
-}
-
-static inline void pci_unmap_single(struct pci_dev *hwdev, dma_addr_t dma_addr,
-				    size_t size, int direction)
-{
-	BUG_ON(direction == PCI_DMA_NONE);
-	/* nothing to do */
-}
-
-/* pci_unmap_{page,single} is a nop so... */
-#define DECLARE_PCI_UNMAP_ADDR(ADDR_NAME)
-#define DECLARE_PCI_UNMAP_LEN(LEN_NAME)
-#define pci_unmap_addr(PTR, ADDR_NAME)		(0)
-#define pci_unmap_addr_set(PTR, ADDR_NAME, VAL)	do { } while (0)
-#define pci_unmap_len(PTR, LEN_NAME)		(0)
-#define pci_unmap_len_set(PTR, LEN_NAME, VAL)	do { } while (0)
-
-/*
- * pci_{map,unmap}_single_page maps a kernel page to a dma_addr_t. identical
- * to pci_map_single, but takes a struct page instead of a virtual address
- */
-static inline dma_addr_t pci_map_page(struct pci_dev *hwdev, struct page *page,
-				      unsigned long offset, size_t size,
-				      int direction)
-{
-	BUG_ON(direction == PCI_DMA_NONE);
-	consistent_sync_page(page, offset, size, direction);
-	return (page - mem_map) * PAGE_SIZE + PCI_DRAM_OFFSET + offset;
-}
-
-static inline void pci_unmap_page(struct pci_dev *hwdev, dma_addr_t dma_address,
-				  size_t size, int direction)
-{
-	BUG_ON(direction == PCI_DMA_NONE);
-	/* Nothing to do */
-}
-
-/* Map a set of buffers described by scatterlist in streaming
- * mode for DMA.  This is the scather-gather version of the
- * above pci_map_single interface.  Here the scatter gather list
- * elements are each tagged with the appropriate dma address
- * and length.  They are obtained via sg_dma_{address,length}(SG).
- *
- * NOTE: An implementation may be able to use a smaller number of
- *       DMA address/length pairs than there are SG table elements.
- *       (for example via virtual mapping capabilities)
- *       The routine returns the number of addr/length pairs actually
- *       used, at most nents.
- *
- * Device ownership issues as mentioned above for pci_map_single are
- * the same here.
- */
-static inline int pci_map_sg(struct pci_dev *hwdev, struct scatterlist *sg,
-			     int nents, int direction)
-{
-	int i;
-
-	BUG_ON(direction == PCI_DMA_NONE);
-
-	/*
-	 * temporary 2.4 hack
-	 */
-	for (i = 0; i < nents; i++, sg++) {
-		BUG_ON(!sg->page);
-		consistent_sync_page(sg->page, sg->offset,
-				     sg->length, direction);
-		sg->dma_address = page_to_bus(sg->page) + sg->offset;
-	}
-
-	return nents;
-}
-
-/* Unmap a set of streaming mode DMA translations.
- * Again, cpu read rules concerning calls here are the same as for
- * pci_unmap_single() above.
- */
-static inline void pci_unmap_sg(struct pci_dev *hwdev, struct scatterlist *sg,
-				int nents, int direction)
-{
-	BUG_ON(direction == PCI_DMA_NONE);
-	/* nothing to do */
-}
-
-/* Make physical memory consistent for a single
- * streaming mode DMA translation after a transfer.
- *
- * If you perform a pci_map_single() but wish to interrogate the
- * buffer using the cpu, yet do not wish to teardown the PCI dma
- * mapping, you must call this function before doing so.  At the
- * next point you give the PCI dma address back to the card, you
- * must first perform a pci_dma_sync_for_device, and then the device
- * again owns the buffer.
- */
-static inline void pci_dma_sync_single_for_cpu(struct pci_dev *hwdev,
-					       dma_addr_t dma_handle,
-					       size_t size, int direction)
-{
-	BUG_ON(direction == PCI_DMA_NONE);
-
-	consistent_sync(bus_to_virt(dma_handle), size, direction);
-}
-
-static inline void pci_dma_sync_single_for_device(struct pci_dev *hwdev,
-						  dma_addr_t dma_handle,
-						  size_t size, int direction)
-{
-	BUG_ON(direction == PCI_DMA_NONE);
-
-	consistent_sync(bus_to_virt(dma_handle), size, direction);
-}
-
-/* Make physical memory consistent for a set of streaming
- * mode DMA translations after a transfer.
- *
- * The same as pci_dma_sync_single_for_* but for a scatter-gather list,
- * same rules and usage.
- */
-static inline void pci_dma_sync_sg_for_cpu(struct pci_dev *hwdev,
-					   struct scatterlist *sg,
-					   int nelems, int direction)
-{
-	int i;
-
-	BUG_ON(direction == PCI_DMA_NONE);
-
-	for (i = 0; i < nelems; i++, sg++)
-		consistent_sync_page(sg->page, sg->offset,
-				     sg->length, direction);
-}
-
-static inline void pci_dma_sync_sg_for_device(struct pci_dev *hwdev,
-					      struct scatterlist *sg,
-					      int nelems, int direction)
-{
-	int i;
-
-	BUG_ON(direction == PCI_DMA_NONE);
-
-	for (i = 0; i < nelems; i++, sg++)
-		consistent_sync_page(sg->page, sg->offset,
-				     sg->length, direction);
-}
-
-/* Return whether the given PCI device DMA address mask can
- * be supported properly.  For example, if your device can
- * only drive the low 24-bits during PCI bus mastering, then
- * you would pass 0x00ffffff as the mask to this function.
- */
-static inline int pci_dma_supported(struct pci_dev *hwdev, u64 mask)
-{
-	return 1;
-}
+#define PCI_DMA_BUS_IS_PHYS     (1)

 /*
  * At present there are very few 32-bit PPC machines that can have
  * memory above the 4GB point, and we don't support that.
  */
 #define pci_dac_dma_supported(pci_dev, mask)	(0)
-
-static inline dma64_addr_t
-pci_dac_page_to_dma(struct pci_dev *pdev, struct page *page, unsigned long offset, int direction)
-{
-	return (dma64_addr_t) page_to_bus(page) + offset;
-}
-
-static inline struct page *
-pci_dac_dma_to_page(struct pci_dev *pdev, dma64_addr_t dma_addr)
-{
-	return mem_map + (unsigned long)(dma_addr >> PAGE_SHIFT);
-}
-
-static inline unsigned long
-pci_dac_dma_to_offset(struct pci_dev *pdev, dma64_addr_t dma_addr)
-{
-	return (dma_addr & ~PAGE_MASK);
-}
-
-static inline void
-pci_dac_dma_sync_single_for_cpu(struct pci_dev *pdev, dma64_addr_t dma_addr, size_t len, int direction)
-{
-	/* Nothing to do. */
-}
-
-static inline void
-pci_dac_dma_sync_single_for_device(struct pci_dev *pdev, dma64_addr_t dma_addr, size_t len, int direction)
-{
-	/* Nothing to do. */
-}
-
-static inline int pci_dma_mapping_error(dma_addr_t dma_addr)
-{
-	return 0;
-}

 /* Return the index of the PCI controller for device PDEV. */
 #define pci_domain_nr(bus) ((struct pci_controller *)(bus)->sysdata)->index

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
