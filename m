Return-Path: <linuxppc-dev+bounces-18839-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id CFDAD10AB82A
	for <linuxppc-dev@archiver.kernel.org>; Thu, 26 Mar 2026 22:17:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fhdRv73Wkz2yY0;
	Fri, 27 Mar 2026 09:17:15 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774563435;
	cv=none; b=YqhIRu2ZoWFDiC+P7oQPGOukXiuUoyJ57dztAZdII1ZTFc2PxRDiB+OhR4WZrvpf5wXZZT3D0meSASdRCVSGh9nvhjwbVTWJ/N5SYZJhos7wX10cwZh+fxJEDDtuGWE4v9Abk1FtmKaa9Y25sLQyySentwER/mfnb9SwQhdsi4PTdci8U0OfMzRWQ+G/y1DMK8zdtu0oKWPKNZJApaDzMZsKFrvreJG1SJ6Ue256kFZrzq5vj5A73srH6OKZLNiJF0II2aXtURCGvVRXoVQfOuStBLuVDZzBReAQYHLQQDHZKmsZMRCy1xrmYOyjWzPCVTtK/o67QbcIn0fd6amaKw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774563435; c=relaxed/relaxed;
	bh=glFjKxjAo1VGzHup/HsXziAyDLKn89fs6Fyq68wQjAU=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=czf4GR+A09JSNZ9ENzUKtEFPjcIxRsGFkbedojuR7CWXMOwjGp0pg4wFAjflS7hCE1X9iibpKiOf+9TyN7HWXKo/pZbmVIEdTo4VF9nNmI1EI5zE+Me0I5U323W2T2HDtw11UXR6/FbOCP75g6uZ39ec2nHm2idoVZ//ukVbP5aiNBGzL1NrsYcp4NI0IjosNu422SHsqrmVq8cTtKRBPKhQtxqiSIZ0qgcn4M+cbJgdCqG6UBsOWgRXRSeUnGPi5mfuszrKlDkH5hJrn3TiXQRQyFqQYtTXpHPZPlnfUip9vUVuZzSncXB3VhKQev7Srt6/5Yr2fpojOOFyp7guzA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U3Ik8hLX; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=U3Ik8hLX;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102b; helo=mail-pj1-x102b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fhdRt3Wc4z2yLG
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 Mar 2026 09:17:13 +1100 (AEDT)
Received: by mail-pj1-x102b.google.com with SMTP id 98e67ed59e1d1-35c0e7b751aso1450756a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2026 15:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774563431; x=1775168231; darn=lists.ozlabs.org;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=glFjKxjAo1VGzHup/HsXziAyDLKn89fs6Fyq68wQjAU=;
        b=U3Ik8hLXqtEaqZK9OG9dUsz6IKV2Xdt/QXdh4EA/XBghCkV3s1erUbtXuvOGdTIRl7
         w6wBTlORV/beAQ8Cs5a94Z7RwQkiNzAP3oWBl/9g4L4YIz2M75sNV66bR6Le1nFDwVNJ
         GZavmC78QyvYoniRrLrGgR/4klo2GO98d9sp8TzkNC3PLQVFiXn29cfzfCHU78aZ2w9t
         8r4n7Cc6nBElm/XEUpUUxRb0Og8fje5EqPFQs4hQE91gqX76ejaUkIQF2VEYbETsHJKZ
         1QQjCTdvIShSP7AeKyk8hoZAPbmtgq5qbmIOuJETlsjHLKNyUtEm1xtEEFgK+z4TeJ6B
         UWFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774563431; x=1775168231;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=glFjKxjAo1VGzHup/HsXziAyDLKn89fs6Fyq68wQjAU=;
        b=JNA2s9Dgo3A/Tggf8LrhjfNG10UjhhqHIvBASfbXLURHsl8TLoo+tVJXmS1GBcmA2V
         3mxJyPnIwusBhe5mAOT54pkrAEg4T+40xeaREv3+WRq7shLuPbSvSZp4oaSQT59Kumc8
         NMueA9pULyBP+8GkMmyM8WLU439KD8JWkamp47NytfuCGj/vRUCj0pSA1hJ4JVT0dLvU
         qa9VLE9ED/Qm2sL6HkgEwiP6/WE1kevzp7QPpdSUD3ga9vrQc0hkzKh4kis1GZDB9qq8
         cfHexOo6sHlDGm+v1Z6J+E9SC4RIjHOd+KS0OBvFyf+ceWc/vWF9s8dvmcfTnM3i+Bmw
         HTyg==
