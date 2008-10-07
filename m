Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 646E9DDF09
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 08:05:18 +1100 (EST)
Subject: [PATCH 1/3] powerpc: dma code cleanup
From: Remi Machet <rmachet@slac.stanford.edu>
To: Linux PPC <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 07 Oct 2008 14:05:04 -0700
Message-Id: <1223413504.17585.28.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

New dma-noncoherent code. This is a full rewrite of
arch/powerpc/lib/dma-noncoherent.c.

The old code in arch/powerpc/lib/dma-noncoherent.c uses a memory pool at
a hard coded virtual address set by CONFIG_CONSISTENT_START (typically
0xFF100000). If not set carefully this address can conflict with early
ioremap in systems that enable HIGHMEM, on top of that the code is overly
complex because it needs to have its own memory manager.
The new code uses standard memory management APIs, does not require the
user to set CONFIG_CONSISTENT_START or CONFIG_CONSISTENT_SIZE, is much
smaller and simplier. It also can allocate as much memory as needed
(instead of being limited by CONFIG_CONSISTENT_SIZE).

This version of the code supports high memory (even in dma_alloc_coherent).

Signed-off-by: Remi Machet <rmachet@slac.stanford.edu>
---

 Makefile          |    1
 dma-noncoherent.c |  284 ++++++++++++++++++++++++++++++++++++++++++++++++++++++
 2 files changed, 285 insertions(+)

diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index fdb5825..9754157 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -60,6 +60,7 @@ obj-$(CONFIG_HIBERNATION)	+= swsusp.o suspend.o \
 obj64-$(CONFIG_HIBERNATION)	+= swsusp_asm64.o
 obj-$(CONFIG_MODULES)		+= module.o module_$(CONFIG_WORD_SIZE).o
 obj-$(CONFIG_44x)		+= cpu_setup_44x.o
+obj-$(CONFIG_NOT_COHERENT_CACHE)+= dma-noncoherent.o
 
 extra-$(CONFIG_PPC_STD_MMU)	:= head_32.o
 extra-$(CONFIG_PPC64)		:= head_64.o
