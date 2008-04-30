Return-Path: <markn@au1.ibm.com>
Received: from e23smtp04.au.ibm.com (E23SMTP04.au.ibm.com [202.81.18.173])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp04.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 8D271DE06D
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 17:53:40 +1000 (EST)
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [202.81.18.234])
	by e23smtp04.au.ibm.com (8.13.1/8.13.1) with ESMTP id m3U7r2PY007127
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 17:53:02 +1000
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
	by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v8.7) with ESMTP id
	m3U7nlr74739302
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 17:49:47 +1000
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
	by d23av03.au.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m3U7o4M5008161
	for <linuxppc-dev@ozlabs.org>; Wed, 30 Apr 2008 17:50:05 +1000
Message-Id: <20080430074955.078600978@au1.ibm.com>
References: <20080430074621.104662132@au1.ibm.com>
Date: Wed, 30 Apr 2008 17:46:26 +1000
From: markn@au1.ibm.com
To: olof@lixom.net
Subject: [RFC] [PATCH 5/5] [POWERPC] Add DMA_ATTR_WEAK_ORDERING dma attribute
	and use in Cell IOMMU code
Cc: Mark Nelson <markn@au1.ibm.com>, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Introduce a new dma attriblue DMA_ATTR_WEAK_ORDERING to use weak ordering
on DMA mappings in the Cell processor. Add the code to the Cell's IOMMU
implementation to use this code.

Dynamic mappings can be weakly or strongly ordered on an individual basis
but the fixed mapping has to be either completely strong or completely weak.
This is currently decided by a kernel boot option (pass iommu_fixed=weak
for a weakly ordered fixed linear mapping, strongly ordered is the default).

Signed-off-by: Mark Nelson <markn@au1.ibm.com>
---
 Documentation/DMA-attributes.txt    |    9 ++
 arch/powerpc/platforms/cell/iommu.c |  113 ++++++++++++++++++++++++++++++++++--
 include/linux/dma-attrs.h           |    1 
 3 files changed, 118 insertions(+), 5 deletions(-)

Index: upstream/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- upstream.orig/arch/powerpc/platforms/cell/iommu.c
+++ upstream/arch/powerpc/platforms/cell/iommu.c
@@ -199,6 +199,8 @@ static void tce_build_cell(struct iommu_
 	base_pte = IOPTE_PP_W | IOPTE_PP_R | IOPTE_M | IOPTE_SO_RW |
 		(window->ioid & IOPTE_IOID_Mask);
 #endif
+	if (unlikely(dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs)))
+		base_pte &= ~IOPTE_SO_RW;
 
 	io_pte = (unsigned long *)tbl->it_base + (index - tbl->it_offset);
 
@@ -539,7 +541,9 @@ static struct cbe_iommu *cell_iommu_for_
 static unsigned long cell_dma_direct_offset;
 
 static unsigned long dma_iommu_fixed_base;
-struct dma_mapping_ops dma_iommu_fixed_ops;
+
+/* iommu_fixed_is_weak is set if booted with iommu_fixed=weak */
+static int iommu_fixed_is_weak;
 
 static struct iommu_table *cell_get_iommu_table(struct device *dev)
 {
@@ -563,6 +567,98 @@ static struct iommu_table *cell_get_iomm
 	return &window->table;
 }
 
