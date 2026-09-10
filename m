Return-Path: <linuxppc-dev+bounces-27009-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 021CCC79F9F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 10 Sep 2026 06:53:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4hgT0252Qqz2y2L;
	Thu, 10 Sep 2026 16:53:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1789023186;
	cv=none; b=IdZ1sYnXAbgIPqo1tcW9Dci1lkBLU5VKD3LWNHiZLUo6Wq0hqs9kIXeqb1nBm181gsGYIz2VLjcRHSVVndgfLgmp1Z0s2U+R59VTqVWLatJlXu/IU9HahF2DEC9PZVcIkBcgbkWUcAej0GCxYqK4GeI+BtOoad5Q9xOEl/qQNKFs81z7CuAvQT4as+DZTOwjKXLWZ04pDRIsH0DmMDfDOyd9k17izUoSIPpg9cdTtA6i3/XB8X3N20TEB6PxzVoOOT4slQwqLi0+FtxrrTPhurqmx2VcFuCBL5J5zpfnAgF7Etu8+jPDzVKnTDTZpjozvyHMVBkYY0Rr7vwndNImqA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1789023186; c=relaxed/relaxed;
	bh=UNeh3lUekONIP+bceTcz/qzQUFIH9IGvapVm9Sqamho=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=SotCfd1fz1wqB1zoSYccXhBbEaNnys47oSVpJIguObBFtHUAyu4mP1++nBz8lDKyfCsVZR+lBDslThuR0qFzuxYuVeQf6HGWBiM3+hKNfi/SVU3VaDvj6ch6ZKszhftv4amMCeST9WnzXHDDt9MvMpv/gYLb3KszGr008TA4gNOQplvtTEJaSWqgY2fjp+3NcHoaPP5ioJjjSR0RA9t3TYpXS63ujOXk3W+pjatoscra7HtOvg9k/yD2gVZAjzIQP5CLZpve2+4hFgzJF3qb3RXDtpSr+vctC8fpVYLWfOlnf3+RlACzaLeGl2hCPnA9MZyVIqah5DJL7QVlvrU+Vg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UDfBgMFh; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UDfBgMFh;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4hgSzw6rYQz2xYh
	for <linuxppc-dev@lists.ozlabs.org>; Thu, 10 Sep 2026 16:53:00 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-3856d6fbcb3so5671785a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 09 Sep 2026 23:53:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1789023178; x=1789627978; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:from:to:cc:subject:date:message-id:reply-to:content-type;
        bh=UNeh3lUekONIP+bceTcz/qzQUFIH9IGvapVm9Sqamho=;
        b=UDfBgMFhvGEqhXBzH5wU4J5ROECyUUI5CZ9dO/Yx+7Z++pqg3xKHXQs9Z/iAmkpZ0G
         f4ON7ua5t+USQIGiaW5/cIdXpPAKDabMs72/o+G+qX9f53gYXlhvkuLGkuiSjjEuXIH9
         dB8trscS/G84Rpgl4jX+mmso41c1trpL+KaDgNVafMGtBbubQg0KllC5GOsEWnGZUkMv
         ZOexMYkSBIfzwkNX887Q7DTUPznphn1uIT/SvArUgYn/G39wuEyEh/6+liYg2RcGWXq+
         W9tiCA7xbHYsg0puvtlM4tUxuZ864WdBxvJHhti1yH7cRmx7bkH1f+ORt/eVWFiKrofa
         Gj5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1789023178; x=1789627978;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :content-type:mime-version:references:message-id:subject:cc:to:from
         :date:x-gm-gg:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=UNeh3lUekONIP+bceTcz/qzQUFIH9IGvapVm9Sqamho=;
        b=Ff2WTz87T0rzTrP7cGZlJhQUFIfYW37KenzCEJSEbXi9GI0FxGUhJlJ00eVeYjn7/3
         irZyRYirV9NWvS+1fS7qI3PwFlWm3mbOzLyUGWKHHig/O0vny22MT9Sy+3zbRy2w4tEl
         g6Wj+lk6GC2Z3ZPe9NybKyXolElfGetFuNtvvPbobKTOlxCaiBvcyl+gm454ggiemAeL
         Zshr1BojIkUDohiwhSvp9KZSxr/gC2P+ropyHS2sDHfBv8SRNSsmo4QsA/9WGbZCu+a1
         mkocfP7G7xAvTj/clYo71RRrGCQRe2/OKOQQ5CLrnz3X/2TN40syqE/vm5oOrNHJjzAX
         lqVA==
X-Forwarded-Encrypted: i=1; AKwUvBz6tACFKEZiLo2I0k4XFEq5cmky8qKpSKsOuucZ3CiuZ8bjZGZzBRAkN/577VVs4g5X/FCEnBHIUXEFc1s=@lists.ozlabs.org
X-Gm-Message-State: AFuF++ns6CA3U7r+fBVjZmSagfbWl152mQfhtQ1H6ipS3oNKB0PwlDe4
	7EoVNanc5qTohi9JOr0CDKAle6vPUMdteMAJvja2vjqOA4unODaCY+mr
