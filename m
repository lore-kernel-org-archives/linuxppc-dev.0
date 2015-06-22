Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B056E1A0CA9
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Jun 2015 14:32:10 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id t5M4W5Ng022065
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Jun 2015 23:32:06 -0500
Message-ID: <1434947525.27935.27.camel@kernel.crashing.org>
Subject: [PATCH 2/3] powerpc/iommu: Cleanup setting of DMA base/offset
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@lists.ozlabs.org
Date: Mon, 22 Jun 2015 14:32:05 +1000
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that the table and the offset can co-exist, we no longer need
to flip/flop, we can just establish both once at boot time.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 50 +++++++++++--------------------
 arch/powerpc/platforms/pseries/iommu.c    |  3 +-
 arch/powerpc/sysdev/dart_iommu.c          | 16 ++--------
 3 files changed, 22 insertions(+), 47 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5ac7c60..3b3c16e 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1621,11 +1621,9 @@ static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
 	if (bypass) {
 		dev_info(&pdev->dev, "Using 64-bit DMA iommu bypass\n");
 		set_dma_ops(&pdev->dev, &dma_direct_ops);
-		set_dma_offset(&pdev->dev, pe->tce_bypass_base);
 	} else {
 		dev_info(&pdev->dev, "Using 32-bit DMA via iommu\n");
 		set_dma_ops(&pdev->dev, &dma_iommu_ops);
-		set_iommu_table_base(&pdev->dev, pe->tce32_table);
 	}
 	*pdev->dev.dma_mask = dma_mask;
 	return 0;
@@ -1653,22 +1651,22 @@ static u64 pnv_pci_ioda_dma_get_required_mask(struct pnv_phb *phb,
 	return mask;
 }
 
+static void pnv_ioda_setup_dev_dma(struct pnv_ioda_pe *pe,
+				   struct pci_dev *dev)
+{
+	set_iommu_table_base_and_group(&dev->dev, pe->tce32_table);
+	set_dma_offset(&dev->dev, pe->tce_bypass_base);
+}
+
 static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
-				   struct pci_bus *bus,
-				   bool add_to_iommu_group)
+				   struct pci_bus *bus)
 {
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		if (add_to_iommu_group)
-			set_iommu_table_base_and_group(&dev->dev,
-						       pe->tce32_table);
-		else
-			set_iommu_table_base(&dev->dev, pe->tce32_table);
-
+		pnv_ioda_setup_dev_dma(pe, dev);
 		if (dev->subordinate)
-			pnv_ioda_setup_bus_dma(pe, dev->subordinate,
-					       add_to_iommu_group);
+			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
 	}
 }
 
@@ -1841,11 +1839,11 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	if (pe->flags & PNV_IODA_PE_DEV) {
 		iommu_register_group(tbl, phb->hose->global_number,
 				     pe->pe_number);
-		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
+		pnv_ioda_setup_dev_dma(pe, pe->pdev);
 	} else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)) {
 		iommu_register_group(tbl, phb->hose->global_number,
 				     pe->pe_number);
-		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
+		pnv_ioda_setup_bus_dma(pe, pe->pbus);
 	} else if (pe->flags & PNV_IODA_PE_VF) {
 		iommu_register_group(tbl, phb->hose->global_number,
 				     pe->pe_number);
@@ -1882,17 +1880,6 @@ static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
 						     window_id,
 						     pe->tce_bypass_base,
 						     0);
-
-		/*
-		 * EEH needs the mapping between IOMMU table and group
-		 * of those VFIO/KVM pass-through devices. We can postpone
-		 * resetting DMA ops until the DMA mask is configured in
-		 * host side.
-		 */
-		if (pe->pdev)
-			set_iommu_table_base(&pe->pdev->dev, tbl);
-		else
-			pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
 	}
 	if (rc)
 		pe_err(pe, "OPAL error %lld configuring bypass window\n", rc);
@@ -1977,23 +1964,22 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	}
 	iommu_init_table(tbl, phb->hose->node);
 
+	/* Also create a bypass window */
+	if (!pnv_iommu_bypass_disabled)
+		pnv_pci_ioda2_setup_bypass_pe(phb, pe);
+
 	if (pe->flags & PNV_IODA_PE_DEV) {
 		iommu_register_group(tbl, phb->hose->global_number,
 				     pe->pe_number);
-		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
+		pnv_ioda_setup_dev_dma(pe, pe->pdev);
 	} else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)) {
 		iommu_register_group(tbl, phb->hose->global_number,
 				     pe->pe_number);
-		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
+		pnv_ioda_setup_bus_dma(pe, pe->pbus);
 	} else if (pe->flags & PNV_IODA_PE_VF) {
 		iommu_register_group(tbl, phb->hose->global_number,
 				     pe->pe_number);
 	}
-
-	/* Also create a bypass window */
-	if (!pnv_iommu_bypass_disabled)
-		pnv_pci_ioda2_setup_bypass_pe(phb, pe);
-
 	return;
 fail:
 	if (pe->tce32_seg >= 0)
diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index 7803a19..0acab86 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -1161,11 +1161,10 @@ static int dma_set_mask_pSeriesLP(struct device *dev, u64 dma_mask)
 		}
 	}
 
-	/* fall back on iommu ops, restore table pointer with ops */
+	/* fall back on iommu ops */
 	if (!ddw_enabled && get_dma_ops(dev) != &dma_iommu_ops) {
 		dev_info(dev, "Restoring 32-bit DMA via iommu\n");
 		set_dma_ops(dev, &dma_iommu_ops);
-		pci_dma_dev_setup_pSeriesLP(pdev);
 	}
 
 check_mask:
diff --git a/arch/powerpc/sysdev/dart_iommu.c b/arch/powerpc/sysdev/dart_iommu.c
index 9e5353f..6cf033d 100644
--- a/arch/powerpc/sysdev/dart_iommu.c
+++ b/arch/powerpc/sysdev/dart_iommu.c
@@ -306,20 +306,11 @@ static void iommu_table_dart_setup(void)
 	set_bit(iommu_table_dart.it_size - 1, iommu_table_dart.it_map);
 }
 
-static void dma_dev_setup_dart(struct device *dev)
-{
-	/* We only have one iommu table on the mac for now, which makes
-	 * things simple. Setup all PCI devices to point to this table
-	 */
-	if (get_dma_ops(dev) == &dma_direct_ops)
-		set_dma_offset(dev, DART_U4_BYPASS_BASE);
-	else
-		set_iommu_table_base(dev, &iommu_table_dart);
-}
-
 static void pci_dma_dev_setup_dart(struct pci_dev *dev)
 {
-	dma_dev_setup_dart(&dev->dev);
+	if (dart_is_u4)
+		set_dma_offset(&dev->dev, DART_U4_BYPASS_BASE);
+	set_iommu_table_base(&dev->dev, &iommu_table_dart);
 }
 
 static void pci_dma_bus_setup_dart(struct pci_bus *bus)
@@ -363,7 +354,6 @@ static int dart_dma_set_mask(struct device *dev, u64 dma_mask)
 		dev_info(dev, "Using 32-bit DMA via iommu\n");
 		set_dma_ops(dev, &dma_iommu_ops);
 	}
-	dma_dev_setup_dart(dev);
 
 	*dev->dma_mask = dma_mask;
 	return 0;
