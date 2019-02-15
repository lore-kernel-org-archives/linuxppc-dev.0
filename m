Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_PASS autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BAE4DC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 10:03:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 09CAF21924
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 10:03:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 09CAF21924
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=virtuozzo.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44183D6p9SzDqgr
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 21:03:20 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=virtuozzo.com
 (client-ip=185.231.240.75; helo=relay.sw.ru;
 envelope-from=aryabinin@virtuozzo.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=virtuozzo.com
Received: from relay.sw.ru (relay.sw.ru [185.231.240.75])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44181K37vBzDqWM
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 21:01:38 +1100 (AEDT)
Received: from [172.16.25.12] by relay.sw.ru with esmtp (Exim 4.91)
 (envelope-from <aryabinin@virtuozzo.com>)
 id 1guaJA-0003fU-Ra; Fri, 15 Feb 2019 13:01:24 +0300
Subject: Re: [PATCH v5 3/3] powerpc/32: Add KASAN support
To: Christophe Leroy <christophe.leroy@c-s.fr>, Daniel Axtens
 <dja@axtens.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>
References: <cover.1549935247.git.christophe.leroy@c-s.fr>
 <3429fe33b68206ecc2a725a740937bbaef2d1ac8.1549935251.git.christophe.leroy@c-s.fr>
 <8736oq3u2r.fsf@dja-thinkpad.axtens.net>
 <b5db7714-51e3-785c-34ca-6c358661c9e8@c-s.fr>
From: Andrey Ryabinin <aryabinin@virtuozzo.com>
Message-ID: <e43e21c2-f42c-bab3-c112-2a557f3de5b1@virtuozzo.com>
Date: Fri, 15 Feb 2019 13:01:46 +0300
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <b5db7714-51e3-785c-34ca-6c358661c9e8@c-s.fr>
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
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, kasan-dev@googlegroups.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 2/15/19 11:41 AM, Christophe Leroy wrote:
> 
> 
> Le 14/02/2019 à 23:04, Daniel Axtens a écrit :
>> Hi Christophe,
>>
>>> --- a/arch/powerpc/include/asm/string.h
>>> +++ b/arch/powerpc/include/asm/string.h
>>> @@ -27,6 +27,20 @@ extern int memcmp(const void *,const void *,__kernel_size_t);
>>>   extern void * memchr(const void *,int,__kernel_size_t);
>>>   extern void * memcpy_flushcache(void *,const void *,__kernel_size_t);
>>>   +void *__memset(void *s, int c, __kernel_size_t count);
>>> +void *__memcpy(void *to, const void *from, __kernel_size_t n);
>>> +void *__memmove(void *to, const void *from, __kernel_size_t n);
>>> +
>>> +#if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
>>> +/*
>>> + * For files that are not instrumented (e.g. mm/slub.c) we
>>> + * should use not instrumented version of mem* functions.
>>> + */
>>> +#define memcpy(dst, src, len) __memcpy(dst, src, len)
>>> +#define memmove(dst, src, len) __memmove(dst, src, len)
>>> +#define memset(s, c, n) __memset(s, c, n)
>>> +#endif
>>> +
>>
>> I'm finding that I miss tests like 'kasan test: kasan_memcmp
>> out-of-bounds in memcmp' because the uninstrumented asm version is used
>> instead of an instrumented C version. I ended up guarding the relevant
>> __HAVE_ARCH_x symbols behind a #ifndef CONFIG_KASAN and only exporting
>> the arch versions if we're not compiled with KASAN.
>>
>> I find I need to guard and unexport strncpy, strncmp, memchr and
>> memcmp. Do you need to do this on 32bit as well, or are those tests
>> passing anyway for some reason?
> 
> Indeed, I didn't try the KASAN test module recently, because my configs don't have CONFIG_MODULE by default.
> 
> Trying to test it now, I am discovering that module loading oopses with latest version of my series, I need to figure out exactly why. Here below the oops by modprobing test_module (the one supposed to just say hello to the world).
> 
> What we see is an access to the RO kasan zero area.
> 
> The shadow mem is 0xf7c00000..0xffc00000
> Linear kernel memory is shadowed by 0xf7c00000-0xf8bfffff
> 0xf8c00000-0xffc00000 is shadowed read only by the kasan zero page.
> 
> Why is kasan trying to access that ? Isn't kasan supposed to not check stuff in vmalloc area ?

It tries to poison global variables in modules. If module is in vmalloc, than it will try to poison vmalloc.
Given that the vmalloc area is not so big on 32bits, the easiest solution is to cover all vmalloc with RW shadow.



