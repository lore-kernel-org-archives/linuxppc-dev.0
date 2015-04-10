Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BCD81A0B95
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:45 +1000 (AEST)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Fri, 10 Apr 2015 16:32:44 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E6C9A2BB005B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:41 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t3A6WX8H37159134
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:41 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t3A6W8WE023179
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Apr 2015 16:32:08 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH kernel v8 18/31] powerpc/powernv/ioda2: Rework iommu_table
 creation
Date: Fri, 10 Apr 2015 16:31:00 +1000
Message-Id: <1428647473-11738-19-git-send-email-aik@ozlabs.ru>
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

This moves iommu_table creation to the beginning. This is a mechanical
patch.

Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 34 ++++++++++++++++---------------
 1 file changed, 18 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 4d80502..a1e0df9 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1437,27 +1437,33 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	addr = page_address(tce_mem);
 	memset(addr, 0, tce_table_size);
 
+	/* Setup iommu */
+	pe->table_group.tables[0].it_group = &pe->table_group;
+
+	/* Setup linux iommu table */
+	tbl = &pe->table_group.tables[0];
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
 		goto fail;
 	}
 
-	/* Setup iommu */
-	pe->table_group.tables[0].it_group = &pe->table_group;
-
-	/* Setup linux iommu table */
-	tbl = &pe->table_group.tables[0];
-	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
-			IOMMU_PAGE_SHIFT_4K);
-
 	/* OPAL variant of PHB3 invalidated TCEs */
 	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
 	if (swinvp) {
@@ -1471,16 +1477,12 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 				8);
 		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
 	}
-	tbl->it_ops = &pnv_ioda2_iommu_ops;
-	iommu_init_table(tbl, phb->hose->node);
-#ifdef CONFIG_IOMMU_API
-	pe->table_group.ops = &pnv_pci_ioda2_ops;
-#endif
 	iommu_register_group(&pe->table_group, phb->hose->global_number,
 			pe->pe_number);
 
 	if (pe->pdev)
-		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
+		set_iommu_table_base_and_group(&pe->pdev->dev,
+				&pe->table_group.tables[0]);
 	else
 		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
 
-- 
2.0.0
