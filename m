Return-Path: <linuxppc-dev+bounces-26756-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DFD84C79F82
	for <linuxppc-dev@archiver.kernel.org>; Tue,  8 Sep 2026 07:37:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hfG4Y1rnNz2xlJ;
	Tue, 08 Sep 2026 17:37:49 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2001:8b0:10b:1:d65d:64ff:fe57:4e05"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1788853069;
	cv=none; b=TgfozTW10EuSEs1SbPhi7g9sMx2FBrSuoe3TRpvcxfTjmNyTnPTFd4oFcERE57ke21HZjl2liKX2ZblQq9ykOSkDy2zt1/+ikYeLLyG1r7x9DwdpF4oEECOeFhyJvQ52Xylvld7Lt4NxE35Xuzpz2WW9q9o83KFaU9CWmFovWfSEfc0JN/d3YtU1PaWoGgRyuIOxex9tAYY3/x/qav2/7pPNZM3BbWXbTQKpFjnboQSWT795IadXWxhTo5t1qGslqBg1uk239Yduip+MrzlkCTuBxrCTDq+D3blU7I3ztr+al2NLSBYxRtyPxm0q3ZGlLoHdVL1mDrBw4+XmnOrqdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1788853069; c=relaxed/relaxed;
	bh=dMspgRwQUUIexqKss7dqowtOmwD0tLbRBkFb+1ouQnY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=H/qLt6+3otML+RLwqH/WYLcFfbs8JOD2EQ5EMH9Oc4Z0ISFEm3a0fGqDuTPGzj9GAFtGwsBUzX3mUdYDHTW5ly9lOSDjc5UtZpxgAe517afrd+D5n6pA+C0BzBf76zPuI2SIZ0fXXYJV0MxjzQz/Uy41zl74ROeJ2jOhnLyfDnn6aqTbDW6v9J5gWEH5aDFZM9LRg6EpXrstZ8e7ndvHX1jnjrfxuIt2t3NFa2deSek6Bf8Pabpur2KdwnFjLke25S8O5zDq+kOZX96nbhFCod5YHam7qol60a0c2pOXZ1qQOcDtZCWa6EGFhw2xhQsexreVnpnO3ELR1SVPnYXXwQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org; dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=irAwsshP; dkim-atps=neutral; spf=pass (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org) smtp.mailfrom=infradead.org
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=infradead.org
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; secure) header.d=infradead.org header.i=@infradead.org header.a=rsa-sha256 header.s=desiato.20200630 header.b=irAwsshP;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=infradead.org (client-ip=2001:8b0:10b:1:d65d:64ff:fe57:4e05; helo=desiato.infradead.org; envelope-from=peterz@infradead.org; receiver=lists.ozlabs.org)
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hfG4S598Jz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Sep 2026 17:37:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
	d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Transfer-Encoding:
	Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:
	Sender:Reply-To:Content-ID:Content-Description;
	bh=dMspgRwQUUIexqKss7dqowtOmwD0tLbRBkFb+1ouQnY=; b=irAwsshPXpU7Uf/rfFaj3uWs6G
	difPdlK64/emyFJJjlL7wNOeoAd6Y+U30iaYxFlQNgUaXhJ5XP9GQvgT7SeejFL749VvbdmXzNQmr
	ysoKC7HRo3DXe9AyxTg6XU4ih3jJvnovv2Ujltj+xakHIL0+9ST9dekY+kWUCq6mECTuqGA167fg+
	YqFWds1pqUcKbMJUd2jIJjqcUYt3toc+D0q3aR2UwfeZbWbAc5JAxTcsD0VD8CvN28YZRwquKZu0g
	pKwTeSbCwX4MUVnlh4QxgKngIIgLaxab029w2jsxL2wYaE+8OY428gXbHH21x+RnEEnFMu/t4r9jb
	gZmtLwfw==;
Received: from 77-249-17-252.cable.dynamic.v4.ziggo.nl ([77.249.17.252] helo=noisy.programming.kicks-ass.net)
	by desiato.infradead.org with esmtpsa (Exim 4.99.2 #2 (Red Hat Linux))
	id 1x3qOD-0000000H407-3KtV;
	Tue, 08 Sep 2026 07:37:10 +0000
Received: by noisy.programming.kicks-ass.net (Postfix, from userid 1000)
	id E0348300400; Tue, 08 Sep 2026 09:37:07 +0200 (CEST)
Date: Tue, 8 Sep 2026 09:37:07 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Thomas =?iso-8859-1?Q?Wei=DFschuh?= <thomas.weissschuh@linutronix.de>
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
	Borislav Petkov <bp@alien8.de>,
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
	=?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
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
Subject: Re: [PATCH v5 12/24] vdso: Add the vdsocheck tool
Message-ID: <20260908073707.GV4120091@noisy.programming.kicks-ass.net>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-12-3a93791af1cf@linutronix.de>
 <20260908071911.GU4120091@noisy.programming.kicks-ass.net>
 <20260908093302-1a1cf0c7-8103-48b1-9f6a-abd5c5c16523@linutronix.de>
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
In-Reply-To: <20260908093302-1a1cf0c7-8103-48b1-9f6a-abd5c5c16523@linutronix.de>

On Tue, Sep 08, 2026 at 09:35:46AM +0200, Thomas Weiﬂschuh wrote:
> On Tue, Sep 08, 2026 at 09:19:11AM +0200, Peter Zijlstra wrote:
> > On Tue, Sep 08, 2026 at 08:33:46AM +0200, Thomas Weiﬂschuh wrote:
> > > All vDSO code needs to be completely position independent. Symbol
> > > references are marked as hidden so the compiler emits PC-relative
> > > relocations. However there are cases where the compiler may still
> > > emit absolute relocations, as they are valid in regular PIC DSO code.
> > > These would be resolved by the linker and will break at runtime.
> > > This has been observed on arm64, see commit 0c314cda9325 ("arm64: vdso:
> > > Work around invalid absolute relocations from GCC")
> > > 
> > > Introduce a tool to check for absolute relocations during the build,
> > > as the current inline-shell logic is not expressive enough.
> > > The check is done on the object files as the relocations will not exist
> > > anymore in the final DSO. As there is no extension point for the
> > > compilation of each object file, perform the validation in vdso_check.
> > > 
> > > Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> > > ---
> > >  Makefile                    |  19 ++
> > >  lib/vdso/Kconfig            |   5 +
> > >  lib/vdso/Makefile           |   2 +
> > >  lib/vdso/Makefile.include   |  14 ++
> > >  lib/vdso/check/.gitignore   |   3 +
> > >  lib/vdso/check/Makefile     |  34 +++
> > >  lib/vdso/check/elf.rs       | 498 ++++++++++++++++++++++++++++++++++++++++++++
> > >  lib/vdso/check/vdsocheck.rs | 154 ++++++++++++++
> > >  8 files changed, 729 insertions(+)
> > 
> > Urgh, does this mean I have to have rust installed just to build a
> > kernel now?
> 
> No.
> 
> If you don't have rust installed the build will instead use the existing shell
> script for a less thorough check. We only need one build machine at some point
> to have rust installed to report issues and this check to be useful.

Ah, *phew*. Thanks!

