Return-Path: <dougmill@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B29191A0191
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 01:28:25 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <dougmill@linux.vnet.ibm.com>;
 Tue, 9 Feb 2016 07:28:23 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 1C2B6C40008
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  9 Feb 2016 07:16:31 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u19ESL6123396466
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 07:28:21 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u19ESK0r013145
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 9 Feb 2016 07:28:21 -0700
Subject: Re: [RFC PATCH kernel] powerpc/ioda: Set "read" permission when
 "write" is set
To: Alexey Kardashevskiy <aik@ozlabs.ru>, linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1452573620-17979-1-git-send-email-aik@ozlabs.ru>
 <1452640054.3262.11.camel@kernel.crashing.org>
 <5695B542.5010001@linux.vnet.ibm.com> <569DB2F3.1070901@ozlabs.ru>
 <569E87F8.1030907@linux.vnet.ibm.com> <56B942CF.9020906@ozlabs.ru>
From: Douglas Miller <dougmill@linux.vnet.ibm.com>
Message-ID: <56B9F783.6070002@linux.vnet.ibm.com>
Date: Tue, 9 Feb 2016 08:28:19 -0600
MIME-Version: 1.0
In-Reply-To: <56B942CF.9020906@ozlabs.ru>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We finally got the chance to test it end of last week. I forgot to 
update everyone Monday. B all appearances, the patch fixes the problem. 
We did not see any new issues with the patch (vs. same test scenarios 
without).

I'll also update the bugzilla.

Thanks,
Doug

On 02/08/2016 07:37 PM, Alexey Kardashevskiy wrote:
> On 01/20/2016 06:01 AM, Douglas Miller wrote:
>>
>>
>> On 01/18/2016 09:52 PM, Alexey Kardashevskiy wrote:
>>> On 01/13/2016 01:24 PM, Douglas Miller wrote:
>>>>
>>>>
>>>> On 01/12/2016 05:07 PM, Benjamin Herrenschmidt wrote:
>>>>> On Tue, 2016-01-12 at 15:40 +1100, Alexey Kardashevskiy wrote:
>>>>>> Quite often drivers set only "write" permission assuming that this
>>>>>> includes "read" permission as well and this works on plenty
>>>>>> platforms.
>>>>>> However IODA2 is strict about this and produces an EEH when "read"
>>>>>> permission is not and reading happens.
>>>>>>
>>>>>> This adds a workaround in IODA code to always add the "read" bit 
>>>>>> when
>>>>>> the "write" bit is set.
>>>>>>
>>>>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>>> ---
>>>>>>
>>>>>>
>>>>>> Ben, what was the driver which did not set "read" and caused EEH?
>>>>> aacraid
>>>>>
>>>>> Cheers,
>>>>> Ben.
>>>> Just to be precise, the driver wasn't responsible for setting READ. 
>>>> The
>>>> driver called scsi_dma_map() and the scsicmd was set (by scsi 
>>>> layer) as
>>>> DMA_FROM_DEVICE so the current code would set the permissions to
>>>> WRITE-ONLY. Previously, and in other architectures, this scsicmd 
>>>> would have
>>>> resulted in READ+WRITE permissions on the DMA map.
>>>
>>>
>>> Does the patch fix the issue? Thanks.
>>>
>>>
>>>
>>>>>
>>>>>> ---
>>>>>>   arch/powerpc/platforms/powernv/pci.c | 6 ++++++
>>>>>>   1 file changed, 6 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/powerpc/platforms/powernv/pci.c
>>>>>> b/arch/powerpc/platforms/powernv/pci.c
>>>>>> index f2dd772..c7dcae5 100644
>>>>>> --- a/arch/powerpc/platforms/powernv/pci.c
>>>>>> +++ b/arch/powerpc/platforms/powernv/pci.c
>>>>>> @@ -601,6 +601,9 @@ int pnv_tce_build(struct iommu_table *tbl, long
>>>>>> index, long npages,
>>>>>>       u64 rpn = __pa(uaddr) >> tbl->it_page_shift;
>>>>>>       long i;
>>>>>> +    if (proto_tce & TCE_PCI_WRITE)
>>>>>> +        proto_tce |= TCE_PCI_READ;
>>>>>> +
>>>>>>       for (i = 0; i < npages; i++) {
>>>>>>           unsigned long newtce = proto_tce |
>>>>>>               ((rpn + i) << tbl->it_page_shift);
>>>>>> @@ -622,6 +625,9 @@ int pnv_tce_xchg(struct iommu_table *tbl, long
>>>>>> index,
>>>>>>       BUG_ON(*hpa & ~IOMMU_PAGE_MASK(tbl));
>>>>>> +    if (newtce & TCE_PCI_WRITE)
>>>>>> +        newtce |= TCE_PCI_READ;
>>>>>> +
>>>>>>       oldtce = xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce));
>>>>>>       *hpa = be64_to_cpu(oldtce) & ~(TCE_PCI_READ |
>>>>>> TCE_PCI_WRITE);
>>>>>>       *direction = iommu_tce_direction(oldtce);
>>>>> _______________________________________________
>>>>> Linuxppc-dev mailing list
>>>>> Linuxppc-dev@lists.ozlabs.org
>>>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>>>
>>>> _______________________________________________
>>>> Linuxppc-dev mailing list
>>>> Linuxppc-dev@lists.ozlabs.org
>>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>>
>>>
>> I am still working on getting a machine to try this on. From code
>> inspection, it looks like it should work. The problem is shortage of
>> machines and machines tied-up by Test.
>
> Any progress here? Thanks.
>
>
>
>
