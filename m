Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-f50.google.com (mail-pa0-f50.google.com
 [209.85.220.50])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4F7AA1A0042
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 23 Jul 2014 14:04:27 +1000 (EST)
Received: by mail-pa0-f50.google.com with SMTP id et14so881407pad.9
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Jul 2014 21:04:25 -0700 (PDT)
Message-ID: <53CF3440.6070504@ozlabs.ru>
Date: Wed, 23 Jul 2014 14:04:16 +1000
From: Alexey Kardashevskiy <aik@ozlabs.ru>
MIME-Version: 1.0
To: Gavin Shan <gwshan@linux.vnet.ibm.com>
Subject: Re: [PATCH v2 06/18] powerpc/powernv: Use it_page_shift in TCE build
References: <1406084764-24685-1-git-send-email-aik@ozlabs.ru>
 <1406084764-24685-7-git-send-email-aik@ozlabs.ru>
 <20140723040040.GB5531@shangw>
In-Reply-To: <20140723040040.GB5531@shangw>
Content-Type: text/plain; charset=KOI8-R
Cc: linuxppc-dev@lists.ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/23/2014 02:00 PM, Gavin Shan wrote:
> On Wed, Jul 23, 2014 at 01:05:52PM +1000, Alexey Kardashevskiy wrote:
>> This makes use of iommu_table::it_page_shift instead of TCE_SHIFT and
>> TCE_RPN_SHIFT hardcoded values.
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Reviewed-by: Gavin Shan <gwshan@linux.vnet.ibm.com>
> 
>> ---
>> arch/powerpc/platforms/powernv/pci.c | 5 +++--
>> 1 file changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci.c b/arch/powerpc/platforms/powernv/pci.c
>> index f91a4e5..b6cb996 100644
>> --- a/arch/powerpc/platforms/powernv/pci.c
>> +++ b/arch/powerpc/platforms/powernv/pci.c
>> @@ -564,10 +564,11 @@ static int pnv_tce_build(struct iommu_table *tbl, long index, long npages,
>> 		proto_tce |= TCE_PCI_WRITE;
>>
>> 	tces = tcep = ((__be64 *)tbl->it_base) + index - tbl->it_offset;
>> -	rpn = __pa(uaddr) >> TCE_SHIFT;
>> +	rpn = __pa(uaddr) >> tbl->it_page_shift;
>>
> 
> I'm not sure for 100%. It might be worthy to have some check somewhere:
> 
> 	WARN_ON(uaddr & ((1ull << tbl->it_page_shift) - 1))


The calling code (KVM and SPAPR TCE VFIO driver) performs all these checks,
no need to repeat it here.


> The "uaddr" are required to be "0x1ull << tbl->it_page_shift" aligned :-)
> 
> Thanks,
> Gavin
> 
>> 	while (npages--)
>> -		*(tcep++) = cpu_to_be64(proto_tce | (rpn++ << TCE_RPN_SHIFT));
>> +		*(tcep++) = cpu_to_be64(proto_tce |
>> +				(rpn++ << tbl->it_page_shift));
>>
>> 	/* Some implementations won't cache invalid TCEs and thus may not
>> 	 * need that flush. We'll probably turn it_type into a bit mask
>> -- 
>> 2.0.0
>>
> 


-- 
Alexey
