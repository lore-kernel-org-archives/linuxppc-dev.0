Return-Path: <alistair@popple.id.au>
Received: from ipmail07.adl2.internode.on.net (ipmail07.adl2.internode.on.net
 [IPv6:2001:44b8:8060:ff02:300:1:2:7])
 by ozlabs.org (Postfix) with ESMTP id 15E5D2C0185
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 15:22:09 +1100 (EST)
From: Alistair Popple <alistair@popple.id.au>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/3] powerpc iommu: Update constant names to reflect their
 hardcoded page size
Date: Mon, 11 Nov 2013 15:22:07 +1100
Message-Id: <1384143729-14491-2-git-send-email-alistair@popple.id.au>
In-Reply-To: <1384143729-14491-1-git-send-email-alistair@popple.id.au>
References: <1384143729-14491-1-git-send-email-alistair@popple.id.au>
Cc: Alistair Popple <alistair@popple.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The powerpc iommu uses a hardcoded page size of 4K. This patch changes
the name of the IOMMU_PAGE_* macros to reflect the hardcoded values. A
future patch will use the existing names to support dynamic page
sizes.

Signed-off-by: Alistair Popple <alistair@popple.id.au>
---
 arch/powerpc/include/asm/iommu.h       |   10 ++--
 arch/powerpc/kernel/dma-iommu.c        |    4 +-
 arch/powerpc/kernel/iommu.c            |   80 ++++++++++++++++----------------
 arch/powerpc/kernel/vio.c              |   19 ++++----
 arch/powerpc/platforms/powernv/pci.c   |    2 +-
 arch/powerpc/platforms/pseries/iommu.c |    8 ++--
 arch/powerpc/platforms/pseries/setup.c |    4 +-
 drivers/net/ethernet/ibm/ibmveth.c     |    9 ++--
 8 files changed, 69 insertions(+), 67 deletions(-)

diff --git a/arch/powerpc/include/asm/iommu.h b/arch/powerpc/include/asm/iommu.h
index c34656a..e53de39 100644
--- a/arch/powerpc/include/asm/iommu.h
+++ b/arch/powerpc/include/asm/iommu.h
@@ -30,10 +30,10 @@
 #include <asm/machdep.h>
 #include <asm/types.h>
 
-#define IOMMU_PAGE_SHIFT      12
-#define IOMMU_PAGE_SIZE       (ASM_CONST(1) << IOMMU_PAGE_SHIFT)
-#define IOMMU_PAGE_MASK       (~((1 << IOMMU_PAGE_SHIFT) - 1))
-#define IOMMU_PAGE_ALIGN(addr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE)
+#define IOMMU_PAGE_SHIFT_4K      12
+#define IOMMU_PAGE_SIZE_4K       (ASM_CONST(1) << IOMMU_PAGE_SHIFT_4K)
+#define IOMMU_PAGE_MASK_4K       (~((1 << IOMMU_PAGE_SHIFT_4K) - 1))
+#define IOMMU_PAGE_ALIGN_4K(addr) _ALIGN_UP(addr, IOMMU_PAGE_SIZE_4K)
 
 /* Boot time flags */
 extern int iommu_is_off;
@@ -42,7 +42,7 @@ extern int iommu_force_on;
 /* Pure 2^n version of get_order */
 static __inline__ __attribute_const__ int get_iommu_order(unsigned long size)
 {
-	return __ilog2((size - 1) >> IOMMU_PAGE_SHIFT) + 1;
+	return __ilog2((size - 1) >> IOMMU_PAGE_SHIFT_4K) + 1;
 }
 
 
diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index e489752..5cfe3db 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -83,10 +83,10 @@ static int dma_iommu_dma_supported(struct device *dev, u64 mask)
 		return 0;
 	}
 
-	if (tbl->it_offset > (mask >> IOMMU_PAGE_SHIFT)) {
+	if (tbl->it_offset > (mask >> IOMMU_PAGE_SHIFT_4K)) {
 		dev_info(dev, "Warning: IOMMU offset too big for device mask\n");
 		dev_info(dev, "mask: 0x%08llx, table offset: 0x%08lx\n",
-				mask, tbl->it_offset << IOMMU_PAGE_SHIFT);
+				mask, tbl->it_offset << IOMMU_PAGE_SHIFT_4K);
 		return 0;
 	} else
 		return 1;
