Return-Path: <linuxppc-dev+bounces-19868-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73540F327B1
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 06:49:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0Cd90lDHz2ySW;
	Tue, 21 Apr 2026 16:49:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776754157;
	cv=none; b=ILBVwjozgfFXjmhcG4mb+Plluhejth3vdHMpJo0XC7ciahR7RYCZ75kgm8JG+88ohWVvtvVyf5J4/xESFTrER9DyLl+6FXgJ9YK23gQqW5UUwJp5pe45+YfEzN+ugC4tsl5mNn0XpOXDKuauijxoN/6JB+l+ZmHE/lAKBGWelMJZngBroCFJSe19O83DFM5ZdehjKIs78g6wbKH0DC0z4Ok5tebFdxBeZdRtAQDwdk8ip2EogYZ8W6AVY0e/C13qttSL7fyMd4oTmA9mUq2wFX9zpQxssbfnwulM/Qtwx6kgR9UL3yxI9h9F4rPINzFnX+r0oH/I03bRLwX2qAzhHw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776754157; c=relaxed/relaxed;
	bh=VdNywBu7apdyTFV9cnt3GZxXLndr1pBULjY0WptzCm8=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=mbwvlxa/54sHlClZXl3/EtTe07a27e1G4Tld3EY27bdD79PtYewDPGb8A6u6lWtrH3U1idMuAlSPsQB8PTy3RLp0retSiNh8L+IQOzjXcoomcVlM++gqqleLjhfCGt2L3Ow09lZPuFRxW9FP97/6QpyUYxOSO3e9Ea/Pje6HflZ2ZUt8h/y8/PkcSjIgTO1PLOB8l0QA7evKC4CH2RTJWkndwa5OUAby18K9WrQp7x6VY1Un3s5SBBwmzv4mg09qxPKr5FlOdzijizynxCpUSBpioK/qkIHd8M38zs6Lzmf8PiqKTT1tX29MNZZIIGBtP2JfLwT5VbfTiVJTJ6Oe9w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qPTRIf1Z; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=qPTRIf1Z;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0Cd82DFKz2xlK
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 16:49:15 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-356337f058aso2502939a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Apr 2026 23:49:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776754153; x=1777358953; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=VdNywBu7apdyTFV9cnt3GZxXLndr1pBULjY0WptzCm8=;
        b=qPTRIf1Z0lDAABusgQZXmC3VhKVWv22k7gqXrV6dzN0BwU4/l6J6gcx5xEFtkBolzR
         H+9L7FaXhogFWXiXQ7cuyBj0f+t3eWeYU4a6PiDdXFIOP7dUgZJtA0lQ3BC9khr1j+Mm
         eDD57r4/bP9LoxgN22uZdtgZSISfU8qxkUF0wIN6IMmyFxf+qi4KI0eCth+Zv4qQ8ch9
         lmVHYbMQTakuHAnZbjRwhyHlf9ykE95dgdF3ASqHt415Jjhg0DNB9cyA1lKN4fLGAmZF
         3j2hWcBcgFjeZvbXqcmGIcYyeEhVfSLFTJUd0h1ri+tYh0kI1IoGOX2vO+JdbpPYO7br
         gVyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776754153; x=1777358953;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=VdNywBu7apdyTFV9cnt3GZxXLndr1pBULjY0WptzCm8=;
        b=T00JUVnRkoXOUj6HY3KkRfY3Xn1z6gO4fVgDFZzK5XFiDsXCjViyeWsStIaZAKgYrq
         7IGyNuaYY9b9DIhrratrMedvHwe+n9LfuslLhbJ+LH+OQD6kMgh/rY8M81mxdqd7IJuC
         68zroiT75pXyRJtFTEiU/bwFog/gicjk5fIDYhSuJqeyXNvEpWnMchoY0ptBG6Y5M7j1
         MxXNFd8iOmOa3emz6sIrZi77zvbsyiZgg20ltjbNcKh/db1q3HCIexbmSR9nR/HXP6MK
         v/WvQ1kD4s+Td3caddP+KJMU8P7ssclfJd9u/42DLV11wrlCiYm20Gwtiw+fSZELx/uf
         GfeA==
