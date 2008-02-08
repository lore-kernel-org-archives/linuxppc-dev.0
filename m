Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <dd3f371c284d86bf912a262e761fe8eb60389237.1202449018.git.michael@ellerman.id.au>
In-Reply-To: <3aa63ba024ba35ff3bf5b5f1d6aec2efa9782ba5.1202449018.git.michael@ellerman.id.au>
References: <3aa63ba024ba35ff3bf5b5f1d6aec2efa9782ba5.1202449018.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 3/4] Fix potential cell IOMMU bug when switching back to
	default DMA ops
Date: Fri,  8 Feb 2008 16:37:04 +1100 (EST)
Cc: cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

If we get a 64-bit dma mask we switch to the fixed ops and call
cell_dma_dev_setup(). If the driver then switches back to a 32-bit dma
mask for any reason we don't call cell_dma_dev_setup() again, which
has the potential to leave bogus data in dev->archdata.dma_data.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |   15 +++++++--------
 1 files changed, 7 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index 1f7b254..5cdcd36 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -841,19 +841,18 @@ static int dma_set_mask_and_switch(struct device *dev, u64 dma_mask)
 	if (!dev->dma_mask || !dma_supported(dev, dma_mask))
 		return -EIO;
 
-	if (dma_mask == DMA_BIT_MASK(64)) {
-		if (cell_iommu_get_fixed_address(dev) == OF_BAD_ADDR)
-			dev_dbg(dev, "iommu: 64-bit OK, but bad addr\n");
-		else {
-			dev_dbg(dev, "iommu: 64-bit OK, using fixed ops\n");
-			set_dma_ops(dev, &dma_iommu_fixed_ops);
-			cell_dma_dev_setup(dev);
-		}
+	if (dma_mask == DMA_BIT_MASK(64) &&
+		cell_iommu_get_fixed_address(dev) != OF_BAD_ADDR)
+	{
+		dev_dbg(dev, "iommu: 64-bit OK, using fixed ops\n");
+		set_dma_ops(dev, &dma_iommu_fixed_ops);
 	} else {
 		dev_dbg(dev, "iommu: not 64-bit, using default ops\n");
 		set_dma_ops(dev, get_pci_dma_ops());
 	}
 
+	cell_dma_dev_setup(dev);
+
 	*dev->dma_mask = dma_mask;
 
 	return 0;
-- 
1.5.2.rc1.1884.g59b20
