Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <8a166cbe25152a5f4895d83469d34d5814d45661.1193381582.git.michael@ellerman.id.au>
In-Reply-To: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
References: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 05/16] Use of_get_next_parent() in
	pci_dma_dev_setup_pSeriesLP()
Date: Fri, 26 Oct 2007 16:54:35 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pci_dma_dev_setup_pSeriesLP() should use of_get_next_parent() to safely
iterate through the parent nodes.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/iommu.c |   12 ++++++++----
 1 files changed, 8 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 5e9430e..ef1aa8d 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -503,8 +503,9 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	dn = pci_device_to_OF_node(dev);
 	DBG("  node is %s\n", dn->full_name);
 
-	for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->iommu_table;
-	     pdn = pdn->parent) {
+	for (pdn = of_node_get(dn);
+	     pdn && PCI_DN(pdn) && !PCI_DN(pdn)->iommu_table;
+	     pdn = of_get_next_parent(pdn)) {
 		dma_window = of_get_property(pdn, "ibm,dma-window", NULL);
 		if (dma_window)
 			break;
@@ -514,7 +515,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 		printk(KERN_WARNING "pci_dma_dev_setup_pSeriesLP: "
 		       "no DMA window found for pci dev=%s dn=%s\n",
 				 pci_name(dev), dn? dn->full_name : "<null>");
-		return;
+		goto out_put;
 	}
 	DBG("  parent is %s\n", pdn->full_name);
 
@@ -524,7 +525,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	if (dma_window == NULL || pdn->parent == NULL) {
 		DBG("  no dma window for device, linking to parent\n");
 		dev->dev.archdata.dma_data = PCI_DN(pdn)->iommu_table;
-		return;
+		goto out_put;
 	}
 
 	pci = PCI_DN(pdn);
@@ -544,6 +545,9 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	}
 
 	dev->dev.archdata.dma_data = pci->iommu_table;
+
+out_put:
+	of_node_put(pdn);
 }
 #else  /* CONFIG_PCI */
 #define pci_dma_bus_setup_pSeries	NULL
-- 
1.5.2.rc1.1884.g59b20
