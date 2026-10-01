Return-Path: <linuxppc-dev+bounces-28642-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 7C97ECA5FB3
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 11:03:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwTY83d1Nz2yTQ;
	Thu, 01 Oct 2026 21:03:24 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790852604;
	cv=none; b=k5fJuNeatK3bryYfFU6Dd41byqEX77jOBOctx024NkcO5SFEAECWQZ2b4neveP50XW8RvV8a8YBo1LtZndmssIbceQM2PQ1TzpV7KVCIdt4Mz2K8MFfwH29k9ill+PKqwwevZIZdl7BUSUWz/Xti8vVJmSjHpGCm/Y8BzBDtD1tfJJ3CBhuCX+EFRSxrfZvRWHhgF7UYyrDOUNAbbA1oQ+37lVV1YbRF2mXE6GpZVsMDDm7/0WklFdlPRODlhK5V6eMNDREU8ekdhzzWTuhZt4NzuDhv2qI5a7G/YQqWNWTJ/0A1IJmwY7UnuGf//iiP5Q7LvP/tZLsa596oU27fSA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790852604; c=relaxed/relaxed;
	bh=6Fz/XiVPQbxeCrS6Ooyx7iK8DZuaZzJa+GXwQ5Vs63Y=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I07cYk569icTjnLvPrNr0A+XZcnlupHmmo+jWmG4G0hDA3+TzwEHSwO/D4mJhYikuV41jDXWU+v6PsCc6H2OUKVwfYkkTlqkMwEy8cO8hDtb/9A31ioZ4Ka6j1dvJPbVWJscWoJC0OP0F7Ut4X/+qp0mznwTCpSyr5zZiFFHpjMlwEs9crlDc0Mapiv4Ytw8IvTA0QEcDhht4N29M1+6NX+zGePUbtyLu6UStUM3jgT+Ayk/DGNBQ3NEFT9mbhlyvdEoYCiMM3hb5/gtP43VmP2570t4MPccJo5u4IDnfUjAVvlMO6J9Xsq6YZ0jXHjgz3Z8XaQTAnlxy4VvTy7LDw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ilyZfZwc; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=ilyZfZwc;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwTY72K4Kz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 21:03:23 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D89AD401C2;
	Thu,  1 Oct 2026 11:03:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9AB1F00899;
	Thu,  1 Oct 2026 11:03:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790852600;
	bh=6Fz/XiVPQbxeCrS6Ooyx7iK8DZuaZzJa+GXwQ5Vs63Y=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=ilyZfZwcyiaalOxi9FuCnkRKhUhFz2Rp84s1uKKcWMtsnqyjRTK4chwYRwfKNBpcG
	 xSWBcawjlZQB5N6YjSTxTcpFx29bHpXUFY+OWY1TkZB40Znnbzavrt+0sofMnIlCUg
	 Od59qfNTDltB+xCARwtpINaIAgDE6VSmDVPbipxbZz19xRjIq2SM0ui5Q0u18s0Gtl
	 NeQeaadbEMr4KuuuBha6lwUTBYKyOGuVxY1TXFcDAM/cJYztQkrdJjzWvC7M2HCZFM
	 aTGy5tCkS+EUw48u7uFYxLL2NBl9H+HwOLOBoQLTpCYdKAAi0YFeiPNJ2tJBVrTE2s
	 KBIVWg2Z/PAVA==
Date: Thu, 1 Oct 2026 13:03:10 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>, Paul Walmsley <pjw@kernel.org>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>, Ingo Molnar <mingo@redhat.com>,
	Borislav Petkov <bp@alien8.de>,
	Dave Hansen <dave.hansen@linux.intel.com>,
	"H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
	linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
	loongarch@lists.linux.dev, linuxppc-dev@lists.ozlabs.org,
	linux-riscv@lists.infradead.org, linux-s390@vger.kernel.org,
	llvm@lists.linux.dev
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
Message-ID: <20261001110310.GA138012@ax162>
References: <CAKwvOd=BrMfFT88jsvBPhh383qqk5G+J07CsofNu0MVkziyhCg@mail.gmail.com>
 <20260930133813.GA3142230@ax162>
 <ar0a4b9CjL2YHCkY@zx2c4.com>
 <ar0gTS71qxnx9AkW@zx2c4.com>
 <20260930151337.GD3142230@ax162>
 <CAHmME9pA+AntJ6hWoFYpTVjh-NUSd0ZGXp5XiUuhQcq3HjQT3g@mail.gmail.com>
 <ede392d7-3104-4a0f-9fa1-99b22552dcd6@kernel.org>
 <ar4nD8aRH7wEvTMt@zx2c4.com>
 <20261001102059.GA4176271@ax162>
 <ar46ap4jzLWyP92C@zx2c4.com>
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
In-Reply-To: <ar46ap4jzLWyP92C@zx2c4.com>

On Thu, Oct 01, 2026 at 12:48:10PM +0200, Jason A. Donenfeld wrote:
> On Thu, Oct 01, 2026 at 12:20:59PM +0200, Nathan Chancellor wrote:
> > control. The change that introduced -max-store-memset only did it to
> > "allow fine-tuning of the inlining threshold for performance analysis
> > and optimization". If they decide to remove it for whatever reason,
> > we're back to square one.
> 
> I suppose all the more reason to get -finline-stringops=memset added to
> clang. Then the dual-default thing you came up with below will naturally
> start choosing the first option when it becomes available.

Fair point, I can file an issue with LLVM upstream.

> > I know something like below would be uglier due to the ifdef but it
> > would avoid changing anything for GCC while clearing up the issue at
> > hand for clang in a guaranteed stable and succinct manner.
> 
> But then we're back to the byte-by-byte codegen that Christophe pointed
> out.

I thought that was only because the fallback memset_inline() from v2 was
doing a byte-by-byte initialization? With my suggested diff, nothing
should change for GCC, as it does not have __builtin_memset_inline(), so
the "Before the patch" code generation that Christophe showed should
still be present.

> > If that is not acceptable, something like the following does appear to
> > work for me.
> 
> Okay, great, let's do that.
> 
> Does this commit seem okay with you? I used the diff you sent below and
> adjusted the commit message: https://git.zx2c4.com/linux-rng/commit/?id=56ff95ee85715047eb5b5220243778af657778c8

Yeah, that seems fine to me, thanks for taking care of it!

-- 
Cheers,
Nathan

