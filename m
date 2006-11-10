Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Fri, 10 Nov 2006 18:45:02 +1100
Subject: [PATCH 22/32] powerpc: Cell fixup DMA offset for new southbridge
In-Reply-To: <1163144683.554182.685908332811.qpush@grosgo>
Message-Id: <20061110074505.8063E67EFF@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch makes the Cell DMA code work on both the Spider and the Axon
south bridges by turning cell_dma_valid into a variable instead of a
constant. This is a temporary patch until we have full iommu support.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/platforms/cell/iommu.c |   14 +++++++++++---
 arch/powerpc/platforms/cell/iommu.h |    8 +++++---
 2 files changed, 16 insertions(+), 6 deletions(-)

Index: linux-cell/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/iommu.c	2006-10-27 15:42:15.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/cell/iommu.c	2006-10-27 15:55:13.000000000 +1000
@@ -46,6 +46,8 @@
 
 #include "iommu.h"
 
+static dma_addr_t cell_dma_valid = SPIDER_DMA_VALID;
+
 static inline unsigned long 
 get_iopt_entry(unsigned long real_address, unsigned long ioid,
 			 unsigned long prot)
@@ -423,7 +425,7 @@ static void *cell_alloc_coherent(struct 
 	ret = (void *)__get_free_pages(flag, get_order(size));
 	if (ret != NULL) {
 		memset(ret, 0, size);
-		*dma_handle = virt_to_abs(ret) | CELL_DMA_VALID;
+		*dma_handle = virt_to_abs(ret) | cell_dma_valid;
 	}
 	return ret;
 }
@@ -437,7 +439,7 @@ static void cell_free_coherent(struct de
 static dma_addr_t cell_map_single(struct device *hwdev, void *ptr,
 		size_t size, enum dma_data_direction direction)
 {
-	return virt_to_abs(ptr) | CELL_DMA_VALID;
+	return virt_to_abs(ptr) | cell_dma_valid;
 }
 
 static void cell_unmap_single(struct device *hwdev, dma_addr_t dma_addr,
@@ -452,7 +454,7 @@ static int cell_map_sg(struct device *hw
 
 	for (i = 0; i < nents; i++, sg++) {
 		sg->dma_address = (page_to_phys(sg->page) + sg->offset)
-					| CELL_DMA_VALID;
+					| cell_dma_valid;
 		sg->dma_length = sg->length;
 	}
 
@@ -483,6 +485,12 @@ void cell_init_iommu(void)
 {
 	int setup_bus = 0;
 
+	/* If we have an Axon bridge, clear the DMA valid mask. This is fairly
+	 * hackish but will work well enough until we have proper iommu code.
+	 */
+	if (of_find_node_by_name(NULL, "axon"))
+		cell_dma_valid = 0;
+
 	if (of_find_node_by_path("/mambo")) {
 		pr_info("Not using iommu on systemsim\n");
 	} else {
Index: linux-cell/arch/powerpc/platforms/cell/iommu.h
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/iommu.h	2006-10-27 15:49:10.000000000 +1000
+++ linux-cell/arch/powerpc/platforms/cell/iommu.h	2006-10-27 15:52:19.000000000 +1000
@@ -53,9 +53,11 @@ enum {
 	IOC_ST_ORIGIN     = 0x918,
 	IOC_CONF	  = 0x930,
 
-	/* The high bit needs to be set on every DMA address,
-	   only 2GB are addressable */
-	CELL_DMA_VALID	  = 0x80000000,
+	/* The high bit needs to be set on every DMA address when using
+	 * a spider bridge and only 2GB are addressable with the current
+	 * iommu code.
+	 */
+	SPIDER_DMA_VALID  = 0x80000000,
 	CELL_DMA_MASK	  = 0x7fffffff,
 };
 
