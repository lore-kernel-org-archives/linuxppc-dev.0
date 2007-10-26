Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <b53a672823801d516f8cad9853f3e95914b0c6e4.1193381582.git.michael@ellerman.id.au>
In-Reply-To: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
References: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 03/16] Use of_get_next_parent() in
	pci_dma_bus_setup_pSeriesLP()
Date: Fri, 26 Oct 2007 16:54:33 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pci_dma_bus_setup_pSeriesLP() should use of_get_next_parent() to safely
iterate through the parent nodes.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/iommu.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 83c0e0f..e2b325d 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -403,7 +403,7 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 	DBG("pci_dma_bus_setup_pSeriesLP: setting up bus %s\n", dn->full_name);
 
 	/* Find nearest ibm,dma-window, walking up the device tree */
-	for (pdn = dn; pdn != NULL; pdn = pdn->parent) {
+	for (pdn = of_node_get(dn); pdn; pdn = of_get_next_parent(pdn)) {
 		dma_window = of_get_property(pdn, "ibm,dma-window", NULL);
 		if (dma_window != NULL)
 			break;
@@ -411,6 +411,7 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 
 	if (dma_window == NULL) {
 		DBG("  no ibm,dma-window property !\n");
+		of_node_put(pdn);
 		return;
 	}
 
@@ -437,6 +438,8 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 
 	if (pdn != dn)
 		PCI_DN(dn)->iommu_table = ppci->iommu_table;
+
+	of_node_put(pdn);
 }
 
 
-- 
1.5.2.rc1.1884.g59b20
