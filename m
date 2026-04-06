Return-Path: <linuxppc-dev+bounces-19408-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 34C4BF46C78
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 20:02:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqKx42pjVz2ySS;
	Tue, 07 Apr 2026 06:02:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::532"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775505736;
	cv=none; b=NIC15BexIjXGix2NZ3St6K/YnnzSRVAikFod4tOQIf1MIbQMe8yHLtUbR+Xeq1fxuRMralPz1b8qa4EjVY5HHb70+9IBSZstq63MK6cwnj59ieyVNaxC48/di0v87bO8s9kLdJF1UhGk5+vOKk7uEbdtelFn1QjDOhDpQtwDrvuC+M1nwzqXpExTFfpdeKqC5kzNzoTTZFpGjubWRcIVLUNsnibLCPuo1It0I7OtrDKzmVFX0CWJr5peq00iqfsNYdOz87mml08wcn9y3oYDR1oi3oUSRHmPA/wBReSfG+mqseCryqfMqeGNslDq4WvjSqHBtm7AyU1BVDSPatejPw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775505736; c=relaxed/relaxed;
	bh=lPSLhEO/t1n98OrRH4+WlgtQBOSzWDBbT00u5q2kC9Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SNHKPzyC3YycqgxVF07JbdpxPlKd8I1ZkG3j6mpsg7ffZYXoGdBYIpUlSGQBJ4fH4pAXVla43quI9atk5yZuYbAAGpJaj8qc1Q4J8mTizHhnLy6FSjNGN6lzWoXBFZX6kO11RZzH+eBjMNuFutW7B3ugNKSa6s7ym8E+oZtYurR5Hi4zJ85QVgZSoqnE3Mde6bKr7VVSJT34pV8RhVA6/jleyEedYCOwp8QqPiuv2uwsXjy71gQLdVR1L/OPDJFLwpTLwUMIUuDxOt73k4yXRBn/2rpp6u8TKhkPQ+6F88wyocZ4TPP3hsuqZeQVuBG4ta4FsFkvT41YBVfGpsQgGA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fl12yo8e; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=fl12yo8e;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::532; helo=mail-pg1-x532.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqKx304nWz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 06:02:14 +1000 (AEST)
Received: by mail-pg1-x532.google.com with SMTP id 41be03b00d2f7-c76bde70ec9so1668299a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 13:02:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775505733; x=1776110533; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=lPSLhEO/t1n98OrRH4+WlgtQBOSzWDBbT00u5q2kC9Y=;
        b=fl12yo8e/DgBy3qgmMsbiW8M7zPT39Q282FhYVqGk5Hv2MtGekzxBuOBma+CBQgqv5
         J8cgNP0iCCO/aSAYFHB5wdJdch9IkZGeh/0c6cx70h9IbF8p5nj2JFSBqI6Ud7pxHj1B
         6fraX3lyky776S6nRhGhb9abWarFA5I71YlxaxgXGlXLULIMnxlTWeT95ckTAJZNgXor
         uy3/zN7n0pJzzXIgYTCTkyjRTrrKR+6zJXNHpcvbVMhqbvry8QNxezAl+XIV7axfT+/B
         C+Cu1SBUvJHRCJ5XcB3/wKjl8Hh4FA2xqUVqBjxTmEdcy9qpDwV8VdqZGadU5xW5BupG
         +v/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775505733; x=1776110533;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=lPSLhEO/t1n98OrRH4+WlgtQBOSzWDBbT00u5q2kC9Y=;
        b=ZxaZco7syG6P3OKjrB5c6Wx8+TbXPUQlYYKtPdnDLWbt/7Ja+rAoQ/I1+Au317JlB5
         eB13Qd7Xisgd8L+g6WlxHA0KBRlrV8MTgaMp6tQnbqfT4aUVY7IoxFfxOnaG+KIoJx0p
         6c3sdq9kcBASZuStcWMF4EfG9+kJRIzLFWktBVFfL61f6yyBHFiAvUGhzAu1UVZWbBIG
         HHudREQAQIZSEotgvcRC0FiS4RlPwp0uCPdCmuUTn1/Dem82O8f5qtOvSa/aXwNhd/Sy
         T1h/takzjC3d2fww06CEPFCXF3914Ia1H1csf1sPwdXwuUIbTlb/RvmLHM0OwaCnltO3
         xeNA==
