Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f178.google.com (mail-pd0-f178.google.com
 [209.85.192.178])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 0807A1A01E4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 19:26:37 +1000 (AEST)
Received: by pdbnk13 with SMTP id nk13so23117586pdb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 02:26:35 -0700 (PDT)
Message-ID: <5540A3C4.2040908@ozlabs.ru>
Date: Wed, 29 Apr 2015 19:26:28 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v9 21/32] powerpc/powernv/ioda2: Introduce
 pnv_pci_ioda2_set_window
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-22-git-send-email-aik@ozlabs.ru>
 <20150429044510.GR32589@voom.redhat.com>
In-Reply-To: <20150429044510.GR32589@voom.redhat.com>
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

On 04/29/2015 02:45 PM, David Gibson wrote:
> On Sat, Apr 25, 2015 at 10:14:45PM +1000, Alexey Kardashevskiy wrote:
>> This is a part of moving DMA window programming to an iommu_ops
>> callback. pnv_pci_ioda2_set_window() takes an iommu_table_group as
>> a first parameter (not pnv_ioda_pe) as it is going to be used as
>> a callback for VFIO DDW code.
>>
>> This adds pnv_pci_ioda2_tvt_invalidate() to invalidate TVT as it is
>> a good thing to do.
>
> What's the TVT and why is invalidating it a good thing?


"TCE Validation Table". Yeah, I need to rephrase it. Will do.


> Also, it looks like it didn't add it, just move it.

Agrh. Lost it in rebases. Will fix.


>> It does not have immediate effect now as the table
>> is never recreated after reboot but it will in the following patches.
>>
>> This should cause no behavioural change.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>
> Really?  I don't remember this one.


Message-ID: <20150416064351.GK3632@voom.redhat.com>
:)

But I believe it did not have TVT stuff then so I should have removed your 
RB from here.

>
>> ---
>> Changes:
>> v9:
>> * initialize pe->table_group.tables[0] at the very end when
>> tbl is fully initialized
>> * moved pnv_pci_ioda2_tvt_invalidate() from earlier patch
>> ---
>>   arch/powerpc/platforms/powernv/pci-ioda.c | 67 +++++++++++++++++++++++--------
>>   1 file changed, 51 insertions(+), 16 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index b9b3773..59baa15 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -1960,6 +1960,52 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>>   		__free_pages(tce_mem, get_order(TCE32_TABLE_SIZE * segs));
>>   }
>>
>> +static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
>> +		struct iommu_table *tbl)
>> +{
>> +	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
>> +			table_group);
>> +	struct pnv_phb *phb = pe->phb;
>> +	int64_t rc;
>> +	const __u64 start_addr = tbl->it_offset << tbl->it_page_shift;
>> +	const __u64 win_size = tbl->it_size << tbl->it_page_shift;
>> +
>> +	pe_info(pe, "Setting up window at %llx..%llx "
>> +			"pgsize=0x%x tablesize=0x%lx\n",
>> +			start_addr, start_addr + win_size - 1,
>> +			1UL << tbl->it_page_shift, tbl->it_size << 3);
>> +
>> +	tbl->it_table_group = &pe->table_group;
>> +
>> +	/*
>> +	 * Map TCE table through TVT. The TVE index is the PE number
>> +	 * shifted by 1 bit for 32-bits DMA space.
>> +	 */
>> +	rc = opal_pci_map_pe_dma_window(phb->opal_id,
>> +			pe->pe_number,
>> +			pe->pe_number << 1,
>> +			1,
>> +			__pa(tbl->it_base),
>> +			tbl->it_size << 3,
>> +			1ULL << tbl->it_page_shift);
>> +	if (rc) {
>> +		pe_err(pe, "Failed to configure TCE table, err %ld\n", rc);
>> +		goto fail;
>> +	}
>> +
>> +	pnv_pci_ioda2_tvt_invalidate(pe);
>> +
>> +	/* Store fully initialized *tbl (may be external) in PE */
>> +	pe->table_group.tables[0] = *tbl;
>
> Hrm, a non-atomic copy of a whole structure into the array.  Is that
> really what you want?


set_window is called from VFIO (protected by mutex there) and the platform 
code which I believe is not racy (or hotplug takes care of it anyway). Or I 
am missing something else?


>> +	return 0;
>> +fail:
>> +	if (pe->tce32_seg >= 0)
>> +		pe->tce32_seg = -1;
>> +
>> +	return rc;
>> +}
>> +
>>   static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
>>   {
>>   	uint16_t window_id = (pe->pe_number << 1 ) + 1;
>> @@ -2068,21 +2114,16 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>   	pe->table_group.ops = &pnv_pci_ioda2_ops;
>>   #endif
>>
>> -	/*
>> -	 * Map TCE table through TVT. The TVE index is the PE number
>> -	 * shifted by 1 bit for 32-bits DMA space.
>> -	 */
>> -	rc = opal_pci_map_pe_dma_window(phb->opal_id, pe->pe_number,
>> -			pe->pe_number << 1, 1, __pa(tbl->it_base),
>> -			tbl->it_size << 3, 1ULL << tbl->it_page_shift);
>> +	rc = pnv_pci_ioda2_set_window(&pe->table_group, tbl);
>>   	if (rc) {
>>   		pe_err(pe, "Failed to configure 32-bit TCE table,"
>>   		       " err %ld\n", rc);
>> -		goto fail;
>> +		pnv_pci_free_table(tbl);
>> +		if (pe->tce32_seg >= 0)
>> +			pe->tce32_seg = -1;
>> +		return;
>>   	}
>>
>> -	pnv_pci_ioda2_tvt_invalidate(pe);
>> -
>>   	/* OPAL variant of PHB3 invalidated TCEs */
>>   	if (pe->tce_inval_reg)
>>   		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
>> @@ -2103,12 +2144,6 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
>>   	/* Also create a bypass window */
>>   	if (!pnv_iommu_bypass_disabled)
>>   		pnv_pci_ioda2_setup_bypass_pe(phb, pe);
>> -
>> -	return;
>> -fail:
>> -	if (pe->tce32_seg >= 0)
>> -		pe->tce32_seg = -1;
>> -	pnv_pci_free_table(tbl);
>>   }
>>
>>   static void pnv_ioda_setup_dma(struct pnv_phb *phb)
>


-- 
Alexey
