Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 264B11A0E90
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:45:00 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 4 Jun 2015 16:44:59 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 34DA5357805B
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Jun 2015 16:44:56 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t546hXl854001720
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:41 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t546h8pf001841
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 4 Jun 2015 16:43:09 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com, aik@ozlabs.ru,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org, Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: [PATCH v5 07/42] powerpc/powernv: Calculate PHB's DMA weight
 dynamically
Date: Thu,  4 Jun 2015 16:41:36 +1000
Message-Id: <1433400131-18429-8-git-send-email-gwshan@linux.vnet.ibm.com>
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

For P7IOC, the whole available DMA32 space, which is below the
MEM32 space, is divided evenly into 256MB segments. How many
continuous segments assigned to one particular PE depends on
the PE's DMA weight that is figured out from the type of each
PCI devices contained in the PE, and PHB's DMA weight which is
accumulative DMA weight of PEs contained in the PHB. It means
that the PHB's DMA weight calculation depends on existing PEs,
which works perfectly now, but not hotplug friendly. As the
whole available DMA32 space can be assigned to one PE on PHB3,
so we don't have the issue on PHB3.

The patch calculates PHB's DMA weight based on the PCI devices
contained in the PHB dynamically so that it's hotplug friendly.
At the meanwhile, the patch removes the code handling DMA weight
for PHB3 in pnv_ioda_setup_dma().

Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
---
v5:
  * Split from PATCH[v4 5/21]
  * Fixed line over 80 characters reported from checkpatch.pl
---
 arch/powerpc/platforms/powernv/pci-ioda.c | 90 +++++++++++++++----------------
 arch/powerpc/platforms/powernv/pci.h      |  6 ---
 2 files changed, 44 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
index 46a5e10..d9ff739 100644
--- a/arch/powerpc/platforms/powernv/pci-ioda.c
+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
@@ -979,8 +979,11 @@ static void pnv_ioda_link_pe_by_weight(struct pnv_phb *phb,
 	list_add_tail(&pe->dma_link, &phb->ioda.pe_dma_list);
 }
 
-static unsigned int pnv_ioda_dma_weight(struct pci_dev *dev)
+static unsigned int pnv_ioda_dev_dma_weight(struct pci_dev *dev)
 {
+	struct pci_controller *hose = pci_bus_to_host(dev->bus);
+	struct pnv_phb *phb = hose->private_data;
+
 	/* This is quite simplistic. The "base" weight of a device
 	 * is 10. 0 means no DMA is to be accounted for it.
 	 */
@@ -993,14 +996,34 @@ static unsigned int pnv_ioda_dma_weight(struct pci_dev *dev)
 	if (dev->class == PCI_CLASS_SERIAL_USB_UHCI ||
 	    dev->class == PCI_CLASS_SERIAL_USB_OHCI ||
 	    dev->class == PCI_CLASS_SERIAL_USB_EHCI)
-		return 3;
+		return 3 * phb->ioda.tce32_count;
 
 	/* Increase the weight of RAID (includes Obsidian) */
 	if ((dev->class >> 8) == PCI_CLASS_STORAGE_RAID)
-		return 15;
+		return 15 * phb->ioda.tce32_count;
 
 	/* Default */
-	return 10;
+	return 10 * phb->ioda.tce32_count;
+}
+
+static int __pnv_ioda_phb_dma_weight(struct pci_dev *pdev, void *data)
+{
+	unsigned int *dma_weight = data;
+
+	*dma_weight += pnv_ioda_dev_dma_weight(pdev);
+	return 0;
+}
+
+static unsigned int pnv_ioda_phb_dma_weight(struct pnv_phb *phb)
+{
+	unsigned int dma_weight = 0;
+
+	if (!phb->hose->bus)
+		return dma_weight;
+
+	pci_walk_bus(phb->hose->bus,
+		     __pnv_ioda_phb_dma_weight, &dma_weight);
+	return dma_weight;
 }
 
 #ifdef CONFIG_PCI_IOV
@@ -1159,7 +1182,7 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
 			continue;
 		}
 		pdn->pe_number = pe->pe_number;
-		pe->dma_weight += pnv_ioda_dma_weight(dev);
+		pe->dma_weight += pnv_ioda_dev_dma_weight(dev);
 		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
 			pnv_ioda_setup_same_PE(dev->subordinate, pe);
 	}