diff --git a/arch/powerpc/kernel/dma-noncoherent.c b/arch/powerpc/kernel/dma-noncoherent.c
new file mode 100644
index 0000000..6a517f3
--- /dev/null
+++ b/arch/powerpc/kernel/dma-noncoherent.c
@@ -0,0 +1,284 @@
+/*
+ * Copyright (C) 2008 Remi Machet, Stanford University
+ *
+ * Provide default implementations of the DMA mapping callbacks for
+ * directly mapped busses that have non-coherent memory.
+ */
+
+#include <linux/device.h>
+#include <linux/dma-mapping.h>
+#include <linux/highmem.h>
+#include <linux/bug.h>
+#include <asm/abs_addr.h>
+#include <asm/tlbflush.h>
+
+/*
+ * Direct DMA implementation for non-coherent architectures
+ *
+ * This implementation supports a per-device offset that can be applied if
+ * the address at which memory is visible to devices is not 0. Platform code
+ * can set archdata.dma_data to an unsigned long holding the offset. By
+ * default the offset is PCI_DRAM_OFFSET.
+ */
+
+static unsigned long get_dma_noncoherent_direct_offset(struct device *dev)
+{
+	if (dev)
+		return (unsigned long)dev->archdata.dma_data;
+
+	return PCI_DRAM_OFFSET;
+}
+
+/*
+ * dma_noncoherent_sync makes memory consistent.
+ */
+static void sync_vaddr(struct device *dev, unsigned long vaddr,
+	size_t size, enum dma_data_direction direction)
+{
+	unsigned long start = vaddr;
+	unsigned long end   = start + size;
+	int unaligned;
+
+	switch (direction) {
+	case DMA_NONE:
+		BUG();
+	case DMA_FROM_DEVICE:
+		/*
+		 * if start or size is not cache aligned we flush before
+		 * invalidating.
+		 * Beware: flush_dcache_range does flush and invalidate
+		 */
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
+/*
+ * dma_noncoherent_sync_page makes memory consistent.
+ */
+void dma_noncoherent_sync(struct device *dev, dma_addr_t dma_address,
+				size_t size, enum dma_data_direction direction)
+{
+	struct page *page;
+	unsigned long vaddr;
+	unsigned long offset;
+
+	page = pfn_to_page((dma_address
+				- get_dma_noncoherent_direct_offset(dev))
+				>> PAGE_SHIFT);
+	vaddr = (unsigned long)page_address(page);
+	offset = dma_address & (PAGE_SIZE-1);
+	/* vaddr will be 0 if the page is not mapped => we do a
+		temporary mapping */
+	if (vaddr == 0) {
+		while (size != 0) {
+			int tosync = size < PAGE_SIZE ? size : PAGE_SIZE;
+			vaddr = (unsigned long)kmap_atomic(page,
+							KM_PPC_SYNC_PAGE)
+							+ offset;
+			tosync -= offset;
+			sync_vaddr(dev, vaddr + offset, tosync, direction);
+			kunmap_atomic((void *)vaddr, KM_PPC_SYNC_PAGE);
+			size -= tosync;
+			page++;
+			offset = 0;	/* Only used in the first loop */
+		}
+	} else {
+		sync_vaddr(dev, vaddr + offset, size, direction);
+	}
+}
+
+void *dma_noncoherent_alloc(struct device *dev, size_t size,
+				dma_addr_t *dma_handle, gfp_t flag)
+{
+	struct page *page, *p;
+	unsigned long order;
+	unsigned long kaddr;
+	unsigned long addr;
+	u64 mask = 0x00ffffff, limit; /* ISA default */
+
+	size = PAGE_ALIGN(size);
+	limit = (mask + 1) & ~mask;
+	if (limit && size >= limit) {
+		printk(KERN_WARNING "coherent allocation too big " \
+			"(requested %#x mask %#Lx)\n", size, mask);
+		return NULL;
+	}
+
+	order = get_order(size);
+
+	if (mask != 0xffffffff)
+		flag |= GFP_DMA;
+
+	page = alloc_pages(flag, order);
+	if (!page)
+		return NULL;
+
+	/*
+	 * Make sure the page is mapped in virtual memory.
+	 * if it is kmap will return the virtual address,
+	 * otherwise it will create a permanent mapping.
+	 */
+	kaddr = (unsigned long)kmap(page);
+
+	/*
+	 * Invalidate any data that might be lurking in the
+	 * kernel direct-mapped region for device DMA.
+	 * the name is confusing here: flush_dcache_range does a
+	 * flush + invalidate.
+	 */
+	flush_dcache_range(kaddr, kaddr + size);
+
+	/*
+	 * Out of the returned page generate a table of 1<<order
+	 * PAGE_SIZE pages. This make sure each page has its own PTE.
+	 */
+	split_page(page, order);
+
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
+	}
+	flush_tlb_kernel_range(kaddr, kaddr+size-1);
+
+	/* Handle is the physical address of the first page */
+	*dma_handle = page_to_phys(page)
+				+ get_dma_noncoherent_direct_offset(dev);
+
+	return (void *)kaddr;
+}
+
+void dma_noncoherent_free(struct device *dev, size_t size,
+			      void *vaddr, dma_addr_t dma_handle)
+{
+	struct page *page;
+	unsigned long order;
+	unsigned long addr;
+
+	/* This is safe because we do the same in __dma_alloc_coherent */
+	size = PAGE_ALIGN(size);
+	order = get_order(size);
+
+	/*
+	 * Retrieve the page associated with this address
+	 * It is safer to convert dma_handle to a page versus
+	 * virt_to_page(vaddr) because virt_to_page won't work
+	 * with high memory.
+	 */
+	page = pfn_to_page((dma_handle -
+				get_dma_noncoherent_direct_offset(dev))
+				>> PAGE_SHIFT);
+
+	/* If the page is in high memory, release the virtual mapping */
+	kunmap(page);
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
+	}
+}
+
+static int dma_noncoherent_map_sg(struct device *dev, struct scatterlist *sgl,
+			     int nents, enum dma_data_direction direction,
+			     struct dma_attrs *attrs)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i) {
+		sg->dma_address = sg_phys(sg)
+				+ get_dma_noncoherent_direct_offset(dev);
+		sg->dma_length = sg->length;
+	}
+
+	return nents;
+}
+
+static void dma_noncoherent_unmap_sg(struct device *dev, struct scatterlist *sg,
+				int nents, enum dma_data_direction direction,
+				struct dma_attrs *attrs)
+{
+}
+
+static int dma_noncoherent_dma_supported(struct device *dev, u64 mask)
+{
+#ifdef CONFIG_PPC64
+	/* Could be improved to check for memory though it better be
+	 * done via some global so platforms can set the limit in case
+	 * they have limited DMA windows
+	 */
+	return mask >= DMA_32BIT_MASK;
+#else
+	return 1;
+#endif
+}
+
+static inline dma_addr_t dma_noncoherent_map_page(struct device *dev,
+					     struct page *page,
+					     unsigned long offset,
+					     size_t size,
+					     enum dma_data_direction dir,
+					     struct dma_attrs *attrs)
+{
+	dma_addr_t dma_handle = page_to_phys(page) + offset
+				+ get_dma_noncoherent_direct_offset(dev);
+	dma_noncoherent_sync(dev, dma_handle, size, dir);
+	return dma_handle;
+}
+
+static inline void dma_noncoherent_unmap_page(struct device *dev,
+					 dma_addr_t dma_address,
+					 size_t size,
+					 enum dma_data_direction direction,
+					 struct dma_attrs *attrs)
+{
+}
+
+struct dma_mapping_ops dma_noncoherent_direct_ops = {
+	.alloc_coherent	= dma_noncoherent_alloc,
+	.free_coherent	= dma_noncoherent_free,
+	.map_sg		= dma_noncoherent_map_sg,
+	.unmap_sg	= dma_noncoherent_unmap_sg,
+	.dma_supported	= dma_noncoherent_dma_supported,
+	.map_page	= dma_noncoherent_map_page,
+	.unmap_page	= dma_noncoherent_unmap_page,
+	.sync		= dma_noncoherent_sync,
+};
+EXPORT_SYMBOL(dma_noncoherent_direct_ops);
