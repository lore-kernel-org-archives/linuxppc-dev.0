Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <4108415683edeb799fd4880a8dba3e9f27a34415.1204097262.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/8] Clearup cell IOMMU fixed mapping terminology
Date: Wed, 27 Feb 2008 18:28:14 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

It's called the fixed mapping, not the static mapping.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |    8 ++++----
 1 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index edab631..bbe8389 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -549,7 +549,7 @@ static void cell_dma_dev_setup_iommu(struct device *dev)
 	archdata->dma_data = &window->table;
 }
 
-static void cell_dma_dev_setup_static(struct device *dev);
+static void cell_dma_dev_setup_fixed(struct device *dev);
 
 static void cell_dma_dev_setup(struct device *dev)
 {
@@ -557,7 +557,7 @@ static void cell_dma_dev_setup(struct device *dev)
 
 	/* Order is important here, these are not mutually exclusive */
 	if (get_dma_ops(dev) == &dma_iommu_fixed_ops)
-		cell_dma_dev_setup_static(dev);
+		cell_dma_dev_setup_fixed(dev);
 	else if (get_pci_dma_ops() == &dma_iommu_ops)
 		cell_dma_dev_setup_iommu(dev);
 	else if (get_pci_dma_ops() == &dma_direct_ops)
@@ -858,7 +858,7 @@ static int dma_set_mask_and_switch(struct device *dev, u64 dma_mask)
 	return 0;
 }
 
-static void cell_dma_dev_setup_static(struct device *dev)
+static void cell_dma_dev_setup_fixed(struct device *dev)
 {
 	struct dev_archdata *archdata = &dev->archdata;
 	u64 addr;
@@ -894,7 +894,7 @@ static void cell_iommu_setup_fixed_ptab(struct cbe_iommu *iommu,
 	for (i = fbase; i < fbase + fsize; i++, uaddr += IOMMU_PAGE_SIZE) {
 		/* Don't touch the dynamic region */
 		if (i >= dbase && i < (dbase + dsize)) {
-			pr_debug("iommu: static/dynamic overlap, skipping\n");
+			pr_debug("iommu: fixed/dynamic overlap, skipping\n");
 			continue;
 		}
 		io_pte[i] = base_pte | (__pa(uaddr) & IOPTE_RPN_Mask);
-- 
1.5.2.rc1.1884.g59b20
