Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f175.google.com (mail-pd0-f175.google.com
 [209.85.192.175])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 907A51A023C
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Jun 2015 21:19:00 +1000 (AEST)
Received: by pdbqa5 with SMTP id qa5so5480541pdb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 03 Jun 2015 04:18:58 -0700 (PDT)
Message-ID: <556EE29A.6040108@ozlabs.ru>
Date: Wed, 03 Jun 2015 21:18:50 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
CC: linuxppc-dev@lists.ozlabs.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Gavin Shan <gwshan@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kvm@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH kernel v11 26/34] powerpc/powernv/ioda2: Introduce
 pnv_pci_ioda2_set_window
References: <1432889098-22924-1-git-send-email-aik@ozlabs.ru>
 <1432889098-22924-27-git-send-email-aik@ozlabs.ru>
 <20150601233039.GP22789@voom.redhat.com>
In-Reply-To: <20150601233039.GP22789@voom.redhat.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 06/02/2015 09:30 AM, David Gibson wrote:
> On Fri, May 29, 2015 at 06:44:50PM +1000, Alexey Kardashevskiy wrote:
>> This is a part of moving DMA window programming to an iommu_ops
>> callback. pnv_pci_ioda2_set_window() takes an iommu_table_group as
>> a first parameter (not pnv_ioda_pe) as it is going to be used as
>> a callback for VFIO DDW code.
>>
>> This adds pnv_pci_ioda2_tvt_invalidate() to invalidate TVT as it is
>
> I'm assuming that's what's now called pnv_pci_ioda2_invalidate_entire()?


Yes, my bad... And the patch is not adding it at all...


>
>> a good thing to do. It does not have immediate effect now as the table
>> is never recreated after reboot but it will in the following patches.
>>
>> This should cause no behavioural change.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>> ---
>> Changes:
>> v11:
>> * replaced some 1<<it_page_shift with IOMMU_PAGE_SIZE() macro
>>
>> v9:
>> * initialize pe->table_group.tables[0] at the very end when
>> tbl is fully initialized
>> * moved pnv_pci_ioda2_tvt_invalidate() from earlier patch
>> ---
>>   arch/powerpc/platforms/powernv/pci-ioda.c | 47 +++++++++++++++++++++++++------
>>   1 file changed, 38 insertions(+), 9 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 3d29fe3..fda01c1 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -1968,6 +1968,43 @@ static void pnv_pci_ioda_setup_dma_pe(struct pnv_phb *phb,
>>   	}
>>   }
>>
>> +static long pnv_pci_ioda2_set_window(struct iommu_table_group *table_group,
>> +		int num, struct iommu_table *tbl)
>> +{
>> +	struct pnv_ioda_pe *pe = container_of(table_group, struct pnv_ioda_pe,
>> +			table_group);
>> +	struct pnv_phb *phb = pe->phb;
>> +	int64_t rc;
>> +	const __u64 start_addr = tbl->it_offset << tbl->it_page_shift;
>> +	const __u64 win_size = tbl->it_size << tbl->it_page_shift;
>> +
>> +	pe_info(pe, "Setting up window %llx..%llx pg=%x\n",
>> +			start_addr, start_addr + win_size - 1,
>> +			IOMMU_PAGE_SIZE(tbl));
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
>> +			IOMMU_PAGE_SIZE(tbl));
>> +	if (rc) {
>> +		pe_err(pe, "Failed to configure TCE table, err %ld\n", rc);
>> +		return rc;
>> +	}
>> +
>> +	pnv_pci_link_table_and_group(phb->hose->node, num,
>> +			tbl, &pe->table_group);
>> +	pnv_pci_ioda2_tce_invalidate_entire(pe);
>> +
>> +	return 0;
>> +}
>> +
>>   static void pnv_pci_ioda2_set_bypass(struct pnv_ioda_pe *pe, bool enable)
>>   {
>>   	uint16_t window_id = (pe->pe_number << 1 ) + 1;
>> @@ -2123,21 +2160,13 @@ static void pnv_pci_ioda2_setup_dma_pe(struct pnv_phb *phb,
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
>> +	rc = pnv_pci_ioda2_set_window(&pe->table_group, 0, tbl);
>>   	if (rc) {
>>   		pe_err(pe, "Failed to configure 32-bit TCE table,"
>>   		       " err %ld\n", rc);
>>   		goto fail;
>>   	}
>>
>> -	pnv_pci_ioda2_tce_invalidate_entire(pe);
>> -
>>   	/* OPAL variant of PHB3 invalidated TCEs */
>>   	if (phb->ioda.tce_inval_reg)
>>   		tbl->it_type |= (TCE_PCI_SWINV_CREATE | TCE_PCI_SWINV_FREE);
>


-- 
Alexey
