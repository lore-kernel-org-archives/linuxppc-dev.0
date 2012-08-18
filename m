Return-Path: <aaro.koskinen@iki.fi>
Received: from filtteri5.pp.htv.fi (filtteri5.pp.htv.fi [213.243.153.188])
 by ozlabs.org (Postfix) with ESMTP id A17742C0098
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 19 Aug 2012 03:43:01 +1000 (EST)
From: Aaro Koskinen <aaro.koskinen@iki.fi>
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH] powerpc: dma-iommu: fix IOMMU window check
Date: Sat, 18 Aug 2012 20:34:15 +0300
Message-Id: <1345311255-30657-1-git-send-email-aaro.koskinen@iki.fi>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Checking for device mask to cover the whole IOMMU table is too strict.
IOMMU allocators should handle mask constraint properly for each
allocation.

The patch enables to use old AirPort Extreme cards on PowerMacs with
more than 1GB of memory; without the patch the driver init fails with:

  b43-pci-bridge 0001:01:01.0: Warning: IOMMU window too big for device mask
  b43-pci-bridge 0001:01:01.0: mask: 0x3fffffff, table end: 0x80000000
  b43-phy0 ERROR: The machine/kernel does not support the required 30-bit DMA mask

Signed-off-by: Aaro Koskinen <aaro.koskinen@iki.fi>
---
 arch/powerpc/kernel/dma-iommu.c |    9 ++++-----
 1 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/kernel/dma-iommu.c b/arch/powerpc/kernel/dma-iommu.c
index 2d7bb8c..e489752 100644
--- a/arch/powerpc/kernel/dma-iommu.c
+++ b/arch/powerpc/kernel/dma-iommu.c
@@ -83,11 +83,10 @@ static int dma_iommu_dma_supported(struct device *dev, u64 mask)
 		return 0;
 	}
 
-	if ((tbl->it_offset + tbl->it_size) > (mask >> IOMMU_PAGE_SHIFT)) {
-		dev_info(dev, "Warning: IOMMU window too big for device mask\n");
-		dev_info(dev, "mask: 0x%08llx, table end: 0x%08lx\n",
-				mask, (tbl->it_offset + tbl->it_size) <<
-				IOMMU_PAGE_SHIFT);
+	if (tbl->it_offset > (mask >> IOMMU_PAGE_SHIFT)) {
+		dev_info(dev, "Warning: IOMMU offset too big for device mask\n");
+		dev_info(dev, "mask: 0x%08llx, table offset: 0x%08lx\n",
+				mask, tbl->it_offset << IOMMU_PAGE_SHIFT);
 		return 0;
 	} else
 		return 1;
-- 
1.7.2.5
