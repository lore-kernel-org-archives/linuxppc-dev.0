Return-Path: <arnd@arndb.de>
Message-Id: <20080715195740.098068951@arndb.de>
References: <20080715195139.316677337@arndb.de>
Date: Tue, 15 Jul 2008 21:51:48 +0200
From: arnd@arndb.de
To: benh@kernel.crashing.org, cbe-oss-dev@ozlabs.org, linuxppc-dev@ozlabs.org
Subject: [patch 9/9] powerpc/cell: Add DMA_ATTR_STRONG_ORDERING dma attribute
	and use in IOMMU code
Cc: Mark Nelson <markn@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Mark Nelson <markn@au1.ibm.com>

Introduce a new dma attriblue DMA_ATTR_STRONG_ORDERING to use strong ordering
on DMA mappings in the Cell processor. Add the code to the Cell's IOMMU
implementation to use this.

The current Cell IOMMU implementation sets the IOPTE_SO_RW bits in all IOTPEs
(for both the dynamic and fixed mappings) which enforces strong ordering of
both reads and writes. This patch makes the default behaviour weak ordering
(the IOPTE_SO_RW bits not set) and to request a strongly ordered mapping the
new DMA_ATTR_STRONG_ORDERING needs to be used.

Dynamic mappings can be weakly or strongly ordered on an individual basis
but the fixed mapping is always weakly ordered.

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 Documentation/DMA-attributes.txt    |   12 +++++
 arch/powerpc/platforms/cell/iommu.c |   93 ++++++++++++++++++++++++++++++++---
 include/linux/dma-attrs.h           |    1 +
 3 files changed, 99 insertions(+), 7 deletions(-)

diff --git a/Documentation/DMA-attributes.txt b/Documentation/DMA-attributes.txt
index 6d772f8..f2d2800 100644
--- a/Documentation/DMA-attributes.txt
+++ b/Documentation/DMA-attributes.txt
@@ -22,3 +22,15 @@ ready and available in memory.  The DMA of the "completion indication"
 could race with data DMA.  Mapping the memory used for completion
 indications with DMA_ATTR_WRITE_BARRIER would prevent the race.
 
