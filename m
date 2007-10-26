Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <42234d04c09b6cff48929785a7533e9d7d7c39bf.1193381582.git.michael@ellerman.id.au>
In-Reply-To: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
References: <80449d4682309dbf8cf80816be4f381fe875f3d1.1193381582.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH 04/16] Use of_get_next_parent() in pci_dma_dev_setup_pSeries()
Date: Fri, 26 Oct 2007 16:54:34 +1000 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

pci_dma_dev_setup_pSeries() should use of_get_next_parent() to safely
iterate through the parent nodes.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/pseries/iommu.c |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index e2b325d..5e9430e 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -472,14 +472,17 @@ static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 	 * an already allocated iommu table is found and use that.
 	 */
 
+	dn = of_node_get(dn);
 	while (dn && PCI_DN(dn) && PCI_DN(dn)->iommu_table == NULL)
-		dn = dn->parent;
+		dn = of_get_next_parent(dn);
 
 	if (dn && PCI_DN(dn))
 		dev->dev.archdata.dma_data = PCI_DN(dn)->iommu_table;
 	else
 		printk(KERN_WARNING "iommu: Device %s has no iommu table\n",
 		       pci_name(dev));
+
+	of_node_put(dn);
 }
 
 static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
-- 
1.5.2.rc1.1884.g59b20