X-Gm-Gg: AYBFou3B+QlC2jVTfEjPncqUnApOodBx/STb6d4ZCAeHpHpYEPR8FBHAERyOVtYyeuw
	pheu0quGnZj7JcQywTDt1uCGntzJfRVrUXpnzT4KEnFOhWLnbisqSlkXc5N2I+AT8A02kLA4qAe
	Zo9EwqZVdE+BLMLEkuhBKCVQg2/xBrdr6Ty8ARiV5VcZhrFLxXs7YyyE8joGwm0+lCpeiiJUzIL
	cYMDvqRP6vFztNwuV1oaeYz6nZB8qH8pasWULm22ZhWZ0C5SI8up2gb0sFuoF8p2WBYdqy7o8Rb
	CEl5+VO1b0jgo166aTcLk+hE1DTxi2xvr2UcT/bVAlM6o7WK/bNUxquXEGJe9rjI9tmjNj8OAHa
	usPxoBpefMGskc8TY0tv+AcFzNWBOTUIJJDdhCJFxF8Qkyn+LPc9uP5icvTRoDmWzWcXeTY0IiC
	r9u/ZCrBd6K9LDM3Y9bNcvIxp1xvArb3DTzfMVFDRt5LdHRg33ydQ3xqjkqNFknvOjoO2/qQ6at
	oh4vjXGiLxPjrT93HU/KQLdu4qinvi97GC7juP58to=
X-Received: by 2002:a17:90b:3d92:b0:398:bf7e:b267 with SMTP id 98e67ed59e1d1-39b2614df9dmr61606265a91.2.1789023178292;
        Wed, 09 Sep 2026 23:52:58 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-39d7e77498csm2694423a91.3.2026.09.09.23.52.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Sep 2026 23:52:57 -0700 (PDT)
Date: Thu, 10 Sep 2026 12:22:33 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Thomas =?utf-8?Q?Wei=C3=9Fschuh?= <thomas.weissschuh@linutronix.de>
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
Message-ID: <aqJS61DbuUI3xoY3@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260908-vdso-absolute-reloc-v5-0-3a93791af1cf@linutronix.de>
 <20260908-vdso-absolute-reloc-v5-12-3a93791af1cf@linutronix.de>
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
In-Reply-To: <20260908-vdso-absolute-reloc-v5-12-3a93791af1cf@linutronix.de>

On Tue, Sep 08, 2026 at 08:33:46AM +0200, Thomas Weiﬂschuh wrote:
> All vDSO code needs to be completely position independent. Symbol
> references are marked as hidden so the compiler emits PC-relative
> relocations. However there are cases where the compiler may still
> emit absolute relocations, as they are valid in regular PIC DSO code.
> These would be resolved by the linker and will break at runtime.
> This has been observed on arm64, see commit 0c314cda9325 ("arm64: vdso:
> Work around invalid absolute relocations from GCC")
> 
> Introduce a tool to check for absolute relocations during the build,
> as the current inline-shell logic is not expressive enough.
> The check is done on the object files as the relocations will not exist
> anymore in the final DSO. As there is no extension point for the
> compilation of each object file, perform the validation in vdso_check.
> 
> Signed-off-by: Thomas Weiﬂschuh <thomas.weissschuh@linutronix.de>
> ---
>  Makefile                    |  19 ++
>  lib/vdso/Kconfig            |   5 +
>  lib/vdso/Makefile           |   2 +
>  lib/vdso/Makefile.include   |  14 ++
>  lib/vdso/check/.gitignore   |   3 +
>  lib/vdso/check/Makefile     |  34 +++
>  lib/vdso/check/elf.rs       | 498 ++++++++++++++++++++++++++++++++++++++++++++
>  lib/vdso/check/vdsocheck.rs | 154 ++++++++++++++
>  8 files changed, 729 insertions(+)
> 
> diff --git a/Makefile b/Makefile
> index 4ad67b737af7..e6e0dd7818ef 100644
> --- a/Makefile
> +++ b/Makefile
> @@ -1559,6 +1559,25 @@ vdso_install: export INSTALL_FILES = $(vdso-install-y)
>  vdso_install:
>  	$(Q)$(MAKE) -f $(srctree)/scripts/Makefile.vdsoinst
>  
> +# ---------------------------------------------------------------------------
> +# vDSO check
> +
> +ifdef CONFIG_RUST_IS_AVAILABLE
> +ifdef CONFIG_VDSO_CHECK
> +
> +# Build the checker early.
> +prepare: vdsocheck
> +
> +# If the architecture builds the vDSO early, make sure to be earlier.
> +PHONY += vdso_prepare
> +vdso_prepare: vdsocheck
> +
> +PHONY += vdsocheck
> +vdsocheck:
> +	$(Q)$(MAKE) $(build)=lib/vdso/check $@
> +endif
> +endif
> +
>  # ---------------------------------------------------------------------------
>  # Tools
>  
> diff --git a/lib/vdso/Kconfig b/lib/vdso/Kconfig
> index 597f5f0f9681..112b42a5aeb1 100644
> --- a/lib/vdso/Kconfig
> +++ b/lib/vdso/Kconfig
> @@ -23,3 +23,8 @@ config VDSO_GETRANDOM
>  	select VDSO_DATASTORE
>  	help
>  	  Selected by architectures that support vDSO getrandom().
> +
> +config VDSO_CHECK
> +	bool
> +	help
> +	  Selected for architectures that are supported by the 'vdsocheck' progam.
	s/progam/program

Regards,
Mukesh

