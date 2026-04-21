Return-Path: <linuxppc-dev+bounces-19877-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6AFC0F8925F
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 11:23:01 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0Kj00M6Mz2ytx;
	Tue, 21 Apr 2026 21:23:00 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::430"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776770579;
	cv=none; b=lj9nqhQh7KJBtPfORVLhA1XAseAORQHawN+bg6J3Z7pRWVaFEtAtp5QnIqLijjIV3VrlYaWJ0aoLn5/9291IXvWY3T1jZ13eNWUCWWZFS7IBQ5phE7XtVVuwxRKJ+ZxAQVYzW2ebzqJsEtCQAYhOrgK5aRRQ6aJ734Ma4GWTsQDXbT8sMjD56K0Y76t0T9yVAaYnClf7IHbCM/321Miw3ahg3+B49axYVFkOyswwDxBp5B0DQW5D4e8OJGdhXUlD7ysIXsciqGKucW2O/olBLOAsMCHE53j98Q7gIsAQR45VqogXnYNHSuTgxnZRUGPydjS+44hhupLZD/f0BvYGIQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776770579; c=relaxed/relaxed;
	bh=pbepvZoiaQHnY8ojgGndHUN0tqRJnJo2KRx8HLgDgUI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=b/pW75LJ2fNApVKkY8zAn0gdwq7iAKjIaY5GTQNLvF4rf3zr6NQa62IqOtVuflqL9OjfkQEAiW1DV4MsOKhXUmiB5DpkW00x5vgAMLsWEkEm7bP68QAAc4RFPLJVcHU6dmU+9BpucMKIW0+JGkN2OeAbrQhYnOCNJEd65TppbnIjl/xjiAK0LRbWObKQRrQTI4FkkKmjg2wyNqqvTrHMEztDUBCYdqbcjwjhO7+xFNcvOhF4MpohiICOtfzqjNd9izwr2wsxbyQyvRcuwinOLwDEEocXrmJgbuz99mcFj6pnrwKM4LJJrUMh7ks/Ybc2k8O//Ru+q00G29myzLGL2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WNa+lohl; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=WNa+lohl;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::430; helo=mail-pf1-x430.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x430.google.com (mail-pf1-x430.google.com [IPv6:2607:f8b0:4864:20::430])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0Khx4qzvz2ypk
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 21:22:56 +1000 (AEST)
Received: by mail-pf1-x430.google.com with SMTP id d2e1a72fcca58-82f431c0ab6so1869004b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 04:22:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776770574; x=1777375374; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=pbepvZoiaQHnY8ojgGndHUN0tqRJnJo2KRx8HLgDgUI=;
        b=WNa+lohlGTFljkYYomh/1AcXYJyGtXGC0ygehKBZ9jLWIo6JseW9Mfx1uTYG3+RcZJ
         80mgOmatopE+9wg+7LlNcI3e25FyLCrwYZhC9/JkoTqYQ+QCOR1JnrnOroel/kj4MzzZ
         MrFzvu4izI3zmOtfGi84adfSe8Wy7KcbRl3HOwKt2yNRfdDs+Wdm++BCfZZS0lNrzF2j
         EgVKxjQWqB3/4/SYxP1c8AhH7zKCaX5DOPwdu3BMWhucbMaQ97Clvm9Gn+Cx421VJhKo
         qQh/PtxMKkuMHB7csQMPzyYneoGW+EIbrbl9eIgjNI5pGDYLxfIkUo9g2pgpY+cHIoTM
         v/uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776770574; x=1777375374;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=pbepvZoiaQHnY8ojgGndHUN0tqRJnJo2KRx8HLgDgUI=;
        b=WHcI3d8axDiBoPCjBaAfzWZxX9Gd2mzMQ3em/6mGEP0AYoqiMZEvBJRYUt9mbGT4Ul
         DqG/3R0zF6H3QT/Yxm+fvwnFjjpGz4VOirKhqwGlPSkTLBUM0eiXDlv3oPH+8AmQ53ET
         HAGgEeL2doAZWv6uJXZNExgBk4xh9jMwCw291KUAJRU4nkWgFcKiZ/Ote899xcBLTM8I
         7pe19tyULGtBLSTeVCtVomGAsUPLe8OXg/+Qo/AXTCgCZ2LYO9fUtWYzZS0rJJyMBjVo
         TOMxBZBLt6vi6b/w0+80S4O1pLTvd83QSU9bM/LW1ZnQgK3bH+k6EKSN27cCRS1KZapI
         qSIQ==
