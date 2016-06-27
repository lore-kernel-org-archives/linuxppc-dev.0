Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdSpW02gszDqx1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 27 Jun 2016 22:26:11 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rdSpV2CpJz9t1N
 for <linuxppc-dev@ozlabs.org>; Mon, 27 Jun 2016 22:26:10 +1000 (AEST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 11/17] powerpc/powernv/pci: Fallback to OPAL for TCE
 invalidations
Date: Mon, 27 Jun 2016 22:25:27 +1000
Message-Id: <1467030333-31435-12-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
References: <1467030333-31435-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If we don't find registers for the PHB or don't know the model
specific invalidation method, use OPAL calls instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 33 +++++++++++++++++++++++++++----
 1 file changed, 29 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8574a9b..5f08cd5 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1869,6 +1869,17 @@ static void pnv_pci_phb3_tce_invalidate(struct pnv_ioda_pe *pe, bool rm,
 	}
 }
 
+static inline void pnv_pci_ioda2_tce_invalidate_pe(struct pnv_ioda_pe *pe)
+{
+	struct pnv_phb *phb = pe->phb;
+
+	if (phb->model == PNV_PHB_MODEL_PHB3 && phb->regs)
+		pnv_pci_phb3_tce_invalidate_pe(pe);
+	else
+		opal_pci_tce_kill(phb->opal_id, OPAL_PCI_TCE_KILL_PE,
+				  pe->pe_number, 0, 0, 0);
+}
+
 static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 		unsigned long index, unsigned long npages, bool rm)
 {
@@ -1877,17 +1888,31 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
 	list_for_each_entry_rcu(tgl, &tbl->it_group_list, next) {
 		struct pnv_ioda_pe *pe = container_of(tgl->table_group,
 				struct pnv_ioda_pe, table_group);
-		if (pe->phb->type == PNV_PHB_NPU) {
+		struct pnv_phb *phb = pe->phb;
+		unsigned int shift = tbl->it_page_shift;
+
+		if (phb->type == PNV_PHB_NPU) {
 			/*
 			 * The NVLink hardware does not support TCE kill
 			 * per TCE entry so we have to invalidate
 			 * the entire cache for it.
 			 */
-			pnv_pci_phb3_tce_invalidate_entire(pe->phb, rm);
+			pnv_pci_phb3_tce_invalidate_entire(phb, rm);
 			continue;
 		}
-		pnv_pci_phb3_tce_invalidate(pe, rm, tbl->it_page_shift,
-					    index, npages);
+		if (phb->model == PNV_PHB_MODEL_PHB3 && phb->regs)
+			pnv_pci_phb3_tce_invalidate(pe, rm, shift,
+						    index, npages);
+		else if (rm)
+			opal_rm_pci_tce_kill(phb->opal_id,
+					     OPAL_PCI_TCE_KILL_PAGES,
+					     pe->pe_number, 1u << shift,
+					     index << shift, npages);
+		else
+			opal_pci_tce_kill(phb->opal_id,
+					  OPAL_PCI_TCE_KILL_PAGES,
+					  pe->pe_number, 1u << shift,
+					  index << shift, npages);
 	}
 }
 
-- 
2.7.4
