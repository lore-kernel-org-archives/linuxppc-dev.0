Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <a0d6f1f283ef13c53b09ab219eb59d830d501b10.1193381582.git.michael@ellerman.id.au>
In-Reply-To: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
References: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 02/16] Use of_get_next_parent() in pci_dma_bus_setup_pSeries()
Date: Fri, 26 Oct 2007 16:54:32 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pci_dma_bus_setup_pSeries() should use of_get_next_parent() to safely
iterate through the parent nodes.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/iommu.c |   10 +++++-----
 1 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index be17d23..83c0e0f 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -314,7 +314,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 {
 	struct device_node *dn;
 	struct iommu_table *tbl;
-	struct device_node *isa_dn, *isa_dn_orig;
+	struct device_node *isa_dn;
 	struct device_node *tmp;
 	struct pci_dn *pci;
 	int children;
@@ -334,13 +334,13 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	/* Check if the ISA bus on the system is under
 	 * this PHB.
 	 */
-	isa_dn = isa_dn_orig = of_find_node_by_type(NULL, "isa");
+	isa_dn = of_find_node_by_type(NULL, "isa");
 
 	while (isa_dn && isa_dn != dn)
-		isa_dn = isa_dn->parent;
+		isa_dn = of_get_next_parent(isa_dn);
 
-	if (isa_dn_orig)
-		of_node_put(isa_dn_orig);
+	/* Drop our reference, it's still safe to check the pointer below */
+	of_node_put(isa_dn);
 
 	/* Count number of direct PCI children of the PHB. */
 	for (children = 0, tmp = dn->child; tmp; tmp = tmp->sibling)
-- 
1.5.2.rc1.1884.g59b20
