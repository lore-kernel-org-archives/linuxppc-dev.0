Return-Path: <SRS0=0iBm=QT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E8968C169C4
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 01:10:35 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 613AF217FA
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 01:10:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="jtkrfv5h"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 613AF217FA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43z4Mr2bDLzDqKb
	for <linuxppc-dev@archiver.kernel.org>; Tue, 12 Feb 2019 12:10:32 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::441; helo=mail-pf1-x441.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="jtkrfv5h"; 
 dkim-atps=neutral
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43z4Kp17DkzDqHb
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Feb 2019 12:08:45 +1100 (AEDT)
Received: by mail-pf1-x441.google.com with SMTP id z9so429654pfi.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Feb 2019 17:08:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version:content-transfer-encoding;
 bh=WfZyIsccqWR3lZErvejq0nP1VhlSzDJCMVE8xMZxBo4=;
 b=jtkrfv5h0Z5ESOjhOeJ+kwO2Ti2RhZaG9kOTT32sBA33x6st698ZR104Kzny8NB9Gg
 8BBn24As3ax0MfwHfqh03vMdOsNkun4gA5eQAn+8U0jrslgVwBGMd/XTec5AbF37LhYW
 YoRYcglS/a37IsHlilhe4vSt8Gq0twliHzroY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version:content-transfer-encoding;
 bh=WfZyIsccqWR3lZErvejq0nP1VhlSzDJCMVE8xMZxBo4=;
 b=rfQKMzsgrFWGDKILKFdxqlGpP2fOSMM37/DZH/WVL03Jb+/ngKsNoh25g5lcqB6eaX
 wJv1bwsSm8pFGpcdh7WbSCwkWhox+qO6dLe8Es7juXNb9jGjOKbr0MEOZ+9OH1oKfj4s
 g3ymluL4aYfKbL2speFDOvWrlAULl4OmMI1TxLhS1hFANpOqroowuSmNaVwK62337XUx
 i+4s7YNawZygfSdd4Ej6W19j/lb3LBN8qJ/LrndHi7s/plNII3p1nTDmwq8wSn4DcIKV
 jimj/GA1SQaT6JbkXs6DeF2/TS1684Mm8GF1KyBwut8G+8fUKA4ECNfsHMzyu4QzkyXF
 LRuQ==
X-Gm-Message-State: AHQUAua6RCbDEtkSlUeVxPQkth1IY8+4Fe+OjBcGlLPRuggLY5NUASzO
 c4jMV3CtKio3e7UiLm+TT49pmA==
X-Google-Smtp-Source: AHgI3IYwyw2dUTqU1GUA+O3qTH7XPl2tZBiWgJCD013uPJgIBjqRK0tLqD7dhhCkrMJ3SKiUfeDYFw==
X-Received: by 2002:a62:ca03:: with SMTP id n3mr1216531pfg.241.1549933723290; 
 Mon, 11 Feb 2019 17:08:43 -0800 (PST)
Received: from localhost (124-171-97-196.dyn.iinet.net.au. [124.171.97.196])
 by smtp.gmail.com with ESMTPSA id o126sm7732968pfb.126.2019.02.11.17.08.41
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 11 Feb 2019 17:08:42 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Andrey Konovalov <andreyknvl@google.com>,
 christophe leroy <christophe.leroy@c-s.fr>
Subject: Re: [PATCH v4 3/3] powerpc/32: Add KASAN support
In-Reply-To: <805fbf9d-a10f-03e0-aa52-6f6bd16059b9@virtuozzo.com>
References: <cover.1548166824.git.christophe.leroy@c-s.fr>
 <1f5629e03181d0e30efc603f00dad78912991a45.1548166824.git.christophe.leroy@c-s.fr>
 <87ef8i45km.fsf@dja-thinkpad.axtens.net>
 <69720148-fd19-0810-5a1d-96c45e2ec00c@c-s.fr>
 <CAAeHK+wcUwLiSQffUkcyiH2fuox=VihJadEqQqRG1YfU3Y2gDA@mail.gmail.com>
 <f8b9e9ec-991b-6824-46c2-f7fc0aaa7fb8@c-s.fr>
 <CAAeHK+zop5ajOJQ4KEYbuxMRegk2GM1LvuGcSbCU1O5EZxB0MA@mail.gmail.com>
 <805fbf9d-a10f-03e0-aa52-6f6bd16059b9@virtuozzo.com>
Date: Tue, 12 Feb 2019 12:08:36 +1100
Message-ID: <87imxpak4r.fsf@linkitivity.dja.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
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

Andrey Ryabinin <aryabinin@virtuozzo.com> writes:

