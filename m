Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f42.google.com (mail-pa0-f42.google.com
 [209.85.220.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 63A011A0201
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 19:02:26 +1000 (AEST)
Received: by pacwv17 with SMTP id wv17so22320691pac.0
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Apr 2015 02:02:24 -0700 (PDT)
Message-ID: <55409E19.3090204@ozlabs.ru>
Date: Wed, 29 Apr 2015 19:02:17 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [PATCH kernel v9 17/32] powerpc/powernv: Implement accessor to
 TCE entry
References: <1429964096-11524-1-git-send-email-aik@ozlabs.ru>
 <1429964096-11524-18-git-send-email-aik@ozlabs.ru>
 <20150429040436.GN32589@voom.redhat.com>
In-Reply-To: <20150429040436.GN32589@voom.redhat.com>
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

On 04/29/2015 02:04 PM, David Gibson wrote:
> On Sat, Apr 25, 2015 at 10:14:41PM +1000, Alexey Kardashevskiy wrote:
>> This replaces direct accesses to TCE table with a helper which
>> returns an TCE entry address. This does not make difference now but will
>> when multi-level TCE tables get introduces.
>>
>> No change in behavior is expected.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>
> Reviewed-by: David Gibson <david@gibson.dropbear.id.au>
>
>
>> ---
>> Changes:
>> v9:
>> * new patch in the series to separate this mechanical change from
>> functional changes; this is not right before
>> "powerpc/powernv: Implement multilevel TCE tables" but here in order
>> to let the next patch - "powerpc/iommu/powernv: Release replaced TCE" -
>> use pnv_tce() and avoid changing the same code twice
>> ---
>>   arch/powerpc/platforms/powernv/pci.c | 34 +++++++++++++++++++++-------------
>>   1 file changed, 21 insertions(+), 13 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>> index 84b4ea4..ba75aa5 100644
>> --- a/arch/powerpc/platforms/powernv/pci.c
>> +++ b/arch/powerpc/platforms/powernv/pci.c
>> @@ -572,38 +572,46 @@ struct pci_ops pnv_pci_ops = {
>>   	.write = pnv_pci_write_config,
>>   };
>>
>> +static __be64 *pnv_tce(struct iommu_table *tbl, long idx)
>> +{
>> +	__be64 *tmp = ((__be64 *)tbl->it_base);
>> +
>> +	return tmp + idx;
>> +}
>> +
>>   int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
>>   		unsigned long uaddr, enum dma_data_direction direction,
>>   		struct dma_attrs *attrs)
>>   {
>>   	u64 proto_tce = iommu_direction_to_tce_perm(direction);
>> -	__be64 *tcep;
>> -	u64 rpn;
>> +	u64 rpn = __pa(uaddr) >> tbl->it_page_shift;
>
> I guess this was a problem in the existing code, not this patch.  But
> "uaddr" is a really bad name (and unsigned long is a bad type) for
> what must actually be a kernel linear mapping address.


Yes and may be one day I'll clean this up. s/uaddr/linear/ and 
s/hwaddr/hpa/ are the first things to do globally but not in this patchset.


>
>> +	long i;
>>
>> -	tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
>> -	rpn = __pa(uaddr) >> tbl->it_page_shift;
>> -
>> -	while (npages--)
>> -		*(tcep++) = cpu_to_be64(proto_tce |
>> -				(rpn++ << tbl->it_page_shift));
>> +	for (i = 0; i < npages; i++) {
>> +		unsigned long newtce = proto_tce |
>> +			((rpn + i) << tbl->it_page_shift);
>> +		unsigned long idx = index - tbl->it_offset + i;
>>
>> +		*(pnv_tce(tbl, idx)) = cpu_to_be64(newtce);
>> +	}
>>
>>   	return 0;
>>   }
>>
>>   void pnv_tce_free(struct iommu_table *tbl, long index, long npages)
>>   {
>> -	__be64 *tcep;
>> +	long i;
>>
>> -	tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
>> +	for (i = 0; i < npages; i++) {
>> +		unsigned long idx = index - tbl->it_offset + i;
>>
>> -	while (npages--)
>> -		*(tcep++) = cpu_to_be64(0);
>> +		*(pnv_tce(tbl, idx)) = cpu_to_be64(0);
>> +	}
>>   }
>>
>>   unsigned long pnv_tce_get(struct iommu_table *tbl, long index)
>>   {
>> -	return ((u64 *)tbl->it_base)[index - tbl->it_offset];
>> +	return *(pnv_tce(tbl, index - tbl->it_offset));
>>   }
>>
>>   void pnv_pci_setup_iommu_table(struct iommu_table *tbl,
>


-- 
Alexey
