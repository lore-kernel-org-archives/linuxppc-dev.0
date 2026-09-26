Return-Path: <linuxppc-dev+bounces-28276-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 14BE0C98332
	for <linuxppc-dev@archiver.kernel.org>; Sat, 26 Sep 2026 12:33:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hsRmz53Lhz30Nl;
	Sat, 26 Sep 2026 22:33:07 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.105.4.254
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790425987;
	cv=none; b=KtlqR21D7QxdMVKzK3fQ03UqN2IJA6la76FIQjtnrQgTzL7Pvc9NFt6KVtTcFhAAZwTv/BQpTO4JHN1WLxFyU5hji5u+b31T8ZCR0An2JKAGx0lV7dT8ix7/XrQShsganRiHwHt7zoCnP7zzy5yP0omw/UpDPoyXMi5oBAMXibszunfsZXFBnDbmNjcEXGMPaf+F225UqiLdvFmetppHKtn1YAzoISn9f1WvD6HyscXh1EuYglpthg0avcga7L07X2HYZNGqK0TUMtYI7eJJ1EB8KbJZ3nq/OTmOeLxp8C0Pur/WkITpZJKpcXYrcOg27Fkx4NKlJ895DVi+u3AKsA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790425987; c=relaxed/relaxed;
	bh=wN9D2nKA01y/2x8IJdWZfEnnjMzwFRK3N4mVnSJjkBY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=B90nciwsm2rezXujeQu9osrlNPKSCakTQ56+kr0LGRBmsJWsdvufHIMZKAsNojszQ39NOMaXyGAeuLMCbPRaSmPUhPtegBjdgkNVgzGpDeVRYiX3g1yhPgBP4x1XH18rE3iiDGKM93m7wRdd6eb8yV3dBpZIXR5/v/c/Q9KWnD+dJ5s/dlYMe0+FjA/FsMTcCr47XLfYXk41okHOaei+FQxtzSkCuTJcYI4isu1Z8eKStRrn48oSp0y0Qn7LBCZIRrwaYy93sBO3R2alqNMZhk5EMXdC86IPFSQbGOtKl7Balxvf3swQWMVKyXqsuxyehIxscIrjj1zRu8J63V6N+g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com; dkim=pass (1024-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=jlCeeByi; dkim-atps=neutral; spf=pass (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=vbjr=hs=zx2c4.com=jason@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=jlCeeByi;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.105.4.254; helo=tor.source.kernel.org; envelope-from=srs0=vbjr=hs=zx2c4.com=jason@kernel.org; receiver=lists.ozlabs.org)
Received: from tor.source.kernel.org (tor.source.kernel.org [172.105.4.254])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hsRmy63kHz2y7p
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 26 Sep 2026 22:33:06 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by tor.source.kernel.org (Postfix) with ESMTP id DB1AB6020C;
	Sat, 26 Sep 2026 12:33:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C15541F000FF;
	Sat, 26 Sep 2026 12:32:59 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=jlCeeByi
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1790425978;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=wN9D2nKA01y/2x8IJdWZfEnnjMzwFRK3N4mVnSJjkBY=;
	b=jlCeeByiKyNAkRDIl4L4BWyGHQY1JK/6GovcSrkf8oXtiWNghruM3MspMqAjQRrS0A5Y4N
	9+00l0im2/J3X1CtQ1hGQXUesbacPr8oKkkGy3jQrUfnbQNxrABBNqKeaKwtQlF9FRtom+
	IijiL9NA1TH1lfYG6igzuyjRxzyvjCg=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 6d775622 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Sat, 26 Sep 2026 12:32:58 +0000 (UTC)
Date: Sat, 26 Sep 2026 14:32:49 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Nathan Chancellor <nathan@kernel.org>
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
Message-ID: <are7cfMIHZZn6jLz@zx2c4.com>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
 <87zex4ic68.fsf@linux-m68k.org>
 <20260926121927.GA1486962@ax162>
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
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20260926121927.GA1486962@ax162>

On Sat, Sep 26, 2026 at 01:19:27PM +0100, Nathan Chancellor wrote:
> On Sat, Sep 26, 2026 at 11:39:43AM +0200, Andreas Schwab wrote:
> > On Sep 25 2026, Nathan Chancellor wrote:
> > 
> > > +#if __has_builtin(__builtin_memset_inline)
> > > +#define memset_inline(dst, value, size) __builtin_memset_inline(dst, value, size)
> > > +#elif IS_ENABLED(CONFIG_CC_HAS_OPT_INLINE_MEMSET)
> > > +#define memset_inline(dst, value, size) __builtin_memset(dst, value, size)
> > > +#else
> > > +static inline void *memset_inline(void *dst, int value, size_t size)
> > > +{
> > > +	char *d = dst;
> > > +
> > > +	while (size--)
> > > +		*d++ = value;
> > > +
> > > +	return d;
> > > +}
> > > +#endif
> > > +
> > 
> > memset actually returns the original pointer, not the incremented one.
> > Nothing uses the return value of memset_inline here, but it is
> > confusing.
> 
> Whoops, good catch, I guess my fingers gave up on those last two
> characters :) I will fix this for v3 once there has been some time for
> further review.

Do we even need to return a value at all? Might as well just make the
function two lines:

+       for (char *d = dst; size--;)
+               *d++ = value;

(Technically that could even be one, but maybe that sort of golf loses
clarity. Your choice.)

