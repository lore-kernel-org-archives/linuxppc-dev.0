Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f177.google.com (mail-pd0-f177.google.com
 [209.85.192.177])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A8D0F1A0201
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 19:00:39 +1000 (AEST)
Received: by pdbnk13 with SMTP id nk13so22538727pdb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 02:00:37 -0700 (PDT)
Message-ID: <55409DAE.2000400@ozlabs.ru>
Date: Wed, 29 Apr 2015 19:00:30 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v9 16/32] powerpc/powernv/ioda: Move TCE kill
 register address to PE
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-17-git-send-email-aik@ozlabs.ru>
 <20150429032517.GM32589@voom.redhat.com>
In-Reply-To: <20150429032517.GM32589@voom.redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: Gavin Shan <gwshan@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 04/29/2015 01:25 PM, David Gibson wrote:
> On Sat, Apr 25, 2015 at 10:14:40PM +1000, Alexey Kardashevskiy wrote:
>> At the moment the DMA setup code looks for the "ibm,opal-tce-kill" property
>> which contains the TCE kill register address. Writes to this register
>> invalidates TCE cache on IODA/IODA2 hub.
>>
>> This moves the register address from iommu_table to pnv_ioda_pe as
>> later there will be 2 tables per PE and it will be used for both tables.
>>
>> This moves the property reading/remapping code to a helper to reduce
>> code duplication.
>>
>> This adds a new pnv_pci_ioda2_tvt_invalidate() helper which invalidates
>> the entire table. It should be called after every call to
>> opal_pci_map_pe_dma_window(). It was not required before because
>> there is just a single TCE table and 64bit DMA is handled via bypass
>> window (which has no table so no chache is used) but this is going
>> to change with Dynamic DMA windows (DDW).
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>> Changes:
>> v9:
>> * new in the series
>> ---
>>   arch/powerpc/platforms/powernv/pci-ioda.c | 69 +++++++++++++++++++------------
>>   arch/powerpc/platforms/powernv/pci.h      |  1 +
>>   2 files changed, 44 insertions(+), 26 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index f070c44..b22b3ca 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -1672,7 +1672,7 @@ static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
>>   			struct pnv_ioda_pe, table_group);
>>   	__be64 __iomem *invalidate = rm ?
>>   		(__be64 __iomem *)pe->tce_inval_reg_phys :
>> -		(__be64 __iomem *)tbl->it_index;
>> +		pe->tce_inval_reg;
>>   	unsigned long start, end, inc;
>>   	const unsigned shift = tbl->it_page_shift;
>>
>> @@ -1743,6 +1743,18 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops = {
>>   	.get = pnv_tce_get,
>>   };
>>
>> +static inline void pnv_pci_ioda2_tvt_invalidate(struct pnv_ioda_pe *pe)
>> +{
>> +	/* 01xb - invalidate TCEs that match the specified PE# */
>> +	unsigned long addr = (0x4ull << 60) | (pe->pe_number & 0xFF);
>
> This doesn't really look like an address, but rather the data you're
> writing to the register.


This thing is made of "invalidate operation" (0x4 here), "invalidate 
address" (pci address but it is zero here as we reset everything, most bits 
are here) and "invalidate PE number". So what should I call it? :)



