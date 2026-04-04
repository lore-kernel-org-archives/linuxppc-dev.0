Return-Path: <linuxppc-dev+bounces-19304-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 71DB8E88D7B
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 03:39:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnhD20Mtbz2yL8;
	Sat, 04 Apr 2026 14:39:30 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775273969;
	cv=none; b=NluCndiqVhTSi41o6X4SgkBFazhDPYz1qcBWknOhEfWmKwOYrWtO6FVVaiKwFKN18zOTlWYZqSjboZ50rjTuLG6W0q7Ufm5nkT0LcGsaXC6z54SOngrQAgt8pwY0XJ5QXNYUtzry3sy7kNU4HVSo9H264X85bBCFU4EOhRT/PB1WSpV5FedFnWzBI9sDfUzkW/PxkxIiA3RGIfd5LmvXUGmG6qMG9JGasF+3xIJUeqXgh2gqnkrG3B0JnoyfUj/wX+C8HcGLNoMwS1znfmMY2RoDYZ7PLP0kDL7GZjitS5O0b7L+sGIWXhTA7eOhPl5FjpZbRPfra37qiNg8ieuJZw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775273969; c=relaxed/relaxed;
	bh=p/mS68jPp5o6fDVjVxwaQqVlnV+4rvaGWH9gRtfYcJE=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=ebIcj7uBeCEnJXeZJIdzvCjNnl2e5KrAZpWb74P4jQ5BP0nDL84FdGh1nvwUpcDTBatv8KsD6GefVr1K8++55X3jc+5Foy98a8KpcxuGBi7RS7RjoyGuKuzYNc68xvyTZGwxN0+KhEXtNZGDJx5Y9OTU4arSThJv5OU3zlM2i4MeYg8nn6tcsmVjYEx+e3xxAgyG/AhDiqqI6tMJDEdFuDHJwM1pq3Hyy9cVXazbDNKC4YT0pm/rXH6SQ+EakOmFsvE+2HJW/0Nb3V/uwR/vpUfbco4wkMC0nM95pBsZfksIco7/2/+9mX94Z6Ta5HHiybOqzWG/rouZLc1ccJ9rhA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VyUeWqu5; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VyUeWqu5;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62c; helo=mail-pl1-x62c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnhD05Y3hz2xQr
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 14:39:27 +1100 (AEDT)
Received: by mail-pl1-x62c.google.com with SMTP id d9443c01a7336-2b2429f98d0so15442965ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 20:39:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775273965; x=1775878765; darn=lists.ozlabs.org;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=p/mS68jPp5o6fDVjVxwaQqVlnV+4rvaGWH9gRtfYcJE=;
        b=VyUeWqu5RzbL2CY4APQ/stFWJCvVTaRRvLuMaNp0GVd5dipiKNrwiy3BT50tlia1Ji
         lkjk35QINau+t4BQALdjRISPuLT0iJFn/884k2W23qopndG0uE8NxTr/E+qCNMco3h/V
         N8aLtKcif1Fwq61Kh1rh+NQ+TxJbe1uaNbSpw8mXN0P5OQNXvEHOmpthg2a8sMSSE8t4
         gVUOxd3PTH/p+pUdFoxJYC1ufX4XmQ3KSQAesacGxb2bb+SBLfET3JqMLp/GBhzWLZlp
         vZI8qyW3J78SbqSDPsJjZHy1KfJVeveNevS3jEVWpgDgCC+2Y/u7N3M6zE7+lvyK/8YC
         nokg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775273965; x=1775878765;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-gg:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=p/mS68jPp5o6fDVjVxwaQqVlnV+4rvaGWH9gRtfYcJE=;
        b=C5SufYo8I8IFae6+S8tDx08MVDEFArrY/mzxF5FzyeX16Go9NrnziV2L3PA29H245q
         MR1JB5piOUDUQL39GdQRpnzpBEN4uT6xnY57NCL9eKFInoqKo3/xkiPddlz2eoloHzUZ
         bLIPlawVlLfk5QU3BMp4sj0pIfYNzuDf6dz8TG2VvkapN6DfEY6BGUBvwWHxwiVqyZik
         CpudyFE8Sncjwe/tI21EhdQdFGvoMkYVkw7cBherGoRBeW93vCqiBF9WmMBkTL6vi58N
         s46ff+sg4AxJRXT/+TqR+ekliP+QpsEM9GSMKsmo9eAunLNAGJEuAYSAnmZ4ClpodQtr
         imwA==
