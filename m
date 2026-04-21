Return-Path: <linuxppc-dev+bounces-19889-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 74F14F8FA66
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 12:19:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0LyW70CLz2xQB;
	Tue, 21 Apr 2026 22:19:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776773987;
	cv=none; b=eX7Tjm7NRcTSnMeHVfPoQyviY+fca37/pPVJVLCf6zCLeIN/Whs5vtiZciqf78VuyTkJ61oUluQzK/Jg3JJpn0owIWMioYWXXgsLgMopt1Do5RLV/6brk7eJHGidWX515Qz4rPWwW4rUkLBRMuULlFoDnheM7Nifli9m6RMLeD/cdY4eAw2klqWEMIIyPlB7RBRvDUpV7lAhA2SDas7rw5KDkf3owr77ODg+xMr/JI6lUxO4T6sQx38qH8F4S7C7oTAlM4OgeyfEZJ3NTmr6VLOcb0jbritRGlSefEnl5tsTGACM0TDEgLgQVzWlK/487jDNtfzTKNXHr5c2PZP4rw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776773987; c=relaxed/relaxed;
	bh=vPHwFw5HHJka+xANCiAhcAPbp7wHGr/DNQOtUCyQXW0=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Q1FWcNTBRg1LmOx78Gn2cRFmvl6nFy/JLHGf3eJAAAGwqT3iE7fqVwC57IBTRAjcloC4uUaa3wsDk5DO/C+EvNdOS/L37+mI9gXmAiPjVOxSa/rpWps03gOcjyHOkJLwT2ehO3TRylcubcRKA7xjXrnfzL8Bv3HteJ9wBPNADyHvsBCudA2Y0a/izaNVbxES5er0jf08LGaKBx/0QBxiDGYd14WlmlQN4md6vOo5beCi9l76jWzxUSK1YzoLrMUfHaKCYth0zgaRIZ44SxQGda8vg8dHrSVUaQbJg4gNNPThG4zCKOG3fMS+3yUG0CFg1qPpa1iOdI7W12Rq4DA+2w==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ozk7A0rp; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ozk7A0rp;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0LyV6d3Sz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 22:19:46 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-82fa8d6425bso1131936b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 05:19:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776773984; x=1777378784; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=vPHwFw5HHJka+xANCiAhcAPbp7wHGr/DNQOtUCyQXW0=;
        b=Ozk7A0rpB8mAM/mMA0S0ghmTfrYlEtc0WNBlCJ8a6Hs6BfFtOPJk8i7bJP/1hcG7P+
         VgyNccA3mkYnivpoyyT8NsAfiyPTguQ/qk/MbXLnuiYkUbL3PIJjW9KW+RyQRVymDaf4
         A9yS3pBjEkO3ds3w+0Fgbmyo/JF8EFumO6pG7+2Rm2awTqAm2t0R/jNy3wYZF/n5Ti5D
         F6ECzebvc0s9RuUuqrOH6JlmRjEhTcuuvd3jpJ/28YOyBZ/D/7c94HpC/QMfVRgilOi6
         WmjFI/Lj7p4jUHS+bFy1qhJDOTaAwV+ravW1SF711B2hwrc2WpZfS8b/uhiIZDVszu5U
         BG/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776773984; x=1777378784;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=vPHwFw5HHJka+xANCiAhcAPbp7wHGr/DNQOtUCyQXW0=;
        b=JRm44WBtjvxzOVrp0dnEe5UVb3wuUFZaiGXfFB0Aa3lOzCOdUZnKVeapA6JnSiWzfx
         OeadZkZyR4kNjbrux0Vu5H3+Tm017yqCb6/08Ay2EpOAptbV6n40vob4iMVT+BTI+3hY
         ank0BonmXfWkzWSdA9ChsaSPGvD4Z0proHEzcU4mhf5bEbIubrAWJiMQHRDWZY0q5VPv
         jNvDghiBHgnSrgriMuFkn/1YNwAUAWC2f2dTWCQVk0XEzemT6Wp+GEtT8kccs2UTQlVX
         M90fvoEsxUBF65ZhTimgdYO3f3kREQnjkI4K6s5Z3yPQdCyH2DIOssBcGgzBOGmy3ssw
         84Sg==
