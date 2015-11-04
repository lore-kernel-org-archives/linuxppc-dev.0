Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E1B5C1A0C8F
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Nov 2015 00:13:32 +1100 (AEDT)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 4 Nov 2015 18:43:30 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 29014125805E
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  4 Nov 2015 18:43:28 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tA4DDFWT36110452
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:16 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA4DDDqB031561
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 4 Nov 2015 18:43:15 +0530
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com,
 Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v7 17/50] powerpc/powernv: Avoid calculating DMA32 segments on
 PHB3
Date: Thu,  5 Nov 2015 00:12:17 +1100
Message-Id: <1446642770-4681-18-git-send-email-gwshan@linux.vnet.ibm.com>
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

In pnv_ioda_setup_dma(), it's unnecessary to calculate the DMA32
segments for PEs on PHB3 as the whole available DMA32 space can
be assigned to one specific PE on PHB3.

This splits pnv_ioda_setup_dma() to pnv_pci_ioda1_setup_dma() and
pnv_pci_ioda2_setup_dma() in order to avoid calculating DMA32
segments for PEs on PHB3. No logical changes introduced.

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 41 ++++++++++++++++++-------------
 1 file changed, 24 insertions(+), 17 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 5a08e20..4c2e023 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -2383,7 +2383,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 		pnv_ioda_setup_bus_dma(pe, pe->pbus);
 }
 
-static void pnv_ioda_setup_dma(struct pnv_phb *phb)
+static void pnv_pci_ioda1_setup_dma(struct pnv_phb *phb)
 {
 	struct pci_controller *hose = phb->hose;
 	unsigned int residual, remaining, segs, tw, base;
@@ -2428,26 +2428,30 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
 				segs = remaining;
 		}
 
-		/*
-		 * For IODA2 compliant PHB3, we needn't care about the weight.
-		 * The all available 32-bits DMA space will be assigned to
-		 * the specific PE.
-		 */
-		if (phb->type == PNV_PHB_IODA1) {
-			pe_info(pe, "DMA weight %d, assigned %d DMA32 segments\n",
-				pe->dma_weight, segs);
-			pnv_pci_ioda1_setup_dma_pe(phb, pe, base, segs);
-		} else {
-			pe_info(pe, "Assign DMA32 space\n");
-			segs = 0;
-			pnv_pci_ioda2_setup_dma_pe(phb, pe);
-		}
+		pe_info(pe, "DMA weight %d, assigned %d DMA32 segments\n",
+			pe->dma_weight, segs);
+		pnv_pci_ioda1_setup_dma_pe(phb, pe, base, segs);
 
 		remaining -= segs;
 		base += segs;
 	}
 }
 
+static void pnv_pci_ioda2_setup_dma(struct pnv_phb *phb)
+{
+	struct pnv_ioda_pe *pe;
+
+	pnv_pci_ioda_setup_opal_tce_kill(phb);
+
+	list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
+		if (!pe->dma_weight)
+			continue;
+
+		pe_info(pe, "Assign DMA32 space\n");
+		pnv_pci_ioda2_setup_dma_pe(phb, pe);
+	}
+}
+
 #ifdef CONFIG_PCI_MSI
 static void pnv_ioda2_msi_eoi(struct irq_data *d)
 {
@@ -2931,10 +2935,13 @@ static void pnv_pci_ioda_setup_DMA(void)
 	struct pnv_phb *phb;
 
 	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
-		pnv_ioda_setup_dma(hose->private_data);
+		phb = hose->private_data;
+		if (phb->type == PNV_PHB_IODA1)
+			pnv_pci_ioda1_setup_dma(phb);
+		else
+			pnv_pci_ioda2_setup_dma(phb);
 
 		/* Mark the PHB initialization done */
-		phb = hose->private_data;
 		phb->initialized = 1;
 	}
 }
-- 
2.1.0
