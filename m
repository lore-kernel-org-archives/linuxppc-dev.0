Return-Path: <linuxppc-dev+bounces-18984-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C4084FC97EA
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Mar 2026 21:31:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkSHj2HSQz2xQD;
	Mon, 30 Mar 2026 08:31:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774819889;
	cv=none; b=PNnvfhyi9Zx7l5RyGOAFJd2FnkC+tyITTGrM0p/LiETEmAXVx+cconv6RD5o74YM5Yr50V5BDmP7WhCZEtZyZw68TGTW6mioH+XvsPeMvO/B8B0DUvkJi12S1L7zjdMEkIickh13VHplwkNXLBZo/i6dIggm/YR3UgbNqHleFMbWcfpjOC3MV6V5RV1sOPLWTgrF6CSPzaRGkw8Uk9EF+zLoJD4+wJSkASP/Gy3vGdBEHV/gVJJxFhzquvaO4oXWbZMdaBskS2+8i+Q7R0G/6oHQr/bG6dfn7Qis+Bkxi0vUD6S8kLtHSBvamSTNslIns5Br1kNw58DpflSAIA4YhA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774819889; c=relaxed/relaxed;
	bh=j4CeAQMu9DQKqH07kUrTogoujHxmqR5Uldl+FpaannQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=KxDpeWL9XQM35Aa9+SD3TBLqgavbcDDahJigCUuY1Z9x1oaN2YGAKbfMTgr1ftflFEjWmf9MGG75CZhG0WCbdDBxTDHacRMchqk9VPnP+Vj6V/f2H01HgVqKw6FqEFMpA+GIN3Cqd6ORkWbEd/K+DaRQRXOgJB40hReySJcdJ8M9EALohTpyVjoaPrrYTCelQZv2B9eOh//AQBq7Fhagk5RVoougX0nVrW/zMhm3LotttmeqBuDeRqCFyLrMAneH3GZg7oXWpgsbSKLk8YcTjYS8RYQpnDOAPBgBCthphX7eDe/R/EsNkv5AtR0vDzUIfw2hCl+YTomo+Jt78DUgEw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ULb4+Wxd; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=ULb4+Wxd;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkSHg444Hz2xQB
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 08:31:27 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by sea.source.kernel.org (Postfix) with ESMTP id 4967F408C6;
	Sun, 29 Mar 2026 21:31:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2530AC116C6;
	Sun, 29 Mar 2026 21:31:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1774819885;
	bh=PZ1wpSjnIe92PCeQuI7dS0b860us4G2UnkohZEsZsEU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=ULb4+WxdcWS0LYY9+V+ZhbQ2W3+gIjbkOcw58cK44Qjr9h22rlhdWgqrzvN7R6PFm
	 JREZi4dijq69Gaojf+s0flL7jtbEMPdMc1H9xiVEXRPZGXJ+mlST60uJB7ykogcxSg
	 kmfGm8RBCtS/7B0rt59NZvGOlgpFTgi1GJtUu13b3N8GxcTN5UmObfYBhRebgAbOcw
	 s6hlqjkrksTerC1XE20F/dvAdRtaJ9guJhs99OCpaYdx7JLVTyioUmYJlr1WpZMw7X
	 u3sIge99HyZ1zxhIvJaxFTUekKZ6rH63KCJunK++uOHXMhMrLVzR5ifEDLGHmrI7Dj
	 yDWAS2zzXgozA==
Date: Sun, 29 Mar 2026 14:31:19 -0700
From: Eric Biggers <ebiggers@kernel.org>
To: Christoph Hellwig <hch@lst.de>
Cc: Andrew Morton <akpm@linux-foundation.org>,
	Richard Henderson <richard.henderson@linaro.org>,
	Matt Turner <mattst88@gmail.com>,
	Magnus Lindholm <linmag7@gmail.com>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Ard Biesheuvel <ardb@kernel.org>,
	Huacai Chen <chenhuacai@kernel.org>,
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
	Li Nan <linan122@huawei.com>, Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>, linux-alpha@vger.kernel.org,
	linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	sparclinux@vger.kernel.org, linux-um@lists.infradead.org,
	linux-crypto@vger.kernel.org, linux-btrfs@vger.kernel.org,
	linux-arch@vger.kernel.org, linux-raid@vger.kernel.org
Subject: Re: cleanup the RAID5 XOR library v4
Message-ID: <20260329213119.GA2106@quark>
References: <20260327061704.3707577-1-hch@lst.de>
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
In-Reply-To: <20260327061704.3707577-1-hch@lst.de>

On Fri, Mar 27, 2026 at 07:16:32AM +0100, Christoph Hellwig wrote:
> Hi all,
> 
> the XOR library used for the RAID5 parity is a bit of a mess right now.
> The main file sits in crypto/ despite not being cryptography and not
> using the crypto API, with the generic implementations sitting in
> include/asm-generic and the arch implementations sitting in an asm/
> header in theory.  The latter doesn't work for many cases, so
> architectures often build the code directly into the core kernel, or
> create another module for the architecture code.
> 
> Changes this to a single module in lib/ that also contains the
> architecture optimizations, similar to the library work Eric Biggers
> has done for the CRC and crypto libraries later.  After that it changes
> to better calling conventions that allow for smarter architecture
> implementations (although none is contained here yet), and uses
> static_call to avoid indirection function call overhead.
> 
> A git tree is also available here:
> 
>     git://git.infradead.org/users/hch/misc.git xor-improvements
> 
> Gitweb:
> 
>     https://git.infradead.org/?p=users/hch/misc.git;a=shortlog;h=refs/heads/xor-improvements
> 
> Changes since v3:
>  - switch away from lockdep_assert_preemption_enabled() again
>  - fix a @ reference in a kerneldoc comment.
>  - build the arm4regs implementation also without kernel-mode neon
>    support
>  - fix a pre-existing issue about mismatched attributes on arm64's
>    xor_block_inner_neon
>  - reject 0-sized xor request and adjust the kunit test case to not
>    generate them

Reviewed-by: Eric Biggers <ebiggers@kernel.org>

But yes, as Andrew mentioned there are two "xor: add a better public
API" patches.  They should be folded together.

- Eric

