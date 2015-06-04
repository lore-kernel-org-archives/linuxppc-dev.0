Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EDEDD1A0BBE
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:43:37 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 16:43:37 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 62C3D2BB006A
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:43:35 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t546hRrO55378096
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:35 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t546h17e005391
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:03 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 23/42] powerpc/powernv: Cleanup on
 pnv_pci_ioda2_release_dma_pe()
Date: Thu,  4 Jun 2015 16:41:52 +1000
Message-Id: <1433400131-18429-24-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The patch applies cleanup on pnv_pci_ioda2_release_dma_pe():

  * Rename it to pnv_pci_ioda2_release_pe_dma() to match the
    function names used to release resources for one PE in the
    subsequent patches.
  * Remove the parameter of PCI device, which is used to figure
    out device node. VFs don't have associated device nodes in
    SRIOV case. For other cases, the device node can be figured
    out from the PCI bus or device the PE was allocated for.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Newly introduced
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 26 +++++++++++++++++++-------
 1 file changed, 19 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 3d5aec8d..2e31472 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -197,11 +197,11 @@ static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
 		pe->tce_bypass_enabled = enable;
 }
 
-static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev,
-					 struct pnv_ioda_pe *pe)
+static void pnv_pci_ioda2_release_pe_dma(struct pnv_ioda_pe *pe)
 {
-	struct iommu_table    *tbl;
-	int64_t               rc;
+	struct iommu_table *tbl;
+	struct device_node *dn;
+	int64_t rc;
 
 	tbl = pe->table_group.tables[0];
 	rc = pnv_pci_ioda2_unset_window(&pe->table_group, 0);
@@ -213,8 +213,20 @@ static void pnv_pci_ioda2_release_dma_pe(struct pci_dev *dev,
 		iommu_group_put(pe->table_group.group);
 		BUG_ON(pe->table_group.group);
 	}
+
+	if (pe->flags & (PNV_IODA_PE_BUS | PNV_IODA_PE_BUS_ALL))
+		dn = pci_bus_to_OF_node(pe->pbus);
+	else if (pe->flags & PNV_IODA_PE_DEV)
+		dn = pci_device_to_OF_node(pe->pdev);
+#ifdef CONFIG_PCI_IOV
+	else if (pe->flags & PNV_IODA_PE_VF)
+		dn = pci_device_to_OF_node(pe->parent_dev);
+#endif
+	else
+		dn = NULL;
+
 	pnv_pci_ioda2_table_free_pages(tbl);
-	iommu_free_table(tbl, of_node_full_name(dev->dev.of_node));
+	iommu_free_table(tbl, of_node_full_name(dn));
 }
 
 static int pnv_ioda_set_one_peltv(struct pnv_phb *phb,
@@ -1495,14 +1507,14 @@ static void pnv_ioda_release_vf_PE(struct pci_dev *pdev, u16 num_vfs)
 		if ((pe->flags & PNV_IODA_PE_MASTER) &&
 		    (pe->flags & PNV_IODA_PE_VF)) {
 			list_for_each_entry_safe(s, sn, &pe->slaves, list) {
-				pnv_pci_ioda2_release_dma_pe(pdev, s);
+				pnv_pci_ioda2_release_pe_dma(s);
 				list_del(&s->list);
 				pnv_ioda_deconfigure_pe(phb, s);
 				pnv_ioda_free_pe(phb, s->pe_number);
 			}
 		}
 
-		pnv_pci_ioda2_release_dma_pe(pdev, pe);
+		pnv_pci_ioda2_release_pe_dma(pe);
 
 		/* Remove from list */
 		mutex_lock(&phb->ioda.pe_list_mutex);
-- 
2.1.0
