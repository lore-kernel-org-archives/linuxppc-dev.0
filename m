Return-Path: <linuxppc-dev+bounces-17444-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CF62FEE4CC
	for <linuxppc-dev@archiver.kernel.org>; Sat, 28 Feb 2026 07:15:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fNGgN6kwbz30hg;
	Sat, 28 Feb 2026 18:15:28 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772262928;
	cv=none; b=R/vuKp5948zHo9WBsBf4aEtGSyXFewm0f0cm5pp6U9SEMbh6XKx3JVDJv5zwG0EQ1akHbOhrRFv8wxWwsxuU9/3na/46E3xxvPblfJZy4jXdpw78NqmDDDpdLVl0tx+uG2JXq0Fw399AyZCOaJ8HkcJde1WkdfeimrBz4xobk8lg60KWXHPXx+ksUmqjy+QTWk+plCC5dTzkD6oIh/xveNMwo9tt8B80aaiH8wneRHhe44CmdQA1wG+etA26IgnKhssaDiMLgYCzEec7umUhHNHmJVykIynyirLWzBmsXN4pl1wvierySAaUZ4UKsC6i7FRb7wDA+Y3j2sCfA/nROg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772262928; c=relaxed/relaxed;
	bh=3y/IqGod0OtoNjM34bJe5aCjje6al8v83ndNN1uCr6A=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=aNEesA0tjO9m29QG4I0aMj+xec67nDYQS+qkH/F+xTW8SeMb40qKfh6do7wRL4k/rLOcWbLNOBmBI8i1MfSUba05rWihFlbo1sf3G9ivZpkNYSRpMmOhg9x5xil52XTDBloFKoZ38dh4lBli2wAO1qfuwvTZy43sPbVFX43/+7piGHTlut2ihXEt0W9PsffWxH5RBox97mGY9NG8JK98L0O18plkBlDCxUfONsIhXOLvXf1Bv2U7MSKna9ZK1RcJTgINp6KanvAsc+9S7+ZtgDNR2mL6d3L+iHi6o1PNaMOZGPjPADfsWl77kgMuLWYMl7jHGRVIPKJqPxuFLZ8XEg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Vz3k8kyT; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=Vz3k8kyT;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fNGgN0YRTz30BR
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 18:15:28 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id B403E6001D;
	Sat, 28 Feb 2026 07:15:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 39044C116D0;
	Sat, 28 Feb 2026 07:15:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772262925;
	bh=zWqt8Joca1KvplCXgcwLYttswt0fM6g1E9UxDDRiVTY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=Vz3k8kyTWZXHMK5zn7xXibfO3tQ+c+PplCLKYAb/nEXG6XVyxylOPTDzXmct2v/wF
	 WmaMWfVwV7ygt8481V3ntzFPARMBXxozM0S4vYM+fu8NTjVMCeXuO/SMU92oOtftWp
	 YviS01hMbTL4Nkd5vseytV1ImcKk3TWqfzHY4gUzr3YvSM+tsz1IZkLgKG1gW+KaxO
	 rZfmvPr+C7N697Fz2WWHkMDqBLHLN/FfRu//s+ea1lU/Ju8ebw+5Si06It93glm1Ff
	 QePblciurUn+VamkBgtZHIFv4AD004DBjvXkKZVZLJlMvZ9IVJkH2jsgcBMJr2hP7p
	 3dV2gvb5/dQtw==
Date: Fri, 27 Feb 2026 23:15:21 -0800
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
Subject: Re: [PATCH 09/25] xor: move generic implementations out of
 asm-generic/xor.h
Message-ID: <20260228071521.GK65277@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-10-hch@lst.de>
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
In-Reply-To: <20260226151106.144735-10-hch@lst.de>

On Thu, Feb 26, 2026 at 07:10:21AM -0800, Christoph Hellwig wrote:
> Move the generic implementations from asm-generic/xor.h to
> per-implementaion .c files in lib/raid.
> 
> Note that this would cause the second xor_block_8regs instance created by
> arch/arm/lib/xor-neon.c to be generated instead of discarded as dead
> code, so add a NO_TEMPLATE symbol to disable it for this case.
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>

This makes the generic code always be included in xor.ko, even when the
architecture doesn't need it.  For example, x86_64 doesn't need it,
since it always selects either the AVX or SSE code.

Have you considered putting the generic code in xor-core.c (or in
headers included by it) before xor_arch.h is included, and putting
__maybe_unused on the xor_block_template structs?  Then they'll still be
available for arch_xor_init() to use, but any of them that aren't used
in a particular build will be optimized out as dead code by the
compiler.

lib/crc/ and lib/crypto/ take a similar approach for most algorithms.

- Eric

