Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8089D1A0157
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 17:01:03 +1000 (EST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 15 Jul 2014 17:01:01 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9AE243578053
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 17:00:59 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s6F70h6711731300
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 17:00:43 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s6F70xL9031872
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Jul 2014 17:00:59 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 1/2] powerpc/powernv: Fix IOMMU table for VFIO dev
Date: Tue, 15 Jul 2014 17:00:55 +1000
Message-Id: <1405407656-3751-2-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1405407656-3751-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1405407656-3751-1-git-send-email-gwshan@linux.vnet.ibm.com>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PHB3, PCI devices can bypass IOMMU for DMA access. If we pass
through one PCI device, whose hose driver ever enable the bypass
mode, pdev->dev.archdata.dma_data.iommu_table_base isn't IOMMU
table. However, EEH needs access the IOMMU table when the device
is owned by guest.

The patch fixes pdev->dev.archdata.dma_data.iommu_table when
passing through the device to guest in pnv_pci_ioda2_set_bypass().

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 30 +++++++++++++++++++++---------
 1 file changed, 21 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index de19ede..93fd815 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -494,14 +494,22 @@ static int pnv_pci_ioda_dma_set_mask(struct pnv_phb *phb,
 	return 0;
 }
 
-static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
+static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe,
+				   struct pci_bus *bus,
+				   bool add_to_iommu_group)
 {
 	struct pci_dev *dev;
 
 	list_for_each_entry(dev, &bus->devices, bus_list) {
-		set_iommu_table_base_and_group(&dev->dev, &pe->tce32_table);
+		if (add_to_iommu_group)
+			set_iommu_table_base_and_group(&dev->dev,
+						       &pe->tce32_table);
+		else
+			set_iommu_table_base(&dev->dev, &pe->tce32_table);
+
 		if (dev->subordinate)
-			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
+			pnv_ioda_setup_bus_dma(pe, dev->subordinate,
+					       add_to_iommu_group);
 	}
 }
 
@@ -677,7 +685,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	if (pe->pdev)
 		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
 	else
-		pnv_ioda_setup_bus_dma(pe, pe->pbus);
+		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
 
 	return;
  fail:
@@ -713,11 +721,15 @@ static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
 						     0);
 
 		/*
-		 * We might want to reset the DMA ops of all devices on
-		 * this PE. However in theory, that shouldn't be necessary
-		 * as this is used for VFIO/KVM pass-through and the device
-		 * hasn't yet been returned to its kernel driver
+		 * EEH needs the mapping between IOMMU table and group
+		 * of those VFIO/KVM pass-through devices. We can postpone
+		 * resetting DMA ops until the DMA mask is configured in
+		 * host side.
 		 */
+		if (pe->pdev)
+			set_iommu_table_base(&pe->pdev->dev, tbl);
+		else
+			pnv_ioda_setup_bus_dma(pe, pe->pbus, false);
 	}
 	if (rc)
 		pe_err(pe, "OPAL error %lld configuring bypass window\n", rc);
@@ -805,7 +817,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	if (pe->pdev)
 		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
 	else
-		pnv_ioda_setup_bus_dma(pe, pe->pbus);
+		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
 
 	/* Also create a bypass window */
 	pnv_pci_ioda2_setup_bypass_pe(phb, pe);
-- 
1.8.3.2