diff --git a/arch/powerpc/kernel/iommu.c b/arch/powerpc/kernel/iommu.c
index 572bb5b..6bc5d14 100644
--- a/arch/powerpc/kernel/iommu.c
+++ b/arch/powerpc/kernel/iommu.c
@@ -251,14 +251,14 @@ again:
 
 	if (dev)
 		boundary_size = ALIGN(dma_get_seg_boundary(dev) + 1,
-				      1 << IOMMU_PAGE_SHIFT);
+				      1 << IOMMU_PAGE_SHIFT_4K);
 	else
-		boundary_size = ALIGN(1UL << 32, 1 << IOMMU_PAGE_SHIFT);
+		boundary_size = ALIGN(1UL << 32, 1 << IOMMU_PAGE_SHIFT_4K);
 	/* 4GB boundary for iseries_hv_alloc and iseries_hv_map */
 
 	n = iommu_area_alloc(tbl->it_map, limit, start, npages,
-			     tbl->it_offset, boundary_size >> IOMMU_PAGE_SHIFT,
-			     align_mask);
+			tbl->it_offset, boundary_size >> IOMMU_PAGE_SHIFT_4K,
+			align_mask);
 	if (n == -1) {
 		if (likely(pass == 0)) {
 			/* First try the pool from the start */
@@ -320,12 +320,12 @@ static dma_addr_t iommu_alloc(struct device *dev, struct iommu_table *tbl,
 		return DMA_ERROR_CODE;
 
 	entry += tbl->it_offset;	/* Offset into real TCE table */
-	ret = entry << IOMMU_PAGE_SHIFT;	/* Set the return dma address */
+	ret = entry << IOMMU_PAGE_SHIFT_4K;	/* Set the return dma address */
 
 	/* Put the TCEs in the HW table */
 	build_fail = ppc_md.tce_build(tbl, entry, npages,
-	                              (unsigned long)page & IOMMU_PAGE_MASK,
-	                              direction, attrs);
+				(unsigned long)page & IOMMU_PAGE_MASK_4K,
+				direction, attrs);
 
 	/* ppc_md.tce_build() only returns non-zero for transient errors.
 	 * Clean up the table bitmap in this case and return
@@ -352,7 +352,7 @@ static bool iommu_free_check(struct iommu_table *tbl, dma_addr_t dma_addr,
 {
 	unsigned long entry, free_entry;
 
-	entry = dma_addr >> IOMMU_PAGE_SHIFT;
+	entry = dma_addr >> IOMMU_PAGE_SHIFT_4K;
 	free_entry = entry - tbl->it_offset;
 
 	if (((free_entry + npages) > tbl->it_size) ||
@@ -401,7 +401,7 @@ static void __iommu_free(struct iommu_table *tbl, dma_addr_t dma_addr,
 	unsigned long flags;
 	struct iommu_pool *pool;
 
-	entry = dma_addr >> IOMMU_PAGE_SHIFT;
+	entry = dma_addr >> IOMMU_PAGE_SHIFT_4K;
 	free_entry = entry - tbl->it_offset;
 
 	pool = get_pool(tbl, free_entry);
@@ -468,13 +468,13 @@ int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 		}
 		/* Allocate iommu entries for that segment */
 		vaddr = (unsigned long) sg_virt(s);
-		npages = iommu_num_pages(vaddr, slen, IOMMU_PAGE_SIZE);
+		npages = iommu_num_pages(vaddr, slen, IOMMU_PAGE_SIZE_4K);
 		align = 0;
-		if (IOMMU_PAGE_SHIFT < PAGE_SHIFT && slen >= PAGE_SIZE &&
+		if (IOMMU_PAGE_SHIFT_4K < PAGE_SHIFT && slen >= PAGE_SIZE &&
 		    (vaddr & ~PAGE_MASK) == 0)
-			align = PAGE_SHIFT - IOMMU_PAGE_SHIFT;
+			align = PAGE_SHIFT - IOMMU_PAGE_SHIFT_4K;
 		entry = iommu_range_alloc(dev, tbl, npages, &handle,
-					  mask >> IOMMU_PAGE_SHIFT, align);
+					  mask >> IOMMU_PAGE_SHIFT_4K, align);
 
 		DBG("  - vaddr: %lx, size: %lx\n", vaddr, slen);
 
@@ -489,16 +489,16 @@ int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 
 		/* Convert entry to a dma_addr_t */
 		entry += tbl->it_offset;
-		dma_addr = entry << IOMMU_PAGE_SHIFT;
-		dma_addr |= (s->offset & ~IOMMU_PAGE_MASK);
+		dma_addr = entry << IOMMU_PAGE_SHIFT_4K;
+		dma_addr |= (s->offset & ~IOMMU_PAGE_MASK_4K);
 
 		DBG("  - %lu pages, entry: %lx, dma_addr: %lx\n",
 			    npages, entry, dma_addr);
 
 		/* Insert into HW table */
 		build_fail = ppc_md.tce_build(tbl, entry, npages,
-		                              vaddr & IOMMU_PAGE_MASK,
-		                              direction, attrs);
+					vaddr & IOMMU_PAGE_MASK_4K,
+					direction, attrs);
 		if(unlikely(build_fail))
 			goto failure;
 
@@ -559,9 +559,9 @@ int iommu_map_sg(struct device *dev, struct iommu_table *tbl,
 		if (s->dma_length != 0) {
 			unsigned long vaddr, npages;
 
-			vaddr = s->dma_address & IOMMU_PAGE_MASK;
+			vaddr = s->dma_address & IOMMU_PAGE_MASK_4K;
 			npages = iommu_num_pages(s->dma_address, s->dma_length,
-						 IOMMU_PAGE_SIZE);
+						 IOMMU_PAGE_SIZE_4K);
 			__iommu_free(tbl, vaddr, npages);
 			s->dma_address = DMA_ERROR_CODE;
 			s->dma_length = 0;
@@ -592,7 +592,7 @@ void iommu_unmap_sg(struct iommu_table *tbl, struct scatterlist *sglist,
 		if (sg->dma_length == 0)
 			break;
 		npages = iommu_num_pages(dma_handle, sg->dma_length,
-					 IOMMU_PAGE_SIZE);
+					 IOMMU_PAGE_SIZE_4K);
 		__iommu_free(tbl, dma_handle, npages);
 		sg = sg_next(sg);
 	}
@@ -676,7 +676,7 @@ struct iommu_table *iommu_init_table(struct iommu_table *tbl, int nid)
 		set_bit(0, tbl->it_map);
 
 	/* We only split the IOMMU table if we have 1GB or more of space */
-	if ((tbl->it_size << IOMMU_PAGE_SHIFT) >= (1UL * 1024 * 1024 * 1024))
+	if ((tbl->it_size << IOMMU_PAGE_SHIFT_4K) >= (1UL * 1024 * 1024 * 1024))
 		tbl->nr_pools = IOMMU_NR_POOLS;
 	else
 		tbl->nr_pools = 1;
@@ -768,16 +768,16 @@ dma_addr_t iommu_map_page(struct device *dev, struct iommu_table *tbl,
 
 	vaddr = page_address(page) + offset;
 	uaddr = (unsigned long)vaddr;
-	npages = iommu_num_pages(uaddr, size, IOMMU_PAGE_SIZE);
+	npages = iommu_num_pages(uaddr, size, IOMMU_PAGE_SIZE_4K);
 
 	if (tbl) {
 		align = 0;
-		if (IOMMU_PAGE_SHIFT < PAGE_SHIFT && size >= PAGE_SIZE &&
+		if (IOMMU_PAGE_SHIFT_4K < PAGE_SHIFT && size >= PAGE_SIZE &&
 		    ((unsigned long)vaddr & ~PAGE_MASK) == 0)
-			align = PAGE_SHIFT - IOMMU_PAGE_SHIFT;
+			align = PAGE_SHIFT - IOMMU_PAGE_SHIFT_4K;
 
 		dma_handle = iommu_alloc(dev, tbl, vaddr, npages, direction,
-					 mask >> IOMMU_PAGE_SHIFT, align,
+					 mask >> IOMMU_PAGE_SHIFT_4K, align,
 					 attrs);
 		if (dma_handle == DMA_ERROR_CODE) {
 			if (printk_ratelimit())  {
@@ -786,7 +786,7 @@ dma_addr_t iommu_map_page(struct device *dev, struct iommu_table *tbl,
 					 npages);
 			}
 		} else
-			dma_handle |= (uaddr & ~IOMMU_PAGE_MASK);
+			dma_handle |= (uaddr & ~IOMMU_PAGE_MASK_4K);
 	}
 
 	return dma_handle;
@@ -801,7 +801,7 @@ void iommu_unmap_page(struct iommu_table *tbl, dma_addr_t dma_handle,
 	BUG_ON(direction == DMA_NONE);
 
 	if (tbl) {
-		npages = iommu_num_pages(dma_handle, size, IOMMU_PAGE_SIZE);
+		npages = iommu_num_pages(dma_handle, size, IOMMU_PAGE_SIZE_4K);
 		iommu_free(tbl, dma_handle, npages);
 	}
 }
@@ -845,10 +845,10 @@ void *iommu_alloc_coherent(struct device *dev, struct iommu_table *tbl,
 	memset(ret, 0, size);
 
 	/* Set up tces to cover the allocated range */
-	nio_pages = size >> IOMMU_PAGE_SHIFT;
+	nio_pages = size >> IOMMU_PAGE_SHIFT_4K;
 	io_order = get_iommu_order(size);
 	mapping = iommu_alloc(dev, tbl, ret, nio_pages, DMA_BIDIRECTIONAL,
-			      mask >> IOMMU_PAGE_SHIFT, io_order, NULL);
+			      mask >> IOMMU_PAGE_SHIFT_4K, io_order, NULL);
 	if (mapping == DMA_ERROR_CODE) {
 		free_pages((unsigned long)ret, order);
 		return NULL;
@@ -864,7 +864,7 @@ void iommu_free_coherent(struct iommu_table *tbl, size_t size,
 		unsigned int nio_pages;
 
 		size = PAGE_ALIGN(size);
-		nio_pages = size >> IOMMU_PAGE_SHIFT;
+		nio_pages = size >> IOMMU_PAGE_SHIFT_4K;
 		iommu_free(tbl, dma_handle, nio_pages);
 		size = PAGE_ALIGN(size);
 		free_pages((unsigned long)vaddr, get_order(size));
@@ -935,10 +935,10 @@ int iommu_tce_clear_param_check(struct iommu_table *tbl,
 	if (tce_value)
 		return -EINVAL;
 
-	if (ioba & ~IOMMU_PAGE_MASK)
+	if (ioba & ~IOMMU_PAGE_MASK_4K)
 		return -EINVAL;
 
-	ioba >>= IOMMU_PAGE_SHIFT;
+	ioba >>= IOMMU_PAGE_SHIFT_4K;
 	if (ioba < tbl->it_offset)
 		return -EINVAL;
 
@@ -955,13 +955,13 @@ int iommu_tce_put_param_check(struct iommu_table *tbl,
 	if (!(tce & (TCE_PCI_WRITE | TCE_PCI_READ)))
 		return -EINVAL;
 
-	if (tce & ~(IOMMU_PAGE_MASK | TCE_PCI_WRITE | TCE_PCI_READ))
+	if (tce & ~(IOMMU_PAGE_MASK_4K | TCE_PCI_WRITE | TCE_PCI_READ))
 		return -EINVAL;
 
-	if (ioba & ~IOMMU_PAGE_MASK)
+	if (ioba & ~IOMMU_PAGE_MASK_4K)
 		return -EINVAL;
 
-	ioba >>= IOMMU_PAGE_SHIFT;
+	ioba >>= IOMMU_PAGE_SHIFT_4K;
 	if (ioba < tbl->it_offset)
 		return -EINVAL;
 
@@ -1037,7 +1037,7 @@ int iommu_tce_build(struct iommu_table *tbl, unsigned long entry,
 
 	/* if (unlikely(ret))
 		pr_err("iommu_tce: %s failed on hwaddr=%lx ioba=%lx kva=%lx ret=%d\n",
-				__func__, hwaddr, entry << IOMMU_PAGE_SHIFT,
+				__func__, hwaddr, entry << IOMMU_PAGE_SHIFT_4K,
 				hwaddr, ret); */
 
 	return ret;
@@ -1049,14 +1049,14 @@ int iommu_put_tce_user_mode(struct iommu_table *tbl, unsigned long entry,
 {
 	int ret;
 	struct page *page = NULL;
-	unsigned long hwaddr, offset = tce & IOMMU_PAGE_MASK & ~PAGE_MASK;
+	unsigned long hwaddr, offset = tce & IOMMU_PAGE_MASK_4K & ~PAGE_MASK;
 	enum dma_data_direction direction = iommu_tce_direction(tce);
 
 	ret = get_user_pages_fast(tce & PAGE_MASK, 1,
 			direction != DMA_TO_DEVICE, &page);
 	if (unlikely(ret != 1)) {
 		/* pr_err("iommu_tce: get_user_pages_fast failed tce=%lx ioba=%lx ret=%d\n",
-				tce, entry << IOMMU_PAGE_SHIFT, ret); */
+				tce, entry << IOMMU_PAGE_SHIFT_4K, ret); */
 		return -EFAULT;
 	}
 	hwaddr = (unsigned long) page_address(page) + offset;
@@ -1067,7 +1067,7 @@ int iommu_put_tce_user_mode(struct iommu_table *tbl, unsigned long entry,
 
 	if (ret < 0)
 		pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%d\n",
-				__func__, entry << IOMMU_PAGE_SHIFT, tce, ret);
+			__func__, entry << IOMMU_PAGE_SHIFT_4K, tce, ret);
 
 	return ret;
 }
@@ -1164,7 +1164,7 @@ static int __init tce_iommu_init(void)
 {
 	struct pci_dev *pdev = NULL;
 
-	BUILD_BUG_ON(PAGE_SIZE < IOMMU_PAGE_SIZE);
+	BUILD_BUG_ON(PAGE_SIZE < IOMMU_PAGE_SIZE_4K);
 
 	for_each_pci_dev(pdev)
 		iommu_add_device(&pdev->dev);
diff --git a/arch/powerpc/kernel/vio.c b/arch/powerpc/kernel/vio.c
index d38cc08..a93e501 100644
--- a/arch/powerpc/kernel/vio.c
+++ b/arch/powerpc/kernel/vio.c
@@ -520,14 +520,14 @@ static dma_addr_t vio_dma_iommu_map_page(struct device *dev, struct page *page,
 	struct vio_dev *viodev = to_vio_dev(dev);
 	dma_addr_t ret = DMA_ERROR_CODE;
 
-	if (vio_cmo_alloc(viodev, roundup(size, IOMMU_PAGE_SIZE))) {
+	if (vio_cmo_alloc(viodev, roundup(size, IOMMU_PAGE_SIZE_4K))) {
 		atomic_inc(&viodev->cmo.allocs_failed);
 		return ret;
 	}
 
 	ret = dma_iommu_ops.map_page(dev, page, offset, size, direction, attrs);
 	if (unlikely(dma_mapping_error(dev, ret))) {
-		vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE));
+		vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE_4K));
 		atomic_inc(&viodev->cmo.allocs_failed);
 	}
 
@@ -543,7 +543,7 @@ static void vio_dma_iommu_unmap_page(struct device *dev, dma_addr_t dma_handle,
 
 	dma_iommu_ops.unmap_page(dev, dma_handle, size, direction, attrs);
 
-	vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE));
+	vio_cmo_dealloc(viodev, roundup(size, IOMMU_PAGE_SIZE_4K));
 }
 
 static int vio_dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
@@ -556,7 +556,7 @@ static int vio_dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 	size_t alloc_size = 0;
 
 	for (sgl = sglist; count < nelems; count++, sgl++)
-		alloc_size += roundup(sgl->length, IOMMU_PAGE_SIZE);
+		alloc_size += roundup(sgl->length, IOMMU_PAGE_SIZE_4K);
 
 	if (vio_cmo_alloc(viodev, alloc_size)) {
 		atomic_inc(&viodev->cmo.allocs_failed);
@@ -572,7 +572,7 @@ static int vio_dma_iommu_map_sg(struct device *dev, struct scatterlist *sglist,
 	}
 
 	for (sgl = sglist, count = 0; count < ret; count++, sgl++)
-		alloc_size -= roundup(sgl->dma_length, IOMMU_PAGE_SIZE);
+		alloc_size -= roundup(sgl->dma_length, IOMMU_PAGE_SIZE_4K);
 	if (alloc_size)
 		vio_cmo_dealloc(viodev, alloc_size);
 
@@ -590,7 +590,7 @@ static void vio_dma_iommu_unmap_sg(struct device *dev,
 	int count = 0;
 
 	for (sgl = sglist; count < nelems; count++, sgl++)
-		alloc_size += roundup(sgl->dma_length, IOMMU_PAGE_SIZE);
+		alloc_size += roundup(sgl->dma_length, IOMMU_PAGE_SIZE_4K);
 
 	dma_iommu_ops.unmap_sg(dev, sglist, nelems, direction, attrs);
 
@@ -736,7 +736,8 @@ static int vio_cmo_bus_probe(struct vio_dev *viodev)
 			return -EINVAL;
 		}
 
-		viodev->cmo.desired = IOMMU_PAGE_ALIGN(viodrv->get_desired_dma(viodev));
+		viodev->cmo.desired =
+			IOMMU_PAGE_ALIGN_4K(viodrv->get_desired_dma(viodev));
 		if (viodev->cmo.desired < VIO_CMO_MIN_ENT)
 			viodev->cmo.desired = VIO_CMO_MIN_ENT;
 		size = VIO_CMO_MIN_ENT;
@@ -1170,9 +1171,9 @@ static struct iommu_table *vio_build_iommu_table(struct vio_dev *dev)
 			    &tbl->it_index, &offset, &size);
 
 	/* TCE table size - measured in tce entries */
-	tbl->it_size = size >> IOMMU_PAGE_SHIFT;
+	tbl->it_size = size >> IOMMU_PAGE_SHIFT_4K;
 	/* offset for VIO should always be 0 */
-	tbl->it_offset = offset >> IOMMU_PAGE_SHIFT;
+	tbl->it_offset = offset >> IOMMU_PAGE_SHIFT_4K;
 	tbl->it_busno = 0;
 	tbl->it_type = TCE_VB;
 	tbl->it_blocksize = 16;
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index a28d3b5..78b231c 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -452,7 +452,7 @@ void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 {
 	tbl->it_blocksize = 16;
 	tbl->it_base = (unsigned long)tce_mem;
-	tbl->it_offset = dma_offset >> IOMMU_PAGE_SHIFT;
+	tbl->it_offset = dma_offset >> IOMMU_PAGE_SHIFT_4K;
 	tbl->it_index = 0;
 	tbl->it_size = tce_size >> 3;
 	tbl->it_busno = 0;
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 0307901..007c21f 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -487,7 +487,7 @@ static void iommu_table_setparms(struct pci_controller *phb,
 	tbl->it_busno = phb->bus->number;
 
 	/* Units of tce entries */
-	tbl->it_offset = phb->dma_window_base_cur >> IOMMU_PAGE_SHIFT;
+	tbl->it_offset = phb->dma_window_base_cur >> IOMMU_PAGE_SHIFT_4K;
 
 	/* Test if we are going over 2GB of DMA space */
 	if (phb->dma_window_base_cur + phb->dma_window_size > 0x80000000ul) {
@@ -498,7 +498,7 @@ static void iommu_table_setparms(struct pci_controller *phb,
 	phb->dma_window_base_cur += phb->dma_window_size;
 
 	/* Set the tce table size - measured in entries */
-	tbl->it_size = phb->dma_window_size >> IOMMU_PAGE_SHIFT;
+	tbl->it_size = phb->dma_window_size >> IOMMU_PAGE_SHIFT_4K;
 
 	tbl->it_index = 0;
 	tbl->it_blocksize = 16;
@@ -539,8 +539,8 @@ static void iommu_table_setparms_lpar(struct pci_controller *phb,
 	tbl->it_base   = 0;
 	tbl->it_blocksize  = 16;
 	tbl->it_type = TCE_PCI;
-	tbl->it_offset = offset >> IOMMU_PAGE_SHIFT;
-	tbl->it_size = size >> IOMMU_PAGE_SHIFT;
+	tbl->it_offset = offset >> IOMMU_PAGE_SHIFT_4K;
+	tbl->it_size = size >> IOMMU_PAGE_SHIFT_4K;
 }
 
 static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 1f97e2b..17d6f8a 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -72,7 +72,7 @@
 
 int CMO_PrPSP = -1;
 int CMO_SecPSP = -1;
-unsigned long CMO_PageSize = (ASM_CONST(1) << IOMMU_PAGE_SHIFT);
+unsigned long CMO_PageSize = (ASM_CONST(1) << IOMMU_PAGE_SHIFT_4K);
 EXPORT_SYMBOL(CMO_PageSize);
 
 int fwnmi_active;  /* TRUE if an FWNMI handler is present */
@@ -543,7 +543,7 @@ void pSeries_cmo_feature_init(void)
 {
 	char *ptr, *key, *value, *end;
 	int call_status;
-	int page_order = IOMMU_PAGE_SHIFT;
+	int page_order = IOMMU_PAGE_SHIFT_4K;
 
 	pr_debug(" -> fw_cmo_feature_init()\n");
 	spin_lock(&rtas_data_buf_lock);
diff --git a/drivers/net/ethernet/ibm/ibmveth.c b/drivers/net/ethernet/ibm/ibmveth.c
index 5d41aee..eef362d 100644
--- a/drivers/net/ethernet/ibm/ibmveth.c
+++ b/drivers/net/ethernet/ibm/ibmveth.c
@@ -1282,24 +1282,25 @@ static unsigned long ibmveth_get_desired_dma(struct vio_dev *vdev)
 
 	/* netdev inits at probe time along with the structures we need below*/
 	if (netdev == NULL)
-		return IOMMU_PAGE_ALIGN(IBMVETH_IO_ENTITLEMENT_DEFAULT);
+		return IOMMU_PAGE_ALIGN_4K(IBMVETH_IO_ENTITLEMENT_DEFAULT);
 
 	adapter = netdev_priv(netdev);
 
 	ret = IBMVETH_BUFF_LIST_SIZE + IBMVETH_FILT_LIST_SIZE;
-	ret += IOMMU_PAGE_ALIGN(netdev->mtu);
+	ret += IOMMU_PAGE_ALIGN_4K(netdev->mtu);
 
 	for (i = 0; i < IBMVETH_NUM_BUFF_POOLS; i++) {
 		/* add the size of the active receive buffers */
 		if (adapter->rx_buff_pool[i].active)
 			ret +=
 			    adapter->rx_buff_pool[i].size *
-			    IOMMU_PAGE_ALIGN(adapter->rx_buff_pool[i].
+			    IOMMU_PAGE_ALIGN_4K(adapter->rx_buff_pool[i].
 			            buff_size);
 		rxqentries += adapter->rx_buff_pool[i].size;
 	}
 	/* add the size of the receive queue entries */
-	ret += IOMMU_PAGE_ALIGN(rxqentries * sizeof(struct ibmveth_rx_q_entry));
+	ret += IOMMU_PAGE_ALIGN_4K(
+		rxqentries * sizeof(struct ibmveth_rx_q_entry));
 
 	return ret;
 }
-- 
1.7.10.4
