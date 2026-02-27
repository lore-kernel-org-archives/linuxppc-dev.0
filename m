Return-Path: <linuxppc-dev+bounces-17429-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 9CAE91048922
	for <linuxppc-dev@archiver.kernel.org>; Fri, 27 Feb 2026 23:55:39 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fN4vs418Zz30T9;
	Sat, 28 Feb 2026 10:55:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c04:e001:324:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1772236537;
	cv=none; b=a2+VI4SYS62sqbvm6fJFouoBK8cCBl4DUSpu2QmC+zO7YRrA7v8sB5ZI7SbLMFCMXi0NNZxZqDA03OfxTgjyNHyo5anCWZlWYTWFoUZ4HcDzl3TW4yeRsLS53QnN8It1eT/wt2o6xGByUtkhEB1eSa3sdiOlA5DjJwTYcgQnj6Zpest1zrgXfRKqSWX/UlQDL9lc+ykGEOjAcNPELWHdWmCcV9UtA1cjjFljqLDXOu6xN9ggx3ctISUIj4kJnbl1F7XJfOaMvYD6XL8qbNkJj8rbS4cKYMcGW+g7pBG2c4lec33p7a/HomMiPhmzrxW5ILDFumv9bhStcxLCEgpWFw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1772236537; c=relaxed/relaxed;
	bh=OapKvdiEwQYu8NOR3j/Rtm7Hb+46RUg9fRdsdH5rsws=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f0ES3RVP1+KDed2HM4J0YX4kYspPwRllpUimiu8LSG6TBtk60Ji5RQrdbz4EXVCV2b9zN6ZUIOnmZixVu8yVcCyGBblQjZtB203JZyOxCNnzgzjCy2HLYGXX3OxrVVBZYMupDROLSLbuVi5oKlN8YoDsjW8zfoNl4Tkua8Jt2xWp9/oDRNO/7m0ne0Qq6ljRRw2wQgcrg9sAmyVclqjcjVxSCLltb8XI2ZdFjr0he4zCYpsruu1jR1ulRBmjLE5GZJJ69hiwdXoOC1RvKGYLC/Tt9qUd4dX55CUZjj/MxcjGtaXZxZh7a+sbC+8D3Sv64SEwfGXsBfGoXtAfNRwZLw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XVTF8TDa; dkim-atps=neutral; spf=pass (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20201202 header.b=XVTF8TDa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c04:e001:324:0:1991:8:25; helo=tor.source.kernel.org; envelope-from=ebiggers@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [IPv6:2600:3c04:e001:324:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fN4vr10Ctz30T8
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Feb 2026 10:55:36 +1100 (AEDT)
Received: from smtp.kernel.org (transwarp.subspace.kernel.org [100.75.92.58])
	by tor.source.kernel.org (Postfix) with ESMTP id 9859C6111B;
	Fri, 27 Feb 2026 23:55:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 97119C116C6;
	Fri, 27 Feb 2026 23:55:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=k20201202; t=1772236532;
	bh=9epsKT1Tqv7365SBQ+LgdgBkS+QLvJq0YDfqzGCQppg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=XVTF8TDa48poxgWx9OMrHOWcWeX+DIvF8W0Cz9PzVZzIIYVyeCBp8CVqVCQqnKv6k
	 5zzYRJst/PHEWqq92j85maQBi7plq+GNVhfHcc+9Pog+YMNqi1zTL7+4Ehtq9UJ7o9
	 QJHa0cD62wS9Zi36AMnb9/VkZXXyv/qc0FNC/OF8hsDCWgrlGfX7gqqn/VNAfN6Fee
	 CkNTC4E/BHSyzLgTwiN6IqzHfjJo9okaT9JcgxYGTsEHUQc31er3WUHfK/2Gx865yY
	 ogRz41c7RbSVwCM0hpH/O2zyx2nKKDpUW5eh/FdyMQPRe2Q68ih/qS1f7bbUEX5IYc
	 3kMoxNtkaet5g==
Date: Fri, 27 Feb 2026 15:55:29 -0800
From: Eric Biggers <ebiggers@kernel.org>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Christoph Hellwig <hch@lst.de>,
	Andrew Morton <akpm@linux-foundation.org>,
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
Subject: Re: [PATCH 18/25] x86: move the XOR code to lib/raid/
Message-ID: <20260227235529.GA31321@quark>
References: <20260226151106.144735-1-hch@lst.de>
 <20260226151106.144735-19-hch@lst.de>
 <20260227143016.GH1282955@noisy.programming.kicks-ass.net>
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
In-Reply-To: <20260227143016.GH1282955@noisy.programming.kicks-ass.net>

On Fri, Feb 27, 2026 at 03:30:16PM +0100, Peter Zijlstra wrote:
> On Thu, Feb 26, 2026 at 07:10:30AM -0800, Christoph Hellwig wrote:
> > Move the optimized XOR code out of line into lib/raid.
> > 
> > Signed-off-by: Christoph Hellwig <hch@lst.de>
> > ---
> >  arch/x86/include/asm/xor.h                    | 518 ++----------------
> >  arch/x86/include/asm/xor_64.h                 |  32 --
> >  lib/raid/xor/Makefile                         |   8 +
> >  .../xor_avx.h => lib/raid/xor/x86/xor-avx.c   |  14 +-
> >  .../xor_32.h => lib/raid/xor/x86/xor-mmx.c    |  60 +-
> >  lib/raid/xor/x86/xor-sse.c                    | 476 ++++++++++++++++
> 
> I gotta ask, why lib/raid/xor/$arch/ instead of something like
> arch/$arch/lib/xor ?

Similar to lib/crypto/ and lib/crc/, it allows the translation units
(either .c or .S files) containing architecture-optimized XOR code to be
included directly in the xor.ko module, where they should be.

Previously, these were always built into the core kernel even if
XOR_BLOCKS was 'n' or 'm', or they were built into a separate module
xor-neon.ko which xor.ko depended on.  So either the code was included
unnecessarily, or there was an extra module.

Technically we could instead have the lib makefile compile stuff in
arch/, but that would be unusual.  It's much cleaner to have the
directory structure match the build system.

If we made this code always built-in, like memcpy(), then we could put
it anywhere.  But (like many of the crypto and CRC algorithms) many
kernels don't need this code, and even if they do it may be needed only
by 'm' code.  So it makes sense to support tristate.

- Eric

