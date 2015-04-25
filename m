Return-Path: <aik@ozlabs.ru>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id BF6BA1A0C3A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:21 +1000 (AEST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Sat, 25 Apr 2015 22:16:21 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 2CEDD2BB0055
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:20 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3PCGCCS47775792
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:16:20 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3PCFkET014053
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 25 Apr 2015 22:15:46 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v9 19/32] powerpc/powernv/ioda2: Rework iommu_table
 creation
Date: Sat, 25 Apr 2015 22:14:43 +1000
Message-Id: <1429964096-11524-20-git-send-email-aik@ozlabs.ru>
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

This moves iommu_table creation to the beginning to make following changes
easier to review. This starts using table parameters from the iommu_table
struct.

This should cause no behavioural change.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
Changes:
v9:
* updated commit log and did minor cleanup
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 33 +++++++++++++++----------------
 1 file changed, 16 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fb765af..a80be34 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2041,7 +2041,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 {
 	struct page *tce_mem = NULL;
 	void *addr;
-	struct iommu_table *tbl;
+	struct iommu_table *tbl = &pe->table_group.tables[0];
 	unsigned int tce_table_size, end;
 	int64_t rc;
 
@@ -2068,13 +2068,26 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	addr = page_address(tce_mem);
 	memset(addr, 0, tce_table_size);
 
+	/* Setup iommu */
+	tbl->it_table_group = &pe->table_group;
+
+	/* Setup linux iommu table */
+	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
+			IOMMU_PAGE_SHIFT_4K);
+
+	tbl->it_ops = &pnv_ioda2_iommu_ops;
+	iommu_init_table(tbl, phb->hose->node);
+#ifdef CONFIG_IOMMU_API
+	pe->table_group.ops = &pnv_pci_ioda2_ops;
+#endif
+
 	/*
 	 * Map TCE table through TVT. The TVE index is the PE number
 	 * shifted by 1 bit for 32-bits DMA space.
 	 */
 	rc = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
-					pe->pe_number << 1, 1, __pa(addr),
-					tce_table_size, 0x1000);
+			pe->pe_number << 1, 1, __pa(tbl->it_base),
+			tbl->it_size << 3, 1ULL << tbl->it_page_shift);
 	if (rc) {
 		pe_err(pe, "Failed to configure 32-bit TCE table,"
 		       " err %ld\n", rc);
@@ -2083,24 +2096,10 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 
 	pnv_pci_ioda2_tvt_invalidate(pe);
 
-	/* Setup iommu */
-	pe->table_group.tables[0].it_table_group = &pe->table_group;
-
-	/* Setup linux iommu table */
-	tbl = &pe->table_group.tables[0];
-	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
-			IOMMU_PAGE_SHIFT_4K);
-
 	/* OPAL variant of PHB3 invalidated TCEs */
 	if (pe->tce_inval_reg)
 		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
 
-	tbl->it_ops = &pnv_ioda2_iommu_ops;
-	iommu_init_table(tbl, phb->hose->node);
-#ifdef CONFIG_IOMMU_API
-	pe->table_group.ops = &pnv_pci_ioda2_ops;
-#endif
-
 	if (pe->flags & PNV_IODA_PE_DEV) {
 		iommu_register_group(&pe->table_group, phb->hose->global_number,
 				     pe->pe_number);
-- 
2.0.0
