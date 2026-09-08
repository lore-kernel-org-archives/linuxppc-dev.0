Return-Path: <linuxppc-dev+bounces-26811-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1380EC79FB2
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 15:14:02 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfSBx1N4zz2y8p;
	Wed, 09 Sep 2026 01:14:01 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a01:4f9:3051:3f93::2"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788880441;
	cv=none; b=SAR5MjFzR0ETv01ikf3YNApkBSD9Afy6XH08e4OimkVM45Kn5tiQI+/mHBmjuGaZjasBPJ9xF4OHKraoMPwLOKjqNTiXfILq6oCNhtrz8CGVKeuH0S3ulDPSP5SwNKkQ+6ynJKStypBtRxwBJA3NUn3fecYMbLXT46hVyBHdJD9gNSCplp3oM//3gJ6jSFE5OuBAtYRaJvCMgDktrwtFhMNfiHy2qbq8qpI3r7Yfpy/QiL3lmcSi63XHZd+Q7SB5nwqR6yVSaWcSrXzv/2pZcIfbR5/Z5XA6cOHr9gkohVeQE0AMQ6s7jtImMTKbA5iEmH+xtM1tykUjoKCBeK2avw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788880441; c=relaxed/relaxed;
	bh=b+dYGUlP4/NCA7NxfzDivtwOTsXnKhj8P8GD9GvMt1o=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QoL/52WzaXbgdJMPF3zqZWVDAH5w4Fev/NxxO4/GdhS45NhdJUm4umCP5OKkeKvk02Ork6xmlUjJjS5ERHElHKXOZWspuuJuH90QIRIveeLGlM13gMZppwJgHKrzBtfCwobZzAMlibnIHhGdVp8klCdku5TPK5SvtCTvMHBLPJO8ACwGQCnHaDAEoWuQXbxGespWXegPTGJA97GK9FhSNZzxBybWPDqF3Ja+XM5UepQ6z0Q3MZ3zys8E+Y0PqByQlGz7yr2Dd3WAhe7GUYyUUnDxJWsj+1fYYkw+6AJUzbipA4sbUcIlCqQJ5OwfuYNjB3WfgoBIHdasvw3Z6/LFwA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=fail (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=fAETnApx reason="signature verification failed"; dkim-atps=neutral; spf=pass (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=fail reason="signature verification failed" (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=fAETnApx;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=2a01:4f9:3051:3f93::2; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
Received: from mail.alien8.de (mail.alien8.de [IPv6:2a01:4f9:3051:3f93::2])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfSBv10fxz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 01:13:58 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 8807440E01F9;
	Tue,  8 Sep 2026 15:13:53 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=fail (4096-bit key)
	reason="fail (body has been altered)" header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id APiSMwsJLR9v; Tue,  8 Sep 2026 15:13:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788880423; bh=SihVXpN4VvNY3Mg5IOkHy8UfEsHqRfkcnelNTeVhEJY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=fAETnApxBEtfPuqHFKCgIL29nHx0Z2YHgAygdIUM8hU/Mz33/kA4ZUBeN/gRjrvau
	 vtDllihc6pYSe5SXQwgoqpNhfk4/08/8KMfUsCAU9thasCFYYPKC5Y/pV7Y6XU69vH
	 LNwlFlG04npY9qQKxVsZcrZnpWC37yTWxuzhzHRm5KpwYfkHvzNEQeiGPcvB58aLNL
	 CiYr2yyCrB3Kpf/DVc891YwOW/34b2QLG1yPFPyiPhCi535fKHZgiFGNQiM2V+7vT2
	 gPcZgp3ofWVjQmcjoKAe195uX42B3clf9ibePNVbJKWUY1oARNBH9aqSnI0FgzmH5W
	 h3dWuWkymclGp3MUg9haChNnjvPBl3Zfv+FDejA3/AFf/CVXHWsWO5KDUQ2zEgeqt/
	 YAh14BnniVfR4yGoNbbKeldMZUsNF3icLMOF+CXHFJzyhU2PGxTQ2922hXMjHxMdeL
	 Z7VOvQUlIKK4Twu3A1MK/eNhNVBp3Aq4OXXBOciVJLy8/PcJIx0toX/zZ4lcn1jfV9
	 ErcQYDZ5WCkd1WmQQESUO71elKnVOkkPTWwEHl1ZBofjxaMBHmYZWTaJGuyt7QqChy
	 44ZU/2M46IVY51m5w2KmjWEiICeA6W5JNXmeJ3Nh9U8UDaWIWWakyv4XQKa/cqNpso
	 4+S63J9RdOKwhC2R/OGeJJio=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 2B8AE40E016C;
	Tue,  8 Sep 2026 15:12:41 +0000 (UTC)
Date: Tue, 8 Sep 2026 08:12:38 -0700
From: Borislav Petkov <bp@alien8.de>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
Cc: Paul Walmsley <paul.walmsley@sifive.com>,
	Palmer Dabbelt <palmer@dabbelt.com>,
	Albert Ou <aou@eecs.berkeley.edu>, Alexandre Ghiti <alex@ghiti.fr>,
	Nathan Chancellor <nathan@kernel.org>,
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>,
	Bill Wendling <morbo@google.com>,
	Justin Stitt <justinstitt@google.com>,
	Andy Lutomirski <luto@kernel.org>,
	Vincenzo Frascino <vincenzo.frascino@arm.com>,
	Kees Cook <kees@kernel.org>, Ingo Molnar <mingo@redhat.com>,
	Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
	"H. Peter Anvin" <hpa@zytor.com>,
	Richard Weinberger <richard@nod.at>,
	Anton Ivanov <anton.ivanov@cambridgegreys.com>,
	Johannes Berg <johannes@sipsolutions.net>,
	Russell King <linux@armlinux.org.uk>,
	Catalin Marinas <catalin.marinas@arm.com>,
	Will Deacon <will@kernel.org>,
	Madhavan Srinivasan <maddy@linux.ibm.com>,
	Michael Ellerman <mpe@ellerman.id.au>,
	Nicholas Piggin <npiggin@gmail.com>,
	Huacai Chen <chenhuacai@kernel.org>,
	WANG Xuerui <kernel@xen0n.name>, Heiko Carstens <hca@linux.ibm.com>,
	Vasily Gorbik <gor@linux.ibm.com>,
	Alexander Gordeev <agordeev@linux.ibm.com>,
	Christian Borntraeger <borntraeger@linux.ibm.com>,
	Sven Schnelle <svens@linux.ibm.com>,
	Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
	Miguel Ojeda <ojeda@kernel.org>,
	Alex Gaynor <alex.gaynor@gmail.com>, Gary Guo <gary@garyguo.net>,
	=?utf-8?B?QmrDtnJu?= Roy Baron <bjorn3_gh@protonmail.com>,
	Benno Lossin <lossin@kernel.org>,
	Andreas Hindborg <a.hindborg@kernel.org>,
	Alice Ryhl <aliceryhl@google.com>, Trevor Gross <tmgross@umich.edu>,
	Danilo Krummrich <dakr@kernel.org>,
	Thomas Gleixner <tglx@kernel.org>,
	Christophe Leroy <chleroy@kernel.org>,
	Boqun Feng <boqun@kernel.org>, Nicolas Schier <nsc@kernel.org>,
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org,
	llvm@lists.linux.dev, linux-mm@kvack.org,
	linux-um@lists.infradead.org, linux-arm-kernel@lists.infradead.org,
	linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev,
	linux-s390@vger.kernel.org, linux-mips@vger.kernel.org,
	rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
	Jan Stancek <jstancek@redhat.com>,
	Arnaldo Carvalho de Melo <acme@redhat.com>,
	Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v5 02/24] x86/elf, um/x86/elf: Move relocation constants
 to UAPI
Message-ID: <20260908151238.GBaqAl5iKb64meuPJl@fat_crate.local>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-2-3a93791af1cf@linutronix.de>
 <20260908135513.GAaqATwXHcQD7plnH-@fat_crate.local>
 <20260908161740-0d79e592-87a6-43c5-9174-84ce1904e639@linutronix.de>
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
In-Reply-To: <20260908161740-0d79e592-87a6-43c5-9174-84ce1904e639@linutronix.de>
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 08, 2026 at 04:26:00PM +0200, Thomas Wei=C3=9Fschuh wrote:
> The existing, generic ELF definitions are there.
> The ELF stuff in include/linux/ is highly specific to Linux.

And putting them in UAPI casts them in stone. I wouldn't want to maintain=
 them
forever if not necessary.

> Also later in the patchset I want to expose the definitions to the
> tools/ build. Exposing generic UAPI definitions to tools/ is a much
> easier sell than include/linux/.

tools/ *copies* kernel headers on a "they're needed" basis. No need to pu=
t
anything in UAPI for that.

It's even written down: tools/include/uapi/README

--=20
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

