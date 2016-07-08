Return-Path: <benh@kernel.crashing.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm71B5gJdzDqnG
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 18:28:30 +1000 (AEST)
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3rm7196RLHz9s9W
 for <linuxppc-dev@ozlabs.org>; Fri,  8 Jul 2016 18:28:29 +1000 (AEST)
Received: from localhost.localdomain (localhost.localdomain [127.0.0.1])
 by gate.crashing.org (8.14.1/8.13.8) with ESMTP id u688SOc1014967
 for <linuxppc-dev@ozlabs.org>; Fri, 8 Jul 2016 03:28:26 -0500
Message-ID: <1467966504.2874.27.camel@kernel.crashing.org>
Subject: [PATCH v2 11/14] powerpc/powernv/pci: Fallback to OPAL for TCE
 invalidations
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Date: Fri, 08 Jul 2016 18:28:24 +1000
In-Reply-To: <1467959838-6900-11-git-send-email-benh@kernel.crashing.org>
References: <1467959838-6900-1-git-send-email-benh@kernel.crashing.org>
 <1467959838-6900-11-git-send-email-benh@kernel.crashing.org>
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

If we don't find registers for the PHB or don't know the model
specific invalidation method, use OPAL calls instead.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

v2. Missed some new invalidation calls that went upstream since I
    wrote the original patch.

 arch/powerpc/platforms/powernv/pci-ioda.c | 37 ++++++++++++++++++++++++++-----
 1 file changed, 31 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index ac4a432..4e9b000 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1867,6 +1867,17 @@ static void pnv_pci_phb3_tce_invalidate(struct pnv_ioda_pe *pe, bool rm,
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
@@ -1875,17 +1886,31 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
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
 
@@ -2151,7 +2176,7 @@ static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
 
 	pnv_pci_link_table_and_group(phb->hose->node, num,
 			tbl, &pe->table_group);
-	pnv_pci_phb3_tce_invalidate_pe(pe);
+	pnv_pci_ioda2_tce_invalidate_pe(pe);
 
 	return 0;
 }
@@ -2289,7 +2314,7 @@ static long pnv_pci_ioda2_unset_window(struct iommu_table_group *table_group,
 	if (ret)
 		pe_warn(pe, "Unmapping failed, ret = %ld\n", ret);
 	else
-		pnv_pci_phb3_tce_invalidate_pe(pe);
+		pnv_pci_ioda2_tce_invalidate_pe(pe);
 
 	pnv_pci_unlink_table_and_group(table_group->tables[num], table_group);
 
