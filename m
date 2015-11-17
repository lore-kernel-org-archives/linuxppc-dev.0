Return-Path: <gwshan@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 827FA1A0196
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:56:52 +1100 (AEDT)
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <gwshan@linux.vnet.ibm.com>;
 Tue, 17 Nov 2015 11:56:51 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 9BDF43578058
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:56:48 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 tAH1uXXF34734230
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:56:42 +1100
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tAH1uEHZ031426
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Nov 2015 12:56:16 +1100
Date: Tue, 17 Nov 2015 12:55:50 +1100
From: Gavin Shan <gwshan@linux.vnet.ibm.com>
To: Daniel Axtens <dja@axtens.net>
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-pci@vger.kernel.org, devicetree@vger.kernel.org,
 benh@kernel.crashing.org, mpe@ellerman.id.au, aik@ozlabs.ru,
 bhelgaas@google.com, grant.likely@linaro.org, robherring2@gmail.com,
 panto@antoniou-consulting.com, frowand.list@gmail.com
Subject: Re: [PATCH v7 19/50] powerpc/powernv: Track DMA32 segment consumption
Message-ID: <20151117015550.GA1452@gwshan>
Reply-To: Gavin Shan <gwshan@linux.vnet.ibm.com>
References: <1446642770-4681-1-git-send-email-gwshan@linux.vnet.ibm.com>
 <1446642770-4681-20-git-send-email-gwshan@linux.vnet.ibm.com>
 <87ziydbhaz.fsf@gamma.ozlabs.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <87ziydbhaz.fsf@gamma.ozlabs.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Nov 17, 2015 at 11:28:20AM +1100, Daniel Axtens wrote:
>Gavin Shan <gwshan@linux.vnet.ibm.com> writes:
>
>> Similar to the mechanism tracking consumed IO/M32/M64 segments,
>> this introduces an array for each PHB to track the consumed DMA32
>> segments, which are going to be released on PCI unplugging time.
>> The index of the array is the DMA32 segment number while the value
>> stored in the element is the assigned PE number.
>>
>
>
>> +	/* Setup TCE32 segment mapping */
>Do you mean DMA32 rather than TCE32?

Right, will change it to "DMA32" in next revision.

>> +	for (i = base; i < base + segs; i++)
>> +		phb->ioda.dma32_segmap[i] = pe->pe_number;
>> +
>I'm pretty sure this is right, but can you just confirm that you
>intended to index into the array starting at base and going to base + segs,
>and not going from 0 to segs? (i.e. not dma32_segmap[i - base]).
>

I think you're saying "I'm not pretty sure this is right". The code doesn't
have problem here: it starts from @base.

