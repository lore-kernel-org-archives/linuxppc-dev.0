Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 07 Nov 2006 18:22:58 +1100
Subject: [PATCH 25/31] powerpc: Add an optional offset to direct DMA on 64 bits
In-Reply-To: <1162884150.435786.961370643810.qpush@grosgo>
Message-Id: <20061107072416.61B3168337@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds an optional global offset that can be added to DMA addresses
when using the direct DMA operations.

That brings it a step closer to the 32 bits direct DMA operations, and makes
it useable on Cell when the MMU is disabled and we are using a spider
southbridge.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/kernel/dma_64.c      |   11 ++++++++---
 include/asm-powerpc/dma-mapping.h |    2 ++
 2 files changed, 10 insertions(+), 3 deletions(-)

Index: linux-cell/arch/powerpc/kernel/dma_64.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/dma_64.c	2006-11-06 16:38:19.000000000 +1100
+++ linux-cell/arch/powerpc/kernel/dma_64.c	2006-11-07 16:43:23.000000000 +1100
@@ -134,7 +134,11 @@ EXPORT_SYMBOL(dma_iommu_ops);
 
 /*
  * Generic direct DMA implementation
+ *
+ * This implementation supports a global offset that can be applied if
+ * the address at which memory is visible to devices is not 0.
  */
+unsigned long dma_direct_offset;
 
 static void *dma_direct_alloc_coherent(struct device *dev, size_t size,
 				       dma_addr_t *dma_handle, gfp_t flag)
@@ -145,7 +149,7 @@ static void *dma_direct_alloc_coherent(s
 	ret = (void *)__get_free_pages(flag, get_order(size));
 	if (ret != NULL) {
 		memset(ret, 0, size);
-		*dma_handle = virt_to_abs(ret);
+		*dma_handle = virt_to_abs(ret) | dma_direct_offset;
 	}
 	return ret;
 }
@@ -160,7 +164,7 @@ static dma_addr_t dma_direct_map_single(
 					size_t size,
 					enum dma_data_direction direction)
 {
-	return virt_to_abs(ptr);
+	return virt_to_abs(ptr) | dma_direct_offset;
 }
 
 static void dma_direct_unmap_single(struct device *dev, dma_addr_t dma_addr,
@@ -175,7 +179,8 @@ static int dma_direct_map_sg(struct devi
 	int i;
 
 	for (i = 0; i < nents; i++, sg++) {
-		sg->dma_address = page_to_phys(sg->page) + sg->offset;
+		sg->dma_address = (page_to_phys(sg->page) + sg->offset) |
+			dma_direct_offset;
 		sg->dma_length = sg->length;
 	}
 
Index: linux-cell/include/asm-powerpc/dma-mapping.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/dma-mapping.h	2006-11-06 16:38:19.000000000 +1100
+++ linux-cell/include/asm-powerpc/dma-mapping.h	2006-11-07 16:23:21.000000000 +1100
@@ -192,6 +192,8 @@ static inline void dma_unmap_sg(struct d
 extern struct dma_mapping_ops dma_iommu_ops;
 extern struct dma_mapping_ops dma_direct_ops;
 
+extern unsigned long dma_direct_offset;
+
 #else /* CONFIG_PPC64 */
 
 #define dma_supported(dev, mask)	(1)
