Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <2949748ba6ad7e14f0768ac3889267e42c050d7a.1200894155.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 1/7] Set archdata.dma_data for direct DMA in
	cell_dma_dev_setup()
Date: Mon, 21 Jan 2008 16:42:41 +1100 (EST)
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Store the direct_dma_offset in each device's dma_data in the case
where we're using the direct DMA ops.

We need to make sure we setup the ppc_md.pci_dma_dev_setup() callback
if we're using a non-zero offset.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/iommu.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/cell/iommu.c b/arch/powerpc/platforms/cell/iommu.c
index bceb5e1..9682b63 100644
--- a/arch/powerpc/platforms/cell/iommu.c
+++ b/arch/powerpc/platforms/cell/iommu.c
@@ -496,9 +496,10 @@ static void cell_dma_dev_setup(struct device *dev)
 	struct cbe_iommu *iommu;
 	struct dev_archdata *archdata = &dev->archdata;
 
-	/* If we run without iommu, no need to do anything */
-	if (get_pci_dma_ops() == &dma_direct_ops)
+	if (get_pci_dma_ops() == &dma_direct_ops) {
+		archdata->dma_data = (void *)dma_direct_offset;
 		return;
+	}
 
 	/* Current implementation uses the first window available in that
 	 * node's iommu. We -might- do something smarter later though it may
@@ -690,6 +691,9 @@ static int __init cell_iommu_init_disabled(void)
 
 	dma_direct_offset += base;
 
+	if (dma_direct_offset != 0)
+		ppc_md.pci_dma_dev_setup = cell_pci_dma_dev_setup;
+
 	printk("iommu: disabled, direct DMA offset is 0x%lx\n",
 	       dma_direct_offset);
 
-- 
1.5.2.rc1.1884.g59b20