>Otherwise looks good.
>
>
>>  	/* Setup linux iommu table */
>>  	pnv_pci_setup_iommu_table(tbl, addr, tce32_segsz * segs,
>>  				  base * PNV_IODA1_DMA32_SEGSIZE,
>> @@ -2378,13 +2382,13 @@ static void pnv_pci_ioda1_setup_dma(struct pnv_phb *phb)
>>  	 * then we assign at least one segment per PE, plus more based
>>  	 * on the amount of devices under that PE
>>  	 */
>> -	if (dma_pe_count > phb->ioda.tce32_count)
>> +	if (dma_pe_count > phb->ioda.dma32_count)
>>  		residual = 0;
>>  	else
>> -		residual = phb->ioda.tce32_count - dma_pe_count;
>> +		residual = phb->ioda.dma32_count - dma_pe_count;
>>  
>>  	pr_info("PCI: Domain %04x has %ld available 32-bit DMA segments\n",
>> -		hose->global_number, phb->ioda.tce32_count);
>> +		hose->global_number, phb->ioda.dma32_count);
>>  	pr_info("PCI: %d PE# for a total weight of %d\n",
>>  		dma_pe_count, total_weight);
>>  
>> @@ -2394,7 +2398,7 @@ static void pnv_pci_ioda1_setup_dma(struct pnv_phb *phb)
>>  	 * out one base segment plus any residual segments based on
>>  	 * weight
>>  	 */
>> -	remaining = phb->ioda.tce32_count;
>> +	remaining = phb->ioda.dma32_count;
>>  	base = 0;
>>  	list_for_each_entry(pe, &phb->ioda.pe_list, list) {
>>  		weight = pnv_pci_ioda_pe_dma_weight(pe);
>> @@ -3094,7 +3098,8 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>  {
>>  	struct pci_controller *hose;
>>  	struct pnv_phb *phb;
>> -	unsigned long size, m64map_off, m32map_off, pemap_off, iomap_off = 0;
>> +	unsigned long size, m64map_off, m32map_off, pemap_off;
>> +	unsigned long iomap_off = 0, dma32map_off = 0;
>>  	const __be64 *prop64;
>>  	const __be32 *prop32;
>>  	int i, len;
>> @@ -3177,6 +3182,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>  	phb->ioda.io_segsize = phb->ioda.io_size / phb->ioda.total_pe_num;
>>  	phb->ioda.io_pci_base = 0; /* XXX calculate this ? */
>>  
>> +	/* Calculate how many 32-bit TCE segments we have */
>> +	phb->ioda.dma32_count = phb->ioda.m32_pci_base /
>> +				PNV_IODA1_DMA32_SEGSIZE;
>> +
>>  	/* Allocate aux data & arrays. We don't have IO ports on PHB3 */
>>  	size = _ALIGN_UP(phb->ioda.total_pe_num / 8, sizeof(unsigned long));
>>  	m64map_off = size;
>> @@ -3186,6 +3195,9 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>  	if (phb->type == PNV_PHB_IODA1) {
>>  		iomap_off = size;
>>  		size += phb->ioda.total_pe_num * sizeof(phb->ioda.io_segmap[0]);
>> +		dma32map_off = size;
>> +		size += phb->ioda.dma32_count *
>> +			sizeof(phb->ioda.dma32_segmap[0]);
>>  	}
>>  	pemap_off = size;
>>  	size += phb->ioda.total_pe_num * sizeof(struct pnv_ioda_pe);
>> @@ -3201,6 +3213,10 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>  		phb->ioda.io_segmap = aux + iomap_off;
>>  		for (i = 0; i < phb->ioda.total_pe_num; i++)
>>  			phb->ioda.io_segmap[i] = IODA_INVALID_PE;
>> +
>> +		phb->ioda.dma32_segmap = aux + dma32map_off;
>> +		for (i = 0; i < phb->ioda.dma32_count; i++)
>> +			phb->ioda.dma32_segmap[i] = IODA_INVALID_PE;
>>  	}
>>  	phb->ioda.pe_array = aux + pemap_off;
>>  	set_bit(phb->ioda.reserved_pe_idx, phb->ioda.pe_alloc);
>> @@ -3208,10 +3224,6 @@ static void __init pnv_pci_init_ioda_phb(struct device_node *np,
>>  	INIT_LIST_HEAD(&phb->ioda.pe_list);
>>  	mutex_init(&phb->ioda.pe_list_mutex);
>>  
>> -	/* Calculate how many 32-bit TCE segments we have */
>> -	phb->ioda.tce32_count = phb->ioda.m32_pci_base /
>> -				PNV_IODA1_DMA32_SEGSIZE;
>> -
>>  #if 0 /* We should really do that ... */
>>  	rc = opal_pci_set_phb_mem_window(opal->phb_id,
>>  					 window_type,
>> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>> index 2038ef2..0802fcd 100644
>> --- a/arch/powerpc/platforms/powernv/pci.h
>> +++ b/arch/powerpc/platforms/powernv/pci.h
>> @@ -148,6 +148,10 @@ struct pnv_phb {
>>  			int			*m32_segmap;
>>  			int			*io_segmap;
>>  
>> +			/* DMA32 segment maps - IODA1 only */
>> +			unsigned long		dma32_count;
>> +			int			*dma32_segmap;
>> +
>>  			/* IRQ chip */
>>  			int			irq_chip_init;
>>  			struct irq_chip		irq_chip;
>> @@ -164,9 +168,6 @@ struct pnv_phb {
>>  			 */
>>  			unsigned char		pe_rmap[0x10000];
>>  
>> -			/* 32-bit TCE tables allocation */
>> -			unsigned long		tce32_count;
>> -
>>  			/* TCE cache invalidate registers (physical and
>>  			 * remapped)
>>  			 */

Thanks,
Gavin
