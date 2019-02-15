Return-Path: <SRS0=eC6l=QW=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29F7CC43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 10:12:29 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 97A6321A80
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 10:12:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="dsVPGzXf"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 97A6321A80
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4418Fk4C9kzDqfb
	for <linuxppc-dev@archiver.kernel.org>; Fri, 15 Feb 2019 21:12:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="dsVPGzXf"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4418Cl12V4zDqbc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Feb 2019 21:10:43 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 4418Cf5XlBz9vKJC;
 Fri, 15 Feb 2019 11:10:38 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=dsVPGzXf; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id kY2u5JCdnJat; Fri, 15 Feb 2019 11:10:38 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 4418Cf4QVrz9vKJB;
 Fri, 15 Feb 2019 11:10:38 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1550225438; bh=fGrTf9HHpW6M3RhNKUCDoLysugJ3V4FOz2cylNekxBo=;
 h=Subject:To:Cc:References:From:Date:In-Reply-To:From;
 b=dsVPGzXf9jTylpe4jcZ42VTr8CyUFG1L0HNnZ+W9GYdkRO9/4qND3a1ysrc0Ax81h
 6V9aLnS8grv5bdjtZ5GXir9xL/DUYNnOQOOppPkGgtKGt943zlEsSDAKzHWThrzpL2
 suwZ4SQlA+a9sM5G4TUbb1ydvkZLudL+eVg6KBdg=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 9A4B88B8C6;
 Fri, 15 Feb 2019 11:10:39 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id cC4JOO6DXi5B; Fri, 15 Feb 2019 11:10:39 +0100 (CET)
Received: from PO15451 (po15451.idsi0.si.c-s.fr [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 60CE88B8C5;
 Fri, 15 Feb 2019 11:10:39 +0100 (CET)
Subject: Re: [PATCH v5 3/3] powerpc/32: Add KASAN support
To: Andrey Ryabinin <aryabinin@virtuozzo.com>, Daniel Axtens
 <dja@axtens.net>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>
References: <cover.1549935247.git.christophe.leroy@c-s.fr>
 <3429fe33b68206ecc2a725a740937bbaef2d1ac8.1549935251.git.christophe.leroy@c-s.fr>
 <8736oq3u2r.fsf@dja-thinkpad.axtens.net>
 <b5db7714-51e3-785c-34ca-6c358661c9e8@c-s.fr>
 <e43e21c2-f42c-bab3-c112-2a557f3de5b1@virtuozzo.com>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Message-ID: <cd942662-2e93-ca93-915f-c9f346317535@c-s.fr>
Date: Fri, 15 Feb 2019 11:10:39 +0100
User-Agent: Mozilla/5.0 (Windows NT 6.1; WOW64; rv:60.0) Gecko/20100101
 Thunderbird/60.5.0
MIME-Version: 1.0
In-Reply-To: <e43e21c2-f42c-bab3-c112-2a557f3de5b1@virtuozzo.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: fr
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



Le 15/02/2019 à 11:01, Andrey Ryabinin a écrit :
> 
> 
> On 2/15/19 11:41 AM, Christophe Leroy wrote:
>>
>>
>> Le 14/02/2019 à 23:04, Daniel Axtens a écrit :
>>> Hi Christophe,
>>>
>>>> --- a/arch/powerpc/include/asm/string.h
>>>> +++ b/arch/powerpc/include/asm/string.h
>>>> @@ -27,6 +27,20 @@ extern int memcmp(const void *,const void *,__kernel_size_t);
>>>>    extern void * memchr(const void *,int,__kernel_size_t);
>>>>    extern void * memcpy_flushcache(void *,const void *,__kernel_size_t);
>>>>    +void *__memset(void *s, int c, __kernel_size_t count);
>>>> +void *__memcpy(void *to, const void *from, __kernel_size_t n);
>>>> +void *__memmove(void *to, const void *from, __kernel_size_t n);
>>>> +
>>>> +#if defined(CONFIG_KASAN) && !defined(__SANITIZE_ADDRESS__)
>>>> +/*
>>>> + * For files that are not instrumented (e.g. mm/slub.c) we
>>>> + * should use not instrumented version of mem* functions.
>>>> + */
>>>> +#define memcpy(dst, src, len) __memcpy(dst, src, len)
>>>> +#define memmove(dst, src, len) __memmove(dst, src, len)
>>>> +#define memset(s, c, n) __memset(s, c, n)
>>>> +#endif
>>>> +
>>>
>>> I'm finding that I miss tests like 'kasan test: kasan_memcmp
>>> out-of-bounds in memcmp' because the uninstrumented asm version is used
>>> instead of an instrumented C version. I ended up guarding the relevant
>>> __HAVE_ARCH_x symbols behind a #ifndef CONFIG_KASAN and only exporting
>>> the arch versions if we're not compiled with KASAN.
>>>
>>> I find I need to guard and unexport strncpy, strncmp, memchr and
>>> memcmp. Do you need to do this on 32bit as well, or are those tests
>>> passing anyway for some reason?
>>
>> Indeed, I didn't try the KASAN test module recently, because my configs don't have CONFIG_MODULE by default.
>>
>> Trying to test it now, I am discovering that module loading oopses with latest version of my series, I need to figure out exactly why. Here below the oops by modprobing test_module (the one supposed to just say hello to the world).
>>
>> What we see is an access to the RO kasan zero area.
>>
>> The shadow mem is 0xf7c00000..0xffc00000
>> Linear kernel memory is shadowed by 0xf7c00000-0xf8bfffff
>> 0xf8c00000-0xffc00000 is shadowed read only by the kasan zero page.
>>
>> Why is kasan trying to access that ? Isn't kasan supposed to not check stuff in vmalloc area ?
> 
> It tries to poison global variables in modules. If module is in vmalloc, than it will try to poison vmalloc.
> Given that the vmalloc area is not so big on 32bits, the easiest solution is to cover all vmalloc with RW shadow.
> 

Euh ... Not so big ?

Memory: 96448K/131072K available (8016K kernel code, 1680K rwdata
, 2720K rodata, 624K init, 4678K bss, 34624K reserved, 0K cma-reserved)
Kernel virtual memory layout:
   * 0xffefc000..0xffffc000  : fixmap
   * 0xf7c00000..0xffc00000  : kasan shadow mem
   * 0xf7a00000..0xf7c00000  : consistent mem
   * 0xf7a00000..0xf7a00000  : early ioremap
   * 0xc9000000..0xf7a00000  : vmalloc & ioremap

Here, vmalloc area size 0x2ea00000, that is 746Mbytes. Shadow for this 
would be 93Mbytes and we are already using 16Mbytes to shadow the linear 
memory area .... this poor board has 128Mbytes RAM in total.

So another solution is needed.

Christophe