X-Forwarded-Encrypted: i=1; AJvYcCUbUXnC8NuZV3xckebT043QfHtfWUPeVNqmR0xgn0q6gOWE16jKwHVFcMox25YDKbJ2NlZaTMfFNZaungQ=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx1XO1agPsWvLZER9J4mOFE35TCvO56iu0ng4R1qiujx048yJQo
	R85ukl0zCV14wHZhwwI6LoHxJ7tEQLZ2ypfVg4XXSI51DfD2xADFxvAV
X-Gm-Gg: AeBDievdpIyk1YvoeTpDKpKAVVtxvYftOywk7dEH114JB66taMr3peqhQIOT73maCr1
	2+3Ugq77960WRyeydm+9Gc3hxyB7fnJ53QyvVZzh7zAoSTN+JH7vFC5osxHskyrJTeVJygGFGvk
	iGhJO4T4Q6DQqzde6EfdiBBMC2dISDSOwtvU/IyxK7PKzsvcncIV0lHcOqIfLVOoUlzwby/nUbe
	W/5G3/Mi/6rdDHFvGCjf2oJJNoAAwqQqS1XmN0nC+Pb+R07s4C95J2LjoDVSr+jwD8LZj+Dim5o
	2QOUMaM1hvszjuU4ExDvP2HHn3LsXy6/+afqOkQV/WCQzV3bCkSmID8iE9uT+W89ubg6ISOFeAd
	Ur2P/bfq02h+fzq56qP3H1NGjEtkTSz50XUM8/xiCYgYJGN6H02zVZmYVCCEdJZ/GEG/YRyAV6E
	5hZ+RMVTtc9B2gTShc608fNczXfS/DSRU1zWKLBjYD8tUmOTCHZ+ewo/pMbKQvcOJpmQzvLQ==
X-Received: by 2002:a17:902:f603:b0:2b0:9a61:9e9 with SMTP id d9443c01a7336-2b281769197mr58132275ad.32.1775273965093;
        Fri, 03 Apr 2026 20:39:25 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27478945asm96269225ad.28.2026.04.03.20.39.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 20:39:24 -0700 (PDT)
Date: Sat, 4 Apr 2026 09:09:13 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Gary Guo <gary@garyguo.net>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com, 
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, 
	aliceryhl@google.com, rostedt@goodmis.org, ardb@kernel.org, ojeda@kernel.org, 
	boqun@kernel.org, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org, nathan@kernel.org, 
	nick.desaulniers+lkml@gmail.com, morbo@google.com, justinstitt@google.com, 
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org, rust-for-linux@vger.kernel.org, 
	llvm@lists.linux.dev
Subject: Re: [PATCH V8 1/4] rust: Fix "multiple candidates for rmeta
 dependency core" error
Message-ID: <adCHe9rU_azp8svx@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260403145308.1042622-1-mkchauras@gmail.com>
 <20260403145308.1042622-2-mkchauras@gmail.com>
 <DHJM52JEY7D3.MGKXTZB319ZL@garyguo.net>
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
In-Reply-To: <DHJM52JEY7D3.MGKXTZB319ZL@garyguo.net>