+/* A coherent allocation implies strong ordering */
+
+static void *dma_fixed_alloc_coherent(struct device *dev, size_t size,
+				      dma_addr_t *dma_handle, gfp_t flag)
+{
+	if (iommu_fixed_is_weak)
+		return iommu_alloc_coherent(dev, cell_get_iommu_table(dev),
+					    size, dma_handle,
+					    device_to_mask(dev), flag,
+					    dev->archdata.numa_node);
+	else
+		return dma_direct_ops.alloc_coherent(dev, size, dma_handle,
+						     flag);
+}
+
+static void dma_fixed_free_coherent(struct device *dev, size_t size,
+				    void *vaddr, dma_addr_t dma_handle)
+{
+	if (iommu_fixed_is_weak)
+		iommu_free_coherent(cell_get_iommu_table(dev), size, vaddr,
+				    dma_handle);
+	else
+		dma_direct_ops.free_coherent(dev, size, vaddr, dma_handle);
+}
+
+static dma_addr_t dma_fixed_map_single(struct device *dev, void *ptr,
+				       size_t size,
+				       enum dma_data_direction direction,
+				       struct dma_attrs *attrs)
+{
+	if (iommu_fixed_is_weak == dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs))
+		return dma_direct_ops.map_single(dev, ptr, size, direction,
+						 attrs);
+	else
+		return iommu_map_single(dev, cell_get_iommu_table(dev), ptr,
+					size, device_to_mask(dev), direction,
+					attrs);
+}
+
+static void dma_fixed_unmap_single(struct device *dev, dma_addr_t dma_addr,
+				   size_t size,
+				   enum dma_data_direction direction,
+				   struct dma_attrs *attrs)
+{
+	if (iommu_fixed_is_weak == dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs))
+		dma_direct_ops.unmap_single(dev, dma_addr, size, direction,
+					    attrs);
+	else
+		iommu_unmap_single(cell_get_iommu_table(dev), dma_addr, size,
+				   direction, attrs);
+}
+
+static int dma_fixed_map_sg(struct device *dev, struct scatterlist *sg,
+			   int nents, enum dma_data_direction direction,
+			   struct dma_attrs *attrs)
+{
+	if (iommu_fixed_is_weak == dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs))
+		return dma_direct_ops.map_sg(dev, sg, nents, direction, attrs);
+	else
+		return iommu_map_sg(dev, cell_get_iommu_table(dev), sg, nents,
+				    device_to_mask(dev), direction, attrs);
+}
+
+static void dma_fixed_unmap_sg(struct device *dev, struct scatterlist *sg,
+			       int nents, enum dma_data_direction direction,
+			       struct dma_attrs *attrs)
+{
+	if (iommu_fixed_is_weak == dma_get_attr(DMA_ATTR_WEAK_ORDERING, attrs))
+		dma_direct_ops.unmap_sg(dev, sg, nents, direction, attrs);
+	else
+		iommu_unmap_sg(cell_get_iommu_table(dev), sg, nents, direction,
+			       attrs);
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
@@ -919,9 +1015,16 @@ static void cell_iommu_setup_fixed_ptab(
 
 	pr_debug("iommu: mapping 0x%lx pages from 0x%lx\n", fsize, fbase);
 
-	base_pte = IOPTE_PP_W | IOPTE_PP_R | IOPTE_M | IOPTE_SO_RW
+	base_pte = IOPTE_PP_W | IOPTE_PP_R | IOPTE_M
 		    | (cell_iommu_get_ioid(np) & IOPTE_IOID_Mask);
 
+	if (iommu_fixed_is_weak)
+		pr_info("IOMMU: Using weak ordering for fixed mapping\n");
+	else {
+		pr_info("IOMMU: Using strong ordering for fixed mapping\n");
+		base_pte |= IOPTE_SO_RW;
+	}
+
 	for (uaddr = 0; uaddr < fsize; uaddr += (1 << 24)) {
 		/* Don't touch the dynamic region */
 		ioaddr = uaddr + fbase;
@@ -1037,9 +1140,6 @@ static int __init cell_iommu_fixed_mappi
 		cell_iommu_setup_window(iommu, np, dbase, dsize, 0);
 	}
 
-	dma_iommu_fixed_ops = dma_direct_ops;
-	dma_iommu_fixed_ops.set_dma_mask = dma_set_mask_and_switch;
-
 	dma_iommu_ops.set_dma_mask = dma_set_mask_and_switch;
 	set_pci_dma_ops(&dma_iommu_ops);
 
@@ -1053,6 +1153,9 @@ static int __init setup_iommu_fixed(char
 	if (strcmp(str, "off") == 0)
 		iommu_fixed_disabled = 1;
 
+	else if (strcmp(str, "weak") == 0)
+		iommu_fixed_is_weak = 1;
+
 	return 1;
 }
 __setup("iommu_fixed=", setup_iommu_fixed);
Index: upstream/Documentation/DMA-attributes.txt
===================================================================
--- upstream.orig/Documentation/DMA-attributes.txt
+++ upstream/Documentation/DMA-attributes.txt
@@ -22,3 +22,12 @@ ready and available in memory.  The DMA 
 could race with data DMA.  Mapping the memory used for completion
 indications with DMA_ATTR_WRITE_BARRIER would prevent the race.
 
+DMA_ATTR_WEAK_ORDERING
+----------------------
+
+DMA_ATTR_WEAK_ORDERING specifies that reads and writes to the mapping
+may be weakly ordered, that is that reads and writes may pass each other.
+
+Since it is optional for platforms to implement DMA_ATTR_WEAK_ORDERING,
+those that do not will simply ignore the attribute and exhibit default
+behavior.
Index: upstream/include/linux/dma-attrs.h
===================================================================
--- upstream.orig/include/linux/dma-attrs.h
+++ upstream/include/linux/dma-attrs.h
@@ -12,6 +12,7 @@
  */
 enum dma_attr {
 	DMA_ATTR_WRITE_BARRIER,
+	DMA_ATTR_WEAK_ORDERING,
 	DMA_ATTR_MAX,
 };
 

-- 
