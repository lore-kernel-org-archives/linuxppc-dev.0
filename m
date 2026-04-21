Return-Path: <linuxppc-dev+bounces-19874-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5C981F327CD
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 09:38:20 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0HNB506Tz2ytx;
	Tue, 21 Apr 2026 19:38:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip=82.65.109.163
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776764298;
	cv=none; b=LLt3OiJ34CE0lN6rFZd4e9uCt95fldkXXJa7yc6i/NorM5M7t+Y4Qqr28n5B7cdPcfFwLsqKWIB9CLc1kRG8uaFmsDTRiLH6Jqi2bY2Q3sSpu0uqnegVHip7sDps7fVDvez5efPn48qHtlaVJaW3aZQsmWQckG6XjmB2RyLI38S1eI3Lx5j8h7JUBvMjuUi7HD731WcAPpBEcZ9bZjBvkMQZCEzsTiBHEzUQwmlyaC3LS7b7t6yoUfkgsSKT3j4g83AqGX7J6vNDKMJu4OMSEj6Z5YjDAJNTxk7qXk5qqSyUN+eSP7Wl0uIOxxu7/ab46QngIwZXeDC3KHb88axYuw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776764298; c=relaxed/relaxed;
	bh=hDroTMjglCpi13BA/D1fjt+h+/a1WAzk3r/B7ObFTTY=;
	h=Date:From:To:Cc:Subject:Message-ID:References:MIME-Version:
	 Content-Type:Content-Disposition:In-Reply-To; b=QIgVggXBo8LgbR5pKPJb42yeiwpe/xQWxEQwQ0f+X48UEW+agM1u2XWV0YWAfeXKGIloVDYW9pOhzOzrAxRv+0N0DoG7iG7RzlD5MCV8yJnhd/2/vned0p3JxugwjCWlzdCOgZOb/j5dJlMtj0VZ26QUdXVLB/al9lzP9z+esUPyztOTMjkrUKY5NQN+DtnjslNoKZ6R1oHgVItDdvfBFYjS8SMzjnWC2ZhS0HsbDiMgvVGfjIymz0ju4sWrrzDcURYwkgkBGnDU7Z6dqlJml3/pM9FE/YdsqvEIDmn51fnK7ul2OB3axFdFKVNY7BpLHupu5sXKcTfQYnchBlNCPA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr; spf=pass (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org) smtp.mailfrom=linkmauve.fr
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none) header.from=linkmauve.fr
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=linkmauve.fr (client-ip=82.65.109.163; helo=luna.linkmauve.fr; envelope-from=linkmauve@linkmauve.fr; receiver=lists.ozlabs.org)
Received: from luna.linkmauve.fr (82-65-109-163.subs.proxad.net [82.65.109.163])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0HN93t26z2yfS
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 19:38:16 +1000 (AEST)
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
	id 608E7F40843; Tue, 21 Apr 2026 11:38:09 +0200 (CEST)
Date: Tue, 21 Apr 2026 11:38:08 +0200
From: Link Mauve <linkmauve@linkmauve.fr>
To: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Cc: maddy@linux.ibm.com, mpe@ellerman.id.au, npiggin@gmail.com,
	chleroy@kernel.org, peterz@infradead.org, jpoimboe@kernel.org,
	jbaron@akamai.com, aliceryhl@google.com, rostedt@goodmis.org,
	ardb@kernel.org, ojeda@kernel.org, boqun@kernel.org,
	gary@garyguo.net, bjorn3_gh@protonmail.com, lossin@kernel.org,
	a.hindborg@kernel.org, tmgross@umich.edu, dakr@kernel.org,
	nathan@kernel.org, nick.desaulniers+lkml@gmail.com,
	morbo@google.com, justinstitt@google.com,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org, llvm@lists.linux.dev
Subject: Re: [PATCH V11 1/4] rust: Fix "multiple candidates for rmeta
 dependency core" error
