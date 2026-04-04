Return-Path: <linuxppc-dev+bounces-19310-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1CC18E88D80
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 12:16:40 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnvhj3rDLz2yng;
	Sat, 04 Apr 2026 23:16:37 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1031"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775304997;
	cv=none; b=iscP4xVHDi+7gSTdp3fmbTy3FBLd4hCN45TqWH61mDRFVX+zw5bD7cVdeb1hec5x5lHQ0Gx46XFmt3zaB5+tlSdMr82TyICcdCUM1O0J63VaJLjkVZmmHXXDhLCwhMapWcr6oib+ZvZSGLDqNG7+1XVHrw5PMgMwE6tLOjRnmhJJqOi9vz+mOhwPUYV3QoAPjmAQCCl3Voijc7NzthlryM/GhLbEKcQtv6aDYOts1+R0yVzJngXdG4VgeYyFREO3zZizRny57QREcwptMgw0HdK8OJ4kyVYdKLKPP2e80VldT/ar8whF43IxL8/8KdfclHS1xhHc9RKsBm0ve5fzEQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775304997; c=relaxed/relaxed;
	bh=QRC8yozcX9QSmNG0yIA7nVyNQgWhlHJbCL9t4pSEkxw=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=GWF996krskHI7oE3FwwonvqilADAJeUEb7mKlh9sMhQS0qbve5jhcCZMl1X5CcreaDfSYtOwemmfZwQPoysx+2OELbm4fk886hWoQqEKivSPSP+ZIdDfHLulLm/4tBF5hlahixSumV3lTYY4n/pzjRYo+thBeLDq3X+AEi0dXgNMebSDKkeFxo5lCZef1T/BhIZDByoBS24haU8xmf96tkRMcMDk0uBklsa2YLxOkqLWnI1tzSmP913wxxEhgnf29Dk2jcFeCv05JZ3WHwTWa6V0GcCxxXzbuTQEdrpgzuXW8uXHHifWTC+vvyum+bTYxJfyb7heYsXwv3gRLS9fFg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mYKJtM60; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=mYKJtM60;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1031; helo=mail-pj1-x1031.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnvhh4jsxz2yC9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 23:16:36 +1100 (AEDT)
Received: by mail-pj1-x1031.google.com with SMTP id 98e67ed59e1d1-35da2d35eccso1680176a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 05:16:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775304994; x=1775909794; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QRC8yozcX9QSmNG0yIA7nVyNQgWhlHJbCL9t4pSEkxw=;
        b=mYKJtM60cUXo2SPrnRFv+xbsqj5CteLx/o9XV7uJKbHtZ5OVuW2A442zxKQUO31Eyf
         vWuXQqphdVowpMkKSQ7w+dzgLpVyyvkqqztuvZkOvQXXHp0wApGjkfaTvJpJBC6GHvGX
         Eky607D87GF6PF+HsLcCjwK7zYu+q139Ho0Wu9md9BE3T29akZTRt+YJRkyZPS4SCchc
         A1zv0/NL1p+J0ggxlgoVATs1tfc8TlqLavPmIO1K1+lbCeM0f6Mk6nL6f3GKjCdvbrQj
         tELcRTNiWZbVN79GR+YCRYQMijlXLJciDHFeTTVcG2CC0MWHXBhZOP8+sYrVmgwovJ1v
         ZwLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775304994; x=1775909794;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=QRC8yozcX9QSmNG0yIA7nVyNQgWhlHJbCL9t4pSEkxw=;
        b=ZqwDNBZdR79zRYVIelff6Vr5+TY8DEXNtewTgyQyrlGqinW8LDzX0Q/kvppW5eohh3
         28H4VirXFqH5xNI91a7KCudxsnUL4u0pSfhX/w6HckinjKvmaFPZsnGr5yeyhAQ8AUAl
         to2KRDdUcQfbKAbqMBMsrYD6pacyqWmU9zJryoYxP8KzuCvDFPBemRujWczynZczoddF
         vLv5Fzf7WUmBNm03O3AGuwI/H8NZh5YIqp6O0yg0dlIz56SXvKZYDjWSdqfQwm3Hyskv
         WIkGPk5N7ELmXamUk+opgTjI1L4zR5ZPbJ9CZiPEtYm/6a9RGdCWP6Shg3LEy2n4t9ag
         pprg==
X-Forwarded-Encrypted: i=1; AJvYcCWRoTK2tVZaucflZJOhK+fJQ8IZCawEfNPRUWA9lZibs7F+TvYupVr7sZ1B+NTe18VGviCXdfZrmUOEV4I=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwfyaVDsv7aDXzUWeb/jRi+W+xqAN4rLPJw2LakH+bUvezTFjuZ
	0DoruP0sy6W1SulCR9ehBYt1olBgga7f3+wYgad5qGDkGbpKI44wbhp6
