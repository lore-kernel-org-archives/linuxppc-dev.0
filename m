Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0A4BE1A0047
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 16:13:28 +1000 (AEST)
Received: from /spool/local
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Wed, 10 Jun 2015 16:13:25 +1000
Received: from d23relay07.au.ibm.com (d23relay07.au.ibm.com [9.190.26.37])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id EF92A3578052
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 16:13:22 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay07.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5A6DFDB47841458
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 16:13:23 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5A6CnI8017393
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Jun 2015 16:12:50 +1000
Date: Wed, 10 Jun 2015 16:12:23 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, bhelgaas@google.com,
 panto@antoniou-consulting.com, robherring2@gmail.com,
 grant.likely@linaro.org
Subject: Re: [PATCH v5 08/42] powerpc/powernv: DMA32 cleanup
Message-ID: <20150610061223.GC5664@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1433400131-18429-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1433400131-18429-9-git-send-email-gwshan@linux.vnet.ibm.com>
 <5577BA56.2080507@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <5577BA56.2080507@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jun 10, 2015 at 02:17:26PM +1000, Alexey Kardashevskiy wrote:
>On 06/04/2015 04:41 PM, Gavin Shan wrote:
>>The patch cleans up DMA32 in pci-ioda.c. It shouldn't introduce
>>behavioural changes:
>>
>>    * Rename various fields in "struct pnv_phb" and "struct pnv_ioda_pe"
>>      as 32-bits DMA should be related to "DMA", not "TCE", and move
>>      them around to reflect their relationship and their relative
>>      importance.
>>    * Removed struct pnv_ioda_pe::tce32_segcount.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>v5:
>>   * Split from PATCH[v4 5/21]
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 48 +++++++++++++++----------------
>>  arch/powerpc/platforms/powernv/pci.h      | 13 +++------
>>  2 files changed, 28 insertions(+), 33 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index d9ff739..4af3d06 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -971,7 +971,7 @@ static void pnv_ioda_link_pe_by_weight(struct pnv_phb *phb,
>>  	struct pnv_ioda_pe *lpe;
>>
>>  	list_for_each_entry(lpe, &phb->ioda.pe_dma_list, dma_link) {
>>-		if (lpe->dma_weight < pe->dma_weight) {
>>+		if (lpe->dma32_weight < pe->dma32_weight) {
>>  			list_add_tail(&pe->dma_link, &lpe->dma_link);
>>  			return;
>>  		}
>>@@ -996,14 +996,14 @@ static unsigned int pnv_ioda_dev_dma_weight(struct pci_dev *dev)
>>  	if (dev->class == PCI_CLASS_SERIAL_USB_UHCI ||
>>  	    dev->class == PCI_CLASS_SERIAL_USB_OHCI ||
>>  	    dev->class == PCI_CLASS_SERIAL_USB_EHCI)
>>-		return 3 * phb->ioda.tce32_count;
>>+		return 3 * phb->ioda.dma32_segcount;
>>
>>  	/* Increase the weight of RAID (includes Obsidian) */
>>  	if ((dev->class >> 8) == PCI_CLASS_STORAGE_RAID)
>>-		return 15 * phb->ioda.tce32_count;
>>+		return 15 * phb->ioda.dma32_segcount;
>>
>>  	/* Default */
>>-	return 10 * phb->ioda.tce32_count;
>>+	return 10 * phb->ioda.dma32_segcount;
>>  }
>>
>>  static int __pnv_ioda_phb_dma_weight(struct pci_dev *pdev, void *data)
>>@@ -1182,7 +1182,7 @@ static void pnv_ioda_setup_same_PE(struct pci_bus *bus, struct pnv_ioda_pe *pe)
>>  			continue;
>>  		}
>>  		pdn->pe_number = pe->pe_number;
>>-		pe->dma_weight += pnv_ioda_dev_dma_weight(dev);
>>+		pe->dma32_weight += pnv_ioda_dev_dma_weight(dev);
>>  		if ((pe->flags & PNV_IODA_PE_BUS_ALL) && dev->subordinate)
>>  			pnv_ioda_setup_same_PE(dev->subordinate, pe);
>>  	}
>>@@ -1219,10 +1219,10 @@ static void pnv_ioda_setup_bus_PE(struct pci_bus *bus, int all)
>>  	pe->flags |= (all ? PNV_IODA_PE_BUS_ALL : PNV_IODA_PE_BUS);
>>  	pe->pbus = bus;
>>  	pe->pdev = NULL;
>>-	pe->tce32_seg = -1;
>>+	pe->dma32_seg = -1;
>>  	pe->mve_number = -1;
>>  	pe->rid = bus->busn_res.start << 8;
>>-	pe->dma_weight = 0;
>>+	pe->dma32_weight = 0;
>>
>>  	if (all)
>>  		pe_info(pe, "Secondary bus %d..%d associated with PE#%d\n",
>>@@ -1585,7 +1585,7 @@ static void pnv_ioda_setup_vf_PE(struct pci_dev *pdev, u16 num_vfs)
>>  		pe->flags = PNV_IODA_PE_VF;
>>  		pe->pbus = NULL;
>>  		pe->parent_dev = pdev;
>>-		pe->tce32_seg = -1;
>>+		pe->dma32_seg = -1;
>>  		pe->mve_number = -1;
>>  		pe->rid = (pci_iov_virtfn_bus(pdev, vf_index) << 8) |
>>  			   pci_iov_virtfn_devfn(pdev, vf_index);
>>@@ -2061,7 +2061,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>>  	/* XXX FIXME: Allocate multi-level tables on PHB3 */
>>
>>  	/* We shouldn't already have a 32-bit DMA associated */
>>-	if (WARN_ON(pe->tce32_seg >= 0))
>>+	if (WARN_ON(pe->dma32_seg >= 0))
>>  		return;
>>
>>  	tbl = pnv_pci_table_alloc(phb->hose->node);
>>@@ -2070,7 +2070,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>>  	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
>>
>>  	/* Grab a 32-bit TCE table */
>>-	pe->tce32_seg = base;
>>+	pe->dma32_seg = base;
>>  	pe_info(pe, " Setting up 32-bit TCE table at %08x..%08x\n",
>>  		(base << 28), ((base + segs) << 28) - 1);
>>
>>@@ -2131,8 +2131,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>>  	return;
>>   fail:
>>  	/* XXX Failure: Try to fallback to 64-bit only ? */
>>-	if (pe->tce32_seg >= 0)
>>-		pe->tce32_seg = -1;
>>+	if (pe->dma32_seg >= 0)
>>+		pe->dma32_seg = -1;
>>  	if (tce_mem)
>>  		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
>>  	if (tbl) {
>>@@ -2520,7 +2520,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>  	int64_t rc;
>>
>>  	/* We shouldn't already have a 32-bit DMA associated */
>>-	if (WARN_ON(pe->tce32_seg >= 0))
>>+	if (WARN_ON(pe->dma32_seg >= 0))
>>  		return;
>>
>>  	/* TVE #1 is selected by PCI address bit 59 */
>>@@ -2530,7 +2530,7 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>  			pe->pe_number);
>>
>>  	/* The PE will reserve all possible 32-bits space */
>>-	pe->tce32_seg = 0;
>>+	pe->dma32_seg = 0;
>>  	pe_info(pe, "Setting up 32-bit TCE table at 0..%08x\n",
>>  		phb->ioda.m32_pci_base);
>>
>>@@ -2547,8 +2547,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>
>>  	rc = pnv_pci_ioda2_setup_default_config(pe);
>>  	if (rc) {
>>-		if (pe->tce32_seg >= 0)
>>-			pe->tce32_seg = -1;
>>+		if (pe->dma32_seg >= 0)
>>+			pe->dma32_seg = -1;
>>  		return;
>>  	}
>>
>>@@ -2567,7 +2567,7 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
>>  	/* Calculate the PHB's DMA weight */
>>  	dma_weight = pnv_ioda_phb_dma_weight(phb);
>>  	pr_info("PCI%04x has %ld DMA32 segments, total weight %d\n",
>>-		hose->global_number, phb->ioda.tce32_count, dma_weight);
>>+		hose->global_number, phb->ioda.dma32_segcount, dma_weight);
>>
>>  	pnv_pci_ioda_setup_opal_tce_kill(phb);
>>
>>@@ -2576,7 +2576,7 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
>>  	 * weight
>>  	 */
>>  	list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
>>-		if (!pe->dma_weight)
>>+		if (!pe->dma32_weight)
>>  			continue;
>>
>>  		/*
>>@@ -2587,15 +2587,15 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
>>  		if (phb->type == PNV_PHB_IODA1) {
>>  			unsigned int segs, base = 0;
>>
>>-			if (pe->dma_weight <
>>-			    dma_weight / phb->ioda.tce32_count)
>>+			if (pe->dma32_weight <
>>+			    dma_weight / phb->ioda.dma32_segcount)
>>  				segs = 1;
>>  			else
>>-				segs = (pe->dma_weight *
>>-					phb->ioda.tce32_count) / dma_weight;
>>+				segs = (pe->dma32_weight *
>>+					phb->ioda.dma32_segcount) / dma_weight;
>>
>>  			pe_info(pe, "DMA weight %d, assigned %d DMA32 segments\n",
>>-				pe->dma_weight, segs);
>>+				pe->dma32_weight, segs);
>>  			pnv_pci_ioda_setup_dma_pe(phb, pe, base, segs);
>>
>>  			base += segs;
>>@@ -3314,7 +3314,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>  	mutex_init(&phb->ioda.pe_list_mutex);
>>
>>  	/* Calculate how many 32-bit TCE segments we have */
>>-	phb->ioda.tce32_count = phb->ioda.m32_pci_base >> 28;
>>+	phb->ioda.dma32_segcount = phb->ioda.m32_pci_base >> 28;
>>
>>  #if 0 /* We should really do that ... */
>>  	rc = opal_pci_set_phb_mem_window(opal->phb_id,
>>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>>index 38d8616..5ea33ca 100644
>>--- a/arch/powerpc/platforms/powernv/pci.h
>>+++ b/arch/powerpc/platforms/powernv/pci.h
>>@@ -58,15 +58,10 @@ struct pnv_ioda_pe {
>>  	unsigned long		m32_segmap[8];
>>  	unsigned long		m64_segmap[8];
>>
>>-	/* "Weight" assigned to the PE for the sake of DMA resource
>>-	 * allocations
>>-	 */
>>-	unsigned int		dma_weight;
>
>
>This belongs to the previous patch, more precisely to the part of the
>previous patch which changes stuff for PHB3 and which you want to move to a
>separate patch (or to this one, up to you).
>

Ok. I'll try to change the code according to your comments.

>>-
>>  	/* "Base" iommu table, ie, 4K TCEs, 32-bit DMA */
>>-	int			tce32_seg;
>>-	int			tce32_segcount;
>>  	struct iommu_table_group table_group;
>>+	int			dma32_seg;
>>+	unsigned int		dma32_weight;
>
>Tiny comment - you not just renamed the fields but also moved them :)
>

Yes, as I explained in the chagelog :-)

	* Rename various fields in "struct pnv_phb" and "struct pnv_ioda_pe"
	  as 32-bits DMA should be related to "DMA", not "TCE", and move
	  them around to reflect their relationship and their relative
	  importance.

>>
>>  	/* 64-bit TCE bypass region */
>>  	bool			tce_bypass_enabled;
>>@@ -182,8 +177,8 @@ struct pnv_phb {
>>  			 */
>>  			unsigned char		pe_rmap[0x10000];
>>
>>-			/* 32-bit TCE tables allocation */
>>-			unsigned long		tce32_count;
>>+			/* Number of 32-bit DMA segments */
>>+			unsigned long		dma32_segcount;
>>
>>  			/* Sorted list of used PE's, sorted at
>>  			 * boot for resource allocation purposes
>>

Thanks,
Gavin
