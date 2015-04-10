Return-Path: <aik@ozlabs.ru>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 51FF31A0BAF
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:33:09 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 10 Apr 2015 16:33:08 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 702BA2BB005C
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:33:06 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3A6WwBl31064146
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:33:06 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3A6WWfb005721
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:32 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v8 20/31] powerpc/powernv/ioda2: Introduce
 pnv_pci_ioda2_set_window
Date: Fri, 10 Apr 2015 16:31:02 +1000
Message-Id: <1428647473-11738-21-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
References: <1428647473-11738-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This is a part of moving DMA window programming to an iommu_ops
callback.

This is a mechanical patch.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 85 ++++++++++++++++++++-----------
 1 file changed, 56 insertions(+), 29 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 908863a..64b7cfe 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1391,6 +1391,57 @@ static void pnv_pci_free_table(struct iommu_table *tbl)
 	memset(tbl, 0, sizeof(struct iommu_table));
 }
 
+static long pnv_pci_ioda2_set_window(struct pnv_ioda_pe *pe,
+		struct iommu_table *tbl)
+{
+	struct pnv_phb *phb = pe->phb;
+	const __be64 *swinvp;
+	int64_t rc;
+	const __u64 start_addr = tbl->it_offset << tbl->it_page_shift;
+	const __u64 win_size = tbl->it_size << tbl->it_page_shift;
+
+	pe_info(pe, "Setting up window at %llx..%llx pagesize=0x%x tablesize=0x%lx\n",
+			start_addr, start_addr + win_size - 1,
+			1UL << tbl->it_page_shift, tbl->it_size << 3);
+
+	pe->table_group.tables[0] = *tbl;
+	tbl = &pe->table_group.tables[0];
+	tbl->it_group = &pe->table_group;
+
+	/*
+	 * Map TCE table through TVT. The TVE index is the PE number
+	 * shifted by 1 bit for 32-bits DMA space.
+	 */
+	rc = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
+			pe->pe_number << 1, 1, __pa(tbl->it_base),
+			tbl->it_size << 3, 1ULL << tbl->it_page_shift);
+	if (rc) {
+		pe_err(pe, "Failed to configure TCE table, err %ld\n", rc);
+		goto fail;
+	}
+
+	/* OPAL variant of PHB3 invalidated TCEs */
+	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
+	if (swinvp) {
+		/* We need a couple more fields -- an address and a data
+		 * to or.  Since the bus is only printed out on table free
+		 * errors, and on the first pass the data will be a relative
+		 * bus number, print that out instead.
+		 */
+		pe->tce_inval_reg_phys = be64_to_cpup(swinvp);
+		tbl->it_index = (unsigned long)ioremap(pe->tce_inval_reg_phys,
+				8);
+		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
+	}
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
@@ -1463,7 +1514,6 @@ static struct iommu_table_group_ops pnv_pci_ioda2_ops = {
 static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 				       struct pnv_ioda_pe *pe)
 {
-	const __be64 *swinvp;
 	unsigned int end;
 	struct iommu_table *tbl = &pe->table_group.tables[0];
 	int64_t rc;
@@ -1493,31 +1543,14 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	pe->table_group.ops = &pnv_pci_ioda2_ops;
 #endif
 
-	/*
-	 * Map TCE table through TVT. The TVE index is the PE number
-	 * shifted by 1 bit for 32-bits DMA space.
-	 */
-	rc = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
-			pe->pe_number << 1, 1, __pa(tbl->it_base),
-			tbl->it_size << 3, 1ULL << tbl->it_page_shift);
+	rc = pnv_pci_ioda2_set_window(pe, tbl);
 	if (rc) {
 		pe_err(pe, "Failed to configure 32-bit TCE table,"
 		       " err %ld\n", rc);
-		goto fail;
-	}
-
-	/* OPAL variant of PHB3 invalidated TCEs */
-	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
-	if (swinvp) {
-		/* We need a couple more fields -- an address and a data
-		 * to or.  Since the bus is only printed out on table free
-		 * errors, and on the first pass the data will be a relative
-		 * bus number, print that out instead.
-		 */
-		pe->tce_inval_reg_phys = be64_to_cpup(swinvp);
-		tbl->it_index = (unsigned long)ioremap(pe->tce_inval_reg_phys,
-				8);
-		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
+		pnv_pci_free_table(tbl);
+		if (pe->tce32_seg >= 0)
+			pe->tce32_seg = -1;
+		return;
 	}
 	iommu_register_group(&pe->table_group, phb->hose->global_number,
 			pe->pe_number);
@@ -1531,12 +1564,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
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
