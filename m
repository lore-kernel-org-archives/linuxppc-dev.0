Return-Path: <linuxppc-dev+bounces-16579-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8987EE9538C
	for <linuxppc-dev@archiver.kernel.org>; Wed,  4 Feb 2026 11:53:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4f5dzF4kYNz2xm3;
	Wed, 04 Feb 2026 22:53:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2a00:1450:4864:20::34a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1770201702;
	cv=none; b=GqHqADVsZ1SUq6XMmqQ7IYZmrbaV1crbf3ILTNjCb7BJfuJCOF977vT0ZFrLmtSc9MOrGTBkxg414n6QbBPCt2xY5TKea/ekrJEZaWJOebW0Mvf5bXepR+6Hjnm11n8qrDg9fZpr02hYqbjeqrNh94svGvj3UZMwej2xhjh9xHgN69GQGwBepchjX9L9L/LCbgkrmeLkjzswr1yx+s8Q/mdbykL5FhvlKHdS0xNpndZW2viBTMSclrkHAPCFo+2zPQtugvh9URFOny3qmvnnasuQOnocSC4d8ZYmNvP23TluGC5S+5Y1OF69iR0nkkaLBauFKxIMpEBrGXfQcE8Y0A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1770201702; c=relaxed/relaxed;
	bh=pRwouiQfEMsoda5YPwBCj431swMzELp5kqTN2koP4hQ=;
	h=Date:In-Reply-To:Mime-Version:References:Message-ID:Subject:From:
	 To:Cc:Content-Type; b=NxYVzFrCUzN4bNvMYVf1l7Jbp32eMNuI9WOm+YgvdsQPrQ9hc92uT/nqyJrIJ9SZZMjgTHSs08hwtsjZN4ICKmYOPcAtagV19TAKQfe3kKCp7xTXAVEixhCa2jyrywUVbw7YZotDDSi//9gliVGKozVok518zYR+ZfvwvWA0tDFcqjSVX+IMusQEOq+bgCdx4kwFbciVl+T5s4yIjRoOK2Q9VI0F43B5xmTfM/SRobE5LwSRcNiTza58yXYI7LkWeiKzwwBfcrU6ah9lwvOvGsyhkI5QFICOwweZoQeGjo+sxwnZRtFt1/LF38tHhWWMztr3SK1MOCGAClfkBbCbpA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com; dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=AkQkc2Hy; dkim-atps=neutral; spf=pass (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3xikdaqkkdamdolfhu1kojrrjoh.frpolqx0ssf-ghyolvwv.r2odev.ruj@flex--aliceryhl.bounces.google.com; receiver=lists.ozlabs.org) smtp.mailfrom=flex--aliceryhl.bounces.google.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=reject dis=none) header.from=google.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=google.com header.i=@google.com header.a=rsa-sha256 header.s=20230601 header.b=AkQkc2Hy;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=flex--aliceryhl.bounces.google.com (client-ip=2a00:1450:4864:20::34a; helo=mail-wm1-x34a.google.com; envelope-from=3xikdaqkkdamdolfhu1kojrrjoh.frpolqx0ssf-ghyolvwv.r2odev.ruj@flex--aliceryhl.bounces.google.com; receiver=lists.ozlabs.org)