X-Gm-Gg: AeBDievJtb7Ax0RlBHJdBIjeYbtNzzNUrFiNbMhpVWBL2l1hIKcdV2RHPkRAk4BMw6s
	alT6XaJFxHLs46kA75CdezuvKK3XqpM3cnHSJelixeGt+Lb410CCIbQQyqPaTXtXBkmEyWU4YYU
	29fjkGfTpQG5qAHBVPHe7+XySBUFENQJo58zsAjP/1HjThSpTmfySJGYTVkuYW6eCU0Q+aqmEYJ
	BLO3rt8YN9iAJ9kQzUlcujy8TNJIb2Alif7xWoPOrih6PB7VZjO00FAIeXqEDu3H8oYCTzNhDOQ
	1gJKSQD6t/GU5AkLmuGu3naeLovFUmghPb4v6610cfaWM4w6SMCV7+9TLVjs+R1iJ44PipiKKbK
	Nkd1uYkb4xYuRe0N47let8ySquk0HGmwz2+4dosp6oOQnl7S4tJMAQAJobX5mqtLXonPNC5Q7is
	GnPA9/uETTCQAvtALWKVi6gEPQGJjlGaR+3Ex9tnrbxMD7PGGKBLxlX+Wz892M2mGe8oI773CBZ
	xU=
X-Received: by 2002:a17:90b:2fcb:b0:35d:972c:b3d6 with SMTP id 98e67ed59e1d1-35de68688damr6047728a91.9.1775304994508;
        Sat, 04 Apr 2026 05:16:34 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de500c42fsm2702745a91.0.2026.04.04.05.16.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 05:16:33 -0700 (PDT)
From: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
To: maddy@linux.ibm.com,
	mpe@ellerman.id.au,
	npiggin@gmail.com,
	chleroy@kernel.org,
	peterz@infradead.org,
	jpoimboe@kernel.org,
	jbaron@akamai.com,
	aliceryhl@google.com,
	rostedt@goodmis.org,
	ardb@kernel.org,
	ojeda@kernel.org,
	boqun@kernel.org,
	gary@garyguo.net,
	bjorn3_gh@protonmail.com,
	lossin@kernel.org,
	a.hindborg@kernel.org,
	tmgross@umich.edu,
	dakr@kernel.org,
	nathan@kernel.org,
	nick.desaulniers+lkml@gmail.com,
	morbo@google.com,
	justinstitt@google.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: [PATCH V9 1/4] rust: Fix "multiple candidates for rmeta dependency core" error
Date: Sat,  4 Apr 2026 17:46:07 +0530
Message-ID: <20260404121610.1956528-2-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404121610.1956528-1-mkchauras@gmail.com>
References: <20260404121610.1956528-1-mkchauras@gmail.com>
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
Content-Transfer-Encoding: 8bit

When building Rust code with LLVM=1 with -j1, rustc was encountering
an error:
"multiple candidates for `rmeta` dependency `core` found", with two
candidates:
1. The host's standard library from the rustup toolchain
2. The kernel's custom libcore.rmeta in the rust/ directory

This occurred because the build system was using `-L$(objtree)/rust`
for host library builds (proc_macro2, quote, syn), which caused rustc
to search the rust/ directory. During this search, rustc would find
both the kernel's custom libcore.rmeta and gain access to the host's
standard library, creating a conflict.

The solution is to separate host libraries into a dedicated rust/host/
subdirectory and use `-L$(objtree)/rust/host` for host builds instead
of `-L$(objtree)/rust`. This ensures that:

1. Host library builds (proc_macro2, quote, syn) only search rust/host/
   and never encounter the kernel's libcore.rmeta
2. Proc macro builds use `-L$(objtree)/rust/host` to find their
   dependencies

Special handling is added for rustdoc-pin_init, which is a host build
(to access the alloc crate) but depends on proc macros from the main
rust/ directory. It uses explicit `--extern` paths with absolute paths
to reference the proc macros without adding `-L$(objtree)/rust`, which
would reintroduce the conflict.

The rust/host/ directory is added to clean-files to ensure it's removed
during `make clean`.

As there is a lot going on, here's a summary of changes:
- Add clean-files := host/ to clean the generated directory
- Change host library targets from lib*.rlib to host/lib*.rlib
- Update cmd_rustc_procmacrolibrary to create host/ directory
- Update cmd_rustc_procmacro to use -L$(objtree)/rust/host
- Update cmd_rustdoc to use -L$(objtree)/rust/host for host builds
- Update rustdoc-pin_init to use explicit --extern paths for proc macros
  as pin-init also needs alloc crate from -L$(objtree)/rust. So the proc
  macros needs an absolute path

