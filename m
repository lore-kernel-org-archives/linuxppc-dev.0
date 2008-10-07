Return-Path: <rmachet@slac.stanford.edu>
Received: from nospam3.slac.stanford.edu (nospam3.slac.stanford.edu
	[134.79.18.120])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 4E976DDF2E
	for <linuxppc-dev@ozlabs.org>; Wed,  8 Oct 2008 08:05:55 +1100 (EST)
Subject: [PATCH 2/3] powerpc: dma code cleanup
From: Remi Machet <rmachet@slac.stanford.edu>
To: Linux PPC <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Date: Tue, 07 Oct 2008 14:05:44 -0700
Message-Id: <1223413545.17585.29.camel@pcds-ts102.slac.stanford.edu>
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Code cleanup in arch/powerpc/include/asm/dma-mapping.h and 
arch/powerpc/include/asm/io.h. 

I replaced _dma_sync and _dma_sync_page with a new dma_mapping_ops 
API called sync: this is necessary to make sure that the proper 
synchronization mechanism is used for each device on a platform 
where multiple DMA architecture would co-exist.

Removed the page_to_bus macro which is not used anymore.

Added the hook to use the new dma-noncoherent code if 
CONFIG_NOT_COHERENT_CACHE is set.

Signed-off-by: Remi Machet <rmachet@slac.stanford.edu>
---

 dma-mapping.h |   69 ++++++++++++++++++++++++++++++----------------------------
 io.h          |    6 -----
 2 files changed, 36 insertions(+), 39 deletions(-)

diff --git a/arch/powerpc/include/asm/dma-mapping.h b/arch/powerpc/include/asm/dma-mapping.h
index fddb229..3328244 100644
--- a/arch/powerpc/include/asm/dma-mapping.h
+++ b/arch/powerpc/include/asm/dma-mapping.h
@@ -18,32 +18,6 @@
 
 #define DMA_ERROR_CODE		(~(dma_addr_t)0x0)
 
-#ifdef CONFIG_NOT_COHERENT_CACHE
-/*
- * DMA-consistent mapping functions for PowerPCs that don't support
- * cache snooping.  These allocate/free a region of uncached mapped
- * memory space for use with DMA devices.  Alternatively, you could
- * allocate the space "normally" and use the cache management functions
- * to ensure it is consistent.
- */
-extern void *__dma_alloc_coherent(size_t size, dma_addr_t *handle, gfp_t gfp);
-extern void __dma_free_coherent(size_t size, void *vaddr);
-extern void __dma_sync(void *vaddr, size_t size, int direction);
-extern void __dma_sync_page(struct page *page, unsigned long offset,
-				 size_t size, int direction);
-
-#else /* ! CONFIG_NOT_COHERENT_CACHE */
-/*
- * Cache coherent cores.
- */
-
-#define __dma_alloc_coherent(gfp, size, handle)	NULL
-#define __dma_free_coherent(size, addr)		((void)0)
-#define __dma_sync(addr, size, rw)		((void)0)
-#define __dma_sync_page(pg, off, sz, rw)	((void)0)
-
-#endif /* ! CONFIG_NOT_COHERENT_CACHE */
-
 static inline unsigned long device_to_mask(struct device *dev)
 {
 	if (dev->dma_mask && *dev->dma_mask)
@@ -82,6 +56,8 @@ struct dma_mapping_ops {
 				dma_addr_t dma_address, size_t size,
 				enum dma_data_direction direction,
 				struct dma_attrs *attrs);
+	void 		(*sync)(struct device *dev, dma_addr_t dma_address,
+				size_t size, enum dma_data_direction direction);
 };
 
 /*
@@ -90,6 +66,9 @@ struct dma_mapping_ops {
 #ifdef CONFIG_PPC64
 extern struct dma_mapping_ops dma_iommu_ops;
 #endif
+#ifdef CONFIG_NOT_COHERENT_CACHE
+extern struct dma_mapping_ops dma_noncoherent_direct_ops;
+#endif
 extern struct dma_mapping_ops dma_direct_ops;
 
 static inline struct dma_mapping_ops *get_dma_ops(struct device *dev)
@@ -108,8 +87,12 @@ static inline struct dma_mapping_ops *get_dma_ops(struct device *dev)
 		/* TODO: Long term, we should fix drivers so that dev and
 		 * archdata dma_ops are set up for all buses.
 		 */
