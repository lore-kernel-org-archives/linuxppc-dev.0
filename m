Return-Path: <linuxppc-dev+bounces-27004-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 96961C79FB7
	for <linuxppc-dev@archiver.kernel.org>; Wed,  9 Sep 2026 19:48:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgBFT2H1dz302T;
	Thu, 10 Sep 2026 05:48:45 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=65.109.113.108
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788983325;
	cv=none; b=dnEK7aV8pmrrHQwVX47BpvlxT0EpsFTfzmJFGDNLZXygB3v13sXUDA36gDLbu7RUy+C0QFDw3FYHGCVxX+bg979Rdt7JbckHWwW2r+WiPYXNu+WIEiNdGJrHo7dqJ15Z5uThs/iEcPEItswWNswYXbS3hB1LT9Qw81QznFDHeR/FzAFSI2w79rzomgRSkX9UUeEz2KDyng+b/fMk4qj13H7nFnpaSrWo9ENJPYYk/sO0ZUiAp6BIY+uuJNSREhiAm3xtBqG9HEbU/PfD8eojC5k3vZe28wKxFB3VxTMUcVT4Oq1+HG/JMWPj/rs18jvUJ+vPjVD259GcivKg7wqg+g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788983325; c=relaxed/relaxed;
	bh=J47hfMemV3x17DwbT77P3iNi200v7sArNBFyj4FIEqg=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=f1NfG+UklSj0PRsxS6UHp+FHkBBbx5nJUKW3Um5JKreln57RPfoVE3Dwryc1Kuy7jIkgWsqgUAgNlCJczg3jGN0y+VCBD4mH01LJcg+fb+jaUbP3ho4z2sYvFGA6wmXpTJHf2Aco3d5VriKXYn74yRXpjgiPH2x0ywyQ0T5vFLNI1KPtp1beMk09K4ZG2W/dYbqIDtO4zQ3Q7v8D8YaUrfLwH2w7/kfCclIR+mfuJ7c9aCNDS1Urk9kM4mJc+gvRuWUMnsV1ZOUPrWYqsAa9Hc2xQrlNreeJgazc2g5zGUNvRI8RRTrsIulmgpr2O5E/204SLTlbu6RASgim2Cw7wQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de; dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=dwPEQtMe; dkim-atps=neutral; spf=pass (client-ip=65.109.113.108; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org) smtp.mailfrom=alien8.de
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=alien8.de
Authentication-Results: lists.ozlabs.org;
	dkim=pass (4096-bit key; unprotected) header.d=alien8.de header.i=@alien8.de header.a=rsa-sha256 header.s=alien8 header.b=dwPEQtMe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=alien8.de (client-ip=65.109.113.108; helo=mail.alien8.de; envelope-from=bp@alien8.de; receiver=lists.ozlabs.org)
Received: from mail.alien8.de (mail.alien8.de [65.109.113.108])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgBFR2pXqz3000
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 05:48:42 +1000 (AEST)
Received: from localhost (localhost.localdomain [127.0.0.1])
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTP id 3887A40E02C3;
	Wed,  9 Sep 2026 19:48:36 +0000 (UTC)
X-Virus-Scanned: Debian amavisd-new at mail.alien8.de
Authentication-Results: mail.alien8.de (amavisd-new); dkim=pass (4096-bit key)
	header.d=alien8.de
Received: from mail.alien8.de ([127.0.0.1])
	by localhost (mail.alien8.de [127.0.0.1]) (amavisd-new, port 10026)
	with ESMTP id bnu2s_xtow5o; Wed,  9 Sep 2026 19:48:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=alien8;
	t=1788983306; bh=J47hfMemV3x17DwbT77P3iNi200v7sArNBFyj4FIEqg=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
	b=dwPEQtMeNA/0X4YLMHgzSgsrJEReG+/8XquiXTEMnDnzYNtgPhOSI1ZuSGGmf+uhU
	 V5oLCoI78r3zgomqpkBhYGGK+og2znQrV4khKuBGPQqxLpck4AnonixUBFFT+OQ9pO
	 XoUFWUpeutEqUWw6qWZlF4MSezuaZDbfmEkEMesoxESuMOiVSVBIpvn/lv+oZivGlF
	 NbJK5pOApwMB2U2u72e0KDAnjAnnVYBqW7hqQCjgkPVGWIyW67likuKOr8KL2iCigy
	 wfxOcixBxel6j9y0nGeCklkkuo9SS7BzFZrMmfwjY0x8ZNHxCfzFe8nm3kMfbW2SkQ
	 hVt6NGm6loU4cNhNTVlWkweLsqiDVWKEfmcR69gNzENXWQF+DAqzhl1dooy8yRdyQ8
	 hzYMVbv7DEaFBzo345o2SdVnqq8Hbvr6zEs3Jz+soHKZ00hNuarCPD8kKht9ZWHhDX
	 K6qLog8avAPiAmQEstoo2bUscQYMRoJj1G/FpwnavifIGACdSvVBx3KQXFGuPZFI6C
	 LW+eR2FIosDuuKNbgs+V1Q5Aiz3ngAXwHI3OctVEHffGJL4rAUmbrTcA7D2mTokDP5
	 cDqR90QAouoVLFeoaPRexpBIoBjUfItvei9H8egAwCVgnmg67MgfJgP2vnIu6Np7cO
	 rVr0gT+x4+ZZPc8QFps0Hbqg=
Received: from stx.tnic (unknown [IPv6:2600:1700:38ca:c00::42])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange ECDHE (P-256) server-signature ECDSA (P-256) server-digest SHA256)
	(No client certificate requested)
	by mail.alien8.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 0329240E01ED;
	Wed,  9 Sep 2026 19:47:23 +0000 (UTC)
Date: Wed, 9 Sep 2026 12:47:20 -0700
From: Borislav Petkov <bp@alien8.de>
To: "H. Peter Anvin" <hpa@zytor.com>
Cc: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>,
	Paul Walmsley <paul.walmsley@sifive.com>,
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
Message-ID: <20260909194720.GCaqG3yPjDmwKikdIQ@fat_crate.local>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-2-3a93791af1cf@linutronix.de>
 <20260908135513.GAaqATwXHcQD7plnH-@fat_crate.local>
 <20260908161740-0d79e592-87a6-43c5-9174-84ce1904e639@linutronix.de>
 <20260908151238.GBaqAl5iKb64meuPJl@fat_crate.local>
 <20260909075156-06ff671c-ab7b-47d8-aaa3-588b570888bc@linutronix.de>
 <20260909144930.GAaqFx-mjH3-u6jLjw@fat_crate.local>
 <F9786718-8378-443D-A21E-77E057B62BB2@zytor.com>
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
In-Reply-To: <F9786718-8378-443D-A21E-77E057B62BB2@zytor.com>

On Wed, Sep 09, 2026 at 12:27:30PM -0700, H. Peter Anvin wrote:
> I do believe there are *some* headers that would be reasonably to export to
> tools/ beyond what it is in uapi; a major reason for that is that the tools
> are suffering from a crazy level of internal inconsistency right now. 

Well, as long as it stays "internal" I don't mind.

What I do mind is this unnecessary and senseless exposure of headers.

-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette

