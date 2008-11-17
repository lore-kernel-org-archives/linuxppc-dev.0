Return-Path: <bgill@blarg.am.freescale.net>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 1A58EDDDEE
	for <linuxppc-dev@ozlabs.org>; Tue, 18 Nov 2008 07:19:31 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	mAHKJQga002010
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 13:19:27 -0700 (MST)
Received: from blarg.am.freescale.net (blarg.am.freescale.net [10.82.19.176])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id
	mAHKJPLp014385
	for <linuxppc-dev@ozlabs.org>; Mon, 17 Nov 2008 14:19:26 -0600 (CST)
From: Becky Bruce <becky.bruce@freescale.com>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add sync_*_for_* to dma_ops
Date: Mon, 17 Nov 2008 14:19:25 -0600
Message-Id: <1226953165-19305-1-git-send-email-becky.bruce@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We need to swap these out once we start using swiotlb, so add
them to dma_ops.  When these are called, if the dma_op pointer
for the specific function is NULL, we just do nothing - most
of the 64-bit platforms don't actually need to do anything with
the sync so we don't require a sync function to be implemented.

Signed-off-by: Becky Bruce <becky.bruce@freescale.com>
---
 arch/powerpc/include/asm/dma-mapping.h |   97 ++++++++++++++++++++++----------
 arch/powerpc/kernel/dma.c              |   35 +++++++++++
 2 files changed, 102 insertions(+), 30 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index 3c4a2c2..7edab27 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -76,6 +76,26 @@ struct dma_mapping_ops {
 				dma_addr_t dma_address, size_t size,
 				enum dma_data_direction direction,
 				struct dma_attrs *attrs);
+	void            (*sync_single_for_cpu)(struct device *hwdev,
+				dma_addr_t dma_handle, size_t size,
+				enum dma_data_direction direction);
+	void            (*sync_single_for_device)(struct device *hwdev,
+				dma_addr_t dma_handle, size_t size,
+				enum dma_data_direction direction);
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
 };
 
 /*
@@ -286,42 +306,75 @@ static inline void dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size,
 		enum dma_data_direction direction)
 {
-	BUG_ON(direction == DMA_NONE);
-	__dma_sync(bus_to_virt(dma_handle), size, direction);
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
+
+	BUG_ON(!dma_ops);
+	if (dma_ops->sync_single_for_cpu != NULL)
+		dma_ops->sync_single_for_cpu(dev, dma_handle, size,
+					     direction);
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
+
+	if (dma_ops->sync_single_for_device != NULL)
+		dma_ops->sync_single_for_device(dev, dma_handle,
+						size, direction);
 }
 
 static inline void dma_sync_sg_for_cpu(struct device *dev,
 		struct scatterlist *sgl, int nents,
 		enum dma_data_direction direction)
 {
-	struct scatterlist *sg;
-	int i;
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 
-	BUG_ON(direction == DMA_NONE);
+	BUG_ON(!dma_ops);
 
-	for_each_sg(sgl, sg, nents, i)
-		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
+	if (dma_ops->sync_sg_for_cpu != NULL)
+		dma_ops->sync_sg_for_cpu(dev, sgl, nents, direction);
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
 
-	for_each_sg(sgl, sg, nents, i)
-		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
+	if (dma_ops->sync_sg_for_device != NULL)
+		dma_ops->sync_sg_for_device(dev, sgl, nents, direction);
+}
+
+static inline void dma_sync_single_range_for_cpu(struct device *dev,
+		dma_addr_t dma_handle, unsigned long offset, size_t size,
+		enum dma_data_direction direction)
+{
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
+
+	BUG_ON(!dma_ops);
+
+	if (dma_ops->sync_single_range_for_cpu != NULL)
+		dma_ops->sync_single_range_for_cpu(dev, dma_handle,
+						   offset, size, direction);
+}
+
+static inline void dma_sync_single_range_for_device(struct device *dev,
+		dma_addr_t dma_handle, unsigned long offset, size_t size,
+		enum dma_data_direction direction)
+{
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
+
+	BUG_ON(!dma_ops);
+
+	if (dma_ops->sync_single_range_for_device != NULL)
+		dma_ops->sync_single_range_for_device(dev, dma_handle, offset,
+						      size, direction);
 }
 
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
@@ -356,22 +409,6 @@ static inline int dma_get_cache_alignment(void)
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
index 1562daf..93f15b4 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -119,6 +119,35 @@ static inline void dma_direct_unmap_page(struct device *dev,
 {
 }
 
+static inline void dma_direct_sync_single(struct device *dev,
+		dma_addr_t dma_handle, size_t size,
+		enum dma_data_direction direction)
+{
+	BUG_ON(direction == DMA_NONE);
+	__dma_sync(bus_to_virt(dma_handle), size, direction);
+}
+
+static inline void dma_direct_sync_sg(struct device *dev,
+		struct scatterlist *sgl, int nents,
+		enum dma_data_direction direction)
+{
+	struct scatterlist *sg;
+	int i;
+
+	BUG_ON(direction == DMA_NONE);
+
+	for_each_sg(sgl, sg, nents, i)
+		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
+}
+
+static inline void dma_direct_sync_single_range(struct device *dev,
+		dma_addr_t dma_handle, unsigned long offset, size_t size,
+		enum dma_data_direction direction)
+{
+	/* just sync everything for now */
+	dma_direct_sync_single(dev, dma_handle, offset + size, direction);
+}
+
 struct dma_mapping_ops dma_direct_ops = {
 	.alloc_coherent	= dma_direct_alloc_coherent,
 	.free_coherent	= dma_direct_free_coherent,
@@ -127,5 +156,11 @@ struct dma_mapping_ops dma_direct_ops = {
 	.dma_supported	= dma_direct_dma_supported,
 	.map_page	= dma_direct_map_page,
 	.unmap_page	= dma_direct_unmap_page,
+	.sync_single_for_cpu 		= dma_direct_sync_single,
+	.sync_single_for_device 	= dma_direct_sync_single,
+	.sync_single_range_for_cpu 	= dma_direct_sync_single_range,
+	.sync_single_range_for_device 	= dma_direct_sync_single_range,
+	.sync_sg_for_cpu 		= dma_direct_sync_sg,
+	.sync_sg_for_device 		= dma_direct_sync_sg,
 };
 EXPORT_SYMBOL(dma_direct_ops);
-- 
1.5.6.5