> On 2/11/19 3:25 PM, Andrey Konovalov wrote:
>> On Sat, Feb 9, 2019 at 12:55 PM christophe leroy
>> <christophe.leroy@c-s.fr> wrote:
>>>
>>> Hi Andrey,
>>>
>>> Le 08/02/2019 =C3=A0 18:40, Andrey Konovalov a =C3=A9crit :
>>>> On Fri, Feb 8, 2019 at 6:17 PM Christophe Leroy <christophe.leroy@c-s.=
fr> wrote:
>>>>>
>>>>> Hi Daniel,
>>>>>
>>>>> Le 08/02/2019 =C3=A0 17:18, Daniel Axtens a =C3=A9crit :
>>>>>> Hi Christophe,
>>>>>>
>>>>>> I've been attempting to port this to 64-bit Book3e nohash (e6500),
>>>>>> although I think I've ended up with an approach more similar to Anee=
sh's
>>>>>> much earlier (2015) series for book3s.
>>>>>>
>>>>>> Part of this is just due to the changes between 32 and 64 bits - we =
need
>>>>>> to hack around the discontiguous mappings - but one thing that I'm
>>>>>> particularly puzzled by is what the kasan_early_init is supposed to =
do.
>>>>>
>>>>> It should be a problem as my patch uses a 'for_each_memblock(memory,
>>>>> reg)' loop.
>>>>>
>>>>>>
>>>>>>> +void __init kasan_early_init(void)
>>>>>>> +{
>>>>>>> +    unsigned long addr =3D KASAN_SHADOW_START;
>>>>>>> +    unsigned long end =3D KASAN_SHADOW_END;
>>>>>>> +    unsigned long next;
>>>>>>> +    pmd_t *pmd =3D pmd_offset(pud_offset(pgd_offset_k(addr), addr)=
, addr);
>>>>>>> +    int i;
>>>>>>> +    phys_addr_t pa =3D __pa(kasan_early_shadow_page);
>>>>>>> +
>>>>>>> +    BUILD_BUG_ON(KASAN_SHADOW_START & ~PGDIR_MASK);
>>>>>>> +
>>>>>>> +    if (early_mmu_has_feature(MMU_FTR_HPTE_TABLE))
>>>>>>> +            panic("KASAN not supported with Hash MMU\n");
>>>>>>> +
>>>>>>> +    for (i =3D 0; i < PTRS_PER_PTE; i++)
>>>>>>> +            __set_pte_at(&init_mm, (unsigned long)kasan_early_shad=
ow_page,
>>>>>>> +                         kasan_early_shadow_pte + i,
>>>>>>> +                         pfn_pte(PHYS_PFN(pa), PAGE_KERNEL_RO), 0);
>>>>>>> +
>>>>>>> +    do {
>>>>>>> +            next =3D pgd_addr_end(addr, end);
>>>>>>> +            pmd_populate_kernel(&init_mm, pmd, kasan_early_shadow_=
pte);
>>>>>>> +    } while (pmd++, addr =3D next, addr !=3D end);
>>>>>>> +}
>>>>>>
>>>>>> As far as I can tell it's mapping the early shadow page, read-only, =
over
>>>>>> the KASAN_SHADOW_START->KASAN_SHADOW_END range, and it's using the e=
arly
>>>>>> shadow PTE array from the generic code.
>>>>>>
>>>>>> I haven't been able to find an answer to why this is in the docs, so=
 I
>>>>>> was wondering if you or anyone else could explain the early part of
>>>>>> kasan init a bit better.
>>>>>
>>>>> See https://www.kernel.org/doc/html/latest/dev-tools/kasan.html for an
>>>>> explanation of the shadow.
>>>>>
>>>>> When shadow is 0, it means the memory area is entirely accessible.
>>>>>
>>>>> It is necessary to setup a shadow area as soon as possible because all
>>>>> data accesses check the shadow area, from the begining (except for a =
few
>>>>> files where sanitizing has been disabled in Makefiles).
>>>>>
>>>>> Until the real shadow area is set, all access are granted thanks to t=
he
>>>>> zero shadow area beeing for of zeros.
>>>>
>>>> Not entirely correct. kasan_early_init() indeed maps the whole shadow
>>>> memory range to the same kasan_early_shadow_page. However as kernel
>>>> loads and memory gets allocated this shadow page gets rewritten with
>>>> non-zero values by different KASAN allocator hooks. Since these values
>>>> come from completely different parts of the kernel, but all land on
>>>> the same page, kasan_early_shadow_page's content can be considered
>>>> garbage. When KASAN checks memory accesses for validity it detects
>>>> these garbage shadow values, but doesn't print any reports, as the
>>>> reporting routine bails out on the current->kasan_depth check (which
>>>> has the value of 1 initially). Only after kasan_init() completes, when
>>>> the proper shadow memory is mapped, current->kasan_depth gets set to 0
>>>> and we start reporting bad accesses.
>>>
>>> That's surprising, because in the early phase I map the shadow area
>>> read-only, so I do not expect it to get modified unless RO protection is
>>> failing for some reason.
>>=20
>> Actually it might be that the allocator hooks don't modify shadow at
>> this point, as the allocator is not yet initialized. However stack
>> should be getting poisoned and unpoisoned from the very start. But the
>> generic statement that early shadow gets dirtied should be correct.
>> Might it be that you don't use stack instrumentation?
>>=20
>
> Yes, stack instrumentation is not used here, because shadow offset which =
we pass to
> the -fasan-shadow-offset=3D cflag is not specified here. So the logic in =
scrpits/Makefile.kasan
> just fallbacks to CFLAGS_KASAN_MINIMAL, which is outline and without stac=
k instrumentation.
>
> Christophe, you can specify KASAN_SHADOW_OFFSET either in Kconfig (e.g. x=
86_64) or
> in Makefile (e.g. arm64). And make early mapping writable, because compil=
er generated code will write
> to shadow memory in function prologue/epilogue.

Hmm. Is this limitation just that compilers have not implemented
out-of-line support for stack instrumentation, or is there a deeper
reason that stack/global instrumentation relies upon inline
instrumentation?

I ask because it's very common on ppc64 to have the virtual address
space split up into discontiguous blocks. I know this means we lose
inline instrumentation, but I didn't realise we'd also lose stack and
global instrumentation...

I wonder if it would be worth, in the distant future, trying to
implement a smarter scheme in compilers where we could insert more
complex inline mapping schemes.

Regards,
Daniel
