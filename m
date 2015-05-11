Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9CC951A0373
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:50 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Tue, 12 May 2015 01:40:50 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id DF96B2BB0060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:46 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4BFecxO48234584
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:46 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4BFeEWE028947
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 May 2015 01:40:14 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v10 26/34] powerpc/powernv/ioda2: Introduce
 pnv_pci_ioda2_set_window
Date: Tue, 12 May 2015 01:39:15 +1000
Message-Id: <1431358763-24371-27-git-send-email-aik@ozlabs.ru>
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
 arch/powerpc/platforms/powernv/pci-ioda.c | 47 +++++++++++++++++++++++++------
 1 file changed, 38 insertions(+), 9 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 7d98d83..85f80b2 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1983,6 +1983,43 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	}
 }
 
+static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
+		int num, struct iommu_table *tbl)
+{
+	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
+			table_group);
+	struct pnv_phb *phb = pe->phb;
+	int64_t rc;
+	const __u64 start_addr = tbl->it_offset << tbl->it_page_shift;
+	const __u64 win_size = tbl->it_size << tbl->it_page_shift;
+
+	pe_info(pe, "Setting up window %llx..%llx pg=%x\n",
+			start_addr, start_addr + win_size - 1,
+			1UL << tbl->it_page_shift);
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
+		return rc;
+	}
+
+	pnv_pci_link_table_and_group(phb->hose->node, num,
+			tbl, &pe->table_group);
+	pnv_pci_ioda2_tvt_invalidate(pe);
+
+	return 0;
+}
+
 static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
 {
 	uint16_t window_id = (pe->pe_number << 1 ) + 1;
@@ -2127,21 +2164,13 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	pe->table_group.ops = &pnv_pci_ioda2_ops;
 #endif
 
-	/*
-	 * Map TCE table through TVT. The TVE index is the PE number
-	 * shifted by 1 bit for 32-bits DMA space.
-	 */
-	rc = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
-			pe->pe_number << 1, 1, __pa(tbl->it_base),
-			tbl->it_size << 3, 1ULL << tbl->it_page_shift);
+	rc = pnv_pci_ioda2_set_window(&pe->table_group, 0, tbl);
 	if (rc) {
 		pe_err(pe, "Failed to configure 32-bit TCE table,"
 		       " err %ld\n", rc);
 		goto fail;
 	}
 
-	pnv_pci_ioda2_tvt_invalidate(pe);
-
 	/* OPAL variant of PHB3 invalidated TCEs */
 	if (pe->tce_inval_reg)
 		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
-- 
2.4.0.rc3.8.gfb3e7d5
