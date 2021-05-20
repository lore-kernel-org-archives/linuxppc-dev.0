Return-Path: <SRS0=6/er=KP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLACK,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA4BBC433ED
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 05:54:38 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 26BFA600CD
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 05:54:38 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 26BFA600CD
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ozlabs.ru
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4FlzTS51sQz3bsC
	for <linuxppc-dev@archiver.kernel.org>; Thu, 20 May 2021 15:54:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com header.i=@ozlabs-ru.20150623.gappssmtp.com header.a=rsa-sha256 header.s=20150623 header.b=rZjq2Bfy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=ozlabs.ru (client-ip=2607:f8b0:4864:20::42b;
 helo=mail-pf1-x42b.google.com; envelope-from=aik@ozlabs.ru;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=ozlabs-ru.20150623.gappssmtp.com
 header.i=@ozlabs-ru.20150623.gappssmtp.com header.a=rsa-sha256
 header.s=20150623 header.b=rZjq2Bfy; dkim-atps=neutral
Received: from mail-pf1-x42b.google.com (mail-pf1-x42b.google.com
 [IPv6:2607:f8b0:4864:20::42b])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4FlzSy2rbCz2xfw
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 May 2021 15:54:07 +1000 (AEST)
Received: by mail-pf1-x42b.google.com with SMTP id g18so9892463pfr.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 19 May 2021 22:54:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=ozlabs-ru.20150623.gappssmtp.com; s=20150623;
 h=message-id:date:mime-version:user-agent:subject:content-language:to
 :cc:references:from:in-reply-to:content-transfer-encoding;
 bh=nn4C4WfDFyQrAY0FjKx9ASqecq4iY3YBFSKNHm7Kxus=;
 b=rZjq2BfyGbNocTutDXo8xiiqDUuzzd3nvY3YxbrZLvqC7ykfW9V88EgDrL/t0qheZl
 MiQKvotk1SyjT+L1/WwZ0/L0PmvIMSjvS4Hs8ADVMc7r7Kz0hlJiCYS9N18Fff0I9ZDC
 +DvZRjUvkXdhgzd257pjfGKTNWaxlDiQ1KiTfeBNk4vBkUpcr4doXLGC+Eawzu5WWL11
 9eul0Ao9RLo32ILYxQS/JJMlGHWhTs8QSoJ/x8JiZ9XNPZRYbmdc+pmlRjyHX7+UaLIq
 Wcm2YWkq0j75vcK4e5gKnYbElIzUwH6ZuVHCrSfJSb5Cjp+E24W/1v2eC6K6Z+nHoBjv
 SzsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
 :content-language:to:cc:references:from:in-reply-to
 :content-transfer-encoding;
 bh=nn4C4WfDFyQrAY0FjKx9ASqecq4iY3YBFSKNHm7Kxus=;
 b=VNbXkcIptZ9kHtBxCbm8glM1j6bLr5KoHtlIPBo9AgEUzfoPEQRc+wPLrHOXijJuTy
 bxVIfE5gsLRmKT1Uj0SJXsDF6nE8BuTQDu1wqKfgSf+HygqoavNtYeg22/VBO2q06IaD
 Y2dykN2K+onE2sQkkyFODWJntdxd29AhKIdgEd7JSIZf1VS6jKKPDGfnasvwB8hBD6qx
 y8RT+yCiLKxQAq/NOPSeTnZPMi0GX2i4V3kZmpP1A0EvmbulOXEfCgaoHVJA3YaEchop
 0dMbVPea9aQI+CtDrRpJEqRJaC24MB3TvKzUMkkKctbOt8lQIIEn9dNpUw8lNtoBpYz+
 rRGA==
X-Gm-Message-State: AOAM531LnqjszsxNQxZsnT+t78Kc9d8we58PNS+IOYbIvfY8tUs+CPGL
 /zpRAaMyuogAg2A0FJpIsqfisgxMjL3Ic2Ob
X-Google-Smtp-Source: ABdhPJxzYOMihNh4OusQ5btOL1lNgd9olAB8XI4BlkB17wjT3HANfqmJiMHXA7TsUC5YhcIEyLNVQg==
X-Received: by 2002:a63:7c57:: with SMTP id l23mr2822036pgn.429.1621490045431; 
 Wed, 19 May 2021 22:54:05 -0700 (PDT)
Received: from [192.168.10.23]
 (ppp121-45-194-51.cbr-trn-nor-bras38.tpg.internode.on.net. [121.45.194.51])
 by smtp.gmail.com with UTF8SMTPSA id g13sm959224pfr.75.2021.05.19.22.54.03
 (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
 Wed, 19 May 2021 22:54:05 -0700 (PDT)
Message-ID: <db846a8e-bc75-244f-5e4a-513e762a875f@ozlabs.ru>
Date: Thu, 20 May 2021 15:52:38 +1000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:89.0) Gecko/20100101
 Thunderbird/89.0
Subject: Re: [RFC PATCH kernel] powerpc: Fix early setup to make early_ioremap
 work
Content-Language: en-US
To: Christophe Leroy <christophe.leroy@csgroup.eu>,
 linuxppc-dev@lists.ozlabs.org
References: <20210520032919.358935-1-aik@ozlabs.ru>
 <467a5a5f-7fab-b6b1-e81f-85518378f4b8@csgroup.eu>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
In-Reply-To: <467a5a5f-7fab-b6b1-e81f-85518378f4b8@csgroup.eu>
Content-Type: text/plain; charset=UTF-8; format=flowed
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
Cc: Chris Packham <chris.packham@alliedtelesis.co.nz>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>



On 20/05/2021 15:46, Christophe Leroy wrote:
> 
> 
> Le 20/05/2021 à 05:29, Alexey Kardashevskiy a écrit :
>> The immediate problem is that after
>> 0bd3f9e953bd ("powerpc/legacy_serial: Use early_ioremap()")
>> the kernel silently reboots. The reason is that early_ioremap() returns
>> broken addresses as it uses slot_virt[] array which initialized with
>> offsets from FIXADDR_TOP == IOREMAP_END+FIXADDR_SIZE ==
>> KERN_IO_END- FIXADDR_SIZ + FIXADDR_SIZE == __kernel_io_end which is 0
>> when early_ioremap_setup() is called. __kernel_io_end is initialized
>> little bit later in early_init_mmu().
>>
>> This fixes the initialization by swapping early_ioremap_setup and
>> early_init_mmu.
> 
> Hum ... Chris tested it on a T2080RDB, that must be a book3e.
> 
> So we missed it. I guess your fix is right.


Oh cool.

>>
>> This also fixes IOREMAP_END to use FIXADDR_SIZE defined just next to it,
>> seems to make sense, unless there is some weird logic with redefining
>> FIXADDR_SIZE as the compiling goes.
> 
> Well, I don't think the order of defines matters, the change should be 
> kept out of the fix.

When I see this:

#define IOREMAP_END    (KERN_IO_END - FIXADDR_SIZE)
#define FIXADDR_SIZE    SZ_32M


... I have to think harder what FIXADDR_SIZE was in the first macro and 
in what order the preprocessor expands them.


> But if you want it anyway, then I'd suggest to move it before 
> IOREMAP_BASE in order to keep the 3 IOREMAP_xxx together.

Up to Michael, I guess.


> 
>>
>> Signed-off-by: Alexey Kardashevskiy <aik@ozlabs.ru>
> 
> Reviewed-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> 
>> ---
>>   arch/powerpc/include/asm/book3s/64/pgtable.h | 2 +-
>>   arch/powerpc/kernel/setup_64.c               | 3 ++-
>>   2 files changed, 3 insertions(+), 2 deletions(-)
>>
>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h 
>> b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> index a666d561b44d..54a06129794b 100644
>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> @@ -325,8 +325,8 @@ extern unsigned long pci_io_base;
>>   #define  PHB_IO_END    (KERN_IO_START + FULL_IO_SIZE)
>>   #define IOREMAP_BASE    (PHB_IO_END)
>>   #define IOREMAP_START    (ioremap_bot)
>> -#define IOREMAP_END    (KERN_IO_END - FIXADDR_SIZE)
>>   #define FIXADDR_SIZE    SZ_32M
>> +#define IOREMAP_END    (KERN_IO_END - FIXADDR_SIZE)
>>   /* Advertise special mapping type for AGP */
>>   #define HAVE_PAGE_AGP
>> diff --git a/arch/powerpc/kernel/setup_64.c 
>> b/arch/powerpc/kernel/setup_64.c
>> index b779d25761cf..ce09fe5debf4 100644
>> --- a/arch/powerpc/kernel/setup_64.c
>> +++ b/arch/powerpc/kernel/setup_64.c
>> @@ -369,11 +369,12 @@ void __init early_setup(unsigned long dt_ptr)
>>       apply_feature_fixups();
>>       setup_feature_keys();
>> -    early_ioremap_setup();
>>       /* Initialize the hash table or TLB handling */
>>       early_init_mmu();
>> +    early_ioremap_setup();
>> +
>>       /*
>>        * After firmware and early platform setup code has set things up,
>>        * we note the SPR values for configurable control/performance
>>

-- 
Alexey
