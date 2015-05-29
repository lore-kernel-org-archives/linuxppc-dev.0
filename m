Return-Path: <aik@ozlabs.ru>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E65C61A0600
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:46:01 +1000 (AEST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 29 May 2015 18:45:59 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id A541F357804C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:45:57 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4T8jngH53936344
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:45:57 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4T8jOC5026963
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:45:25 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH kernel v11 03/34] powerpc/powernv/ioda: Clean up IOMMU group
 registration
Date: Fri, 29 May 2015 18:44:27 +1000
Message-Id: <1432889098-22924-4-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The existing code has 3 calls to iommu_register_group() and
all 3 branches actually cover all possible cases.

This replaces 3 calls with one and moves the registration earlier;
the latter will make more sense when we add TCE table sharing.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 28 ++++++++--------------------
 1 file changed, 8 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 9a77f3c..8ca7abd 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1784,6 +1784,9 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	if (WARN_ON(pe->tce32_seg >= 0))
 		return;
 
+	tbl = pe->tce32_table;
+	iommu_register_group(tbl, phb->hose->global_number, pe->pe_number);
+
 	/* Grab a 32-bit TCE table */
 	pe->tce32_seg = base;
 	pe_info(pe, " Setting up 32-bit TCE table at %08x..%08x\n",
@@ -1818,7 +1821,6 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	}
 
 	/* Setup linux iommu table */
-	tbl = pe->tce32_table;
 	pnv_pci_setup_iommu_table(tbl, addr, TCE32_TABLE_SIZE * segs,
 				  base << 28, IOMMU_PAGE_SHIFT_4K);
 
@@ -1840,8 +1842,6 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	iommu_init_table(tbl, phb->hose->node);
 
 	if (pe->flags & PNV_IODA_PE_DEV) {
-		iommu_register_group(tbl, phb->hose->global_number,
-				     pe->pe_number);
 		/*
 		 * Setting table base here only for carrying iommu_group
 		 * further down to let iommu_add_device() do the job.
@@ -1849,14 +1849,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 		 */
 		set_iommu_table_base(&pe->pdev->dev, tbl);
 		iommu_add_device(&pe->pdev->dev);
-	} else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)) {
-		iommu_register_group(tbl, phb->hose->global_number,
-				     pe->pe_number);
+	} else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
 		pnv_ioda_setup_bus_dma(pe, pe->pbus);
-	} else if (pe->flags & PNV_IODA_PE_VF) {
-		iommu_register_group(tbl, phb->hose->global_number,
-				     pe->pe_number);
-	}
 
 	return;
  fail:
@@ -1923,6 +1917,9 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	if (WARN_ON(pe->tce32_seg >= 0))
 		return;
 
+	tbl = pe->tce32_table;
+	iommu_register_group(tbl, phb->hose->global_number, pe->pe_number);
+
 	/* The PE will reserve all possible 32-bits space */
 	pe->tce32_seg = 0;
 	end = (1 << ilog2(phb->ioda.m32_pci_base));
@@ -1954,7 +1951,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	}
 
 	/* Setup linux iommu table */
-	tbl = pe->tce32_table;
 	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
 			IOMMU_PAGE_SHIFT_4K);
 
@@ -1974,8 +1970,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	iommu_init_table(tbl, phb->hose->node);
 
 	if (pe->flags & PNV_IODA_PE_DEV) {
-		iommu_register_group(tbl, phb->hose->global_number,
-				     pe->pe_number);
 		/*
 		 * Setting table base here only for carrying iommu_group
 		 * further down to let iommu_add_device() do the job.
@@ -1983,14 +1977,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		 */
 		set_iommu_table_base(&pe->pdev->dev, tbl);
 		iommu_add_device(&pe->pdev->dev);
-	} else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL)) {
-		iommu_register_group(tbl, phb->hose->global_number,
-				     pe->pe_number);
+	} else if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
 		pnv_ioda_setup_bus_dma(pe, pe->pbus);
-	} else if (pe->flags & PNV_IODA_PE_VF) {
-		iommu_register_group(tbl, phb->hose->global_number,
-				     pe->pe_number);
-	}
 
 	/* Also create a bypass window */
 	if (!pnv_iommu_bypass_disabled)
-- 
2.4.0.rc3.8.gfb3e7d5