X-Forwarded-Encrypted: i=1; AFNElJ+18EQw5mWv7hjXoe32JdGsu5rZUZK+OsT/t/Y++acJVuB1l1tU6NDZOgrIlQ95ntJu0Cl705zgcSmH7MY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxevS5ze8fIBnFKv6Gv7qXljt0X7Yajgh5Twnm9BxyxZn8SsD4s
	6zb1KXHu2wPY6lSpsFIUNZSffd6yNY1QAWh4VlfUNjtwH2gGRo5cvOhc
X-Gm-Gg: AeBDietMME0jt3XNqLfmMaYB1qvtvPlpbqrYAl/O4E/wbeFW6FM0yHjCxb5AF+qGMFp
	XHWhmIoCioVAamqzfsfBHWv0IJttaIK2KgTKMcKm+h2M+1ct5WImoY1w2QgsTaiV24m4gHdP1Ly
	6CfZ/Nrn++XCQRS2dmE52Puqcg1bNTBT5dY0CrNTxNZJgbnj3HgyefshkkaW1uXtG1LQ5Q1Knhs
	pMxMDnnPGgO/ckHM8s6EQK685xhiV3ryDzUoKJ1PZ+IaRfA2FMMs5f93ctVTrdPktqZCdmuvxAV
	AgXrup1ilIxuHGZ25sxfBdmYsMukiqFPcLhr0r1LI6GVA7EsDi/xrqZC8fRrJzbVbzYUH0uWgMT
	DigwhG+H4W94YRCu0Q79mptcmNswp6klUay9wBhvmSADxvpiw1/IQUCSKVysMlXswTTL98/S8/c
	7H6KsX0Z3OJMpISjDZMKUmaPpRyCNRB7nVoN169bfqwWZWpuZCtWNwqEHoi4M+E++T/AADyaGiH
	QLJ2g==
X-Received: by 2002:a05:6a00:6988:b0:82f:aae5:c7a9 with SMTP id d2e1a72fcca58-82faae5d438mr7228492b3a.27.1776770573719;
        Tue, 21 Apr 2026 04:22:53 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e981a0asm14155014b3a.3.2026.04.21.04.22.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 04:22:53 -0700 (PDT)
Date: Tue, 21 Apr 2026 16:52:37 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas Gleixner <tglx@kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, 
	Michael Ellerman <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Arnd Bergmann <arnd@arndb.de>, 
	x86@kernel.org, Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, 
	Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org, linux-wireless@vger.kernel.org, 
	Herbert Xu <herbert@gondor.apana.org.au>, linux-crypto@vger.kernel.org, 
	Vlastimil Babka <vbabka@kernel.org>, linux-mm@kvack.org, David Woodhouse <dwmw2@infradead.org>, 
	Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org, Theodore Tso <tytso@mit.edu>, 
	linux-ext4@vger.kernel.org, Andrew Morton <akpm@linux-foundation.org>, 
	Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>, 
	Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com, 
	Andrey Ryabinin <ryabinin.a.a@gmail.com>, Thomas Sailer <t.sailer@alumni.ethz.ch>, 
	linux-hams@vger.kernel.org, "Jason A. Donenfeld" <Jason@zx2c4.com>, 
	Richard Henderson <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, 
	Russell King <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, 
	Catalin Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev, 
	Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org, 
	Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, 
	Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org, Paul Walmsley <pjw@kernel.org>, 
	linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>, linux-s390@vger.kernel.org, 
	"David S. Miller" <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [patch 33/38] powerpc: Select ARCH_HAS_RANDOM_ENTROPY
