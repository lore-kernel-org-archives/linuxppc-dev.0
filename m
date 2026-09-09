Return-Path: <linuxppc-dev+bounces-26870-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73F4DC79FB7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 06:00:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfqsB5BQ3z2ygp;
	Wed, 09 Sep 2026 15:59:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788933598;
	cv=none; b=kAFsLYUMfCpS7j0nkST7IEALs9IHdY+f1lo+GtUTrt7jmjE8azgmo6mEKezl5fndcZjWDEOIqBD9/Xpvm9wpnrrP3s1W280+USQdnWQVLcZ9PaVxstIv0tjlLqFZqwnE9IapyxEJkXzQ+I3V8WCdj76yuwy2VVZAvmjsumo+VVJ6Gywrz0er44jti+ohD3DYuxPdpbuzQUFZ3RcogBJi8YA6OlB8pdhlzGI5O120DM4gobLsrl1Wt5q5gBqPQD/6Z2yH2KE2TGU6peKIGsKLXqW1y04wfCh4Zo1Tg/xPDW/2a2dorZf6llT997NcpMGRF7Gjlrbrin0g2ywdbhoAnw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788933598; c=relaxed/relaxed;
	bh=XfBuOKvuia8jKU4jKhI6ImQ24+OP+x2lVvStL9kHB6c=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=WiRSzf1P1pBa7Zaou3CM895O47yAPcozUN24GOPG5HlVwf1gEYjsJSyYPpGySDIUv9dgragJHNoDZpN8i+GgWPz2XCs0/XSc5VceqbBh/vT6ZSossdAQOMeQLALm2fdsWRJolPkyzT0SNDSCm2XDUoqwiL4gz1zbqOmT1BnABXYTG1yP1BoVGK6bx9wH4aY1bt94xTbLx8fmp8EGeEzWNQZ2daJzfPtwhqzymADVfpCDTdwCOGhP1XFQu7eF8VTP3AkK9w8zBoV+GkBgEPb19c6uJfl79wQCAZtE7nvKc2WxXRUlqt2SFVRU8r9u7kotdjrcUKF88+LWSVI1+k45Yg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=CMEIGvTJ; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=VonGHAfq; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=CMEIGvTJ;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=VonGHAfq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfqs964Zpz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 15:59:57 +1000 (AEST)
Date: Wed, 9 Sep 2026 07:59:51 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788933591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XfBuOKvuia8jKU4jKhI6ImQ24+OP+x2lVvStL9kHB6c=;
	b=CMEIGvTJ+RpDUpaQX63YOGpF9L1xMeGi9s7P9EumAFOOXvZhDn04zc5cDcznjmEwFWcMKn
	aV3mh9HSsioEvvDCuqmuPhxAz0EDxVz5FVZWfmObWfXRSybwQ1ZxDVQ4z0tJ5bj8HKl6QH
	2LpCD9FeG6rAkLbfiSKloV9FiP1FFipkSzlhBo3Zplknr1ofEEQBBTOoi2c+qR7w1FFuf1
	oLRZ1Ohqd/R7qrq1gOVWGdmCLZlvGzRsKpGh6crrwVT4V1hNIEeMZP96qZ+DAKQJ/Yh6qb
	V/ykB9y+Wc32WJFwaNxXjYic0iDsUwgblz+2Yps3KMILiE5BRXmRKCLGA9EuDw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788933591;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=XfBuOKvuia8jKU4jKhI6ImQ24+OP+x2lVvStL9kHB6c=;
	b=VonGHAfqnQoueeh6Hl3Lomphhnqa2H/lUyc5Ke65gvgt5gNmjnE70KZBPhdx4hgXdpJF0U
	tvpV+04d2I30q5AQ==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: Borislav Petkov <bp@alien8.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>, 
	Palmer Dabbelt <palmer@dabbelt.com>, Albert Ou <aou@eecs.berkeley.edu>, 
	Alexandre Ghiti <alex@ghiti.fr>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, Andy Lutomirski <luto@kernel.org>, 
	Vincenzo Frascino <vincenzo.frascino@arm.com>, Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>, 
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org, "H. Peter Anvin" <hpa@zytor.com>, 
	Richard Weinberger <richard@nod.at>, Anton Ivanov <anton.ivanov@cambridgegreys.com>, 
	Johannes Berg <johannes@sipsolutions.net>, Russell King <linux@armlinux.org.uk>, 
	Catalin Marinas <catalin.marinas@arm.com>, Will Deacon <will@kernel.org>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, Huacai Chen <chenhuacai@kernel.org>, 
	WANG Xuerui <kernel@xen0n.name>, Heiko Carstens <hca@linux.ibm.com>, 
	Vasily Gorbik <gor@linux.ibm.com>, Alexander Gordeev <agordeev@linux.ibm.com>, 
	Christian Borntraeger <borntraeger@linux.ibm.com>, Sven Schnelle <svens@linux.ibm.com>, 
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>, Miguel Ojeda <ojeda@kernel.org>, 
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>, 
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
Subject: Re: [PATCH v5 02/24] x86/elf, um/x86/elf: Move relocation constants
 to UAPI
Message-ID: <20260909075156-06ff671c-ab7b-47d8-aaa3-588b570888bc@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-2-3a93791af1cf@linutronix.de>
 <20260908135513.GAaqATwXHcQD7plnH-@fat_crate.local>
 <20260908161740-0d79e592-87a6-43c5-9174-84ce1904e639@linutronix.de>
 <20260908151238.GBaqAl5iKb64meuPJl@fat_crate.local>
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
In-Reply-To: <20260908151238.GBaqAl5iKb64meuPJl@fat_crate.local>

On Tue, Sep 08, 2026 at 08:12:38AM -0700, Borislav Petkov wrote:
> On Tue, Sep 08, 2026 at 04:26:00PM +0200, Thomas Weißschuh wrote:
> > The existing, generic ELF definitions are there.
> > The ELF stuff in include/linux/ is highly specific to Linux.
> 
> And putting them in UAPI casts them in stone. I wouldn't want to maintain them
> forever if not necessary.

These names and numbers are defined by the architectures' ELF specifications.
They are already cast in stone. For example see Table 4.9 of [0].
Changing them would break compilers, linkers, loaders and more or less every
existing ELF binary.

> > Also later in the patchset I want to expose the definitions to the
> > tools/ build. Exposing generic UAPI definitions to tools/ is a much
> > easier sell than include/linux/.
> 
> tools/ *copies* kernel headers on a "they're needed" basis. No need to put
> anything in UAPI for that.
> 
> It's even written down: tools/include/uapi/README

That is the documentation for the tools UAPI headers.

Also we already have other, closely related, ELF constants in the UAPI,
see {,tools/}include/uapi/linux/elf{,-em}.h.

[0] https://gitlab.com/x86-psABIs/x86-64-ABI/-/jobs/artifacts/master/raw/x86-64-ABI/abi.pdf?job=build


Thomas

