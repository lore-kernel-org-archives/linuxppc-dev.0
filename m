Return-Path: <bgill@blarg.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id DA3A5474DE
	for <linuxppc-dev@ozlabs.org>; Fri, 21 Nov 2008 03:49:23 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	mAKGnIWA002998
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 09:49:18 -0700 (MST)
Received: from blarg.am.freescale.net (blarg.am.freescale.net [10.82.19.176])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	mAKGnG9X028746
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Nov 2008 10:49:17 -0600 (CST)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V2] powerpc: Add sync_*_for_* to dma_ops
Date: Thu, 20 Nov 2008 10:49:16 -0600
Message-Id: <1227199756-10623-1-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We need to swap these out once we start using swiotlb, so add
them to dma_ops.  Create CONFIG_PPC_NEED_DMA_SYNC_OPS Kconfig
option; this is currently enabled automatically if we're
CONFIG_NOT_COHERENT_CACHE.  In the future, this will also
be enabled for builds that need swiotlb.  If PPC_NEED_DMA_SYNC_OPS
is not defined, the dma_sync_*_for_* ops compile to nothing.
Otherwise, they access the dma_ops pointers for the sync ops.

This patch also changes dma_sync_single_range_* to actually
sync the range - previously it was using a generous
dma_sync_single.  dma_sync_single_* is now implemented
as a dma_sync_single_range with an offset of 0.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
 arch/powerpc/Kconfig                   |    4 ++
 arch/powerpc/include/asm/dma-mapping.h |   93 +++++++++++++++++++++-----------
 arch/powerpc/kernel/dma.c              |   26 +++++++++
 3 files changed, 92 insertions(+), 31 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 525c13a..be4f99b 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -285,6 +285,10 @@ config IOMMU_VMERGE
 config IOMMU_HELPER
 	def_bool PPC64
 
+config PPC_NEED_DMA_SYNC_OPS
+	def_bool y
+	depends on NOT_COHERENT_CACHE
+
 config HOTPLUG_CPU
 	bool "Support for enabling/disabling CPUs"
 	depends on SMP && HOTPLUG && EXPERIMENTAL && (PPC_PSERIES || PPC_PMAC)
diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 3c4a2c2..9063184 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -76,6 +76,22 @@ struct dma_mapping_ops {
 				dma_addr_t dma_address, size_t size,
 				enum dma_data_direction direction,
 				struct dma_attrs *attrs);
+#ifdef CONFIG_PPC_NEED_DMA_SYNC_OPS
+	void            (*sync_single_range_for_cpu)(struct device *hwdev,
+				dma_addr_t dma_handle, unsigned long offset,
+				size_t size,
+				enum dma_data_direction direction);
+	void            (*sync_single_range_for_device)(struct device *hwdev,
+				dma_addr_t dma_handle, unsigned long offset,
+				size_t size,
+				enum dma_data_direction direction);
+	void            (*sync_sg_for_cpu)(struct device *hwdev,
+				struct scatterlist *sg, int nelems,
+				enum dma_data_direction direction);
+	void            (*sync_sg_for_device)(struct device *hwdev,
+				struct scatterlist *sg, int nelems,
+				enum dma_data_direction direction);
+#endif
 };
 
 /*
@@ -282,47 +298,78 @@ static inline void dma_unmap_sg(struct device *dev, struct scatterlist *sg,
 	dma_unmap_sg_attrs(dev, sg, nhwentries, direction, NULL);
 }
 
+#ifdef CONFIG_PPC_NEED_DMA_SYNC_OPS
 static inline void dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size,
 		enum dma_data_direction direction)
 {
-	BUG_ON(direction == DMA_NONE);
-	__dma_sync(bus_to_virt(dma_handle), size, direction);
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
+
+	BUG_ON(!dma_ops);
+	dma_ops->sync_single_range_for_cpu(dev, dma_handle, 0,
+					   size, direction);
 }
 
 static inline void dma_sync_single_for_device(struct device *dev,
 		dma_addr_t dma_handle, size_t size,
 		enum dma_data_direction direction)
 {
-	BUG_ON(direction == DMA_NONE);
-	__dma_sync(bus_to_virt(dma_handle), size, direction);
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
+
+	BUG_ON(!dma_ops);
+	dma_ops->sync_single_range_for_device(dev, dma_handle,
+					      0, size, direction);
 }
 
 static inline void dma_sync_sg_for_cpu(struct device *dev,
 		struct scatterlist *sgl, int nents,
 		enum dma_data_direction direction)
 {
-	struct scatterlist *sg;
-	int i;
-
-	BUG_ON(direction == DMA_NONE);
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
-	for_each_sg(sgl, sg, nents, i)
-		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
+	BUG_ON(!dma_ops);
+	dma_ops->sync_sg_for_cpu(dev, sgl, nents, direction);
 }
 
 static inline void dma_sync_sg_for_device(struct device *dev,
 		struct scatterlist *sgl, int nents,
 		enum dma_data_direction direction)
 {
-	struct scatterlist *sg;
-	int i;
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
-	BUG_ON(direction == DMA_NONE);
+	BUG_ON(!dma_ops);
+	dma_ops->sync_sg_for_device(dev, sgl, nents, direction);
+}
+
+static inline void dma_sync_single_range_for_cpu(struct device *dev,
+		dma_addr_t dma_handle, unsigned long offset, size_t size,
+		enum dma_data_direction direction)
+{
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
-	for_each_sg(sgl, sg, nents, i)
-		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
+	BUG_ON(!dma_ops);
+	dma_ops->sync_single_range_for_cpu(dev, dma_handle,
+					   offset, size, direction);
+}
+
+static inline void dma_sync_single_range_for_device(struct device *dev,
+		dma_addr_t dma_handle, unsigned long offset, size_t size,
+		enum dma_data_direction direction)
+{
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
+
+	BUG_ON(!dma_ops);
+	dma_ops->sync_single_range_for_device(dev, dma_handle, offset,
+					      size, direction);
 }
+#else /* CONFIG_PPC_NEED_DMA_SYNC_OPS */
+#define dma_sync_single_for_cpu(d, h, s, dir) ((void)0)
+#define dma_sync_single_for_device(d, h, s, dir) ((void)0)
+#define dma_sync_single_range_for_cpu(d, h, o, s, dir) ((void)0)
+#define dma_sync_single_range_for_device(d, h, o, s, dir) ((void)0)
+#define dma_sync_sg_for_cpu(d, s, n, dir) ((void)0)
+#define dma_sync_sg_for_device(d, s, n, dir) ((void)0)
+#endif
 
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
 {
@@ -356,22 +403,6 @@ static inline int dma_get_cache_alignment(void)
 #endif
 }
 
