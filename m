Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <c1fa776aef619225a389570c2904c4baaa3dd76e.1208505275.git.michael@ellerman.id.au>
In-Reply-To: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
References: <fbb91d0892c720d6f28501e1830028c78eb6664f.1208505275.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 07/11] Convert from DBG() to pr_debug() in
	platforms/pseries/iommu.c
Date: Fri, 18 Apr 2008 17:54:40 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/iommu.c |   39 +++++++++++++++----------------
 1 files changed, 19 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index a65c763..176f1f3 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -47,7 +47,6 @@
 
 #include "plpar_wrappers.h"
 
-#define DBG(fmt...)
 
 static void tce_build_pSeries(struct iommu_table *tbl, long index,
 			      long npages, unsigned long uaddr,
@@ -322,7 +321,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 
 	dn = pci_bus_to_OF_node(bus);
 
-	DBG("pci_dma_bus_setup_pSeries: setting up bus %s\n", dn->full_name);
+	pr_debug("pci_dma_bus_setup_pSeries: setting up bus %s\n", dn->full_name);
 
 	if (bus->self) {
 		/* This is not a root bus, any setup will be done for the
@@ -347,7 +346,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	for (children = 0, tmp = dn->child; tmp; tmp = tmp->sibling)
 		children++;
 
-	DBG("Children: %d\n", children);
+	pr_debug("Children: %d\n", children);
 
 	/* Calculate amount of DMA window per slot. Each window must be
 	 * a power of two (due to pci_alloc_consistent requirements).
@@ -361,8 +360,8 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 
 		while (pci->phb->dma_window_size * children > 0x80000000ul)
 			pci->phb->dma_window_size >>= 1;
-		DBG("No ISA/IDE, window size is 0x%lx\n",
-			pci->phb->dma_window_size);
+		pr_debug("No ISA/IDE, window size is 0x%lx\n",
+			 pci->phb->dma_window_size);
 		pci->phb->dma_window_base_cur = 0;
 
 		return;
@@ -387,8 +386,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	while (pci->phb->dma_window_size * children > 0x70000000ul)
 		pci->phb->dma_window_size >>= 1;
 
-	DBG("ISA/IDE, window size is 0x%lx\n", pci->phb->dma_window_size);
-
+	pr_debug("ISA/IDE, window size is 0x%lx\n", pci->phb->dma_window_size);
 }
 
 
@@ -401,7 +399,8 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 
 	dn = pci_bus_to_OF_node(bus);
 
-	DBG("pci_dma_bus_setup_pSeriesLP: setting up bus %s\n", dn->full_name);
+	pr_debug("pci_dma_bus_setup_pSeriesLP: setting up bus %s\n",
+		 dn->full_name);
 
 	/* Find nearest ibm,dma-window, walking up the device tree */
 	for (pdn = dn; pdn != NULL; pdn = pdn->parent) {
@@ -411,14 +410,14 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 	}
 
 	if (dma_window == NULL) {
-		DBG("  no ibm,dma-window property !\n");
+		pr_debug("  no ibm,dma-window property !\n");
 		return;
 	}
 
 	ppci = PCI_DN(pdn);
 
-	DBG("  parent is %s, iommu_table: 0x%p\n",
-	    pdn->full_name, ppci->iommu_table);
+	pr_debug("  parent is %s, iommu_table: 0x%p\n",
+		 pdn->full_name, ppci->iommu_table);
 
 	if (!ppci->iommu_table) {
 		tbl = kmalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
@@ -426,7 +425,7 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window,
 			bus->number);
 		ppci->iommu_table = iommu_init_table(tbl, ppci->phb->node);
-		DBG("  created table: %p\n", ppci->iommu_table);
+		pr_debug("  created table: %p\n", ppci->iommu_table);
 	}
 
 	if (pdn != dn)
@@ -439,7 +438,7 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 	struct device_node *dn;
 	struct iommu_table *tbl;
 
-	DBG("pci_dma_dev_setup_pSeries: %s\n", pci_name(dev));
+	pr_debug("pci_dma_dev_setup_pSeries: %s\n", pci_name(dev));
 
 	dn = dev->dev.archdata.of_node;
 
@@ -450,7 +449,7 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 	if (!dev->bus->self) {
 		struct pci_controller *phb = PCI_DN(dn)->phb;
 
-		DBG(" --> first child, no bridge. Allocating iommu table.\n");
+		pr_debug(" --> first child, no bridge. Allocating iommu table.\n");
 		tbl = kmalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
 				   phb->node);
 		iommu_table_setparms(phb, dn, tbl);
@@ -480,7 +479,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	const void *dma_window = NULL;
 	struct pci_dn *pci;
 
-	DBG("pci_dma_dev_setup_pSeriesLP: %s\n", pci_name(dev));
+	pr_debug("pci_dma_dev_setup_pSeriesLP: %s\n", pci_name(dev));
 
 	/* dev setup for LPAR is a little tricky, since the device tree might
 	 * contain the dma-window properties per-device and not neccesarily
@@ -489,7 +488,7 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 	 * already allocated.
 	 */
 	dn = pci_device_to_OF_node(dev);
-	DBG("  node is %s\n", dn->full_name);
+	pr_debug("  node is %s\n", dn->full_name);
 
 	for (pdn = dn; pdn && PCI_DN(pdn) && !PCI_DN(pdn)->iommu_table;
 	     pdn = pdn->parent) {
@@ -504,13 +503,13 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 				 pci_name(dev), dn? dn->full_name : "<null>");
 		return;
 	}
-	DBG("  parent is %s\n", pdn->full_name);
+	pr_debug("  parent is %s\n", pdn->full_name);
 
 	/* Check for parent == NULL so we don't try to setup the empty EADS
 	 * slots on POWER4 machines.
 	 */
 	if (dma_window == NULL || pdn->parent == NULL) {
-		DBG("  no dma window for device, linking to parent\n");
+		pr_debug("  no dma window for device, linking to parent\n");
 		dev->dev.archdata.dma_data = PCI_DN(pdn)->iommu_table;
 		return;
 	}
@@ -522,9 +521,9 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window,
 			pci->phb->bus->number);
 		pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
-		DBG("  created table: %p\n", pci->iommu_table);
+		pr_debug("  created table: %p\n", pci->iommu_table);
 	} else {
-		DBG("  found DMA window, table: %p\n", pci->iommu_table);
+		pr_debug("  found DMA window, table: %p\n", pci->iommu_table);
 	}
 
 	dev->dev.archdata.dma_data = pci->iommu_table;
-- 
1.5.5
