Return-Path: <linuxppc-dev+bounces-17438-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 4622AFEE4CB
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Feb 2026 05:47:25 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNDjl3X7Fz30hg;
	Sat, 28 Feb 2026 16:47:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772257643;
	cv=none; b=UeSidAiIug6fX3KUwpm69yvTEbHuuVoXEB4Nm+zwApc1qSyU56jbjm05zMZ4FsAHEj1mkMfIRUWBXkMGoPXujU7OCWg9BhgLIpXXoFYCUZW0bD7+bAkllbE4wB7g0vpOEVj62Ds8nPIIRu7EOZbaPxJDmi9VoIkeaMEVSg8m3eZXpfhmmlLUGTjZt/cquNcFVNqHLXEv1I6scSlO0pnI1NI66NaWQYI+Tt5UW0Jih9sB616j2soOseiavRB897jZSr0f9gnK1XEUk6tyMN9Ju6CaxBb7kXKWW4n6PwHw098C96qDoHGHGu0dQ5raLtRlTA5BtQvt6j0Oa2zA/KJ76w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772257643; c=relaxed/relaxed;
	bh=UZF1EV3uOejareY3JkuljGyR7tieZdU6/99rOblHojU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=bhDGvWVBMnC6bPjdYvxhcAqE93uaIOTppZrR9Nd86Pn09C1XgJZfS7ktoJcs4EsuPDNM1sjHfckDfXDHzyNcK9fNzslzDR8yziRghaYbMqQpJ+pCF/SuNBhnhm1/t/dyVpFtdcNjHVkkfxDBHpdDALQYPqa/L/PpiaQgM0Lvi/YXIVIMTNA+rmFW+nhtwPedSqtQzb0Es9MOrRkIz+WvzWuM/i2WiHL5EgHCrI/PUSgzryEISi34yBKGOF3DupHVt0s0KOPVAeqXvvSjUzmHvGxnSTSHbCbLysKkLsoB3kcRXL3pJUnfsHAsWh1ZeChszOoUZQ12LCG6jVIOzYNpbw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZxnCfx5J; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ZxnCfx5J;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNDjk3Rrhz30BR
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 16:47:22 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 2B33141E50;
	Sat, 28 Feb 2026 05:47:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E6374C116D0;
	Sat, 28 Feb 2026 05:47:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772257640;
	bh=3fhtDiEfYQIsR8xe5v1xLPzjOApnwt1LgQea0fiE/sk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ZxnCfx5JDI332Qrr3aqcMLFE+Z8TXsT+uailOd+3AxcXf1coTOZ7vF5OtRVlFz27S
	 I+XE3qJMsOy/NaWilUmpaeuY7J3oz+cG4Um71U6OgQ7NcFA0HIvDDJfrudH5EPWD3S
	 jPn9xscU5HDErluyyxksFTvSuNR6X2vG6RGaNlRTZxMmerYr0sgLOhE7L00/8t5/MJ
	 uNCGKSSPUVI6ufs4uUbVSf5rsbRTL4oD2BooogSyg1zZ0YWLvakCTY7IPYd2SyPwrp
	 50+eB5Q59+IeVeLCa8yNWJbEZz5QSmLw3fDIRjKAzMjZdSuoZa7lO1W7LFFthLj2/W
	 ELDld1Q34kANQ==
Date: Fri, 27 Feb 2026 21:47:16 -0800
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
Subject: Re: [PATCH 16/25] sparc: move the XOR code to lib/raid/
Message-ID: <20260228054716.GF65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-17-hch@lst.de>
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
In-Reply-To: <20260226151106.144735-17-hch@lst.de>

On Thu, Feb 26, 2026 at 07:10:28AM -0800, Christoph Hellwig wrote:
> diff --git a/arch/sparc/lib/xor.S b/lib/raid/xor/sparc/xor-niagara.S
> similarity index 53%
> rename from arch/sparc/lib/xor.S
> rename to lib/raid/xor/sparc/xor-niagara.S
> index 35461e3b2a9b..f8749a212eb3 100644
> --- a/arch/sparc/lib/xor.S
> +++ b/lib/raid/xor/sparc/xor-niagara.S
> @@ -1,11 +1,8 @@
>  /* SPDX-License-Identifier: GPL-2.0 */
>  /*
> - * arch/sparc64/lib/xor.S
> - *
>   * High speed xor_block operation for RAID4/5 utilizing the
> - * UltraSparc Visual Instruction Set and Niagara store-init/twin-load.
> + * Niagara store-init/twin-load.
>   *
> - * Copyright (C) 1997, 1999 Jakub Jelinek (jj@ultra.linux.cz)
>   * Copyright (C) 2006 David S. Miller <davem@davemloft.net>
>   */
>  
> @@ -16,343 +13,6 @@
>  #include <asm/dcu.h>
>  #include <asm/spitfire.h>
>  

<linux/export.h> can be removed from the two assembly files, since all
the invocations of EXPORT_SYMBOL() in them were removed.

Also, xor-niagara.S ended up without a .text directive at the beginning.
Probably it was unnecessary anyway.  However, this seems unintentional,
given that xor-vis.S still has it.

- Eric

