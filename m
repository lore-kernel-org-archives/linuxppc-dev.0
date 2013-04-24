Return-Path: <shangw@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e9.ny.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2CAFD2C011D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 19:37:53 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shangw@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 05:37:51 -0400
Received: from d01relay06.pok.ibm.com (d01relay06.pok.ibm.com [9.56.227.116])
 by d01dlp03.pok.ibm.com (Postfix) with ESMTP id D1A07C9001A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 05:37:48 -0400 (EDT)
Received: from d01av01.pok.ibm.com (d01av01.pok.ibm.com [9.56.224.215])
 by d01relay06.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3O9bnoJ39846096
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 05:37:49 -0400
Received: from d01av01.pok.ibm.com (loopback [127.0.0.1])
 by d01av01.pok.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3O9bmer003689
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 05:37:48 -0400
From: Gavin Shan <shangw@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 7/7] powerpc/powernv: Fix invalid IOMMU table
Date: Wed, 24 Apr 2013 17:37:39 +0800
Message-Id: <1366796259-29412-8-git-send-email-shangw@linux.vnet.ibm.com>
In-Reply-To: <1366796259-29412-1-git-send-email-shangw@linux.vnet.ibm.com>
References: <1366796259-29412-1-git-send-email-shangw@linux.vnet.ibm.com>
Cc: Gavin Shan <shangw@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ben found the root cause. Commit 37f02195bee9c25ce44e25204f40b7961a6d7c9d
("powerpc/pci: fix PCI-e devices rescan issue on powerpc platform")
overwrites the IOMMU table of PCI device while enabling PCI device.
The patch intends to fix the IOMMU table after that point.

Signed-off-by: Gavin Shan <shangw@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c |   33 ++++++++++------------------
 1 files changed, 12 insertions(+), 21 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 6bc4648..c41696f 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -432,20 +432,21 @@ static void pnv_pci_ioda_setup_PEs(void)
 	}
 }
 
-static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *dev)
+static void pnv_pci_ioda_dma_dev_setup(struct pnv_phb *phb, struct pci_dev *pdev)
 {
-	/* We delay DMA setup after we have assigned all PE# */
-}
+	struct pci_dn *pdn = pnv_ioda_get_pdn(pdev);
+	struct pnv_ioda_pe *pe;
 
-static void pnv_ioda_setup_bus_dma(struct pnv_ioda_pe *pe, struct pci_bus *bus)
-{
-	struct pci_dev *dev;
+	/*
+	 * The function can be called while the PE#
+	 * hasn't been assigned. Do nothing for the
+	 * case.
+	 */
+	if (!pdn || pdn->pe_number == IODA_INVALID_PE)
+		return;
 
-	list_for_each_entry(dev, &bus->devices, bus_list) {
-		set_iommu_table_base(&dev->dev, &pe->tce32_table);
-		if (dev->subordinate)
-			pnv_ioda_setup_bus_dma(pe, dev->subordinate);
-	}
+	pe = &phb->ioda.pe_array[pdn->pe_number];
+	set_iommu_table_base(&pdev->dev, &pe->tce32_table);
 }
 
 void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
@@ -594,11 +595,6 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	}
 	iommu_init_table(tbl, phb->hose->node);
 
-	if (pe->pdev)
-		set_iommu_table_base(&pe->pdev->dev, tbl);
-	else
-		pnv_ioda_setup_bus_dma(pe, pe->pbus);
-
 	return;
  fail:
 	/* XXX Failure: Try to fallback to 64-bit only ? */
@@ -673,11 +669,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	}
 	iommu_init_table(tbl, phb->hose->node);
 
-	if (pe->pdev)
-		set_iommu_table_base(&pe->pdev->dev, tbl);
-	else
-		pnv_ioda_setup_bus_dma(pe, pe->pbus);
-
 	return;
 fail:
 	if (pe->tce32_seg >= 0)
-- 
1.7.5.4
