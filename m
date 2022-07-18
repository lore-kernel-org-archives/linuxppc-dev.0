Return-Path: <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D35C43334
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Jul 2022 12:54:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [IPv6:::1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4Lmhk54KQBz3bkZ
	for <linuxppc-dev@archiver.kernel.org>; Mon, 18 Jul 2022 22:54:21 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=rYUSYTCm;
	dkim-atps=neutral
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4LmhjR6sVcz2xTj
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Jul 2022 22:53:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=ellerman.id.au header.i=@ellerman.id.au header.a=rsa-sha256 header.s=201909 header.b=rYUSYTCm;
	dkim-atps=neutral
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
	(No client certificate requested)
	by mail.ozlabs.org (Postfix) with ESMTPSA id 4LmhjM6Tyvz4xL4;
	Mon, 18 Jul 2022 22:53:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
	s=201909; t=1658148826;
	bh=SgPxyBJcHGr81rN/PCtKiWXwYtSKRO2w9sb5M0yS/pU=;
	h=From:To:Cc:Subject:In-Reply-To:References:Date:From;
	b=rYUSYTCmldp3zN6k/ysHQC4QOd4JlL88muNz4v08jJK1s2WGTd3Mzi3YvFcU0K1vn
	 W9DjCRjYAUlAqCOsgnj9C2L03vYDPzdtzucwIqSf9LlRFHwnOxDjFTzYnRJ7sF7Qh7
	 s7WWq+PLlyqwqYFgoflfRl2VvnXJyrMtwl/lsuIfyzK3l1gMB3Crb5m0jy6Mxv5+Dh
	 aGLrf18lWzXpBPZggcYl8BALR0j3fUTopMtowWx4R5DdSKPEOSU5EIjA0QWTpE5Yrx
	 TOB8RIY3sLW94KzeZkoH+eaXTCtIMN8zUbNlcSlD+ryvYxI0pWTlI+XB/pQMZmjzg0
	 n4k9AuAcZSRYQ==
From: Michael Ellerman <mpe@ellerman.id.au>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>, Borislav Petkov <bp@alien8.de>,
 "H. Peter Anvin" <hpa@zytor.com>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, linux-s390@vger.kernel.org,
 linux-kernel@vger.kernel.org, x86@kernel.org, Catalin Marinas
 <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, Heiko Carstens
 <hca@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, Thomas
 Gleixner <tglx@linutronix.de>, Greg Kroah-Hartman
 <gregkh@linuxfoundation.org>, Arnd Bergmann <arnd@arndb.de>, Borislav
 Petkov <bp@suse.de>
Subject: Re: [PATCH v5] random: remove CONFIG_ARCH_RANDOM
In-Reply-To: <20220708004032.733426-1-Jason@zx2c4.com>
References: <20220706143521.459565-1-Jason@zx2c4.com>
 <20220708004032.733426-1-Jason@zx2c4.com>
Date: Mon, 18 Jul 2022 22:53:38 +1000
Message-ID: <877d4aeg4t.fsf@mpe.ellerman.id.au>
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
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev" <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

"Jason A. Donenfeld" <Jason@zx2c4.com> writes:
> When RDRAND was introduced, there was much discussion on whether it
> should be trusted and how the kernel should handle that. Initially, two
> mechanisms cropped up, CONFIG_ARCH_RANDOM, a compile time switch, and
> "nordrand", a boot-time switch.
...
>
>  arch/arm/include/asm/archrandom.h             |  2 ++
>  arch/arm64/Kconfig                            |  8 ------
>  arch/arm64/include/asm/archrandom.h           | 10 --------
>  arch/arm64/kernel/cpufeature.c                |  2 --
>  arch/powerpc/Kconfig                          |  3 ---
>  arch/powerpc/include/asm/archrandom.h         |  3 ---
>  arch/powerpc/include/asm/machdep.h            |  2 --
>  arch/powerpc/platforms/microwatt/Kconfig      |  1 -
>  arch/powerpc/platforms/powernv/Kconfig        |  1 -
>  arch/powerpc/platforms/pseries/Kconfig        |  1 -

Acked-by: Michael Ellerman <mpe@ellerman.id.au> (powerpc)

cheers
