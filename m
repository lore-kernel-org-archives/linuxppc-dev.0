Return-Path: <alistair@popple.id.au>
Received: from ipmail06.adl2.internode.on.net (ipmail06.adl2.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:2:6])
 by ozlabs.org (Postfix) with ESMTP id 2730A2C037A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Oct 2013 13:54:51 +1000 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] iommu: Add support for iommu page sizes other than 4K
Date: Tue,  1 Oct 2013 13:54:09 +1000
Message-Id: <1380599650-9541-2-git-send-email-alistair@popple.id.au>
In-Reply-To: <1380599650-9541-1-git-send-email-alistair@popple.id.au>
References: <1380599650-9541-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently the iommu uses hardcoded pages sizes of 4K even though some
hardware supports other page sizes. This patch adds a field (it_page_shift)
to struct iommu_table to support different page sizes and updates the generic
iommu code to use that field.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/include/asm/iommu.h |   28 ++++++++++-------
 arch/powerpc/kernel/dma-iommu.c  |    4 +--
 arch/powerpc/kernel/iommu.c      |   64 +++++++++++++++++++-------------------
 3 files changed, 51 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index c34656a..e412a15 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -30,22 +30,19 @@
 #include <asm/machdep.h>
 #include <asm/types.h>
 
-#define IOMMU_PAGE_SHIFT      12
-#define IOMMU_PAGE_SIZE       (ASM_CONST(1) << IOMMU_PAGE_SHIFT)
-#define IOMMU_PAGE_MASK       (~((1 << IOMMU_PAGE_SHIFT) - 1))
-#define IOMMU_PAGE_ALIGN(addr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE)
+#define IOMMU_PAGE_SIZE(tblptr) (ASM_CONST(1) << (tblptr)->it_page_shift)
+#define IOMMU_PAGE_MASK(tblptr) (~((1 << (tblptr)->it_page_shift) - 1))
+#define IOMMU_PAGE_ALIGN(addr, tblptr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE(tblptr))
+
+#define IOMMU_PAGE_SHIFT_4K	(12)
+#define IOMMU_PAGE_SIZE_4K	(ASM_CONST(1) << 12)
+#define IOMMU_PAGE_MASK_4k	(~((1 << 12) - 1))
+#define IOMMU_PAGE_ALIGN_4K(addr)	_ALIGN_UP(addr, IOMMU_PAGE_SIZE_4K)
 
 /* Boot time flags */
 extern int iommu_is_off;
 extern int iommu_force_on;
 
-/* Pure 2^n version of get_order */
-static __inline__ __attribute_const__ int get_iommu_order(unsigned long size)
-{
-	return __ilog2((size - 1) >> IOMMU_PAGE_SHIFT) + 1;
-}
-
-
 /*
  * IOMAP_MAX_ORDER defines the largest contiguous block
  * of dma space we can get.  IOMAP_MAX_ORDER = 13
@@ -76,11 +73,20 @@ struct iommu_table {
 	struct iommu_pool large_pool;
 	struct iommu_pool pools[IOMMU_NR_POOLS];
 	unsigned long *it_map;       /* A simple allocation bitmap for now */
+	unsigned long  it_page_shift;/* table iommu page size */
 #ifdef CONFIG_IOMMU_API
 	struct iommu_group *it_group;
 #endif
 };
 
+/* Pure 2^n version of get_order */
+static inline __attribute_const__
+int get_iommu_order(unsigned long size, struct iommu_table *tbl)
+{
+	return __ilog2((size - 1) >> tbl->it_page_shift) + 1;
+}
+
+
 struct scatterlist;
 
 static inline void set_iommu_table_base(struct device *dev, void *base)
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index e489752..54d0116 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -83,10 +83,10 @@ static int dma_iommu_dma_supported(struct device *dev, u64 mask)
 		return 0;
 	}
 
-	if (tbl->it_offset > (mask >> IOMMU_PAGE_SHIFT)) {
+	if (tbl->it_offset > (mask >> tbl->it_page_shift)) {
 		dev_info(dev, "Warning: IOMMU offset too big for device mask\n");
 		dev_info(dev, "mask: 0x%08llx, table offset: 0x%08lx\n",
-				mask, tbl->it_offset << IOMMU_PAGE_SHIFT);
+				mask, tbl->it_offset << tbl->it_page_shift);
 		return 0;
 	} else
 		return 1;
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index b20ff17..38f6e0c 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -251,14 +251,13 @@ again:
 
 	if (dev)
 		boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
-				      1 << IOMMU_PAGE_SHIFT);
+				      1 << tbl->it_page_shift);
 	else
