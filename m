Return-Path: <SRS0=HYLD=OT=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.7 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_PASS,
	USER_AGENT_NEOMUTT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3C3AC04EB8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 15:18:19 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 4D6CE20855
	for <linuxppc-dev@archiver.kernel.org>; Mon, 10 Dec 2018 15:18:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="rOY8UICN"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 4D6CE20855
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43D6CY4Z0nzDqtp
	for <linuxppc-dev@archiver.kernel.org>; Tue, 11 Dec 2018 02:18:17 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="rOY8UICN";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=none (mailfrom) smtp.mailfrom=shutemov.name
 (client-ip=2a00:1450:4864:20::144; helo=mail-lf1-x144.google.com;
 envelope-from=kirill@shutemov.name; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=shutemov.name
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=shutemov-name.20150623.gappssmtp.com
 header.i=@shutemov-name.20150623.gappssmtp.com header.b="rOY8UICN"; 
 dkim-atps=neutral
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com
 [IPv6:2a00:1450:4864:20::144])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43D68364rwzDqwn
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Dec 2018 02:15:12 +1100 (AEDT)
Received: by mail-lf1-x144.google.com with SMTP id p86so8247897lfg.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 10 Dec 2018 07:15:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=shutemov-name.20150623.gappssmtp.com; s=20150623;
 h=date:from:to:cc:subject:message-id:references:mime-version
 :content-disposition:in-reply-to:user-agent;
 bh=E5xm7eH52Fy6OJNbIJDutqhE46UBtijO2dHJCxBrof4=;
 b=rOY8UICNhwgenMQ974wdzmyfQp3RMk4pfA4G90T6YXz4bNiCBoITjKkVPjP8oMcCON
 uHUOoz0prTIV9VETT8vOEQqGkwYD3k7h8BC0YPUSjIa51YDC02AJdYRompscCVlPIq5a
 0DIZdEI1azzblOZp1L+ueNUczetC6OH4t/4JjOSECJ83RzrKi8ighmib2MFtofFZHY/y
 yAShWskIH8VJgeH6RnKnCMlZ4c7cYrMzJYLscx2WUl4nXZy4600eOfuD63Swyx7UL2bp
 khabEgtpfrDVZAFhikxK7/cDnuHIXoi6vwJYKriH+XcnLaTgnA7m3vvf5XDgt70EHnbU
 lMoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:references
 :mime-version:content-disposition:in-reply-to:user-agent;
 bh=E5xm7eH52Fy6OJNbIJDutqhE46UBtijO2dHJCxBrof4=;
 b=bgdECYhBuEkW/6j7ogY2IyYalmzu/KoWCl9X15n6qSprE02gx0reRSb470rYtKOIeX
 d5gJFpeV+gt/yp3WanUp02EPDPaqKzA/y7KYLVHvgQ1krohbJZ7JLNEX4QTqoWq3TJTx
 Ghbkd6v6JhccEJG+Ma0pGB9fgygP+fiTqNLJhLtGR3wYcK81QAyqvQY0BosJtlNhcRpO
 OQdXkJPIqdBowNg2ujJq3PO8ttDyf932dheHyNVeLUf+jlFtlMMPjKgtazH1Bi5hkX44
 4rKO8DdPLvKzDALqS0OlyfMznS9RIDnroPdyg90NOCFN5hzSU1Ec2f+sqxl5RgEoqhow
 n2lw==
X-Gm-Message-State: AA+aEWZ2MSVMPAdLu29ic10hmn4qjTXA55yGlEhibz8DxYX+ok5SVd2U
 s18diztjXkkPw+2lvOKUBvNENg==
X-Google-Smtp-Source: AFSGD/X7lJuM1kAIPu8kAyzpO2/5GH0DL/7RY2tdW0r70cn17ZYoIEjBj5YaEZKPstRbOKVPX/N/ag==
X-Received: by 2002:a19:8fce:: with SMTP id s75mr6814620lfk.151.1544454909175; 
 Mon, 10 Dec 2018 07:15:09 -0800 (PST)
