Return-Path: <linuxppc-dev+bounces-26808-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28901C79F82
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 14:26:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfR7s2GwWz2y8p;
	Wed, 09 Sep 2026 00:26:17 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788877577;
	cv=none; b=Oaq8znEiv6nW2uPG9DZl4gO3xkPlIbTCNgEHZGcPvuXFpqtEOUX8DS7OAPx7HmNWpWq2K9YrXElbZYZZArJl1FgwIR6gOvqwumVSvFKF2raJ5InsAappwbA/+jY0cWphG5ek5EgaV+1/uJ8ITOmoLASjkkiqpzsseA81/qo50PjoDfVopvK4qVl1lt3usjv8+QbXu5UICZJrTVWU5fFZmxe2/+wz7aqgsgJRTz2tmsakBra7+8UCUp0R+4RpI5CzXWdkZpTvdAq6vkyxERQxzjkCHwH1EjaOEWjjidkJkwLEqbN+1/nri+b3amGqHbEDX1Onw1P+11nK6ajfjpEUyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788877577; c=relaxed/relaxed;
	bh=3bG7xzyOLgkq/hT1vQoL2+37rRIngeN99Zi6O3p/t1Q=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ODvQ/apLz/pOJuDCqR9s1yEVY7xzzC+mTDNPExP9npj3ga5BzYssdMI7KIu6C6XAdNOY2qyTBpMEkGAyk3Zwrt7P+wfQxdYDYcNP66+O9+QYMRcPxUIDQPDZKVsj9jKicwG/Vim2qdJQpCoG3hY0GoeqTcjNiXbiydALJD2hxIJyXse/9naAy+lXLi6p6vZG6+joM3dQHP1nbRbhOLhEARPMkt59mzuw2DpDIC7LbkT02iQGtHGA8x/YHwDBlYy5JPYyx1+YkC7Vb61Mysi7zLSJy48PobNq7QX0kZvP8Kpkvv7M6oPA30s3tQnnfJKeMLvhmR3KFcLRuzcxDFQpUg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ibCJ1vTa; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=dujpHxA7; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=ibCJ1vTa;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=dujpHxA7;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfR7q72zsz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 00:26:15 +1000 (AEST)
Date: Tue, 8 Sep 2026 16:26:00 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788877566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bG7xzyOLgkq/hT1vQoL2+37rRIngeN99Zi6O3p/t1Q=;
	b=ibCJ1vTaf2PfeTeGGS4CPdeCQlmt6p7aLY7mIyests6CYT2a6E4Mjbx9HP5VcqSFIGIDN5
	lQzNq4LeidtkfT+EysNyxDj3JNRd+SkiSObbBLZntgveQTRfZuO3v/L3jsJBVUb2BH8YCM
	7vKdLixe7hXeDeAfmTR73MLoheT6qddEqn0zSpdo08XfzCFSXasPoLv5PXY5oZ4uUtuuhQ
	ue9dInv7mMssJZ5SEhI8zG40m/o1XMobx0JA0bqLkrd6i/I6QO8W9g5ozGh5HmdlKJSK+H
	nBg3aR8ypjomfwqNmYevI/XWRU18YkOzSNQOVFvzM7BNe1wvopfv0uHl4KPu0w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788877566;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=3bG7xzyOLgkq/hT1vQoL2+37rRIngeN99Zi6O3p/t1Q=;
	b=dujpHxA7PKpeJCyeZiOagFVHrYS6MiqrupOYGFJ0EP4mlmR+jdnMRKg1XsL53yLYA37pen
	ASTs5tXfWZYBIDDw==
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
Message-ID: <20260908161740-0d79e592-87a6-43c5-9174-84ce1904e639@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-2-3a93791af1cf@linutronix.de>
 <20260908135513.GAaqATwXHcQD7plnH-@fat_crate.local>
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
In-Reply-To: <20260908135513.GAaqATwXHcQD7plnH-@fat_crate.local>

On Tue, Sep 08, 2026 at 06:55:13AM -0700, Borislav Petkov wrote:
> On Tue, Sep 08, 2026 at 08:33:36AM +0200, Thomas Weißschuh wrote:
> > These constants are useful for cross-platform userspace, for example to
> > process ELF files during kernel cross-compilation.
> > 
> > Move them from the kernel-private architecture-specific header to the UAPI.
> 
> Why UAPI?
> 
> Why not include/linux/ ?

The existing, generic ELF definitions are there.
The ELF stuff in include/linux/ is highly specific to Linux.

Also later in the patchset I want to expose the definitions to the
tools/ build. Exposing generic UAPI definitions to tools/ is a much
easier sell than include/linux/.


Thomas

