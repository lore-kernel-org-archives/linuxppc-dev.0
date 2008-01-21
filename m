Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <e9ff0b0489aa17d36387d252811c2846976684fd.1200894155.git.michael@ellerman.id.au>
In-Reply-To: <2949748ba6ad7e14f0768ac3889267e42c050d7a.1200894155.git.michael@ellerman.id.au>
References: <2949748ba6ad7e14f0768ac3889267e42c050d7a.1200894155.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 5/7] Have celleb use its own dma_direct_offset variable
Date: Mon, 21 Jan 2008 16:42:46 +1100 (EST)
Cc: Arnd Bergmann <arnd.bergmann@de.ibm.com>, cbe-oss-dev@ozlabs.org
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
index 843a66f..93b0efd 100644
--- a/arch/powerpc/platforms/celleb/iommu.c
+++ b/arch/powerpc/platforms/celleb/iommu.c
@@ -52,6 +52,8 @@ static int __init find_dma_window(u64 *io_space_id, u64 *ioid,
 	return 0;
 }
 
+static unsigned long celleb_dma_direct_offset;
+
 static void __init celleb_init_direct_mapping(void)
 {
 	u64 lpar_addr, io_addr;
@@ -69,13 +71,13 @@ static void __init celleb_init_direct_mapping(void)
 				     ioid, DMA_FLAGS);
 	}
 
-	dma_direct_offset = dma_base;
+	celleb_dma_direct_offset = dma_base;
 }
 
 static void celleb_dma_dev_setup(struct device *dev)
 {
 	dev->archdata.dma_ops = get_pci_dma_ops();
-	dev->archdata.dma_data = (void *)dma_direct_offset;
+	dev->archdata.dma_data = (void *)celleb_dma_direct_offset;
 }
 
 static void celleb_pci_dma_dev_setup(struct pci_dev *pdev)
-- 
1.5.2.rc1.1884.g59b20
