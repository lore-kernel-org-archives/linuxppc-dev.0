Return-Path: <linuxppc-dev+bounces-28278-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BE5F0C98328
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Sep 2026 12:49:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hsS8G6fq9z2y7p;
	Sat, 26 Sep 2026 22:49:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790426990;
	cv=none; b=c1WfXMaiq5xeGqPAzxVQQhBwHotEdyURaWvqSsPp/SDLcR+AzlJDwrhiCxb3RMTvAUH+EpEGJzldJZuI2d9wv5YLS+EvmSDJlqNt63Pup/Qw5zO8rQZDnxZcc2jwQa19HJmAIs5HkJtX74w2IF/Rzhaz4pPFld049C/PJEJ1MoPn+4+Oyn++yq1EpVMurESSYHVtuS36u/14Vkl1FL1CxdoI02F8UFfQG45X5NE+qIBGRq1sC7jHaeXujunZ9vLjMzXl8pR1M9raAWmzvwXRgA688zQq9Z4yxKDm7zM/rfxEfPomRLenwiZ3EVlgE4u1AKacgf9j49DbUKokamvo2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790426990; c=relaxed/relaxed;
	bh=VcwH+9dD3jn1cikX304Fn2/psmP9ex3vbb4X9xZ4y0w=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=UCbEC5EgnAefRzpkFvgK7T6eH2JuhYUUKzirDtcK6O1egKnSOgMyNSZwpj5azX4tE9t9z74T9F4XGRtdZQ+BNajNWlbK4vnfaqbZy2xis/AmWCLQiCMmFUTAfd/v08+wUf9wkguTuOHREAGC74gile1qTtiK0UTQNFJEwoRmNIWnVGfI2V5xcPl0lZZM75eHbXE0hfcufbies27GKVjO3Gzyu5eDBK0AXVv9RFRII6/JYudWGZklIBNLr6dMviWPupJRmBQO3LcInzoZltFOl4VLBtFNFJfl6TWEmoyYTcf4pamRlZYiTGSdfJ9isy+PLdoqrABPIY9YQEPZuY7qgQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fd5egb/9; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fd5egb/9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hsS8G0Bcbz2y2K
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 22:49:50 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id AC4E943D49;
	Sat, 26 Sep 2026 12:49:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B6DC21F000FF;
	Sat, 26 Sep 2026 12:49:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790426987;
	bh=VcwH+9dD3jn1cikX304Fn2/psmP9ex3vbb4X9xZ4y0w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fd5egb/9VQIjjOqS4QVt0JCgY3CjQEWPCjDbq1JPvTO/u/NWzV+lbMU2GnucpD8Cg
	 fQBncBItUBiNpft5Xle3TNZkvASdQXwYT782WczpRC4jNHKnURx/VR4lMI4JBZAg4b
	 za0ej8mPU5YqIeMJVF26LmaALHmhJznID0Q97bqr7HNfNTSy14hNnajBL2yZtPoDr6
	 ZPeKxz/NhMbw/6kJedmpg94MnX+XYJsijQGDTgqkeXja/IGUPPqM+mRcQX86S0NU8a
	 AaymHjbxISsM0nBUg8bnqDkatbTzLbXwZiMwQwM34QeqRDonyX/y1rrUsoEZSMn7fp
	 RycokNiL9jKuw==
Date: Sat, 26 Sep 2026 13:49:38 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Andreas Schwab <schwab@linux-m68k.org>,
	Andy Lutomirski <luto@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>, Theodore Ts'o <tytso@mit.edu>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Nick Desaulniers <ndesaulniers@google.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
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
Message-ID: <20260926124938.GC1486962@ax162>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
 <87zex4ic68.fsf@linux-m68k.org>
 <20260926121927.GA1486962@ax162>
 <are7cfMIHZZn6jLz@zx2c4.com>
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
In-Reply-To: <are7cfMIHZZn6jLz@zx2c4.com>

On Sat, Sep 26, 2026 at 02:32:49PM +0200, Jason A. Donenfeld wrote:
> On Sat, Sep 26, 2026 at 01:19:27PM +0100, Nathan Chancellor wrote:
> > On Sat, Sep 26, 2026 at 11:39:43AM +0200, Andreas Schwab wrote:
> > > On Sep 25 2026, Nathan Chancellor wrote:
> > > 
> > > > +#if __has_builtin(__builtin_memset_inline)
> > > > +#define memset_inline(dst, value, size) __builtin_memset_inline(dst, value, size)
> > > > +#elif IS_ENABLED(CONFIG_CC_HAS_OPT_INLINE_MEMSET)
> > > > +#define memset_inline(dst, value, size) __builtin_memset(dst, value, size)
> > > > +#else
> > > > +static inline void *memset_inline(void *dst, int value, size_t size)
> > > > +{
> > > > +	char *d = dst;
> > > > +
> > > > +	while (size--)
> > > > +		*d++ = value;
> > > > +
> > > > +	return d;
> > > > +}
> > > > +#endif
> > > > +
> > > 
> > > memset actually returns the original pointer, not the incremented one.
> > > Nothing uses the return value of memset_inline here, but it is
> > > confusing.
> > 
> > Whoops, good catch, I guess my fingers gave up on those last two
> > characters :) I will fix this for v3 once there has been some time for
> > further review.
> 
> Do we even need to return a value at all? Might as well just make the
> function two lines:
> 
> +       for (char *d = dst; size--;)
> +               *d++ = value;

Yeah, good point, no point in returning something that we don't need
plus this is basically what we had before, just with a different pointer
type. Thanks for the suggestion.

> (Technically that could even be one, but maybe that sort of golf loses
> clarity. Your choice.)

I'll keep it two lines just for the sake of clarity.

-- 
Cheers,
Nathan