+
+DMA_ATTR_STRONG_ORDERING
+----------------------
+
+DMA_ATTR_STRONG_ORDERING specifies that previous reads and writes are
+performed in the order in which they're received by the IOMMU; thus
+reads and writes may not pass each other.
+
+Platforms that are strongly ordered by default will ignore this new
+attribute but platforms that are weakly ordered by default should not
+ignore this new attribute. Instead, they should return an error if a
+strongly ordered mapping cannot be used when one is requested.
diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 3b70784..7f6ed20 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -194,11 +194,13 @@ static void tce_build_cell(struct iommu_table *tbl, long index, long npages,
 	const unsigned long prot = 0xc48;
 	base_pte =
 		((prot << (52 + 4 * direction)) & (IOPTE_PP_W | IOPTE_PP_R))
-		| IOPTE_M | IOPTE_SO_RW | (window->ioid & IOPTE_IOID_Mask);
+		| IOPTE_M | (window->ioid & IOPTE_IOID_Mask);
 #else
-	base_pte = IOPTE_PP_W | IOPTE_PP_R | IOPTE_M | IOPTE_SO_RW |
+	base_pte = IOPTE_PP_W | IOPTE_PP_R | IOPTE_M |
 		(window->ioid & IOPTE_IOID_Mask);
 #endif
+	if (unlikely(dma_get_attr(DMA_ATTR_STRONG_ORDERING, attrs)))
+		base_pte |= IOPTE_SO_RW;
 
 	io_pte = (unsigned long *)tbl->it_base + (index - tbl->it_offset);
 
@@ -539,7 +541,6 @@ static struct cbe_iommu *cell_iommu_for_node(int nid)
 static unsigned long cell_dma_direct_offset;
 
 static unsigned long dma_iommu_fixed_base;
-struct dma_mapping_ops dma_iommu_fixed_ops;
 
 static struct iommu_table *cell_get_iommu_table(struct device *dev)
 {
@@ -563,6 +564,85 @@ static struct iommu_table *cell_get_iommu_table(struct device *dev)
 	return &window->table;
 }
 
+static void *dma_fixed_alloc_coherent(struct device *dev, size_t size,
+				      dma_addr_t *dma_handle, gfp_t flag)
+{
+	return dma_direct_ops.alloc_coherent(dev, size, dma_handle, flag);
+}
+
+static void dma_fixed_free_coherent(struct device *dev, size_t size,
+				    void *vaddr, dma_addr_t dma_handle)
+{
+	dma_direct_ops.free_coherent(dev, size, vaddr, dma_handle);
+}
+
+static dma_addr_t dma_fixed_map_single(struct device *dev, void *ptr,
+				       size_t size,
+				       enum dma_data_direction direction,
+				       struct dma_attrs *attrs)
+{
+	if (dma_get_attr(DMA_ATTR_STRONG_ORDERING, attrs))
+		return iommu_map_single(dev, cell_get_iommu_table(dev), ptr,
+					size, device_to_mask(dev), direction,
+					attrs);
+	else
+		return dma_direct_ops.map_single(dev, ptr, size, direction,
+						 attrs);
+}
+
+static void dma_fixed_unmap_single(struct device *dev, dma_addr_t dma_addr,
+				   size_t size,
+				   enum dma_data_direction direction,
+				   struct dma_attrs *attrs)
+{
+	if (dma_get_attr(DMA_ATTR_STRONG_ORDERING, attrs))
+		iommu_unmap_single(cell_get_iommu_table(dev), dma_addr, size,
+				   direction, attrs);
+	else
+		dma_direct_ops.unmap_single(dev, dma_addr, size, direction,
+					    attrs);
+}
+
+static int dma_fixed_map_sg(struct device *dev, struct scatterlist *sg,
+			   int nents, enum dma_data_direction direction,
+			   struct dma_attrs *attrs)
+{
+	if (dma_get_attr(DMA_ATTR_STRONG_ORDERING, attrs))
+		return iommu_map_sg(dev, cell_get_iommu_table(dev), sg, nents,
+				    device_to_mask(dev), direction, attrs);
+	else
+		return dma_direct_ops.map_sg(dev, sg, nents, direction, attrs);
+}
+
+static void dma_fixed_unmap_sg(struct device *dev, struct scatterlist *sg,
+			       int nents, enum dma_data_direction direction,
+			       struct dma_attrs *attrs)
+{
+	if (dma_get_attr(DMA_ATTR_STRONG_ORDERING, attrs))
+		iommu_unmap_sg(cell_get_iommu_table(dev), sg, nents, direction,
+			       attrs);
+	else
+		dma_direct_ops.unmap_sg(dev, sg, nents, direction, attrs);
+}
+
+static int dma_fixed_dma_supported(struct device *dev, u64 mask)
+{
+	return mask == DMA_64BIT_MASK;
+}
+
+static int dma_set_mask_and_switch(struct device *dev, u64 dma_mask);
+
+struct dma_mapping_ops dma_iommu_fixed_ops = {
+	.alloc_coherent = dma_fixed_alloc_coherent,
+	.free_coherent  = dma_fixed_free_coherent,
+	.map_single     = dma_fixed_map_single,
+	.unmap_single   = dma_fixed_unmap_single,
+	.map_sg         = dma_fixed_map_sg,
+	.unmap_sg       = dma_fixed_unmap_sg,
+	.dma_supported  = dma_fixed_dma_supported,
+	.set_dma_mask   = dma_set_mask_and_switch,
+};
+
 static void cell_dma_dev_setup_fixed(struct device *dev);
 
 static void cell_dma_dev_setup(struct device *dev)
@@ -919,9 +999,11 @@ static void cell_iommu_setup_fixed_ptab(struct cbe_iommu *iommu,
 
 	pr_debug("iommu: mapping 0x%lx pages from 0x%lx\n", fsize, fbase);
 
-	base_pte = IOPTE_PP_W | IOPTE_PP_R | IOPTE_M | IOPTE_SO_RW
+	base_pte = IOPTE_PP_W | IOPTE_PP_R | IOPTE_M
 		    | (cell_iommu_get_ioid(np) & IOPTE_IOID_Mask);
 
+	pr_info("IOMMU: Using weak ordering for fixed mapping\n");
+
 	for (uaddr = 0; uaddr < fsize; uaddr += (1 << 24)) {
 		/* Don't touch the dynamic region */
 		ioaddr = uaddr + fbase;
@@ -1037,9 +1119,6 @@ static int __init cell_iommu_fixed_mapping_init(void)
 		cell_iommu_setup_window(iommu, np, dbase, dsize, 0);
 	}
 
-	dma_iommu_fixed_ops = dma_direct_ops;
-	dma_iommu_fixed_ops.set_dma_mask = dma_set_mask_and_switch;
-
 	dma_iommu_ops.set_dma_mask = dma_set_mask_and_switch;
 	set_pci_dma_ops(&dma_iommu_ops);
 
diff --git a/include/linux/dma-attrs.h b/include/linux/dma-attrs.h
index 1677e2b..600fea7 100644
--- a/include/linux/dma-attrs.h
+++ b/include/linux/dma-attrs.h
@@ -12,6 +12,7 @@
  */
 enum dma_attr {
 	DMA_ATTR_WRITE_BARRIER,
+	DMA_ATTR_STRONG_ORDERING,
 	DMA_ATTR_MAX,
 };
 
-- 
1.5.4.3

-- 