On Fri, Apr 03, 2026 at 04:09:04PM +0100, Gary Guo wrote:
> On Fri Apr 3, 2026 at 3:53 PM BST, Mukesh Kumar Chaurasiya (IBM) wrote:
> > When building Rust code with LLVM=1 with -j1, rustc was encountering
> > an error:
> > "multiple candidates for `rmeta` dependency `core` found", with two
> > candidates:
> > 1. The host's standard library from the rustup toolchain
> > 2. The kernel's custom libcore.rmeta in the rust/ directory
> >
> > This occurred because the build system was using `-L$(objtree)/rust`
> > for host library builds (proc_macro2, quote, syn), which caused rustc
> > to search the rust/ directory. During this search, rustc would find
> > both the kernel's custom libcore.rmeta and gain access to the host's
> > standard library, creating a conflict.
> >
> > The solution is to separate host libraries into a dedicated rust/host/
> > subdirectory and use `-L$(objtree)/rust/host` for host builds instead
> > of `-L$(objtree)/rust`. This ensures that:
> >
> > 1. Host library builds (proc_macro2, quote, syn) only search rust/host/
> >    and never encounter the kernel's libcore.rmeta
> > 2. Proc macro builds use `-L$(objtree)/rust/host` to find their
> >    dependencies
> > 3. Test builds use `-L$(objtree)/rust/test` for their dependencies
> > 4. Target builds continue to use `-L$(objtree)/rust` as before
> >
> > Special handling is added for rustdoc-pin_init, which is a host build
> > (to access the alloc crate) but depends on proc macros from the main
> > rust/ directory. It uses explicit `--extern` paths with absolute paths
> > to reference the proc macros without adding `-L$(objtree)/rust`, which
> > would reintroduce the conflict.
> >
> > The rust/host/ directory is added to clean-files to ensure it's removed
> > during `make clean`.
> >
> > Changes:
> > - Add clean-files := host/ to clean the generated directory
> > - Change host library targets from lib*.rlib to host/lib*.rlib
> > - Update cmd_rustc_procmacrolibrary to create host/ directory
> > - Update cmd_rustc_procmacro to use -L$(objtree)/rust/host
> > - Update cmd_rustdoc to use -L$(objtree)/rust/host for host builds
> > - Update cmd_rustc_test_library to use -L$(objtree)/rust/test
> > - Update rustdoc-pin_init to use explicit --extern paths for proc macros
> 
> This should go after the tags and ---, so it's not part of the commit message.
> 
Hey Gary,

I was intending that to be a part of commit message. May be specifying
that as changes is confusing. I'll put it there as a summary.
> >
> > Link: https://github.com/Rust-for-Linux/linux/issues/105
> > Link: https://github.com/linuxppc/issues/issues/451
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > ---
> >  rust/Makefile | 63 ++++++++++++++++++++++++++++++++-------------------
> >  1 file changed, 40 insertions(+), 23 deletions(-)
> >
> > diff --git a/rust/Makefile b/rust/Makefile
> > index 9801af2e1e02..762bddc868e4 100644
> > --- a/rust/Makefile
> > +++ b/rust/Makefile
> > @@ -3,6 +3,9 @@
> >  # Where to place rustdoc generated documentation
> >  rustdoc_output := $(objtree)/Documentation/output/rust/rustdoc
> >  
> > +# Clean generated host directory
> > +clean-files := host/
> > +
> >  obj-$(CONFIG_RUST) += core.o compiler_builtins.o ffi.o
> >  always-$(CONFIG_RUST) += exports_core_generated.h
> >  
> > @@ -27,7 +30,7 @@ endif
> >  
> >  obj-$(CONFIG_RUST) += exports.o
> >  
> > -always-$(CONFIG_RUST) += libproc_macro2.rlib libquote.rlib libsyn.rlib
> > +always-$(CONFIG_RUST) += host/libproc_macro2.rlib host/libquote.rlib host/libsyn.rlib
> >  
> >  always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated.rs
> >  always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.c
> > @@ -150,7 +153,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
> >  	OBJTREE=$(abspath $(objtree)) \
> >  	$(RUSTDOC) $(filter-out $(skip_flags) --remap-path-prefix=% --remap-path-scope=%, \
> >  			$(if $(rustdoc_host),$(rust_common_flags),$(rust_flags))) \
> > -		$(rustc_target_flags) -L$(objtree)/$(obj) \
> > +		$(rustc_target_flags) -L$(objtree)/$(obj)$(if $(rustdoc_host),/host) \
> >  		-Zunstable-options --generate-link-to-definition \
> >  		--output $(rustdoc_output) \
> >  		--crate-name $(subst rustdoc-,,$@) \
> > @@ -193,13 +196,16 @@ rustdoc-proc_macro2: $(src)/proc-macro2/lib.rs rustdoc-clean FORCE
> >  	+$(call if_changed,rustdoc)
> >  
> >  rustdoc-quote: private rustdoc_host = yes
> > -rustdoc-quote: private rustc_target_flags = $(quote-flags)
> > +rustdoc-quote: private rustc_target_flags = $(quote-flags) \
> > +    --extern proc_macro2=$(abspath $(objtree)/$(obj)/host/libproc_macro2.rlib)
> 
> Why not just add `-L$(objtree)/$(obj)/host`? If we go with the host directory
> approach we shouldn't need to explicitly specify the path?
> 
> Best,
> Gary
> 
Yeah makes sense. Will send out new revision.

