Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <4058299ab263711f8d57d53b23a11b363db33395.1196839256.git.michael@ellerman.id.au>
In-Reply-To: <ac4252cfbaa0c1a3534443007417dfc43b597eb5.1196839256.git.michael@ellerman.id.au>
References: <ac4252cfbaa0c1a3534443007417dfc43b597eb5.1196839256.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 4/7] Have cell use its own dma_direct_offset variable
Date: Wed,  5 Dec 2007 18:21:01 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rather than using the global variable, have cell use its own variable to
store the direct DMA offset.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |   10 ++++++----
 1 files changed, 6 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 2edb1ad..d2f9242 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -489,6 +489,8 @@ static struct cbe_iommu *cell_iommu_for_node(int nid)
 	return NULL;
 }
 
+static unsigned long cell_dma_direct_offset;
+
 static void cell_dma_dev_setup(struct device *dev)
 {
 	struct iommu_window *window;
@@ -496,7 +498,7 @@ static void cell_dma_dev_setup(struct device *dev)
 	struct dev_archdata *archdata = &dev->archdata;
 
 	if (get_pci_dma_ops() == &dma_direct_ops) {
-		archdata->dma_data = &dma_direct_offset;
+		archdata->dma_data = &cell_dma_direct_offset;
 		return;
 	}
 
@@ -654,7 +656,7 @@ static int __init cell_iommu_init_disabled(void)
 
 	/* If we have no Axon, we set up the spider DMA magic offset */
 	if (of_find_node_by_name(NULL, "axon") == NULL)
-		dma_direct_offset = SPIDER_DMA_OFFSET;
+		cell_dma_direct_offset = SPIDER_DMA_OFFSET;
 
 	/* Now we need to check to see where the memory is mapped
 	 * in PCI space. We assume that all busses use the same dma
@@ -688,10 +690,10 @@ static int __init cell_iommu_init_disabled(void)
 		return -ENODEV;
 	}
 
-	dma_direct_offset += base;
+	cell_dma_direct_offset += base;
 
 	printk("iommu: disabled, direct DMA offset is 0x%lx\n",
-	       dma_direct_offset);
+	       cell_dma_direct_offset);
 
 	return 0;
 }
-- 
1.5.3.7.1.g4e596e