X-Forwarded-Encrypted: i=1; AJvYcCV7s3aA2dVpube2zSUYS6Cju4+/DPYJ6jUMqIRODcN7VpTBhFh1CK775r5N1C2aoiFWpRJDPbaeoXmwyow=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyWgxueSNHf+yNIMXapvdTQik4w8+KDK5xhW1Qy4VgpR7EGPXWG
	3evptMIy+O2roCJtxANamGfdSBRmUEIgmGelq+pzhHm3gXw1kF1d05ew
X-Gm-Gg: AeBDies37+eUVjb3fiPzgKCOBVJRHnNLstjRvSwMkstNEMG5twaR0wwTsQ/gD7meB6a
	vsSH6CNSF5AgtWgYjzbaWA9REDYR/qsmWbQsSGgGpQBJQ74N001VY9X3S9To5avNXzIV0tW+yO2
	5w1F1mjQM1jt6bWa/FCC7z0uz87ARQTNmSYl6nh7+SnX8jz789BsCbsnykR5CuVU/aDvWp7Ui0b
	9aPe1Py/qaNQhanRrr5gXwcFSiu0Sz7jWV6yKmXcqUgj2h/nX2Uu7m+ZPK8BD43xS2gNEPos5Um
	0uH7vZWkGQkbZGpXmw0lf57IkkUspnDly++gn5WA4gMxaqdzEQN/w0TsAMwnQvuwIzHawbPHbLP
	dPnnMlIoOBKmrnmFxu9owapfUX74iZU30/NF6y7fSMIhr5nG3CMRGhvAUvj8fRHbyJmkyUdlyVV
	jDfHBklAjqxF8s22skz9ytL3xi1s5Ot4t7EHeDwCzEnMFYChNIxFpXdUwY0Hi2WX/71B/mGo86w
	Y0=
X-Received: by 2002:a17:903:3b8f:b0:2ae:cb0e:fd59 with SMTP id d9443c01a7336-2b28164cfebmr148221295ad.8.1775505732659;
        Mon, 06 Apr 2026 13:02:12 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497af26sm151098205ad.49.2026.04.06.13.02.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 13:02:12 -0700 (PDT)
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
Subject: [PATCH V10 1/4] rust: Separate host libraries to fix rmeta dependency conflict
Date: Tue,  7 Apr 2026 01:31:46 +0530
Message-ID: <20260406200149.3727922-2-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406200149.3727922-1-mkchauras@gmail.com>
References: <20260406200149.3727922-1-mkchauras@gmail.com>
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

When building Rust code for powerpc64le with LLVM=1 and -j1, rustc
encounters an error: "multiple candidates for `rmeta` dependency `core`
found", with two candidates:
1. The host's standard library from the rustup toolchain
2. The kernel's custom libcore.rmeta in the rust/ directory

This occurs because the build system uses `-L$(objtree)/rust` for host
library builds (proc_macro2, quote, syn), which causes rustc to search
the rust/ directory. During this search, rustc finds both the kernel's
custom libcore.rmeta and gains access to the host's standard library,
creating a conflict.

Separate all host-side build artifacts (host libraries and proc macros)
into a dedicated rust/host/ subdirectory and use `-L$(objtree)/rust/host`
for host builds. This ensures host builds only search rust/host/ and
never encounter the kernel's libcore.rmeta.

The `--out-dir` flag is removed from cmd_rustc_procmacrolibrary because
the output directory is now created explicitly with `mkdir -p $(dir $@)`
and the output file path is specified directly with `--emit=link=$@`,
making `--out-dir` redundant.

Moving the proc macros (libmacros and libpin_init_internal) to rust/host/
eliminates the need for special handling in rustdoc-pin_init, which can
now use the pin_init-flags variable directly instead of duplicating the
flags with absolute paths.

The rust/host/ directory is added to clean-files to ensure it's removed
during `make clean`.

Link: https://github.com/Rust-for-Linux/linux/issues/105
Link: https://github.com/linuxppc/issues/issues/451
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 rust/Makefile | 56 +++++++++++++++++++++++++++------------------------
 1 file changed, 30 insertions(+), 26 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index 9801af2e1e02..d8f34c4858b8 100644
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
@@ -49,7 +52,7 @@ libmacros_extension := $(patsubst libmacros.%,%,$(libmacros_name))
 libpin_init_internal_name := $(shell MAKEFLAGS= $(RUSTC) --print file-names --crate-name pin_init_internal --crate-type proc-macro - </dev/null)
 libpin_init_internal_extension := $(patsubst libpin_init_internal.%,%,$(libpin_init_internal_name))
 
