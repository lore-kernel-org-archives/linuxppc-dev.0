Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp03.au.ibm.com (e23smtp03.au.ibm.com [202.81.31.145])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r0dLz73mHzDq5g
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 11:56:59 +1000 (AEST)
Received: from localhost
 by e23smtp03.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Thu, 5 May 2016 11:56:59 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id EB1622CE8062
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 May 2016 11:56:44 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u451uMPj5636402
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 May 2016 11:56:33 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u451twc1029765
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 May 2016 11:55:58 +1000
Date: Thu, 5 May 2016 11:55:28 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, benh@kernel.crashing.org,
 mpe@ellerman.id.au, aik@ozlabs.ru, alistair@popple.id.au
Subject: Re: [PATCH v9 16/26] powerpc/powernv/ioda1: Improve DMA32 segment
 track
Message-ID: <20160505015528.GA6199@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1462254105-24128-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1462254105-24128-17-git-send-email-gwshan@linux.vnet.ibm.com>
 <20160504132001.GA29136@gwshan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160504132001.GA29136@gwshan>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 04, 2016 at 11:20:01PM +1000, Gavin Shan wrote:
>On Tue, May 03, 2016 at 03:41:35PM +1000, Gavin Shan wrote:
>>In current implementation, the DMA32 segments required by one specific
>>PE isn't calculated with the information hold in the PE independently.
>>It conflicts with the PCI hotplug design: PE centralized, meaning the
>>PE's DMA32 segments should be calculated from the information hold in
>>the PE independently.
>>
>>This introduces an array (@dma32_segmap) for every PHB to track the
>>DMA32 segmeng usage. Besides, this moves the logic calculating PE's
>>consumed DMA32 segments to pnv_pci_ioda1_setup_dma_pe() so that PE's
>>DMA32 segments are calculated/allocated from the information hold in
>>the PE (DMA32 weight). Also the logic is improved: we try to allocate
>>as much DMA32 segments as we can. It's acceptable that number of DMA32
>>segments less than the expected number are allocated.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
>This can cause overlapped DMA32 segments to different PEs in some cases.
>I already had the fix and hold for posting after discussion with Michael
>on how to handle the series tomorrow.
>

I'm going to send v10 as a reply to this thread.

Thanks,
Gavin

