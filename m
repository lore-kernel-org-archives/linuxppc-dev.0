Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 193A1DDF03
	for <linuxppc-dev@ozlabs.org>; Thu,  2 Oct 2008 08:03:22 +1000 (EST)
Received: from mailgate02.slac.stanford.edu (mailgate02.slac.stanford.edu
	[134.79.18.92])
	by nospam3.slac.stanford.edu (8.13.8/8.13.8) with ESMTP id
	m91M3KGo022793
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 15:03:20 -0700 (PDT)
	(envelope-from rmachet@slac.stanford.edu)
Received: from [134.79.128.151] (pcds-ts102.slac.stanford.edu [134.79.128.151])
	by mailgate02.slac.stanford.edu (8.13.8/8.13.8) with ESMTP id
	m91M3J5h019624
	for <linuxppc-dev@ozlabs.org>; Wed, 1 Oct 2008 15:03:20 -0700 (PDT)
	(envelope-from rmachet@slac.stanford.edu)
Subject: [PATCH] dma: add new dma_mapping_ops API sync_page
From: Remi Machet <rmachet@slac.stanford.edu>
To: Linux PPC <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Wed, 01 Oct 2008 15:03:19 -0700
Message-Id: <1222898599.8628.52.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch replaces the global APIs __dma_sync and __dma_sync_page
with a new dma_mapping_ops API named sync_page. This is necessary to make
sure that the proper synchronization mechanism is used for a device
DMA depending on the bus the device is on.

Signed-off-by: Remi Machet <rmachet@slac.stanford.edu>
---
This patch must be applied on top of Becky's serie of
patches "POWERPC: 32/64-bit DMA code merge and cleanup"
I checked it compiles on 32bits non-coherent, 32bits coherent and 64bits
targets but could only test it on a 32bits non-coherent target (c2k).

 include/asm/dma-mapping.h |   38 +++++++++++++++++++++++++++++++-------
 include/asm/io.h          |    3 +++
 kernel/dma.c              |   13 ++++++++++++-
 3 files changed, 46 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index fddb229..8e4cb19 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -82,6 +82,9 @@ struct dma_mapping_ops {
 				dma_addr_t dma_address, size_t size,
 				enum dma_data_direction direction,
 				struct dma_attrs *attrs);
+	void 		(*sync_page)(struct device *dev, struct page *page,
+				unsigned long offset, size_t size,
+				enum dma_data_direction direction);
 };
 
 /*
@@ -312,42 +315,58 @@ static inline void dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size,
 		enum dma_data_direction direction)
 {
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
+
 	BUG_ON(direction == DMA_NONE);
-	__dma_sync(bus_to_virt(dma_handle), size, direction);
+	if (dma_ops->sync_page != NULL)
+		dma_ops->sync_page(dev, bus_to_page(dma_handle),
+				(unsigned long)dma_handle & (PAGE_SIZE-1),
+				size, direction);
 }
 
 static inline void dma_sync_single_for_device(struct device *dev,
 		dma_addr_t dma_handle, size_t size,
 		enum dma_data_direction direction)
 {
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
+
 	BUG_ON(direction == DMA_NONE);
-	__dma_sync(bus_to_virt(dma_handle), size, direction);
+	if (dma_ops->sync_page != NULL)
+		dma_ops->sync_page(dev, bus_to_page(dma_handle),
+				(unsigned long)dma_handle & (PAGE_SIZE-1),
+				size, direction);
 }
 
 static inline void dma_sync_sg_for_cpu(struct device *dev,
 		struct scatterlist *sgl, int nents,
 		enum dma_data_direction direction)
 {
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 	struct scatterlist *sg;
 	int i;
 
 	BUG_ON(direction == DMA_NONE);
 
-	for_each_sg(sgl, sg, nents, i)
-		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
+	if (dma_ops->sync_page != NULL)
+		for_each_sg(sgl, sg, nents, i)
+			dma_ops->sync_page(dev, sg_page(sg), sg->offset,
+					sg->length, direction);
 }
 
 static inline void dma_sync_sg_for_device(struct device *dev,
 		struct scatterlist *sgl, int nents,
 		enum dma_data_direction direction)
 {
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
 	struct scatterlist *sg;
 	int i;
 
 	BUG_ON(direction == DMA_NONE);
 
-	for_each_sg(sgl, sg, nents, i)
-		__dma_sync_page(sg_page(sg), sg->offset, sg->length, direction);
+	if (dma_ops->sync_page != NULL)
+		for_each_sg(sgl, sg, nents, i)
+			dma_ops->sync_page(dev, sg_page(sg), sg->offset,
+					sg->length, direction);
 }
 
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
@@ -401,8 +420,13 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
 static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		enum dma_data_direction direction)
 {
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
+
 	BUG_ON(direction == DMA_NONE);
-	__dma_sync(vaddr, size, (int)direction);
+	if (dma_ops->sync_page != NULL)
+		dma_ops->sync_page(dev, virt_to_page(vaddr),
+					(unsigned long)vaddr & (PAGE_SIZE-1),
+					size, direction);
 }
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 77c7fa0..4dc5325 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -746,6 +746,9 @@ static inline void * bus_to_virt(unsigned long address)
 
 #endif /* CONFIG_PPC32 */
 
+#define bus_to_page(address)	pfn_to_page((address - PCI_DRAM_OFFSET) \
+						>> PAGE_SHIFT)
+
 /* access ports */
 #define setbits32(_addr, _v) out_be32((_addr), in_be32(_addr) |  (_v))
 #define clrbits32(_addr, _v) out_be32((_addr), in_be32(_addr) & ~(_v))
diff --git a/arch/powerpc/kernel/dma.c b/arch/powerpc/kernel/dma.c
index 41fdd48..aab7041 100644
--- a/arch/powerpc/kernel/dma.c
+++ b/arch/powerpc/kernel/dma.c
@@ -95,6 +95,14 @@ static int dma_direct_dma_supported(struct device *dev, u64 mask)
 #endif
 }
 
+static void dma_direct_sync_page(struct device *dev, struct page *page,
+	unsigned long offset, size_t size, enum dma_data_direction direction)
+{
+#ifdef CONFIG_NOT_COHERENT_CACHE
+	__dma_sync_page(page, offset, size, (int)direction);
+#endif
+}
+
 static inline dma_addr_t dma_direct_map_page(struct device *dev,
 					     struct page *page,
 					     unsigned long offset,
@@ -103,7 +111,7 @@ static inline dma_addr_t dma_direct_map_page(struct device *dev,
 					     struct dma_attrs *attrs)
 {
 	BUG_ON(dir == DMA_NONE);
-	__dma_sync_page(page, offset, size, dir);
+	dma_direct_sync_page(dev, page, offset, size, dir);
 	return page_to_phys(page) + offset + get_dma_direct_offset(dev);
 }
 
@@ -123,5 +131,8 @@ struct dma_mapping_ops dma_direct_ops = {
 	.dma_supported	= dma_direct_dma_supported,
 	.map_page	= dma_direct_map_page,
 	.unmap_page	= dma_direct_unmap_page,
+#ifdef CONFIG_NOT_COHERENT_CACHE
+	.sync_page	= dma_direct_sync_page,
+#endif
 };
 EXPORT_SYMBOL(dma_direct_ops);
