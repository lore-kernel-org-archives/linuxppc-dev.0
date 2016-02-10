Return-Path: <aik@ozlabs.ru>
Received: from mail-pa0-x22c.google.com (mail-pa0-x22c.google.com
 [IPv6:2607:f8b0:400e:c03::22c])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EAD181A039D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 10 Feb 2016 11:32:41 +1100 (AEDT)
Received: by mail-pa0-x22c.google.com with SMTP id kp3so2368783pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 09 Feb 2016 16:32:41 -0800 (PST)
Subject: Re: [RFC PATCH kernel] powerpc/ioda: Set "read" permission when
 "write" is set
To: Douglas Miller <dougmill@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1452573620-17979-1-git-send-email-aik@ozlabs.ru>
 <1452640054.3262.11.camel@kernel.crashing.org>
 <5695B542.5010001@linux.vnet.ibm.com> <569DB2F3.1070901@ozlabs.ru>
 <569E87F8.1030907@linux.vnet.ibm.com> <56B942CF.9020906@ozlabs.ru>
 <56B9F783.6070002@linux.vnet.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <56BA8523.2080207@ozlabs.ru>
Date: Wed, 10 Feb 2016 11:32:35 +1100
MIME-Version: 1.0
In-Reply-To: <56B9F783.6070002@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/10/2016 01:28 AM, Douglas Miller wrote:
> We finally got the chance to test it end of last week. I forgot to update
> everyone Monday. B all appearances, the patch fixes the problem. We did not
> see any new issues with the patch (vs. same test scenarios without).
>
> I'll also update the bugzilla.

Thanks. Care to add "Tested-by"?


>
> Thanks,
> Doug
>
> On 02/08/2016 07:37 PM, Alexey Kardashevskiy wrote:
>> On 01/20/2016 06:01 AM, Douglas Miller wrote:
>>>
>>>
>>> On 01/18/2016 09:52 PM, Alexey Kardashevskiy wrote:
>>>> On 01/13/2016 01:24 PM, Douglas Miller wrote:
>>>>>
>>>>>
>>>>> On 01/12/2016 05:07 PM, Benjamin Herrenschmidt wrote:
>>>>>> On Tue, 2016-01-12 at 15:40 +1100, Alexey Kardashevskiy wrote:
>>>>>>> Quite often drivers set only "write" permission assuming that this
>>>>>>> includes "read" permission as well and this works on plenty
>>>>>>> platforms.
>>>>>>> However IODA2 is strict about this and produces an EEH when "read"
>>>>>>> permission is not and reading happens.
>>>>>>>
>>>>>>> This adds a workaround in IODA code to always add the "read" bit when
>>>>>>> the "write" bit is set.
>>>>>>>
>>>>>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>>>>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>>>>>> ---
>>>>>>>
>>>>>>>
>>>>>>> Ben, what was the driver which did not set "read" and caused EEH?
>>>>>> aacraid
>>>>>>
>>>>>> Cheers,
>>>>>> Ben.
>>>>> Just to be precise, the driver wasn't responsible for setting READ. The
>>>>> driver called scsi_dma_map() and the scsicmd was set (by scsi layer) as
>>>>> DMA_FROM_DEVICE so the current code would set the permissions to
>>>>> WRITE-ONLY. Previously, and in other architectures, this scsicmd would
>>>>> have
>>>>> resulted in READ+WRITE permissions on the DMA map.
>>>>
>>>>
>>>> Does the patch fix the issue? Thanks.
>>>>
>>>>
>>>>
>>>>>>
>>>>>>> ---
>>>>>>>   arch/powerpc/platforms/powernv/pci.c | 6 ++++++
>>>>>>>   1 file changed, 6 insertions(+)
>>>>>>>
>>>>>>> diff --git a/arch/powerpc/platforms/powernv/pci.c
>>>>>>> b/arch/powerpc/platforms/powernv/pci.c
>>>>>>> index f2dd772..c7dcae5 100644
>>>>>>> --- a/arch/powerpc/platforms/powernv/pci.c
>>>>>>> +++ b/arch/powerpc/platforms/powernv/pci.c
>>>>>>> @@ -601,6 +601,9 @@ int pnv_tce_build(struct iommu_table *tbl, long
>>>>>>> index, long npages,
>>>>>>>       u64 rpn = __pa(uaddr) >> tbl->it_page_shift;
>>>>>>>       long i;
>>>>>>> +    if (proto_tce & TCE_PCI_WRITE)
>>>>>>> +        proto_tce |= TCE_PCI_READ;
>>>>>>> +
>>>>>>>       for (i = 0; i < npages; i++) {
>>>>>>>           unsigned long newtce = proto_tce |
>>>>>>>               ((rpn + i) << tbl->it_page_shift);
>>>>>>> @@ -622,6 +625,9 @@ int pnv_tce_xchg(struct iommu_table *tbl, long
>>>>>>> index,
>>>>>>>       BUG_ON(*hpa & ~IOMMU_PAGE_MASK(tbl));
>>>>>>> +    if (newtce & TCE_PCI_WRITE)
>>>>>>> +        newtce |= TCE_PCI_READ;
>>>>>>> +
>>>>>>>       oldtce = xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce));
>>>>>>>       *hpa = be64_to_cpu(oldtce) & ~(TCE_PCI_READ |
>>>>>>> TCE_PCI_WRITE);
>>>>>>>       *direction = iommu_tce_direction(oldtce);
>>>>>> _______________________________________________
>>>>>> Linuxppc-dev mailing list
>>>>>> Linuxppc-dev@lists.ozlabs.org
>>>>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>>>>
>>>>> _______________________________________________
>>>>> Linuxppc-dev mailing list
>>>>> Linuxppc-dev@lists.ozlabs.org
>>>>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>>>>
>>>>
>>> I am still working on getting a machine to try this on. From code
>>> inspection, it looks like it should work. The problem is shortage of
>>> machines and machines tied-up by Test.
>>
>> Any progress here? Thanks.
>>
>>
>>
>>
>


-- 
Alexey
