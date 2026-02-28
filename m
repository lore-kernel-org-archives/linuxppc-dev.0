Return-Path: <linuxppc-dev+bounces-17434-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 664E5FEE4C5
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Feb 2026 04:35:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNC6p5TlGz30BR;
	Sat, 28 Feb 2026 15:35:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772253330;
	cv=none; b=oznns5lIsE4UlQXo3a3WgKIXsK2VKmjnIFMC7A6KYGh9kd5S7bY4YyIktqvM3z2Zx9WnEm5F9NXIBXxuOkueLUnHFo7CIwK5aauRhTiPogI+8Tqw42rSF0/CTn/wZSAKzIgnmEpaZ+oC0COseYcwihYEAk7ly5l5xRPbXMFvQ8SioDUDtdHCNmRCsF7vnLVPefesdpe+rB1h2CnM/9gFPxjLMBwx5Z/X01dlGxt/XrpUCt0oUmp4f4Po02iqF4ncsTUSwesc9YYb2F71XrKWuRUbmGC3bUoeCwBF8LjORUOsOwcocJHJvc9OwvL6/K4R4QJsEhjPLEnUyJWnFM2GEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772253330; c=relaxed/relaxed;
	bh=a4/HdkUFGu6SFVOsDJPzYjExpCDKt+qABe3apagq8N4=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=LwscCbWlicFNKD/8s3YXvTKGPQ81MChxAXIqiTn6YStPzQcAwoH4z6/zH6dEJwfZM6HRAi9jBLzg4QDe0xkEqdeNVSTvNWpEmyrIAqlPBeIUgLmfYJ5yjIDxdM6HYFZe3oYeA7eI4gk4lgQH91lCiL0Z05k1GndcIEgskKvAK2XWpCpyJcBYoB1mo3lFAQZB7/BhP6EbgB16tTdyxO66omWuMG6ZYgbOD9Lx7wb+Iwa2/mXQx7E/Cv4qiXYpGAW0oaFupgTr1tANcBFfyD/WPxZywGcMTaz92C/jIMOkl7Hcz0eb6LhkhkpjmAQdgXEkFjbN+1jiw+/EIcnJoSZG3A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jvLMWT5Q; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=jvLMWT5Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNC6n5FlQz2xlj
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 15:35:29 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 7D89B43B42;
	Sat, 28 Feb 2026 04:35:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 69FD3C116D0;
	Sat, 28 Feb 2026 04:35:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772253327;
	bh=7zmaVKtAh2Ji/dO9zQKMopZe2cxR3kulm8/sTdUvOcA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=jvLMWT5QPfWf5fqwCu0b6jyf1JkY8VhTv+hzjbPZJIShl575Kc/hb2XB6K7qkymfN
	 qwBqh029UG4QDt1k4o+yWv6HUuKWpWsplNNhaICJZz2k0ORPmJLnhkHAyONmX7M+TQ
	 zDX6zjqvLirKpTtriXBUSdvtk9Yk8/30R2kYnR4XhUkO0qR3hMOqza11uJQ08QFz4S
	 oQboCK+Z7P0MYthrxKSIcy3roPsAHLbVtIrOmNmHcNMgysOz0VoIhFow1SEkkuFGuP
	 DaFupym5qTt9eY/XGsZgNFTL4RRcp5VoPtcdKHWNHmTzORlfM9TjONCOU+EFM4pkgz
	 p45HIHdqNKblg==
Date: Fri, 27 Feb 2026 20:35:23 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	"Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Paul Walmsley <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	"David S. Miller" <davem@davemloft.net>,
	Andreas Larsson <andreas@gaisler.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Thomas Gleixner <tglx@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Herbert Xu <herbert@gondor.apana.org.au>,
	Dan Williams <dan.j.williams@intel.com>, Chris Mason <clm@fb.com>,
	David Sterba <dsterba@suse.com>, Arnd Bergmann <arnd@arndb.de>,
	Song Liu <song@kernel.org>, Yu Kuai <yukuai@fnnas.com>,
	Li Nan <linan122@huawei.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: [PATCH 04/25] xor: move to lib/raid/
Message-ID: <20260228043523.GB65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-5-hch@lst.de>
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
In-Reply-To: <20260226151106.144735-5-hch@lst.de>

On Thu, Feb 26, 2026 at 07:10:16AM -0800, Christoph Hellwig wrote:
> diff --git a/lib/Kconfig b/lib/Kconfig
> index 0f2fb9610647..5be57adcd454 100644
> --- a/lib/Kconfig
> +++ b/lib/Kconfig
> @@ -138,6 +138,7 @@ config TRACE_MMIO_ACCESS
>  
>  source "lib/crc/Kconfig"
>  source "lib/crypto/Kconfig"
> +source "lib/raid/Kconfig"

This adds lib/raid/ alongside the existing lib/raid6/ directory.  Is
that the intended final state, or is the intent for the code in
lib/raid6/ to eventually be moved to a subdirectory of lib/raid/
(alongside the "xor" subdirectory)?

> diff --git a/lib/raid/Kconfig b/lib/raid/Kconfig
> new file mode 100644
> index 000000000000..4b720f3454a2
> --- /dev/null
> +++ b/lib/raid/Kconfig
> @@ -0,0 +1,3 @@
> +
> +config XOR_BLOCKS
> +	tristate
> diff --git a/lib/raid/Makefile b/lib/raid/Makefile
> new file mode 100644
> index 000000000000..382f2d1694bd
> --- /dev/null
> +++ b/lib/raid/Makefile
> @@ -0,0 +1,2 @@
> +
> +obj-y				+= xor/

Probably should add an SPDX-License-Identifier to these new files.

- Eric

