Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 54E2C1A0BBF
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:43:49 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 16:43:46 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7BC363578057
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:43:44 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t546hZCs35389654
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:43 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t546hB0q002965
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:12 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 09/42] powerpc/powernv: pnv_ioda_setup_dma() configure one
 PE only
Date: Thu,  4 Jun 2015 16:41:38 +1000
Message-Id: <1433400131-18429-10-git-send-email-gwshan@linux.vnet.ibm.com>
In-Reply-To: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The original implementation of pnv_ioda_setup_dma() iterates the
list of PEs and configures the DMA32 space for them one by one.
The function was designed to be called during PHB fixup time.
When configuring PE's DMA32 space in pcibios_setup_bridge(), in
order to support PCI hotplug, we have to have the function PE
oriented.

The patch introduces one more argument "struct pnv_ioda_pe *pe"
to pnv_ioda_setup_dma(). The caller, pnv_pci_ioda_setup_DMA(),
gets PE from the list and passes to it. The patch shouldn't
cause logic changes.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Split from PATCH[v4 06/21]
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 60 ++++++++++++++-----------------
 1 file changed, 27 insertions(+), 33 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 4af3d06..63fad4d 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2558,12 +2558,14 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		pnv_ioda_setup_bus_dma(pe, pe->pbus);
 }
 
-static void pnv_ioda_setup_dma(struct pnv_phb *phb)
+static void pnv_ioda_setup_dma(struct pnv_phb *phb, struct pnv_ioda_pe *pe)
 {
 	struct pci_controller *hose = phb->hose;
-	struct pnv_ioda_pe *pe;
 	unsigned int dma_weight;
 
+	if (!pe->dma32_weight)
+		return;
+
 	/* Calculate the PHB's DMA weight */
 	dma_weight = pnv_ioda_phb_dma_weight(phb);
 	pr_info("PCI%04x has %ld DMA32 segments, total weight %d\n",
@@ -2571,38 +2573,28 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
 
 	pnv_pci_ioda_setup_opal_tce_kill(phb);
 
-	/* Walk our PE list and configure their DMA segments, hand them
-	 * out one base segment plus any residual segments based on
-	 * weight
+	/*
+	 * For IODA2 compliant PHB3, we needn't care about the weight.
+	 * The all available 32-bits DMA space will be assigned to
+	 * the specific PE.
 	 */
-	list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
-		if (!pe->dma32_weight)
-			continue;
+	if (phb->type == PNV_PHB_IODA1) {
+		unsigned int segs, base = 0;
 
-		/*
-		 * For IODA2 compliant PHB3, we needn't care about the weight.
-		 * The all available 32-bits DMA space will be assigned to
-		 * the specific PE.
-		 */
-		if (phb->type == PNV_PHB_IODA1) {
-			unsigned int segs, base = 0;
-
-			if (pe->dma32_weight <
-			    dma_weight / phb->ioda.dma32_segcount)
-				segs = 1;
-			else
-				segs = (pe->dma32_weight *
-					phb->ioda.dma32_segcount) / dma_weight;
-
-			pe_info(pe, "DMA weight %d, assigned %d DMA32 segments\n",
-				pe->dma32_weight, segs);
-			pnv_pci_ioda_setup_dma_pe(phb, pe, base, segs);
+		if (pe->dma32_weight <
+		    dma_weight / phb->ioda.dma32_segcount)
+			segs = 1;
+		else
+			segs = (pe->dma32_weight *
+				phb->ioda.dma32_segcount) / dma_weight;
 
-			base += segs;
-		} else {
-			pe_info(pe, "Assign DMA32 space\n");
-			pnv_pci_ioda2_setup_dma_pe(phb, pe);
-		}
+		pe_info(pe, "DMA weight %d, assigned %d DMA32 segments\n",
+			pe->dma32_weight, segs);
+		pnv_pci_ioda_setup_dma_pe(phb, pe, base, segs);
+		base += segs;
+	} else {
+		pe_info(pe, "Assign DMA32 space\n");
+		pnv_pci_ioda2_setup_dma_pe(phb, pe);
 	}
 }
 
@@ -3073,12 +3065,14 @@ static void pnv_pci_ioda_setup_DMA(void)
 {
 	struct pci_controller *hose, *tmp;
 	struct pnv_phb *phb;
+	struct pnv_ioda_pe *pe;
 
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
-		pnv_ioda_setup_dma(hose->private_data);
+		phb = hose->private_data;
+		list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link)
+			pnv_ioda_setup_dma(phb, pe);
 
 		/* Mark the PHB initialization done */
-		phb = hose->private_data;
 		phb->initialized = 1;
 	}
 }
-- 
2.1.0