X-Forwarded-Encrypted: i=1; AJvYcCU36TzsCp8k2t19Fah0FoSRO2MFUQ+JFnkHWgm7Ece/dcGldb5SREnhoI+HQaJfkj377oJyxJgKIZPvYiE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyXkyQVbhrsAZFuiVsHuP5sjsK3K+ZBCFdDqh6E01cMqC8QBkYI
	VWTgAvjLgvXp1gOgTd2v1W6fAoIJgx+WmwPZXPFz47PTFdDYCdCQ32bS
X-Gm-Gg: ATEYQzyjxLnMxYzhiC3zK7ZWUzLQBxwmQ7W/BIlEDycrLxd5oX4Td5fyPNi8Tut7u7v
	clp/Kuf+yWU6YthKl+k963wxFTPi/AyI+ZugL9ocYCyRFj2UfNYMAs4syReha8YQv/9jzYeT9cO
	0BvKpuSujpW4v6hqDD8lUrDWibeGBHMVUE4BmcTQdv/GCaEH4i/S0FkaKw6SPjsdEyttL3NEl/D
	ZhEBpMfk74FYny+3CWCzUp3v8VhbHffQLLoj75DDe/SPXho6NXlihkFn2TrhKh6+6EEMSznKv1y
	o9mherOzH8sbvHcRON/HACGHCIvT6siNym/54F0KE3YhHto4WxZat+Kk8zXi3y8mVSoERAcbofX
	sTGC/XuMIPHmnIUAnpy4pr60Ot8Zd1RvqmA/hUMVx9rgBZA7MrL/NANJacDwAUnQIcjwGUQOYxW
	m3h5IfqZxwcN4pIQFsWeis5DP3JNr9+2iO1B8AkP/rphJG3Ip791ouPLNAiS2Nrl0cKXzQfQ==
X-Received: by 2002:a17:90b:5383:b0:35b:e4d5:dc6f with SMTP id 98e67ed59e1d1-35c2fff1691mr193223a91.10.1774563430637;
        Thu, 26 Mar 2026 15:17:10 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com ([106.51.160.14])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35c2d8d47c6sm199900a91.1.2026.03.26.15.17.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Mar 2026 15:17:09 -0700 (PDT)
Date: Fri, 27 Mar 2026 03:46:58 +0530
From: Mukesh Kumar Chaurasiya <mkchauras@gmail.com>
To: Madhavan Srinivasan <maddy@linux.ibm.com>, ojeda@kernel.org, 
	aliceryhl@google.com
Cc: linkmauve@linkmauve.fr, ojeda@kernel.org, boqun.feng@gmail.com, 
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org, 
	a.hindborg@kernel.org, aliceryhl@google.com, tmgross@umich.edu, dakr@kernel.org, 
	corbet@lwn.net, mpe@ellerman.id.au, npiggin@gmail.com, chleroy@kernel.org, 
	peterz@infradead.org, jpoimboe@kernel.org, jbaron@akamai.com, rostedt@goodmis.org, 
	ardb@kernel.org, rust-for-linux@vger.kernel.org, linux-doc@vger.kernel.org, 
	linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V6 0/3] Rust support for powerpc
Message-ID: <acWugN2jUVK0e314@li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com>
References: <20260210090023.2587534-1-mkchauras@gmail.com>
 <51269463-8538-4149-a3f3-156a5c4d49b4@linux.ibm.com>
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
In-Reply-To: <51269463-8538-4149-a3f3-156a5c4d49b4@linux.ibm.com>

