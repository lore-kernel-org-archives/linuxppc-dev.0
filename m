Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E0B711A0C87
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:26 +1100 (AEDT)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 18:43:24 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 204171258019
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 18:43:22 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDF8K57409570
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:16 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDDJ2032021
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:14 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 16/50] powerpc/powernv: Define PNV_IODA1_DMA32_SEGSIZE
Date: Thu,  5 Nov 2015 00:12:16 +1100
Message-Id: <1446642770-4681-17-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
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
 arch/powerpc/platforms/powernv/pci-ioda.c | 27 ++++++++++++++-------------
 arch/powerpc/platforms/powernv/pci.h      |  1 +
 2 files changed, 15 insertions(+), 13 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 8a19454..5a08e20 100644
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
 
@@ -1853,7 +1850,7 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
 
 	struct page *tce_mem = NULL;
 	struct iommu_table *tbl;
-	unsigned int i;
+	unsigned int tce32_segsz, i;
 	int64_t rc;
 	void *addr;
 
@@ -1873,29 +1870,31 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
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
@@ -1904,8 +1903,9 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
 	}
 
 	/* Setup linux iommu table */
-	pnv_pci_setup_iommu_table(tbl, addr, TCE32_TABLE_SIZE * segs,
-				  base << 28, IOMMU_PAGE_SHIFT_4K);
+	pnv_pci_setup_iommu_table(tbl, addr, tce32_segsz * segs,
+				  base * PNV_IODA1_DMA32_SEGSIZE,
+				  IOMMU_PAGE_SHIFT_4K);
 
 	/* OPAL variant of P7IOC SW invalidated TCEs */
 	if (phb->ioda.tce_inval_reg)
@@ -1935,7 +1935,7 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
 	if (pe->tce32_seg >= 0)
 		pe->tce32_seg = -1;
 	if (tce_mem)
-		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
+		__free_pages(tce_mem, get_order(tce32_segsz * segs));
 	if (tbl) {
 		pnv_pci_unlink_table_and_group(tbl, &pe->table_group);
 		iommu_free_table(tbl, "pnv");
@@ -3216,7 +3216,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
 	mutex_init(&phb->ioda.pe_list_mutex);
 
 	/* Calculate how many 32-bit TCE segments we have */
-	phb->ioda.tce32_count = phb->ioda.m32_pci_base >> 28;
+	phb->ioda.tce32_count = phb->ioda.m32_pci_base /
+				PNV_IODA1_DMA32_SEGSIZE;
 
 #if 0 /* We should really do that ... */
 	rc = opal_pci_set_phb_mem_window(opal->phb_id,
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index c4019ac..46927ff 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -80,6 +80,7 @@ struct pnv_ioda_pe {
 
 #define PNV_IODA1_M64_NUM	16	/* Number of M64 BARs   */
 #define PNV_IODA1_M64_SEGS	8	/* Segments per M64 BAR */
+#define PNV_IODA1_DMA32_SEGSIZE	0x10000000
 
 #define PNV_PHB_FLAG_EEH	(1 << 0)
 
-- 
2.1.0
