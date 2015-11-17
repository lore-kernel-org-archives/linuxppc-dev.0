Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 14C371A0374
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 13:02:42 +1100 (AEDT)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Nov 2015 12:02:40 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id 7708F2BB0051
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 13:02:38 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAH22N0T28639454
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 13:02:31 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAH224iZ022454
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 13:02:06 +1100
Date: Tue, 17 Nov 2015 13:01:39 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 18/50] powerpc/powernv: Remove DMA32 PE list
Message-ID: <20151117020139.GA3094@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-19-git-send-email-gwshan@linux.vnet.ibm.com>
 <564A88BC.803@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <564A88BC.803@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 17, 2015 at 12:54:04PM +1100, Alexey Kardashevskiy wrote:
>On 11/05/2015 12:12 AM, Gavin Shan wrote:
>>PEs are put into PHB DMA32 list (phb->ioda.pe_dma_list) according
>>to their DMA32 weight. The PEs on the list are iterated to setup
>>their TCE32 tables at system booting time. The list is used for
>>once and there is no good reason for it to survive.
>
>From the above I concluded that you need a list, just do not need to keep
>after the configuration is done but in fact you remove the list completely so
>just remove "to survive" (s/for it to survive/for keep having it/) :)
>

Thanks & will change it accordingly in next revision :)

