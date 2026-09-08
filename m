Return-Path: <linuxppc-dev+bounces-26755-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 6C563C79FA0
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 07:36:04 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfG2V4rYBz2xlJ;
	Tue, 08 Sep 2026 17:36:02 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788852962;
	cv=none; b=MVIPerkdGIerdXJ3jAdvkTaqXPfsiukZiBZ4BIBX7mkHwkK5D5ljWdJ/F8kjG+LtrEWOiPDxtl1FBg26b0T7gueub1ytVNYPR/NQSxNDZoN2m1Eevgy0YFRrfLVWGf2OHh1EJFGJ1ZAp3zj57HJlFn68HCO80HqfrKU0zotUIXv/+rdQssLCslaGlGLsQ/TqvuLfLs+Al85fA1e1yAkte0RwtvxQbEjvMAOLzNGsx1VksERO8FDuapbKGiK7JcSbvGKXFmf++XQnX37e7gSo942nH37aNdXJ8TsKlcRStG6a4rgWqVaUlJ3fxVEZYMlwMEa+dlWgWvkjqdhYEZGurQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788852962; c=relaxed/relaxed;
	bh=Ji2FYflr/CbjV3rk9832i6ivZtcJlLtueWgeq3em9Fs=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=jrlVLZcYcS7Bfc0hf23Lf7yALBmSPflXFwATFAmq453N5VN4ScrgojTK8rRz83a24/bmg/vb62iLMSQwu/toBVPa/SrECvkIhUpI8tLrifgUMG7SIb6yLTIieROd03ZqOhFknRJBzlP3zS6K0f5VGOPrMnLYkE3Nn/Retciq9HlchhrA0H7lwu4Wo76iDO46ODDRc6KBtK/rGcHZiSNqbR57eDaSYFyYjre3o6CNZOADYu19AgzcaNGCyt9vJUdXRs4gNTgX60bJOGFVxjFYi2QeDAiZX8wCUk0SZLF859J4dvg+DUvFYH80BKnVUQ9mTakpZEObtrKI9DwZ/UYakg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=sF40x1Tn; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=t4GN1Dhf; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=sF40x1Tn;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=t4GN1Dhf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfG2P5lYGz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 17:35:57 +1000 (AEST)
Date: Tue, 8 Sep 2026 09:35:46 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788852947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ji2FYflr/CbjV3rk9832i6ivZtcJlLtueWgeq3em9Fs=;
	b=sF40x1TnpsNhyt0sI38rIHaeAvtNg/EM8w3EtHzsFSvvVwHHMnTzo9ND4gwdFmZKWgwiQI
	zIUqZO38xf+hqbFqpxnJEf22XYPf5rduERB4k6rIc5UkCj8/unJYgFDyl/VlE7G+EFDI03
	CNmgd/Vj1Q3c/q3Ydr3Q/DKOj3v431wlaOso4rjeyTahr+hMGIpBnsAkCalXgeDSgVmwoT
	fSwtBw7bhzCeC4FkKyNmCXzfRLo7mT4mBMZCZPU/i5SaXQchJvrd+z5JqASF5WVbgiH5G4
	it4ju8Bz/fYLxG5O3MBiu0Nd1yKjfxaEDd33C3bFc0Qo3/mwB0s4uDaabhB7ew==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788852947;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=Ji2FYflr/CbjV3rk9832i6ivZtcJlLtueWgeq3em9Fs=;
	b=t4GN1DhfMH6AgNQoFSHKMaImcdOBofdEStAoUz2uy11ao2hSCXVnSiB6G9+q7fkA3MPgYT
	C9GJghb2CAl+FqDg==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Borislav Petkov <bp@alien8.de>, Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, 
	"H. Peter Anvin" <hpa@zytor.com>, Richard Weinberger <richard@nod.at>, 
	Anton Ivanov <anton.ivanov@cambridgegreys.com>, Johannes Berg <johannes@sipsolutions.net>, 
	Russell King <linux@armlinux.org.uk>, Catalin Marinas <catalin.marinas@arm.com>, 
	Will Deacon <will@kernel.org>, Madhavan Srinivasan <maddy@linux.ibm.com>, 
	Michael Ellerman <mpe@ellerman.id.au>, Nicholas Piggin <npiggin@gmail.com>, 
	Huacai Chen <chenhuacai@kernel.org>, WANG Xuerui <kernel@xen0n.name>, 
	Heiko Carstens <hca@linux.ibm.com>, Vasily Gorbik <gor@linux.ibm.com>, 
	Alexander Gordeev <agordeev@linux.ibm.com>, Christian Borntraeger <borntraeger@linux.ibm.com>, 
	Sven Schnelle <svens@linux.ibm.com>, Thomas Bogendoerfer <tsbogend@alpha.franken.de>, 
	Miguel Ojeda <ojeda@kernel.org>, Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Alice Ryhl <aliceryhl@google.com>, 
	Trevor Gross <tmgross@umich.edu>, Danilo Krummrich <dakr@kernel.org>, 
	Thomas Gleixner <tglx@kernel.org>, Christophe Leroy <chleroy@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Nicolas Schier <nsc@kernel.org>, linux-riscv@lists.infradead.org, 
	linux-kernel@vger.kernel.org, llvm@lists.linux.dev, linux-mm@kvack.org, 
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org, 
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, linux-s390@vger.kernel.org, 
	linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org, 
	Jan Stancek <jstancek@redhat.com>, Arnaldo Carvalho de Melo <acme@redhat.com>, 
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v5 12/24] vdso: Add the vdsocheck tool
Message-ID: <20260908093302-1a1cf0c7-8103-48b1-9f6a-abd5c5c16523@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-12-3a93791af1cf@linutronix.de>
 <20260908071911.GU4120091@noisy.programming.kicks-ass.net>
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
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20260908071911.GU4120091@noisy.programming.kicks-ass.net>

On Tue, Sep 08, 2026 at 09:19:11AM +0200, Peter Zijlstra wrote:
> On Tue, Sep 08, 2026 at 08:33:46AM +0200, Thomas Weiﬂschuh wrote:
> > All vDSO code needs to be completely position independent. Symbol
> > references are marked as hidden so the compiler emits PC-relative
> > relocations. However there are cases where the compiler may still
> > emit absolute relocations, as they are valid in regular PIC DSO code.
> > These would be resolved by the linker and will break at runtime.
> > This has been observed on arm64, see commit 0c314cda9325 ("arm64: vdso:
> > Work around invalid absolute relocations from GCC")
> > 
> > Introduce a tool to check for absolute relocations during the build,
> > as the current inline-shell logic is not expressive enough.
> > The check is done on the object files as the relocations will not exist
> > anymore in the final DSO. As there is no extension point for the
> > compilation of each object file, perform the validation in vdso_check.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > ---
> >  Makefile                    |  19 ++
> >  lib/vdso/Kconfig            |   5 +
> >  lib/vdso/Makefile           |   2 +
> >  lib/vdso/Makefile.include   |  14 ++
> >  lib/vdso/check/.gitignore   |   3 +
> >  lib/vdso/check/Makefile     |  34 +++
> >  lib/vdso/check/elf.rs       | 498 ++++++++++++++++++++++++++++++++++++++++++++
> >  lib/vdso/check/vdsocheck.rs | 154 ++++++++++++++
> >  8 files changed, 729 insertions(+)
> 
> Urgh, does this mean I have to have rust installed just to build a
> kernel now?

No.

If you don't have rust installed the build will instead use the existing shell
script for a less thorough check. We only need one build machine at some point
to have rust installed to report issues and this check to be useful.


Thomas