Received: from kshutemo-mobl1.localdomain
 (mm-113-209-122-178.mgts.dynamic.pppoe.byfly.by. [178.122.209.113])
 by smtp.gmail.com with ESMTPSA id b128sm2162380lfe.91.2018.12.10.07.15.08
 (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
 Mon, 10 Dec 2018 07:15:08 -0800 (PST)
Received: by kshutemo-mobl1.localdomain (Postfix, from userid 1000)
 id D049130155D; Mon, 10 Dec 2018 18:15:06 +0300 (+03)
Date: Mon, 10 Dec 2018 18:15:06 +0300
From: "Kirill A. Shutemov" <kirill@shutemov.name>
To: Rafael David Tinoco <rafael.tinoco@linaro.org>
Subject: Re: [PATCH] mm/zsmalloc.c: Fix zsmalloc 32-bit PAE support
Message-ID: <20181210151506.phyjkfcg3skogtyh@kshutemo-mobl1>
References: <20181210142105.6750-1-rafael.tinoco@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20181210142105.6750-1-rafael.tinoco@linaro.org>
User-Agent: NeoMutt/20180716
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
 linux-sh@vger.kernel.org, Heiko Carstens <heiko.carstens@de.ibm.com>,
 Ram Pai <linuxram@us.ibm.com>, linux-mips@vger.kernel.org, linux-mm@kvack.org,
 Khalid Aziz <khalid.aziz@oracle.com>, Paul Mackerras <paulus@samba.org>,
 "H . Peter Anvin" <hpa@zytor.com>, sparclinux@vger.kernel.org,
 linux-s390@vger.kernel.org, Yoshinori Sato <ysato@users.sourceforge.jp>,
 x86@kernel.org, Russell King <linux@armlinux.org.uk>,
 Ingo Molnar <mingo@redhat.com>, Catalin Marinas <catalin.marinas@arm.com>,
 James Hogan <jhogan@kernel.org>, Anthony Yznaga <anthony.yznaga@oracle.com>,
 Nitin Gupta <ngupta@vflare.org>, Fenghua Yu <fenghua.yu@intel.com>,
 Joerg Roedel <jroedel@suse.de>, Juergen Gross <jgross@suse.com>,
 Vasily Gorbik <gor@linux.ibm.com>, Will Deacon <will.deacon@arm.com>,
 Nicholas Piggin <npiggin@gmail.com>, Borislav Petkov <bp@alien8.de>,
 Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@linutronix.de>,
 linux-arm-kernel@lists.infradead.org, Tony Luck <tony.luck@intel.com>,
 Jiri Kosina <jkosina@suse.cz>, linux-kernel@vger.kernel.org,
 Ralf Baechle <ralf@linux-mips.org>, Minchan Kim <minchan@kernel.org>,
 Paul Burton <paul.burton@mips.com>,
 "Aneesh Kumar K . V" <aneesh.kumar@linux.ibm.com>,
 Martin Schwidefsky <schwidefsky@de.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 "David S . Miller" <davem@davemloft.net>,
 "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon, Dec 10, 2018 at 12:21:05PM -0200, Rafael David Tinoco wrote:
> diff --git a/arch/x86/include/asm/pgtable_64_types.h b/arch/x86/include/asm/pgtable_64_types.h
> index 84bd9bdc1987..d808cfde3d19 100644
> --- a/arch/x86/include/asm/pgtable_64_types.h
> +++ b/arch/x86/include/asm/pgtable_64_types.h
> @@ -64,8 +64,6 @@ extern unsigned int ptrs_per_p4d;
>  #define P4D_SIZE		(_AC(1, UL) << P4D_SHIFT)
>  #define P4D_MASK		(~(P4D_SIZE - 1))
>  
> -#define MAX_POSSIBLE_PHYSMEM_BITS	52
> -
>  #else /* CONFIG_X86_5LEVEL */
>  
>  /*
> @@ -154,4 +152,6 @@ extern unsigned int ptrs_per_p4d;
>  
>  #define PGD_KERNEL_START	((PAGE_SIZE / 2) / sizeof(pgd_t))
>  
> +#define MAX_POSSIBLE_PHYSMEM_BITS (pgtable_l5_enabled() ? 52 : 46)
> +

...

>  #endif /* _ASM_X86_PGTABLE_64_DEFS_H */
> diff --git a/mm/zsmalloc.c b/mm/zsmalloc.c
> index 0787d33b80d8..132c20b6fd4f 100644
> --- a/mm/zsmalloc.c
> +++ b/mm/zsmalloc.c

...

> @@ -116,6 +100,25 @@
>   */
>  #define OBJ_ALLOCATED_TAG 1
>  #define OBJ_TAG_BITS 1
> +
> +/*
> + * MAX_POSSIBLE_PHYSMEM_BITS should be defined by all archs using zsmalloc:
> + * Trying to guess it from MAX_PHYSMEM_BITS, or considering it BITS_PER_LONG,
> + * proved to be wrong by not considering PAE capabilities, or using SPARSEMEM
> + * only headers, leading to bad object encoding due to object index overflow.
> + */
> +#ifndef MAX_POSSIBLE_PHYSMEM_BITS
> + #define MAX_POSSIBLE_PHYSMEM_BITS BITS_PER_LONG
> + #error "MAX_POSSIBLE_PHYSMEM_BITS HAS to be defined by arch using zsmalloc";
> +#else
> + #ifndef CONFIG_64BIT
> +  #if (MAX_POSSIBLE_PHYSMEM_BITS >= (BITS_PER_LONG + PAGE_SHIFT - OBJ_TAG_BITS))
> +   #error "MAX_POSSIBLE_PHYSMEM_BITS is wrong for this arch";
> +  #endif
> + #endif
> +#endif
> +
> +#define _PFN_BITS (MAX_POSSIBLE_PHYSMEM_BITS - PAGE_SHIFT)
>  #define OBJ_INDEX_BITS	(BITS_PER_LONG - _PFN_BITS - OBJ_TAG_BITS)
>  #define OBJ_INDEX_MASK	((_AC(1, UL) << OBJ_INDEX_BITS) - 1)

Have you tested it with CONFIG_X86_5LEVEL=y?

ASAICS, the patch makes OBJ_INDEX_BITS and what depends from it dynamic --
it depends what paging mode we are booting in. ZS_SIZE_CLASSES depends
indirectly on OBJ_INDEX_BITS and I don't see how struct zs_pool definition
can compile with dynamic ZS_SIZE_CLASSES.

Hm?

-- 
 Kirill A. Shutemov
