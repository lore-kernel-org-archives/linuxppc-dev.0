Return-Path: <SRS0=any3=BQ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52141C433E0
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2020 03:26:48 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id F39F220792
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2020 03:26:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=axtens.net header.i=@axtens.net header.b="L4XB6nyS"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org F39F220792
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4BMYnK55fJzDqcG
	for <linuxppc-dev@archiver.kernel.org>; Thu,  6 Aug 2020 13:26:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=axtens.net (client-ip=2607:f8b0:4864:20::444;
 helo=mail-pf1-x444.google.com; envelope-from=dja@axtens.net;
 receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=axtens.net
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=axtens.net header.i=@axtens.net header.a=rsa-sha256
 header.s=google header.b=L4XB6nyS; dkim-atps=neutral
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com
 [IPv6:2607:f8b0:4864:20::444])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4BMYkv3ht1zDqX1
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Aug 2020 13:24:38 +1000 (AEST)
Received: by mail-pf1-x444.google.com with SMTP id z188so16321445pfc.6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Aug 2020 20:24:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=axtens.net; s=google;
 h=from:to:cc:subject:in-reply-to:references:date:message-id
 :mime-version; bh=49z1+LbfP1EHSHgEOp6zvM41RF4pfO5OwrTaUPLGq48=;
 b=L4XB6nySvLkVi+tDRz+aVFN9lE8H84VaWRQI9BAqRXXdak9thdwmJjjjTgNzlDvW4J
 gMpjXWFmtTYc3PQ4pGwSnkXYbIxaLIfk1P5EvL88W+s2VQfm5bPTlD6QGSkV2KBpHbFV
 ixZWucTBUr7LvmVibQM4DI6H+LTBXuSNATnCs=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
 :message-id:mime-version;
 bh=49z1+LbfP1EHSHgEOp6zvM41RF4pfO5OwrTaUPLGq48=;
 b=KCK8YbbYKdDXTh/a2rKVsmYziaML+XP308UV4ngZPKYsVWpeZyHHUWlcJWwlPBer3D
 HBpSkI91jcSzSGgHHrgbpnQYPdLUJh9SLZP0sBfIFKBr0ObEU9S2hMvBnUBdHuZ4plXx
 jvxabAibfT5AuwnwAbw+iQi/nsjm8Ubxw2ChbyirroYInLAhnsDiR3nUa/S5Z9POAhMA
 B/SOd0iag5p11tLCgmJAOmrKZOvIRljMNoYnfzxnFLhqBzUdVqR1iVEnC4Od4901rHba
 cSTYehZIz0Qv+AfCw6xsbEzy8FEHpJnTY2IorvRHukgu8TVPsE4+TTdern7zQqb9TSgP
 0v3Q==
X-Gm-Message-State: AOAM532QvKkj2pYiYKIL5c75PbZzgPE2rd5eOmIMuubfoOb6Shw/AVHb
 mjVzvijjFkT+wEdREkKX4QGQZA==
X-Google-Smtp-Source: ABdhPJxSs9CpbLd302YKlzGAw+TbSuhCbGjVK9m95qyXcoDgClcDijTfJJJP6G/XTsFMO3IjQGldVg==
X-Received: by 2002:a63:b90a:: with SMTP id z10mr5385445pge.277.1596684275018; 
 Wed, 05 Aug 2020 20:24:35 -0700 (PDT)
Received: from localhost
 (2001-44b8-111e-5c00-b446-662a-483a-dcf2.static.ipv6.internode.on.net.
 [2001:44b8:111e:5c00:b446:662a:483a:dcf2])
 by smtp.gmail.com with ESMTPSA id e65sm5382429pfe.91.2020.08.05.20.24.34
 (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
 Wed, 05 Aug 2020 20:24:34 -0700 (PDT)
From: Daniel Axtens <dja@axtens.net>
To: "Christopher M. Riedl" <cmr@informatik.wtf>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2 2/5] powerpc/lib: Initialize a temporary mm for code
 patching
In-Reply-To: <20200709040316.12789-3-cmr@informatik.wtf>
References: <20200709040316.12789-1-cmr@informatik.wtf>
 <20200709040316.12789-3-cmr@informatik.wtf>
Date: Thu, 06 Aug 2020 13:24:31 +1000
Message-ID: <87lfiso3rk.fsf@dja-thinkpad.axtens.net>
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
Cc: kernel-hardening@lists.openwall.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Christopher M. Riedl" <cmr@informatik.wtf> writes:

