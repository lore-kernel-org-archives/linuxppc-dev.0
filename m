Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B88991A001E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 10:33:15 +1000 (AEST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 11 Aug 2015 06:03:13 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 55F4A1258060
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 06:06:23 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7B0XAJ652691140
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 06:03:10 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7B0X9WS018660
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Aug 2015 06:03:10 +0530
Date: Tue, 11 Aug 2015 10:33:05 +1000
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, bhelgaas@google.com,
 grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com
Subject: Re: [PATCH v6 11/42] powerpc/powernv: Trace DMA32 segments consumed
 by PE
Message-ID: <20150811003305.GA17812@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1438834307-26960-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1438834307-26960-12-git-send-email-gwshan@linux.vnet.ibm.com>
 <55C87254.3020204@ozlabs.ru>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <55C87254.3020204@ozlabs.ru>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Aug 10, 2015 at 07:43:48PM +1000, Alexey Kardashevskiy wrote:
>On 08/06/2015 02:11 PM, Gavin Shan wrote:
>>On P7IOC, the whole DMA32 space is divided evenly to 256MB segments.
>>Each PE can consume one or multiple DMA32 segments. Current code
>>doesn't trace the available DMA32 segments and those consumed by
>>one particular PE. It's conflicting with PCI hotplug.
>>
>>The patch introduces one bitmap to PHB to trace the available
>>DMA32 segments for allocation, more fields to "struct pnv_ioda_pe"
>>to trace the consumed DMA32 segments by the PE, which is going to
>>be released when the PE is destroyed at PCI unplugging time.
>>
>>Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>---
>>  arch/powerpc/platforms/powernv/pci-ioda.c | 40 +++++++++++++++++++++++--------
>>  arch/powerpc/platforms/powernv/pci.h      |  4 +++-
>>  2 files changed, 33 insertions(+), 11 deletions(-)
>>
>>diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>index cd22002..57ba8fd 100644
>>--- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>+++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>@@ -1946,6 +1946,7 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>>
>>  	/* Grab a 32-bit TCE table */
>>  	pe->dma32_seg = base;
>>+	pe->dma32_segcount = segs;
>>  	pe_info(pe, " Setting up 32-bit TCE table at %08x..%08x\n",
>>  		(base << 28), ((base + segs) << 28) - 1);
>>
>>@@ -2006,8 +2007,13 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>>  	return;
>>   fail:
>>  	/* XXX Failure: Try to fallback to 64-bit only ? */
>>-	if (pe->dma32_seg >= 0)
>>+	if (pe->dma32_seg >= 0) {
>>+		bitmap_clear(phb->ioda.dma32_segmap,
>>+			     pe->dma32_seg, pe->dma32_segcount);
>>  		pe->dma32_seg = -1;
>>+		pe->dma32_segcount = 0;
>>+	}
>>+
>>  	if (tce_mem)
>>  		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
>>  	if (tbl) {
>>@@ -2443,12 +2449,11 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>  		pnv_ioda_setup_bus_dma(pe, pe->pbus);
>>  }
>>
>>-static unsigned int pnv_ioda1_setup_dma(struct pnv_phb *phb,
>>-					struct pnv_ioda_pe *pe,
>>-					unsigned int base)
>>+static void pnv_ioda1_setup_dma(struct pnv_phb *phb,
>>+					struct pnv_ioda_pe *pe)
>>  {
>>  	struct pci_controller *hose = phb->hose;
>>-	unsigned int dma_weight, segs;
>>+	unsigned int dma_weight, base, segs;
>>
>>  	/* Calculate the PHB's DMA weight */
>>  	dma_weight = pnv_ioda_phb_dma_weight(phb);
>>@@ -2461,11 +2466,28 @@ static unsigned int pnv_ioda1_setup_dma(struct pnv_phb *phb,
>>  	else
>>  		segs = (pe->dma32_weight *
>>  			phb->ioda.dma32_segcount) / dma_weight;
>>+
>>+	/*
>>+	 * Allocate DMA32 segments. We might not have enough
>>+	 * resources available. However we expect at least one
>>+	 * to be available.
>>+	 */
>>+	do {
>>+		base = bitmap_find_next_zero_area(phb->ioda.dma32_segmap,
>>+						  phb->ioda.dma32_segcount,
>>+						  0, segs, 0);
>>+		if (base < phb->ioda.dma32_segcount) {
>>+			bitmap_set(phb->ioda.dma32_segmap, base, segs);
>>+			break;
>>+		}
>>+	} while (--segs);
>
>
>If segs==0 before entering the loop, the loop will execute 0xfffffffe times.
>Make it for(;segs;--segs){ }.
>

The segs is always equal to 1 or more than that. However, "for()" statement
seems better and I'll change it.

>
>>+
>>+	if (WARN_ON(!segs))
>>+		return;
>>+
>>  	pe_info(pe, "DMA weight %d, assigned %d segments\n",
>>  		pe->dma32_weight, segs);
>>  	pnv_pci_ioda_setup_dma_pe(phb, pe, base, segs);
>>-
>>-	return segs;
>>  }
>>
>>  #ifdef CONFIG_PCI_MSI
>>@@ -2933,20 +2955,18 @@ static void pnv_pci_ioda_setup_DMA(void)
>>  	struct pci_controller *hose, *tmp;
>>  	struct pnv_phb *phb;
>>  	struct pnv_ioda_pe *pe;
>>-	unsigned int base;
>>
>>  	list_for_each_entry_safe(hose, tmp, &hose_list, list_node) {
>>  		phb = hose->private_data;
>>  		pnv_pci_ioda_setup_opal_tce_kill(phb);
>>
>>-		base = 0;
>>  		list_for_each_entry(pe, &phb->ioda.pe_dma_list, dma_link) {
>>  			if (!pe->dma32_weight)
>>  				continue;
>>
>>  			switch (phb->type) {
>>  			case PNV_PHB_IODA1:
>>-				base += pnv_ioda1_setup_dma(phb, pe, base);
>>+				pnv_ioda1_setup_dma(phb, pe);
>>  				break;
>>  			case PNV_PHB_IODA2:
>>  				pnv_pci_ioda2_setup_dma_pe(phb, pe);
>>diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>>index 574fe43..1dc9578 100644
>>--- a/arch/powerpc/platforms/powernv/pci.h
>>+++ b/arch/powerpc/platforms/powernv/pci.h
>>@@ -65,6 +65,7 @@ struct pnv_ioda_pe {
>>
>>  	/* "Base" iommu table, ie, 4K TCEs, 32-bit DMA */
>>  	int			dma32_seg;
>>+	int			dma32_segcount;
>>  	struct iommu_table_group table_group;
>>
>>  	/* 64-bit TCE bypass region */
>>@@ -153,10 +154,11 @@ struct pnv_phb {
>>  			unsigned int		io_segsize;
>>  			unsigned int		io_pci_base;
>>
>>-			/* IO, M32, M64 segment maps */
>>+			/* IO, M32, M64, DMA32 segment maps */
>>  			unsigned long		io_segmap[8];
>>  			unsigned long		m32_segmap[8];
>>  			unsigned long		m64_segmap[8];
>>+			unsigned long		dma32_segmap[8];
>>
>>  			/* PE allocation */
>>  			struct mutex		pe_alloc_mutex;
>>

Thanks,
Gavin
