Return-Path: <linuxppc-dev+bounces-28306-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E26CDC9830E
	for <linuxppc-dev@archiver.kernel.org>; Sun, 27 Sep 2026 07:02:38 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hswP86r44z2yPq;
	Sun, 27 Sep 2026 17:02:36 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:31::11"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790492556;
	cv=none; b=NjiC7lz7bPmtrkOjNM5XuFJ4siuzvr4sKbFsRrHZaTk3nuBQqPBWMU06+RwA/uxiOd4JTXkbiQuvXxMcXdeU+nNIchnhgMTyA0u4hMJxNxUbbPMBabnqdiMwOJYB/pmohR9j9fZUFKXDw5HagNQNhZ4pNmDuNkN1uzqHkcYY85Z8WRgrcPQzXn/JrfCOXKo9TyvWpQwkEVFs7yIx5+0NbKbS/gd3oAMjTJ5T5RnJi35GabrYeY1fbEw3+Ke9c2JRUOIcKf1Vm97NvwFTHuVMCk0ErzGXaOL3sErm2Dqzds6yKbSgqYAgJeCcYZZ1CDLY1iaBAIl7ecZAlrOMrt/ZZQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790492556; c=relaxed/relaxed;
	bh=RJKp/brBpZ8U6kwJIcmM4FiZnVhsdc/GYabd2hj9ep0=;
	h=Date:From:To:Cc:Subject:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=P4ucla+2wAzUnIyEiXC299QbGdxP0L5bZlzmHWGXUnKENnvxApqNyY3shAKB/iIcvvE5RpuT2tynLD7r5g74fXnL4Kdvebc7IRkqtSDQLbalJpkTeZTQBFPdEtyAwfvRG8S8u1kTwfF8zoEjvKVKqCRQnOL0YdBolfnqul6iz42puPgaU9LZN48cEry8U4/gq6gFaGub+V7zdvSBxJrqo2t/IJ7W2oNuM08PEJUpWwraDLbOb549F4J3tUOrS0/7dyobcXt/ZRSyxcOqnefCjEW58VVQuQ9cpRAhF0rdWZwzFeODUk7XDgnGqOUlFliXPNUn5P8gRzGlQdbhCRCZKA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fnpsqdD5; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fnpsqdD5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2a00:1450:4864:31::11; helo=mail-wm2-x11.google.com; envelope-from=david.laight.linux@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-wm2-x11.google.com (mail-wm2-x11.google.com [IPv6:2a00:1450:4864:31::11])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hswP65RlSz2y2K
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 17:02:33 +1000 (AEST)
Received: by mail-wm2-x11.google.com with SMTP id 5b1f17b1804b1-49ff9642c57so3051785e9.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Sep 2026 00:02:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1790492548; x=1791097348; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=RJKp/brBpZ8U6kwJIcmM4FiZnVhsdc/GYabd2hj9ep0=;
        b=fnpsqdD5evnAoXo5FVPtQVB72HNAH5rqjCqutEhy8ieFT/T40DKQZBW27UsmmedSbW
         KtPutAKrLb3bQ/AH8u/dXsPX++Y9BjvHqHiSFfq969laAZBqYlPNcr1WKC82tpVijsIS
         DG0Y4Ef7W6j2GmcmRSJ4IEPRNvGPc6q1PZsq2X8MOuaybF0QfskrIvFUjEGvMwSXGph2
         g573O9lVOAKuWSvnw+/jtnIAedVfzadiTv5IWNaZz/HXZkbAH7ewVTfCua07wewQIQT1
         7h/gIjFDdCnEp+jfDb/cL41vcSy86Inb8vSlDhPTcFUlXqJ2hDz+QeLQBxK78E3RqHxS
         Khsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20260707; t=1790492548; x=1791097348;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=RJKp/brBpZ8U6kwJIcmM4FiZnVhsdc/GYabd2hj9ep0=;
        b=sCF1tJw7dBKPPyQoSNk3QXtIjK7XcqS8z3bzrcBCQtKeR+HzRRWd0M82d2c31JW8ga
         1umg8e+jlYJm5w5RYvSqzADLoMy7r6XfP9SVQ8nEiBT1HwjSbu4FmJWu5oV3AErXwI3m
         jqdVUCGc9lDiJ456YnREjFaXD1uWuEFS5MZzUm1eMFFVNxW7ThBZgCMGZUF9xpvEnf4V
         rwdiFTOqLeNE9d/Mbsdbpj9K3qVUMN1/YTntt5DsaJqNCVLEhN0KLmrWrRhoYexExK3r
         fLjObAbwW07KpGQJ6bRDJeR9S+Nszk4e/212CUnvaX8b0Na3gtYaYDTtU5mY1xVVMMhX
         asCw==