Message-ID: <aedc9UddBSYXzrAj@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260410120044.031381086@kernel.org>
 <20260410120319.789114053@kernel.org>
X-Mailing-List: linuxppc-dev@lists.ozlabs.org
List-Id: <linuxppc-dev.lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev+help@lists.ozlabs.org>
List-Owner: <mailto:linuxppc-dev+owner@lists.ozlabs.org>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Archive: <https://lore.kernel.org/linuxppc-dev/>,
  <https://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Subscribe: <mailto:linuxppc-dev+subscribe@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-digest@lists.ozlabs.org>,
  <mailto:linuxppc-dev+subscribe-nomail@lists.ozlabs.org>
List-Unsubscribe: <mailto:linuxppc-dev+unsubscribe@lists.ozlabs.org>
Precedence: list
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20260410120319.789114053@kernel.org>

On Fri, Apr 10, 2026 at 02:21:09PM +0200, Thomas Gleixner wrote:
> The only remaining usage of get_cycles() is to provide random_get_entropy().
> 
> Switch powerpc over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY
> and providing random_get_entropy() in asm/random.h.
> 
> Remove asm/timex.h as it has no functionality anymore.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/Kconfig              |    1 +
>  arch/powerpc/include/asm/random.h |   13 +++++++++++++
>  arch/powerpc/include/asm/timex.h  |   21 ---------------------
>  3 files changed, 14 insertions(+), 21 deletions(-)
> 
> --- a/arch/powerpc/Kconfig
> +++ b/arch/powerpc/Kconfig
> @@ -150,6 +150,7 @@ config PPC
>  	select ARCH_HAS_PREEMPT_LAZY
>  	select ARCH_HAS_PTDUMP
>  	select ARCH_HAS_PTE_SPECIAL
> +	select ARCH_HAS_RANDOM_ENTROPY
>  	select ARCH_HAS_SCALED_CPUTIME		if VIRT_CPU_ACCOUNTING_NATIVE && PPC_BOOK3S_64
>  	select ARCH_HAS_SET_MEMORY
>  	select ARCH_HAS_STRICT_KERNEL_RWX	if (PPC_BOOK3S || PPC_8xx) && !HIBERNATION
> --- /dev/null
> +++ b/arch/powerpc/include/asm/random.h
> @@ -0,0 +1,13 @@
> +/* SPDX-License-Identifier: GPL-2.0 */
> +#ifndef _ASM_POWERPC_RANDOM_H
> +#define _ASM_POWERPC_RANDOM_H
> +
> +#include <asm/cputable.h>
> +#include <asm/vdso/timebase.h>
> +
> +static inline unsigned long random_get_entropy(void)
> +{
> +	return mftb();
> +}
> +
> +#endif	/* _ASM_POWERPC_RANDOM_H */
> --- a/arch/powerpc/include/asm/timex.h
> +++ b/arch/powerpc/include/asm/timex.h
> @@ -1,21 +0,0 @@
> -/* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_POWERPC_TIMEX_H
> -#define _ASM_POWERPC_TIMEX_H
> -
> -#ifdef __KERNEL__
> -
> -/*
> - * PowerPC architecture timex specifications
> - */
> -
> -#include <asm/cputable.h>
> -#include <asm/vdso/timebase.h>
> -
> -ostatic inline cycles_t get_cycles(void)
> -{
R> -	return mftb();
> -}
> -#define get_cycles get_cycles
> -
> -#endif	/* __KERNEL__ */
> -#endif	/* _ASM_POWERPC_TIMEX_H */
> 
Build tested for this series with allmodconfig and allyesconfig on ppc64le
machine for ppc64le.
tree: git://git.kernel.org/pub/scm/linux/kernel/git/tglx/devel.git getcycles-v1

Boot tested for this series on powernv9 qemu, powernv10 qemu and pSeries
power11 hardware.

Tested-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>


