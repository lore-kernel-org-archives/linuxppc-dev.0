Return-Path: <bsingharora@gmail.com>
Received: from mail-vk0-x243.google.com (mail-vk0-x243.google.com
 [IPv6:2607:f8b0:400c:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40bXJT4PL5zF2QQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 May 2018 18:59:05 +1000 (AEST)
Received: by mail-vk0-x243.google.com with SMTP id x204-v6so8504927vkd.7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 May 2018 01:59:05 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <c04cd729-fd88-ed46-cfcb-93324bb243f3@ozlabs.ru>
References: <20180502040723.20545-1-aik@ozlabs.ru>
 <20180502040723.20545-3-aik@ozlabs.ru>
 <20180502155323.30c41ce4@balbir.ozlabs.ibm.com>
 <c04cd729-fd88-ed46-cfcb-93324bb243f3@ozlabs.ru>
From: Balbir Singh <bsingharora@gmail.com>
Date: Wed, 2 May 2018 18:59:01 +1000
Message-ID: <CAKTCnzkfXjj4o7NRUsjgDOenZjgcxbhUbOgBw84eqi63JzC5pg@mail.gmail.com>
Subject: Re: [PATCH kernel 2/2] KVM: PPC: Allow backing bigger guest IOMMU
 pages with smaller physical pages
To: Alexey Kardashevskiy <aik@ozlabs.ru>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 "open list:KERNEL VIRTUAL MACHINE (KVM) FOR POWERPC" <kvm-ppc@vger.kernel.org>,
 David Gibson <david@gibson.dropbear.id.au>
Content-Type: text/plain; charset="UTF-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, May 2, 2018 at 4:26 PM, Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
> On 2/5/18 3:53 pm, Balbir Singh wrote:
>> On Wed,  2 May 2018 14:07:23 +1000
>> Alexey Kardashevskiy <aik@ozlabs.ru> wrote:
>>
>>> At the moment we only support in the host the IOMMU page sizes which
>>> the guest is aware of, which is 4KB/64KB/16MB. However P9 does not support
>>> 16MB IOMMU pages, 2MB and 1GB pages are supported instead. We can still
>>> emulate bigger guest pages (for example 16MB) with smaller host pages
>>> (4KB/64KB/2MB).
>>>
>>> This allows the physical IOMMU pages to use a page size smaller or equal
>>> than the guest visible IOMMU page size.
>>>
>>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
>>> ---
>>>  arch/powerpc/kvm/book3s_64_vio.c    | 66 +++++++++++++++++++++++++++++--------
>>>  arch/powerpc/kvm/book3s_64_vio_hv.c | 52 +++++++++++++++++++++++++----
>>>  2 files changed, 98 insertions(+), 20 deletions(-)
>>>
>>> diff --git a/arch/powerpc/kvm/book3s_64_vio.c b/arch/powerpc/kvm/book3s_64_vio.c
>>> index 041e54d..e10d6a3 100644
>>> --- a/arch/powerpc/kvm/book3s_64_vio.c
>>> +++ b/arch/powerpc/kvm/book3s_64_vio.c
>>> @@ -176,14 +176,12 @@ extern long kvm_spapr_tce_attach_iommu_group(struct kvm *kvm, int tablefd,
>>>
>>>              if (!tbltmp)
>>>                      continue;
>>> -            /*
>>> -             * Make sure hardware table parameters are exactly the same;
>>> -             * this is used in the TCE handlers where boundary checks
>>> -             * use only the first attached table.
>>> -             */
>>> -            if ((tbltmp->it_page_shift == stt->page_shift) &&
>>> -                            (tbltmp->it_offset == stt->offset) &&
>>> -                            (tbltmp->it_size == stt->size)) {
>>> +            /* Make sure hardware table parameters are compatible */
>>> +            if ((tbltmp->it_page_shift <= stt->page_shift) &&
>>> +                            (tbltmp->it_offset << tbltmp->it_page_shift ==
>>> +                             stt->offset << stt->page_shift) &&
>>> +                            (tbltmp->it_size << tbltmp->it_page_shift ==
>>> +                             stt->size << stt->page_shift)) {
>>
>> Very difficult to parse
>>
>> How about -
>>
>> subpages_shift = (stt->page_shift - tbl->it_page_shift)
>>
>> and then
>>
>> matches_offset = !(tbltmp->it_offset - (stt->it_offset << subpages_shift));
>> matches_size = !(tbltmp->it_size - (stt->it_size << subpages_shift));
>>
>> The condition then is just
>>
>>               if ((tbltmp->it_page_shift == stt->page_shift) &&
>>                               matches_offset && matches_size) {
>
> This is harder to parse. My variant is bulky but straight forward otherwise.

OK, I don't read this code as often, but found it_page_shift and page_shift
variants hard to understand, but I guess it means I need to read more code.

>
>
>>
>>
>>
>>>                      /*
>>>                       * Reference the table to avoid races with
>>>                       * add/remove DMA windows.
>>> @@ -396,7 +394,7 @@ static long kvmppc_tce_iommu_mapped_dec(struct kvm *kvm,
>>>      return H_SUCCESS;
>>>  }
>>>
>>> -static long kvmppc_tce_iommu_unmap(struct kvm *kvm,
>>> +static long kvmppc_tce_iommu_do_unmap(struct kvm *kvm,
>>>              struct iommu_table *tbl, unsigned long entry)
>>>  {
>>>      enum dma_data_direction dir = DMA_NONE;
>>> @@ -416,7 +414,25 @@ static long kvmppc_tce_iommu_unmap(struct kvm *kvm,
>>>      return ret;
>>>  }
>>>
>>> -long kvmppc_tce_iommu_map(struct kvm *kvm, struct iommu_table *tbl,
>>> +static long kvmppc_tce_iommu_unmap(struct kvm *kvm,
>>> +            struct kvmppc_spapr_tce_table *stt, struct iommu_table *tbl,
>>> +            unsigned long entry)
>>> +{
>>> +    unsigned long ret = H_SUCCESS;
>>> +    unsigned long subpages = 1ULL << (stt->page_shift - tbl->it_page_shift);
>>> +    unsigned long io_entry = entry * subpages;
>>
>> How do we know this multiplication does not overflow?
>
> Entry, page_shift come from the userspace and checked in appropriate
> ioctl/hcall handlers.
>

Yes, I am not sure how many safety nets we need, but I worry about
such things :)

>>
>>> +    unsigned long subpg;
>>
>> Why not just i?
>
> I can imagine pages so huge so backing them with 4K will overflow 32bit
> anyway. It is very (very) unlikely but it is 64bit arch anyway and there is
> no much point in not-long types anyway.
>

What David said, i is an easy iterator to understand :)

Balbir Singh.
