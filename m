Return-Path: <linuxppc-dev+bounces-19816-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 07158F8D771
	for <linuxppc-dev@archiver.kernel.org>; Thu, 16 Apr 2026 19:29:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxSl72H4fz2yYK;
	Fri, 17 Apr 2026 05:29:55 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776367795;
	cv=none; b=n3X+UwMJKmBHm2acE779HqGSv5P7Pvd9+cJ6x1KwKrtG7xEwm4Dnvy0i4osTRU/BGaLjGWd6FDdOWN9nQNf19U3a6Eh05v/+ek3yn64X6rDKC5QAEO8m458n2rlbdrcgR9B44oFyvz/9M4CT0Zxl2NZTITw8gnr60Z6p/czElhQmQ+uF7KlxnD7HPtBC3X4/H5Nz0/pjtg80pOi8G4vnw90YewO64Cpof6khw+kPrGtEM/fr/GTmi1CGkUE4PBLgJXjlJSAXj0u8YeYttQWTCg4aVEFwrNFLeIx8jvNsBrog7Iqd3VOhRW43gQ/OrMdBvFHIYB8vUsHoSaQZM+wN3g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776367795; c=relaxed/relaxed;
	bh=zUHI/uE+8wXb1NPS5/0fe9BrIRorqRCB+r5YbC8Vm6c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:Message-ID:
	 MIME-Version:Content-Type; b=jFi8vHj5ugbolKsDy5jMgPhrYHEO2LsFQ4UaSdQkYq3BZrn0W8aSNWeyB1JtrEYquBubuJXzeBF4V8047so6h82t4ZLC/p8fYkwyQZD/flgPUVfTyqqgh96laV8/pT9j/QfmYY30+rJDbQm0gCHxmDEzIATDTIJVeSvN0nJbomnNkoKAarnZjqYA0TZlxZaIYy0dZ3BlYxzyIEulyHK+VUmVCuMskIBuDS3E7NVLziskR1ipbxcAKdsENu/gIfjzlP52ls2vjLdU458vuw+mYOK4OjEV2WsQPtlO9IsdSv2jWlgaJ3QVM09jhU3hhSkNJ9MIiPOA2NBusfH555PcLA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TjiRJ3JY; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=TjiRJ3JY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=tglx@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxSl64MV3z2yVt
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 05:29:54 +1000 (AEST)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id CA94660127;
	Thu, 16 Apr 2026 19:29:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55F0EC2BCAF;
	Thu, 16 Apr 2026 19:29:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1776367790;
	bh=IYYhpzvOPkjnKmWSOWOV2gjFmCyUK20pzUwsrPCl5+c=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=TjiRJ3JYC6H6QODlRe73weMWqu2ToVyxgZaKwDYZeUuXvTFyEukiq8tmP1ejDxYzD
	 rmrx12vxM0g7ZC9obrRxDAfB+VnhJNvbWfFDZNFPe0bmQhLp4LsxxAr5syn+ysbEnb
	 CJFNwSq3IzVphxzvT3UyUKOg1K7FQt/yAeF/6TILljylkaralKACrM4Mn6BgOOeIKv
	 wGHlIow7JIanfsrwpPNBBsFvw34FcmmRQCfrRZvueDO/yyXUoANoGReW/3j6l4sYGi
	 SDFU6WZgysyVavWZIkFYQOfBKcrZOljXUSUoxloeAjzhJrasftfXxGpcy4vC+O3xsf
	 ay/dWzrcNvMPQ==