X-Forwarded-Encrypted: i=1; AKwUvBz7OPSdIdrNZsk2U1q3BX9mKlhPegVFfW+NRHEBVP8Z+4rXF4qrzkE1j/VKuCYBbuIs6iVOgSKSDWCii8w=@lists.ozlabs.org
X-Gm-Message-State: AFuF++mE6DelR5m5njZ4R6WPMGnBEvqcWwJEVQAaIZXisASgi5IfU0SD
	hCAzjNtL5Oqqsnr0HkpHOOCF+h8w0qLJFd4vZpPXHNQ5+yzi4TIkdDHm
X-Gm-Gg: AYBFou3kw8vkaA5cBv/ZHNOJHRjcjRZR6kA97JLWdnVHaaffVwLU1VNmP2f6TCNFRH5
	wgZtJg9Ye9MIuoZOnLgZX5gGgLaRRibb/sZiCEP0MfGqwAlytSA5DWEleZyWUE2fjGYedLlNH3a
	cNWuKRkXIVqs5aJJZPjxyEkZp2M+lSOBBYllOGdPx0bFS0CKsrcBXDycNojqdFANPw1XJPIvMP0
	SIPELT24v0L3rqocPFpGBAkBicaXy24TUYHZQmMRdo1cdMcRx6AFa/lWf1dAvSTmyMFwsiaA+HD
	T6vID+eZjPLGpbbsh2Kl66daWEPgHP6EVvvoLDtsWYCiG/673XabD7Qqn70hIMaXmo+bOTOwQn3
	rwIq4gWLH25UopOItIU5bZWHcEUmzCL/UN1XKKdRRNYLAdRcuqjj1Qax3YZRXmMxSoH67g1e/5u
	cYk+RU1qogNFwuYTsfI1ejnus2e+flQaq/98w9T2wNX+ZNQ7H7mmnVWUBFknUyQHVmQTYCdQR/X
	wzmctb041uB7S6jPq5WOR+zViAhy4EZxt1q
X-Received: by 2002:a05:600c:1f83:b0:49b:8f5e:51fb with SMTP id 5b1f17b1804b1-49fe66c8087mr175447355e9.3.1790492548064;
        Sun, 27 Sep 2026 00:02:28 -0700 (PDT)
Received: from pumpkin (82-69-66-36.dsl.in-addr.zen.co.uk. [82.69.66.36])
        by smtp.gmail.com with ESMTPSA id 5b1f17b1804b1-4a0018f0e79sm57015315e9.7.2026.09.27.00.02.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Sep 2026 00:02:27 -0700 (PDT)
Date: Sun, 27 Sep 2026 08:02:25 +0100
From: David Laight <david.laight.linux@gmail.com>
To: "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc: Nathan Chancellor <nathan@kernel.org>, Andreas Schwab
 <schwab@linux-m68k.org>, Andy Lutomirski <luto@kernel.org>, Thomas Gleixner
 <tglx@kernel.org>, Theodore Ts'o <tytso@mit.edu>, Vincenzo Frascino
 <vincenzo.frascino@arm.com>, Nick Desaulniers <ndesaulniers@google.com>,
 Bill Wendling <morbo@google.com>, Justin Stitt <justinstitt@google.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>,
 Mark Rutland <mark.rutland@arm.com>, Huacai Chen <chenhuacai@kernel.org>,
 WANG Xuerui <kernel@xen0n.name>, Madhavan Srinivasan <maddy@linux.ibm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>,
 "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, Paul Walmsley
 <pjw@kernel.org>, Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou
 <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>, Heiko Carstens
 <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev
 <agordeev@linux.ibm.com>, Christian Borntraeger
 <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, Ingo
 Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>, Dave Hansen
 <dave.hansen@linux.intel.com>, "H. Peter Anvin" <hpa@zytor.com>,
 x86@kernel.org, linux-arm-kernel@lists.infradead.org,
 linux-kernel@vger.kernel.org, loongarch@lists.linux.dev,
 linuxppc-dev@lists.ozlabs.org, linux-riscv@lists.infradead.org,
 linux-s390@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH v2] random: vDSO: Avoid call to memset() when zeroing
 reserved in __cvdso_getrandom_data()
Message-ID: <20260927080225.37534e7c@pumpkin>
In-Reply-To: <are7cfMIHZZn6jLz@zx2c4.com>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
	<87zex4ic68.fsf@linux-m68k.org>
	<20260926121927.GA1486962@ax162>
	<are7cfMIHZZn6jLz@zx2c4.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.38; arm-unknown-linux-gnueabihf)
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
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit

On Sat, 26 Sep 2026 14:32:49 +0200
"Jason A. Donenfeld" <Jason@zx2c4.com> wrote:

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

Wouldn't it be better to add a barrier() or similar in there to
stop the compiler playing unwanted games>

David

> 
> (Technically that could even be one, but maybe that sort of golf loses
> clarity. Your choice.)
> 


