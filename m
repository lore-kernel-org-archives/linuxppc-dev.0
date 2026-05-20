Return-Path: <linuxppc-dev+bounces-21208-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 29973CD4F5E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 06:47:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL2CF60fRz2xnK;
	Wed, 20 May 2026 16:47:05 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1033"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779259625;
	cv=none; b=XBJISSXSl4i/90mspc7le8mcu/w1Q4u9rRVf7rB3bX2o+p8xJ8i066qxH+0paW57aKvDnyt/ALxkcJGMez+G/JfmJeV4nH/eD/oJ31hQJqclMXFmiFwlmAPyL5MoeRfWQPsyD3fJhPWpg9jI9WC+yHWQDEpj5SaeL73vr3gXrscB1zF3I9qc+12ZPocphaE1zt8Am88M42AnN61CPaxxkp9d2DlD+sU6T7PuJvvVeFsV2A3pqcetTjb/ziqVBNMZnfJhjM5MZ8LXGZpCrTxAY4F5g4DwP8CsAxJQ8A3p/HTr9wD2T5LfcvhAiUD+no+NNa86QIcWlgx6+mQHHQu0gQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779259625; c=relaxed/relaxed;
	bh=TU7+XcdePJSecm70VThX1UAzvln9So5XNBiU0U3tbJ8=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=MVouhPdONrfqfSAllhKhOPsWYRuXMsH8KqddTW0JVMpcycmbPX+d++Bq8KHozZzW5nX7ZdCS/C5da5GTflyJCH7g8ZJZRsEqvgdbTMcJMQBKWwb+oLhSIrq2TFUCNT4Fr+B9G6H7pEaxHM8vwkTpW/a7186ScscISn12bu9RTX3v7jzCbRgQsPVEotwqpl/D/7LtXObKrg0B8fyB6PGEkkytwjyHRFCjXGwM0syKOD4GvYa0Z8nZIyOnKuGQnH8OXTPJUpNwXhzH8MEd0Mtg2bcwchMZEPvarIra1TpmIbMCGij1U+e0BeUN2+z26eof952QmS3CXmw9CpzvUHFyQQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NpbrKBm4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=NpbrKBm4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1033; helo=mail-pj1-x1033.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL2CC5SSzz2xPL
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 16:47:03 +1000 (AEST)
Received: by mail-pj1-x1033.google.com with SMTP id 98e67ed59e1d1-36a15ed5119so990856a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 23:47:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779259622; x=1779864422; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=TU7+XcdePJSecm70VThX1UAzvln9So5XNBiU0U3tbJ8=;
        b=NpbrKBm4yTLoIXw7Ns/xgvqUE62NhSOcdqRObi1ReEh4xCm/sSQiHvO+AGIl8L4Ucr
         8M/GDbGxiKfvr2+ia+NDlQCYaT4oEeSWG+k7U9TaK+Bv3UCOuuk1Qt8T0UstPxg9/2Ca
         gku129QpQrXAZlwMQcUXzekdiEFPDjjhmhZOsLh/R48I4GREL5/chkheLS9zTRiK/ZKA
         dlaAdfUJNP+KFBkROcEHmTfilmmo2mQ0dX5oKM1Lys82RsK3IcS6uueQJWZcKI6HmKoR
         FLpHuLDkFznBydBQDyIEV/Mlm1AGQEAizmO7vunlHifJ2Ylwif7Jp6fsGdraDXtiwm0/
         gH6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779259622; x=1779864422;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=TU7+XcdePJSecm70VThX1UAzvln9So5XNBiU0U3tbJ8=;
        b=hoQ2Pa5ys2cnPhVjmXFC0bC77xlZPQdPZrPT9GGnhi319PBhPG4p7Othm13vYc2ZIf
         sI5bMGTe8bNqhYSW1Cuaa8tSxYaWb4S7g17xFHuMrs5sUAQbS2VXoFXpMszi+WuUIeOM
         euA4/zTGyb2eVifdRreU05gSsyB828cVYj13Nic5nol5Bb7DCcqWbRaEeWsxYBZPEYBp
         ug4Mx0fKV/z5Y7hVpMUeN6I04LeW7ugUzZLrEs/EzqV6eOATJdW/zmB7JV0yFaN+5X9T
         abshht7k28N5C55f3dKX6r8DJJi2uxljNCXEZbSQzqeHGfsFWv1vW7/XpoX0wsl6De95
         Yyxw==
X-Forwarded-Encrypted: i=1; AFNElJ/u5qP30KdfLkT/v0dnt2v0UowA3LGoCm7VEk/JJodW76qFDIl6CgUD8wBK+YQHpJwbfW5paFf6hVzfTvs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxGhKjBJCYZysA5VxSpxPRzq+4JM760Z5pAIXfNsDZvjSgv8UWx
	+HjlXFoYlmR7NiohqSha0biHpubjxhnEyoEy2s+3UFCzeA+sagO68w0D
X-Gm-Gg: Acq92OEZ1N3oDpLUbWHyEI+NmrbPtKlxfIm3Bm2y0TRbS+VrmAroYSBAG1UYYHdHmWd
	XJFvUDvR/yTeQdVOD5jOBaZjlrGV2mu0ZQyJUI/7lR/lnAxi9Do4y1ytxhg2adukwbZD9hk1CSF
	2mdFqpEwJ2PoCaa9MfXAxgCDVJtMY5ociEx+e3iPccIAsWoHeDqrCdrG/n7LR0VKEGwgu7HS9lV
	Oh6vbZSWV6Cz8XQy98nDKmwfFqayXN2Dkp2HcrwvvjZIc9ylZuY2l3y3Wf9Q8tAmecM4mxG2bGZ
	6CZTa0n9ABj5h1rcRpd/qBR0HkuaVX6f/LP8k16KCIZbih7nR1R8x7IS2/AO6Zj9v0BUo6fiR8K
	SDdepbGIVW7B6ijj9yNpAOYq+CbnxYQxxCqtTeaYkzI6vLLi9Re5ZwbZUx7+KLRkeLPB1aqFa85
	NO7Sw+oAIyXr+XXRXK+PCaWVA/emPWVUJYKxSPvkGEE71I5vhLHRPun5WWBk6mtMCTcS1j6hZ4u
	OGUBAoHUsaqGAc=