-		boundary_size = ALIGN(1UL << 32, 1 << IOMMU_PAGE_SHIFT);
+		boundary_size = ALIGN(1UL << 32, 1 << tbl->it_page_shift);
 	/* 4GB boundary for iseries_hv_alloc and iseries_hv_map */
 
-	n = iommu_area_alloc(tbl->it_map, limit, start, npages,
-			     tbl->it_offset, boundary_size >> IOMMU_PAGE_SHIFT,
-			     align_mask);
+	n = iommu_area_alloc(tbl->it_map, limit, start, npages, tbl->it_offset,
+			     boundary_size >> tbl->it_page_shift, align_mask);
 	if (n == -1) {
 		if (likely(pass == 0)) {
 			/* First try the pool from the start */
@@ -320,12 +319,12 @@ static dma_addr_t iommu_alloc(struct device *dev, struct iommu_table *tbl,
 		return DMA_ERROR_CODE;
 
 	entry += tbl->it_offset;	/* Offset into real TCE table */
-	ret = entry << IOMMU_PAGE_SHIFT;	/* Set the return dma address */
+	ret = entry << tbl->it_page_shift;	/* Set the return dma address */
 
 	/* Put the TCEs in the HW table */
 	build_fail = ppc_md.tce_build(tbl, entry, npages,
-	                              (unsigned long)page & IOMMU_PAGE_MASK,
-	                              direction, attrs);
+				      (unsigned long)page &
+				      IOMMU_PAGE_MASK(tbl), direction, attrs);
 
 	/* ppc_md.tce_build() only returns non-zero for transient errors.
 	 * Clean up the table bitmap in this case and return
@@ -352,7 +351,7 @@ static bool iommu_free_check(struct iommu_table *tbl, dma_addr_t dma_addr,
 {
 	unsigned long entry, free_entry;
 
-	entry = dma_addr >> IOMMU_PAGE_SHIFT;
+	entry = dma_addr >> tbl->it_page_shift;
 	free_entry = entry - tbl->it_offset;
 
 	if (((free_entry + npages) > tbl->it_size) ||
@@ -401,7 +400,7 @@ static void __iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
 	unsigned long flags;
 	struct iommu_pool *pool;
 
-	entry = dma_addr >> IOMMU_PAGE_SHIFT;
+	entry = dma_addr >> tbl->it_page_shift;
 	free_entry = entry - tbl->it_offset;
 
 	pool = get_pool(tbl, free_entry);
@@ -468,13 +467,13 @@ int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 		}
 		/* Allocate iommu entries for that segment */
 		vaddr = (unsigned long) sg_virt(s);
-		npages = iommu_num_pages(vaddr, slen, IOMMU_PAGE_SIZE);
+		npages = iommu_num_pages(vaddr, slen, IOMMU_PAGE_SIZE(tbl));
 		align = 0;
-		if (IOMMU_PAGE_SHIFT < PAGE_SHIFT && slen >= PAGE_SIZE &&
+		if (tbl->it_page_shift < PAGE_SHIFT && slen >= PAGE_SIZE &&
 		    (vaddr & ~PAGE_MASK) == 0)
-			align = PAGE_SHIFT - IOMMU_PAGE_SHIFT;
+			align = PAGE_SHIFT - tbl->it_page_shift;
 		entry = iommu_range_alloc(dev, tbl, npages, &handle,
-					  mask >> IOMMU_PAGE_SHIFT, align);
+					  mask >> tbl->it_page_shift, align);
 
 		DBG("  - vaddr: %lx, size: %lx\n", vaddr, slen);
 
@@ -489,16 +488,16 @@ int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 
 		/* Convert entry to a dma_addr_t */
 		entry += tbl->it_offset;
-		dma_addr = entry << IOMMU_PAGE_SHIFT;
-		dma_addr |= (s->offset & ~IOMMU_PAGE_MASK);
+		dma_addr = entry << tbl->it_page_shift;
+		dma_addr |= (s->offset & ~IOMMU_PAGE_MASK(tbl));
 
 		DBG("  - %lu pages, entry: %lx, dma_addr: %lx\n",
 			    npages, entry, dma_addr);
 
 		/* Insert into HW table */
 		build_fail = ppc_md.tce_build(tbl, entry, npages,
-		                              vaddr & IOMMU_PAGE_MASK,
-		                              direction, attrs);
+					      vaddr & IOMMU_PAGE_MASK(tbl),
+					      direction, attrs);
 		if(unlikely(build_fail))
 			goto failure;
 
@@ -559,9 +558,9 @@ int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 		if (s->dma_length != 0) {
 			unsigned long vaddr, npages;
 
-			vaddr = s->dma_address & IOMMU_PAGE_MASK;
+			vaddr = s->dma_address & IOMMU_PAGE_MASK(tbl);
 			npages = iommu_num_pages(s->dma_address, s->dma_length,
-						 IOMMU_PAGE_SIZE);
+						 IOMMU_PAGE_SIZE(tbl));
 			__iommu_free(tbl, vaddr, npages);
 			s->dma_address = DMA_ERROR_CODE;
 			s->dma_length = 0;
@@ -592,7 +591,7 @@ void iommu_unmap_sg(struct iommu_table *tbl, struct scatterlist *sglist,
 		if (sg->dma_length == 0)
 			break;
 		npages = iommu_num_pages(dma_handle, sg->dma_length,
-					 IOMMU_PAGE_SIZE);
+					 IOMMU_PAGE_SIZE(tbl));
 		__iommu_free(tbl, dma_handle, npages);
 		sg = sg_next(sg);
 	}