Link: https://github.com/Rust-for-Linux/linux/issues/105
Link: https://github.com/linuxppc/issues/issues/451
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 rust/Makefile | 57 +++++++++++++++++++++++++++++++--------------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 9801af2e1e02..5f726a332d9e 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -3,6 +3,9 @@
 # Where to place rustdoc generated documentation
 rustdoc_output := $(objtree)/Documentation/output/rust/rustdoc
 
+# Clean generated host directory
+clean-files := host/
+
 obj-$(CONFIG_RUST) += core.o compiler_builtins.o ffi.o
 always-$(CONFIG_RUST) += exports_core_generated.h
 
@@ -27,7 +30,7 @@ endif
 
 obj-$(CONFIG_RUST) += exports.o
 
-always-$(CONFIG_RUST) += libproc_macro2.rlib libquote.rlib libsyn.rlib
+always-$(CONFIG_RUST) += host/libproc_macro2.rlib host/libquote.rlib host/libsyn.rlib
 
 always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated.rs
 always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.c
@@ -150,7 +153,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTDOC) $(filter-out $(skip_flags) --remap-path-prefix=% --remap-path-scope=%, \
 			$(if $(rustdoc_host),$(rust_common_flags),$(rust_flags))) \
-		$(rustc_target_flags) -L$(objtree)/$(obj) \
+		$(rustc_target_flags) -L$(objtree)/$(obj)$(if $(rustdoc_host),/host) \
 		-Zunstable-options --generate-link-to-definition \
 		--output $(rustdoc_output) \
 		--crate-name $(subst rustdoc-,,$@) \
@@ -193,13 +196,15 @@ rustdoc-proc_macro2: $(src)/proc-macro2/lib.rs rustdoc-clean FORCE
 	+$(call if_changed,rustdoc)
 
 rustdoc-quote: private rustdoc_host = yes
-rustdoc-quote: private rustc_target_flags = $(quote-flags)
+rustdoc-quote: private rustc_target_flags = $(quote-flags) \
+    --extern proc_macro2
 rustdoc-quote: private skip_flags = $(quote-skip_flags)
 rustdoc-quote: $(src)/quote/lib.rs rustdoc-clean rustdoc-proc_macro2 FORCE
 	+$(call if_changed,rustdoc)
 
 rustdoc-syn: private rustdoc_host = yes
-rustdoc-syn: private rustc_target_flags = $(syn-flags)
+rustdoc-syn: private rustc_target_flags = $(syn-flags) \
+    --extern proc_macro2 --extern quote
 rustdoc-syn: $(src)/syn/lib.rs rustdoc-clean rustdoc-quote FORCE
 	+$(call if_changed,rustdoc)
 
@@ -236,7 +241,10 @@ rustdoc-pin_init_internal: $(src)/pin-init/internal/src/lib.rs \
 	+$(call if_changed,rustdoc)
 
 rustdoc-pin_init: private rustdoc_host = yes
-rustdoc-pin_init: private rustc_target_flags = $(pin_init-flags) \
+rustdoc-pin_init: private rustc_target_flags = \
+    --extern pin_init_internal=$(abspath $(objtree)/$(obj)/$(libpin_init_internal_name)) \
+    --extern macros=$(abspath $(objtree)/$(obj)/$(libmacros_name)) \
+    $(call cfgs-to-flags,$(pin_init-cfgs)) \
     --extern alloc --cfg feature=\"alloc\"
 rustdoc-pin_init: $(src)/pin-init/src/lib.rs rustdoc-pin_init_internal \
     rustdoc-macros FORCE
@@ -525,48 +533,53 @@ $(obj)/exports_kernel_generated.h: $(obj)/kernel.o FORCE
 
 quiet_cmd_rustc_procmacrolibrary = $(RUSTC_OR_CLIPPY_QUIET) PL $@
       cmd_rustc_procmacrolibrary = \
+	mkdir -p $(dir $@); \
 	$(if $(skip_clippy),$(RUSTC),$(RUSTC_OR_CLIPPY)) \
 		$(filter-out $(skip_flags),$(rust_common_flags) $(rustc_target_flags)) \
 		--emit=dep-info=$(depfile) --emit=link=$@ --crate-type rlib -O \
-		--out-dir $(objtree)/$(obj) -L$(objtree)/$(obj) \
 		--crate-name $(patsubst lib%.rlib,%,$(notdir $@)) $<
 