X-Forwarded-Encrypted: i=1; AFNElJ/r43yv+v/0WzED8Z94gKgpWlF4YhxN7sQ8MNaRPT1sP78DKJh5URy/rCm3+QU1d9lC1cVpU0OxYKwbKXc=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyZe3uNGndjHrBXA2yZjnvia86mAYHl0ciG8ru0ekv6y1TIREGF
	3WsDK6w27APpfh8kwbDfS3Aq4jkxGrAMCL3VxE2pS2gw+CEGZkk7PX2A
X-Gm-Gg: AeBDietvv+p9+bu+mgAksS2e3FazlMLdVhsga7vpEdfeB3FmhvIDswWwYiGqnMe1GTP
	ekM8OGF8G8mqFWcpw1h9Zkpag8U/6bZgzphEZ+IVKp5swJrg53/MmszOE648z/5Fr0NeAFbnCbX
	tWty8dlOu82nJpSTKxAgpgFlQPI0iigibMihrgjCMKSgh+rI2SEnxBMhFMKRfqmJlYjvD48guQo
	zFa6+rPdWJdaGPuYay+Vcpr7oei5cFRSdMtWC8qXJ+uxP6imcby+VC3JD3KyeM+gVY/InwHR7JN
	YIwL/KcubUhX5Nw98vmMx7s3O9qkLTNNBvb/Qn/JRK/NC54fpAL/pIEvjrZH19MGcAXuF2WDOZy
	T/YLhtKetV/9DMbXfdcPNjfeJ2ugKxOmroLQ20NTIjYM0VaFfLx5Z6muG6W1sUvpBTQDrEk3jJw
	uNbXuVpYglYjzqlUyTp5JahI+XU1liInNHMvI/1fs3iXLtm54zHUsvKxGe+JdpawQlnYf3+nuRO
	+VsHw==
X-Received: by 2002:a05:6a00:2d1f:b0:82f:bd8:70eb with SMTP id d2e1a72fcca58-82f8c876febmr17561225b3a.21.1776773984383;
        Tue, 21 Apr 2026 05:19:44 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8e9f7735sm14090875b3a.21.2026.04.21.05.19.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:19:43 -0700 (PDT)
Date: Tue, 21 Apr 2026 17:49:32 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Link Mauve <linkmauve@linkmauve.fr>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH V11 1/4] rust: Fix "multiple candidates for rmeta
 dependency core" error
Message-ID: <aedpk1iaeYyKPSOI@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260417152253.2312961-1-mkchauras@gmail.com>
 <20260417152253.2312961-2-mkchauras@gmail.com>
 <aedFgEicDW6LAcuq@luna>
 <aedJGuF9P2V1lOCZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
 <aedQ629D0x-5KuKw@luna>
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
Content-Transfer-Encoding: 8bit
In-Reply-To: <aedQ629D0x-5KuKw@luna>

On Tue, Apr 21, 2026 at 12:26:51PM +0200, Link Mauve wrote:
> On Tue, Apr 21, 2026 at 03:25:22PM +0530, Mukesh Kumar Chaurasiya wrote:
> > On Tue, Apr 21, 2026 at 11:38:08AM +0200, Link Mauve wrote:
> > > Hi Mukesh,
> > > 
> > > This patch doesn’t apply on top of mainline, which tree did you base it
> > > off?
> > > 
> > It was on mainline v7.0 tag.
> 
> Great thanks, they do apply there!
> 
> I needed three more patches for the kernel to build on PPC32, I’ve
> attached them but they are absolutely not patches which could go into
> the kernel (except for the second, enabling asm_experimental_arch).
> 
> What do you think we should do about them?
> 
Regarding the 2nd patch you sent, As the support is experimental as of
now, Let's wait till we get everything stablized, till then we'll use
nightly build for all variants of powerpc. Once we mark it as
maintained, then we can try to push that patch.

