Return-Path: <bsingharora@gmail.com>
Received: from mail-yb0-x244.google.com (mail-yb0-x244.google.com
 [IPv6:2607:f8b0:4002:c09::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sYK776ymqzDrfR
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 19:26:27 +1000 (AEST)
Received: by mail-yb0-x244.google.com with SMTP id 79so1781371ybe.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Sep 2016 02:26:27 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <57D79358.5070104@linux.vnet.ibm.com>
References: <1473678797-22069-1-git-send-email-khandual@linux.vnet.ibm.com>
 <CAKTCnz=W4JD2n-Gne2f1WpstPvKnVHRGaB485ibRdmvmGfF0jA@mail.gmail.com>
 <57D77B8F.6030801@linux.vnet.ibm.com>
 <f76332f8-d4b2-043c-1e72-da0f7cb12758@gmail.com>
 <57D79358.5070104@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Date: Tue, 13 Sep 2016 19:26:23 +1000
Message-ID: <CAKTCnzkRXizfG84tejK4XwavZ-G6EpvJre-zwydHOywHdZqwcA@mail.gmail.com>
Subject: Re: [RFC] KVM: PPC: Book3S HV: Fall back to same size HPT in
 allocation ioctl
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Cc: "open list:LINUX FOR POWERPC (32-BIT AND 64-BIT)"
 <linuxppc-dev@lists.ozlabs.org>,
 Aneesh Kumar KV <aneesh.kumar@linux.vnet.ibm.com>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 13, 2016 at 3:49 PM, Anshuman Khandual
<khandual@linux.vnet.ibm.com> wrote:
> On 09/13/2016 10:04 AM, Balbir Singh wrote:
>>
>>
>> On 13/09/16 14:07, Anshuman Khandual wrote:
>>> On 09/12/2016 05:03 PM, Balbir Singh wrote:
>>>> On Mon, Sep 12, 2016 at 9:13 PM, Anshuman Khandual
>>>> <khandual@linux.vnet.ibm.com> wrote:
>>>>>> When the HPT size is explicitly passed on from the userspace, currently
>>>>>> the KVM_PPC_ALLOCATE_HTAB will try to allocate the requested size of HPT
>>>>>> from reserved CMA area and if that is not possible, the allocation just
>>>>>> fails. With the commit 572abd563befd56 ("KVM: PPC: Book3S HV: Don't fall
>>>>>> back to smaller HPT size in allocation ioctl"), it does not even try to
>>>>>> allocate the same order pages from the page allocator before failing for
>>>>>> good. Same order allocation should be attempted from the page allocator
>>>>>> as a fallback option when the CMA allocation attempt fails.
>>>>>>
>>>>>> Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
>>>>>> ---
>>>>>> - This change saves guests from failing to start after migration
>>>>>>
>>>>>>  arch/powerpc/kvm/book3s_64_mmu_hv.c | 8 ++++++++
>>>>>>  1 file changed, 8 insertions(+)
>>>>>>
>>>>>> diff --git a/arch/powerpc/kvm/book3s_64_mmu_hv.c b/arch/powerpc/kvm/book3s_64_mmu_hv.c
>>>>>> index 05f09ae..0a30eb4 100644
>>>>>> --- a/arch/powerpc/kvm/book3s_64_mmu_hv.c
>>>>>> +++ b/arch/powerpc/kvm/book3s_64_mmu_hv.c
>>>>>> @@ -78,6 +78,14 @@ long kvmppc_alloc_hpt(struct kvm *kvm, u32 *htab_orderp)
>>>>>>                         --order;
>>>>>>         }
>>>>>>
>>>>>> +       /*
>>>>>> +        * Fallback in case the userspace has provided a size via ioctl.
>>>>>> +        * Try allocating the same order pages from the page allocator.
>>>>>> +        */
>>>>>> +       if (!hpt && order > PPC_MIN_HPT_ORDER && htab_orderp)
>>>>>> +               hpt = __get_free_pages(GFP_KERNEL|__GFP_ZERO|__GFP_REPEAT|
>>>>>> +                       __GFP_NOWARN, order - PAGE_SHIFT);
>>>>>> +
>>>> How often does this succeed? Please provide data. I presume this for
>>>
>>> During continuous guest VM migration test from source host to destination host
>>> this patch was able to prevent guest creation failure after migration on the
>>> destination host which was failing after 2-3 days. We have not seen the failure
>>> till now even after 3-4 days.
>>>
>>
>> OK.. the CMA failures need analysis. Are we just ignoring a CMA bug? IOW, why
>
> Sure, it does need analysis. But there will be situations where CMA
> allocation request can fail, thats why we will need fallback option.

Please elaborate those situations. This patch needs more explanation
as to why we should fallback -- what are those short comings of CMA
allocation. Can anyone using CMA face them and have to design a fallback?

> That the same reason why we have fall back options of attempting from
> page allocator (in decreasing order every time) when the size is not
> specified as part of the ioctl. Why the case should be any different
> when the size is specified in the ioctl().
>
>> would CMA allocation fail -- CMA size is too small to accommodate the required
>> number of allocations?
>
> The same size seems to be good enough for first couple of days and
> then it fails. Probably some __GFP_MOVABLE allocation got pinned
> later on.
>

Please analyze and let us know

>>
>>>> the case where guest pages are pinned?
>>>
>>> Hmm, need to check that in the test setup. There was nothing running inside the
>>> guests though. IIUC, HPT size of the guest is computed based on the max memory
>>> the guest is ever going to have irrespective of the RAM usage before migration.
>>> How does pinning effect the HPT size ?
>>>
>>
>> If the pinned pages (from anywhere) belong to CMA, then CMA allocations would start failing
>
> Right and with the current design of CMA we can do nothing about it,
> unless we make sure the pages allocated to satisfy guest real memory
> do not come from CMA area at all.
>

I have patches to move non-THP pages out of CMA

Balbir
