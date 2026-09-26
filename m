Return-Path: <linuxppc-dev+bounces-28274-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 185D0C98332
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Sep 2026 12:19:42 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hsRTT2Z1Mz2y7p;
	Sat, 26 Sep 2026 22:19:41 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2600:3c0a:e001:78e:0:1991:8:25"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790425181;
	cv=none; b=kNkdrNaXGU7CbQddgrtTv0QRGkZzkkufyulPelMAQaJgqWJFHkqTjSuBMiYGi0yZzWCuUHwLrGAwikptDJqAA5GfjV3w2z+nMf6GARdBnNvLZL44M8zkO42mnWfhbCEmMH02uTJC1KEVATdZYcZgzAUye2YjFehO2pb3PQWsEi4jzRKa0IS81bDrKONeRYkOapuwxhFfHCgteeVTeNK0yXL3oKTK0UZtOy1LN7MzF70yHH0mETRwCpn6ImHU1koOysFv3pDIYDw8asoBb6tU1jBiOUfqiEhpHzJid8BrGrmeBsZPKs4R12f7lq4KIdK+uADSsf5zwouIrGoTY5U1wA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790425181; c=relaxed/relaxed;
	bh=fX1UOorzk2WNkUzS8vq28akGhPcRScYxSKIHc7khZsE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jL8XzKOatq9bOcLiB2DH3yYYs/YvUh7trHDLJJLSGYqoJKlgWRegXJVH76164iM5vUXzQjP6y0BA3WggHOjJOhLGGU3dP6A57uzvnYt5W855d7mqZnJ2V14U24q23iPPo8//cKJg6XXvzxNB8boEsK0Qxi2lDNPtiEME9rw/J4+NvKFzmVesLe4j0hvelYZSE+eoj9MHoLZQUvhigF7TMV6ZY0L4AKvecfDCYmSLJPKi5DquinWOu3OjpuAFerYmp5mjq5cijQR2o/gQBnr4OqcESN2SKw8K1f/nyBaRvGsqvzxg9B8sTzRDOteWDkGWccn0n11xJlzETOybzjqNMQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUXIg6Sj; dkim-atps=neutral; spf=pass (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=fUXIg6Sj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=2600:3c0a:e001:78e:0:1991:8:25; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [IPv6:2600:3c0a:e001:78e:0:1991:8:25])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hsRTS3mZyz2xwM
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 22:19:40 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 22F39434A1;
	Sat, 26 Sep 2026 12:19:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20C6B1F000FF;
	Sat, 26 Sep 2026 12:19:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790425176;
	bh=fX1UOorzk2WNkUzS8vq28akGhPcRScYxSKIHc7khZsE=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=fUXIg6SjJk+Qr1M0g3x4kQiPdWY0pMcyzGHOa/cNhZMob/KEO2PpiVHQtdd6QWG3x
	 dZ1y+306fsaJBZodcxplS8L82NhW9YwwaaW61njzxIIsMh2aygiTjvDyx579LwgTlk
	 TiNEAn/LIYOFBCadmux7/TrQTROL8C9DBsngCTXN5FvYS+wlAGeerAjS/qGI8F8zSt
	 zNqskNZyO093mE4xSamxYt4pPd91MQE+lyJXBwlx8zyyl/XlWLoHwQD1qUMS1tbOL6
	 bgAKynwX99Ez+3lc/SWDJSSB8c5kqNCTcs0gDxMX99zbcw5tfAFyKVemNQNOkTs/aX
	 D6EfHEKDJYwZw==
Date: Sat, 26 Sep 2026 13:19:27 +0100
From: Nathan Chancellor <nathan@kernel.org>
To: Andreas Schwab <schwab@linux-m68k.org>
Cc: Andy Lutomirski <luto@kernel.org>, Thomas Gleixner <tglx@kernel.org>,
	Theodore Ts'o <tytso@mit.edu>,
	"Jason A. Donenfeld" <Jason@zx2c4.com>,
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
Message-ID: <20260926121927.GA1486962@ax162>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
 <87zex4ic68.fsf@linux-m68k.org>
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
In-Reply-To: <87zex4ic68.fsf@linux-m68k.org>

On Sat, Sep 26, 2026 at 11:39:43AM +0200, Andreas Schwab wrote:
> On Sep 25 2026, Nathan Chancellor wrote:
> 
> > +#if __has_builtin(__builtin_memset_inline)
> > +#define memset_inline(dst, value, size) __builtin_memset_inline(dst, value, size)
> > +#elif IS_ENABLED(CONFIG_CC_HAS_OPT_INLINE_MEMSET)
> > +#define memset_inline(dst, value, size) __builtin_memset(dst, value, size)
> > +#else
> > +static inline void *memset_inline(void *dst, int value, size_t size)
> > +{
> > +	char *d = dst;
> > +
> > +	while (size--)
> > +		*d++ = value;
> > +
> > +	return d;
> > +}
> > +#endif
> > +
> 
> memset actually returns the original pointer, not the incremented one.
> Nothing uses the return value of memset_inline here, but it is
> confusing.

Whoops, good catch, I guess my fingers gave up on those last two
characters :) I will fix this for v3 once there has been some time for
further review.

-- 
Cheers,
Nathan