-always-$(CONFIG_RUST) += $(libmacros_name) $(libpin_init_internal_name)
+always-$(CONFIG_RUST) += host/$(libmacros_name) host/$(libpin_init_internal_name)
 
 # `$(rust_flags)` is passed in case the user added `--sysroot`.
 rustc_sysroot := $(shell MAKEFLAGS= $(RUSTC) $(rust_flags) --print sysroot)
@@ -150,7 +153,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTDOC) $(filter-out $(skip_flags) --remap-path-prefix=% --remap-path-scope=%, \
 			$(if $(rustdoc_host),$(rust_common_flags),$(rust_flags))) \
-		$(rustc_target_flags) -L$(objtree)/$(obj) \
+		$(rustc_target_flags) -L$(objtree)/$(obj)$(if $(rustdoc_host),/host) \
 		-Zunstable-options --generate-link-to-definition \
 		--output $(rustdoc_output) \
 		--crate-name $(subst rustdoc-,,$@) \
@@ -247,7 +250,7 @@ rustdoc-kernel: private rustc_target_flags = --extern ffi --extern pin_init \
     --extern build_error --extern macros \
     --extern bindings --extern uapi
 rustdoc-kernel: $(src)/kernel/lib.rs rustdoc-core rustdoc-ffi rustdoc-macros \
-    rustdoc-pin_init rustdoc-compiler_builtins $(obj)/$(libmacros_name) \
+    rustdoc-pin_init rustdoc-compiler_builtins $(obj)/host/$(libmacros_name) \
     $(obj)/bindings.o FORCE
 	+$(call if_changed,rustdoc)
 
@@ -299,14 +302,14 @@ rusttestlib-pin_init_internal: $(src)/pin-init/internal/src/lib.rs \
 
 rusttestlib-pin_init: private rustc_target_flags = $(pin_init-flags)
 rusttestlib-pin_init: $(src)/pin-init/src/lib.rs rusttestlib-macros \
-    rusttestlib-pin_init_internal $(obj)/$(libpin_init_internal_name) FORCE
+    rusttestlib-pin_init_internal $(obj)/host/$(libpin_init_internal_name) FORCE
 	+$(call if_changed,rustc_test_library)
 
 rusttestlib-kernel: private rustc_target_flags = --extern ffi \
     --extern build_error --extern macros --extern pin_init \
     --extern bindings --extern uapi
 rusttestlib-kernel: $(src)/kernel/lib.rs rusttestlib-bindings rusttestlib-uapi \
-    rusttestlib-build_error rusttestlib-pin_init $(obj)/$(libmacros_name) \
+    rusttestlib-build_error rusttestlib-pin_init $(obj)/host/$(libmacros_name) \
     $(obj)/bindings.o FORCE
 	+$(call if_changed,rustc_test_library)
 
@@ -525,26 +528,27 @@ $(obj)/exports_kernel_generated.h: $(obj)/kernel.o FORCE
 
 quiet_cmd_rustc_procmacrolibrary = $(RUSTC_OR_CLIPPY_QUIET) PL $@
       cmd_rustc_procmacrolibrary = \
+	mkdir -p $(dir $@); \
 	$(if $(skip_clippy),$(RUSTC),$(RUSTC_OR_CLIPPY)) \
 		$(filter-out $(skip_flags),$(rust_common_flags) $(rustc_target_flags)) \
 		--emit=dep-info=$(depfile) --emit=link=$@ --crate-type rlib -O \
-		--out-dir $(objtree)/$(obj) -L$(objtree)/$(obj) \
+		-L$(objtree)/$(obj)/host \
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
+$(obj)/host/libquote.rlib: private rustc_target_flags = $(quote-flags)
+$(obj)/host/libquote.rlib: $(src)/quote/lib.rs $(obj)/host/libproc_macro2.rlib FORCE
 	+$(call if_changed_dep,rustc_procmacrolibrary)
 