-static inline void dma_sync_single_range_for_cpu(struct device *dev,
-		dma_addr_t dma_handle, unsigned long offset, size_t size,
-		enum dma_data_direction direction)
-{
-	/* just sync everything for now */
-	dma_sync_single_for_cpu(dev, dma_handle, offset + size, direction);
-}
-
-static inline void dma_sync_single_range_for_device(struct device *dev,
-		dma_addr_t dma_handle, unsigned long offset, size_t size,
-		enum dma_data_direction direction)
-{
-	/* just sync everything for now */
-	dma_sync_single_for_device(dev, dma_handle, offset + size, direction);
-}
-
 static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		enum dma_data_direction direction)
 {
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 1562daf..0cfacb3 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -119,6 +119,26 @@ static inline void dma_direct_unmap_page(struct device *dev,
 {
 }
 
+#ifdef CONFIG_NOT_COHERENT_CACHE
+static inline void dma_direct_sync_sg(struct device *dev,
+		struct scatterlist *sgl, int nents,
+		enum dma_data_direction direction)
+{
+	struct scatterlist *sg;
+	int i;
+
+	for_each_sg(sgl, sg, nents, i)
+		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
+}
+
+static inline void dma_direct_sync_single_range(struct device *dev,
+		dma_addr_t dma_handle, unsigned long offset, size_t size,
+		enum dma_data_direction direction)
+{
+	__dma_sync(bus_to_virt(dma_handle+offset), size, direction);
+}
+#endif
+
 struct dma_mapping_ops dma_direct_ops = {
 	.alloc_coherent	= dma_direct_alloc_coherent,
 	.free_coherent	= dma_direct_free_coherent,
@@ -127,5 +147,11 @@ struct dma_mapping_ops dma_direct_ops = {
 	.dma_supported	= dma_direct_dma_supported,
 	.map_page	= dma_direct_map_page,
 	.unmap_page	= dma_direct_unmap_page,
+#ifdef CONFIG_NOT_COHERENT_CACHE
+	.sync_single_range_for_cpu 	= dma_direct_sync_single_range,
+	.sync_single_range_for_device 	= dma_direct_sync_single_range,
+	.sync_sg_for_cpu 		= dma_direct_sync_sg,
+	.sync_sg_for_device 		= dma_direct_sync_sg,
+#endif
 };
 EXPORT_SYMBOL(dma_direct_ops);
-- 
1.5.6.5
