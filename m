Return-Path: <nacc@us.ibm.com>
From: Nishanth Aravamudan <nacc@us.ibm.com>
To: nacc@us.ibm.com
Subject: [RFC PATCH 08/11] ppc/iommu: remove unneeded
	pci_dma_bus_setup_pSeriesLP
Date: Fri,  8 Oct 2010 10:33:09 -0700
Message-Id: <1286559192-10898-9-git-send-email-nacc@us.ibm.com>
In-Reply-To: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
References: <1286559192-10898-1-git-send-email-nacc@us.ibm.com>
Cc: devicetree-discuss@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	miltonm@bga.com, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The work done in pci_dma_bus_setup_pSeriesLP will be done in
pci_dma_dev_setup_pSeriesLP, and therefore we can remove the bus setup
function for lpar.

Signed-off-by: Milton Miller <miltonm@bga.com>
Signed-off-by: Nishanth Aravamudan <nacc@us.ibm.com>
---
 arch/powerpc/platforms/pseries/iommu.c |   43 --------------------------------
 1 files changed, 0 insertions(+), 43 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 9d564b9..d8bb9be 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -417,47 +417,6 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
 	pr_debug("ISA/IDE, window size is 0x%llx\n", pci->phb->dma_window_size);
 }
 
-
-static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
-{
-	struct iommu_table *tbl;
-	struct device_node *dn, *pdn;
-	struct pci_dn *ppci;
-	const void *dma_window = NULL;
-
-	dn = pci_bus_to_OF_node(bus);
-
-	pr_debug("pci_dma_bus_setup_pSeriesLP: setting up bus %s\n",
-		 dn->full_name);
-
-	/* Find nearest ibm,dma-window, walking up the device tree */
-	for (pdn = dn; pdn != NULL; pdn = pdn->parent) {
-		dma_window = of_get_property(pdn, "ibm,dma-window", NULL);
-		if (dma_window != NULL)
-			break;
-	}
-
-	if (dma_window == NULL) {
-		pr_debug("  no ibm,dma-window property !\n");
-		return;
-	}
-
-	ppci = PCI_DN(pdn);
-
-	pr_debug("  parent is %s, iommu_table: 0x%p\n",
-		 pdn->full_name, ppci->iommu_table);
-
-	if (!ppci->iommu_table) {
-		tbl = kzalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
-				   ppci->phb->node);
-		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window,
-			bus->number);
-		ppci->iommu_table = iommu_init_table(tbl, ppci->phb->node);
-		pr_debug("  created table: %p\n", ppci->iommu_table);
-	}
-}
-
-
 static void pci_dma_dev_setup_pSeries(struct pci_dev *dev)
 {
 	struct device_node *dn;
@@ -547,7 +506,6 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 #else  /* CONFIG_PCI */
 #define pci_dma_bus_setup_pSeries	NULL
 #define pci_dma_dev_setup_pSeries	NULL
-#define pci_dma_bus_setup_pSeriesLP	NULL
 #define pci_dma_dev_setup_pSeriesLP	NULL
 #endif /* !CONFIG_PCI */
 
@@ -588,7 +546,6 @@ void iommu_init_early_pSeries(void)
 			ppc_md.tce_free	 = tce_free_pSeriesLP;
 		}
 		ppc_md.tce_get   = tce_get_pSeriesLP;
-		ppc_md.pci_dma_bus_setup = pci_dma_bus_setup_pSeriesLP;
 		ppc_md.pci_dma_dev_setup = pci_dma_dev_setup_pSeriesLP;
 	} else {
 		ppc_md.tce_build = tce_build_pSeries;
-- 
1.7.1
