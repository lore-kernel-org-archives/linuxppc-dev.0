Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C97981A06BA
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:23 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 25 Apr 2015 22:16:23 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 426BE2CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:20 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3PCGCZM43188358
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:20 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3PCFkGH014063
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:15:47 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v9 21/32] powerpc/powernv/ioda2: Introduce
 pnv_pci_ioda2_set_window
Date: Sat, 25 Apr 2015 22:14:45 +1000
Message-Id: <1429964096-11524-22-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
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

This is a part of moving DMA window programming to an iommu_ops
callback. pnv_pci_ioda2_set_window() takes an iommu_table_group as
a first parameter (not pnv_ioda_pe) as it is going to be used as
a callback for VFIO DDW code.

This adds pnv_pci_ioda2_tvt_invalidate() to invalidate TVT as it is
a good thing to do. It does not have immediate effect now as the table
is never recreated after reboot but it will in the following patches.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
---
Changes:
v9:
* initialize pe->table_group.tables[0] at the very end when
tbl is fully initialized
* moved pnv_pci_ioda2_tvt_invalidate() from earlier patch
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 67 +++++++++++++++++++++++--------
 1 file changed, 51 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index b9b3773..59baa15 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1960,6 +1960,52 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
 }
 
+static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
+		struct iommu_table *tbl)
+{
+	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
+			table_group);
+	struct pnv_phb *phb = pe->phb;
+	int64_t rc;
+	const __u64 start_addr = tbl->it_offset << tbl->it_page_shift;
+	const __u64 win_size = tbl->it_size << tbl->it_page_shift;
+
+	pe_info(pe, "Setting up window at %llx..%llx "
+			"pgsize=0x%x tablesize=0x%lx\n",
+			start_addr, start_addr + win_size - 1,
+			1UL << tbl->it_page_shift, tbl->it_size << 3);
+
+	tbl->it_table_group = &pe->table_group;
+
+	/*
+	 * Map TCE table through TVT. The TVE index is the PE number
+	 * shifted by 1 bit for 32-bits DMA space.
+	 */
+	rc = opal_pci_map_pe_dma_window(phb->opal_id,
+			pe->pe_number,
+			pe->pe_number << 1,
+			1,
+			__pa(tbl->it_base),
+			tbl->it_size << 3,
+			1ULL << tbl->it_page_shift);
+	if (rc) {
+		pe_err(pe, "Failed to configure TCE table, err %ld\n", rc);
+		goto fail;
+	}
+
+	pnv_pci_ioda2_tvt_invalidate(pe);
+
+	/* Store fully initialized *tbl (may be external) in PE */
+	pe->table_group.tables[0] = *tbl;
+
+	return 0;
+fail:
+	if (pe->tce32_seg >= 0)
+		pe->tce32_seg = -1;
+
+	return rc;
+}
+
 static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
 {
 	uint16_t window_id = (pe->pe_number << 1 ) + 1;
@@ -2068,21 +2114,16 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	pe->table_group.ops = &pnv_pci_ioda2_ops;
 #endif
 
-	/*
-	 * Map TCE table through TVT. The TVE index is the PE number
-	 * shifted by 1 bit for 32-bits DMA space.
-	 */
-	rc = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
-			pe->pe_number << 1, 1, __pa(tbl->it_base),
-			tbl->it_size << 3, 1ULL << tbl->it_page_shift);
+	rc = pnv_pci_ioda2_set_window(&pe->table_group, tbl);
 	if (rc) {
 		pe_err(pe, "Failed to configure 32-bit TCE table,"
 		       " err %ld\n", rc);
-		goto fail;
+		pnv_pci_free_table(tbl);
+		if (pe->tce32_seg >= 0)
+			pe->tce32_seg = -1;
+		return;
 	}
 
-	pnv_pci_ioda2_tvt_invalidate(pe);
-
 	/* OPAL variant of PHB3 invalidated TCEs */
 	if (pe->tce_inval_reg)
 		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
@@ -2103,12 +2144,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	/* Also create a bypass window */
 	if (!pnv_iommu_bypass_disabled)
 		pnv_pci_ioda2_setup_bypass_pe(phb, pe);
-
-	return;
-fail:
-	if (pe->tce32_seg >= 0)
-		pe->tce32_seg = -1;
-	pnv_pci_free_table(tbl);
 }
 
 static void pnv_ioda_setup_dma(struct pnv_phb *phb)
-- 
2.0.0
