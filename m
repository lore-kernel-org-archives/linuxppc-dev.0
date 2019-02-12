Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F1F96C282C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 12:04:45 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 45BF42075D
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 12:04:45 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 45BF42075D
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43zLtf57RzzDqQN
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 23:04:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=virtuozzo.com
 (client-ip=185.231.240.75; helo=relay.sw.ru;
 envelope-from=aryabinin@virtuozzo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=virtuozzo.com
Received: from relay.sw.ru (relay.sw.ru [185.231.240.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43zLqx4hgzzDqNp
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 23:02:20 +1100 (AEDT)
Received: from [172.16.25.12] by relay.sw.ru with esmtp (Exim 4.91)
 (envelope-from <aryabinin@virtuozzo.com>)
 id 1gtWlM-0007z9-PX; Tue, 12 Feb 2019 15:02:08 +0300
Subject: Re: [PATCH v4 3/3] powerpc/32: Add KASAN support
To: Daniel Axtens <dja@axtens.net>, Andrey Konovalov <andreyknvl@google.com>, 
 christophe leroy <christophe.leroy@c-s.fr>
References: <cover.1548166824.git.christophe.leroy@c-s.fr>
 <1f5629e03181d0e30efc603f00dad78912991a45.1548166824.git.christophe.leroy@c-s.fr>
 <87ef8i45km.fsf@dja-thinkpad.axtens.net>
 <69720148-fd19-0810-5a1d-96c45e2ec00c@c-s.fr>
 <CAAeHK+wcUwLiSQffUkcyiH2fuox=VihJadEqQqRG1YfU3Y2gDA@mail.gmail.com>
 <f8b9e9ec-991b-6824-46c2-f7fc0aaa7fb8@c-s.fr>
 <CAAeHK+zop5ajOJQ4KEYbuxMRegk2GM1LvuGcSbCU1O5EZxB0MA@mail.gmail.com>
 <805fbf9d-a10f-03e0-aa52-6f6bd16059b9@virtuozzo.com>
 <87imxpak4r.fsf@linkitivity.dja.id.au>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <dee48cfa-946f-c4c2-c3ae-dd4c1fec3aca@virtuozzo.com>
Date: Tue, 12 Feb 2019 15:02:30 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <87imxpak4r.fsf@linkitivity.dja.id.au>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: LKML <linux-kernel@vger.kernel.org>, Nicholas Piggin <npiggin@gmail.com>,
 Linux Memory Management List <linux-mm@kvack.org>,
 Alexander Potapenko <glider@google.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Paul Mackerras <paulus@samba.org>, kasan-dev <kasan-dev@googlegroups.com>,
 PowerPC <linuxppc-dev@lists.ozlabs.org>, Dmitry Vyukov <dvyukov@google.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 2/12/19 4:08 AM, Daniel Axtens wrote:
> Andrey Ryabinin <aryabinin@virtuozzo.com> writes:
> 
>> On 2/11/19 3:25 PM, Andrey Konovalov wrote:
>>> On Sat, Feb 9, 2019 at 12:55 PM christophe leroy
>>> <christophe.leroy@c-s.fr> wrote:
>>>>
>>>> Hi Andrey,
>>>>
>>>> Le 08/02/2019 à 18:40, Andrey Konovalov a écrit :
>>>>> On Fri, Feb 8, 2019 at 6:17 PM Christophe Leroy <christophe.leroy@c-s.fr> wrote:
>>>>>>
>>>>>> Hi Daniel,
>>>>>>
>>>>>> Le 08/02/2019 à 17:18, Daniel Axtens a écrit :
>>>>>>> Hi Christophe,
>>>>>>>
>>>>>>> I've been attempting to port this to 64-bit Book3e nohash (e6500),
>>>>>>> although I think I've ended up with an approach more similar to Aneesh's
>>>>>>> much earlier (2015) series for book3s.
>>>>>>>
>>>>>>> Part of this is just due to the changes between 32 and 64 bits - we need
>>>>>>> to hack around the discontiguous mappings - but one thing that I'm
>>>>>>> particularly puzzled by is what the kasan_early_init is supposed to do.
>>>>>>
>>>>>> It should be a problem as my patch uses a 'for_each_memblock(memory,
>>>>>> reg)' loop.
>>>>>>
>>>>>>>
>>>>>>>> +void __init kasan_early_init(void)
>>>>>>>> +{
>>>>>>>> +    unsigned long addr = KASAN_SHADOW_START;
>>>>>>>> +    unsigned long end = KASAN_SHADOW_END;
>>>>>>>> +    unsigned long next;
>>>>>>>> +    pmd_t *pmd = pmd_offset(pud_offset(pgd_offset_k(addr), addr), addr);
>>>>>>>> +    int i;
>>>>>>>> +    phys_addr_t pa = __pa(kasan_early_shadow_page);
>>>>>>>> +
>>>>>>>> +    BUILD_BUG_ON(KASAN_SHADOW_START & ~PGDIR_MASK);
>>>>>>>> +
>>>>>>>> +    if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE))
>>>>>>>> +            panic("KASAN not supported with Hash MMU\n");
>>>>>>>> +
>>>>>>>> +    for (i = 0; i < PTRS_PER_PTE; i++)
>>>>>>>> +            __set_pte_at(&init_mm, (unsigned long)kasan_early_shadow_page,
>>>>>>>> +                         kasan_early_shadow_pte + i,
>>>>>>>> +                         pfn_pte(PHYS_PFN(pa), PAGE_KERNEL_RO), 0);
>>>>>>>> +
>>>>>>>> +    do {
>>>>>>>> +            next = pgd_addr_end(addr, end);
>>>>>>>> +            pmd_populate_kernel(&init_mm, pmd, kasan_early_shadow_pte);
>>>>>>>> +    } while (pmd++, addr = next, addr != end);
>>>>>>>> +}
>>>>>>>
>>>>>>> As far as I can tell it's mapping the early shadow page, read-only, over
>>>>>>> the KASAN_SHADOW_START->KASAN_SHADOW_END range, and it's using the early
>>>>>>> shadow PTE array from the generic code.
>>>>>>>
>>>>>>> I haven't been able to find an answer to why this is in the docs, so I
>>>>>>> was wondering if you or anyone else could explain the early part of
>>>>>>> kasan init a bit better.
>>>>>>
>>>>>> See https://www.kernel.org/doc/html/latest/dev-tools/kasan.html for an
>>>>>> explanation of the shadow.
>>>>>>
>>>>>> When shadow is 0, it means the memory area is entirely accessible.
>>>>>>
>>>>>> It is necessary to setup a shadow area as soon as possible because all
>>>>>> data accesses check the shadow area, from the begining (except for a few
>>>>>> files where sanitizing has been disabled in Makefiles).
>>>>>>
>>>>>> Until the real shadow area is set, all access are granted thanks to the
>>>>>> zero shadow area beeing for of zeros.
>>>>>
>>>>> Not entirely correct. kasan_early_init() indeed maps the whole shadow
>>>>> memory range to the same kasan_early_shadow_page. However as kernel
>>>>> loads and memory gets allocated this shadow page gets rewritten with
>>>>> non-zero values by different KASAN allocator hooks. Since these values
>>>>> come from completely different parts of the kernel, but all land on
>>>>> the same page, kasan_early_shadow_page's content can be considered
>>>>> garbage. When KASAN checks memory accesses for validity it detects
>>>>> these garbage shadow values, but doesn't print any reports, as the
>>>>> reporting routine bails out on the current->kasan_depth check (which
>>>>> has the value of 1 initially). Only after kasan_init() completes, when
>>>>> the proper shadow memory is mapped, current->kasan_depth gets set to 0
>>>>> and we start reporting bad accesses.
>>>>
>>>> That's surprising, because in the early phase I map the shadow area
>>>> read-only, so I do not expect it to get modified unless RO protection is
>>>> failing for some reason.
>>>
>>> Actually it might be that the allocator hooks don't modify shadow at
>>> this point, as the allocator is not yet initialized. However stack
>>> should be getting poisoned and unpoisoned from the very start. But the
>>> generic statement that early shadow gets dirtied should be correct.
>>> Might it be that you don't use stack instrumentation?
>>>
>>
>> Yes, stack instrumentation is not used here, because shadow offset which we pass to
>> the -fasan-shadow-offset= cflag is not specified here. So the logic in scrpits/Makefile.kasan
>> just fallbacks to CFLAGS_KASAN_MINIMAL, which is outline and without stack instrumentation.
>>
>> Christophe, you can specify KASAN_SHADOW_OFFSET either in Kconfig (e.g. x86_64) or
>> in Makefile (e.g. arm64). And make early mapping writable, because compiler generated code will write
>> to shadow memory in function prologue/epilogue.
> 
> Hmm. Is this limitation just that compilers have not implemented
> out-of-line support for stack instrumentation, or is there a deeper
> reason that stack/global instrumentation relies upon inline
> instrumentation?
> 

Yes, it's simply wasn't implemented in compilers. Stack [un]poisoning code is always inlined.

But globals is the opposite of that, they all poisoned out-of-line via __asan_register_globals() call.

> I ask because it's very common on ppc64 to have the virtual address
> space split up into discontiguous blocks. I know this means we lose
> inline instrumentation, but I didn't realise we'd also lose stack and
> global instrumentation...
> 
> I wonder if it would be worth, in the distant future, trying to
> implement a smarter scheme in compilers where we could insert more
> complex inline mapping schemes.
> 

I'd say it depends on performance boost that inline might give for those complex inline schemes.
The whole inline instrumentation thing exists only because it gives better performance.


> Regards,
> Daniel
> 
