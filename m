Return-Path: <aik@ozlabs.ru>
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 346921A0037
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jan 2016 14:52:25 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id 65so12545348pfd.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jan 2016 19:52:25 -0800 (PST)
Subject: Re: [RFC PATCH kernel] powerpc/ioda: Set "read" permission when
 "write" is set
To: Douglas Miller <dougmill@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
References: <1452573620-17979-1-git-send-email-aik@ozlabs.ru>
 <1452640054.3262.11.camel@kernel.crashing.org>
 <5695B542.5010001@linux.vnet.ibm.com>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <569DB2F3.1070901@ozlabs.ru>
Date: Tue, 19 Jan 2016 14:52:19 +1100
MIME-Version: 1.0
In-Reply-To: <5695B542.5010001@linux.vnet.ibm.com>
Content-Type: text/plain; charset=koi8-r; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 01/13/2016 01:24 PM, Douglas Miller wrote:
>
>
> On 01/12/2016 05:07 PM, Benjamin Herrenschmidt wrote:
>> On Tue, 2016-01-12 at 15:40 +1100, Alexey Kardashevskiy wrote:
>>> Quite often drivers set only "write" permission assuming that this
>>> includes "read" permission as well and this works on plenty
>>> platforms.
>>> However IODA2 is strict about this and produces an EEH when "read"
>>> permission is not and reading happens.
>>>
>>> This adds a workaround in IODA code to always add the "read" bit when
>>> the "write" bit is set.
>>>
>>> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>>
>>>
>>> Ben, what was the driver which did not set "read" and caused EEH?
>> aacraid
>>
>> Cheers,
>> Ben.
> Just to be precise, the driver wasn't responsible for setting READ. The
> driver called scsi_dma_map() and the scsicmd was set (by scsi layer) as
> DMA_FROM_DEVICE so the current code would set the permissions to
> WRITE-ONLY. Previously, and in other architectures, this scsicmd would have
> resulted in READ+WRITE permissions on the DMA map.


Does the patch fix the issue? Thanks.



>>
>>> ---
>>>   arch/powerpc/platforms/powernv/pci.c | 6 ++++++
>>>   1 file changed, 6 insertions(+)
>>>
>>> diff --git a/arch/powerpc/platforms/powernv/pci.c
>>> b/arch/powerpc/platforms/powernv/pci.c
>>> index f2dd772..c7dcae5 100644
>>> --- a/arch/powerpc/platforms/powernv/pci.c
>>> +++ b/arch/powerpc/platforms/powernv/pci.c
>>> @@ -601,6 +601,9 @@ int pnv_tce_build(struct iommu_table *tbl, long
>>> index, long npages,
>>>       u64 rpn = __pa(uaddr) >> tbl->it_page_shift;
>>>       long i;
>>> +    if (proto_tce & TCE_PCI_WRITE)
>>> +        proto_tce |= TCE_PCI_READ;
>>> +
>>>       for (i = 0; i < npages; i++) {
>>>           unsigned long newtce = proto_tce |
>>>               ((rpn + i) << tbl->it_page_shift);
>>> @@ -622,6 +625,9 @@ int pnv_tce_xchg(struct iommu_table *tbl, long
>>> index,
>>>       BUG_ON(*hpa & ~IOMMU_PAGE_MASK(tbl));
>>> +    if (newtce & TCE_PCI_WRITE)
>>> +        newtce |= TCE_PCI_READ;
>>> +
>>>       oldtce = xchg(pnv_tce(tbl, idx), cpu_to_be64(newtce));
>>>       *hpa = be64_to_cpu(oldtce) & ~(TCE_PCI_READ |
>>> TCE_PCI_WRITE);
>>>       *direction = iommu_tce_direction(oldtce);
>> _______________________________________________
>> Linuxppc-dev mailing list
>> Linuxppc-dev@lists.ozlabs.org
>> https://lists.ozlabs.org/listinfo/linuxppc-dev
>
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev


-- 
Alexey