> When code patching a STRICT_KERNEL_RWX kernel the page containing the
> address to be patched is temporarily mapped with permissive memory
> protections. Currently, a per-cpu vmalloc patch area is used for this
> purpose. While the patch area is per-cpu, the temporary page mapping is
> inserted into the kernel page tables for the duration of the patching.
> The mapping is exposed to CPUs other than the patching CPU - this is
> undesirable from a hardening perspective.
>
> Use the `poking_init` init hook to prepare a temporary mm and patching
> address. Initialize the temporary mm by copying the init mm. Choose a
> randomized patching address inside the temporary mm userspace address
> portion. The next patch uses the temporary mm and patching address for
> code patching.
>
> Based on x86 implementation:
>
> commit 4fc19708b165
> ("x86/alternatives: Initialize temporary mm for patching")
>
> Signed-off-by: Christopher M. Riedl <cmr@informatik.wtf>
> ---
>  arch/powerpc/lib/code-patching.c | 33 ++++++++++++++++++++++++++++++++
>  1 file changed, 33 insertions(+)
>
> diff --git a/arch/powerpc/lib/code-patching.c b/arch/powerpc/lib/code-patching.c
> index 0a051dfeb177..8ae1a9e5fe6e 100644
> --- a/arch/powerpc/lib/code-patching.c
> +++ b/arch/powerpc/lib/code-patching.c
> @@ -11,6 +11,8 @@
>  #include <linux/cpuhotplug.h>
>  #include <linux/slab.h>
>  #include <linux/uaccess.h>
> +#include <linux/sched/task.h>
> +#include <linux/random.h>
>  
>  #include <asm/tlbflush.h>
>  #include <asm/page.h>
> @@ -44,6 +46,37 @@ int raw_patch_instruction(struct ppc_inst *addr, struct ppc_inst instr)
>  }
>  
>  #ifdef CONFIG_STRICT_KERNEL_RWX
> +
> +static struct mm_struct *patching_mm __ro_after_init;
> +static unsigned long patching_addr __ro_after_init;
> +
> +void __init poking_init(void)
> +{
> +	spinlock_t *ptl; /* for protecting pte table */
> +	pte_t *ptep;
> +
> +	/*
> +	 * Some parts of the kernel (static keys for example) depend on
> +	 * successful code patching. Code patching under STRICT_KERNEL_RWX
> +	 * requires this setup - otherwise we cannot patch at all. We use
> +	 * BUG_ON() here and later since an early failure is preferred to
> +	 * buggy behavior and/or strange crashes later.
> +	 */
> +	patching_mm = copy_init_mm();
> +	BUG_ON(!patching_mm);
> +
> +	/*
> +	 * In hash we cannot go above DEFAULT_MAP_WINDOW easily.
> +	 * XXX: Do we want additional bits of entropy for radix?
> +	 */
> +	patching_addr = (get_random_long() & PAGE_MASK) %
> +		(DEFAULT_MAP_WINDOW - PAGE_SIZE);

It took me a while to understand this calculation. I see that it's
calculating a base address for a page in which to do patching. It does
the following:

 - get a random long

 - mask with PAGE_MASK so as to get a page aligned value

 - make sure that the base address is at least one PAGE_SIZE below
   DEFAULT_MAP_WINDOW so we have a clear page between the base and
   DEFAULT_MAP_WINDOW.

On 64-bit Book3S with 64K pages, that works out to be

PAGE_SIZE = 0x0000 0000 0001 0000
PAGE_MASK = 0xFFFF FFFF FFFF 0000

DEFAULT_MAP_WINDOW = DEFAULT_MAP_WINDOW_USER64 = TASK_SIZE_128TB
                   = 0x0000_8000_0000_0000

DEFAULT_MAP_WINDOW - PAGE_SIZE = 0x0000 7FFF FFFF 0000

It took a while (and a conversation with my wife who studied pure
maths!) but I am convinced that the modulo preserves the page-alignement
of the patching address.

One thing I did realise is that patching_addr can be zero at the end of
this process. That seems dubious and slightly error-prone to me - is
the patching process robust to that or should we exclude it?

Anyway, if I have the maths right, that there are 0x7fffffff or ~2
billion possible locations for the patching page, which is just shy of
31 bits of entropy.

I think this compares pretty favourably to most (K)ASLR implementations?

What's the range if built with 4k pages?

Kind regards,
Daniel

> +
> +	ptep = get_locked_pte(patching_mm, patching_addr, &ptl);
> +	BUG_ON(!ptep);
> +	pte_unmap_unlock(ptep, ptl);
> +}
> +
>  static DEFINE_PER_CPU(struct vm_struct *, text_poke_area);
>  
>  static int text_area_cpu_up(unsigned int cpu)
> -- 
> 2.27.0
