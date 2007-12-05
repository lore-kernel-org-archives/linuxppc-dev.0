Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <ac4252cfbaa0c1a3534443007417dfc43b597eb5.1196839256.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/7] Set archdata.dma_data for direct DMA in
	cell_dma_dev_setup()
Date: Wed,  5 Dec 2007 18:20:57 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Store a pointer to the direct_dma_offset in each device's dma_data
in the case where we're using the direct DMA ops.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |    5 +++--
 1 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index faabc3f..2edb1ad 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -495,9 +495,10 @@ static void cell_dma_dev_setup(struct device *dev)
 	struct cbe_iommu *iommu;
 	struct dev_archdata *archdata = &dev->archdata;
 
-	/* If we run without iommu, no need to do anything */
-	if (get_pci_dma_ops() == &dma_direct_ops)
+	if (get_pci_dma_ops() == &dma_direct_ops) {
+		archdata->dma_data = &dma_direct_offset;
 		return;
+	}
 
 	/* Current implementation uses the first window available in that
 	 * node's iommu. We -might- do something smarter later though it may
-- 
1.5.3.7.1.g4e596e
