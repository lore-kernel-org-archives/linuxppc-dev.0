Return-Path: <linuxppc-dev+bounces-27021-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id EBEE6C79FB9
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 11:02:15 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgZWV0ZFvz2xRs;
	Thu, 10 Sep 2026 21:02:14 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=193.142.43.55
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789038133;
	cv=none; b=WAlb1bScBdldEkhl4CmxY/tII7tGqnSH3U6Sjey9sDTiSeUx2j1/WZz3thiJqG6ytmb71GTCB4kbI2M1wpsVak/R4pyIO06ZQS6OpeA2/6CGCQEoV3ENk+S13xkz1fiU3erd2TXMnbvHZj5NVBkQZgC26z9OUgpvtaOI44u/b5S3lZbfMdSBloVrXs2+6GBwj2KGm613wMvGSCKGTRby5rlYBG7B5v9VkLZdneVjA4tODMIoISVW2MtGs3RekfJQxqw+YDG/e0TDF2G/pXixmfbCLpupY67s/YAM4+K5GX2RjOLuaII5oBTrYLSe14FYqxWx2ZZVlPS4PqdnQRx9bw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789038133; c=relaxed/relaxed;
	bh=PgYnxH7H+tx7By2AM1sGAFXZm+b1KJf3JRXo/DozlYY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=I+teq2bc+HDyqFO4NhV07pEVN/dJAgginqYCiR9quii1UZ+XfPPuFZOFC/u4ywYbi9fB/72jvq00mrZa/Gd6fdl8eZpZ529eFppFo7sr9+6I5mSfYE2gaK/0Hmnilb7ufxUTXk3P5vHTSu2CIuHEZNfTJXxt4jXsz04fayxlJbBULxcHgnpRwhiqYa8o/LhsQSTIhbRZvEQb6nykLmpY7MSwIi1CdMjfnApOEM0msU1rAybNvd8jPGhpn9Np52WfoMqvF2LxAsIrySsidn1MHuitCS7QzTLnhALuqHnq7rFUPZsIcEfB3cPsmBM35ZNECn7lf+LnswXDEi2QnIheUQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de; dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=nq0t+a13; dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5bolpWR6; dkim-atps=neutral; spf=pass (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org) smtp.mailfrom=linutronix.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=linutronix.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=linutronix.de header.i=@linutronix.de header.a=rsa-sha256 header.s=2020 header.b=nq0t+a13;
	dkim=pass header.d=linutronix.de header.i=@linutronix.de header.a=ed25519-sha256 header.s=2020e header.b=5bolpWR6;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linutronix.de (client-ip=193.142.43.55; helo=galois.linutronix.de; envelope-from=t-8ch@linutronix.de; receiver=lists.ozlabs.org)
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgZWR5LCCz2xLq
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 21:02:11 +1000 (AEST)
Date: Thu, 10 Sep 2026 10:33:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020; t=1789029186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgYnxH7H+tx7By2AM1sGAFXZm+b1KJf3JRXo/DozlYY=;
	b=nq0t+a13NaTSuYF4CeenzbMGkxy4JvQOZ0gqaRRD4cV9bqclklB2nkc3jSKVIovWerzMBz
	LqWRF9Z/Wq6H9Z9U5z8AE+VQpRnpoU7JLulnrl5INZdb1CMxTMPnV05lqmLTS9b7bcJFm5
	+Jtv/C4gZ+T4oI66pMCTl5u5+NHtvOkMZSIlvstSVWgfAMfF9Uop+cNAY9pJ1wnhDHX3xt
	0EaSx9l4i8NZrU/FDddnLlVafk+g+pAz5r8kkTP/k3bKjkb7OYFvZ0hMvCNLC7AHSIlTma
	Sl6zOqwKm4Xb6YskdZMSeNDBr8w0HvolM2Ie/L+Q4FlwBs5LfCMZSPSM6ejB+A==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
	s=2020e; t=1789029186;
	h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
	 to:to:cc:cc:mime-version:mime-version:content-type:content-type:
	 content-transfer-encoding:content-transfer-encoding:
	 in-reply-to:in-reply-to:references:references;
	bh=PgYnxH7H+tx7By2AM1sGAFXZm+b1KJf3JRXo/DozlYY=;
	b=5bolpWR6VEOPOQDk4aOdzzFsCMnIuSs3+o1Bx7da9a/VgRkSmhJ5Iff3Ie4w9HH2UtpfSb
	Me4QoEKEhv6cUqDA==
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
Message-ID: <20260910095003-d751da0d-37d1-4b14-9941-e3c388c94733@linutronix.de>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-2-3a93791af1cf@linutronix.de>
 <20260908135513.GAaqATwXHcQD7plnH-@fat_crate.local>
 <20260908161740-0d79e592-87a6-43c5-9174-84ce1904e639@linutronix.de>
 <20260908151238.GBaqAl5iKb64meuPJl@fat_crate.local>
 <20260909075156-06ff671c-ab7b-47d8-aaa3-588b570888bc@linutronix.de>
 <20260909144930.GAaqFx-mjH3-u6jLjw@fat_crate.local>
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
In-Reply-To: <20260909144930.GAaqFx-mjH3-u6jLjw@fat_crate.local>