>> +	if (!pe->tce_inval_reg)
>> +		return;
>> +
>> +        mb(); /* Ensure above stores are visible */
>> +	__raw_writeq(cpu_to_be64(addr), pe->tce_inval_reg);
>> +}
>> +
>>   static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
>>   		unsigned long index, unsigned long npages, bool rm)
>>   {
>> @@ -1751,7 +1763,7 @@ static void pnv_pci_ioda2_tce_invalidate(struct iommu_table *tbl,
>>   	unsigned long start, end, inc;
>>   	__be64 __iomem *invalidate = rm ?
>>   		(__be64 __iomem *)pe->tce_inval_reg_phys :
>> -		(__be64 __iomem *)tbl->it_index;
>> +		pe->tce_inval_reg;
>>   	const unsigned shift = tbl->it_page_shift;
>>
>>   	/* We'll invalidate DMA address in PE scope */
>> @@ -1803,13 +1815,31 @@ static struct iommu_table_ops pnv_ioda2_iommu_ops = {
>>   	.get = pnv_tce_get,
>>   };
>>
>> +static void pnv_pci_ioda_setup_opal_tce_kill(struct pnv_phb *phb,
>> +		struct pnv_ioda_pe *pe)
>> +{
>> +	const __be64 *swinvp;
>> +
>> +	/* OPAL variant of PHB3 invalidated TCEs */
>> +	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
>> +	if (!swinvp)
>> +		return;
>> +
>> +	/* We need a couple more fields -- an address and a data
>> +	 * to or.  Since the bus is only printed out on table free
>> +	 * errors, and on the first pass the data will be a relative
>> +	 * bus number, print that out instead.
>> +	 */
>
> The comment above appears to have nothing to do with the surrounding code.

I'll just remove it.


>
>> +	pe->tce_inval_reg_phys = be64_to_cpup(swinvp);
>> +	pe->tce_inval_reg = ioremap(pe->tce_inval_reg_phys, 8);
>> +}
>> +
>>   static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>>   				      struct pnv_ioda_pe *pe, unsigned int base,
>>   				      unsigned int segs)
>>   {
>>
>>   	struct page *tce_mem = NULL;
>> -	const __be64 *swinvp;
>>   	struct iommu_table *tbl;
>>   	unsigned int i;
>>   	int64_t rc;
>> @@ -1823,6 +1853,8 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>>   	if (WARN_ON(pe->tce32_seg >= 0))
>>   		return;
>>
>> +	pnv_pci_ioda_setup_opal_tce_kill(phb, pe);
>> +
>>   	/* Grab a 32-bit TCE table */
>>   	pe->tce32_seg = base;
>>   	pe_info(pe, " Setting up 32-bit TCE table at %08x..%08x\n",
>> @@ -1865,20 +1897,11 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>>   				  base << 28, IOMMU_PAGE_SHIFT_4K);
>>
>>   	/* OPAL variant of P7IOC SW invalidated TCEs */
>> -	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
>> -	if (swinvp) {
>> -		/* We need a couple more fields -- an address and a data
>> -		 * to or.  Since the bus is only printed out on table free
>> -		 * errors, and on the first pass the data will be a relative
>> -		 * bus number, print that out instead.
>> -		 */
>
> .. although I guess it didn't make any more sense in its original context.
>
>> -		pe->tce_inval_reg_phys = be64_to_cpup(swinvp);
>> -		tbl->it_index = (unsigned long)ioremap(pe->tce_inval_reg_phys,
>> -				8);
>> +	if (pe->tce_inval_reg)
>>   		tbl->it_type |= (TCE_PCI_SWINV_CREATE |
>>   				 TCE_PCI_SWINV_FREE   |
>>   				 TCE_PCI_SWINV_PAIR);
>> -	}
>> +
>>   	tbl->it_ops = &pnv_ioda1_iommu_ops;
>>   	iommu_init_table(tbl, phb->hose->node);
>>
>> @@ -1984,7 +2007,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>   {
>>   	struct page *tce_mem = NULL;
>>   	void *addr;
>> -	const __be64 *swinvp;
>>   	struct iommu_table *tbl;
>>   	unsigned int tce_table_size, end;
>>   	int64_t rc;
>> @@ -1993,6 +2015,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>   	if (WARN_ON(pe->tce32_seg >= 0))
>>   		return;
>>
>> +	pnv_pci_ioda_setup_opal_tce_kill(phb, pe);
>> +
>>   	/* The PE will reserve all possible 32-bits space */
>>   	pe->tce32_seg = 0;
>>   	end = (1 << ilog2(phb->ioda.m32_pci_base));
>> @@ -2023,6 +2047,8 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>   		goto fail;
>>   	}
>>
>> +	pnv_pci_ioda2_tvt_invalidate(pe);
>> +
>
> This looks to be a change in behavbiour - if it's replacing a previous
> invalidation, I'm not seeing where.


It is a new thing and the patch adds it. And it does not say anywhere that 
this patch does not change behavior.


>
>>   	/* Setup iommu */
>>   	pe->table_group.tables[0].it_table_group = &pe->table_group;
>>
>> @@ -2032,18 +2058,9 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>   			IOMMU_PAGE_SHIFT_4K);
>>
>>   	/* OPAL variant of PHB3 invalidated TCEs */
>> -	swinvp = of_get_property(phb->hose->dn, "ibm,opal-tce-kill", NULL);
>> -	if (swinvp) {
>> -		/* We need a couple more fields -- an address and a data
>> -		 * to or.  Since the bus is only printed out on table free
>> -		 * errors, and on the first pass the data will be a relative
>> -		 * bus number, print that out instead.
>> -		 */
>> -		pe->tce_inval_reg_phys = be64_to_cpup(swinvp);
>> -		tbl->it_index = (unsigned long)ioremap(pe->tce_inval_reg_phys,
>> -				8);
>> +	if (pe->tce_inval_reg)
>>   		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
>> -	}
>> +
>>   	tbl->it_ops = &pnv_ioda2_iommu_ops;
>>   	iommu_init_table(tbl, phb->hose->node);
>>   #ifdef CONFIG_IOMMU_API
>> diff --git a/arch/powerpc/platforms/powernv/pci.h b/arch/powerpc/platforms/powernv/pci.h
>> index 368d4ed..bd83d85 100644
>> --- a/arch/powerpc/platforms/powernv/pci.h
>> +++ b/arch/powerpc/platforms/powernv/pci.h
>> @@ -59,6 +59,7 @@ struct pnv_ioda_pe {
>>   	int			tce32_segcount;
>>   	struct iommu_table_group table_group;
>>   	phys_addr_t		tce_inval_reg_phys;
>> +	__be64 __iomem		*tce_inval_reg;
>>
>>   	/* 64-bit TCE bypass region */
>>   	bool			tce_bypass_enabled;
>


-- 
Alexey
