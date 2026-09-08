Return-Path: <linuxppc-dev+bounces-26783-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1820FC79F82
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 09:37:47 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfJkx3pnmz2xlJ;
	Tue, 08 Sep 2026 19:37:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a0a:51c0:0:12e:550::1"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788860265;
	cv=none; b=RxQPvUSLbk94gnAxD4T2xVif5160uRCiSBW1n3vErbU5pSFn51TvWJYu3VbqoKef03KYmHT1+wVIWdj5ooW+pYTZ53d6TLWFEcyvbMHD/STac2nUGwg0mrwNvaRSbCLhem2q6e8JtN+FdBTG8LEBPZe1pjPLNvJB1eC2wQCcjGCDs3HNJLc5lbpFyfr6zBfrPPglP328eGx4pN5zGeEM/Hcqdx1vN9FUF4HUKg6oAIlCVb2KjOlkm7GANqvSyX0XG3l06hyIfsS1HcjFb3ZZ+ln7xHtBhPCYJag8iXPhf+P85XGUsYkZjeSrobJu0kXObdU2Q80h+oJF0ZBRZSzocA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788860265; c=relaxed/relaxed;
	bh=M4bnahwswymvE5nOIFxOjV/veHxRfM8mUS2vFlMphLI=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=HI6IOgq59dPEbC4JxO8o1CW87wJhCzHHFUywZEl1+i+lnVMIyugbgzI7lx8FATzw5P3qqkg3NiB2kQiJQEFcemfN5SweoalhnqVPyNTdlmA8dPtNS6+AqW3WBVBkjZGSK1DtXsrLpbpqEdis+7mmf5xRNrBRhRSmQotf8nc/eSzg9wISRM47TuK3dLM9s+tex+dDXfdbEwQd7//ADqNKo4i1mMofMOT281+Hs5rFljwyyEYrZurBpVVV8ucx+zPJUHy7U5ZyBBmWldOG8HXsvU7rxYhSW7x6FFXOZ3s6uRYyiFZAPoQlDmTQKz3VrgbRBGuOmoIDt82kTuld7nXskA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=F99r3XWu; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Eal5NKMa; dkim-atps=neutral; spf=pass (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=F99r3XWu;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=Eal5NKMa;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=2a0a:51c0:0:12e:550::1; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfJkw3cf3z2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 19:37:44 +1000 (AEST)
Date: Tue, 8 Sep 2026 11:37:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1788860254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4bnahwswymvE5nOIFxOjV/veHxRfM8mUS2vFlMphLI=;
	b=F99r3XWuTQu1aQaZj3Rg35vrK+Vh4xoW6esYP08KsnkTB5yxRHFlAX+DCSQ9MmE/ytdjCY
	bT6ZSwlbgz0Tp/9QlaRm9xj6k6x+gQowVBcql48kgWTi7EY8hoPzlCmCwOwmHC8SxOCa3J
	0icgZeoQJU6KNJO4gOL3qhihZkDuWn/jnlOBCrvGJD7o4Fnl7C36ruhip68Y+2nMvnOAVX
	9XoGZlIvgcOwA32mE4o6lEcMBu1d9f3urtNxvC6vBsxPGt/e/3MpqOApvFdmwEjj/Zakfp
	dC6HHcg6MFdoR4Ez1Du4OVqzN/fIOPQmWkTrSXFlU1lEDS+2M+h55TuuwKLKTg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1788860254;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=M4bnahwswymvE5nOIFxOjV/veHxRfM8mUS2vFlMphLI=;
	b=Eal5NKMa9KoeM279byQBbEfyeEmUQxO7LFbQVe68UMo95PO7FvduzWF1IqJWwbafV544s9
	HhGMsegsgfpaGqBA==
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
Subject: Re: [PATCH v5 11/24] tools headers UAPI: Sync ELF headers with the
 kernel sources
Message-ID: <20260908113701-7b7e8e99-81cd-40b3-8a33-f316defe6f45@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-11-3a93791af1cf@linutronix.de>
 <06996199-5255-41d0-ba6a-ebeca57f61da@kernel.org>
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
In-Reply-To: <06996199-5255-41d0-ba6a-ebeca57f61da@kernel.org>

On Tue, Sep 08, 2026 at 10:56:58AM +0200, Christophe Leroy (CS GROUP) wrote:
> Le 08/09/2026 ‡ 08:33, Thomas Weiﬂschuh a Ècrit†:
> > Pick up changes from the UAPI ELF header files.
> > This picks up general changes to elf.h, elf-em.h which was forgotten
> > previously and the new elf-r.h.
> > 
> > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > 
> > ---
> > Cc: Arnaldo Carvalho de Melo <acme@redhat.com>
> > ---
> >   tools/include/uapi/linux/elf-em.h |  71 ++++
> >   tools/include/uapi/linux/elf-r.h  | 696 ++++++++++++++++++++++++++++++++++++++
> >   tools/include/uapi/linux/elf.h    | 112 +++++-
> >   3 files changed, 868 insertions(+), 11 deletions(-)
> > 
> 
> > diff --git a/tools/include/uapi/linux/elf.h b/tools/include/uapi/linux/elf.h
> > index 5834b83d7f9a..88bdcbb526c1 100644
> > --- a/tools/include/uapi/linux/elf.h
> > +++ b/tools/include/uapi/linux/elf.h
> 
> > @@ -312,7 +323,7 @@ typedef struct elf64_phdr {
> >   #define SHN_ABS		0xfff1
> >   #define SHN_COMMON	0xfff2
> >   #define SHN_HIRESERVE	0xffff
> > -
> > +
> 
> Getting the following warning when applying this series with 'b4 shazam'.
> 
> /home/chleroy/linux-powerpc/.git/rebase-apply/patch:846: trailing
> whitespace.
> 
> Seems to come from here.

That's also present in include/uapi/linux/elf.h.
I'll add a fix for that, too.

> 
> >   typedef struct elf32_shdr {
> >     Elf32_Word	sh_name;
> >     Elf32_Word	sh_type;

