Return-Path: <linuxppc-dev+bounces-19754-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id A24E0FA0C37
	for <linuxppc-dev@archiver.kernel.org>; Wed, 15 Apr 2026 06:43:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fwWnL2Qbgz2yvL;
	Wed, 15 Apr 2026 16:43:34 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776235414;
	cv=none; b=JIxbWHg5c/24DB6jvcLWUeh+wIBfJQjfr2l40vVvbwwkhgKNmDp4rFo8x02YRAgys8FHHlJ+7NthuWKji02N8snGGirK92xkfNlJBKCgSGEnlCyI57M9UUfeFnLrkURw6AqccKUyGI7WPqijqPfimbR98fsHadEnvwK78dniYGyQSEEhhYRMd9Gac1Mlfpx32W/HkGkHy0wTAqtRGlaLLDA7Ssn2zntXikUvGngFjr51ATGx0F5E9+b5m0XG2BppX3sKFx61pcl+n/CkC1282yC/thnSKlGOWrbm27zhohjAg7kHBuGnd8tImYjcQjcKFreA+Irr9X3PUTan5PcUjg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776235414; c=relaxed/relaxed;
	bh=r6HjAjcgcE6PNwReVnTSdYqGCc9ebXbnfh6z+tasmI8=;
	h=Message-ID:Date:MIME-Version:Subject:To:Cc:References:From:
	 In-Reply-To:Content-Type; b=kTV076QGaMVSsVzVzLx6s4vJK6bH59qbna4R8Y1WXudUNnknnVcW7gEEfDjnG9Su6ASRdx1IrWGTD02qoDzr9OiagikUw6qik/yVvmlkPs3LiR45GI/alZdkXOnOCpdmXR6PPm6/TaOMDhm0MSeE4yJUHlulkuSSb4IjdiBGetSVO1nJQpw99CQCuMx/NPC90AUsO0LqwzRFtwnlmSPnDzgoopgqRTFVgzEpwTK92ENMUgKgVs60+iVmEjPaO30tvkJiSZZ91LQ0gr54ES8BAcoyS4vyVYGzN9TbxqZGZP3KaK81dxnNK1b6y93u8NCKFS7yRBbM6so2Eb8siGPMbg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NmG1V1Qh; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=NmG1V1Qh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=chleroy@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fwWnK34tnz2yVP
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Apr 2026 16:43:33 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7742F403A8;
	Wed, 15 Apr 2026 06:43:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0DC3EC19424;
	Wed, 15 Apr 2026 06:43:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776235411;
	bh=3l4dmsvsnQyxf5GbIefFkBoRTtzYmP3a/BJez1WWJU0=;
	h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
	b=NmG1V1Qh8X51h9yFFz/RGI1o84gKp7RHsiOopESELjzBD3f9G2epzFGKqLdlrBBvM
	 85BRNDv9YgePWTAd/mWHoOfcVqkZ9t54hSGyPy5okYzBxuCsVMlJue+y2wSJhbVhIb
	 lb1DnIaWF178QVSBg4jx+V4/OFjaBNwtpoh3Tr4lJfjGJizmbNJlvTEiLyH2ILDjm+
	 9pOpGMDHM1wUUHlqTgOAicNu6S/pI86hh/KXo0HpBVSU8mvpdrsn1yE6nfT23v28aD
	 LJpZNPtQ4Ce9RQkXbclJOLPdj0XzY6SczhKB/CIS9XrbEQGTKPU35O7cIRgQtYcfwt
	 Wv24vurrRB4xg==