Received: from mail-wm1-x34a.google.com (mail-wm1-x34a.google.com [IPv6:2a00:1450:4864:20::34a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4f5cNN0PZmz2xHt
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2026 21:41:39 +1100 (AEDT)
Received: by mail-wm1-x34a.google.com with SMTP id 5b1f17b1804b1-483129eb5ccso4047345e9.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 04 Feb 2026 02:41:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20230601; t=1770201695; x=1770806495; darn=lists.ozlabs.org;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pRwouiQfEMsoda5YPwBCj431swMzELp5kqTN2koP4hQ=;
        b=AkQkc2HyTG5PkxYbl+9eOIesXR3J8zW3ftFBrDOISfuJ6hNSfBXBA+N3Wa6Xfcdq1l
         pT9hMWFhP0mDe/RMuRNFR9PIC22wYnb79bjyk+js5KbHUl5sjX2Cz4+eD1jg7tOCFfZR
         EGek0D43DORq7CXiH+3WPdSvnuCTFrB4nrX4Vq+3lM8KrM/kZiwnPenpTLegdwtaTGxb
         rPFk8scbXwpgTQi3yc1nPrQzNisVKCNebRJOel5ToXN6i6+ydH0/L2NZ6rfrMmuLQDRz
         1YxBF7jj9lE6n06SaRwb0wrmdoaTx3xv5869OyTniR7UrJ7FvFSqI1/dIqJyuvv5nKDM
         hCDg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20230601; t=1770201695; x=1770806495;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=pRwouiQfEMsoda5YPwBCj431swMzELp5kqTN2koP4hQ=;
        b=jhpQxDtW0N2JEt7XnbZLIjGryvFhUe2ClYprUFfAaCQKOUOBMx/Y+HpGrV8JTc/IlZ
         ysaaci59fRotbb6lKKNQ5V+9aVtlfRKdbB/bZFKBB8ARIo+Jz2qLNGPoF1mYlI2rOT6o
         QtiKjWCHQeNz46zxJ9X5W6tL3E0cphkOC+Nsav9dZpvNcTUzh0ZkHl4IjWp1CKmHMlU3
         iwwMg3JWOKc4TGv/qG6KgzB0o65PxZOlKRdgVGnRpHyQuHMKBErHlD6rCKE4XQGyr1AH
         7gAHLVLKB/s6kGWtGCyDgdNhGHgwQbgtz26lx5pyzygThGwDyPh2cgyfM7PVRjakp2YV
         2XRw==
X-Forwarded-Encrypted: i=1; AJvYcCVS7KjIDJ/M+bCq+IYeRNCjFBBl8N7boBaPQzK9qBMN89LKu+2NKoRHndtUfByVqJzuofnQYZbjJsDxtSw=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwY5Y02TloZTZZC6zX0uKkWRZ8dsdf+fOd6/9kPvF6DyIPMbz18
	bM7wJ1dFzzj94UJR2jnsuc2nR/Ix4wh4f2Az6JgImsbRoq9VIFHE4kakKrLMwcBwGRs6ophhbQ2
	F4YgthPPwr+qMeJDnUw==
X-Received: from wmbgz9-n1.prod.google.com ([2002:a05:600c:8889:10b0:480:6c9b:592])
 (user=aliceryhl job=prod-delivery.src-stubby-dispatcher) by
 2002:a05:600c:680a:b0:480:6c75:ddce with SMTP id 5b1f17b1804b1-4830e9a9b17mr35223645e9.33.1770201694753;
 Wed, 04 Feb 2026 02:41:34 -0800 (PST)
Date: Wed, 4 Feb 2026 10:41:33 +0000
In-Reply-To: <20260204030507.8203-1-linkmauve@linkmauve.fr>
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
Mime-Version: 1.0
References: <20260204030507.8203-1-linkmauve@linkmauve.fr>
Message-ID: <aYMiXcy33YEVkgYM@google.com>
Subject: Re: [PATCH] rust: Add PowerPC support
From: Alice Ryhl <aliceryhl@google.com>
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>, 
	Boqun Feng <boqun@kernel.org>, Gary Guo <gary@garyguo.net>, 
	"=?utf-8?B?QmrDtnJu?= Roy Baron" <bjorn3_gh@protonmail.com>, Benno Lossin <lossin@kernel.org>, 
	Andreas Hindborg <a.hindborg@kernel.org>, Trevor Gross <tmgross@umich.edu>, 
	Danilo Krummrich <dakr@kernel.org>, Jonathan Corbet <corbet@lwn.net>, 
	Madhavan Srinivasan <maddy@linux.ibm.com>, Michael Ellerman <mpe@ellerman.id.au>, 
	Nicholas Piggin <npiggin@gmail.com>, "Christophe Leroy (CS GROUP)" <chleroy@kernel.org>, 
	Peter Zijlstra <peterz@infradead.org>, Josh Poimboeuf <jpoimboe@kernel.org>, 
	Jason Baron <jbaron@akamai.com>, Steven Rostedt <rostedt@goodmis.org>, 
	Ard Biesheuvel <ardb@kernel.org>, Nathan Chancellor <nathan@kernel.org>, 
	Nick Desaulniers <nick.desaulniers+lkml@gmail.com>, Bill Wendling <morbo@google.com>, 
	Justin Stitt <justinstitt@google.com>, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org, 
	llvm@lists.linux.dev, officialTechflashYT@gmail.com, 
	Ash Logan <ash@heyquark.com>, Roberto Van Eeden <rw-r-r-0644@protonmail.com>, 
	"Jonathan =?utf-8?Q?Neusch=C3=A4fer?=" <j.neuschaefer@gmx.net>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable

On Wed, Feb 04, 2026 at 04:05:04AM +0100, Link Mauve wrote:
> For now only Big Endian 32-bit PowerPC is supported, as that is the only
> hardware I have.  This has been tested on the Nintendo Wii so far, but I
> plan on also using it on the GameCube, Wii U and Apple G4.

Super cool!

> These changes aren=E2=80=99t the only ones required to get the kernel to =
compile
> and link on PowerPC, libcore will also have to be changed to not use
> integer division to format u64, u128 and core::time::Duration, otherwise
> __udivdi3() and __umoddi3() will have to be added.  I have tested this
> change by replacing the three implementations with unimplemented!() and
> it linked just fine.

Uh oh this seems tricky. How is this not a problem on arm32 too?

Perhaps we should just be providing __udivdi3() and __umoddi3() in
general?

> diff --git a/arch/powerpc/include/asm/jump_label.h b/arch/powerpc/include=
/asm/jump_label.h
> index d4eaba459a0e..238f0f625a36 100644
> --- a/arch/powerpc/include/asm/jump_label.h
> +++ b/arch/powerpc/include/asm/jump_label.h
> @@ -15,14 +15,18 @@
>  #define JUMP_ENTRY_TYPE		stringify_in_c(FTR_ENTRY_LONG)
>  #define JUMP_LABEL_NOP_SIZE	4
> =20
> +/* This macro is also expanded on the Rust side. */
> +#define ARCH_STATIC_BRANCH_ASM(key, label)		\
> +	"1:\n\t"					\
> +	"nop # arch_static_branch\n\t"			\
> +	".pushsection __jump_table,  \"aw\"\n\t"	\
> +	".long 1b - ., " label " - .\n\t"		\
> +	 JUMP_ENTRY_TYPE key " - .\n\t"			\
> +	 ".popsection \n\t"
> +
>  static __always_inline bool arch_static_branch(struct static_key *key, b=
ool branch)
>  {
> -	asm goto("1:\n\t"
> -		 "nop # arch_static_branch\n\t"
> -		 ".pushsection __jump_table,  \"aw\"\n\t"
> -		 ".long 1b - ., %l[l_yes] - .\n\t"
> -		 JUMP_ENTRY_TYPE "%c0 - .\n\t"
> -		 ".popsection \n\t"
> +	asm goto(ARCH_STATIC_BRANCH_ASM("%c0", "%l[l_yes]")
>  		 : :  "i" (&((char *)key)[branch]) : : l_yes);

In case this patch takes a long time to land, it may make sense to split
this part out in a separate patch that can land now.

Also, consider pre-emptively updating arch_static_branch_jump too. We
probably need it at some point in the future.

> diff --git a/scripts/generate_rust_target.rs b/scripts/generate_rust_targ=
et.rs
> index 38b3416bb979..0054880ba0ea 100644
> --- a/scripts/generate_rust_target.rs
> +++ b/scripts/generate_rust_target.rs
> @@ -188,6 +188,16 @@ fn main() {
>          panic!("arm uses the builtin rustc target");
>      } else if cfg.has("ARM64") {
>          panic!("arm64 uses the builtin rustc aarch64-unknown-none target=
");
> +    } else if cfg.has("PPC32") {
> +        ts.push("arch", "powerpc");
> +        ts.push("data-layout", "E-m:e-p:32:32-Fn32-i64:64-n32");
> +        ts.push("features", "+soft-float");
> +        ts.push("llvm-target", "powerpc-unknown-eabi");
> +        if cfg.rustc_version_atleast(1, 91, 0) {
> +            ts.push("target-pointer-width", 32);
> +        } else {
> +            ts.push("target-pointer-width", "32");
> +        }

Is there no built-in target we can use? I think we want to avoid adding
new targets if at all possible.

Alice

