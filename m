Return-Path: <SRS0=1oDC=MP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9AF6C00449
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 04:26:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 37B262064E
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 04:26:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="D4D0nSZW"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 37B262064E
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 42Q2ym6Tt7zF39h
	for <linuxppc-dev@archiver.kernel.org>; Wed,  3 Oct 2018 14:26:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.b="D4D0nSZW";
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::544; helo=mail-pg1-x544.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="D4D0nSZW"; 
 dkim-atps=neutral
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com
 [IPv6:2607:f8b0:4864:20::544])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42Q2w96zKVzF38F
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Oct 2018 14:24:09 +1000 (AEST)
Received: by mail-pg1-x544.google.com with SMTP id y18-v6so960310pge.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 02 Oct 2018 21:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=date:from:to:cc:subject:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=NZes71k05JZveThK4dwg4hJgdX3SYR4bz4d1tEH+vYI=;
 b=D4D0nSZWkPow1G7jNggVNveCypL4nQ8wYcTRqM8IeyDd8P1ktUN8E09OTO3rANmY+M
 QpNlRFdkBD6u+UIEtMp6OymS7z12hms+feWxdp2dYRj5cBhbkCl5MDFWiGEKmGgbojUk
 V9KnVO09+q208TvkUEn4UVMO1YIbnQY81L47VJCpdT4mDJbOQiXiVccRPUjax/j6b3RB
 op46mmCiW9HQQnjs+PaVJSvAErtyUg0Ws6Z3+SePudMOmNcdtux5LLoZYiDXg9dBQQGR
 zNuqOyBcp0I6rOmnkUsp/3HhsP7CuuCgxdaKJnBGXyrz11Z+2S1dNsavUqa58FuIXiUM
 q68g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:date:from:to:cc:subject:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=NZes71k05JZveThK4dwg4hJgdX3SYR4bz4d1tEH+vYI=;
 b=Jd/EyJSSsQE8jOjIsk6ErryjTszwzOrNxRr4IzF4StD7kBnp4wlK/XeL17jCymvLaO
 QahcJcYP+jcHZPx6wgY9rN6FqD5Cx65CwCq+orht7hDmrJQnxxxf2fRNcA/rtQsQnWts
 8LTcAAeRqQv28t/+NV7am6gUS0YNWDzTPkHs64LOn2YLB2VAhhOtkTRBNYbetdTm0elz
 2lMiHpLTr43n0JddsXoYhWbEg0OulqtX43aR5fpfBQ/wkhkJFbYKoZeRaZ00ddEbNQKU
 zgFrJ8zIVpr4bS/7PkRtqiUf/ttJOVbPsemlTIKkNEQHWLFLfZhyQ8PJ83RnThNmB/47
 22mw==
X-Gm-Message-State: ABuFfojsDWbyhFqS12mIRzrLm2iziQAr9KlS8fwv72rRhV6MOVNtrXCB
 LwSY1wSVZgrKlS/wqeAzWQ9hYKnE
X-Google-Smtp-Source: ACcGV61GN/ekaUMScFGFk0rYIX9ZacBiPKECbW5TqiwHtvv67yG4j6/vyPZKLMjwWfUAlSsGLDEllQ==
X-Received: by 2002:a62:c28a:: with SMTP id
 w10-v6mr3961412pfk.158.1538540647003; 
 Tue, 02 Oct 2018 21:24:07 -0700 (PDT)