-$(obj)/libsyn.rlib: private skip_clippy = 1
-$(obj)/libsyn.rlib: private rustc_target_flags = $(syn-flags)
-$(obj)/libsyn.rlib: $(src)/syn/lib.rs $(obj)/libquote.rlib FORCE
+$(obj)/host/libsyn.rlib: private skip_clippy = 1
+$(obj)/host/libsyn.rlib: private rustc_target_flags = $(syn-flags)
+$(obj)/host/libsyn.rlib: $(src)/syn/lib.rs $(obj)/host/libquote.rlib FORCE
 	+$(call if_changed_dep,rustc_procmacrolibrary)
 
 quiet_cmd_rustc_procmacro = $(RUSTC_OR_CLIPPY_QUIET) P $@
@@ -553,20 +557,20 @@ quiet_cmd_rustc_procmacro = $(RUSTC_OR_CLIPPY_QUIET) P $@
 		-Clinker-flavor=gcc -Clinker=$(HOSTCC) \
 		-Clink-args='$(call escsq,$(KBUILD_PROCMACROLDFLAGS))' \
 		--emit=dep-info=$(depfile) --emit=link=$@ --extern proc_macro \
-		--crate-type proc-macro -L$(objtree)/$(obj) \
+		--crate-type proc-macro -L$(objtree)/$(obj)/host \
 		--crate-name $(patsubst lib%.$(libmacros_extension),%,$(notdir $@)) \
 		@$(objtree)/include/generated/rustc_cfg $<
 
 # Procedural macros can only be used with the `rustc` that compiled it.
-$(obj)/$(libmacros_name): private rustc_target_flags = \
+$(obj)/host/$(libmacros_name): private rustc_target_flags = \
     --extern proc_macro2 --extern quote --extern syn
-$(obj)/$(libmacros_name): $(src)/macros/lib.rs $(obj)/libproc_macro2.rlib \
-    $(obj)/libquote.rlib $(obj)/libsyn.rlib FORCE
+$(obj)/host/$(libmacros_name): $(src)/macros/lib.rs $(obj)/host/libproc_macro2.rlib \
+    $(obj)/host/libquote.rlib $(obj)/host/libsyn.rlib FORCE
 	+$(call if_changed_dep,rustc_procmacro)
 
-$(obj)/$(libpin_init_internal_name): private rustc_target_flags = $(pin_init_internal-flags)
-$(obj)/$(libpin_init_internal_name): $(src)/pin-init/internal/src/lib.rs \
-    $(obj)/libproc_macro2.rlib $(obj)/libquote.rlib $(obj)/libsyn.rlib FORCE
+$(obj)/host/$(libpin_init_internal_name): private rustc_target_flags = $(pin_init_internal-flags)
+$(obj)/host/$(libpin_init_internal_name): $(src)/pin-init/internal/src/lib.rs \
+    $(obj)/host/libproc_macro2.rlib $(obj)/host/libquote.rlib $(obj)/host/libsyn.rlib FORCE
 	+$(call if_changed_dep,rustc_procmacro)
 
 # `rustc` requires `-Zunstable-options` to use custom target specifications
@@ -665,7 +669,7 @@ $(obj)/compiler_builtins.o: $(src)/compiler_builtins.rs $(obj)/core.o FORCE
 $(obj)/pin_init.o: private skip_gendwarfksyms = 1
 $(obj)/pin_init.o: private rustc_target_flags = $(pin_init-flags)
 $(obj)/pin_init.o: $(src)/pin-init/src/lib.rs $(obj)/compiler_builtins.o \
-    $(obj)/$(libpin_init_internal_name) $(obj)/$(libmacros_name) FORCE
+    $(obj)/host/$(libpin_init_internal_name) $(obj)/host/$(libmacros_name) FORCE
 	+$(call if_changed_rule,rustc_library)
 
 # Even if normally `build_error` is not a kernel object, it should still be
@@ -699,7 +703,7 @@ $(obj)/uapi.o: $(src)/uapi/lib.rs \
 $(obj)/kernel.o: private rustc_target_flags = --extern ffi --extern pin_init \
     --extern build_error --extern macros --extern bindings --extern uapi
 $(obj)/kernel.o: $(src)/kernel/lib.rs $(obj)/build_error.o $(obj)/pin_init.o \
-    $(obj)/$(libmacros_name) $(obj)/bindings.o $(obj)/uapi.o FORCE
+    $(obj)/host/$(libmacros_name) $(obj)/bindings.o $(obj)/uapi.o FORCE
 	+$(call if_changed_rule,rustc_library)
 
 ifdef CONFIG_JUMP_LABEL
-- 
2.53.0


