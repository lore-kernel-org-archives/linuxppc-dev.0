Return-Path: <ryabinin.a.a@gmail.com>
Received: from mail-vk0-x236.google.com (mail-vk0-x236.google.com
 [IPv6:2607:f8b0:400c:c05::236])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 914841A0151
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 18:50:51 +1000 (AEST)
Received: by vkfi73 with SMTP id i73so66475320vkf.2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 01:50:49 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87zj1pnodu.fsf@linux.vnet.ibm.com>
References: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1439794492.2416.8.camel@kernel.crashing.org>
 <87mvxqp7l5.fsf@linux.vnet.ibm.com>
 <CAPAsAGzLY86BLT2KwE+dc=R+rnTPbMbxH_V4eror-Nvnd=3K8w@mail.gmail.com>
 <87zj1pnodu.fsf@linux.vnet.ibm.com>
Date: Tue, 18 Aug 2015 11:50:49 +0300
Message-ID: <CAPAsAGz40+1+P7ANVjU0WKCsiF4=sKNEs2+Jx_gdcKpkL5nL+A@mail.gmail.com>
Subject: Re: [RFC PATCH V1 0/8] KASAN ppc64 support
From: Andrey Ryabinin <ryabinin.a.a@gmail.com>
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>, paulus@samba.org,
 mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

2015-08-18 8:42 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
> Andrey Ryabinin <ryabinin.a.a@gmail.com> writes:
>
>> 2015-08-17 12:50 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
>>> Because of the above I concluded that we may not be able to do
>>> inline instrumentation. Now if we are not doing inline instrumentation,
>>> we can simplify kasan support by not creating a shadow mapping at all
>>> for vmalloc and vmemmap region. Hence the idea of returning the address
>>> of a zero page for anything other than kernel linear map region.
>>>
>>
>> Yes, mapping zero page needed only for inline instrumentation.
>> You simply don't need to check shadow for vmalloc/vmemmap.
>>
>> So, instead of redefining kasan_mem_to_shadow() I'd suggest to
>> add one more arch hook. Something like:
>>
>> bool kasan_tracks_vaddr(unsigned long addr)
>> {
>>      return REGION_ID(addr) == KERNEL_REGION_ID;
>> }
>>
>> And in check_memory_region():
>>        if (!(kasan_enabled() && kasan_tracks_vaddr(addr)))
>>                return;
>
>
> But that is introducting conditionals in core code for no real benefit.
> This also will break when we eventually end up tracking vmalloc ?

Ok, that's a very good reason to not do this.

I see one potential problem in the way you use kasan_zero_page, though.
memset/memcpy of large portions of memory ( > 8 * PAGE_SIZE) will end up
in overflowing kasan_zero_page when we check shadow in memory_is_poisoned_n()

> In that case our mem_to_shadow will esentially be a switch
> statement returning different offsets for kernel region and vmalloc
> region. As far as core kernel code is considered, it just need to
> ask arch to get the shadow address for a memory and instead of adding
> conditionals in core, my suggestion is, we handle this in an arch function.
>
> -aneesh
>
