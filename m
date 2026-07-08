Return-Path: <linuxppc-dev+bounces-23783-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id BC8DCC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 08:25:28 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwB473Q1Rz2ygX;
	Wed, 08 Jul 2026 18:25:27 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::536"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783499127;
	cv=none; b=ia+NOk8ORzt/KQrEYxADCOAGOuJpZOajBTrSNNsPijyp6qQeimpDsBrzLUPrtfsDfFKdibYTouoocERkD8xmKOL9AwvRetQKp7uToLFbskkT3ld01BofneUCR+ghPvlQ4y2VCv2LbfVDyNACdDgBokB9REMD1DmSp2UirwG4xnU309qaRHM5lMFv7Zd85xrA8WjWAAMqVnIJIxb5P58V5nIIoTD4OIOPZ62KL64ozohNWf4QWglOCCZQwF3Fxi56penBJNX4X9ECVtBdclc2Us99xkVlfFO9qjKWvc0H7ckuvmRqFu2VLvO8b4UA1mu2R16Rx+FcXAZjFJuXbXV7TA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783499127; c=relaxed/relaxed;
	bh=kqHcDJLpqtPG3b1h3n4CGDV6Uky+owIJPUMSqpt6iVU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=CCosFEnaTvkOlLWTbnRzt9BklWFnkftQOvjIWdZAkEeWJ38bdvfFa4y+7oXqkuTOKUZvxQ43tTBxN81krKkdwlg/j0XIjnvCZfoTSjLZ3Nu1pmNPN1J9rqr5G/K5txhMvqT9Sin7o02Bnigci/BgCoOdnSC4k4jljQ1NnS5+/T0HqeNlUI2ra82azC3HE5h8dRNO9PTt30JHWaR0OusCjWNQDpKMIFmR123yUaZdEi+MQdlzOo9ORrpb/vNoApmjF7PZVgQjXR6bruRSmgs9AMmqVCYcAImYW/doQuk7u2cx/UYUHp+h+yi6RwHk4pZLT3qbQHjc8VTS1INYJ56Vlg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hsMyymU/; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hsMyymU/;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::536; helo=mail-pg1-x536.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x536.google.com (mail-pg1-x536.google.com [IPv6:2607:f8b0:4864:20::536])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwB4575k8z308k
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 18:25:25 +1000 (AEST)
Received: by mail-pg1-x536.google.com with SMTP id 41be03b00d2f7-ca2fad0ae38so252288a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 01:25:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783499124; x=1784103924; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=kqHcDJLpqtPG3b1h3n4CGDV6Uky+owIJPUMSqpt6iVU=;
        b=hsMyymU/Wcgt21BA8Nzh4pxepRVg2851FY7SfYlfiGZnzmFhDGLxUrPap8+P4LozMI
         DnWMFF6YffQTw1Z916rGKgPRpbxpd1V3AI4aDpwRMbt8iMqNURfkGIljYg/U060QO4kB
         8fGJ1nVaDJTxmoU4qpvH2sBm0KRel/UyBaCOf3OGhREXNOE3/XtbIdJ90xsNvlovgcI7
         ZwoCALkUzzbXdD787PPYBilXfRTM+UW1y7duNwvOxgJDP75FJ9Ez8v9N/7mLybsJf9zk
         ILKZwEAlwa165oIZVbh2bnIP/8OlA7++HbRR6B16eioj5Ui3KebuOtLh0PEof86eq7vS
         DRMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783499124; x=1784103924;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=kqHcDJLpqtPG3b1h3n4CGDV6Uky+owIJPUMSqpt6iVU=;
        b=Gbnx3vIpg3dH0sziPi9uXP/X0OZJ4KVIrjN5TALChFFDCJX+P+U7ih89H9x6dEH0x2
         jkjvx/pWvUPVsGTG0wq7Fw76OsD1B+eY46NjULwbLdLP/hrxBSHtgjJFLkiyNY347/I2
         4KTN+RUzLmiLGQ+RVu7mM6mmT0afic6INrVQGYZB+aBk0ApC7Z9N3QFh8pb+weJBvXzC
         0dEQRheZmQNymgTWW6uyRobqAKI8nPk1O4Ms4wAAFuS7ZfoTwWnMnefYn3Ls2KO6UG3X
         6kOWZsUk39UKn6LLwMqM9JGSzRTIcr41anpLsK8LtTVNAd/+Aal6EmvNtDjtIw7y2sW6
         8SUA==
X-Forwarded-Encrypted: i=1; AHgh+RqlLK5dUgzOcSjFMNv3blIjjc4gowW4P8+nwe29tLWAOjfXOBS+CBWNf2fZfj/StNYDzFQDC+LresgvBmA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxbFIygdsveA4Nq630F3Mgvn2jivutsXIxj9HjGKDot0EPpH7PY
	wE8qtKuCMHl+3SyZg9wqCshvwCrUHXA4dEa8dorLWqa3G7JknaogcPTc
