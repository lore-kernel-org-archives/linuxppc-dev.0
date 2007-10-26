Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <d1190dd5941ead502359315715d83973aebaae7b.1193381582.git.michael@ellerman.id.au>
In-Reply-To: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
References: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 06/16] Use of_get_next_child() in pci_dma_bus_setup_pSeries()
Date: Fri, 26 Oct 2007 16:54:36 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pci_dma_bus_setup_pSeries() should use of_get_next_child() to safely
iterate through the nodes children.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/iommu.c |    2 +-
 1 files changed, 1 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index ef1aa8d..1a9e14f 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -343,7 +343,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	of_node_put(isa_dn);
 
 	/* Count number of direct PCI children of the PHB. */
-	for (children = 0, tmp = dn->child; tmp; tmp = tmp->sibling)
+	for (children = 0, tmp = NULL; (tmp = of_get_next_child(dn, tmp));)
 		children++;
 
 	DBG("Children: %d\n", children);
-- 
1.5.2.rc1.1884.g59b20
