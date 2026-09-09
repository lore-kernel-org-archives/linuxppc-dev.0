Return-Path: <linuxppc-dev+bounces-26872-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 00E37C79F8C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 06:09:12 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfr3q4m26z2ygp;
	Wed, 09 Sep 2026 16:09:11 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788934151;
	cv=none; b=V7qBV3ApXX4+4J43XxITa3y45gsJYzMImHUwHyUYoqCEc6ggTR1gyVNue2Xc/k/R3oTqz12hJbmZj2vAZ92l6vMu4D/qsIo1rPwIJ/gM4Kmc8a3zuFtr+K1EWGjiciPucHvhCksW1F/JHb+VLJ0IJUbtdiQRgIgPpGIyrnTmHDzJlVgiMdez3m0DYERykf6V1OQH9VH8Y5sZb7yu/540aOt/3IhZHOIgXHmML3BU1QCqxcwOr4eiiDg5TGjM06g0HUFDXgJbk9w7J4sL6829aUNPsV89RNPrq0l5+dhLchqOBxZ4nWif7O7tC2gpzOqnfrW6XB9ft9faLW8Xbw+y2A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788934151; c=relaxed/relaxed;
	bh=Fsx+E+IxhTgqrNd5fDNEdWA4P4WjUu/zI9gxcY2gf1k=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Ru1P7Uwq55lNZUHZPbJOuWWGyZfCp9TznCqaWzRKryJJIlP2LTyLJtnifM5M/HpvEXUo57+jtFRdnkIGwQTu2BVqP/ch+KvooirZKjON1zHmDAWSASDgZdxmpgxEOAO8nGUKYtB8D0Go92Ikem+1gwE5qz2lAwM63aMfmmmI8Yrwv0sMzegX0wBJOe8FdZZBznyQQNIatf/7lessu7EADXbTtjmcUCtZD9LCkWMb56cYh2THHe3nB1vcYZm4EQOMCV1eVZqAjvk8bcS+CUrXyFQFy8FzyChHP1oZrMHucv316Ge2gSgrXpeh7XbuJ5zRlILFJvwz+t7JyoN5ollRSA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Ba8CFyue; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=fAJ6G75L; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=Ba8CFyue;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=fAJ6G75L;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfr3p69kdz2y2J
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 16:09:10 +1000 (AEST)
Date: Wed, 9 Sep 2026 08:09:07 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788934147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fsx+E+IxhTgqrNd5fDNEdWA4P4WjUu/zI9gxcY2gf1k=;
	b=Ba8CFyueZIBv0OelbgTnQd8Liev5J1UqmQNZMlTvb9O8KcOJJTdoaB2ThyVqE1f8eVdkpB
	wTE4Lfz5SmplS9gum8fRJfjedlxYamdPBHVJ2zN0PmVQ/fAuza+eRyHTaqNl21luZW5FSV
	7mSECa3gWtr+fP2KkXm6iC1JdfB5MAxu3Qk/bZ7DsXkgsNE6bOUj/o8lxR1BIYweICcdVu
	Fm6yt/eraobBg9c2pGNyeS88edKZbZQw3VCce9fTmXPsolJkOwKGjp5YqUwJX6x49ccs+s
	3BERlZcIkDcJWAolf/r7TyPPNGX94YB/SldI2jSo7Dc4KeV5buIEb4c2Lh26vA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788934147;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 in-reply-to:in-reply-to:references:references;
	bh=Fsx+E+IxhTgqrNd5fDNEdWA4P4WjUu/zI9gxcY2gf1k=;
	b=fAJ6G75LaW8nnqqa43BRDYqlP7QW6Q+nfq2qssYjtogHzBntGBNA7rR18bMVBCUfwB7vq4
	TycChAiSqeQsMbBw==
From: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
To: "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>
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
	Thomas Gleixner <tglx@kernel.org>, Boqun Feng <boqun@kernel.org>, Nicolas Schier <nsc@kernel.org>, 
	linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org, llvm@lists.linux.dev, 
	linux-mm@kvack.org, linux-um@lists.infradead.org, 
	linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org, loongarch@lists.linux.dev, 
	linux-s390@vger.kernel.org, linux-mips@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	linux-kbuild@vger.kernel.org, Jan Stancek <jstancek@redhat.com>, 
	Arnaldo Carvalho de Melo <acme@redhat.com>, Alexandre Ghiti <alexghiti@rivosinc.com>
Subject: Re: [PATCH v5 17/24] powerpc/vdso: Enable the vdsocheck tool
Message-ID: <20260909080124-ef171c1a-83ff-486b-b632-8613011a5a97@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-17-3a93791af1cf@linutronix.de>
 <7c9f6ec3-5886-41ea-8803-d81019321d29@kernel.org>
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
In-Reply-To: <7c9f6ec3-5886-41ea-8803-d81019321d29@kernel.org>

On Tue, Sep 08, 2026 at 04:41:09PM +0200, Christophe Leroy (CS GROUP) wrote:
(...)

> > diff --git a/arch/powerpc/kernel/vdso/Makefile b/arch/powerpc/kernel/vdso/Makefile
> > index 368759f81708..ca20b91b4373 100644
> > --- a/arch/powerpc/kernel/vdso/Makefile
> > +++ b/arch/powerpc/kernel/vdso/Makefile
> > @@ -81,9 +81,9 @@ targets += vdso64.lds
> >   CPPFLAGS_vdso64.lds += -P -C
> >   # link rule for the .so file, .lds has to be first
> > -$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/vgetrandom-32.o $(obj)/crtsavres-32.o FORCE
> > +$(obj)/vdso32.so.dbg: $(obj)/vdso32.lds $(obj-vdso32) $(obj)/vgettimeofday-32.o $(obj)/vgetrandom-32.o $(obj)/crtsavres-32.o $(vdsocheck) FORCE
> >   	$(call if_changed,vdso32ld_and_check)
> > -$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o $(obj)/vgetrandom-64.o FORCE
> > +$(obj)/vdso64.so.dbg: $(obj)/vdso64.lds $(obj-vdso64) $(obj)/vgettimeofday-64.o $(obj)/vgetrandom-64.o $(vdsocheck) FORCE
> >   	$(call if_changed,vdso64ld_and_check)
> >   # assembly rules for the .S files
> > diff --git a/lib/vdso/check/vdsocheck.rs b/lib/vdso/check/vdsocheck.rs
> > index e45a1fbc6829..429bdcd65818 100644
> > --- a/lib/vdso/check/vdsocheck.rs
> > +++ b/lib/vdso/check/vdsocheck.rs
> > @@ -69,6 +69,33 @@ fn allowed_relocations_for_machine(machine: u16) -> Option<AllowedRelocations<'s
> >               ..Default::default()
> >           }
> >           .into(),
> > +        bindings::EM_PPC => AllowedRelocations {
> > +            in_object_file: &[
> > +                bindings::R_PPC_REL24,
> 
> Not sure this is correct, see commit 42ed6d56ade2 ("powerpc/vdso: Block
> R_PPC_REL24 relocations")

(...)

The mentioned commit prevents the relocation in the final vDSO,
while my patch allows it in the intermediate object files.
In the final vDSO no relocations are accepted whatsovever.

