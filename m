Return-Path: <SRS0=JJ8i=RB=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8992EC43381
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 05:14:18 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id AA37920851
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 05:14:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="e55m6nKW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org AA37920851
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 447n6b2ZndzDqQJ
	for <linuxppc-dev@archiver.kernel.org>; Tue, 26 Feb 2019 16:14:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=axtens.net
 (client-ip=2607:f8b0:4864:20::444; helo=mail-pf1-x444.google.com;
 envelope-from=dja@axtens.net; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.b="e55m6nKW"; 
 dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 447n4k5NlmzDqJQ
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2019 16:12:36 +1100 (AEDT)
Received: by mail-pf1-x444.google.com with SMTP id n125so5633986pfn.5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 25 Feb 2019 21:12:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=jP7E96nDoS9qSn8Kxb3Jp/bLxbA/jS+6WHNjYKFaHjE=;
 b=e55m6nKW/IQe++VEbFmJ3PdWMLlNZdt+OvmM+JvnjNi4qDJ0NM71riTgrciXkTr2/d
 XOyow++bPK333G+xGQ94OB3Mpc36jFTiBk1xLUyrNHdd+jxuz4xyhsKq24yIKGDXgYyw
 HJmDnxCSixGHOTPu7P25HX5DZEjJXzAyHMzG0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=jP7E96nDoS9qSn8Kxb3Jp/bLxbA/jS+6WHNjYKFaHjE=;
 b=dbidxVYnRU8aPGWDryLNaDIb83CPUd+3lXMCHPiQZiupmULAtRJMiH9SjFFtdyGl6H
 KF7A+ZuCXmtBssqoLxJywEQq9Hc5SgbYqR9DO3cccXJH7kgM7R4Njjtm+zASu8DItCHA
 Yi/CZ0YKoS3IcnBS7DOimYRp+opIBKRdQe+Myc2mgwSmAbnFqQ3iPvF1soL5ZUfGwtnY
 JM58eb5LfBDDYH3WbNKhoENSmEkmD6INCT0WF8s1hLXOVZve4YuM96Z+ZoXMKvLkto7E
 ZnQ/Z53PVT4ZLIQOASMTmd/f2Kh27i6Rt7PsgwcbvPqJRXoTpFRLQW/rG0TKFvZaOAxL
 hzBg==
X-Gm-Message-State: AHQUAuZnOyDcw3sNDXGo7vwWu9b1Ty8mLd5CHE056DIlmenWEg8Mn5QW
 Sxw6FmM7vm44R1V4B2Mk+sLQSQ==
X-Google-Smtp-Source: AHgI3IaSLGOpU22EpGz/ie7BujSE7kSVELONx0Juwd5c5vPPZ5pv3S8o7D4lS8F/xPSn7sZWKZdL1w==
X-Received: by 2002:a63:354a:: with SMTP id c71mr22981364pga.150.1551157953041; 
 Mon, 25 Feb 2019 21:12:33 -0800 (PST)
Received: from localhost (124-171-134-245.dyn.iinet.net.au. [124.171.134.245])
 by smtp.gmail.com with ESMTPSA id
 d5sm16233714pfo.83.2019.02.25.21.12.31
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Mon, 25 Feb 2019 21:12:32 -0800 (PST)
From: Daniel Axtens <dja@axtens.net>
To: Christophe Leroy <christophe.leroy@c-s.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 Andrey Ryabinin <aryabinin@virtuozzo.com>,
 Alexander Potapenko <glider@google.com>, Dmitry Vyukov <dvyukov@google.com>
Subject: Re: [PATCH v7 07/11] powerpc/32: prepare shadow area for KASAN
In-Reply-To: <bada5c0051f749565d27da9527ce933aa205bf86.1551098214.git.christophe.leroy@c-s.fr>
References: <cover.1551098214.git.christophe.leroy@c-s.fr>
 <bada5c0051f749565d27da9527ce933aa205bf86.1551098214.git.christophe.leroy@c-s.fr>
Date: Tue, 26 Feb 2019 16:12:29 +1100
Message-ID: <87a7ij2kw2.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain
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

Christophe Leroy <christophe.leroy@c-s.fr> writes:

> This patch prepares a shadow area for KASAN.
>
> The shadow area will be at the top of the kernel virtual
> memory space above the fixmap area and will occupy one
> eighth of the total kernel virtual memory space.
>
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/Kconfig              |  5 +++++
>  arch/powerpc/include/asm/fixmap.h |  5 +++++
>  arch/powerpc/include/asm/kasan.h  | 17 +++++++++++++++++
>  arch/powerpc/mm/mem.c             |  4 ++++
>  arch/powerpc/mm/ptdump/ptdump.c   |  8 ++++++++
>  5 files changed, 39 insertions(+)
>
> diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
> index 652c25260838..f446e016f4a1 100644
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -382,6 +382,11 @@ config PGTABLE_LEVELS
>  	default 3 if PPC_64K_PAGES && !PPC_BOOK3S_64
>  	default 4
>  
> +config KASAN_SHADOW_OFFSET
> +	hex
> +	depends on KASAN
> +	default 0xe0000000
> +

Should this live in Kconfig.debug?

Regards,
Daniel

>  source "arch/powerpc/sysdev/Kconfig"
>  source "arch/powerpc/platforms/Kconfig"
>  
> diff --git a/arch/powerpc/include/asm/fixmap.h b/arch/powerpc/include/asm/fixmap.h
> index b9fbed84ddca..51a1a309c919 100644
> --- a/arch/powerpc/include/asm/fixmap.h
> +++ b/arch/powerpc/include/asm/fixmap.h
> @@ -22,7 +22,12 @@
>  #include <asm/kmap_types.h>
>  #endif
>  
> +#ifdef CONFIG_KASAN
> +#include <asm/kasan.h>
> +#define FIXADDR_TOP	KASAN_SHADOW_START
> +#else
>  #define FIXADDR_TOP	((unsigned long)(-PAGE_SIZE))
> +#endif
>  
>  /*
>   * Here we define all the compile-time 'special' virtual
> diff --git a/arch/powerpc/include/asm/kasan.h b/arch/powerpc/include/asm/kasan.h
> index 2efd0e42cfc9..b554d3bd3e2c 100644
> --- a/arch/powerpc/include/asm/kasan.h
> +++ b/arch/powerpc/include/asm/kasan.h
> @@ -12,4 +12,21 @@
>  #define EXPORT_SYMBOL_KASAN(fn)	EXPORT_SYMBOL(fn)
>  #endif
>  
> +#ifndef __ASSEMBLY__
> +
> +#include <asm/page.h>
> +#include <asm/pgtable-types.h>
> +
> +#define KASAN_SHADOW_SCALE_SHIFT	3
> +
> +#define KASAN_SHADOW_OFFSET	ASM_CONST(CONFIG_KASAN_SHADOW_OFFSET)
> +
> +#define KASAN_SHADOW_START	(KASAN_SHADOW_OFFSET + \
> +				 (PAGE_OFFSET >> KASAN_SHADOW_SCALE_SHIFT))
> +
> +#define KASAN_SHADOW_END	0UL
> +
> +#define KASAN_SHADOW_SIZE	(KASAN_SHADOW_END - KASAN_SHADOW_START)
> +
> +#endif /* __ASSEMBLY */
>  #endif
> diff --git a/arch/powerpc/mm/mem.c b/arch/powerpc/mm/mem.c
> index f6787f90e158..4e7fa4eb2dd3 100644
> --- a/arch/powerpc/mm/mem.c
> +++ b/arch/powerpc/mm/mem.c
> @@ -309,6 +309,10 @@ void __init mem_init(void)
>  	mem_init_print_info(NULL);
>  #ifdef CONFIG_PPC32
>  	pr_info("Kernel virtual memory layout:\n");
> +#ifdef CONFIG_KASAN
> +	pr_info("  * 0x%08lx..0x%08lx  : kasan shadow mem\n",
> +		KASAN_SHADOW_START, KASAN_SHADOW_END);
> +#endif
>  	pr_info("  * 0x%08lx..0x%08lx  : fixmap\n", FIXADDR_START, FIXADDR_TOP);
>  #ifdef CONFIG_HIGHMEM
>  	pr_info("  * 0x%08lx..0x%08lx  : highmem PTEs\n",
> diff --git a/arch/powerpc/mm/ptdump/ptdump.c b/arch/powerpc/mm/ptdump/ptdump.c
> index 37138428ab55..812ed680024f 100644
> --- a/arch/powerpc/mm/ptdump/ptdump.c
> +++ b/arch/powerpc/mm/ptdump/ptdump.c
> @@ -101,6 +101,10 @@ static struct addr_marker address_markers[] = {
>  	{ 0,	"Fixmap start" },
>  	{ 0,	"Fixmap end" },
>  #endif
> +#ifdef CONFIG_KASAN
> +	{ 0,	"kasan shadow mem start" },
> +	{ 0,	"kasan shadow mem end" },
> +#endif
>  	{ -1,	NULL },
>  };
>  
> @@ -322,6 +326,10 @@ static void populate_markers(void)
>  #endif
>  	address_markers[i++].start_address = FIXADDR_START;
>  	address_markers[i++].start_address = FIXADDR_TOP;
> +#ifdef CONFIG_KASAN
> +	address_markers[i++].start_address = KASAN_SHADOW_START;
> +	address_markers[i++].start_address = KASAN_SHADOW_END;
> +#endif
>  #endif /* CONFIG_PPC64 */
>  }
>  
> -- 
> 2.13.3
