Return-Path: <linuxppc-dev+bounces-28509-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 820C1CA5FA5
	for <linuxppc-dev@archiver.kernel.org>; Tue, 29 Sep 2026 16:59:55 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hvPYP67Bgz30WF;
	Wed, 30 Sep 2026 02:59:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790701193;
	cv=none; b=W6XbLT9+iIoC7mSRH0QzfLo/EpqJz+ZQr/0bVQWSx+XJ87rjkW8BcazUVFUoaXpNAHM5jq1FUKSjzOQZatL+EmutmN0oAVq2yxs50I/kISZAdv9mVoM5X/5y49+6SIAd1atwf0UC2KyRStm0E7WjdgJWEAz6b4yvwZgqUkQKUK/V0bAHM+h6fj03fDMWuNSGW3XNFD7QQrvyWulLpF7i3mNz9nWBwxhchm9cIyMu9aHbGn1M7JZAagtV+/DPXph20mQAe52gsbcVGw/DAFm/Wpo+hFk1x9oHmb65ikcpgb85TFCGhCd2xVFzWctiTxzoMvpM76O2Z77RGSoiCcx3Vw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790701193; c=relaxed/relaxed;
	bh=MGBWHHaEJganj8D1yagMHRlcdsNEyTtM3iC7GV8hUXU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ZTZ79lcUpGECYc0icafr1cZLARTE37FLlvkq3e+biUtrX6Jp+NT5ckb+JJBSYmBs9fWqmkCHGWBBVjY1NTT5ADhMKkpgEN5gennz49IvGWWIObxm1EU3i5QsYvvpFJ4bR4h0THl1bWb38dCcw+fgKkcnw3jV5re9mxZE4pI+J8Mg8wzbdvgZ2+u7HvlxhlXEfrEIN0Qu+4fWWJurcciBoGDqeyMWKCWlXwi37FoV/tpLbR9EQGKanMWLzW7mKH9qb5ShJ2avkxWorOrAFervkoRXI7w/mUrnAciv1MC+80hMF8wWq8i0StqJIxbJLTfQZ1Euwnbir/H025E3IY637g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org; dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjePm7x0; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=kernel.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=kernel.org header.i=@kernel.org header.a=rsa-sha256 header.s=k20260515 header.b=SjePm7x0;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=nathan@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hvPYP0zCTz30W9
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Sep 2026 02:59:53 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id 6AB8243BFA;
	Tue, 29 Sep 2026 16:59:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 153C71F000FF;
	Tue, 29 Sep 2026 16:59:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=kernel.org;
	s=k20260515; t=1790701190;
	bh=MGBWHHaEJganj8D1yagMHRlcdsNEyTtM3iC7GV8hUXU=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To;
	b=SjePm7x02Lah5vOELf9ce4YUO5z/8quB47KG1ZoIMK72aUNVrPrCdr0c0MhVEUCct
	 e/pjkzplRRlc+iDw8myI00JnCkhOCgIGqKVjqAEmF68e1bsSBFWkNDo/dnGaHUUbmN
	 gGTfswdR99FIW24ZhkxFSWQUM+NnT0oWNEgj5t/DAU3kIqebd4giVteYXHP1sJE9R7
	 LMnUflkro8TfjhlCllhq8FQKM35R/YNnamS2pvqYaCoDITHJ1zkhAY1dQR0e4Sb4q1
	 loj77pP8vyLLK7xfd/8pczOKmPjnIREFvATiAc8+2ruPOGvW7PPEKs8kujnvVWWvGM
	 j5+6rTn2iVdcw==
Date: Tue, 29 Sep 2026 18:59:39 +0200
From: Nathan Chancellor <nathan@kernel.org>
To: David Laight <david.laight.linux@gmail.com>
Cc: "Jason A. Donenfeld" <Jason@zx2c4.com>,
	Andreas Schwab <schwab@linux-m68k.org>,
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
Message-ID: <20260929165939.GA1890629@ax162>
References: <20260925-vdso-getrandom-avoid-memset-llvm-24-v2-1-ce640f872393@kernel.org>
 <87zex4ic68.fsf@linux-m68k.org>
 <20260926121927.GA1486962@ax162>
 <are7cfMIHZZn6jLz@zx2c4.com>
 <20260927080225.37534e7c@pumpkin>
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
In-Reply-To: <20260927080225.37534e7c@pumpkin>

On Sun, Sep 27, 2026 at 08:02:25AM +0100, David Laight wrote:
> On Sat, 26 Sep 2026 14:32:49 +0200
> "Jason A. Donenfeld" <Jason@zx2c4.com> wrote:
> > Do we even need to return a value at all? Might as well just make the
> > function two lines:
> > 
> > +       for (char *d = dst; size--;)
> > +               *d++ = value;
> 
> Wouldn't it be better to add a barrier() or similar in there to
> stop the compiler playing unwanted games>

Wouldn't that just result in the same code generation issue that Jason
pointed out on my v1?

  https://lore.kernel.org/aquyVkdYceiWdckX@zx2c4.com/

Maybe that doesn't matter because modern compilers have better options?

-- 
Cheers,
Nathan

