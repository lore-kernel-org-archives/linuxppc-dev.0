Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CE6C91A029A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:55 +1100 (AEDT)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 17 Feb 2016 13:45:55 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 2E6182CE805C
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:52 +1100 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1H3jicV3867060
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:52 +1100
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1H3jITH018076
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 17 Feb 2016 14:45:19 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 dja@axtens.net, bhelgaas@google.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v8 15/45] powerpc/powernv/ioda1: Introduce
 PNV_IODA1_DMA32_SEGSIZE
Date: Wed, 17 Feb 2016 14:43:58 +1100
Message-Id: <1455680668-23298-16-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently, there is one macro (TCE32_TABLE_SIZE) representing the
TCE table size for one DMA32 segment. The constant representing
the DMA32 segment size (1 << 28) is still used in the code.

This defines PNV_IODA1_DMA32_SEGSIZE representing one DMA32
segment size. the TCE table size can be calcualted when the page
has fixed 4KB size. So all the related calculation depends on one
macro (PNV_IODA1_DMA32_SEGSIZE). No logical changes introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 30 +++++++++++++++++-------------
 arch/powerpc/platforms/powernv/pci.h      |  1 +
 2 files changed, 18 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index d18b95e..e60cff6 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -48,9 +48,6 @@
 #include "powernv.h"
 #include "pci.h"
 
-/* 256M DMA window, 4K TCE pages, 8 bytes TCE */
-#define TCE32_TABLE_SIZE	((0x10000000 / 0x1000) * 8)
-
 #define POWERNV_IOMMU_DEFAULT_LEVELS	1
 #define POWERNV_IOMMU_MAX_LEVELS	5
 
@@ -2034,7 +2031,7 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
 
 	struct page *tce_mem = NULL;
 	struct iommu_table *tbl;
-	unsigned int i;
+	unsigned int tce32_segsz, i;
 	int64_t rc;
 	void *addr;
 
@@ -2054,29 +2051,34 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
 	/* Grab a 32-bit TCE table */
 	pe->tce32_seg = base;
 	pe_info(pe, " Setting up 32-bit TCE table at %08x..%08x\n",
-		(base << 28), ((base + segs) << 28) - 1);
+		base * PNV_IODA1_DMA32_SEGSIZE,
+		(base + segs) * PNV_IODA1_DMA32_SEGSIZE - 1);
 
 	/* XXX Currently, we allocate one big contiguous table for the
 	 * TCEs. We only really need one chunk per 256M of TCE space
 	 * (ie per segment) but that's an optimization for later, it
 	 * requires some added smarts with our get/put_tce implementation
+	 *
+	 * Each TCE page is 4KB in size and each TCE entry occupies 8
+	 * bytes
 	 */
+	tce32_segsz = PNV_IODA1_DMA32_SEGSIZE >> (IOMMU_PAGE_SHIFT_4K - 3);
 	tce_mem = alloc_pages_node(phb->hose->node, GFP_KERNEL,
-				   get_order(TCE32_TABLE_SIZE * segs));
+				   get_order(tce32_segsz * segs));
 	if (!tce_mem) {
 		pe_err(pe, " Failed to allocate a 32-bit TCE memory\n");
 		goto fail;
 	}
 	addr = page_address(tce_mem);
-	memset(addr, 0, TCE32_TABLE_SIZE * segs);
+	memset(addr, 0, tce32_segsz * segs);
 
 	/* Configure HW */
 	for (i = 0; i < segs; i++) {
 		rc = opal_pci_map_pe_dma_window(phb->opal_id,
 					      pe->pe_number,
 					      base + i, 1,
-					      __pa(addr) + TCE32_TABLE_SIZE * i,
-					      TCE32_TABLE_SIZE, 0x1000);
+					      __pa(addr) + tce32_segsz * i,
+					      tce32_segsz, 0x1000);
 		if (rc) {
 			pe_err(pe, " Failed to configure 32-bit TCE table,"
 			       " err %ld\n", rc);
@@ -2085,8 +2087,9 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
 	}
 
 	/* Setup linux iommu table */
-	pnv_pci_setup_iommu_table(tbl, addr, TCE32_TABLE_SIZE * segs,
-				  base << 28, IOMMU_PAGE_SHIFT_4K);
+	pnv_pci_setup_iommu_table(tbl, addr, tce32_segsz * segs,
+				  base * PNV_IODA1_DMA32_SEGSIZE,
+				  IOMMU_PAGE_SHIFT_4K);
 
 	/* OPAL variant of P7IOC SW invalidated TCEs */
 	if (phb->ioda.tce_inval_reg)
@@ -2116,7 +2119,7 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
 	if (pe->tce32_seg >= 0)
 		pe->tce32_seg = -1;
 	if (tce_mem)
-		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
+		__free_pages(tce_mem, get_order(tce32_segsz * segs));
 	if (tbl) {
 		pnv_pci_unlink_table_and_group(tbl, &pe->table_group);
 		iommu_free_table(tbl, "pnv");
@@ -3445,7 +3448,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	mutex_init(&phb->ioda.pe_list_mutex);
 
 	/* Calculate how many 32-bit TCE segments we have */
-	phb->ioda.tce32_count = phb->ioda.m32_pci_base >> 28;
+	phb->ioda.tce32_count = phb->ioda.m32_pci_base /
+				PNV_IODA1_DMA32_SEGSIZE;
 
 #if 0 /* We should really do that ... */
 	rc = opal_pci_set_phb_mem_window(opal->phb_id,
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 00539ff..1d8e775 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -84,6 +84,7 @@ struct pnv_ioda_pe {
 
 #define PNV_IODA1_M64_NUM	16	/* Number of M64 BARs   */
 #define PNV_IODA1_M64_SEGS	8	/* Segments per M64 BAR */
+#define PNV_IODA1_DMA32_SEGSIZE	0x10000000
 
 #define PNV_PHB_FLAG_EEH	(1 << 0)
 
-- 
2.1.0
