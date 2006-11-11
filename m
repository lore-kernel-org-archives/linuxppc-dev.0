Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Sat, 11 Nov 2006 17:25:17 +1100
Subject: [PATCH 28/32] powerpc: Make cell use direct DMA ops
In-Reply-To: <1163226282.72526.823314634857.qpush@butch>
Message-Id: <20061111062547.92CAD684B2@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Now that the direct DMA ops supports an offset, we use that instead
of defining our own.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>


 arch/powerpc/platforms/cell/iommu.c |   79 ++----------------------------------
 1 file changed, 6 insertions(+), 73 deletions(-)

Index: linux-cell/arch/powerpc/platforms/cell/iommu.c
===================================================================
--- linux-cell.orig/arch/powerpc/platforms/cell/iommu.c	2006-11-07 16:45:08.000000000 +1100
+++ linux-cell/arch/powerpc/platforms/cell/iommu.c	2006-11-07 16:48:00.000000000 +1100
@@ -46,8 +46,6 @@
 
 #include "iommu.h"
 
-static dma_addr_t cell_dma_valid = SPIDER_DMA_VALID;
-
 static inline unsigned long 
 get_iopt_entry(unsigned long real_address, unsigned long ioid,
 			 unsigned long prot)
@@ -417,83 +415,18 @@ static int cell_map_iommu(void)
 	return 1;
 }
 
-static void *cell_alloc_coherent(struct device *hwdev, size_t size,
-			   dma_addr_t *dma_handle, gfp_t flag)
-{
-	void *ret;
-
-	ret = (void *)__get_free_pages(flag, get_order(size));
-	if (ret != NULL) {
-		memset(ret, 0, size);
-		*dma_handle = virt_to_abs(ret) | cell_dma_valid;
-	}
-	return ret;
-}
-
-static void cell_free_coherent(struct device *hwdev, size_t size,
-				 void *vaddr, dma_addr_t dma_handle)
-{
-	free_pages((unsigned long)vaddr, get_order(size));
-}
-
-static dma_addr_t cell_map_single(struct device *hwdev, void *ptr,
-		size_t size, enum dma_data_direction direction)
-{
-	return virt_to_abs(ptr) | cell_dma_valid;
-}
-
-static void cell_unmap_single(struct device *hwdev, dma_addr_t dma_addr,
-		size_t size, enum dma_data_direction direction)
-{
-}
-
-static int cell_map_sg(struct device *hwdev, struct scatterlist *sg,
-		int nents, enum dma_data_direction direction)
-{
-	int i;
-
-	for (i = 0; i < nents; i++, sg++) {
-		sg->dma_address = (page_to_phys(sg->page) + sg->offset)
-					| cell_dma_valid;
-		sg->dma_length = sg->length;
-	}
-
-	return nents;
-}
-
-static void cell_unmap_sg(struct device *hwdev, struct scatterlist *sg,
-		int nents, enum dma_data_direction direction)
-{
-}
-
-static int cell_dma_supported(struct device *dev, u64 mask)
-{
-	return mask < 0x100000000ull;
-}
-
-static struct dma_mapping_ops cell_iommu_ops = {
-	.alloc_coherent = cell_alloc_coherent,
-	.free_coherent = cell_free_coherent,
-	.map_single = cell_map_single,
-	.unmap_single = cell_unmap_single,
-	.map_sg = cell_map_sg,
-	.unmap_sg = cell_unmap_sg,
-	.dma_supported = cell_dma_supported,
-};
-
 void cell_init_iommu(void)
 {
 	int setup_bus = 0;
 
-	/* If we have an Axon bridge, clear the DMA valid mask. This is fairly
-	 * hackish but will work well enough until we have proper iommu code.
-	 */
-	if (of_find_node_by_name(NULL, "axon"))
-		cell_dma_valid = 0;
-
 	if (of_find_node_by_path("/mambo")) {
 		pr_info("Not using iommu on systemsim\n");
 	} else {
+		/* If we don't have an Axon bridge, we assume we have a
+		 * spider which requires a DMA offset
+		 */
+		if (of_find_node_by_name(NULL, "axon") == NULL)
+			dma_direct_offset = SPIDER_DMA_VALID;
 
 		if (!(of_chosen &&
 		      get_property(of_chosen, "linux,iommu-off", NULL)))
@@ -509,5 +442,5 @@ void cell_init_iommu(void)
 		}
 	}
 
-	pci_dma_ops = &cell_iommu_ops;
+	pci_dma_ops = &dma_direct_ops;
 }
