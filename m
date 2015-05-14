Return-Path: <aik@ozlabs.ru>
Received: from mail-pd0-f172.google.com (mail-pd0-f172.google.com
 [209.85.192.172])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C87281A03B4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 14 May 2015 13:39:49 +1000 (AEST)
Received: by pdbnk13 with SMTP id nk13so71420291pdb.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 May 2015 20:39:48 -0700 (PDT)
Message-ID: <555418FC.1070906@ozlabs.ru>
Date: Thu, 14 May 2015 13:39:40 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH kernel v10 20/34] powerpc/powernv/ioda2: Move TCE kill
 register address to PE
References: <1431358763-24371-1-git-send-email-aik@ozlabs.ru>
 <1431358763-24371-21-git-send-email-aik@ozlabs.ru>
 <20150514021047.GA31156@gwshan>
In-Reply-To: <20150514021047.GA31156@gwshan>
Content-Type: text/plain; charset=koi8-r; format=flowed
Cc: Wei Yang <weiyang@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Alex Williamson <alex.williamson@redhat.com>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 David Gibson <david@gibson.dropbear.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/14/2015 12:10 PM, Gavin Shan wrote:
> On Tue, May 12, 2015 at 01:39:09AM +1000, Alexey Kardashevskiy wrote:
>> At the moment the DMA setup code looks for the "ibm,opal-tce-kill" property
>> which contains the TCE kill register address. Writes to this register
>> invalidates TCE cache on IODA/IODA2 hub.
>>
>> This moves the register address from iommu_table to pnv_ioda_pe as:
>> 1) When we get 2 tables per PE, this register will be used for both tables;
>> 2) When we get TCE tables sharing, we will need to invalidate every
>> IOMMU group (i.e. PE) which is using this table and each PE has
>> its own invalidate register.
>>
>
> Actually, it's the virtual address of IO remapped PHB hardware register.
> So it would be a property of PHB (struct pnv_phb). As the PE is connecting
> with IOMMU table group. The virtual address can be retrieved by the path:
> iommu_table -> iommu_table_group -> pnv_ioda_pe -> pnv_phb. However, I
> don't insist and you have the best judge on it :-)

Are you suggesting moving pe->tce_inval_reg from pnv_ioda_pe to pnv_phb?

>
>> This moves the property reading/remapping code to a helper to reduce
>> code duplication. Although this change is not required for IODA1, this
>> changes it as well to reduce code duplication.
>>
>> This adds a new pnv_pci_ioda2_tvt_invalidate() helper which invalidates
>> the entire table. It should be called after every call to
>> opal_pci_map_pe_dma_window(). It was not required before because
>> there is just a single TCE table and 64bit DMA is handled via bypass
>> window (which has no table so no chache is used) but this is going
>> to change with Dynamic DMA windows (DDW).
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
>
> Thanks,
> Gavin
>
>> ---
>> Changes:
>> v10:
>> * fixed error from checkpatch.pl
>> * removed comment at "ibm,opal-tce-kill" parsing as irrelevant
>> * s/addr/val/ in pnv_pci_ioda2_tvt_invalidate() as it was not a kernel address
>>
>> v9:
>> * new in the series
>> ---
>> arch/powerpc/platforms/powernv/pci-ioda.c | 64 ++++++++++++++++++-------------
>> arch/powerpc/platforms/powernv/pci.h      |  1 +
>> 2 files changed, 39 insertions(+), 26 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci-ioda.c b/arch/powerpc/platforms/powernv/pci-ioda.c
>> index 35ab19c8..f972e40 100644
>> --- a/arch/powerpc/platforms/powernv/pci-ioda.c
>> +++ b/arch/powerpc/platforms/powernv/pci-ioda.c
>> @@ -1680,7 +1680,7 @@ static void pnv_pci_ioda1_tce_invalidate(struct iommu_table *tbl,
>> 			struct pnv_ioda_pe, table_group);
>> 	__be64 __iomem *invalidate = rm ?
>> 		(__be64 __iomem *)pe->tce_inval_reg_phys :
>> -		(__be64 __iomem *)tbl->it_index;
>> +		pe->tce_inval_reg;
>> 	unsigned long start, end, inc;
>> 	const unsigned shift = tbl->it_page_shift;
>>
>> @@ -1751,6 +1751,18 @@ static struct iommu_table_ops pnv_ioda1_iommu_ops = {
>> 	.get = pnv_tce_get,
>> };
>>
>> +static inline void pnv_pci_ioda2_tvt_invalidate(struct pnv_ioda_pe *pe)
>> +{
>> +	/* 01xb - invalidate TCEs that match the specified PE# */
>> +	unsigned long val = (0x4ull << 60) | (pe->pe_number & 0xFF);
>> +
>> +	if (!pe->tce_inval_reg)
>> +		return;
>> +
>> +	mb(); /* Ensure above stores are visible */
>> +	__raw_writeq(cpu_to_be64(val), pe->tce_inval_reg);
>> +}
>> +
>
> The function name sounds it's to invalidate TVE cache. Actually, it's invalidting
> TCE cache. So I guess the function name pnv_pci_ioda2_tce_invalidate() would be
> more accurate.

TVT vs. TVE distinction is not clear for me, sorry :)

There is a function with exactly the same name as you proposed, below in 
this mail, it invalidates cache.
May be s/pnv_pci_ioda2_tvt_invalidate/pnv_pci_ioda2_invalidate_entire_cache/ ?




-- 
Alexey