-$(obj)/libproc_macro2.rlib: private skip_clippy = 1
-$(obj)/libproc_macro2.rlib: private rustc_target_flags = $(proc_macro2-flags)
-$(obj)/libproc_macro2.rlib: $(src)/proc-macro2/lib.rs FORCE
+$(obj)/host/libproc_macro2.rlib: private skip_clippy = 1
+$(obj)/host/libproc_macro2.rlib: private rustc_target_flags = $(proc_macro2-flags)
+$(obj)/host/libproc_macro2.rlib: $(src)/proc-macro2/lib.rs FORCE
 	+$(call if_changed_dep,rustc_procmacrolibrary)
 
-$(obj)/libquote.rlib: private skip_clippy = 1
-$(obj)/libquote.rlib: private skip_flags = $(quote-skip_flags)
-$(obj)/libquote.rlib: private rustc_target_flags = $(quote-flags)
-$(obj)/libquote.rlib: $(src)/quote/lib.rs $(obj)/libproc_macro2.rlib FORCE
+$(obj)/host/libquote.rlib: private skip_clippy = 1
+$(obj)/host/libquote.rlib: private skip_flags = $(quote-skip_flags)
+$(obj)/host/libquote.rlib: private rustc_target_flags = $(quote-flags) \
+	-L$(objtree)/$(obj)/host --extern proc_macro2
+$(obj)/host/libquote.rlib: $(src)/quote/lib.rs $(obj)/host/libproc_macro2.rlib FORCE
 	+$(call if_changed_dep,rustc_procmacrolibrary)
 
-$(obj)/libsyn.rlib: private skip_clippy = 1
-$(obj)/libsyn.rlib: private rustc_target_flags = $(syn-flags)
-$(obj)/libsyn.rlib: $(src)/syn/lib.rs $(obj)/libquote.rlib FORCE
+$(obj)/host/libsyn.rlib: private skip_clippy = 1
+$(obj)/host/libsyn.rlib: private rustc_target_flags = $(syn-flags) \
+	-L$(objtree)/$(obj)/host --extern proc_macro2 --extern quote
+$(obj)/host/libsyn.rlib: $(src)/syn/lib.rs $(obj)/host/libquote.rlib FORCE
 	+$(call if_changed_dep,rustc_procmacrolibrary)
 
 quiet_cmd_rustc_procmacro = $(RUSTC_OR_CLIPPY_QUIET) P $@
       cmd_rustc_procmacro = \
-	$(RUSTC_OR_CLIPPY) $(rust_common_flags) $(rustc_target_flags) \
+	$(RUSTC_OR_CLIPPY) $(rust_common_flags) \
 		-Clinker-flavor=gcc -Clinker=$(HOSTCC) \
 		-Clink-args='$(call escsq,$(KBUILD_PROCMACROLDFLAGS))' \
 		--emit=dep-info=$(depfile) --emit=link=$@ --extern proc_macro \
-		--crate-type proc-macro -L$(objtree)/$(obj) \
+		--crate-type proc-macro \
+		-L$(objtree)/$(obj)/host \
 		--crate-name $(patsubst lib%.$(libmacros_extension),%,$(notdir $@)) \
-		@$(objtree)/include/generated/rustc_cfg $<
+		@$(objtree)/include/generated/rustc_cfg \
+		$(rustc_target_flags) \
+		$<
 
 # Procedural macros can only be used with the `rustc` that compiled it.
 $(obj)/$(libmacros_name): private rustc_target_flags = \
     --extern proc_macro2 --extern quote --extern syn
-$(obj)/$(libmacros_name): $(src)/macros/lib.rs $(obj)/libproc_macro2.rlib \
-    $(obj)/libquote.rlib $(obj)/libsyn.rlib FORCE
+$(obj)/$(libmacros_name): $(src)/macros/lib.rs $(obj)/host/libproc_macro2.rlib \
+    $(obj)/host/libquote.rlib $(obj)/host/libsyn.rlib FORCE
 	+$(call if_changed_dep,rustc_procmacro)
 
 $(obj)/$(libpin_init_internal_name): private rustc_target_flags = $(pin_init_internal-flags)
 $(obj)/$(libpin_init_internal_name): $(src)/pin-init/internal/src/lib.rs \
-    $(obj)/libproc_macro2.rlib $(obj)/libquote.rlib $(obj)/libsyn.rlib FORCE
+    $(obj)/host/libproc_macro2.rlib $(obj)/host/libquote.rlib $(obj)/host/libsyn.rlib FORCE
 	+$(call if_changed_dep,rustc_procmacro)
 
 # `rustc` requires `-Zunstable-options` to use custom target specifications
-- 
2.53.0