Received: from roar.ozlabs.ibm.com (60-240-189-67.tpgi.com.au. [60.240.189.67])
 by smtp.gmail.com with ESMTPSA id h130-v6sm168291pgc.88.2018.10.02.21.24.03
 (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
 Tue, 02 Oct 2018 21:24:06 -0700 (PDT)
Date: Wed, 3 Oct 2018 14:24:00 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: Re: [RFC PATCH v3 1/7] book3s/64: avoid circular header inclusion
 in mmu-hash.h
Message-ID: <20181003142400.490fd38a@roar.ozlabs.ibm.com>
In-Reply-To: <c95148024873842459472bbcc0dd0e65607fd43b.1538396658.git.christophe.leroy@c-s.fr>
References: <cover.1538396658.git.christophe.leroy@c-s.fr>
 <c95148024873842459472bbcc0dd0e65607fd43b.1538396658.git.christophe.leroy@c-s.fr>
X-Mailer: Claws Mail 3.17.0 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
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
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 aneesh.kumar@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

On Mon,  1 Oct 2018 12:30:19 +0000 (UTC)
Christophe Leroy <christophe.leroy@c-s.fr> wrote:

> When activating CONFIG_THREAD_INFO_IN_TASK, linux/sched.h
> includes asm/current.h. This generates a circular dependency.
> To avoid that, asm/processor.h shall not be included in mmu-hash.h
> 
> In order to do that, this patch moves into a new header called
> asm/task_size.h the information from asm/processor.h requires by
> mmu-hash.h

Doesn't look like you use this header in 32-bit code. Put task_size.h
in asm/64/ maybe?

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>

> 
> Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
> ---
>  arch/powerpc/include/asm/book3s/64/mmu-hash.h |  2 +-
>  arch/powerpc/include/asm/processor.h          | 34 +---------------------
>  arch/powerpc/include/asm/task_size.h          | 42 +++++++++++++++++++++++++++
>  arch/powerpc/kvm/book3s_hv_hmi.c              |  1 +
>  4 files changed, 45 insertions(+), 34 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/task_size.h
> 
> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> index bbeaf6adf93c..7788e35f19f0 100644
> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
> @@ -23,7 +23,7 @@
>   */
>  #include <asm/book3s/64/pgtable.h>
>  #include <asm/bug.h>
> -#include <asm/processor.h>
> +#include <asm/task_size.h>
>  #include <asm/cpu_has_feature.h>
>  
>  /*
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index 350c584ca179..353879db3e98 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -101,40 +101,8 @@ void release_thread(struct task_struct *);
>  #endif
>  
>  #ifdef CONFIG_PPC64
> -/*
> - * 64-bit user address space can have multiple limits
> - * For now supported values are:
> - */
> -#define TASK_SIZE_64TB  (0x0000400000000000UL)
> -#define TASK_SIZE_128TB (0x0000800000000000UL)
> -#define TASK_SIZE_512TB (0x0002000000000000UL)
> -#define TASK_SIZE_1PB   (0x0004000000000000UL)
> -#define TASK_SIZE_2PB   (0x0008000000000000UL)
> -/*
> - * With 52 bits in the address we can support
> - * upto 4PB of range.
> - */
> -#define TASK_SIZE_4PB   (0x0010000000000000UL)
>  
> -/*
> - * For now 512TB is only supported with book3s and 64K linux page size.
> - */
> -#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_64K_PAGES)
> -/*
> - * Max value currently used:
> - */
> -#define TASK_SIZE_USER64		TASK_SIZE_4PB
> -#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_128TB
> -#define TASK_CONTEXT_SIZE		TASK_SIZE_512TB
> -#else
> -#define TASK_SIZE_USER64		TASK_SIZE_64TB
> -#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_64TB
> -/*
> - * We don't need to allocate extended context ids for 4K page size, because
> - * we limit the max effective address on this config to 64TB.
> - */
> -#define TASK_CONTEXT_SIZE		TASK_SIZE_64TB
> -#endif
> +#include <asm/task_size.h>
>  
>  /*
>   * 32-bit user address space is 4GB - 1 page
> diff --git a/arch/powerpc/include/asm/task_size.h b/arch/powerpc/include/asm/task_size.h
> new file mode 100644
> index 000000000000..ca45638617b0
> --- /dev/null
> +++ b/arch/powerpc/include/asm/task_size.h
> @@ -0,0 +1,42 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_TASK_SIZE_H
> +#define _ASM_POWERPC_TASK_SIZE_H
> +
> +#ifdef CONFIG_PPC64
> +/*
> + * 64-bit user address space can have multiple limits
> + * For now supported values are:
> + */
> +#define TASK_SIZE_64TB  (0x0000400000000000UL)
> +#define TASK_SIZE_128TB (0x0000800000000000UL)
> +#define TASK_SIZE_512TB (0x0002000000000000UL)
> +#define TASK_SIZE_1PB   (0x0004000000000000UL)
> +#define TASK_SIZE_2PB   (0x0008000000000000UL)
> +/*
> + * With 52 bits in the address we can support
> + * upto 4PB of range.
> + */
> +#define TASK_SIZE_4PB   (0x0010000000000000UL)
> +
> +/*
> + * For now 512TB is only supported with book3s and 64K linux page size.
> + */
> +#if defined(CONFIG_PPC_BOOK3S_64) && defined(CONFIG_PPC_64K_PAGES)
> +/*
> + * Max value currently used:
> + */
> +#define TASK_SIZE_USER64		TASK_SIZE_4PB
> +#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_128TB
> +#define TASK_CONTEXT_SIZE		TASK_SIZE_512TB
> +#else
> +#define TASK_SIZE_USER64		TASK_SIZE_64TB
> +#define DEFAULT_MAP_WINDOW_USER64	TASK_SIZE_64TB
> +/*
> + * We don't need to allocate extended context ids for 4K page size, because
> + * we limit the max effective address on this config to 64TB.
> + */
> +#define TASK_CONTEXT_SIZE		TASK_SIZE_64TB
> +#endif
> +
> +#endif /* CONFIG_PPC64 */
> +#endif /* _ASM_POWERPC_TASK_SIZE_H */
> diff --git a/arch/powerpc/kvm/book3s_hv_hmi.c b/arch/powerpc/kvm/book3s_hv_hmi.c
> index e3f738eb1cac..64b5011475c7 100644
> --- a/arch/powerpc/kvm/book3s_hv_hmi.c
> +++ b/arch/powerpc/kvm/book3s_hv_hmi.c
> @@ -24,6 +24,7 @@
>  #include <linux/compiler.h>
>  #include <asm/paca.h>
>  #include <asm/hmi.h>
> +#include <asm/processor.h>
>  
>  void wait_for_subcore_guest_exit(void)
>  {
> -- 
> 2.13.3
> 