On Wed, Mar 25, 2026 at 01:59:55PM +0530, Madhavan Srinivasan wrote:
> 
> On 2/10/26 2:30 PM, Mukesh Kumar Chaurasiya (IBM) wrote:
> > Enable experimental rust support for ppc64le and ppc32be. The patch for
> > ppc32 has been provided by Link Mauve[1] and ppc64le support[2] has been
> > merged over it. ppc32 needs some toolchain fixes mentioned in the patch
> > `rust: Add PowerPC support` and the discussion for that is done here[1].
> > 
> > This has been tested on powernv9 hardware and power10 pseries qemu. I
> > I request Link to test the ppc32 part as i don't have a hardware to test
> > it out.
> > 
> > [1] https://lore.kernel.org/all/20260204030507.8203-1-linkmauve@linkmauve.fr
> > [2] https://lore.kernel.org/all/20260204042417.83903-1-mkchauras@gmail.com
> 
> Could see these build issues with the Rust patchset in the compilation of
> powerpc-next-test
> This happens when compilation happens only with few threads
> 
> # rustc --version
> rustc 1.94.0 (4a4ef493e 2026-03-02)
> 
> ....
>   EXPORTS rust/exports_core_generated.h
>   BINDGEN rust/bindings/bindings_generated.rs
>   BINDGEN rust/bindings/bindings_helpers_generated.rs
>   CC      rust/helpers/helpers.o
>   EXPORTS rust/exports_helpers_generated.h
>   RUSTC L rust/compiler_builtins.o
>   RUSTC L rust/ffi.o
>   RUSTC PL rust/libproc_macro2.rlib
> error[E0464]: multiple candidates for `rmeta` dependency `core` found
>  --> rust/proc-macro2/marker.rs:4:5
>   |
> 4 | use core::marker::PhantomData;
>   |     ^^^^
>   |
>   = note: candidate #1: /root/.rustup/toolchains/nightly-powerpc64le-unknown-linux-gnu/lib/rustlib/powerpc64le-unknown-linux-gnu/lib/libcore-951759db375eea0c.rmeta
>   = note: candidate #2: ./rust/libcore.rmeta
> 
> error[E0119]: conflicting implementations of trait `PartialEq` for type
> `fallback::Ident`
>    --> rust/proc-macro2/fallback.rs:875:1
>     |
> 869 |   impl PartialEq for Ident {
>     |   ------------------------ first implementation here
> ...
> 875 | / impl<T> PartialEq<T> for Ident
> 876 | | where
> 877 | |     T: ?Sized + AsRef<str>,
>     | |___________________________^ conflicting implementation for
> `fallback::Ident`
> 
> error[E0277]: `LexError` doesn't implement `std::fmt::Display`
>    --> rust/proc-macro2/lib.rs:347:16
>     |
> 347 | impl Error for LexError {}
>     |                ^^^^^^^^ unsatisfied trait bound
>     |
> help: the trait `std::fmt::Display` is not implemented for `LexError`
>    --> rust/proc-macro2/lib.rs:204:1
>     |
> 204 | pub struct LexError {
>     | ^^^^^^^^^^^^^^^^^^^
> note: required by a bound in `std::error::Error`
>    --> /root/.rustup/toolchains/nightly-powerpc64le-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/error.rs:59:26
>     |
>  59 | pub trait Error: Debug + Display {
>     |                          ^^^^^^^ required by this bound in `Error`
> 
> error[E0277]: `LexError` doesn't implement `Debug`
>    --> rust/proc-macro2/lib.rs:347:16
>     |
> 347 | impl Error for LexError {}
>     |                ^^^^^^^^ unsatisfied trait bound
>     |
> help: the trait `Debug` is not implemented for `LexError`
>    --> rust/proc-macro2/lib.rs:204:1
>     |
> 204 | pub struct LexError {
>     | ^^^^^^^^^^^^^^^^^^^
>     = note: add `#[derive(Debug)]` to `LexError` or manually `impl Debug for
> LexError`
> note: required by a bound in `std::error::Error`
>    --> /root/.rustup/toolchains/nightly-powerpc64le-unknown-linux-gnu/lib/rustlib/src/rust/library/core/src/error.rs:59:18
>     |
>  59 | pub trait Error: Debug + Display {
>     |                  ^^^^^ required by this bound in `Error`
> 
> error: aborting due to 4 previous errors
> 
> ......
> But when parallelized with more threads (-j 128) compilation passes with out
> any error
> There is some ordering of libcore is messing up I guess (I could be wrong)
> (I have removed the warning of unstable features messages here for cleaner
> output)
> 
> ....
>   VDSO64SYM include/generated/vdso64-offsets.h
>   RUSTC L rust/core.o
>   BINDGEN rust/bindings/bindings_generated.rs
>   BINDGEN rust/bindings/bindings_helpers_generated.rs
>   CC      rust/helpers/helpers.o
>   RUSTC PL rust/libproc_macro2.rlib
>   BINDGEN rust/uapi/uapi_generated.rs
>   RSCPP     rust/kernel/generated_arch_static_branch_asm.rs
>   RSCPP     rust/kernel/generated_arch_warn_asm.rs
>   RSCPP     rust/kernel/generated_arch_reachable_asm.rs
> clang diag: ./arch/powerpc/include/uapi/asm/ioctl.h:5:9: warning:
> '_IOC_SIZEBITS' macro redefined [-Wmacro-redefined]
> clang diag: ./arch/powerpc/include/uapi/asm/ioctl.h:6:9: warning:
> '_IOC_DIRBITS' macro redefined [-Wmacro-redefined]
> clang diag: ./arch/powerpc/include/uapi/asm/ioctl.h:8:9: warning:
> '_IOC_NONE' macro redefined [-Wmacro-redefined]
> clang diag: ./arch/powerpc/include/uapi/asm/ioctl.h:10:9: warning:
> '_IOC_WRITE' macro redefined [-Wmacro-redefined]
>   EXPORTS rust/exports_helpers_generated.h
>   RUSTC PL rust/libquote.rlib
>   RUSTC PL rust/libsyn.rlib
>   RUSTC P rust/libpin_init_internal.so
>   RUSTC P rust/libmacros.so
>   EXPORTS rust/exports_core_generated.h
>   RUSTC L rust/compiler_builtins.o
>   RUSTC L rust/ffi.o
>   RUSTC L rust/pin_init.o
>   RUSTC L rust/build_error.o
>   RUSTC L rust/bindings.o
>   RUSTC L rust/uapi.o
>   EXPORTS rust/exports_bindings_generated.h
>   RUSTC L rust/kernel.o
>   EXPORTS rust/exports_kernel_generated.h
>   LDS     scripts/module.lds
>   HOSTCC  usr/gen_init_cpio
>   CC      init/main.o
> ....
> 
> Also I see some errors when compiling modules. I am looking at these and any
> help is welcome.
> I will pull out Rust patches for now from powerpc-linux next-test branch and
> once this is
> restored I will add these patches back to branch for the merge.
> 
> Maddy
> 
Aah this happens because core.o is compiled before libproc_macro2.rlib
starts compiling. Once the core.o is compiled it generates the
libcore.rmeta, leading to conflict in two libcore.rmeta available.

I can think of 2 solutions here for this,

1. We can make the libproc_macro2.rlib libquote.rlib libsyn.rlib compile
befor the core.o is compiled OR
2. We can force these to use the toolchain core's metadata and not look
into the kernel's rust directory.

I am still not able to figure out why this is not happening for x86.

What should we do in this case?

Regards,
Mukesh

> > Changelog:
> > V5 -> V6:
> > - Added a missing Tested by from Venkat which got missed since V3
> > - Support is marked as Maintained instead of experimental
> > V5: https://lore.kernel.org/all/20260210053756.2088302-1-mkchauras@gmail.com
> > 
> > V4 -> V5:
> > - Removed a nested ifdef from PPC64 for Little endian toolchain
> > V4: https://lore.kernel.org/all/20260209105456.1551677-1-mkchauras@gmail.com
> > 
> > V3 -> V4:
> > - Co-developed-by header added in patch 1
> > V3: https://lore.kernel.org/all/20260205180429.3280657-1-mkchauras@gmail.com
> > 
> > V2 -> V3:
> > - Splited HAVE_RUST in 2 lines
> > - BINDGEN_TARGET_powerpc initialized before assigning the same to
> >    BINDGEN_TARGET
> > V2: https://lore.kernel.org/all/20260204210125.613350-1-mkchauras@gmail.com
> > 
> > V1 -> V2:
> > - jump label fix for rust has been moved to a separate patch
> > - PPC32 support has been taken
> > - rust support has been marked experimental
> > - target.json dependency has been removed
> > - HAVE_RUST now depends on CPU_LITTLE_ENDIAN for PPC64
> > 
> > 
> > Link Mauve (1):
> >    rust: Add PowerPC support
> > 
> > Mukesh Kumar Chaurasiya (IBM) (2):
> >    powerpc/jump_label: adjust inline asm to be consistent
> >    powerpc: Enable Rust for ppc64le
> > 
> >   Documentation/rust/arch-support.rst   |  1 +
> >   arch/powerpc/Kconfig                  |  2 ++
> >   arch/powerpc/Makefile                 |  7 +++++++
> >   arch/powerpc/include/asm/jump_label.h | 23 +++++++++++++----------
> >   rust/Makefile                         | 10 +++++++++-
> >   5 files changed, 32 insertions(+), 11 deletions(-)
> > 

