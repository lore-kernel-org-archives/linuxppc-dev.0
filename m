Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8EB601A0C74
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:55 +1100 (AEDT)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 18:43:52 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id E1DD61258061
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 18:43:49 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDm7332571440
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:48 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDFAr031654
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:16 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 20/50] powerpc/powernv: Improve DMA32 segment calculation
Date: Thu,  5 Nov 2015 00:12:20 +1100
Message-Id: <1446642770-4681-21-git-send-email-gwshan@linux.vnet.ibm.com>
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

In current implementation, the DMA32 segments required by one specific
PE isn't calculated with the information hold in the PE independently.
It conflicts with the PCI hotplug design: PE centralized, meaning the
PE's DMA32 segments should be calculated from the information hold in
the PE independently.

This moves the logic calculating PE's consumed DMA32 segments from
pnv_pci_ioda1_setup_dma() to pnv_pci_ioda1_setup_dma_pe() so that PE's
DMA32 segments are calculated/allocated from the information hold in
the PE (DMA32 weight). Also the logic is improved: we try to allocate
as much DMA32 segments as we can. It's acceptable that number of DMA32
segments less than the expected number are allocated.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 119 ++++++++++++++----------------
 1 file changed, 57 insertions(+), 62 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index fdbc012..0e66c4d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -1830,15 +1830,23 @@ static unsigned int pnv_pci_ioda_pe_dma_weight(struct pnv_ioda_pe *pe)
 	return weight;
 }
 
+static unsigned int pnv_pci_ioda_total_dma_weight(struct pnv_phb *phb)
+{
+	unsigned int weight = 0;
+
+	pci_walk_bus(phb->hose->bus, pnv_pci_ioda_dev_dma_weight, &weight);
+	return weight;
+}
+
 static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
-				       struct pnv_ioda_pe *pe,
-				       unsigned int base,
-				       unsigned int segs)
+				       struct pnv_ioda_pe *pe)
 {
 
 	struct page *tce_mem = NULL;
 	struct iommu_table *tbl;
-	unsigned int tce32_segsz, i;
+	unsigned int weight, total_weight;
+	unsigned int tce32_segsz, base, segs, i;
+	bool found;
 	int64_t rc;
 	void *addr;
 
@@ -1846,12 +1854,55 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
 	/* XXX FIXME: Provide 64-bit DMA facilities & non-4K TCE tables etc.. */
 	/* XXX FIXME: Allocate multi-level tables on PHB3 */
 
+	total_weight = pnv_pci_ioda_total_dma_weight(phb);
+	weight = pnv_pci_ioda_pe_dma_weight(pe);
+	if (!total_weight || !weight)
+		return;
+
+	segs = (weight * phb->ioda.dma32_count) / total_weight;
+	if (!segs)
+		segs = 1;
+
+	/*
+	 * Allocate continuous DMA32 segments. We begin with the expected
+	 * number of segments. With one more attempt, the number of DMA32
+	 * segments to be allocated is decreased by one until one segment
+	 * is allocated successfully.
+	 */
+	while (segs) {
+		found = false;
+		for (base = 0; base <= phb->ioda.dma32_count - segs; base++) {
+			for (i = base; i < base + segs; i++) {
+				if (phb->ioda.dma32_segmap[i] !=
+				    IODA_INVALID_PE)
+					break;
+			}
+
+			if (i >= base + segs) {
+				found = true;
+				break;
+			}
+		}
+
+		if (found)
+			break;
+
+		segs--;
+	}
+
+	if (!segs) {
+		pe_warn(pe, "No available DMA32 resource\n");
+		return;
+	}
+
 	tbl = pnv_pci_table_alloc(phb->hose->node);
 	iommu_register_group(&pe->table_group, phb->hose->global_number,
 			pe->pe_number);
 	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
 
 	/* Grab a 32-bit TCE table */
+	pe_info(pe, "DMA weight %d (%d), assigned %d DMA32 segments\n",
+		weight, total_weight, segs);
 	pe_info(pe, " Setting up 32-bit TCE table at %08x..%08x\n",
 		base * PNV_IODA1_DMA32_SEGSIZE,
 		(base + segs) * PNV_IODA1_DMA32_SEGSIZE - 1);
@@ -2362,68 +2413,12 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 
 static void pnv_pci_ioda1_setup_dma(struct pnv_phb *phb)
 {
-	struct pci_controller *hose = phb->hose;
-	unsigned int weight, total_weight, dma_pe_count;
-	unsigned int residual, remaining, segs, base;
 	struct pnv_ioda_pe *pe;
 
-	total_weight = 0;
-	dma_pe_count = 0;
-	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
-		weight = pnv_pci_ioda_pe_dma_weight(pe);
-		if (weight > 0)
-			dma_pe_count++;
-
-		total_weight += weight;
-	}
-
-	/* If we have more PE# than segments available, hand out one
-	 * per PE until we run out and let the rest fail. If not,
-	 * then we assign at least one segment per PE, plus more based
-	 * on the amount of devices under that PE
-	 */
-	if (dma_pe_count > phb->ioda.dma32_count)
-		residual = 0;
-	else
-		residual = phb->ioda.dma32_count - dma_pe_count;
-
-	pr_info("PCI: Domain %04x has %ld available 32-bit DMA segments\n",
-		hose->global_number, phb->ioda.dma32_count);
-	pr_info("PCI: %d PE# for a total weight of %d\n",
-		dma_pe_count, total_weight);
-
 	pnv_pci_ioda_setup_opal_tce_kill(phb);
 
-	/* Walk our PE list and configure their DMA segments, hand them
-	 * out one base segment plus any residual segments based on
-	 * weight
-	 */
-	remaining = phb->ioda.dma32_count;
-	base = 0;
-	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
-		weight = pnv_pci_ioda_pe_dma_weight(pe);
-		if (!weight)
-			continue;
-
-		if (!remaining) {
-			pe_warn(pe, "No DMA32 resources available\n");
-			continue;
-		}
-		segs = 1;
-		if (residual) {
-			segs += ((weight * residual)  + (total_weight / 2)) /
-				total_weight;
-			if (segs > remaining)
-				segs = remaining;
-		}
-
-		pe_info(pe, "DMA weight %d, assigned %d DMA32 segments\n",
-			weight, segs);
-		pnv_pci_ioda1_setup_dma_pe(phb, pe, base, segs);
-
-		remaining -= segs;
-		base += segs;
-	}
+	list_for_each_entry(pe, &phb->ioda.pe_list, list)
+		pnv_pci_ioda1_setup_dma_pe(phb, pe);
 }
 
 static void pnv_pci_ioda2_setup_dma(struct pnv_phb *phb)
-- 
2.1.0