>>
>>This moves the logic calculating DMA32 weight of PHB and PE to
>>pnv_pci_ioda1_setup_dma() to drop PHB's DMA32 list.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 150 ++++++++++++++----------------
>>  arch/powerpc/platforms/powernv/pci.h      |  19 ----
>>  2 files changed, 68 insertions(+), 101 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index 4c2e023..20ebe6e 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -891,44 +891,6 @@ out:
>>  	return 0;
>>  }
>>
>>-static void pnv_ioda_link_pe_by_weight(struct pnv_phb *phb,
>>-				       struct pnv_ioda_pe *pe)
>>-{
>>-	struct pnv_ioda_pe *lpe;
>>-
>>-	list_for_each_entry(lpe, &phb->ioda.pe_dma_list, dma_link) {
>>-		if (lpe->dma_weight < pe->dma_weight) {
>>-			list_add_tail(&pe->dma_link, &lpe->dma_link);
>>-			return;
>>-		}
>>-	}
>>-	list_add_tail(&pe->dma_link, &phb->ioda.pe_dma_list);
>>-}
>>-
>>-static unsigned int pnv_ioda_dma_weight(struct pci_dev *dev)
>>-{
>>-	/* This is quite simplistic. The "base" weight of a device
>>-	 * is 10. 0 means no DMA is to be accounted for it.
>>-	 */
>>-
>>-	/* If it's a bridge, no DMA */
>>-	if (dev->hdr_type != PCI_HEADER_TYPE_NORMAL)
>>-		return 0;
>>-
>>-	/* Reduce the weight of slow USB controllers */
>>-	if (dev->class == PCI_CLASS_SERIAL_USB_UHCI ||
>>-	    dev->class == PCI_CLASS_SERIAL_USB_OHCI ||
>>-	    dev->class == PCI_CLASS_SERIAL_USB_EHCI)
>>-		return 3;
>>-
>>-	/* Increase the weight of RAID (includes Obsidian) */
>>-	if ((dev->class >> 8) == PCI_CLASS_STORAGE_RAID)
>>-		return 15;
>>-
>>-	/* Default */
>>-	return 10;
>>-}
>>-
>>  #ifdef CONFIG_PCI_IOV
>>  static int pnv_pci_vf_resource_shift(struct pci_dev *dev, int offset)
>>  {
>>@@ -1009,7 +971,6 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
>>  			continue;
>>  		}
>>  		pdn->pe_number = pe->pe_number;
>>-		pe->dma_weight += pnv_ioda_dma_weight(dev);
>>  		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
>>  			pnv_ioda_setup_same_PE(dev->subordinate, pe);
>>  	}
>>@@ -1046,10 +1007,8 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
>>  	pe->flags |= (all ? PNV_IODA_PE_BUS_ALL : PNV_IODA_PE_BUS);
>>  	pe->pbus = bus;
>>  	pe->pdev = NULL;
>>-	pe->tce32_seg = -1;
>>  	pe->mve_number = -1;
>>  	pe->rid = bus->busn_res.start << 8;
>>-	pe->dma_weight = 0;
>>
>>  	if (all)
>>  		pe_info(pe, "Secondary bus %d..%d associated with PE#%d\n",
>>@@ -1071,17 +1030,6 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, bool all)
>>
>>  	/* Put PE to the list */
>>  	list_add_tail(&pe->list, &phb->ioda.pe_list);
>>-
>>-	/* Account for one DMA PE if at least one DMA capable device exist
>>-	 * below the bridge
>>-	 */
>>-	if (pe->dma_weight != 0) {
>>-		phb->ioda.dma_weight += pe->dma_weight;
>>-		phb->ioda.dma_pe_count++;
>>-	}
>>-
>>-	/* Link the PE */
>>-	pnv_ioda_link_pe_by_weight(phb, pe);
>>  }
>>
>>  static void pnv_ioda_setup_PEs(struct pci_bus *bus)
>>@@ -1389,7 +1337,6 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
>>  		pe->flags = PNV_IODA_PE_VF;
>>  		pe->pbus = NULL;
>>  		pe->parent_dev = pdev;
>>-		pe->tce32_seg = -1;
>>  		pe->mve_number = -1;
>>  		pe->rid = (pci_iov_virtfn_bus(pdev, vf_index) << 8) |
>>  			   pci_iov_virtfn_devfn(pdev, vf_index);
>>@@ -1842,6 +1789,47 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops = {
>>  	.free = pnv_ioda2_table_free,
>>  };
>>
>>+static int pnv_pci_ioda_dev_dma_weight(struct pci_dev *dev, void *data)
>>+{
>>+	unsigned int *weight = (unsigned int *)data;
>>+
>>+	/* This is quite simplistic. The "base" weight of a device
>>+	 * is 10. 0 means no DMA is to be accounted for it.
>>+	 */
>>+
>>+	if (dev->hdr_type != PCI_HEADER_TYPE_NORMAL)
>>+		return 0;
>>+
>>+	if (dev->class == PCI_CLASS_SERIAL_USB_UHCI ||
>>+	    dev->class == PCI_CLASS_SERIAL_USB_OHCI ||
>>+	    dev->class == PCI_CLASS_SERIAL_USB_EHCI)
>>+		*weight += 3;
>>+	else if ((dev->class >> 8) == PCI_CLASS_STORAGE_RAID)
>>+		*weight += 15;
>>+	else
>>+		*weight += 10;
>>+
>>+	return 0;
>>+}
>>+
>>+static unsigned int pnv_pci_ioda_pe_dma_weight(struct pnv_ioda_pe *pe)
>>+{
>>+	unsigned int weight = 0;
>>+
>>+	if ((pe->flags & PNV_IODA_PE_DEV) && pe->pdev) {
>>+		pnv_pci_ioda_dev_dma_weight(pe->pdev, &weight);
>>+	} else if ((pe->flags & PNV_IODA_PE_BUS) && pe->pbus) {
>>+		struct pci_dev *pdev;
>>+
>>+		list_for_each_entry(pdev, &pe->pbus->devices, bus_list)
>>+			pnv_pci_ioda_dev_dma_weight(pdev, &weight);
>>+	} else if ((pe->flags & PNV_IODA_PE_BUS_ALL) && pe->pbus) {
>>+		pci_walk_bus(pe->pbus, pnv_pci_ioda_dev_dma_weight, &weight);
>>+	}
>>+
>>+	return weight;
>>+}
>>+
>>  static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
>>  				       struct pnv_ioda_pe *pe,
>>  				       unsigned int base,
>>@@ -1858,17 +1846,12 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
>>  	/* XXX FIXME: Provide 64-bit DMA facilities & non-4K TCE tables etc.. */
>>  	/* XXX FIXME: Allocate multi-level tables on PHB3 */
>>
>>-	/* We shouldn't already have a 32-bit DMA associated */
>>-	if (WARN_ON(pe->tce32_seg >= 0))
>>-		return;
>>-
>>  	tbl = pnv_pci_table_alloc(phb->hose->node);
>>  	iommu_register_group(&pe->table_group, phb->hose->global_number,
>>  			pe->pe_number);
>>  	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
>>
>>  	/* Grab a 32-bit TCE table */
>>-	pe->tce32_seg = base;
>>  	pe_info(pe, " Setting up 32-bit TCE table at %08x..%08x\n",
>>  		base * PNV_IODA1_DMA32_SEGSIZE,
>>  		(base + segs) * PNV_IODA1_DMA32_SEGSIZE - 1);
>>@@ -1932,8 +1915,6 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
>>  	return;
>>   fail:
>>  	/* XXX Failure: Try to fallback to 64-bit only ? */
>>-	if (pe->tce32_seg >= 0)
>>-		pe->tce32_seg = -1;
>>  	if (tce_mem)
>>  		__free_pages(tce_mem, get_order(tce32_segsz * segs));
>>  	if (tbl) {
>>@@ -2344,10 +2325,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>  {
>>  	int64_t rc;
>>
>>-	/* We shouldn't already have a 32-bit DMA associated */
>>-	if (WARN_ON(pe->tce32_seg >= 0))
>>-		return;
>>-
>>  	/* TVE #1 is selected by PCI address bit 59 */
>>  	pe->tce_bypass_base = 1ull << 59;
>>
>>@@ -2355,7 +2332,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>  			pe->pe_number);
>>
>>  	/* The PE will reserve all possible 32-bits space */
>>-	pe->tce32_seg = 0;
>>  	pe_info(pe, "Setting up 32-bit TCE table at 0..%08x\n",
>>  		phb->ioda.m32_pci_base);
>>
>>@@ -2371,11 +2347,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>  #endif
>>
>>  	rc = pnv_pci_ioda2_setup_default_config(pe);
>>-	if (rc) {
>>-		if (pe->tce32_seg >= 0)
>>-			pe->tce32_seg = -1;
>>+	if (rc)
>>  		return;
>>-	}
>>
>>  	if (pe->flags & PNV_IODA_PE_DEV)
>>  		iommu_add_device(&pe->pdev->dev);
>>@@ -2386,24 +2359,34 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>  static void pnv_pci_ioda1_setup_dma(struct pnv_phb *phb)
>>  {
>>  	struct pci_controller *hose = phb->hose;
>>-	unsigned int residual, remaining, segs, tw, base;
>>+	unsigned int weight, total_weight, dma_pe_count;
>>+	unsigned int residual, remaining, segs, base;
>>  	struct pnv_ioda_pe *pe;
>>
>>+	total_weight = 0;
>>+	dma_pe_count = 0;
>>+	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
>>+		weight = pnv_pci_ioda_pe_dma_weight(pe);
>>+		if (weight > 0)
>>+			dma_pe_count++;
>>+
>>+		total_weight += weight;
>>+	}
>>+
>>  	/* If we have more PE# than segments available, hand out one
>>  	 * per PE until we run out and let the rest fail. If not,
>>  	 * then we assign at least one segment per PE, plus more based
>>  	 * on the amount of devices under that PE
>>  	 */
>>-	if (phb->ioda.dma_pe_count > phb->ioda.tce32_count)
>>+	if (dma_pe_count > phb->ioda.tce32_count)
>>  		residual = 0;
>>  	else
>>-		residual = phb->ioda.tce32_count -
>>-			phb->ioda.dma_pe_count;
>>+		residual = phb->ioda.tce32_count - dma_pe_count;
>>
>>  	pr_info("PCI: Domain %04x has %ld available 32-bit DMA segments\n",
>>  		hose->global_number, phb->ioda.tce32_count);
>>  	pr_info("PCI: %d PE# for a total weight of %d\n",
>>-		phb->ioda.dma_pe_count, phb->ioda.dma_weight);
>>+		dma_pe_count, total_weight);
>>
>>  	pnv_pci_ioda_setup_opal_tce_kill(phb);
>>
>>@@ -2412,24 +2395,26 @@ static void pnv_pci_ioda1_setup_dma(struct pnv_phb *phb)
>>  	 * weight
>>  	 */
>>  	remaining = phb->ioda.tce32_count;
>>-	tw = phb->ioda.dma_weight;
>>  	base = 0;
>>-	list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
>>-		if (!pe->dma_weight)
>>+	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
>>+		weight = pnv_pci_ioda_pe_dma_weight(pe);
>>+		if (!weight)
>>  			continue;
>>+
>
>
>Unrelated new line.
>

Will remove it in next revision.

Thanks,
Gavin