X-Forwarded-Encrypted: i=1; AFNElJ+EFtHBzqKDzaEPOHVflxlzj6m9ylKv4pjXfPSNfYeADuljNQuoJ+NOqDiawiv3AzlYDc95iG4Bxwp+VkU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzVqjKnzSJOBUQHwrr+YSOLCafgP79KmARqkyQiOwCYB8VHAsDg
	v8cTiQIDMKUwUpuMmfTvx4PxqY8hJFKSSJ90zyOa87xlV3WWJsW+Hn4P
X-Gm-Gg: AeBDies780ekUsDC/qrxDmNWB0Uz0AMImBbVJu57u9y3zMuTLImUUYSHCL0GahiD0hF
	+Zq3TXNRrqLwPLclyC2l3zAKjdPkaAdHXeC9HKw7aGVtH6nauRxrMTaVdJE955q8kgT9bUVE6OX
	SWnM+xvFnC5qzmYiPyZLEa/Y0mBCYl5j45Fu68/7O9EwZPKmNqYLnJTMdjNwoUkoSV2wYaqSNSx
	5ppSkvjFJI4uXUmxC4h95IB0s6AhF6Z4gLg7HlOHcdUiveLkzY3o4M8VLOnn6DA2rINmEGafuqe
	vRxKfiR4TTXAV2GyLPahzmasNkO5KWaZa/oqdXZOvOGURvrH05asnwQK8X6cTQ+4zU4EsZ9Xrqr
	ULSnFOJREo8CcNkXHA2z1lWHdnNV7mbg1kmdPCFkhEzOghcaXO1hiIh6NVhtioXJV9udG9cnIut
	B88XuSsRxkU1pcWR2NM9vIREcCnBxXRvsXqqkOed6wnRiq1PGg8pT+tPmjzeDo3+2YAn3PkJYxW
	noCyN8yIbUpDtum
X-Received: by 2002:a17:90a:dfd0:b0:35e:30bc:96ed with SMTP id 98e67ed59e1d1-36140402361mr16891174a91.10.1776754153374;
        Mon, 20 Apr 2026 23:49:13 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3614195a8f0sm12278674a91.12.2026.04.20.23.48.57
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 20 Apr 2026 23:49:13 -0700 (PDT)
Date: Tue, 21 Apr 2026 12:18:55 +0530
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
Subject: Re: [patch 32/38] powerpc/spufs: Use mftb() directly
Message-ID: <aecdpyvTLJOjCdFp@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260410120044.031381086@kernel.org>
 <20260410120319.723429844@kernel.org>
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
In-Reply-To: <20260410120319.723429844@kernel.org>

On Fri, Apr 10, 2026 at 02:21:04PM +0200, Thomas Gleixner wrote:
> There is no reason to indirect via get_cycles(), which is about to be
> removed.
> 
> Use mftb() directly.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> ---
>  arch/powerpc/platforms/cell/spufs/switch.c |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> --- a/arch/powerpc/platforms/cell/spufs/switch.c
> +++ b/arch/powerpc/platforms/cell/spufs/switch.c
> @@ -34,6 +34,7 @@
>  #include <asm/spu_priv1.h>
>  #include <asm/spu_csa.h>
>  #include <asm/mmu_context.h>
> +#include <asm/time.h>
>  
>  #include "spufs.h"
>  
> @@ -279,7 +280,7 @@ static inline void save_timebase(struct
>  	 *    Read PPE Timebase High and Timebase low registers
>  	 *    and save in CSA.  TBD.
>  	 */
> -	csa->suspend_time = get_cycles();
> +	csa->suspend_time = mftb();
>  }
>  
>  static inline void remove_other_spu_access(struct spu_state *csa,
> @@ -1261,7 +1262,7 @@ static inline void setup_decr(struct spu
>  	 *     in LSCSA.
>  	 */
>  	if (csa->priv2.mfc_control_RW & MFC_CNTL_DECREMENTER_RUNNING) {
> -		cycles_t resume_time = get_cycles();
> +		cycles_t resume_time = mftb();
>  		cycles_t delta_time = resume_time - csa->suspend_time;
>  
>  		csa->lscsa->decr_status.slot[0] = SPU_DECR_STATUS_RUNNING;
> 
Reviewed-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>

