Return-Path: <linuxppc-dev+bounces-26067-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 736C1C61DB6
	for <linuxppc-dev@archiver.kernel.org>; Mon, 24 Aug 2026 15:50:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hTFkC5Yxkz2xpv;
	Tue, 25 Aug 2026 01:50:43 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1787586643;
	cv=none; b=O7TXpU8XQGcePAz22hwkfTsRH8YSGGey+PS9u9uZYfg9Ys+DxRYm3VN1+yWzTQdjYsnyl7LULJa2nhT2vdrX7cV2R7uxfLXPmlXzh/UTU+/YZGCDIM+navzT8jmkVyQAMbxl5tMRJbrJGOCdklADRjjvrsnGe6WTmAC1SXw9QT5rj2T43prj80C2uWKNKRIU+Fo+u7X8ZZpmNrauSTh/EKJt7ikwsmlDGif8XMrfplw9tlRXB+ZCqHGJVuoFE1khqnkIEWPJPy+U4arP7c71m2Shxlxmp3JyEMGNo/QFz5bB78UKgX6RXrmhQBJuvImvb+lniTI4l5wP6lD6Y9wF8g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1787586643; c=relaxed/relaxed;
	bh=8n2sUFyNkTeeyJ480adWKOU51gCub2/F4WE3r3BRNf0=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=EHW2RtL0IPg7OOR3kBsmXZUC05hV7Jj0lPng+8VvUWMr6lZ0m0QElLV1iQNnA5h3MUNDjNpm5BAizih3Hq+ououV2qU9YCWnpDRfgifjqlsKTcNJJgsnYLbLk+rPloKUIieUE3KGh4JBOS+jxEVv+oNZilr55ZF7qfsz4qxHagbljFpL2MZenIZXpC7BvuGWdxvr5tpWss/z0+FNTCigrD4cU6NxYdsLYn8M9bgi3cChaFHNzKF/qCT5A2w1tEDnDNOQQIhYnfdHKnF3bW9NRA2RjL0PjyQUX1qDJNT/mI/hqpsz2MlccPuLQc0O+gnP7BD4TJQlagBakN4zBPymLg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=sifive.com; dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=E0bPSDYE; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=samuel.holland@sifive.com; receiver=lists.ozlabs.org) smtp.mailfrom=sifive.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=sifive.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=sifive.com header.i=@sifive.com header.a=rsa-sha256 header.s=google header.b=E0bPSDYE;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=sifive.com (client-ip=2607:f8b0:4864:20::42a; helo=mail-pf1-x42a.google.com; envelope-from=samuel.holland@sifive.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hTFkB5C1Fz2xmh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Aug 2026 01:50:41 +1000 (AEST)
Received: by mail-pf1-x42a.google.com with SMTP id d2e1a72fcca58-84e04df8c46so4831356b3a.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Aug 2026 08:50:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google; t=1787586639; x=1788191439; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=8n2sUFyNkTeeyJ480adWKOU51gCub2/F4WE3r3BRNf0=;
        b=E0bPSDYERJb6tl0WB1DmAYF+QKEy1nnCtKZkTvg3YGZGFKzrRae1ug1gp2vKvtUOA1
         vYGuY4ApDArFwKH0cJ22x1gcJ2Ayo+Reh6CSy3e0cmHRPPVwZL5pjcDtnIK1DI5CIapy
         IWng18h5IZa6r2o/xcOz22yluFEzbg+ddSa2njXSGPkF1LKEN76G4Vz/MgaqzeuHpCCh
         UMKd7d3Npiv0HDJiW6k6CkHUXyK03rug8H6GhsIqfk/PvlD6OBjuvAt41FI6by677v0T
         BeVgYtcf1wMo6cjMnMgHEfHlHymHYPa/sDX3AabpvnbL6liYK3ZwEfD0WMQV18AFHQ9u
         CI5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1787586639; x=1788191439;
        h=content-transfer-encoding:content-type:in-reply-to:content-language
         :from:references:cc:to:subject:user-agent:mime-version:date
         :message-id:x-gm-gg:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to:content-type;
        bh=8n2sUFyNkTeeyJ480adWKOU51gCub2/F4WE3r3BRNf0=;
        b=PgUY2VDGWVxZmRrO7PARnySQBSU6dqPFhg+iKkalK9Qam97Dlliaci3eSUXIy2QrL9
         ah9vTiquY+Ns2dBc1Idi7z6jQ+OIW8mf025pbYzQs+KNpchUPCL4MXMOlkNbupqbZuR0
         V9KGpsVBgXW+4yuuwkkcQeHBdtHxOSsg3U5chrUoIFLKnxdaL4yR5Nosei+LzoU/nocc
         sSzA4bLnHV5ZeI+yIRnh0YAfD8qi7M7N3RODlny7xaR7Bz45EcgGQEZQ68zp/1KcmwT2
         fV58TU+iYM4SQYxfe5vnFy02NgkZTR47rBv5qj+hX+KE2Rv44dLDnaB94O+y5/Cb0Cl4
         jV4Q==
X-Forwarded-Encrypted: i=1; AHgh+Ro5HRCXgQr9PlX0tRkuf759ldCjRWU9wGcK5A1mqViAHJOJMuoFgD8COrIG5+x/KXf/4TqP6VZOly1YVKE=@lists.ozlabs.org
X-Gm-Message-State: AFuF++lTpiF0kMQtnp3u2Qhl6HCuyHonFkemJTiUAIrbmxx/GXHYeJSp
	7kGlPQHPaAYUv8Jm6UjqkbVtg3xcHJh6KUY8yvNqeXPPhZACHivZpAWHwleYafdM/vU=
X-Gm-Gg: AR+sD13VEHu1DYBC5y1iMmp7kG6WwU0tQ7Vj+W/KNggWD4IhC9kyzQeFIrDwk5UPs4+
	WqAbFz5TgcNHFzCn9k57h3u2SGMh11G5vwcdX2RGu5USN0x4/P4VCrp6cX+KE262QJf++Y73YLe
	Q63Di7z1qD3W3vx3CPuQ+cZ3mNmFUj0yGNaXngrcXf16zaxUu/nwZ2hiBBtG2ufXnyigXcLoW44
	NodFF8XnajiJ7mwzXOY7CTMipXanC+pbd3m2nG4U3le67Vw30OtHhpQWP9Fqdw7qXiFksDDLq4C
	s2gg3X8LPxi3tsMs4NkwZByGUhBGmbnzflKC2aWEVv/dvcZpaY6z0mI58fsAU6mFNMKF5CdJbhl
	sCzzmvXQdVUQxIFSz7/tQieyqXEIY15SHsEQGr1Mbp+XHFcWa7iahLecpH6mfhTf8tF6hjeFZoX
	wINV8G3SVCJG6xFBrycJPRAnONdebAhcyYZYnxaO6JGCqZZO7sQWtosYY/iJbXQOnV
X-Received: by 2002:a05:6a00:10d1:b0:848:5540:2377 with SMTP id d2e1a72fcca58-851fa070c14mr40910400b3a.17.1787586639434;
        Mon, 24 Aug 2026 08:50:39 -0700 (PDT)
Received: from [100.64.0.1] ([165.225.242.163])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-8520ef36048sm2219670b3a.26.2026.08.24.08.50.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 24 Aug 2026 08:50:38 -0700 (PDT)
Message-ID: <6dae9cae-9665-4dc8-9a49-d6e5acda221b@sifive.com>
Date: Mon, 24 Aug 2026 10:50:37 -0500
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
User-Agent: Mozilla Thunderbird
Subject: Re: [RFC V3 8/8] mm: Drop pxd_ERROR()
To: Anshuman Khandual <anshuman.khandual@arm.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>, Rich Felker
 <dalias@libc.org>, John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>,
 "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
 Helge Deller <deller@gmx.de>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, linux-alpha@vger.kernel.org,
 linux-snps-arc@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
 linux-csky@vger.kernel.org, linux-hexagon@vger.kernel.org,
 loongarch@lists.linux.dev, linux-m68k@lists.linux-m68k.org,
 linux-mips@vger.kernel.org, linux-openrisc@vger.kernel.org,
 linux-parisc@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
 linux-sh@vger.kernel.org, sparclinux@vger.kernel.org,
 linux-um@lists.infradead.org, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-mm@kvack.org, akpm@linux-foundation.org, david@kernel.org
References: <20260818040041.1891769-1-anshuman.khandual@arm.com>
 <20260818040041.1891769-9-anshuman.khandual@arm.com>
From: Samuel Holland <samuel.holland@sifive.com>
Content-Language: en-US
In-Reply-To: <20260818040041.1891769-9-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit

On 2026-08-17 11:00 PM, Anshuman Khandual wrote:
> There are no more users left for any pxd_ERROR() either in generic MM or in
> the platform MM. Hence all these platform macros along with their generic
> fallback could be dropped across the tree.
> 
> Cc: linux-alpha@vger.kernel.org
> Cc: linux-snps-arc@lists.infradead.org
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-csky@vger.kernel.org
> Cc: linux-hexagon@vger.kernel.org
> Cc: loongarch@lists.linux.dev
> Cc: linux-m68k@lists.linux-m68k.org
> Cc: linux-mips@vger.kernel.org
> Cc: linux-openrisc@vger.kernel.org
> Cc: linux-parisc@vger.kernel.org
> Cc: linuxppc-dev@lists.ozlabs.org
> Cc: linux-riscv@lists.infradead.org
> Cc: linux-s390@vger.kernel.org
> Cc: linux-sh@vger.kernel.org
> Cc: sparclinux@vger.kernel.org
> Cc: linux-um@lists.infradead.org
> Cc: linux-arch@vger.kernel.org
> Cc: linux-mm@kvack.org
> Cc: linux-kernel@vger.kernel.org
> Acked-by: Geert Uytterhoeven <geert@linux-m68k.org> # m68k
> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> ---
> Changes in RFC V3
> 
> - Moved ptrval_to_str() as header in a [PATCH 1/8]
> - Stopped using pxd_ERROR() in generic MM in [PATCH 2/8]
> - Dropped pxd_ERRO() macros from all platforms in this patch
> 
>  arch/alpha/include/asm/pgtable.h               |  7 -------
>  arch/arc/include/asm/pgtable-levels.h          | 11 -----------
>  arch/arm/include/asm/pgtable.h                 |  7 -------
>  arch/arm/kernel/traps.c                        | 17 -----------------
>  arch/arm64/include/asm/pgtable.h               | 15 ---------------
>  arch/csky/include/asm/pgtable.h                |  4 ----
>  arch/hexagon/include/asm/pgtable.h             |  3 ---
>  arch/loongarch/include/asm/pgtable.h           | 11 -----------
>  arch/m68k/include/asm/mcf_pgtable.h            |  6 ------
>  arch/m68k/include/asm/motorola_pgtable.h       |  8 --------
>  arch/m68k/include/asm/sun3_pgtable.h           |  7 -------
>  arch/microblaze/include/asm/pgtable.h          |  7 -------
>  arch/mips/include/asm/pgtable-32.h             | 10 ----------
>  arch/mips/include/asm/pgtable-64.h             | 13 -------------
>  arch/nios2/include/asm/pgtable.h               |  7 -------
>  arch/openrisc/include/asm/pgtable.h            |  7 -------
>  arch/parisc/include/asm/pgtable.h              |  9 ---------
>  arch/powerpc/include/asm/book3s/32/pgtable.h   |  2 --
>  arch/powerpc/include/asm/book3s/64/pgtable.h   |  7 -------
>  arch/powerpc/include/asm/nohash/32/pgtable.h   |  2 --
>  .../powerpc/include/asm/nohash/64/pgtable-4k.h |  3 ---
>  arch/powerpc/include/asm/nohash/64/pgtable.h   |  5 -----
>  arch/riscv/include/asm/pgtable-64.h            |  9 ---------
>  arch/riscv/include/asm/pgtable.h               |  4 ----
>  arch/s390/include/asm/pgtable.h                | 11 -----------
>  arch/sh/include/asm/pgtable-3level.h           |  3 ---
>  arch/sh/include/asm/pgtable_32.h               |  8 --------
>  arch/sparc/include/asm/pgtable_32.h            |  3 ---
>  arch/sparc/include/asm/pgtable_64.h            | 10 ----------
>  arch/um/include/asm/pgtable-2level.h           |  7 -------
>  arch/um/include/asm/pgtable-4level.h           | 13 -------------
>  arch/x86/include/asm/pgtable-2level.h          |  5 -----
>  arch/x86/include/asm/pgtable-3level.h          | 11 -----------
>  arch/x86/include/asm/pgtable_64.h              | 18 ------------------
>  arch/xtensa/include/asm/pgtable.h              |  4 ----
>  include/asm-generic/pgtable-nop4d.h            |  1 -
>  include/asm-generic/pgtable-nopmd.h            |  1 -
>  include/asm-generic/pgtable-nopud.h            |  1 -
>  38 files changed, 277 deletions(-)
> ...
> diff --git a/arch/riscv/include/asm/pgtable.h b/arch/riscv/include/asm/pgtable.h
> index 5d5756bda82e..993a6505eb8f 100644
> --- a/arch/riscv/include/asm/pgtable.h
> +++ b/arch/riscv/include/asm/pgtable.h
> @@ -559,10 +559,6 @@ static inline pte_t pte_modify(pte_t pte, pgprot_t newprot)
>  	return __pte((pte_val(pte) & _PAGE_CHG_MASK) | newprot_val);
>  }
>  
> -#define pgd_ERROR(e) \
> -	pr_err("%s:%d: bad pgd " PTE_FMT ".\n", __FILE__, __LINE__, pgd_val(e))

We can drop the PTE_FMT macro now too.

Regards,
Samuel