On Wed, Sep 09, 2026 at 07:49:30AM -0700, Borislav Petkov wrote:
> On Wed, Sep 09, 2026 at 07:59:51AM +0200, Thomas Weiﬂschuh wrote:
> > These names and numbers are defined by the architectures' ELF specifications.
> > They are already cast in stone. For example see Table 4.9 of [0].
> > Changing them would break compilers, linkers, loaders and more or less every
> > existing ELF binary.
> 
> So?

This was a direct response to your "And putting them in UAPI casts them in
stone". With the idea that we can't possibly cast them more into stone
than they already are.

> Your goal is to provide them to tools/. You want to provide them to
> *everything*. See the discrepance here?

My goal is to make my tool work. For that I can just as well add ad-hoc
relocation constants definitions in my own code. Just as everybody else
has done, in what seems like a well-honed tradition.
Unifying the constant definitions was a preparatory cleanup step I put
in my series.

Some architectures (like x86) define the relocation constants in internal
kernel headers, but others do so in their UAPI headers, so we can't have it
in include/linux/.
As the UAPI is the common superset, and given that we already have quite some
ELF definitions in the UAPI I this is where I put the relocation constants.
We can add a tools/-specific header which is not shared with include/linux/
but then we still have duplication with the regular kernel code.

As a coincidence, these definitions in the UAPI would also be useful
for nolibc static PIE support, but that is more of a weird curiousity
and not something I want to bring up as reason here.

(...)

> > Also we already have other, closely related, ELF constants in the UAPI,
> > see {,tools/}include/uapi/linux/elf{,-em}.h.
>
> Srsly?!?
> 
> You moved them there:
> 
> commit 626fd35278295fbb21f2da331cd8028e9738d965
> Author: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> Date:   Wed Feb 26 12:44:46 2025 +0100
> 
>     tools/include: Add uapi/linux/elf.h
>     
>     It will be used by the vDSO selftests.

I think we are talking past each other. To me the act of "exposing
something to UAPI" is adding it to include/uapi/ (or the arch/ variants).
That is an actual change worthy of discussion, which I am happy to have.
Copying headers (UAPI or not) to tools/include/ is a rote administrative task.

The commit above is the latter.
elf.h has been part of the UAPI for as long as the UAPI exists.

> Looking at the rest, it looks like some elf bits got exported, you added some
> more and that ship has sailed.

"some elf bits got exported" undersells it a bit. There are 14 years of dozens
of people adding constants to include/uapi/linux/elf.h. So far it doesn't seem
to have been a problem.

> I still think us providing headers is completely unnecessary and it will come
> to cause conflicts eventually but hey, not my problem.

As there is pushback, I'll just drop all of the header changes.
Maybe somebody else wants to deal with it at some point. Not my problem either.


Thomas