X-Received: by 2002:a17:90b:5904:b0:367:d850:6a5f with SMTP id 98e67ed59e1d1-36951c9f53dmr23341879a91.25.1779259621592;
        Tue, 19 May 2026 23:47:01 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695a0e93e0sm6069970a91.10.2026.05.19.23.46.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 23:47:01 -0700 (PDT)
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
	daniel.almeida@collabora.com,
	acourbot@nvidia.com,
	fujita.tomonori@gmail.com,
	gregkh@linuxfoundation.org,
	prafulrai522@gmail.com,
	tamird@kernel.org,
	kees@kernel.org,
	mkchauras@gmail.com,
	lyude@redhat.com,
	airlied@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V16 1/7] rust: Fix "multiple candidates for rmeta dependency core" error
Date: Wed, 20 May 2026 12:16:23 +0530
Message-ID: <20260520064630.1785283-2-mkchauras@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520064630.1785283-1-mkchauras@gmail.com>
References: <20260520064630.1785283-1-mkchauras@gmail.com>
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

The solution is to separate host libraries into a dedicated rust/host/
subdirectory and use `-L$(objtree)/rust/host` for host builds instead
of `-L$(objtree)/rust`. This ensures that:

1. Host library builds (proc_macro2, quote, syn) only search rust/host/
   and never encounter the kernel's libcore.rmeta
2. Proc macro builds use `-L$(objtree)/rust/host` to find their
   dependencies

Special handling is added for rustdoc-pin_init, which is a host build
(to access the alloc crate) but depends on proc macros from the main
rust/ directory. It uses explicit `--extern` paths to reference the
proc macros without adding `-L$(objtree)/rust`, which would reintroduce
the conflict.

The rust/host/ directory is added to clean-files to ensure it's removed
during `make clean`.

Link: https://github.com/Rust-for-Linux/linux/issues/105
Link: https://github.com/linuxppc/issues/issues/451
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 rust/Makefile | 38 +++++++++++++++++++++-----------------
 1 file changed, 21 insertions(+), 17 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index b9e9f512cec3..6d7ed7a1ff18 100644
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
 
@@ -31,7 +34,7 @@ endif
 
 obj-$(CONFIG_RUST) += exports.o
 
-always-$(CONFIG_RUST) += libproc_macro2.rlib libquote.rlib libsyn.rlib
+always-$(CONFIG_RUST) += host/libproc_macro2.rlib host/libquote.rlib host/libsyn.rlib
 
 always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated.rs
 always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.c
@@ -146,7 +149,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
       cmd_rustdoc = \
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTDOC) $(filter-out $(skip_flags) --remap-path-scope=%,$(if $(rustdoc_host),$(rust_common_flags),$(rust_flags))) \
-		$(rustc_target_flags) -L$(objtree)/$(obj) \
+		$(rustc_target_flags) -L$(objtree)/$(obj)$(if $(rustdoc_host),/host) \
 		-Zunstable-options --generate-link-to-definition \
 		--output $(rustdoc_output) \
 		--crate-name $(subst rustdoc-,,$@) \
@@ -231,6 +234,7 @@ rustdoc-pin_init_internal: $(src)/pin-init/internal/src/lib.rs \
 
 rustdoc-pin_init: private rustdoc_host = yes
 rustdoc-pin_init: private rustc_target_flags = $(pin_init-flags) \
+    --extern pin_init_internal=$(objtree)/$(obj)/$(libpin_init_internal_name) \
     --extern alloc --cfg feature=\"alloc\"
 rustdoc-pin_init: $(src)/pin-init/src/lib.rs rustdoc-pin_init_internal \
     rustdoc-macros FORCE
@@ -522,23 +526,23 @@ quiet_cmd_rustc_procmacrolibrary = $(RUSTC_OR_CLIPPY_QUIET) PL $@
 	$(if $(skip_clippy),$(RUSTC),$(RUSTC_OR_CLIPPY)) \
 		$(filter-out $(skip_flags),$(rust_common_flags) $(rustc_target_flags)) \
 		--emit=dep-info=$(depfile) --emit=link=$@ --crate-type rlib -O \
-		--out-dir $(objtree)/$(obj) -L$(objtree)/$(obj) \
+		--out-dir $(objtree)/$(obj)/host -L$(objtree)/$(obj)/host \
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
@@ -547,20 +551,20 @@ quiet_cmd_rustc_procmacro = $(RUSTC_OR_CLIPPY_QUIET) P $@
 		-Clinker-flavor=gcc -Clinker=$(HOSTCC) \
 		-Clink-args='$(call escsq,$(KBUILD_PROCMACROLDFLAGS))' \
 		--emit=dep-info=$(depfile) --emit=link=$@ --extern proc_macro \
-		--crate-type proc-macro -L$(objtree)/$(obj) \
+		--crate-type proc-macro -L$(objtree)/$(obj)/host \
 		--crate-name $(patsubst lib%.$(libmacros_extension),%,$(notdir $@)) \
 		@$(objtree)/include/generated/rustc_cfg $<
 
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
2.54.0


