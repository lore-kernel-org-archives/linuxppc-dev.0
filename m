Return-Path: <aik@ozlabs.ru>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9A0B61A1D81
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 16:38:15 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 5 Jun 2015 16:38:15 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 03D422BB0057
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  5 Jun 2015 16:38:13 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t556ao9s20250740
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 16:36:58 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t556aPBO015314
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 5 Jun 2015 16:36:25 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 David Gibson <david@gibson.dropbear.id.au>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Paul Mackerras <paulus@samba.org>,
 Wei Yang <weiyang@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org
Subject: [PATCH kernel v12 24/34] powerpc/powernv/ioda2: Rework iommu_table
 creation
Date: Fri,  5 Jun 2015 16:35:16 +1000
Message-Id: <1433486126-23551-25-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1433486126-23551-1-git-send-email-aik@ozlabs.ru>
References: <1433486126-23551-1-git-send-email-aik@ozlabs.ru>
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
Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
Changes:
v9:
* updated commit log and did minor cleanup
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 24 ++++++++++++------------
 1 file changed, 12 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 19d89dc..95d3121 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2070,13 +2070,23 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	addr = page_address(tce_mem);
 	memset(addr, 0, tce_table_size);
 
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
@@ -2085,20 +2095,10 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 
 	pnv_pci_ioda2_tce_invalidate_entire(pe);
 
-	/* Setup linux iommu table */
-	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
-			IOMMU_PAGE_SHIFT_4K);
-
 	/* OPAL variant of PHB3 invalidated TCEs */
 	if (phb->ioda.tce_inval_reg)
 		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
 
-	tbl->it_ops = &pnv_ioda2_iommu_ops;
-	iommu_init_table(tbl, phb->hose->node);
-#ifdef CONFIG_IOMMU_API
-	pe->table_group.ops = &pnv_pci_ioda2_ops;
-#endif
-
 	if (pe->flags & PNV_IODA_PE_DEV) {
 		/*
 		 * Setting table base here only for carrying iommu_group
-- 
2.4.0.rc3.8.gfb3e7d5
