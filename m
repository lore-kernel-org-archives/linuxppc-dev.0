Return-Path: <linuxppc-dev+bounces-28641-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3AA56CA5FCB
	for <linuxppc-dev@archiver.kernel.org>; Thu,  1 Oct 2026 10:48:30 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hwTCw3dGLz2yTQ;
	Thu, 01 Oct 2026 20:48:28 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=172.234.252.31
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1790851708;
	cv=none; b=VgZ25NhOlu+j2f4XWES+x4xtb/ntJGj0JvhTx9CDjCCgDgWPuKVY4+o7RRRFivIIp0rIdfwmELGetujR4TeDeDSL0SAoHuBVEmG2lcbkUnlzlJROoe+kZOjBVkcorqkT+GotsDvzlaCQ76oJE9VfMh0Q2YtAl1MtaTrh2RuyzZznQV41FLKSWCpuiRuWyi4axn8Y4WEFEKnIo0Pko8PMDpkPCe+P/oW3OJODCXCmOtkFidlHhjcEBFwWI+/LRYnGMk3kVYNFVsaUrZI0KGZcBegy5423UfKadI+fAsX/sh75K6QItrxx7VQ64/QaYcesjR9jZzcL9kjKNkBxD5O1xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1790851708; c=relaxed/relaxed;
	bh=/oOpPY/gsh1NivZHQbt/4ewXmUw4hi2f8c5A+91XjAQ=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=VTvNGwjhQ9gdkIVy0Zu+KHoQyaZj5of9J3po0BuhbHwGOCgoRYCTM+LJVLb7NIZBRd1diSQbBFb/fq2yzaxP0ss2BqlrkETCSj7jAH0qlUaedqGkC7lHn1znNv/HRhawO2nVIlCgtaATP9qW/MwPadffzmBFADrX8swkntizDk1AnTC8Xr1NiGT7n3OcemUH6u32R98ho00sJugoy9PIQYm5N00RIoalum9t0d5NBAdxJFzOMePGPI4lpDR6Z2Gx3V6EZORr1fNWW5XylvmWRyu7UZj1WOFAQk5tJ89RHevuW5zdWTjyW0eSb9ohc5In7jPSIJ1Q5PPIMK6N3Z5Rdg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com; dkim=pass (1024-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=B57mDsY4; dkim-atps=neutral; spf=pass (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=73p4=hx=zx2c4.com=jason@kernel.org; receiver=lists.ozlabs.org) smtp.mailfrom=kernel.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=quarantine dis=none) header.from=zx2c4.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (1024-bit key; unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=B57mDsY4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=kernel.org (client-ip=172.234.252.31; helo=sea.source.kernel.org; envelope-from=srs0=73p4=hx=zx2c4.com=jason@kernel.org; receiver=lists.ozlabs.org)
Received: from sea.source.kernel.org (sea.source.kernel.org [172.234.252.31])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hwTCp694Fz2xfP
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 01 Oct 2026 20:48:22 +1000 (AEST)
Received: from smtp.kernel.org (quasi.space.kernel.org [100.103.45.18])
	by sea.source.kernel.org (Postfix) with ESMTP id D801141768;
	Thu,  1 Oct 2026 10:48:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7D6031F000FF;
	Thu,  1 Oct 2026 10:48:17 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
	dkim=pass (1024-bit key, unprotected) header.d=zx2c4.com header.i=@zx2c4.com header.a=rsa-sha256 header.s=20210105 header.b=B57mDsY4
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
	t=1790851695;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=/oOpPY/gsh1NivZHQbt/4ewXmUw4hi2f8c5A+91XjAQ=;
	b=B57mDsY4+jopKLImXZNVOWxdVpQrgNONXSBu75IrKyl7123Al4mEDaeWWuv661fwT5QFtp
	DyBe8f04ARHZI529RupFjeyvDFHWlpXWFuVEmNR4jf9UiXLsJ+Xu0/uwQUzKXb1sdqw5Bu
	rwXQT6Por1A+lDJO9XzMggVf/BrbZ0A=
Received: 
	by mail.zx2c4.com (OpenSMTPD) with ESMTPSA id 03abc62d (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
	Thu, 1 Oct 2026 10:48:15 +0000 (UTC)
Date: Thu, 1 Oct 2026 12:48:10 +0200
From: "Jason A. Donenfeld" <Jason@zx2c4.com>
To: Nathan Chancellor <nathan@kernel.org>
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
Message-ID: <ar46ap4jzLWyP92C@zx2c4.com>
References: <are6s5e6On3hpD3M@zx2c4.com>
 <CAKwvOd=BrMfFT88jsvBPhh383qqk5G+J07CsofNu0MVkziyhCg@mail.gmail.com>
 <20260930133813.GA3142230@ax162>
 <ar0a4b9CjL2YHCkY@zx2c4.com>
 <ar0gTS71qxnx9AkW@zx2c4.com>
 <20260930151337.GD3142230@ax162>
 <CAHmME9pA+AntJ6hWoFYpTVjh-NUSd0ZGXp5XiUuhQcq3HjQT3g@mail.gmail.com>
 <ede392d7-3104-4a0f-9fa1-99b22552dcd6@kernel.org>
 <ar4nD8aRH7wEvTMt@zx2c4.com>
 <20261001102059.GA4176271@ax162>
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
In-Reply-To: <20261001102059.GA4176271@ax162>

On Thu, Oct 01, 2026 at 12:20:59PM +0200, Nathan Chancellor wrote:
> control. The change that introduced -max-store-memset only did it to
> "allow fine-tuning of the inlining threshold for performance analysis
> and optimization". If they decide to remove it for whatever reason,
> we're back to square one.

I suppose all the more reason to get -finline-stringops=memset added to
clang. Then the dual-default thing you came up with below will naturally
start choosing the first option when it becomes available.

> I know something like below would be uglier due to the ifdef but it
> would avoid changing anything for GCC while clearing up the issue at
> hand for clang in a guaranteed stable and succinct manner.

But then we're back to the byte-by-byte codegen that Christophe pointed
out.
 
> If that is not acceptable, something like the following does appear to
> work for me.

Okay, great, let's do that.

Does this commit seem okay with you? I used the diff you sent below and
adjusted the commit message: https://git.zx2c4.com/linux-rng/commit/?id=56ff95ee85715047eb5b5220243778af657778c8

Jason

