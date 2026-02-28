Return-Path: <linuxppc-dev+bounces-17436-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 0BE83FEE4C4
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Feb 2026 04:44:03 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNCJd2sPKz30BR;
	Sat, 28 Feb 2026 15:44:01 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772253841;
	cv=none; b=ZY43JsLlcgGySDNNahQV3WTU4q2NzW5OnYLgQzJGNpTs3HGH1kK7NyWPnDIX3YOJcqJ79L4CEKk6xote+Wopm/4oD8eimuXE28gMa8+tjlxsSxT9Bdtrj4owP+5BEZnZ6n3eWQ0DHSR/PEDQSIgx18s27lLFyWx7nVLIcncbm6n8KthewHzv1RIIPCXuFyr13yv9/6GrXcxhEOeRnQPrGJT10Vmc3HQmKAc7F0b9Krs9Cu1cCeZC1mGKqBH9c+dLP1xExpmhNDLdp+7LIBR4UjvtxrKCx/vYTTryx9UahDEyOfiw9Cv8dzQKnqWwA8gj6K+3EUvVUiBsQFkvaPBOoA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772253841; c=relaxed/relaxed;
	bh=hTTnDcnDoYmcoNie9tHbMTIizvVqtd87Tnc3PFg/feQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=FjDtttb7OAlglSRHBrkKC+ZOydQ35XT6IrwQQNCs2iZSppFlPvmR3LBecvzHQViG7Rb5xCxzB9Jf80EOJga1bG+SrPfl3Tml8fbSMky4dQ6m+Lv+4XBTY47bI1yUbResvMXxrqV226jifCnO8AtFbJFAcPoErUpDCHYs0vK2d+q+mAt2cajhE76fmN6a+2zDu/xVPfYN1IHUTYvqQz+HZ52Ir4Vm3I3jrsSy83s1BHIS1GjoEtJbnxtgNJYfy9CeAxf7vD3HqS02VYIcs7kFbIiYzUcwqQ/XVaWdscYWRYdyFSq1bjbpYVk9QFOH4KdCCqC9NJS8b0F/wm44O285aQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PuoEPD5d; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=PuoEPD5d;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNCJc5wY0z2xlj
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 15:44:00 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id AF29C438ED;
	Sat, 28 Feb 2026 04:43:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B7B7EC116D0;
	Sat, 28 Feb 2026 04:43:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772253838;
	bh=yQS8EYr1F4rANaBe7v+3inxmWJU0zVKQEOlUsxymw4k=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=PuoEPD5dGKM2iOhSW+0my0D/f4VLvinBi2jt5Kbxbd81P1k+jWi0+KVciBAPrpL/g
	 r4r2NT2v38o9qtnIhfBxVgmjQSQJywLVObj3muDNlyHJqSESQCTZhmJe/6Rzsk2R9M
	 8ZnzLPFYGLtie7deDR1V8Pnkzre6yCwdaC1qBSQ9wNIL1XaAUgCSzSUwN7lW5l11mD
	 VW2gjQBqijiFVLqfxqw/TTKXHQthqIgVue3hQeJ64rdHrmcizqorwLbqqoBbwNSZH4
	 QorQ2T+BBBGPZMVwQBEeX4nOyWDWoKOqpyMPTJ5mdi+JknVW5oDrCxr9Qb4qEoWrJm
	 UhY0/KMibUBXA==
Date: Fri, 27 Feb 2026 20:43:55 -0800
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
Subject: Re: [PATCH 07/25] xor: split xor.h
Message-ID: <20260228044355.GD65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-8-hch@lst.de>
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
In-Reply-To: <20260226151106.144735-8-hch@lst.de>

On Thu, Feb 26, 2026 at 07:10:19AM -0800, Christoph Hellwig wrote:
> Keep xor.h for the public API, and split the struct xor_block_template
> definition that is only needed by the xor.ko core and
> architecture-specific optimizations into a separate xor_impl.h header.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> ---
>  arch/arm/lib/xor-neon.c       |  1 +
>  arch/s390/lib/xor.c           |  2 +-
>  include/linux/raid/xor.h      | 22 +---------------------
>  include/linux/raid/xor_impl.h | 25 +++++++++++++++++++++++++
>  lib/raid/xor/xor-core.c       |  1 +
>  5 files changed, 29 insertions(+), 22 deletions(-)
>  create mode 100644 include/linux/raid/xor_impl.h

arch/arm64/lib/xor-neon.c needs to be updated to include xor_impl.h.

- Eric

