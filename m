Return-Path: <linuxppc-dev+bounces-17440-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CD6AFEE4CA
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Feb 2026 06:42:58 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNFxr5V9qz30hg;
	Sat, 28 Feb 2026 17:42:56 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772260976;
	cv=none; b=hYn7n/GzHbTE6NVDeOpiQ5zPb6TuqocLlusD+MlX8vbgcQyEn2Jo/VlIAfSV3Wq4dz06Vm0r9Aqd3VDqoEfbf9B9DisQzXo5Mn42f0RkkjqHbG6x/8H68LjvEanJFwRr2vPeY4aAgKk+kfV00bvwO5WSjtbdXRyMNJhzl87UNbHxVkLbSSgB1EeDU7zaUHZTKLYg84tQCdp9ktcByTKXanpJvom6grZ8adWkY6Rt8gE4LvI8H2v63FKKfE+X4wInBH9sxyinJUWlOdwxdS99VsBMasb5pwUtQDX95nkRGWoOfersYu4PDUflKX7WTglg7Dk8hKWAAi9eZ0yx6XiCGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772260976; c=relaxed/relaxed;
	bh=6IUKgULF8ycn4aiMjxbWgi7kwhcuo5AKCMo5sVjVXSI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=NrKxe+RoXxTalXdwN9XNRNHcWSqnWtojT7bPvThs/NMIfrztWxIFbIvmaiODRk8I6VlDYNZxkfFRi7nRAXGx9IV93l1q8/FhTLnZLoipcBeCJpDDUT+NEbLaj4OhFFk4CL3FT3leDwAiF/dOn6LK5Jmg/EVWTNwXvrf2CXmvfvlKS/UwgHvpEzxEgQbYAPN6Y6W99AdHEHQbFlVj9hPSmvbrT2VWuMS8P9LQnZSutQrmWBdjzcs+hhgys17yQiEIaemPyN2sS6UvrJX9GgJTAO5enzRDQIIQJMN679N/bF8Zz+88b8MmCuCzW1AokLASYpTG4JiMgbCsYoj49eqtnw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YClOM9Wk; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=YClOM9Wk;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNFxq6yspz30BR
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 17:42:55 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 36ED940A5D;
	Sat, 28 Feb 2026 06:42:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 32FCCC116D0;
	Sat, 28 Feb 2026 06:42:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772260973;
	bh=RjXh+3ODcjpkGCclxlZLerhUTxAgrS3+Qw6tdSUsizg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=YClOM9Wk3/7+pE7QyV7s9mlYuDllppl2YGLrTn0xkJ5pU3h4NtzzqxpXAgzhRI9N2
	 JuGJGprSvbiCiYCR4+DPFVLVUesA+9zY/ql1wKLu6GOJbDRJOE72dBApORguyRvSk0
	 Ip+z80iLf2XB3ZIQqPYK3ZEA4iixYi0/FOhgYq24wKd6cZqPgSNMaeZpzPpmIg/H3w
	 0n7sJMgccYUbEkKSe7BVVGr7K1ToaaAdi9JBbH+YWUnyRyLa4C5j5ZLWu0XZjJO8MA
	 f7GJPwidtEPGlIQhpocckRINXMDZxErl0fKAfQbViWFT5IVTuMqtgP4lHaU8x4cpN/
	 +BKrl6+TlJfNA==
Date: Fri, 27 Feb 2026 22:42:49 -0800
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
Subject: Re: [PATCH 20/25] xor: make xor.ko self-contained in lib/raid/
Message-ID: <20260228064249.GG65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-21-hch@lst.de>
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
In-Reply-To: <20260226151106.144735-21-hch@lst.de>

On Thu, Feb 26, 2026 at 07:10:32AM -0800, Christoph Hellwig wrote:
> diff --git a/arch/um/include/asm/xor.h b/lib/raid/xor/um/xor_arch.h
> similarity index 61%
> rename from arch/um/include/asm/xor.h
> rename to lib/raid/xor/um/xor_arch.h
> index c9ddedc19301..c75cd9caf792 100644
> --- a/arch/um/include/asm/xor.h
> +++ b/lib/raid/xor/um/xor_arch.h
> @@ -1,7 +1,4 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
> -#ifndef _ASM_UM_XOR_H
> -#define _ASM_UM_XOR_H
> -
>  #ifdef CONFIG_64BIT
>  #undef CONFIG_X86_32
>  #else
>  #define CONFIG_X86_32 1
>  #endif

Due to this change, the above code that sets CONFIG_X86_32 to the
opposite of CONFIG_64BIT is no longer included in xor-sse.c, which uses
CONFIG_X86_32.  So if the above code actually did anything, this change
would have broken it for xor-sse.c.  However, based on
arch/x86/um/Kconfig, CONFIG_X86_32 is always the opposite of
CONFIG_64BIT, so the above code actually has no effect.  Does that sound
right?

- Eric

