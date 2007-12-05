Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <2b8d160d8baf8570781441808cd117dd5e34f703.1196839256.git.michael@ellerman.id.au>
In-Reply-To: <ac4252cfbaa0c1a3534443007417dfc43b597eb5.1196839256.git.michael@ellerman.id.au>
References: <ac4252cfbaa0c1a3534443007417dfc43b597eb5.1196839256.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 5/7] Have celleb use its own dma_direct_offset variable
Date: Wed,  5 Dec 2007 18:21:03 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Rather than using the global variable, have celleb use its own variable to
store the direct DMA offset.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/celleb/iommu.c |    6 ++++--
 1 files changed, 4 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/platforms/celleb/iommu.c b/arch/powerpc/platforms/celleb/iommu.c
index 04d5678..85af76f 100644
--- a/arch/powerpc/platforms/celleb/iommu.c
+++ b/arch/powerpc/platforms/celleb/iommu.c
@@ -51,6 +51,8 @@ static int __init find_dma_window(u64 *io_space_id, u64 *ioid,
 	return 0;
 }
 
+static unsigned long celleb_dma_direct_offset;
+
 static void __init celleb_init_direct_mapping(void)
 {
 	u64 lpar_addr, io_addr;
@@ -68,13 +70,13 @@ static void __init celleb_init_direct_mapping(void)
 				     ioid, DMA_FLAGS);
 	}
 
-	dma_direct_offset = dma_base;
+	celleb_dma_direct_offset = dma_base;
 }
 
 static void celleb_dma_dev_setup(struct device *dev)
 {
 	dev->archdata.dma_ops = get_pci_dma_ops();
-	dev->archdata.dma_data = &dma_direct_offset;
+	dev->archdata.dma_data = &celleb_dma_direct_offset;
 }
 
 static void celleb_pci_dma_dev_setup(struct pci_dev *pdev)
-- 
1.5.3.7.1.g4e596e
