Return-Path: <dougmill@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C26961A06C1
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jan 2016 13:24:08 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dougmill@linux.vnet.ibm.com>;
 Tue, 12 Jan 2016 19:24:06 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 76F591FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 19:12:14 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0D2O4kf25493642
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 19:24:04 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0D2O3Xl030964
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 19:24:03 -0700
Received: from oc5780617838.ibm.com ([9.80.96.161])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVin) with ESMTP id
 u0D2O34A030914
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 19:24:03 -0700
Subject: Re: [RFC PATCH kernel] powerpc/ioda: Set "read" permission when
 "write" is set
To: linuxppc-dev@lists.ozlabs.org
References: <1452573620-17979-1-git-send-email-aik@ozlabs.ru>
 <1452640054.3262.11.camel@kernel.crashing.org>
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Message-ID: <5695B542.5010001@linux.vnet.ibm.com>
Date: Tue, 12 Jan 2016 20:24:02 -0600
MIME-Version: 1.0
In-Reply-To: <1452640054.3262.11.camel@kernel.crashing.org>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 01/12/2016 05:07 PM, Benjamin Herrenschmidt wrote:
> On Tue, 2016-01-12 at 15:40 +1100, Alexey Kardashevskiy wrote:
>> Quite often drivers set only "write" permission assuming that this
>> includes "read" permission as well and this works on plenty
>> platforms.
>> However IODA2 is strict about this and produces an EEH when "read"
>> permission is not and reading happens.
>>
>> This adds a workaround in IODA code to always add the "read" bit when
>> the "write" bit is set.
>>
>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>> ---
>>
>>
>> Ben, what was the driver which did not set "read" and caused EEH?
> aacraid
>
> Cheers,
> Ben.
Just to be precise, the driver wasn't responsible for setting READ. The 
driver called scsi_dma_map() and the scsicmd was set (by scsi layer) as 
DMA_FROM_DEVICE so the current code would set the permissions to 
WRITE-ONLY. Previously, and in other architectures, this scsicmd would 
have resulted in READ+WRITE permissions on the DMA map.
>
>> ---
>>   arch/powerpc/platforms/powernv/pci.c | 6 ++++++
>>   1 file changed, 6 insertions(+)
>>
>> diff --git a/arch/powerpc/platforms/powernv/pci.c
>> b/arch/powerpc/platforms/powernv/pci.c
>> index f2dd772..c7dcae5 100644
>> --- a/arch/powerpc/platforms/powernv/pci.c
>> +++ b/arch/powerpc/platforms/powernv/pci.c
>> @@ -601,6 +601,9 @@ int pnv_tce_build(struct iommu_table *tbl, long
>> index, long npages,
>>   	u64 rpn = __pa(uaddr) >> tbl->it_page_shift;
>>   	long i;
>>   
>> +	if (proto_tce & TCE_PCI_WRITE)
>> +		proto_tce |= TCE_PCI_READ;
>> +
>>   	for (i = 0; i < npages; i++) {
>>   		unsigned long newtce = proto_tce |
>>   			((rpn + i) << tbl->it_page_shift);
>> @@ -622,6 +625,9 @@ int pnv_tce_xchg(struct iommu_table *tbl, long
>> index,
>>   
>>   	BUG_ON(*hpa & ~IOMMU_PAGE_MASK(tbl));
>>   
>> +	if (newtce & TCE_PCI_WRITE)
>> +		newtce |= TCE_PCI_READ;
>> +
>>   	oldtce = xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce));
>>   	*hpa = be64_to_cpu(oldtce) & ~(TCE_PCI_READ |
>> TCE_PCI_WRITE);
>>   	*direction = iommu_tce_direction(oldtce);
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