@@ -1222,14 +1245,6 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
 	/* Put PE to the list */
 	list_add_tail(&pe->list, &phb->ioda.pe_list);
 
-	/* Account for one DMA PE if at least one DMA capable device exist
-	 * below the bridge
-	 */
-	if (pe->dma_weight != 0) {
-		phb->ioda.dma_weight += pe->dma_weight;
-		phb->ioda.dma_pe_count++;
-	}
-
 	/* Link the PE */
 	pnv_ioda_link_pe_by_weight(phb, pe);
 }
@@ -2546,24 +2561,13 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
 static void pnv_ioda_setup_dma(struct pnv_phb *phb)
 {
 	struct pci_controller *hose = phb->hose;
-	unsigned int residual, remaining, segs, tw, base;
 	struct pnv_ioda_pe *pe;
+	unsigned int dma_weight;
 
-	/* If we have more PE# than segments available, hand out one
-	 * per PE until we run out and let the rest fail. If not,
-	 * then we assign at least one segment per PE, plus more based
-	 * on the amount of devices under that PE
-	 */
-	if (phb->ioda.dma_pe_count > phb->ioda.tce32_count)
-		residual = 0;
-	else
-		residual = phb->ioda.tce32_count -
-			phb->ioda.dma_pe_count;
-
-	pr_info("PCI: Domain %04x has %ld available 32-bit DMA segments\n",
-		hose->global_number, phb->ioda.tce32_count);
-	pr_info("PCI: %d PE# for a total weight of %d\n",
-		phb->ioda.dma_pe_count, phb->ioda.dma_weight);
+	/* Calculate the PHB's DMA weight */
+	dma_weight = pnv_ioda_phb_dma_weight(phb);
+	pr_info("PCI%04x has %ld DMA32 segments, total weight %d\n",
+		hose->global_number, phb->ioda.tce32_count, dma_weight);
 
 	pnv_pci_ioda_setup_opal_tce_kill(phb);
 
@@ -2571,22 +2575,9 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
 	 * out one base segment plus any residual segments based on
 	 * weight
 	 */
-	remaining = phb->ioda.tce32_count;
-	tw = phb->ioda.dma_weight;
-	base = 0;
 	list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
 		if (!pe->dma_weight)
 			continue;
-		if (!remaining) {
-			pe_warn(pe, "No DMA32 resources available\n");
-			continue;
-		}
-		segs = 1;
-		if (residual) {
-			segs += ((pe->dma_weight * residual)  + (tw / 2)) / tw;
-			if (segs > remaining)
-				segs = remaining;
-		}
 
 		/*
 		 * For IODA2 compliant PHB3, we needn't care about the weight.
@@ -2594,17 +2585,24 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
 		 * the specific PE.
 		 */
 		if (phb->type == PNV_PHB_IODA1) {
+			unsigned int segs, base = 0;
+
+			if (pe->dma_weight <
+			    dma_weight / phb->ioda.tce32_count)
+				segs = 1;
+			else
+				segs = (pe->dma_weight *
+					phb->ioda.tce32_count) / dma_weight;
+
 			pe_info(pe, "DMA weight %d, assigned %d DMA32 segments\n",
 				pe->dma_weight, segs);
 			pnv_pci_ioda_setup_dma_pe(phb, pe, base, segs);
+
+			base += segs;
 		} else {
 			pe_info(pe, "Assign DMA32 space\n");
-			segs = 0;
 			pnv_pci_ioda2_setup_dma_pe(phb, pe);
 		}
-
-		remaining -= segs;
-		base += segs;
 	}
 }
 
diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
index 0a8cecb..38d8616 100644
--- a/arch/powerpc/platforms/powernv/pci.h
+++ b/arch/powerpc/platforms/powernv/pci.h
@@ -185,12 +185,6 @@ struct pnv_phb {
 			/* 32-bit TCE tables allocation */
 			unsigned long		tce32_count;
 
-			/* Total "weight" for the sake of DMA resources
-			 * allocation
-			 */
-			unsigned int		dma_weight;
-			unsigned int		dma_pe_count;
-
 			/* Sorted list of used PE's, sorted at
 			 * boot for resource allocation purposes
 			 */
-- 
2.1.0