>>---
>> arch/powerpc/platforms/powernv/pci-ioda.c | 110 ++++++++++++++++--------------
>> arch/powerpc/platforms/powernv/pci.h      |   7 +-
>> 2 files changed, 61 insertions(+), 56 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index f70a4e0..cfd2906 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -2011,27 +2011,57 @@ static unsigned int pnv_pci_ioda_pe_dma_weight(struct pnv_ioda_pe *pe)
>> }
>>
>> static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
>>-				       struct pnv_ioda_pe *pe,
>>-				       unsigned int base,
>>-				       unsigned int segs)
>>+				       struct pnv_ioda_pe *pe)
>> {
>>
>> 	struct page *tce_mem = NULL;
>> 	struct iommu_table *tbl;
>>-	unsigned int tce32_segsz, i;
>>+	unsigned int weight, total_weight = 0;
>>+	unsigned int tce32_segsz, base, segs, i;
>> 	int64_t rc;
>> 	void *addr;
>>
>> 	/* XXX FIXME: Handle 64-bit only DMA devices */
>> 	/* XXX FIXME: Provide 64-bit DMA facilities & non-4K TCE tables etc.. */
>> 	/* XXX FIXME: Allocate multi-level tables on PHB3 */
>>+	pci_walk_bus(phb->hose->bus, pnv_pci_ioda_dev_dma_weight,
>>+		     &total_weight);
>>+	weight = pnv_pci_ioda_pe_dma_weight(pe);
>>+
>>+	segs = (weight * phb->ioda.dma32_count) / total_weight;
>>+	if (!segs)
>>+		segs = 1;
>>+
>>+	/*
>>+	 * Allocate contiguous DMA32 segments. We begin with the expected
>>+	 * number of segments. With one more attempt, the number of DMA32
>>+	 * segments to be allocated is decreased by one until one segment
>>+	 * is allocated successfully.
>>+	 */
>>+	do {
>>+		for (base = 0; base <= phb->ioda.dma32_count - segs; base++) {
>>+			for (i = base; i < base + segs; i++) {
>>+				if (phb->ioda.dma32_segmap[i] !=
>>+				    IODA_INVALID_PE)
>>+					goto found;
>>+			}
>>+		}
>>+	} while (segs--);
>>+
>>+	if (!segs) {
>>+		pe_warn(pe, "No available DMA32 segments\n");
>>+		return;
>>+	}
>>
>>+found:
>> 	tbl = pnv_pci_table_alloc(phb->hose->node);
>> 	iommu_register_group(&pe->table_group, phb->hose->global_number,
>> 			pe->pe_number);
>> 	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
>>
>> 	/* Grab a 32-bit TCE table */
>>+	pe_info(pe, "DMA weight %d (%d), assigned (%d) %d DMA32 segments\n",
>>+		weight, total_weight, base, segs);
>> 	pe_info(pe, " Setting up 32-bit TCE table at %08x..%08x\n",
>> 		base * PNV_IODA1_DMA32_SEGSIZE,
>> 		(base + segs) * PNV_IODA1_DMA32_SEGSIZE - 1);
>>@@ -2068,6 +2098,10 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
>> 		}
>> 	}
>>
>>+	/* Setup DMA32 segment mapping */
>>+	for (i = base; i < base + segs; i++)
>>+		phb->ioda.dma32_segmap[i] = pe->pe_number;
>>+
>> 	/* Setup linux iommu table */
>> 	pnv_pci_setup_iommu_table(tbl, addr, tce32_segsz * segs,
>> 				  base * PNV_IODA1_DMA32_SEGSIZE,
>>@@ -2542,73 +2576,34 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>> static void pnv_ioda_setup_dma(struct pnv_phb *phb)
>> {
>> 	struct pci_controller *hose = phb->hose;
>>-	unsigned int weight, total_weight, dma_pe_count;
>>-	unsigned int residual, remaining, segs, base;
>> 	struct pnv_ioda_pe *pe;
>>-
>>-	total_weight = 0;
>>-	pci_walk_bus(phb->hose->bus, pnv_pci_ioda_dev_dma_weight,
>>-		     &total_weight);
>>-
>>-	dma_pe_count = 0;
>>-	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
>>-		weight = pnv_pci_ioda_pe_dma_weight(pe);
>>-		if (weight > 0)
>>-			dma_pe_count++;
>>-	}
>>+	unsigned int weight;
>>
>> 	/* If we have more PE# than segments available, hand out one
>> 	 * per PE until we run out and let the rest fail. If not,
>> 	 * then we assign at least one segment per PE, plus more based
>> 	 * on the amount of devices under that PE
>> 	 */
>>-	if (dma_pe_count > phb->ioda.tce32_count)
>>-		residual = 0;
>>-	else
>>-		residual = phb->ioda.tce32_count - dma_pe_count;
>>-
>>-	pr_info("PCI: Domain %04x has %ld available 32-bit DMA segments\n",
>>-		hose->global_number, phb->ioda.tce32_count);
>>-	pr_info("PCI: %d PE# for a total weight of %d\n",
>>-		dma_pe_count, total_weight);
>>+	pr_info("PCI: Domain %04x has %d available 32-bit DMA segments\n",
>>+		hose->global_number, phb->ioda.dma32_count);
>>
>> 	pnv_pci_ioda_setup_opal_tce_kill(phb);
>>
>>-	/* Walk our PE list and configure their DMA segments, hand them
>>-	 * out one base segment plus any residual segments based on
>>-	 * weight
>>-	 */
>>-	remaining = phb->ioda.tce32_count;
>>-	base = 0;
>>+	/* Walk our PE list and configure their DMA segments */
>> 	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
>> 		weight = pnv_pci_ioda_pe_dma_weight(pe);
>> 		if (!weight)
>> 			continue;
>>
>>-		if (!remaining) {
>>-			pe_warn(pe, "No DMA32 resources available\n");
>>-			continue;
>>-		}
>>-		segs = 1;
>>-		if (residual) {
>>-			segs += ((weight * residual) + (total_weight / 2)) /
>>-				total_weight;
>>-			if (segs > remaining)
>>-				segs = remaining;
>>-		}
>>-
>> 		/*
>> 		 * For IODA2 compliant PHB3, we needn't care about the weight.
>> 		 * The all available 32-bits DMA space will be assigned to
>> 		 * the specific PE.
>> 		 */
>> 		if (phb->type == PNV_PHB_IODA1) {
>>-			pe_info(pe, "DMA weight %d, assigned %d DMA32 segments\n",
>>-				weight, segs);
>>-			pnv_pci_ioda1_setup_dma_pe(phb, pe, base, segs);
>>+			pnv_pci_ioda1_setup_dma_pe(phb, pe);
>> 		} else if (phb->type == PNV_PHB_IODA2) {
>> 			pe_info(pe, "Assign DMA32 space\n");
>>-			segs = 0;
>> 			pnv_pci_ioda2_setup_dma_pe(phb, pe);
>> 		} else if (phb->type == PNV_PHB_NPU) {
>> 			/*
>>@@ -2618,9 +2613,6 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
>> 			 * as the PHB3 TVT.
>> 			 */
>> 		}
>>-
>>-		remaining -= segs;
>>-		base += segs;
>> 	}
>> }
>>
>>@@ -3327,7 +3319,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>> {
>> 	struct pci_controller *hose;
>> 	struct pnv_phb *phb;
>>-	unsigned long size, m64map_off, m32map_off, pemap_off, iomap_off = 0;
>>+	unsigned long size, m64map_off, m32map_off, pemap_off;
>>+	unsigned long iomap_off = 0, dma32map_off = 0;
>> 	const __be64 *prop64;
>> 	const __be32 *prop32;
>> 	int len;
>>@@ -3413,6 +3406,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>> 	phb->ioda.io_segsize = phb->ioda.io_size / phb->ioda.total_pe_num;
>> 	phb->ioda.io_pci_base = 0; /* XXX calculate this ? */
>>
>>+	/* Calculate how many 32-bit TCE segments we have */
>>+	phb->ioda.dma32_count = phb->ioda.m32_pci_base /
>>+				PNV_IODA1_DMA32_SEGSIZE;
>>+
>> 	/* Allocate aux data & arrays. We don't have IO ports on PHB3 */
>> 	size = _ALIGN_UP(phb->ioda.total_pe_num / 8, sizeof(unsigned long));
>> 	m64map_off = size;
>>@@ -3422,6 +3419,9 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>> 	if (phb->type == PNV_PHB_IODA1) {
>> 		iomap_off = size;
>> 		size += phb->ioda.total_pe_num * sizeof(phb->ioda.io_segmap[0]);
>>+		dma32map_off = size;
>>+		size += phb->ioda.dma32_count *
>>+			sizeof(phb->ioda.dma32_segmap[0]);
>> 	}
>> 	pemap_off = size;
>> 	size += phb->ioda.total_pe_num * sizeof(struct pnv_ioda_pe);
>>@@ -3437,6 +3437,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>> 		phb->ioda.io_segmap = aux + iomap_off;
>> 		for (segno = 0; segno < phb->ioda.total_pe_num; segno++)
>> 			phb->ioda.io_segmap[segno] = IODA_INVALID_PE;
>>+
>>+		phb->ioda.dma32_segmap = aux + dma32map_off;
>>+		for (segno = 0; segno < phb->ioda.dma32_count; segno++)
>>+			phb->ioda.dma32_segmap[segno] = IODA_INVALID_PE;
>> 	}
>> 	phb->ioda.pe_array = aux + pemap_off;
>> 	set_bit(phb->ioda.reserved_pe_idx, phb->ioda.pe_alloc);
>>@@ -3445,7 +3449,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>> 	mutex_init(&phb->ioda.pe_list_mutex);
>>
>> 	/* Calculate how many 32-bit TCE segments we have */
>>-	phb->ioda.tce32_count = phb->ioda.m32_pci_base /
>>+	phb->ioda.dma32_count = phb->ioda.m32_pci_base /
>> 				PNV_IODA1_DMA32_SEGSIZE;
>>
>> #if 0 /* We should really do that ... */
>>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>>index 117cfcd..14d9391 100644
>>--- a/arch/powerpc/platforms/powernv/pci.h
>>+++ b/arch/powerpc/platforms/powernv/pci.h
>>@@ -142,6 +142,10 @@ struct pnv_phb {
>> 		unsigned int		*m32_segmap;
>> 		unsigned int		*io_segmap;
>>
>>+		/* DMA32 segment maps - IODA1 only */
>>+		unsigned int		dma32_count;
>>+		unsigned int		*dma32_segmap;
>>+
>> 		/* IRQ chip */
>> 		int			irq_chip_init;
>> 		struct irq_chip		irq_chip;
>>@@ -158,9 +162,6 @@ struct pnv_phb {
>> 		 */
>> 		unsigned char		pe_rmap[0x10000];
>>
>>-		/* 32-bit TCE tables allocation */
>>-		unsigned long		tce32_count;
>>-
>> 		/* TCE cache invalidate registers (physical and
>> 		 * remapped)
>> 		 */
>>-- 
>>2.1.0
>>
