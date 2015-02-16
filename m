Return-Path: <aik@ozlabs.ru>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 61EEE1A0598
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:08:12 +1100 (AEDT)
Received: from /spool/local
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aik@ozlabs.ru>;
 Mon, 16 Feb 2015 20:08:11 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 56F6A357804F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:08:08 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1GA7wdp35651838
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:08:06 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1GA7Y7w021580
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 16 Feb 2015 21:07:34 +1100
From: Alexey Kardashevskiy <aik@ozlabs.ru>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v4 18/28] poweppc/powernv/ioda2: Rework iommu_table creation
Date: Mon, 16 Feb 2015 21:06:10 +1100
Message-Id: <1424081180-4494-19-git-send-email-aik@ozlabs.ru>
In-Reply-To: <1424081180-4494-1-git-send-email-aik@ozlabs.ru>
References: <1424081180-4494-1-git-send-email-aik@ozlabs.ru>
Cc: Alexey Kardashevskiy <aik@ozlabs.ru>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>, Alexander Graf <agraf@suse.de>,
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
 arch/powerpc/platforms/powernv/pci-ioda.c | 31 +++++++++++++++++--------------
 drivers/vfio/vfio_iommu_spapr_tce.c       |  4 +++-
 2 files changed, 20 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 6d279d5..ebfea0a 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1393,27 +1393,31 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	addr = page_address(tce_mem);
 	memset(addr, 0, tce_table_size);
 
+	/* Setup iommu */
+	pe->iommu.tables[0].it_iommu = &pe->iommu;
+
+	/* Setup linux iommu table */
+	tbl = &pe->iommu.tables[0];
+	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
+			IOMMU_PAGE_SHIFT_4K);
+
+	tbl->it_ops = &pnv_ioda2_iommu_ops;
+	iommu_init_table(tbl, phb->hose->node);
+	pe->iommu.ops = &pnv_pci_ioda2_ops;
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
-	pe->iommu.tables[0].it_iommu = &pe->iommu;
-
-	/* Setup linux iommu table */
-	tbl = &pe->iommu.tables[0];
-	pnv_pci_setup_iommu_table(tbl, addr, tce_table_size, 0,
-			IOMMU_PAGE_SHIFT_4K);
-
 	/* OPAL variant of PHB3 invalidated TCEs */
 	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
 	if (swinvp) {
@@ -1427,14 +1431,13 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 				8);
 		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
 	}
-	tbl->it_ops = &pnv_ioda2_iommu_ops;
-	iommu_init_table(tbl, phb->hose->node);
-	pe->iommu.ops = &pnv_pci_ioda2_ops;
+
 	iommu_register_group(&pe->iommu, phb->hose->global_number,
 			pe->pe_number);
 
 	if (pe->pdev)
-		set_iommu_table_base_and_group(&pe->pdev->dev, tbl);
+		set_iommu_table_base_and_group(&pe->pdev->dev,
+				&pe->iommu.tables[0]);
 	else
 		pnv_ioda_setup_bus_dma(pe, pe->pbus, true);
 
diff --git a/drivers/vfio/vfio_iommu_spapr_tce.c b/drivers/vfio/vfio_iommu_spapr_tce.c
index badb648..b5134b7 100644
--- a/drivers/vfio/vfio_iommu_spapr_tce.c
+++ b/drivers/vfio/vfio_iommu_spapr_tce.c
@@ -539,6 +539,7 @@ static long tce_iommu_build(struct tce_container *container,
 	struct page *page;
 	unsigned long hva, oldtce;
 	enum dma_data_direction direction = tce_iommu_direction(tce);
+	bool do_put = false;
 
 	for (i = 0; i < pages; ++i) {
 		if (tce_preregistered(container))
@@ -565,7 +566,8 @@ static long tce_iommu_build(struct tce_container *container,
 		oldtce = 0;
 		ret = iommu_tce_xchg(tbl, entry + i, hva, &oldtce, direction);
 		if (ret) {
-			tce_iommu_unuse_page(container, hva);
+			if (do_put)
+				tce_iommu_unuse_page(container, hva);
 			pr_err("iommu_tce: %s failed ioba=%lx, tce=%lx, ret=%ld\n",
 					__func__, entry << tbl->it_page_shift,
 					tce, ret);
-- 
2.0.0
