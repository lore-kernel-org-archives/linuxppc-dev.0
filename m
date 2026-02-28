Return-Path: <linuxppc-dev+bounces-17437-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1FDC9FEE4C8
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Feb 2026 05:37:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNDVX0SNBz30hg;
	Sat, 28 Feb 2026 16:37:40 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772257059;
	cv=none; b=czW4O32tUNyrDIXxOcDj13a4E/V36JDOXAUBvWeoMexbQn1aQRIxkZQSkr0B4l+O4v605sbptTL4dUatWl20l2dL1+lFK3gTqxIzthNWIIC1aVEeRJmEIZ+bU0ERU4aPH2MkYSV9PUCNGjEMQZfVuawCkPps3nZ6Auw01cpTe7krp/Sw1A2CyVEdyZuPy3bcraC2bdjVTZB+TXREFkOdPQJ+BY8/vhAmJ2grfaxDsxRHqZQyz7fPj+bY01vth5JyDm9P7whZM0m5QyVmTJiYxfATLZVgCT0B0kZJkfHnMndnMB+OOHL6PjLHcdAVS+b/LDLLmKujngjTx7QrZL8gfQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772257059; c=relaxed/relaxed;
	bh=pPKu8pyhkInpX09bIAbmlPH+OLoaLy8SUm0nQHgk8LI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=JDJVPOA+L0ZViq3UV812E1xeSOS5I+zD3JsRMYWyCZDMElGVNGETHDskFPEcShZ67L2xbuVSNKrIFgZbtCs9Vb+5+4Kc3U6bH6+wlg3/wNbr0u4RdU0UDeTtqYTypROUzvSUxOdk/DYnv4qv1aN4nE9bmS4R2H4NzAIfBjJpOzqDG5IgwGaz6UDv8sai2jbscakmbzyIo0hNYSLCJwfuC/T9RT7/c5zYcsAlXULk7AVAjNI1l7AtuoHwJn1viftU6hKPN7aKDXSBQsUWFVwBbdZ5YnGLrxGsxfov6EEuFc3AJkeXnriT21AROMn8rOy46fv6svaAY+izpP3yea4PNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vJAxXZ8K; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=vJAxXZ8K;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNDVV0Crsz30BR
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 16:37:37 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 555454064C;
	Sat, 28 Feb 2026 05:37:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BE76EC116D0;
	Sat, 28 Feb 2026 05:37:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772257055;
	bh=eqLNM+it9jPNWRs+scO49PSKMIRVyGiqn9NcqSlCp7w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=vJAxXZ8Kz5WRI3FAqQiiWltyd3uQ9vRfiXCgBQwT4V+lApPXGfBKpNyhyElFSuB3u
	 XB4VENMAfKNQt4jt5mepYgezGyP/JFcan/V5g78ruKQj4Ji3BOedSoLRvaGOzY6b7q
	 Mc5XWWLUQF0PcVSlTTmo7S7Zck6GQKRu3zWFaP+B5XItpiitYzcZpUfca6qi8XUfOd
	 6vh1cIQZcaLVpiV5n3ZguAWWWmPlxPcj2Nj9plSsomBCSSLqZZekWhAfjQ2YeYW7iu
	 rDzWS5l+PL0z3I+4kxGk4sYmPecb+wzM6vyPcl7Y9d2Uxa1CYls2Am5BPUZnt/qH5z
	 mB77YqO/RTn8A==
Date: Fri, 27 Feb 2026 21:37:30 -0800
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
Subject: Re: [PATCH 15/25] riscv: move the XOR code to lib/raid/
Message-ID: <20260228053730.GE65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-16-hch@lst.de>
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
In-Reply-To: <20260226151106.144735-16-hch@lst.de>

On Thu, Feb 26, 2026 at 07:10:27AM -0800, Christoph Hellwig wrote:
> Move the optimized XOR into lib/raid and include it it in xor.ko
> instead of always building it into the main kernel image.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/riscv/include/asm/xor.h                 | 54 +------------------
>  arch/riscv/lib/Makefile                      |  1 -
>  lib/raid/xor/Makefile                        |  1 +
>  lib/raid/xor/riscv/xor-glue.c                | 56 ++++++++++++++++++++
>  {arch/riscv/lib => lib/raid/xor/riscv}/xor.S |  0

The EXPORT_SYMBOL() statements in xor.S can be removed, since the
functions are now located in the same module as their callers.

- Eric

