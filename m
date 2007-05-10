Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: paulus@samba.org
MIME-Version: 1.0
Subject: [PATCH] minor pSeries IOMMU debug cleanup
Date: Thu, 10 May 2007 15:16:27 +1000
Message-ID: <20106.1178774187@neuling.org>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pci is not initialized before being used here, so this debug print is
bogus at the current location.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/platforms/pseries/iommu.c |    3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

Index: linux-2.6-ozlabs/arch/powerpc/platforms/pseries/iommu.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/platforms/pseries/iommu.c
+++ linux-2.6-ozlabs/arch/powerpc/platforms/pseries/iommu.c
@@ -520,7 +520,6 @@ static void pci_dma_dev_setup_pSeriesLP(
 		dev->dev.archdata.dma_data = PCI_DN(pdn)->iommu_table;
 		return;
 	}
-	DBG("  found DMA window, table: %p\n", pci->iommu_table);
 
 	pci = PCI_DN(pdn);
 	if (!pci->iommu_table) {
@@ -534,6 +533,8 @@ static void pci_dma_dev_setup_pSeriesLP(
 
 		pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
 		DBG("  created table: %p\n", pci->iommu_table);
+	} else {
+		DBG("  found DMA window, table: %p\n", pci->iommu_table);
 	}
 
 	dev->dev.archdata.dma_data = pci->iommu_table;
