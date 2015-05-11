Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1ED4E1A0047
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:29 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 12 May 2015 01:40:28 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id B15613578056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:23 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4BFeFQF37421208
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:23 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4BFdoe7001604
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:39:50 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v10 01/34] powerpc/eeh/ioda2: Use device::iommu_group
 to check IOMMU group
Date: Tue, 12 May 2015 01:38:50 +1000
Message-Id: <1431358763-24371-2-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This relies on the fact that a PCI device always has an IOMMU table
which may not be the case when we get dynamic DMA windows so
let's use more reliable check for IOMMU group here.

As we do not rely on the table presence here, remove the workaround
from pnv_pci_ioda2_set_bypass(); also remove the @add_to_iommu_group
parameter from pnv_ioda_setup_bus_dma().

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/kernel/eeh.c                 |  4 +---
 arch/powerpc/platforms/powernv/pci-ioda.c | 27 +++++----------------------
 2 files changed, 6 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/kernel/eeh.c b/arch/powerpc/kernel/eeh.c
index 9ee61d1..defd874 100644
--- a/arch/powerpc/kernel/eeh.c
+++ b/arch/powerpc/kernel/eeh.c
@@ -1412,13 +1412,11 @@ static int dev_has_iommu_table(struct device *dev, void *data)
 {
 	struct pci_dev *pdev = to_pci_dev(dev);
 	struct pci_dev **ppdev = data;
-	struct iommu_table *tbl;
 
 	if (!dev)
 		return 0;
 
-	tbl = get_iommu_table_base(dev);
-	if (tbl && tbl->it_group) {
+	if (dev->iommu_group) {
 		*ppdev = pdev;
 		return 1;
 	}
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index f8bc950..2f092bb 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1654,21 +1654,15 @@ static u64 pnv_pci_ioda_dma_get_required_mask(struct pnv_phb *phb,
 }
 
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
+		set_iommu_table_base_and_group(&dev->dev, pe->tce32_table);
 
 		if (dev->subordinate)
-			pnv_ioda_setup_bus_dma(pe, dev->subordinate,
-					       add_to_iommu_group);
+			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
 	}
 }
 
@@ -1845,7 +1839,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	} else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)) {
 		iommu_register_group(tbl, phb->hose->global_number,
 				     pe->pe_number);
-		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
+		pnv_ioda_setup_bus_dma(pe, pe->pbus);
 	} else if (pe->flags & PNV_IODA_PE_VF) {
 		iommu_register_group(tbl, phb->hose->global_number,
 				     pe->pe_number);
@@ -1882,17 +1876,6 @@ static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
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
@@ -1984,7 +1967,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	} else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)) {
 		iommu_register_group(tbl, phb->hose->global_number,
 				     pe->pe_number);
-		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
+		pnv_ioda_setup_bus_dma(pe, pe->pbus);
 	} else if (pe->flags & PNV_IODA_PE_VF) {
 		iommu_register_group(tbl, phb->hose->global_number,
 				     pe->pe_number);
-- 
2.4.0.rc3.8.gfb3e7d5