Message-ID: <0758843e-8f75-4c82-b9c0-25fab502e62f@kernel.org>
Date: Wed, 15 Apr 2026 08:43:21 +0200
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
Subject: Re: [patch 07/38] treewide: Consolidate cycles_t
To: Thomas Gleixner <tglx@kernel.org>, LKML <linux-kernel@vger.kernel.org>
Cc: Arnd Bergmann <arnd@arndb.de>, x86@kernel.org,
 Lu Baolu <baolu.lu@linux.intel.com>, iommu@lists.linux.dev,
 Michael Grzeschik <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org, David Woodhouse <dwmw2@infradead.org>,
 Bernie Thompson <bernie@plugable.com>, linux-fbdev@vger.kernel.org,
 Theodore Tso <tytso@mit.edu>, linux-ext4@vger.kernel.org,
 Andrew Morton <akpm@linux-foundation.org>,
 Uladzislau Rezki <urezki@gmail.com>, Marco Elver <elver@google.com>,
 Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
 Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Sailer <t.sailer@alumni.ethz.ch>, linux-hams@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>,
 Richard Henderson <richard.henderson@linaro.org>,
 linux-alpha@vger.kernel.org, Russell King <linux@armlinux.org.uk>,
 linux-arm-kernel@lists.infradead.org,
 Catalin Marinas <catalin.marinas@arm.com>,
 Huacai Chen <chenhuacai@kernel.org>, loongarch@lists.linux.dev,
 Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 Dinh Nguyen <dinguyen@kernel.org>, Jonas Bonn <jonas@southpole.se>,
 linux-openrisc@vger.kernel.org, Helge Deller <deller@gmx.de>,
 linux-parisc@vger.kernel.org, Michael Ellerman <mpe@ellerman.id.au>,
 linuxppc-dev@lists.ozlabs.org, Paul Walmsley <pjw@kernel.org>,
 linux-riscv@lists.infradead.org, Heiko Carstens <hca@linux.ibm.com>,
 linux-s390@vger.kernel.org, "David S. Miller" <davem@davemloft.net>,
 sparclinux@vger.kernel.org
References: <20260410120044.031381086@kernel.org>
 <20260410120318.045532623@kernel.org>
Content-Language: fr-FR
From: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
In-Reply-To: <20260410120318.045532623@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit



Le 10/04/2026 à 14:19, Thomas Gleixner a écrit :
> Most architectures define cycles_t as unsigned long execpt:
> 
>   - x86 requires it to be 64-bit independent of the 32-bit/64-bit build.
> 
>   - parisc and mips define it as unsigned int
> 
>     parisc has no real reason to do so as there are only a few usage sites
>     which either expand it to a 64-bit value or utilize only the lower
>     32bits.
> 
>     mips has no real requirement either.
> 
> Move the typedef to types.h and provide a config switch to enforce the
> 64-bit type for x86.
> 
> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
> ---
>   arch/Kconfig                       |    4 ++++
>   arch/alpha/include/asm/timex.h     |    3 ---
>   arch/arm/include/asm/timex.h       |    1 -
>   arch/loongarch/include/asm/timex.h |    2 --
>   arch/m68k/include/asm/timex.h      |    2 --
>   arch/mips/include/asm/timex.h      |    2 --
>   arch/nios2/include/asm/timex.h     |    2 --
>   arch/parisc/include/asm/timex.h    |    2 --
>   arch/powerpc/include/asm/timex.h   |    4 +---
>   arch/riscv/include/asm/timex.h     |    2 --
>   arch/s390/include/asm/timex.h      |    2 --
>   arch/sparc/include/asm/timex_64.h  |    1 -
>   arch/x86/Kconfig                   |    1 +
>   arch/x86/include/asm/tsc.h         |    2 --
>   include/asm-generic/timex.h        |    1 -
>   include/linux/types.h              |    6 ++++++
>   16 files changed, 12 insertions(+), 25 deletions(-)
> 
> --- a/arch/powerpc/include/asm/timex.h
> +++ b/arch/powerpc/include/asm/timex.h
> @@ -11,9 +11,7 @@
>   #include <asm/cputable.h>
>   #include <asm/vdso/timebase.h>
>   
> -typedef unsigned long cycles_t;
> -
> -static inline cycles_t get_cycles(void)
> +ostatic inline cycles_t get_cycles(void)

What is 'ostatic' ?

>   {
>   	return mftb();
>   }