X-Gm-Gg: AfdE7ckArNjW3py9/2s2V0VDa7JyGodZ8R1jErH1tklelFChCEWWn52OfgftBFlmqJB
	IRLOmqD2GgddkxpMwY7NuhS0mUhUl/fGhMjjZIK8BVyDfCJJksmncXHPunLxzgII0Ejh6seqZga
	yl8i9CSQMWCCAB5+qk6nbgjevG+6w7zbif7jfyCES3quC/xlqLF2+q1K7Te3RGWQybWiQUtqInv
	EX6fwdGqVfM+EFX2AmNs7LDEi6Ti5UeeoERECDHsdXCoFvsVaLT4pqqWOgeobVO8XQX4JHPspKT
	aZp6p4n9Trfijj0jiMNttzcE0ejWOtNAGT1fQTFu7bbM9qmwCFB3uvk1bGw0vjSodxa+m6E0g01
	jsMPfEAx4laGhDVU7DLnkiM1M2/NNiZaLlFIsUK0HZCDEqCbXDy1RcUF41OEgOWXTGMNORlhYys
	EmwjLJovJLdX2AJGKzoF/Gmf6b3UQKuZG1a/4qzpJaNnaIAQioRwn5wawEIUMf93JUBQ==
X-Received: by 2002:a05:6a20:5482:b0:3b3:be1f:c89b with SMTP id adf61e73a8af0-3c0bcff89edmr1826587637.22.1783499123695;
        Wed, 08 Jul 2026 01:25:23 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm19975117eec.0.2026.07.08.01.25.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:25:23 -0700 (PDT)
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
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	fujita.tomonori@gmail.com,
	joelagnelf@nvidia.com,
	gregkh@linuxfoundation.org,
	prafulrai522@gmail.com,
	nsc@kernel.org,
	japo@linux.ibm.com,
	mkchauras@gmail.com,
	lina+kernel@asahilina.net,
	j@jannau.net,
	airlied@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V17 1/7] rust: Fix "multiple candidates for rmeta dependency core" error
Date: Wed,  8 Jul 2026 13:54:48 +0530
Message-ID: <20260708082454.1254320-2-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708082454.1254320-1-mkchauras@gmail.com>
References: <20260708082454.1254320-1-mkchauras@gmail.com>
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
 rust/Makefile | 42 +++++++++++++++++++++++-------------------
 1 file changed, 23 insertions(+), 19 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index a870d1616c71..17b2f329c13d 100644
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
 
@@ -33,7 +36,7 @@ endif
 
 obj-$(CONFIG_RUST) += exports.o
 
-always-$(CONFIG_RUST) += libproc_macro2.rlib libquote.rlib libsyn.rlib
+always-$(CONFIG_RUST) += host/libproc_macro2.rlib host/libquote.rlib host/libsyn.rlib
 
 always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated.rs
 always-$(CONFIG_RUST_KERNEL_DOCTESTS) += doctests_kernel_generated_kunit.c
@@ -163,7 +166,7 @@ quiet_cmd_rustdoc = RUSTDOC $(if $(rustdoc_host),H, ) $<
 	$(rustc_target_envs) \
 	OBJTREE=$(abspath $(objtree)) \
 	$(RUSTDOC) $(filter-out $(skip_flags) --remap-path-scope=%,$(if $(rustdoc_host),$(rust_common_flags),$(rust_flags))) \
-		$(rustc_target_flags) -L$(objtree)/$(obj) \
+		$(rustc_target_flags) -L$(objtree)/$(obj)$(if $(rustdoc_host),/host) \
 		-Zunstable-options --generate-link-to-definition \
 		--output $(rustdoc_output) \
 		--crate-name $(subst rustdoc-,,$@) \
@@ -261,6 +264,7 @@ rustdoc-pin_init_internal: $(src)/pin-init/internal/src/lib.rs \
 
 rustdoc-pin_init: private rustdoc_host = yes
 rustdoc-pin_init: private rustc_target_flags = $(pin_init-flags) \
+    --extern pin_init_internal=$(objtree)/$(obj)/$(libpin_init_internal_name) \
     --extern alloc --cfg feature=\"alloc\"
 rustdoc-pin_init: $(src)/pin-init/src/lib.rs rustdoc-pin_init_internal \
     rustdoc-macros FORCE
@@ -572,23 +576,23 @@ quiet_cmd_rustc_procmacrolibrary = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_Q
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
 
 quiet_cmd_rustc_procmacro = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET)) P $@
@@ -598,26 +602,26 @@ quiet_cmd_rustc_procmacro = $(if $(skip_clippy),RUSTC,$(RUSTC_OR_CLIPPY_QUIET))
 		-Clinker-flavor=gcc -Clinker=$(HOSTCC) \
 		-Clink-args='$(call escsq,$(KBUILD_PROCMACROLDFLAGS))' \
 		--emit=dep-info=$(depfile) --emit=link=$@ --extern proc_macro \
-		--crate-type proc-macro -L$(objtree)/$(obj) \
+		--crate-type proc-macro -L$(objtree)/$(obj)/host \
 		--crate-name $(patsubst lib%.$(procmacro-extension),%,$(notdir $@)) \
 		@$(objtree)/include/generated/rustc_cfg $<
 
 # Procedural macros can only be used with the `rustc` that compiled it.
 $(obj)/$(libzerocopy_derive_name): private skip_clippy = 1
 $(obj)/$(libzerocopy_derive_name): private rustc_target_flags = $(zerocopy_derive-flags)
-$(obj)/$(libzerocopy_derive_name): $(src)/zerocopy-derive/lib.rs $(obj)/libproc_macro2.rlib \
-    $(obj)/libquote.rlib $(obj)/libsyn.rlib FORCE
+$(obj)/$(libzerocopy_derive_name): $(src)/zerocopy-derive/lib.rs $(obj)/host/libproc_macro2.rlib \
+    $(obj)/host/libquote.rlib $(obj)/host/libsyn.rlib FORCE
 	+$(call if_changed_dep,rustc_procmacro)
 
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
2.55.0


