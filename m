Return-Path: <weiyang@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DE531A0237
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 11:57:03 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <weiyang@linux.vnet.ibm.com>;
 Tue, 10 Jun 2014 07:27:01 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 0264A394003E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 07:26:59 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s5A1vC0o8716718
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 07:27:12 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s5A1uwfc029077
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 10 Jun 2014 07:26:58 +0530
From: Wei Yang <weiyang@linux.vnet.ibm.com>
To: benh@au1.ibm.com
Subject: [RFC PATCH V3 05/17] ppc/pnv: user macro to define the TCE size
Date: Tue, 10 Jun 2014 09:56:27 +0800
Message-Id: <1402365399-5121-6-git-send-email-weiyang@linux.vnet.ibm.com>
In-Reply-To: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
References: <1402365399-5121-1-git-send-email-weiyang@linux.vnet.ibm.com>
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-pci@vger.kernel.org,
 gwshan@linux.vnet.ibm.com, qiudayu@linux.vnet.ibm.com, bhelgaas@google.com,
 yan@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

During the initialization of the TVT/TCE, it uses digits to specify the TCE IO
Page Size, TCE Table Size, TCE Entry Size, etc.

This patch replaces those digits with macros, which will be more meaningful and
easy to read.

Signed-off-by: Wei Yang <weiyang@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/tce.h            |    3 ++-
 arch/powerpc/platforms/powernv/pci-ioda.c |   25 +++++++++++--------------
 arch/powerpc/platforms/powernv/pci.c      |    2 +-
 arch/powerpc/platforms/powernv/pci.h      |    5 +++++
 4 files changed, 19 insertions(+), 16 deletions(-)

diff --git a/arch/powerpc/include/asm/tce.h b/arch/powerpc/include/asm/tce.h
index 743f36b..28a1d06 100644
--- a/arch/powerpc/include/asm/tce.h
+++ b/arch/powerpc/include/asm/tce.h
@@ -40,7 +40,8 @@
 #define TCE_SHIFT	12
 #define TCE_PAGE_SIZE	(1 << TCE_SHIFT)
 
-#define TCE_ENTRY_SIZE		8		/* each TCE is 64 bits */
+#define TCE_ENTRY_SHIFT		3
+#define TCE_ENTRY_SIZE		(1 << TCE_ENTRY_SHIFT)	/* each TCE is 64 bits */
 
 #define TCE_RPN_MASK		0xfffffffffful  /* 40-bit RPN (4K pages) */
 #define TCE_RPN_SHIFT		12
diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8ae09cf..9715351 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -820,9 +820,6 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	int64_t rc;
 	void *addr;
 
-	/* 256M DMA window, 4K TCE pages, 8 bytes TCE */
-#define TCE32_TABLE_SIZE	((0x10000000 / 0x1000) * 8)
-
 	/* XXX FIXME: Handle 64-bit only DMA devices */
 	/* XXX FIXME: Provide 64-bit DMA facilities & non-4K TCE tables etc.. */
 	/* XXX FIXME: Allocate multi-level tables on PHB3 */
@@ -834,7 +831,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	/* Grab a 32-bit TCE table */
 	pe->tce32_seg = base;
 	pe_info(pe, " Setting up 32-bit TCE table at %08x..%08x\n",
-		(base << 28), ((base + segs) << 28) - 1);
+		(base << PNV_TCE32_SEG_SHIFT), ((base + segs) << PNV_TCE32_SEG_SHIFT) - 1);
 
 	/* XXX Currently, we allocate one big contiguous table for the
 	 * TCEs. We only really need one chunk per 256M of TCE space
@@ -842,21 +839,21 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	 * requires some added smarts with our get/put_tce implementation
 	 */
 	tce_mem = alloc_pages_node(phb->hose->node, GFP_KERNEL,
-				   get_order(TCE32_TABLE_SIZE * segs));
+				   get_order(PNV_TCE32_TAB_SIZE * segs));
 	if (!tce_mem) {
 		pe_err(pe, " Failed to allocate a 32-bit TCE memory\n");
 		goto fail;
 	}
 	addr = page_address(tce_mem);