From: Thomas Gleixner <tglx@kernel.org>
To: Heiko Carstens <hca@linux.ibm.com>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-s390@vger.kernel.org, Arnd
 Bergmann <arnd@arndb.de>, x86@kernel.org, Lu Baolu
 <baolu.lu@linux.intel.com>, iommu@lists.linux.dev, Michael Grzeschik
 <m.grzeschik@pengutronix.de>, netdev@vger.kernel.org,
 linux-wireless@vger.kernel.org, Herbert Xu <herbert@gondor.apana.org.au>,
 linux-crypto@vger.kernel.org, Vlastimil Babka <vbabka@kernel.org>,
 linux-mm@kvack.org, David Woodhouse <dwmw2@infradead.org>, Bernie Thompson
 <bernie@plugable.com>, linux-fbdev@vger.kernel.org, Theodore Tso
 <tytso@mit.edu>, linux-ext4@vger.kernel.org, Andrew Morton
 <akpm@linux-foundation.org>, Uladzislau Rezki <urezki@gmail.com>, Marco
 Elver <elver@google.com>, Dmitry Vyukov <dvyukov@google.com>,
 kasan-dev@googlegroups.com, Andrey Ryabinin <ryabinin.a.a@gmail.com>,
 Thomas Sailer <t.sailer@alumni.ethz.ch>, linux-hams@vger.kernel.org,
 "Jason A. Donenfeld" <Jason@zx2c4.com>, Richard Henderson
 <richard.henderson@linaro.org>, linux-alpha@vger.kernel.org, Russell King
 <linux@armlinux.org.uk>, linux-arm-kernel@lists.infradead.org, Catalin
 Marinas <catalin.marinas@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 loongarch@lists.linux.dev, Geert Uytterhoeven <geert@linux-m68k.org>,
 linux-m68k@lists.linux-m68k.org, Dinh Nguyen <dinguyen@kernel.org>, Jonas
 Bonn <jonas@southpole.se>, linux-openrisc@vger.kernel.org, Helge Deller
 <deller@gmx.de>, linux-parisc@vger.kernel.org, Michael Ellerman
 <mpe@ellerman.id.au>, linuxppc-dev@lists.ozlabs.org, Paul Walmsley
 <pjw@kernel.org>, linux-riscv@lists.infradead.org, "David S. Miller"
 <davem@davemloft.net>, sparclinux@vger.kernel.org
Subject: Re: [patch 35/38] s390: Select ARCH_HAS_RANDOM_ENTROPY
In-Reply-To: <20260416134238.9230Ba6-hca@linux.ibm.com>
References: <20260410120044.031381086@kernel.org>
 <20260410120319.924028412@kernel.org>
 <20260416134238.9230Ba6-hca@linux.ibm.com>
Date: Thu, 16 Apr 2026 21:29:46 +0200
Message-ID: <87y0imemad.ffs@tglx>
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
Content-Type: text/plain

On Thu, Apr 16 2026 at 15:42, Heiko Carstens wrote:
> On Fri, Apr 10, 2026 at 02:21:19PM +0200, Thomas Gleixner wrote:
>> The only remaining non-architecture usage of get_cycles() is to provide
>> random_get_entropy().
>> 
>> Switch s390 over to the new scheme of selecting ARCH_HAS_RANDOM_ENTROPY and
>> providing random_get_entropy() in asm/random.h.
>> 
>> Add 'asm/timex.h' includes to the relevant files, so the global include can
>> be removed once all architectures are converted over.
>> 
>> Signed-off-by: Thomas Gleixner <tglx@kernel.org>
>> Cc: Heiko Carstens <hca@linux.ibm.com>
>> Cc: linux-s390@vger.kernel.org
>> ---
>>  arch/s390/Kconfig              |    1 +
>>  arch/s390/include/asm/random.h |   12 ++++++++++++
>>  arch/s390/include/asm/timex.h  |    6 ------
>>  arch/s390/kernel/time.c        |    1 +
>>  arch/s390/kernel/vtime.c       |    1 +
>>  5 files changed, 15 insertions(+), 6 deletions(-)
>
> Acked-by: Heiko Carstens <hca@linux.ibm.com>
>
> Thomas, would you mind adding the below as minor improvement to this
> series?

Sure. I'll respin it next week.