@@ -676,7 +675,7 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 		set_bit(0, tbl->it_map);
 
 	/* We only split the IOMMU table if we have 1GB or more of space */
-	if ((tbl->it_size << IOMMU_PAGE_SHIFT) >= (1UL * 1024 * 1024 * 1024))
+	if ((tbl->it_size << tbl->it_page_shift) >= (1UL * 1024 * 1024 * 1024))
 		tbl->nr_pools = IOMMU_NR_POOLS;
 	else
 		tbl->nr_pools = 1;
@@ -768,16 +767,16 @@ dma_addr_t iommu_map_page(struct device *dev, struct iommu_table *tbl,
 
 	vaddr = page_address(page) + offset;
 	uaddr = (unsigned long)vaddr;
-	npages = iommu_num_pages(uaddr, size, IOMMU_PAGE_SIZE);
+	npages = iommu_num_pages(uaddr, size, IOMMU_PAGE_SIZE(tbl));
 
 	if (tbl) {
 		align = 0;
-		if (IOMMU_PAGE_SHIFT < PAGE_SHIFT && size >= PAGE_SIZE &&
+		if (tbl->it_page_shift < PAGE_SHIFT && size >= PAGE_SIZE &&
 		    ((unsigned long)vaddr & ~PAGE_MASK) == 0)
-			align = PAGE_SHIFT - IOMMU_PAGE_SHIFT;
+			align = PAGE_SHIFT - tbl->it_page_shift;
 
 		dma_handle = iommu_alloc(dev, tbl, vaddr, npages, direction,
-					 mask >> IOMMU_PAGE_SHIFT, align,
+					 mask >> tbl->it_page_shift, align,
 					 attrs);
 		if (dma_handle == DMA_ERROR_CODE) {
 			if (printk_ratelimit())  {
@@ -786,7 +785,7 @@ dma_addr_t iommu_map_page(struct device *dev, struct iommu_table *tbl,
 					 npages);
 			}
 		} else
-			dma_handle |= (uaddr & ~IOMMU_PAGE_MASK);
+			dma_handle |= (uaddr & ~IOMMU_PAGE_MASK(tbl));
 	}
 
 	return dma_handle;
@@ -801,7 +800,8 @@ void iommu_unmap_page(struct iommu_table *tbl, dma_addr_t dma_handle,
 	BUG_ON(direction == DMA_NONE);
 
 	if (tbl) {
-		npages = iommu_num_pages(dma_handle, size, IOMMU_PAGE_SIZE);
+		npages = iommu_num_pages(dma_handle, size,
+					 IOMMU_PAGE_SIZE(tbl));
 		iommu_free(tbl, dma_handle, npages);
 	}
 }
@@ -845,10 +845,10 @@ void *iommu_alloc_coherent(struct device *dev, struct iommu_table *tbl,
 	memset(ret, 0, size);
 
 	/* Set up tces to cover the allocated range */
-	nio_pages = size >> IOMMU_PAGE_SHIFT;
-	io_order = get_iommu_order(size);
+	nio_pages = size >> tbl->it_page_shift;
+	io_order = get_iommu_order(size, tbl);
 	mapping = iommu_alloc(dev, tbl, ret, nio_pages, DMA_BIDIRECTIONAL,
-			      mask >> IOMMU_PAGE_SHIFT, io_order, NULL);
+			      mask >> tbl->it_page_shift, io_order, NULL);
 	if (mapping == DMA_ERROR_CODE) {
 		free_pages((unsigned long)ret, order);
 		return NULL;
@@ -864,7 +864,7 @@ void iommu_free_coherent(struct iommu_table *tbl, size_t size,
 		unsigned int nio_pages;
 
 		size = PAGE_ALIGN(size);
-		nio_pages = size >> IOMMU_PAGE_SHIFT;
+		nio_pages = size >> tbl->it_page_shift;
 		iommu_free(tbl, dma_handle, nio_pages);
 		size = PAGE_ALIGN(size);
 		free_pages((unsigned long)vaddr, get_order(size));
-- 
1.7.10.4
