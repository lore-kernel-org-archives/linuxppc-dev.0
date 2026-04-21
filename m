Return-Path: <linuxppc-dev+bounces-19875-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B16D4F327D0
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 09:55:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0HmC16GVz2ytx;
	Tue, 21 Apr 2026 19:55:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776765339;
	cv=none; b=jLd6Mjt2OVoXrIj1l/mLKAzi2SrnBxmbw2PYeSNLwwPQq0NgOkhTwdGsFmAryKMkXJMZV4ck7pe/MGBbnOhcgEtvXPoS4dFGbZz443RViTAjTF5aWuZIhOl0FhvGG868l6BTQ0qhPKO4x+FmqeUuE+eumlnWitrtlWkA1ILNBuXVDrC3/WVnPfIb0DsSLi8pMk1yZ+kwHEcsEi1s8bePgPWqbmHb/fJdqskC+ENjQJ3aBGXN9dK2Mf42I6UImGekWHk2eBXmF5eLboAAnFGX89NCPdAdWGn3xaGr5TcTq4ZkYgBiI+JtW0EDqvVSNCWSnAYge5Cqr+zo01OPe60rZA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776765339; c=relaxed/relaxed;
	bh=91kn5n9C2wXrcDyzWkVlinW43jw3yYJYj+1FYPmqgkc=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=Sn4NJKot6lf+KHC2dReyDCaFo1I0GpCx1JT3Guq6k7DPrXvDqS5m+QplZNowiV2oVNkGPkrB0Srst65XQcv1GVb3n18pEYUTIVYEYVb8+cVYKm7kaq0cAByNqZ9kMUp2Dh21LNIJ/IYeQcqFivl9kkVKBUyp5sVHGEP5GFlTz9PvPnyvb22xChfhmzgnnitfwLDpYgb1G9+GbPOAvtNM9IJfUKXm/sf7Ss/FwizII4V+0PHLLBeBXTETNz97jNAJUo1//6MgDyomJeVvfWmfQJeYLBp38F49sEhYq392/uDFGt3I3rGHiEpdnXll58yRxYIymFsQVj2JZUm5xMIq6Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l6FEbBrY; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=l6FEbBrY;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42d; helo=mail-pf1-x42d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42d.google.com (mail-pf1-x42d.google.com [IPv6:2607:f8b0:4864:20::42d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0Hm93GV9z2xd6
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 19:55:36 +1000 (AEST)
Received: by mail-pf1-x42d.google.com with SMTP id d2e1a72fcca58-82f9fdfc965so1339297b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 02:55:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776765333; x=1777370133; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=91kn5n9C2wXrcDyzWkVlinW43jw3yYJYj+1FYPmqgkc=;
        b=l6FEbBrYZoV8J6qahel3JJYaVGOkjJEJpbDJBL7UDNVDOgDO6q497PBBXcDzLhDzOH
         swfdtFk/IdSDn9pMKookkQ2wAlm95R6X6dNSU2T9ZSomPLDAeNEpOXOEGw+4lrWk3g+0
         rZLI+BJPv/uquBHoJaJYvGaiZWvenstG9arCXueFhUVV/Kn0itMxJOWW9YeiQKnbWkaN
         g30JA85DOzNvAgz64Oq8PUhwOdI9/vq58/VOaMVgBTBYwXCsIJAENPTAYesQwjodyS6L
         mZqyHLt6ZtLPnt57BZLpl6X/SA9qAb00TcQmh6+c6BHMQt0FPFHjmdPASqo2wCUImRTe
         eIpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776765333; x=1777370133;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=91kn5n9C2wXrcDyzWkVlinW43jw3yYJYj+1FYPmqgkc=;
        b=Te8m543879cr9DIxvqd8vL6JU18qox4wJmWORmjq0vCVzSqXa9XEqBjVEF7FGHyKvM
         9MVwPGvtEpgDJpWKELYXqb9b7+AewpKPw17Cx2DdsHEKS6VcEwylLNQltoolNWDQ8DtE
         8XAWINSm5bvlGoxfZbR/3WvvPFqjA3T85XmVKNyCoTeiGXBAg7AxR1rqyEggTQc9S3K3
         uHJSvrWITCZeIrEfYXn7VyvxtjzSnb4/OKIMm0FgeOMrUgYjIa4bqJmObvizdzHsgtXR
         qRFKUlW8yXV6oZhZQOC/90I8ryAnBNUgWNAuWKSResKGEBPiW9Zb2a6hMAWpavx9qZ5a
         Vxhw==
X-Forwarded-Encrypted: i=1; AFNElJ9j4IdaSJQzVvOF4O2FIJqvVgXHodXpIJKlbd7x84YXVK9z4Nq96m2XX6Wi6weeKWGLliLJCOQZOGj4cFM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwmKWLdpsgR1kQgtSBZeOnt8CbZfp8xg+rnSgk7zc9e1OA3ERul
	OhPHacOMlR/xCBE1JAL0hiD/6pbzckFV+kb11DuDJGer5uzAb8Xte1NJ
