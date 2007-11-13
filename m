Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 45BD1DDE29
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 16:31:22 +1100 (EST)
Received: from ash.ozlabs.ibm.com (bh02i525f01.au.ibm.com [202.81.18.30])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by smtps.tip.net.au (Postfix) with ESMTP id 2F22B368006
	for <linuxppc-dev@ozlabs.org>; Tue, 13 Nov 2007 16:31:22 +1100 (EST)
Date: Tue, 13 Nov 2007 16:31:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: ppc-dev <linuxppc-dev@ozlabs.org>
Subject: [PATCH][POWERPC] pSeries: remove dependency on pci_dn bussubno
Message-Id: <20071113163128.1e25ee00.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/platforms/pseries/iommu.c |   24 +++++++-----------------
 1 files changed, 7 insertions(+), 17 deletions(-)

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index d4e9d85..ebb9313 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -296,11 +296,12 @@ static void iommu_table_setparms(struct pci_controller *phb,
 static void iommu_table_setparms_lpar(struct pci_controller *phb,
 				      struct device_node *dn,
 				      struct iommu_table *tbl,
-				      const void *dma_window)
+				      const void *dma_window,
+				      int bussubno)
 {
 	unsigned long offset, size;
 
-	tbl->it_busno  = PCI_DN(dn)->bussubno;
+	tbl->it_busno  = bussubno;
 	of_parse_dma_window(dn, dma_window, &tbl->it_index, &offset, &size);
 
 	tbl->it_base   = 0;
@@ -420,17 +421,10 @@ static void pci_dma_bus_setup_pSeriesLP(struct pci_bus *bus)
 	    pdn->full_name, ppci->iommu_table);
 
 	if (!ppci->iommu_table) {
-		/* Bussubno hasn't been copied yet.
-		 * Do it now because iommu_table_setparms_lpar needs it.
-		 */
-
-		ppci->bussubno = bus->number;
-
 		tbl = kmalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
 				   ppci->phb->node);
-
-		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window);
-
+		iommu_table_setparms_lpar(ppci->phb, pdn, tbl, dma_window,
+			bus->number);
 		ppci->iommu_table = iommu_init_table(tbl, ppci->phb->node);
 		DBG("  created table: %p\n", ppci->iommu_table);
 	}
@@ -523,14 +517,10 @@ static void pci_dma_dev_setup_pSeriesLP(struct pci_dev *dev)
 
 	pci = PCI_DN(pdn);
 	if (!pci->iommu_table) {
-		/* iommu_table_setparms_lpar needs bussubno. */
-		pci->bussubno = pci->phb->bus->number;
-
 		tbl = kmalloc_node(sizeof(struct iommu_table), GFP_KERNEL,
 				   pci->phb->node);
-
-		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window);
-
+		iommu_table_setparms_lpar(pci->phb, pdn, tbl, dma_window,
+			pci->phb->bus->number);
 		pci->iommu_table = iommu_init_table(tbl, pci->phb->node);
 		DBG("  created table: %p\n", pci->iommu_table);
 	} else {
-- 
1.5.3.5