Regards,
Mukesh
> >  rustdoc-quote: private skip_flags = $(quote-skip_flags)
> >  rustdoc-quote: $(src)/quote/lib.rs rustdoc-clean rustdoc-proc_macro2 FORCE
> >  	+$(call if_changed,rustdoc)
> >  
> >  rustdoc-syn: private rustdoc_host = yes
> > -rustdoc-syn: private rustc_target_flags = $(syn-flags)
> > +rustdoc-syn: private rustc_target_flags = $(syn-flags) \
> > +    --extern proc_macro2=$(abspath $(objtree)/$(obj)/host/libproc_macro2.rlib) \
> > +    --extern quote=$(abspath $(objtree)/$(obj)/host/libquote.rlib)
> >  rustdoc-syn: $(src)/syn/lib.rs rustdoc-clean rustdoc-quote FORCE
> >  	+$(call if_changed,rustdoc)
> >  
> > @@ -236,7 +242,10 @@ rustdoc-pin_init_internal: $(src)/pin-init/internal/src/lib.rs \
> >  	+$(call if_changed,rustdoc)
> >  
> >  rustdoc-pin_init: private rustdoc_host = yes
> > -rustdoc-pin_init: private rustc_target_flags = $(pin_init-flags) \
> > +rustdoc-pin_init: private rustc_target_flags = \
> > +    --extern pin_init_internal=$(abspath $(objtree)/$(obj)/$(libpin_init_internal_name)) \
> > +    --extern macros=$(abspath $(objtree)/$(obj)/$(libmacros_name)) \
> > +    $(call cfgs-to-flags,$(pin_init-cfgs)) \
> >      --extern alloc --cfg feature=\"alloc\"
> >  rustdoc-pin_init: $(src)/pin-init/src/lib.rs rustdoc-pin_init_internal \
> >      rustdoc-macros FORCE
> > @@ -369,7 +378,9 @@ rusttest: rusttest-macros
> >  
> >  rusttest-macros: private rustc_target_flags = --extern proc_macro \
> >      --extern macros --extern kernel --extern pin_init \
> > -    --extern proc_macro2 --extern quote --extern syn
> > +    --extern proc_macro2=$(abspath $(objtree)/$(obj)/test/libproc_macro2.rlib) \
> > +    --extern quote=$(abspath $(objtree)/$(obj)/test/libquote.rlib) \
> > +    --extern syn=$(abspath $(objtree)/$(obj)/test/libsyn.rlib)
> >  rusttest-macros: private rustdoc_test_target_flags = --crate-type proc-macro
> >  rusttest-macros: $(src)/macros/lib.rs \
> >      rusttestlib-macros rusttestlib-kernel rusttestlib-pin_init FORCE
> > @@ -525,48 +536,54 @@ $(obj)/exports_kernel_generated.h: $(obj)/kernel.o FORCE
> >  
> >  quiet_cmd_rustc_procmacrolibrary = $(RUSTC_OR_CLIPPY_QUIET) PL $@
> >        cmd_rustc_procmacrolibrary = \
> > +	mkdir -p $(dir $@); \
> >  	$(if $(skip_clippy),$(RUSTC),$(RUSTC_OR_CLIPPY)) \
> >  		$(filter-out $(skip_flags),$(rust_common_flags) $(rustc_target_flags)) \
> >  		--emit=dep-info=$(depfile) --emit=link=$@ --crate-type rlib -O \
> > -		--out-dir $(objtree)/$(obj) -L$(objtree)/$(obj) \
> >  		--crate-name $(patsubst lib%.rlib,%,$(notdir $@)) $<
> >  
> > -$(obj)/libproc_macro2.rlib: private skip_clippy = 1
> > -$(obj)/libproc_macro2.rlib: private rustc_target_flags = $(proc_macro2-flags)
> > -$(obj)/libproc_macro2.rlib: $(src)/proc-macro2/lib.rs FORCE
> > +$(obj)/host/libproc_macro2.rlib: private skip_clippy = 1
> > +$(obj)/host/libproc_macro2.rlib: private rustc_target_flags = $(proc_macro2-flags)
> > +$(obj)/host/libproc_macro2.rlib: $(src)/proc-macro2/lib.rs FORCE
> >  	+$(call if_changed_dep,rustc_procmacrolibrary)
> >  
> > -$(obj)/libquote.rlib: private skip_clippy = 1
> > -$(obj)/libquote.rlib: private skip_flags = $(quote-skip_flags)
> > -$(obj)/libquote.rlib: private rustc_target_flags = $(quote-flags)
> > -$(obj)/libquote.rlib: $(src)/quote/lib.rs $(obj)/libproc_macro2.rlib FORCE
> > +$(obj)/host/libquote.rlib: private skip_clippy = 1
> > +$(obj)/host/libquote.rlib: private skip_flags = $(quote-skip_flags)
> > +$(obj)/host/libquote.rlib: private rustc_target_flags = $(quote-flags) \
> > +	--extern proc_macro2=$(abspath $(objtree)/$(obj)/host/libproc_macro2.rlib)
> > +$(obj)/host/libquote.rlib: $(src)/quote/lib.rs $(obj)/host/libproc_macro2.rlib FORCE
> >  	+$(call if_changed_dep,rustc_procmacrolibrary)
> >  
> > -$(obj)/libsyn.rlib: private skip_clippy = 1
> > -$(obj)/libsyn.rlib: private rustc_target_flags = $(syn-flags)
> > -$(obj)/libsyn.rlib: $(src)/syn/lib.rs $(obj)/libquote.rlib FORCE
> > +$(obj)/host/libsyn.rlib: private skip_clippy = 1
> > +$(obj)/host/libsyn.rlib: private rustc_target_flags = $(syn-flags) \
> > +	--extern proc_macro2=$(abspath $(objtree)/$(obj)/host/libproc_macro2.rlib) \
> > +	--extern quote=$(abspath $(objtree)/$(obj)/host/libquote.rlib)
> > +$(obj)/host/libsyn.rlib: $(src)/syn/lib.rs $(obj)/host/libquote.rlib FORCE
> >  	+$(call if_changed_dep,rustc_procmacrolibrary)
> >  
> >  quiet_cmd_rustc_procmacro = $(RUSTC_OR_CLIPPY_QUIET) P $@
> >        cmd_rustc_procmacro = \
> > -	$(RUSTC_OR_CLIPPY) $(rust_common_flags) $(rustc_target_flags) \
> > +	$(RUSTC_OR_CLIPPY) $(rust_common_flags) \
> >  		-Clinker-flavor=gcc -Clinker=$(HOSTCC) \
> >  		-Clink-args='$(call escsq,$(KBUILD_PROCMACROLDFLAGS))' \
> >  		--emit=dep-info=$(depfile) --emit=link=$@ --extern proc_macro \
> > -		--crate-type proc-macro -L$(objtree)/$(obj) \
> > +		--crate-type proc-macro \
> > +		-L$(objtree)/$(obj)/host \
> >  		--crate-name $(patsubst lib%.$(libmacros_extension),%,$(notdir $@)) \
> > -		@$(objtree)/include/generated/rustc_cfg $<
> > +		@$(objtree)/include/generated/rustc_cfg \
> > +		$(rustc_target_flags) \
> > +		$<
> >  
> >  # Procedural macros can only be used with the `rustc` that compiled it.
> >  $(obj)/$(libmacros_name): private rustc_target_flags = \
> >      --extern proc_macro2 --extern quote --extern syn
> > -$(obj)/$(libmacros_name): $(src)/macros/lib.rs $(obj)/libproc_macro2.rlib \
> > -    $(obj)/libquote.rlib $(obj)/libsyn.rlib FORCE
> > +$(obj)/$(libmacros_name): $(src)/macros/lib.rs $(obj)/host/libproc_macro2.rlib \
> > +    $(obj)/host/libquote.rlib $(obj)/host/libsyn.rlib FORCE
> >  	+$(call if_changed_dep,rustc_procmacro)
> >  
> >  $(obj)/$(libpin_init_internal_name): private rustc_target_flags = $(pin_init_internal-flags)
> >  $(obj)/$(libpin_init_internal_name): $(src)/pin-init/internal/src/lib.rs \
> > -    $(obj)/libproc_macro2.rlib $(obj)/libquote.rlib $(obj)/libsyn.rlib FORCE
> > +    $(obj)/host/libproc_macro2.rlib $(obj)/host/libquote.rlib $(obj)/host/libsyn.rlib FORCE
> >  	+$(call if_changed_dep,rustc_procmacro)
> >  
> >  # `rustc` requires `-Zunstable-options` to use custom target specifications
> 