Maybe Miguel can comment better on this.

Regarding other patches, I am planning to work on ppc32 once ppc64le
stabilizes.

Regards,
Mukesh

> > On latest there is a confilict. I'll send out a rebased version.
> > 
> > > On Fri, Apr 17, 2026 at 08:52:50PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > > > When building Rust code for powerpc64le with LLVM=1 and -j1, rustc
> > > > encounters an error: "multiple candidates for `rmeta` dependency `core`
> > > > found", with two candidates:
> > > > 1. The host's standard library from the rustup toolchain
> > > > 2. The kernel's custom libcore.rmeta in the rust/ directory
> > > > 
> > > > This occurs because the build system uses `-L$(objtree)/rust` for host
> > > > library builds (proc_macro2, quote, syn), which causes rustc to search
> > > > the rust/ directory. During this search, rustc finds both the kernel's
> > > > custom libcore.rmeta and gains access to the host's standard library,
> > > > creating a conflict.
> > > > 
> > > > The solution is to separate host libraries into a dedicated rust/host/
> > > > subdirectory and use `-L$(objtree)/rust/host` for host builds instead
> > > > of `-L$(objtree)/rust`. This ensures that:
> > > > 
> > > > 1. Host library builds (proc_macro2, quote, syn) only search rust/host/
> > > >    and never encounter the kernel's libcore.rmeta
> > > > 2. Proc macro builds use `-L$(objtree)/rust/host` to find their
> > > >    dependencies
> > > > 
> > > > Special handling is added for rustdoc-pin_init, which is a host build
> > > > (to access the alloc crate) but depends on proc macros from the main
> > > > rust/ directory. It uses explicit `--extern` paths to reference the
> > > > proc macros without adding `-L$(objtree)/rust`, which would reintroduce
> > > > the conflict.
> > > > 
> > > > The rust/host/ directory is added to clean-files to ensure it's removed
> > > > during `make clean`.
> > > > 
> > > > Link: https://github.com/Rust-for-Linux/linux/issues/105
> > > > Link: https://github.com/linuxppc/issues/issues/451
> > > > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > > > ---
> > > >  rust/Makefile | 38 +++++++++++++++++++++-----------------
> > > >  1 file changed, 21 insertions(+), 17 deletions(-)
> > > > 
> > > > diff --git a/rust/Makefile b/rust/Makefile
> > > > index 9801af2e1e02..e234b8a39358 100644
> > > > --- a/rust/Makefile
> > > > +++ b/rust/Makefile
> > > > @@ -3,6 +3,9 @@
> > > >  # Where to place rustdoc generated documentation
> > > >  rustdoc_output := $(objtree)/Documentation/output/rust/rustdoc
> > > >  
> > > > +# Clean generated host directory
> > > > +clean-files := host/
> > > > +
> > > >  obj-$(CONFIG_RUST) += core.o compiler_builtins.o ffi.o
> > > >  always-$(CONFIG_RUST) += exports_core_generated.h
> > > >  
> > > > @@ -27,7 +30,7 @@ endif
> > > >  
> > > >  obj-$(CONFIG_RUST) += exports.o
> > > >  
> > > > -always-$(CONFIG_RUST) += libproc_macro2.rlib libquote.rlib libsyn.rlib
> > > > +always-$(CONFIG_RUST) += host/libproc_macro2.rlib host/libquote.rlib host/libsyn.rlib
> > > >  
> > > >  always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated.rs
> > > >  always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.c
> > > > @@ -150,7 +153,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
> > > >  	OBJTREE=$(abspath $(objtree)) \
> > > >  	$(RUSTDOC) $(filter-out $(skip_flags) --remap-path-prefix=% --remap-path-scope=%, \
> > > >  			$(if $(rustdoc_host),$(rust_common_flags),$(rust_flags))) \
> > > 
> > > The issue is here ↑, --remap-path-prefix=% got removed and the two
> > > previous lines got merged into one.
> > > 
> > Yeah will fix this.
> > > > -		$(rustc_target_flags) -L$(objtree)/$(obj) \
> > > > +		$(rustc_target_flags) -L$(objtree)/$(obj)$(if $(rustdoc_host),/host) \
> > > >  		-Zunstable-options --generate-link-to-definition \
> > > >  		--output $(rustdoc_output) \
> > > >  		--crate-name $(subst rustdoc-,,$@) \
> > > […]
> > > 
> > > Thanks anyway for iterating on this series!  I’ve started writing a DRM
> > > driver based off a previous version. :)
> > > 
> > That's cool. Thanks.
> > 
> > Regards,
> > Mukesh
> > > -- 
> > > Link Mauve
> > > 
> 
> -- 
> Link Mauve