X-Gm-Gg: AeBDieulXdaruvMHBvfSdox3GziH8eyDNsCdXcBhz6oZx/hPSfAznehqfEXEPeOBn0Q
	sGtdJdrFCey0G9LaOSQ5CPvNVgdyekSVJqN6gKJ4apGHPOdvl+Hs6aJ6hnAyyEsul50S7dyo1i7
	DoGTCMHhwBD80Yx+E/JnB2lSAJP8D+/g8QU44AzkgIMVVUWm4OFdAV/TWIbW4802R8yS3NkFgYA
	2J/JwW1/R0iyx80sjmLAmbNzT6lR4wXimfMoBrUs+9suGLCjIXcogeZTFFTTafYg5b4as3BQbZe
	uQOR1mD5/z1mnQ0BlVumjvqeNfvH2FMtEITNcmW1qxoIZVFIh1/rHSGSaSqUBjPL8bE46ZdhVEO
	zPYJiQkjK9bGZm1NAe0fUQDWMrWIh+g8R/FGTWPjaeWBIutN1dnkRXwD+XfxHlbGx9dZNCKf0Fv
	EN5fasOjP+nooHEmFr0w4Z67rjxdvLrcZntfkSjDONnjAcndb2L/9kN7Sy2ZqgcboDd5KB+GmGQ
	v98jx2nT69AgF5t
X-Received: by 2002:a05:6a00:2288:b0:82c:e76b:c68c with SMTP id d2e1a72fcca58-82f8c3f2b00mr17779962b3a.0.1776765332666;
        Tue, 21 Apr 2026 02:55:32 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ea09914sm13092315b3a.26.2026.04.21.02.55.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 02:55:32 -0700 (PDT)
Date: Tue, 21 Apr 2026 15:25:22 +0530
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
Message-ID: <aedJGuF9P2V1lOCZ@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260417152253.2312961-1-mkchauras@gmail.com>
 <20260417152253.2312961-2-mkchauras@gmail.com>
 <aedFgEicDW6LAcuq@luna>
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
In-Reply-To: <aedFgEicDW6LAcuq@luna>

On Tue, Apr 21, 2026 at 11:38:08AM +0200, Link Mauve wrote:
> Hi Mukesh,
> 
> This patch doesn’t apply on top of mainline, which tree did you base it
> off?
> 
It was on mainline v7.0 tag.
On latest there is a confilict. I'll send out a rebased version.

> On Fri, Apr 17, 2026 at 08:52:50PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> > When building Rust code for powerpc64le with LLVM=1 and -j1, rustc
> > encounters an error: "multiple candidates for `rmeta` dependency `core`
> > found", with two candidates:
> > 1. The host's standard library from the rustup toolchain
> > 2. The kernel's custom libcore.rmeta in the rust/ directory
> > 
> > This occurs because the build system uses `-L$(objtree)/rust` for host
> > library builds (proc_macro2, quote, syn), which causes rustc to search
> > the rust/ directory. During this search, rustc finds both the kernel's
> > custom libcore.rmeta and gains access to the host's standard library,
> > creating a conflict.
> > 
> > The solution is to separate host libraries into a dedicated rust/host/
> > subdirectory and use `-L$(objtree)/rust/host` for host builds instead
> > of `-L$(objtree)/rust`. This ensures that:
> > 
> > 1. Host library builds (proc_macro2, quote, syn) only search rust/host/
> >    and never encounter the kernel's libcore.rmeta
> > 2. Proc macro builds use `-L$(objtree)/rust/host` to find their
> >    dependencies
> > 
> > Special handling is added for rustdoc-pin_init, which is a host build
> > (to access the alloc crate) but depends on proc macros from the main
> > rust/ directory. It uses explicit `--extern` paths to reference the
> > proc macros without adding `-L$(objtree)/rust`, which would reintroduce
> > the conflict.
> > 
> > The rust/host/ directory is added to clean-files to ensure it's removed
> > during `make clean`.
> > 
> > Link: https://github.com/Rust-for-Linux/linux/issues/105
> > Link: https://github.com/linuxppc/issues/issues/451
> > Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> > ---
> >  rust/Makefile | 38 +++++++++++++++++++++-----------------
> >  1 file changed, 21 insertions(+), 17 deletions(-)
> > 
> > diff --git a/rust/Makefile b/rust/Makefile
> > index 9801af2e1e02..e234b8a39358 100644
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
> 
> The issue is here ↑, --remap-path-prefix=% got removed and the two
> previous lines got merged into one.
> 
Yeah will fix this.
> > -		$(rustc_target_flags) -L$(objtree)/$(obj) \
> > +		$(rustc_target_flags) -L$(objtree)/$(obj)$(if $(rustdoc_host),/host) \
> >  		-Zunstable-options --generate-link-to-definition \
> >  		--output $(rustdoc_output) \
> >  		--crate-name $(subst rustdoc-,,$@) \
> […]
> 
> Thanks anyway for iterating on this series!  I’ve started writing a DRM
> driver based off a previous version. :)
> 
That's cool. Thanks.

Regards,
Mukesh
> -- 
> Link Mauve
> 

