Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22a.google.com (mail-pa0-x22a.google.com
 [IPv6:2607:f8b0:400e:c03::22a])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qqVMB6GhWzDqCX
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Apr 2016 15:10:30 +1000 (AEST)
Received: by mail-pa0-x22a.google.com with SMTP id zm5so13961842pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Apr 2016 22:10:30 -0700 (PDT)
Subject: Re: [PATCH v8 17/45] powerpc/powernv/ioda1: Improve DMA32 segment
 track
To: Gavin Shan <gwshan@linux.vnet.ibm.com>, benh@kernel.crashing.org
References: <1455680668-23298-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1455680668-23298-18-git-send-email-gwshan@linux.vnet.ibm.com>
 <57158ED2.5050203@ozlabs.ru> <20160420004920.GA17414@gwshan>
Cc: linuxppc-dev@lists.ozlabs.org, linux-pci@vger.kernel.org,
 devicetree@vger.kernel.org, mpe@ellerman.id.au, dja@axtens.net,
 bhelgaas@google.com, robherring2@gmail.com, grant.likely@linaro.org
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <57170F3C.8020407@ozlabs.ru>
Date: Wed, 20 Apr 2016 15:10:20 +1000
MIME-Version: 1.0
In-Reply-To: <20160420004920.GA17414@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/20/2016 10:49 AM, Gavin Shan wrote:
> On Tue, Apr 19, 2016 at 11:50:10AM +1000, Alexey Kardashevskiy wrote:
>> On 02/17/2016 02:44 PM, Gavin Shan wrote:
>>> In current implementation, the DMA32 segments required by one specific
>>> PE isn't calculated with the information hold in the PE independently.
>>> It conflicts with the PCI hotplug design: PE centralized, meaning the
>>> PE's DMA32 segments should be calculated from the information hold in
>>> the PE independently.
>>>
>>> This introduces an array (@dma32_segmap) for every PHB to track the
>>> DMA32 segmeng usage. Besides, this moves the logic calculating PE's
>>> consumed DMA32 segments to pnv_pci_ioda1_setup_dma_pe() so that PE's
>>> DMA32 segments are calculated/allocated from the information hold in
>>> the PE (DMA32 weight). Also the logic is improved: we try to allocate
>>> as much DMA32 segments as we can. It's acceptable that number of DMA32
>>> segments less than the expected number are allocated.
>>>
>>> Signed-off-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>>
>>
>> This DMA segments business was the reason why I have not even tried
>> implementing DDW for POWER7 - it is way too different from POWER8 and there
>> is no chance that anyone outside Ozlabs will ever try using this in practice;
>> the same applies to PCI hotplug on POWER7.
>>
>> I am suggesting to ditch all IODA1 changes from this patchset as this code
>> will hang around (unused) for may be a year or so and then will be gone as
>> p5ioc2.
>>
>
> As I knew, some P7 boxes out of Ozlabs have the software stack. At least,
> I was heavily relying on P7 box + PowerNV based linux heavily until last
> September of last year.

And yet you have not replaced a single physical device on any of our power7 
boxes ;)

> My original thoughts are as below. If they're
> convincing, I can drop some of IODA1 changes, but not all of them obviously:
>
> - In case customer want to use this combo (P7 box + PowerNV) for any reason.

I have serious doubts we have any customer like this. Or a developer who 
would want this. And OPAL on P7 does not support this either.

> - In case developers want to use this combo (P7 box + PowerNV) for any reason.
>    For example, no P8 boxes can be found for one particular project, but available
>    P7 box is still ok for that.

Testing POWER8 PCI hotplug on POWER7 machine is kind of pointless anyway.


> - EEH supported on P7/P8 needs hotplug some cases: when hitting excessive failures,
>    PCI devices and their platform resources (PE, DMA, M32/M64 mapping etc) should
>    be purged.

EEH recovery should not require resource reallocation, no?

> - Current implementation has P7/P8 mixed up to some extent which isn't so good
>    as Ben pointed long time ago. It's impossible not to affect P7IOC piece if
>    P8 piece is changed in order to support hotplug.

