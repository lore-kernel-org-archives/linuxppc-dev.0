Return-Path: <ryabinin.a.a@gmail.com>
Received: from mail-vk0-x22d.google.com (mail-vk0-x22d.google.com
 [IPv6:2607:f8b0:400c:c05::22d])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8BB871A0153
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 19:30:35 +1000 (AEST)
Received: by vkao123 with SMTP id o123so5859311vka.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 18 Aug 2015 02:30:33 -0700 (PDT)
MIME-Version: 1.0
In-Reply-To: <87wpwtne9p.fsf@linux.vnet.ibm.com>
References: <1439793400-18147-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1439794492.2416.8.camel@kernel.crashing.org>
 <87mvxqp7l5.fsf@linux.vnet.ibm.com>
 <CAPAsAGzLY86BLT2KwE+dc=R+rnTPbMbxH_V4eror-Nvnd=3K8w@mail.gmail.com>
 <87zj1pnodu.fsf@linux.vnet.ibm.com>
 <CAPAsAGz40+1+P7ANVjU0WKCsiF4=sKNEs2+Jx_gdcKpkL5nL+A@mail.gmail.com>
 <87wpwtne9p.fsf@linux.vnet.ibm.com>
Date: Tue, 18 Aug 2015 12:30:33 +0300
Message-ID: <CAPAsAGzq9M=t7n82wX9xYTwu8bj3U8CsquzE=gLiKW2hVSwmjg@mail.gmail.com>
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

2015-08-18 12:21 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
> Andrey Ryabinin <ryabinin.a.a@gmail.com> writes:
>
>> 2015-08-18 8:42 GMT+03:00 Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>:
>>> Andrey Ryabinin <ryabinin.a.a@gmail.com> writes:
>>>
>>>
>>> But that is introducting conditionals in core code for no real benefit.
>>> This also will break when we eventually end up tracking vmalloc ?
>>
>> Ok, that's a very good reason to not do this.
>>
>> I see one potential problem in the way you use kasan_zero_page, though.
>> memset/memcpy of large portions of memory ( > 8 * PAGE_SIZE) will end up
>> in overflowing kasan_zero_page when we check shadow in memory_is_poisoned_n()
>>
>
> Any suggestion on how to fix that ? I guess we definitely don't want to

Wait, I was wrong, we should be fine.
In memory_is_poisoned_n():

ret = memory_is_zero(kasan_mem_to_shadow((void *)addr),
            kasan_mem_to_shadow((void *)addr + size - 1) + 1);

So this will be: memory_is_zero(kasan_zero_page, (char *)kasan_zero_page + 1);
Which means that we will access only 1 byte of kasan_zero_page.


> check for addr and size in memset/memcpy. The other option is to
> do zero page mapping as is done for other architectures. That is we map
> via page table a zero page. But we still have the issue of memory we
> need to map the entire vmalloc range (page table memory). I was hoping to
> avoid all those complexities.
>
>
> -aneesh
>