> From 79b614dd7be16a1108e1f0176a7bc235fa163a4e Mon Sep 17 00:00:00 2001
> From: Link Mauve <linkmauve@linkmauve.fr>
> Date: Wed, 8 Apr 2026 14:16:04 +0200
> Subject: [PATCH 1/3] XXX: Workaround sstep.c
> 
> These variables are used only on CONFIG_PPC64, which causes compilation
> to fail on PPC32.
> ---
>  arch/powerpc/lib/sstep.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/lib/sstep.c b/arch/powerpc/lib/sstep.c
> index ac3ee19531d8..dc129f0cb6a0 100644
> --- a/arch/powerpc/lib/sstep.c
> +++ b/arch/powerpc/lib/sstep.c
> @@ -1354,15 +1354,15 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
>  #ifdef CONFIG_PPC64
>  	unsigned int suffixopcode, prefixtype, prefix_r;
>  #endif
> -	unsigned int opcode, ra, rb, rc, rd, spr, u;
> +	unsigned int opcode, ra, rb/*, rc*/, rd, spr, u;
>  	unsigned long int imm;
>  	unsigned long int val, val2;
>  	unsigned int mb, me, sh;
> -	unsigned int word, suffix;
> +	unsigned int word/*, suffix*/;
>  	long ival;
>  
>  	word = ppc_inst_val(instr);
> -	suffix = ppc_inst_suffix(instr);
> +	//suffix = ppc_inst_suffix(instr);
>  
>  	op->type = COMPUTE;
>  
> @@ -1480,7 +1480,7 @@ int analyse_instr(struct instruction_op *op, const struct pt_regs *regs,
>  	rd = (word >> 21) & 0x1f;
>  	ra = (word >> 16) & 0x1f;
>  	rb = (word >> 11) & 0x1f;
> -	rc = (word >> 6) & 0x1f;
> +	//rc = (word >> 6) & 0x1f;
>  
>  	switch (opcode) {
>  #ifdef __powerpc64__
> -- 
> 2.54.0
> 

> From d4e72fad43175bde99287b8efdece900e5b53444 Mon Sep 17 00:00:00 2001
> From: Link Mauve <linkmauve@linkmauve.fr>
> Date: Fri, 10 Apr 2026 13:05:24 +0200
> Subject: [PATCH 2/3] XXX: Enable asm_experimental_arch for PowerPC asm!()
> 
> This is needed to compile the kernel crate, otherwise this error
> happens:
> 
> error[E0658]: inline assembly is not stable yet on this architecture
>   --> ../rust/kernel/sync/barrier.rs:19:14
>    |
> 19 |     unsafe { core::arch::asm!("") };
>    |              ^^^^^^^^^^^^^^^^^^^^
>    |
>    = note: see issue #93335 <https://github.com/rust-lang/rust/issues/93335> for more information
>    = help: add `#![feature(asm_experimental_arch)]` to the crate attributes to enable
>    = note: this compiler was built on 2026-03-25; consider upgrading it if it is out of date
> 
> error: aborting due to 1 previous error
> 
> For more information about this error, try `rustc --explain E0658`.
> ---
>  rust/kernel/lib.rs     | 3 +++
>  scripts/Makefile.build | 2 +-
>  2 files changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/rust/kernel/lib.rs b/rust/kernel/lib.rs
> index d93292d47420..92ccd47dc3ee 100644
> --- a/rust/kernel/lib.rs
> +++ b/rust/kernel/lib.rs
> @@ -47,6 +47,9 @@
>  // To be determined.
>  #![feature(used_with_arg)]
>  //
> +// Needed for PowerPC inline assembly.
> +#![feature(asm_experimental_arch)]
> +//
>  // `feature(derive_coerce_pointee)` is expected to become stable. Before Rust
>  // 1.84.0, it did not exist, so enable the predecessor features.
>  #![cfg_attr(CONFIG_RUSTC_HAS_COERCE_POINTEE, feature(derive_coerce_pointee))]
> diff --git a/scripts/Makefile.build b/scripts/Makefile.build
> index 3652b85be545..c7cc21994c5a 100644
> --- a/scripts/Makefile.build
> +++ b/scripts/Makefile.build
> @@ -321,7 +321,7 @@ $(obj)/%.lst: $(obj)/%.c FORCE
>  #
>  # Please see https://github.com/Rust-for-Linux/linux/issues/2 for details on
>  # the unstable features in use.
> -rust_allowed_features := asm_const,asm_goto,arbitrary_self_types,lint_reasons,offset_of_nested,raw_ref_op,slice_ptr_len,strict_provenance,used_with_arg
> +rust_allowed_features := asm_const,asm_goto,asm_experimental_arch,arbitrary_self_types,lint_reasons,offset_of_nested,raw_ref_op,slice_ptr_len,strict_provenance,used_with_arg
>  
>  # `--out-dir` is required to avoid temporaries being created by `rustc` in the
>  # current working directory, which may be not accessible in the out-of-tree
> -- 
> 2.54.0
> 

> From 2c0a3ec3da6fa1f0151225c05159f7a812317d32 Mon Sep 17 00:00:00 2001
> From: Link Mauve <linkmauve@linkmauve.fr>
> Date: Fri, 10 Apr 2026 13:51:24 +0200
> Subject: [PATCH 3/3] XXX: Workaround for __udivdi3() and __umoddi3()
> MIME-Version: 1.0
> Content-Type: text/plain; charset=UTF-8
> Content-Transfer-Encoding: 8bit
> 
> The core crate currently depends on these two functions for i64/u64/
> i128/u128/core::time::Duration formatting, but we shouldn’t use that in
> the kernel so let’s panic if they are ever called.
> ---
>  rust/exports.c | 9 +++++++++
>  1 file changed, 9 insertions(+)
> 
> diff --git a/rust/exports.c b/rust/exports.c
> index 587f0e776aba..5f1cdf13882e 100644
> --- a/rust/exports.c
> +++ b/rust/exports.c
> @@ -12,6 +12,7 @@
>   */
>  
>  #include <linux/export.h>
> +#include <linux/panic.h>
>  
>  #define EXPORT_SYMBOL_RUST_GPL(sym) extern int sym; EXPORT_SYMBOL_GPL(sym)
>  
> @@ -20,6 +21,14 @@
>  #include "exports_bindings_generated.h"
>  #include "exports_kernel_generated.h"
>  
> +void __udivdi3(void) {
> +	panic("__udivdi3() called but shouldn’t be made available on this architecture!\n");
> +}
> +
> +void __umoddi3(void) {
> +	panic("__umoddi3() called but shouldn’t be made available on this architecture!\n");
> +}
> +
>  // For modules using `rust/build_error.rs`.
>  #ifdef CONFIG_RUST_BUILD_ASSERT_ALLOW
>  EXPORT_SYMBOL_RUST_GPL(rust_build_error);
> -- 
> 2.54.0
> 