+#ifdef CONFIG_NOT_COHERENT_CACHE
+		return &dma_noncoherent_direct_ops;
+#else
 		return &dma_direct_ops;
 #endif
+#endif
 	}
 
 	return dev->archdata.dma_ops;
@@ -168,6 +151,8 @@ static inline dma_addr_t dma_map_single_attrs(struct device *dev,
 		return dma_ops->map_single(dev, cpu_addr, size, direction,
 					   attrs);
 
+	/* If vaddr is in high mem virt_to_page won't work */
+	BUG_ON(!virt_addr_valid(cpu_addr));
 	return dma_ops->map_page(dev, virt_to_page(cpu_addr),
 				 (unsigned long)cpu_addr % PAGE_SIZE, size,
 				 direction, attrs);
@@ -312,42 +297,54 @@ static inline void dma_sync_single_for_cpu(struct device *dev,
 		dma_addr_t dma_handle, size_t size,
 		enum dma_data_direction direction)
 {
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
+
 	BUG_ON(direction == DMA_NONE);
-	__dma_sync(bus_to_virt(dma_handle), size, direction);
+	if (dma_ops->sync != NULL)
+		dma_ops->sync(dev, dma_handle, size, direction);
 }
 
 static inline void dma_sync_single_for_device(struct device *dev,
 		dma_addr_t dma_handle, size_t size,
 		enum dma_data_direction direction)
 {
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
+
 	BUG_ON(direction == DMA_NONE);
-	__dma_sync(bus_to_virt(dma_handle), size, direction);
+	if (dma_ops->sync != NULL)
+		dma_ops->sync(dev, dma_handle, size, direction);
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
+	if (dma_ops->sync != NULL)
+		for_each_sg(sgl, sg, nents, i)
+			dma_ops->sync(dev, sg->dma_address,
+					sg->dma_length, direction);
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
+	if (dma_ops->sync != NULL)
+		for_each_sg(sgl, sg, nents, i)
+			dma_ops->sync(dev, sg->dma_address,
+					sg->dma_length, direction);
 }
 
 static inline int dma_mapping_error(struct device *dev, dma_addr_t dma_addr)
@@ -401,8 +398,14 @@ static inline void dma_sync_single_range_for_device(struct device *dev,
 static inline void dma_cache_sync(struct device *dev, void *vaddr, size_t size,
 		enum dma_data_direction direction)
 {
+	struct dma_mapping_ops *dma_ops = get_dma_ops(dev);
+
 	BUG_ON(direction == DMA_NONE);
-	__dma_sync(vaddr, size, (int)direction);
+	if (dma_ops->sync != NULL) {
+		/* If vaddr is in high mem virt_to_page won't work */
+		BUG_ON(!virt_addr_valid(vaddr));
+		dma_ops->sync(dev, virt_to_bus(vaddr), size, direction);
+	}
 }
 
 #endif /* __KERNEL__ */
diff --git a/arch/powerpc/include/asm/io.h b/arch/powerpc/include/asm/io.h
index 77c7fa0..fdb54d6 100644
--- a/arch/powerpc/include/asm/io.h
+++ b/arch/powerpc/include/asm/io.h
@@ -726,8 +726,6 @@ static inline void * phys_to_virt(unsigned long address)
  * drivers (shame shame shame) that use bus_to_virt() and haven't been
  * fixed yet so I need to define it here.
  */
-#ifdef CONFIG_PPC32
-
 static inline unsigned long virt_to_bus(volatile void * address)
 {
         if (address == NULL)
@@ -742,10 +740,6 @@ static inline void * bus_to_virt(unsigned long address)
         return __va(address - PCI_DRAM_OFFSET);
 }
 
-#define page_to_bus(page)	(page_to_phys(page) + PCI_DRAM_OFFSET)
-
-#endif /* CONFIG_PPC32 */
-
 /* access ports */
 #define setbits32(_addr, _v) out_be32((_addr), in_be32(_addr) |  (_v))
 #define clrbits32(_addr, _v) out_be32((_addr), in_be32(_addr) & ~(_v))