-	memset(addr, 0, TCE32_TABLE_SIZE * segs);
+	memset(addr, 0, PNV_TCE32_TAB_SIZE * segs);
 
 	/* Configure HW */
 	for (i = 0; i < segs; i++) {
 		rc = opal_pci_map_pe_dma_window(phb->opal_id,
 					      pe->pe_number,
 					      base + i, 1,
-					      __pa(addr) + TCE32_TABLE_SIZE * i,
-					      TCE32_TABLE_SIZE, 0x1000);
+					      __pa(addr) + PNV_TCE32_TAB_SIZE * i,
+					      PNV_TCE32_TAB_SIZE, TCE_PAGE_SIZE);
 		if (rc) {
 			pe_err(pe, " Failed to configure 32-bit TCE table,"
 			       " err %ld\n", rc);
@@ -866,8 +863,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 
 	/* Setup linux iommu table */
 	tbl = &pe->tce32_table;
-	pnv_pci_setup_iommu_table(tbl, addr, TCE32_TABLE_SIZE * segs,
-				  base << 28);
+	pnv_pci_setup_iommu_table(tbl, addr, PNV_TCE32_TAB_SIZE * segs,
+				  base << PNV_TCE32_SEG_SHIFT);
 
 	/* OPAL variant of P7IOC SW invalidated TCEs */
 	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
@@ -898,7 +895,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
 	if (pe->tce32_seg >= 0)
 		pe->tce32_seg = -1;
 	if (tce_mem)
-		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
+		__free_pages(tce_mem, get_order(PNV_TCE32_TAB_SIZE * segs));
 }
 
 static void pnv_pci_ioda2_set_bypass(struct iommu_table *tbl, bool enable)
@@ -968,7 +965,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	/* The PE will reserve all possible 32-bits space */
 	pe->tce32_seg = 0;
 	end = (1 << ilog2(phb->ioda.m32_pci_base));
-	tce_table_size = (end / 0x1000) * 8;
+	tce_table_size = (end / TCE_PAGE_SIZE) * TCE_ENTRY_SIZE;
 	pe_info(pe, "Setting up 32-bit TCE table at 0..%08x\n",
 		end);
 
@@ -988,7 +985,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 	 */
 	rc = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
 					pe->pe_number << 1, 1, __pa(addr),
-					tce_table_size, 0x1000);
+					tce_table_size, TCE_PAGE_SIZE);
 	if (rc) {
 		pe_err(pe, "Failed to configure 32-bit TCE table,"
 		       " err %ld\n", rc);
@@ -1573,7 +1570,7 @@ void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	INIT_LIST_HEAD(&phb->ioda.pe_list);
 
 	/* Calculate how many 32-bit TCE segments we have */
-	phb->ioda.tce32_count = phb->ioda.m32_pci_base >> 28;
+	phb->ioda.tce32_count = phb->ioda.m32_pci_base >> PNV_TCE32_SEG_SHIFT;
 
 #if 0 /* We should really do that ... */
 	rc = opal_pci_set_phb_mem_window(opal->phb_id,
diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
index 8518817..687a068 100644
--- a/arch/powerpc/platforms/powernv/pci.c
+++ b/arch/powerpc/platforms/powernv/pci.c
@@ -597,7 +597,7 @@ void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
 	tbl->it_page_shift = IOMMU_PAGE_SHIFT_4K;
 	tbl->it_offset = dma_offset >> tbl->it_page_shift;
 	tbl->it_index = 0;
-	tbl->it_size = tce_size >> 3;
+	tbl->it_size = tce_size >> TCE_ENTRY_SHIFT;
 	tbl->it_busno = 0;
 	tbl->it_type = TCE_PCI;
 }
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 3e5f5a1..90f6da4 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -227,4 +227,9 @@ extern void pnv_pci_init_ioda2_phb(struct device_node *np);
 extern void pnv_pci_ioda_tce_invalidate(struct iommu_table *tbl,
 					__be64 *startp, __be64 *endp, bool rm);
 
+#define PNV_TCE32_SEG_SHIFT     28
+#define PNV_TCE32_SEG_SIZE      (1UL << PNV_TCE32_SEG_SHIFT)
+/* 256M DMA window, 4K TCE pages, 8 bytes TCE */
+#define PNV_TCE32_TAB_SIZE	((PNV_TCE32_SEG_SIZE / TCE_PAGE_SIZE) * TCE_ENTRY_SIZE)
+
 #endif /* __POWERNV_PCI_H */
-- 
1.7.9.5
