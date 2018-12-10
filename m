Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E26DEC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 20:00:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 5ACE120821
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 20:00:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=linaro.org header.i=@linaro.org header.b="BBiCVq/u"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 5ACE120821
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=linaro.org
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43DDSw4xS3zDqpL
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 07:00:16 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (1024-bit key; unprotected) header.d=linaro.org header.i=@linaro.org header.b="BBiCVq/u";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=linaro.org
 (client-ip=2607:f8b0:4864:20::742; helo=mail-qk1-x742.google.com;
 envelope-from=rafael.tinoco@linaro.org; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=linaro.org
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=linaro.org header.i=@linaro.org header.b="BBiCVq/u"; 
 dkim-atps=neutral
Received: from mail-qk1-x742.google.com (mail-qk1-x742.google.com
 [IPv6:2607:f8b0:4864:20::742])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43D8Cq6HFGzDqkm
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 03:48:39 +1100 (AEDT)
Received: by mail-qk1-x742.google.com with SMTP id r71so6844969qkr.10
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 08:48:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linaro.org; s=google;
 h=cc:subject:to:references:from:organization:message-id:date
 :user-agent:mime-version:in-reply-to:content-language
 :content-transfer-encoding;
 bh=jIu/NQdLrU30oMjYFo1Dv8/5GvUAOK5LaTrL/MaVmCg=;
 b=BBiCVq/uyLE8Mcbj3/85rQLeTaF8vub5hoz5Kc5iSMv1QCR16Ef7AVjcegACWoNq2f
 b9FdakseRmRV12Sg5KE2z2Tgr+3eYXlQss/vCtI7sbVB6qPTTYbOmgUDuEDF3HntoBcd
 UQljs+6XDQ2PKvNkHy2raDh7Bhs4JA8gCN9E4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:cc:subject:to:references:from:organization
 :message-id:date:user-agent:mime-version:in-reply-to
 :content-language:content-transfer-encoding;
 bh=jIu/NQdLrU30oMjYFo1Dv8/5GvUAOK5LaTrL/MaVmCg=;
 b=Oe7QGtz+S+GKmpbMpQSnAo273UsITzKhIEonzwzvz4WhDA8B9yYvrro7B2GAQ+l/2u
 6bqfUt9hfxwNO5Pgmrte9ZgwDRf1Ru5yjdiTVjxriYctzKdzX/E8b1NZZjuGlhi31WfT
 3A3hSPl12axUCBYZyMoXHlhLacNagESR1rXUS5+qc/D3/mQZwJyZZwx52oaytqbKSXA/
 przs4COeNgwLIFzer07xy7qEz21kxJFk5brBO9Cg8DOUqeJT8iupHOwJ6nEi5PJsnelS
 UgdImawnR3NiLGSOQNw3Tts1lghm6BAle7sPQLskN8OMzBCZBiq6MSySfufDeWgdgoDU
 mIzg==
X-Gm-Message-State: AA+aEWah21fKpS80+TSe0dMiMydlhzv3eLSA12Tc5ikGaUb3UpiL5gLi
 zjAWO1k93htwAy0ESBaEhOgitw==
X-Google-Smtp-Source: AFSGD/VfFUo4Nn/T94zhYEFli0jTOMHkAuEvRfT+ju+BCOJQSu7CmgpI09H1hfGJ0mz5hl9C98/w6Q==
X-Received: by 2002:a37:1f44:: with SMTP id f65mr11166603qkf.33.1544460517260; 
 Mon, 10 Dec 2018 08:48:37 -0800 (PST)
Received: from [192.168.49.18] ([138.204.25.7])
 by smtp.gmail.com with ESMTPSA id l15sm6158986qtr.25.2018.12.10.08.48.27
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 08:48:36 -0800 (PST)
Subject: Re: [PATCH] mm/zsmalloc.c: Fix zsmalloc 32-bit PAE support
To: "Kirill A. Shutemov" <kirill@shutemov.name>
References: <20181210142105.6750-1-rafael.tinoco@linaro.org>
 <20181210151506.phyjkfcg3skogtyh@kshutemo-mobl1>
From: Rafael David Tinoco <rafael.tinoco@linaro.org>
Organization: Linaro
Message-ID: <32747ea1-7437-8055-a4f5-9f22378e57ae@linaro.org>
Date: Mon, 10 Dec 2018 14:48:25 -0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.3.1
MIME-Version: 1.0
In-Reply-To: <20181210151506.phyjkfcg3skogtyh@kshutemo-mobl1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Mailman-Approved-At: Tue, 11 Dec 2018 06:55:18 +1100
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
Cc: Rich Felker <dalias@libc.org>, linux-ia64@vger.kernel.org,
 Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
 linux-sh@vger.kernel.org, Catalin Marinas <catalin.marinas@arm.com>,
 Heiko Carstens <heiko.carstens@de.ibm.com>, Ram Pai <linuxram@us.ibm.com>,
 linux-mips@vger.kernel.org, linux-mm@kvack.org,
 Khalid Aziz <khalid.aziz@oracle.com>, Paul Mackerras <paulus@samba.org>,
 "H . Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, James Hogan <jhogan@kernel.org>,
 Anthony Yznaga <anthony.yznaga@oracle.com>, Nitin Gupta <ngupta@vflare.org>,
 Fenghua Yu <fenghua.yu@intel.com>, Joerg Roedel <jroedel@suse.de>,
 Rafael David Tinoco <rafael.tinoco@linaro.org>,
 Juergen Gross <jgross@suse.com>, Vasily Gorbik <gor@linux.ibm.com>,
 Will Deacon <will.deacon@arm.com>, Nicholas Piggin <npiggin@gmail.com>,
 Borislav Petkov <bp@alien8.de>, Andy Lutomirski <luto@kernel.org>,
 Thomas Gleixner <tglx@linutronix.de>, linux-arm-kernel@lists.infradead.org,
 Tony Luck <tony.luck@intel.com>, Jiri Kosina <jkosina@suse.cz>,
 linux-kernel@vger.kernel.org, Ralf Baechle <ralf@linux-mips.org>,
 Minchan Kim <minchan@kernel.org>, Paul Burton <paul.burton@mips.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On 12/10/18 1:15 PM, Kirill A. Shutemov wrote:
> On Mon, Dec 10, 2018 at 12:21:05PM -0200, Rafael David Tinoco wrote:
>> diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
>> index 84bd9bdc1987..d808cfde3d19 100644
>> --- a/arch/x86/include/asm/pgtable_64_types.h
>> +++ b/arch/x86/include/asm/pgtable_64_types.h
>> @@ -64,8 +64,6 @@ extern unsigned int ptrs_per_p4d;
>>  #define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
>>  #define P4D_MASK		(~(P4D_SIZE - 1))
>>  
>> -#define MAX_POSSIBLE_PHYSMEM_BITS	52
>> -
>>  #else /* CONFIG_X86_5LEVEL */
>>  
>>  /*
>> @@ -154,4 +152,6 @@ extern unsigned int ptrs_per_p4d;
>>  
>>  #define PGD_KERNEL_START	((PAGE_SIZE / 2) / sizeof(pgd_t))
>>  
>> +#define MAX_POSSIBLE_PHYSMEM_BITS (pgtable_l5_enabled() ? 52 : 46)
>> +
> 
> ...
> 
>>  #endif /* _ASM_X86_PGTABLE_64_DEFS_H */
>> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
>> index 0787d33b80d8..132c20b6fd4f 100644
>> --- a/mm/zsmalloc.c
>> +++ b/mm/zsmalloc.c
> 
> ...
> 
>> @@ -116,6 +100,25 @@
>>   */
>>  #define OBJ_ALLOCATED_TAG 1
>>  #define OBJ_TAG_BITS 1
>> +
>> +/*
>> + * MAX_POSSIBLE_PHYSMEM_BITS should be defined by all archs using zsmalloc:
>> + * Trying to guess it from MAX_PHYSMEM_BITS, or considering it BITS_PER_LONG,
>> + * proved to be wrong by not considering PAE capabilities, or using SPARSEMEM
>> + * only headers, leading to bad object encoding due to object index overflow.
>> + */
>> +#ifndef MAX_POSSIBLE_PHYSMEM_BITS
>> + #define MAX_POSSIBLE_PHYSMEM_BITS BITS_PER_LONG
>> + #error "MAX_POSSIBLE_PHYSMEM_BITS HAS to be defined by arch using zsmalloc";
>> +#else
>> + #ifndef CONFIG_64BIT
>> +  #if (MAX_POSSIBLE_PHYSMEM_BITS >= (BITS_PER_LONG + PAGE_SHIFT - OBJ_TAG_BITS))
>> +   #error "MAX_POSSIBLE_PHYSMEM_BITS is wrong for this arch";
>> +  #endif
>> + #endif
>> +#endif
>> +
>> +#define _PFN_BITS (MAX_POSSIBLE_PHYSMEM_BITS - PAGE_SHIFT)
>>  #define OBJ_INDEX_BITS	(BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
>>  #define OBJ_INDEX_MASK	((_AC(1, UL) << OBJ_INDEX_BITS) - 1)
> 
> Have you tested it with CONFIG_X86_5LEVEL=y?
> 
> ASAICS, the patch makes OBJ_INDEX_BITS and what depends from it dynamic --
> it depends what paging mode we are booting in. ZS_SIZE_CLASSES depends
> indirectly on OBJ_INDEX_BITS and I don't see how struct zs_pool definition
> can compile with dynamic ZS_SIZE_CLASSES.
> 
> Hm?
> 

You're right, terribly sorry. This was a last time change.

mm/zsmalloc.c:256:21: error: variably modified ‘size_class’ at file scope

I'll revisit the patch. Any other comments are welcome.

Thank you

