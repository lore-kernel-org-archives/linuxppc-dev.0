Return-Path: <linuxppc-dev+bounces-19274-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5256BE85373
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 14:53:37 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnMDJ04kYz2ynW;
	Sat, 04 Apr 2026 01:53:36 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775228015;
	cv=none; b=kbvrT0UztvOlGYmD0sJlGqG9EAw3f4uTGroLVuEvuUInbdTTI7roBhv1UYoWail4FfqgafKrMtxDf/gLmJUYTU0aAN2zNduDz9qw+hC9oFG8lkgG0tkb5PbRMr2XlVyM4m6zeRQ+TcL502AIybmlqslupYHIZJlxd70JXPp7aISbHdv3SussIGUUlSzeWZwm7Pi8cSX9nCoOyGgKqfSRrBuQId+nEnzbuhF1V/PuKYnoAU/Ih7U/YoQT7L/X3uUuM1ckxmSdbOknNUsDhHtNSivv4ZCiaOc+zTZi+wVevERA4tNogD20rdyR9X8ldbEskWkAqfqUm3ZyhP13tPAxSQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775228015; c=relaxed/relaxed;
	bh=fUTSB1GcQ+ZgkTavCnlkXCyNO/5I/d2MoyKGgMKrfsE=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=nx/y9i3MD5Z8tif0TC4yl1wOSjq95pVh5mLtO/hv+A+MX5BH7ZxG1p/AaDoTix6q7fHKwzgPvMokboMH7zckZpvgeJZHChIaV/ZmU6/asejfIqXBeBrwYvj9705EEvzj26NfLawh90+9vu3royYlJVFOXUnEvlElw4WC+ewCzV5jTb1Y0mpkhgjHAQHW/q2tXiiGGgDJiSlt/61eS75GX7FAKZ05fe8vQOuJX/EQ4RJ95ZyWMa8kfcLo/CvqF3r0pl7nNAdRlgGGMTCVtXxNRh0LssG8tr1Ld8o7rW1OuN+tscHha74/kOInl8zmGJ8/ZqwLbZXJ44EtmWUVAfPzJw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=On9lPSMr; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=On9lPSMr;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42e; helo=mail-pf1-x42e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnMDG6L40z2yWK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 01:53:34 +1100 (AEDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-82cebbdbdccso1004382b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 07:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775228013; x=1775832813; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fUTSB1GcQ+ZgkTavCnlkXCyNO/5I/d2MoyKGgMKrfsE=;
        b=On9lPSMrBXUx+R5j0fuNKOhDrUZVf6jZuVfKp29RgcEffDligDEmST1hJKFX7ag5Mw
         06Kz8yqCWiueKLLoSkoyO7XtZNZtJwuF3qxceEBvlxf585SOWrQh10dKl0W2HfT+X+PG
         xClK6qLg6TS4CN5yYiriav3JxhlX159okURZzA2f46iAO+gGrOAWHZ0y7SL6O+3AXGu4
         Q7cLMwX4I8NV9SGOgGhBISpoiZHIA/a6Sgc1W75RBmHmgk2lYdpoecZ8ZyIU+J4e6xBV
         puZ3oQxJSzunaYskCDAEWS7rcC9erZVP7zaIlW0RV+StFo75XXRNH3JWLDhLPASedD10
         qrvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228013; x=1775832813;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=fUTSB1GcQ+ZgkTavCnlkXCyNO/5I/d2MoyKGgMKrfsE=;
        b=BdZA4Mu+F74zwIJgjL4FaWrk3skCkiELuuZ/w/upddqgJ8wlhvRgQbOE+/fYKc3NZ3
         iY7GlNeLLrBaqrYTdS2fWuhJxw0K9EgOqnlYIt4noQyfOnRPKKdEufM4Tho1I3r3abjb
         ewiB7DHx8hVSVK45OLKYl2tzc9RXmbyQhAPggPzljKF7R6cjdKL9kO9LZjtVaYmsEm3y
         dH3eLnXxbKEvpcin6ASNwUppP75CFnNaVoHSxed/DYTnIOrkXSmfu14k0AngO9Ud6Kw4
         RDuR7X1feWREwK28z2Se3pkDMIpGb+jS/XfSdZuDLhXQkox3lm9qyRHUzWG6DRms3kyA
         Ewnw==
X-Forwarded-Encrypted: i=1; AJvYcCUG+2cYHEFav4n945uZPk4De+ypDTAjNheAArnovN4VrHwPSDb5rfYaEcwHIHwcZfPGAbJ1CLfZqYbgddE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw+wLXwh/brNX92QiNYvc8b6rmW/wGa6DjVNOY9X5Vk7zD2Knq1
	9e2v4OhptYArhIBICW9FyRhZwMRg5QzVkie1IyGCbQFPyI9eCKmCW88u
X-Gm-Gg: AeBDietgJtSZBPwfciSTPYHKJ1+FRV1MpBoFRvEmhqfq57xkl/rgR6tp1KxRW3BndLD
	coatVOqb8IHS6xsI2B8ZvNm+HTrqmEIYwHWLtqxfbksrC0Mz1FrLSlIS1UHjh6HlKrltich/xUn
	5Me2qRH6VAzCSl30chB1kS4NBlep6t/9VIXjNBXTiFjExgqNRPJKeBqMGVrfvPldhyMWGJskZez
	W1F7u5VNCD57mqPTUaPgsrS/gWlW/GMhnrEYG4yY9yVR1CPe3l3U6Er7sXfOr3cG89mqm6VSXZ7
	wil84zogrjjlmKC+kUtXgH3wiZq9ReTZqa+JMwnxyEaVhBSk5hoQaeSFG/cnGNGONcB9EJtff5w
	+EOG5DIkJVQlE5Bka/zSD4dX3wFlIXotP/ntH7I8HoXliJP2foxWzkHBIUW1BSYUF9WaLdW750V
	Fn67fuq6fO2RxbDF+xOg0LGTc0/iiWJgc2+waTCc57+eoablb0ifDyagIIKDZvbibAWW4iTlYCU
	CdQhbUzCtqYIQ==
X-Received: by 2002:a05:6a00:3699:b0:81f:544b:3998 with SMTP id d2e1a72fcca58-82d0dd20f4amr2711320b3a.26.1775228012689;
        Fri, 03 Apr 2026 07:53:32 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca4efesm6301682b3a.61.2026.04.03.07.53.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:53:32 -0700 (PDT)
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
Subject: [PATCH V8 1/4] rust: Fix "multiple candidates for rmeta dependency core" error
Date: Fri,  3 Apr 2026 20:23:05 +0530
Message-ID: <20260403145308.1042622-2-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403145308.1042622-1-mkchauras@gmail.com>
References: <20260403145308.1042622-1-mkchauras@gmail.com>
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
3. Test builds use `-L$(objtree)/rust/test` for their dependencies
4. Target builds continue to use `-L$(objtree)/rust` as before

Special handling is added for rustdoc-pin_init, which is a host build
(to access the alloc crate) but depends on proc macros from the main
rust/ directory. It uses explicit `--extern` paths with absolute paths
to reference the proc macros without adding `-L$(objtree)/rust`, which
would reintroduce the conflict.

The rust/host/ directory is added to clean-files to ensure it's removed
during `make clean`.

Changes:
- Add clean-files := host/ to clean the generated directory
- Change host library targets from lib*.rlib to host/lib*.rlib
- Update cmd_rustc_procmacrolibrary to create host/ directory
- Update cmd_rustc_procmacro to use -L$(objtree)/rust/host
- Update cmd_rustdoc to use -L$(objtree)/rust/host for host builds
- Update cmd_rustc_test_library to use -L$(objtree)/rust/test
- Update rustdoc-pin_init to use explicit --extern paths for proc macros

Link: https://github.com/Rust-for-Linux/linux/issues/105
Link: https://github.com/linuxppc/issues/issues/451
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 rust/Makefile | 63 ++++++++++++++++++++++++++++++++-------------------
 1 file changed, 40 insertions(+), 23 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 9801af2e1e02..762bddc868e4 100644
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
@@ -193,13 +196,16 @@ rustdoc-proc_macro2: $(src)/proc-macro2/lib.rs rustdoc-clean FORCE
 	+$(call if_changed,rustdoc)
 
 rustdoc-quote: private rustdoc_host = yes
-rustdoc-quote: private rustc_target_flags = $(quote-flags)
+rustdoc-quote: private rustc_target_flags = $(quote-flags) \
+    --extern proc_macro2=$(abspath $(objtree)/$(obj)/host/libproc_macro2.rlib)
 rustdoc-quote: private skip_flags = $(quote-skip_flags)
 rustdoc-quote: $(src)/quote/lib.rs rustdoc-clean rustdoc-proc_macro2 FORCE
 	+$(call if_changed,rustdoc)
 
 rustdoc-syn: private rustdoc_host = yes
-rustdoc-syn: private rustc_target_flags = $(syn-flags)
+rustdoc-syn: private rustc_target_flags = $(syn-flags) \
+    --extern proc_macro2=$(abspath $(objtree)/$(obj)/host/libproc_macro2.rlib) \
+    --extern quote=$(abspath $(objtree)/$(obj)/host/libquote.rlib)
 rustdoc-syn: $(src)/syn/lib.rs rustdoc-clean rustdoc-quote FORCE
 	+$(call if_changed,rustdoc)
 
@@ -236,7 +242,10 @@ rustdoc-pin_init_internal: $(src)/pin-init/internal/src/lib.rs \
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
@@ -369,7 +378,9 @@ rusttest: rusttest-macros
 
 rusttest-macros: private rustc_target_flags = --extern proc_macro \
     --extern macros --extern kernel --extern pin_init \
-    --extern proc_macro2 --extern quote --extern syn
+    --extern proc_macro2=$(abspath $(objtree)/$(obj)/test/libproc_macro2.rlib) \
+    --extern quote=$(abspath $(objtree)/$(obj)/test/libquote.rlib) \
+    --extern syn=$(abspath $(objtree)/$(obj)/test/libsyn.rlib)
 rusttest-macros: private rustdoc_test_target_flags = --crate-type proc-macro
 rusttest-macros: $(src)/macros/lib.rs \
     rusttestlib-macros rusttestlib-kernel rusttestlib-pin_init FORCE
@@ -525,48 +536,54 @@ $(obj)/exports_kernel_generated.h: $(obj)/kernel.o FORCE
 
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
+	--extern proc_macro2=$(abspath $(objtree)/$(obj)/host/libproc_macro2.rlib)
+$(obj)/host/libquote.rlib: $(src)/quote/lib.rs $(obj)/host/libproc_macro2.rlib FORCE
 	+$(call if_changed_dep,rustc_procmacrolibrary)
 
-$(obj)/libsyn.rlib: private skip_clippy = 1
-$(obj)/libsyn.rlib: private rustc_target_flags = $(syn-flags)
-$(obj)/libsyn.rlib: $(src)/syn/lib.rs $(obj)/libquote.rlib FORCE
+$(obj)/host/libsyn.rlib: private skip_clippy = 1
+$(obj)/host/libsyn.rlib: private rustc_target_flags = $(syn-flags) \
+	--extern proc_macro2=$(abspath $(objtree)/$(obj)/host/libproc_macro2.rlib) \
+	--extern quote=$(abspath $(objtree)/$(obj)/host/libquote.rlib)
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