Message-ID: <aedFgEicDW6LAcuq@luna>
References: <20260417152253.2312961-1-mkchauras@gmail.com>
 <20260417152253.2312961-2-mkchauras@gmail.com>
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
In-Reply-To: <20260417152253.2312961-2-mkchauras@gmail.com>
Jabber-ID: linkmauve@linkmauve.fr

Hi Mukesh,

This patch doesn’t apply on top of mainline, which tree did you base it
off?

On Fri, Apr 17, 2026 at 08:52:50PM +0530, Mukesh Kumar Chaurasiya (IBM) wrote:
> When building Rust code for powerpc64le with LLVM=1 and -j1, rustc
> encounters an error: "multiple candidates for `rmeta` dependency `core`
> found", with two candidates:
> 1. The host's standard library from the rustup toolchain
> 2. The kernel's custom libcore.rmeta in the rust/ directory
> 
> This occurs because the build system uses `-L$(objtree)/rust` for host
> library builds (proc_macro2, quote, syn), which causes rustc to search
> the rust/ directory. During this search, rustc finds both the kernel's
> custom libcore.rmeta and gains access to the host's standard library,
> creating a conflict.
> 
> The solution is to separate host libraries into a dedicated rust/host/
> subdirectory and use `-L$(objtree)/rust/host` for host builds instead
> of `-L$(objtree)/rust`. This ensures that:
> 
> 1. Host library builds (proc_macro2, quote, syn) only search rust/host/
>    and never encounter the kernel's libcore.rmeta
> 2. Proc macro builds use `-L$(objtree)/rust/host` to find their
>    dependencies
> 
> Special handling is added for rustdoc-pin_init, which is a host build
> (to access the alloc crate) but depends on proc macros from the main
> rust/ directory. It uses explicit `--extern` paths to reference the
> proc macros without adding `-L$(objtree)/rust`, which would reintroduce
> the conflict.
> 
> The rust/host/ directory is added to clean-files to ensure it's removed
> during `make clean`.
> 
> Link: https://github.com/Rust-for-Linux/linux/issues/105
> Link: https://github.com/linuxppc/issues/issues/451
> Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
> ---
>  rust/Makefile | 38 +++++++++++++++++++++-----------------
>  1 file changed, 21 insertions(+), 17 deletions(-)
> 
> diff --git a/rust/Makefile b/rust/Makefile
> index 9801af2e1e02..e234b8a39358 100644
> --- a/rust/Makefile
> +++ b/rust/Makefile
> @@ -3,6 +3,9 @@
>  # Where to place rustdoc generated documentation
>  rustdoc_output := $(objtree)/Documentation/output/rust/rustdoc
>  
> +# Clean generated host directory
> +clean-files := host/
> +
>  obj-$(CONFIG_RUST) += core.o compiler_builtins.o ffi.o
>  always-$(CONFIG_RUST) += exports_core_generated.h
>  
> @@ -27,7 +30,7 @@ endif
>  
>  obj-$(CONFIG_RUST) += exports.o
>  
> -always-$(CONFIG_RUST) += libproc_macro2.rlib libquote.rlib libsyn.rlib
> +always-$(CONFIG_RUST) += host/libproc_macro2.rlib host/libquote.rlib host/libsyn.rlib
>  
>  always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated.rs
>  always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.c
> @@ -150,7 +153,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
>  	OBJTREE=$(abspath $(objtree)) \
>  	$(RUSTDOC) $(filter-out $(skip_flags) --remap-path-prefix=% --remap-path-scope=%, \
>  			$(if $(rustdoc_host),$(rust_common_flags),$(rust_flags))) \

The issue is here ↑, --remap-path-prefix=% got removed and the two
previous lines got merged into one.

> -		$(rustc_target_flags) -L$(objtree)/$(obj) \
> +		$(rustc_target_flags) -L$(objtree)/$(obj)$(if $(rustdoc_host),/host) \
>  		-Zunstable-options --generate-link-to-definition \
>  		--output $(rustdoc_output) \
>  		--crate-name $(subst rustdoc-,,$@) \
[…]

Thanks anyway for iterating on this series!  I’ve started writing a DRM
driver based off a previous version. :)

-- 
Link Mauve