This is understandable.


I'll leave it to Ben.


>
>>> ---
>>>   arch/powerpc/platforms/powernv/pci-ioda.c | 111 +++++++++++++++++-------------
>>>   arch/powerpc/platforms/powernv/pci.h      |   7 +-
>>>   2 files changed, 66 insertions(+), 52 deletions(-)
>>>
>>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>>> index 0fc2309..59782fba 100644
>>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>>> @@ -2007,20 +2007,54 @@ static unsigned int pnv_pci_ioda_total_dma_weight(struct pnv_phb *phb)
>>>   }
>>>
>>>   static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
>>> -				       struct pnv_ioda_pe *pe,
>>> -				       unsigned int base,
>>> -				       unsigned int segs)
>>> +				       struct pnv_ioda_pe *pe)
>>>   {
>>>
>>>   	struct page *tce_mem = NULL;
>>>   	struct iommu_table *tbl;
>>> -	unsigned int tce32_segsz, i;
>>> +	unsigned int weight, total_weight;
>>> +	unsigned int tce32_segsz, base, segs, i;
>>>   	int64_t rc;
>>>   	void *addr;
>>>
>>>   	/* XXX FIXME: Handle 64-bit only DMA devices */
>>>   	/* XXX FIXME: Provide 64-bit DMA facilities & non-4K TCE tables etc.. */
>>>   	/* XXX FIXME: Allocate multi-level tables on PHB3 */
>>> +	total_weight = pnv_pci_ioda_total_dma_weight(phb);
>>> +	weight = pnv_pci_ioda_pe_dma_weight(pe);
>>> +
>>> +	segs = (weight * phb->ioda.dma32_count) / total_weight;
>>> +	if (!segs)
>>> +		segs = 1;
>>> +
>>> +	/*
>>> +	 * Allocate contiguous DMA32 segments. We begin with the expected
>>> +	 * number of segments. With one more attempt, the number of DMA32
>>> +	 * segments to be allocated is decreased by one until one segment
>>> +	 * is allocated successfully.
>>> +	 */
>>> +	while (segs) {
>>> +		for (base = 0; base <= phb->ioda.dma32_count - segs; base++) {
>>> +			for (i = base; i < base + segs; i++) {
>>> +				if (phb->ioda.dma32_segmap[i] !=
>>> +				    IODA_INVALID_PE)
>>> +					break;
>>> +			}
>>> +
>>> +			if (i >= base + segs)
>>> +				break;
>>> +		}
>>> +
>>> +		if (i >= base + segs)
>>> +			break;
>>> +
>>> +		segs--;
>>> +	}
>>> +
>>> +	if (!segs) {
>>> +		pe_warn(pe, "No available DMA32 segments\n");
>>> +		return;
>>> +	}
>>>
>>>   	tbl = pnv_pci_table_alloc(phb->hose->node);
>>>   	iommu_register_group(&pe->table_group, phb->hose->global_number,
>>> @@ -2028,6 +2062,8 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
>>>   	pnv_pci_link_table_and_group(phb->hose->node, 0, tbl, &pe->table_group);
>>>
>>>   	/* Grab a 32-bit TCE table */
>>> +	pe_info(pe, "DMA weight %d (%d), assigned (%d) %d DMA32 segments\n",
>>> +		weight, total_weight, base, segs);
>>>   	pe_info(pe, " Setting up 32-bit TCE table at %08x..%08x\n",
>>>   		base * PNV_IODA1_DMA32_SEGSIZE,
>>>   		(base + segs) * PNV_IODA1_DMA32_SEGSIZE - 1);
>>> @@ -2064,6 +2100,10 @@ static void pnv_pci_ioda1_setup_dma_pe(struct pnv_phb *phb,
>>>   		}
>>>   	}
>>>
>>> +	/* Setup DMA32 segment mapping */
>>> +	for (i = base; i < base + segs; i++)
>>> +		phb->ioda.dma32_segmap[i] = pe->pe_number;
>>> +
>>>   	/* Setup linux iommu table */
>>>   	pnv_pci_setup_iommu_table(tbl, addr, tce32_segsz * segs,
>>>   				  base * PNV_IODA1_DMA32_SEGSIZE,
>>> @@ -2538,70 +2578,34 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>>   static void pnv_ioda_setup_dma(struct pnv_phb *phb)
>>>   {
>>>   	struct pci_controller *hose = phb->hose;
>>> -	unsigned int weight, total_weight, dma_pe_count;
>>> -	unsigned int residual, remaining, segs, base;
>>>   	struct pnv_ioda_pe *pe;
>>> -
>>> -	total_weight = pnv_pci_ioda_total_dma_weight(phb);
>>> -	dma_pe_count = 0;
>>> -	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
>>> -		weight = pnv_pci_ioda_pe_dma_weight(pe);
>>> -		if (weight > 0)
>>> -			dma_pe_count++;
>>> -	}
>>> +	unsigned int weight;
>>>
>>>   	/* If we have more PE# than segments available, hand out one
>>>   	 * per PE until we run out and let the rest fail. If not,
>>>   	 * then we assign at least one segment per PE, plus more based
>>>   	 * on the amount of devices under that PE
>>>   	 */
>>> -	if (dma_pe_count > phb->ioda.tce32_count)
>>> -		residual = 0;
>>> -	else
>>> -		residual = phb->ioda.tce32_count - dma_pe_count;
>>> -
>>>   	pr_info("PCI: Domain %04x has %ld available 32-bit DMA segments\n",
>>> -		hose->global_number, phb->ioda.tce32_count);
>>> -	pr_info("PCI: %d PE# for a total weight of %d\n",
>>> -		dma_pe_count, total_weight);
>>> +		hose->global_number, phb->ioda.dma32_count);
>>>
>>>   	pnv_pci_ioda_setup_opal_tce_kill(phb);
>>>
>>> -	/* Walk our PE list and configure their DMA segments, hand them
>>> -	 * out one base segment plus any residual segments based on
>>> -	 * weight
>>> -	 */
>>> -	remaining = phb->ioda.tce32_count;
>>> -	base = 0;
>>> +	/* Walk our PE list and configure their DMA segments */
>>>   	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
>>>   		weight = pnv_pci_ioda_pe_dma_weight(pe);
>>>   		if (!weight)
>>>   			continue;
>>>
>>> -		if (!remaining) {
>>> -			pe_warn(pe, "No DMA32 resources available\n");
>>> -			continue;
>>> -		}
>>> -		segs = 1;
>>> -		if (residual) {
>>> -			segs += ((weight * residual) + (total_weight / 2)) /
>>> -				total_weight;
>>> -			if (segs > remaining)
>>> -				segs = remaining;
>>> -		}
>>> -
>>>   		/*
>>>   		 * For IODA2 compliant PHB3, we needn't care about the weight.
>>>   		 * The all available 32-bits DMA space will be assigned to
>>>   		 * the specific PE.
>>>   		 */
>>>   		if (phb->type == PNV_PHB_IODA1) {
>>> -			pe_info(pe, "DMA weight %d, assigned %d DMA32 segments\n",
>>> -				weight, segs);
>>> -			pnv_pci_ioda1_setup_dma_pe(phb, pe, base, segs);
>>> +			pnv_pci_ioda1_setup_dma_pe(phb, pe);
>>>   		} else if (phb->type == PNV_PHB_IODA2) {
>>>   			pe_info(pe, "Assign DMA32 space\n");
>>> -			segs = 0;
>>>   			pnv_pci_ioda2_setup_dma_pe(phb, pe);
>>>   		} else if (phb->type == PNV_PHB_NPU) {
>>>   			/*
>>> @@ -2611,9 +2615,6 @@ static void pnv_ioda_setup_dma(struct pnv_phb *phb)
>>>   			 * as the PHB3 TVT.
>>>   			 */
>>>   		}
>>> -
>>> -		remaining -= segs;
>>> -		base += segs;
>>>   	}
>>>   }
>>>
>>> @@ -3313,7 +3314,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>>   {
>>>   	struct pci_controller *hose;
>>>   	struct pnv_phb *phb;
>>> -	unsigned long size, m64map_off, m32map_off, pemap_off, iomap_off = 0;
>>> +	unsigned long size, m64map_off, m32map_off, pemap_off;
>>> +	unsigned long iomap_off = 0, dma32map_off = 0;
>>>   	const __be64 *prop64;
>>>   	const __be32 *prop32;
>>>   	int i, len;
>>> @@ -3398,6 +3400,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>>   	phb->ioda.io_segsize = phb->ioda.io_size / phb->ioda.total_pe_num;
>>>   	phb->ioda.io_pci_base = 0; /* XXX calculate this ? */
>>>
>>> +	/* Calculate how many 32-bit TCE segments we have */
>>> +	phb->ioda.dma32_count = phb->ioda.m32_pci_base /
>>> +				PNV_IODA1_DMA32_SEGSIZE;
>>> +
>>>   	/* Allocate aux data & arrays. We don't have IO ports on PHB3 */
>>>   	size = _ALIGN_UP(phb->ioda.total_pe_num / 8, sizeof(unsigned long));
>>>   	m64map_off = size;
>>> @@ -3407,6 +3413,9 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>>   	if (phb->type == PNV_PHB_IODA1) {
>>>   		iomap_off = size;
>>>   		size += phb->ioda.total_pe_num * sizeof(phb->ioda.io_segmap[0]);
>>> +		dma32map_off = size;
>>> +		size += phb->ioda.dma32_count *
>>> +			sizeof(phb->ioda.dma32_segmap[0]);
>>>   	}
>>>   	pemap_off = size;
>>>   	size += phb->ioda.total_pe_num * sizeof(struct pnv_ioda_pe);
>>> @@ -3422,6 +3431,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>>   		phb->ioda.io_segmap = aux + iomap_off;
>>>   		for (i = 0; i < phb->ioda.total_pe_num; i++)
>>>   			phb->ioda.io_segmap[i] = IODA_INVALID_PE;
>>> +
>>> +		phb->ioda.dma32_segmap = aux + dma32map_off;
>>> +		for (i = 0; i < phb->ioda.dma32_count; i++)
>>> +			phb->ioda.dma32_segmap[i] = IODA_INVALID_PE;
>>>   	}
>>>   	phb->ioda.pe_array = aux + pemap_off;
>>>   	set_bit(phb->ioda.reserved_pe_idx, phb->ioda.pe_alloc);
>>> @@ -3430,7 +3443,7 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>>   	mutex_init(&phb->ioda.pe_list_mutex);
>>>
>>>   	/* Calculate how many 32-bit TCE segments we have */
>>> -	phb->ioda.tce32_count = phb->ioda.m32_pci_base /
>>> +	phb->ioda.dma32_count = phb->ioda.m32_pci_base /
>>>   				PNV_IODA1_DMA32_SEGSIZE;
>>>
>>>   #if 0 /* We should really do that ... */
>>> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>>> index e90bcbe..350e630 100644
>>> --- a/arch/powerpc/platforms/powernv/pci.h
>>> +++ b/arch/powerpc/platforms/powernv/pci.h
>>> @@ -146,6 +146,10 @@ struct pnv_phb {
>>>   		int			*m32_segmap;
>>>   		int			*io_segmap;
>>>
>>> +		/* DMA32 segment maps - IODA1 only */
>>> +		unsigned long		dma32_count;
>>> +		int			*dma32_segmap;
>>> +
>>>   		/* IRQ chip */
>>>   		int			irq_chip_init;
>>>   		struct irq_chip		irq_chip;
>>> @@ -162,9 +166,6 @@ struct pnv_phb {
>>>   		 */
>>>   		unsigned char		pe_rmap[0x10000];
>>>
>>> -		/* 32-bit TCE tables allocation */
>>> -		unsigned long		tce32_count;
>>> -
>>>   		/* TCE cache invalidate registers (physical and
>>>   		 * remapped)
>>>   		 */
>>>
>>
>>
>> --
>> Alexey
>>
>
> --
> To unsubscribe from this list: send the line "unsubscribe linux-pci" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
>


-- 
Alexey
