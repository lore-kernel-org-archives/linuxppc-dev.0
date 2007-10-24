Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <b1a6d99a117d0a0027e3f7dcef4a48f8df68893d.1193199823.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] Use of_get_parent() in pci_dma_dev_setup_pSeriesLP()
Date: Wed, 24 Oct 2007 14:24:20 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The loop to check parent nodes for a dma-window property in
pci_dma_dev_setup_pSeriesLP() does not use the of_* accessors and
does not properly manage refcounts, fix it to do so.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/iommu.c |   17 ++++++++++++-----
 1 files changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index be17d23..2c6fc3f 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -481,7 +481,7 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 
 static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 {
-	struct device_node *pdn, *dn;
+	struct device_node *pdn, *dn, *tmp;
 	struct iommu_table *tbl;
 	const void *dma_window = NULL;
 	struct pci_dn *pci;
@@ -497,18 +497,22 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	dn = pci_device_to_OF_node(dev);
 	DBG("  node is %s\n", dn->full_name);
 
-	for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->iommu_table;
-	     pdn = pdn->parent) {
+	pdn = of_node_get(dn);
+	while (pdn && PCI_DN(pdn) && !PCI_DN(pdn)->iommu_table) {
 		dma_window = of_get_property(pdn, "ibm,dma-window", NULL);
 		if (dma_window)
 			break;
+
+		tmp = of_get_parent(pdn);
+		of_node_put(pdn);
+		pdn = tmp;
 	}
 
 	if (!pdn || !PCI_DN(pdn)) {
 		printk(KERN_WARNING "pci_dma_dev_setup_pSeriesLP: "
 		       "no DMA window found for pci dev=%s dn=%s\n",
 				 pci_name(dev), dn? dn->full_name : "<null>");
-		return;
+		goto out_put;
 	}
 	DBG("  parent is %s\n", pdn->full_name);
 
@@ -518,7 +522,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	if (dma_window == NULL || pdn->parent == NULL) {
 		DBG("  no dma window for device, linking to parent\n");
 		dev->dev.archdata.dma_data = PCI_DN(pdn)->iommu_table;
-		return;
+		goto out_put;
 	}
 
 	pci = PCI_DN(pdn);
@@ -538,6 +542,9 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	}
 
 	dev->dev.archdata.dma_data = pci->iommu_table;
+
+out_put:
+	of_node_put(pdn);
 }
 #else  /* CONFIG_PCI */
 #define pci_dma_bus_setup_pSeries	NULL
-- 
1.5.1.3.g7a33b
