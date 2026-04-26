Return-Path: <linuxppc-dev+bounces-20106-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 59C9BFF885D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 08:57:59 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3LFK4pjQz2ySC;
	Sun, 26 Apr 2026 18:57:57 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777193877;
	cv=none; b=ZjvnO/5CL/zzp8WEiCno+1Wll/XoV0b/zXp9FdnUHzadW5q3DekaLIHM+lQq9xUndf2JM9cwlKk9EKEsjBVBL7DkKm4r4lirQGRY835c7Vnm2YDA18/MbLF9xldZgPmCzOxekKNTpcaYvXFuyZuxkt93/85tdBD0XclRHBRqaD0cOqEMS2VAjaq+ja+7XMD7kHfz3z7QsakBMNzxvt403Wmt6o4v77Qc7WJDbOF7P9pUN17CytaTSngn6FZkri3bEA7BJYhFoTe+fbsC0zREYcbY9s7O2r29rEghMBEozynct4A1/8xDjxzEityx1xvYnS37ao/hvsrFwYpDvslQEg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777193877; c=relaxed/relaxed;
	bh=lfZP0MeIzoN1hcZODtTG+ASkU3LzXr/UqOo4EQPgGgw=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SzHJgt6klrZNDTqFQQ4KwVTNwxFxCcvm9l4DWXcPcmUjxImpsuYBnZ75Lu6eypHQRFuPf9rKP96TDvQaUmcUo6Luvn/GEEuyUDIEZSXKhFVvAX8jZpVVzI4V+Fu6Fxz2GGFIplmcRpLzKv2A/9s4yz4TKclD/8MaDhYA/8w6EvOMyvhuTR/ZUdeJOLl7FpWnoaog/rj8w/aTA4BHqvDtxLDI2Cs1xjrba5ZkcOCF9Va4T20YrSRJsdCbVe2jJS9Cy8vcOewNmc6JOyY83cPQHR3dIET6iI97NbNliTABJrjbRQFa/ZkZ/qVxO1X8x+kinebwj6DLKA3aEHf/IiMZaA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MeA42JkK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=MeA42JkK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3LFJ46Dsz2yFl
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 18:57:56 +1000 (AEST)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-35fb0bb27e7so6010477a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 01:57:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777193874; x=1777798674; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=lfZP0MeIzoN1hcZODtTG+ASkU3LzXr/UqOo4EQPgGgw=;
        b=MeA42JkKf7RxguWxDm9mHgBY2h14AnmHlG/P6+10Kb7OQWcoKKr4kafT7JQ8Y0dqsq
         TBXnlfbT5gzOgz6jIllBsG4lpvJNKzHgwWpm0L/nmJ5QrkY64mQTdhifmpSlvsOdea++
         WzDCRgIuQYq/mHEDwpTDk348G/huDxdNWxY2lt1lgURU/DW1pJnbWTUJ+VNDXSPioLLb
         TcN051ah/STbbxG8+F1Q4+yebzI09GpnTJK/aACfW3V1f2R9NokptpZbkuN+lQQSOuHg
         ouS4PqmhnWJuQnpLMVnym/VKdeXs2sOAawP7Nbyuthutke8aoYsoN+NInsHdRD1+QlJ0
         OpVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777193874; x=1777798674;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=lfZP0MeIzoN1hcZODtTG+ASkU3LzXr/UqOo4EQPgGgw=;
        b=tGB9DopnKbwgXiL2ZFe8hRWQVKehf3QnDLy0Mmti0d2cuLWiBTkoiFzfdMWJJEUzeJ
         uuSFcYW+XQQJsZKwhYZRQLjPUXexNudecPnW6rkalnevWmqG9QlqxCWwEA1t7Y4f9uJ0
         FqKGENIkDws/el3/kuOnTBZtn0Nd1x5p2ZDtzDFUXEGOhOKMhnQFKVnpPatN47+uE7e5
         0vnPah31Rx1lzklmqK50XkTSIvcUBabXVY2JbPJNiQOII9P6ODuGUe7uFbn3S9X8QhoQ
         IbuwgY9GMEO/Hib3Xmt83U5d+x7gZnzvB8S3GPEjPZKGVtopwvv9NGqumQLziQ+ot2sE
         AMGg==
X-Forwarded-Encrypted: i=1; AFNElJ/2i4uZG1VmiVoTXdaHL2oS+bIPf2D0VoqDjkUkq9t1QpGe4hzxiUDf+qwMOLCqEk70qTHKXwzKu5vadjU=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy80s5sDalLxh1XQHsRW49i8yFi3GgEOY9Pi8GY+SKtUTYxBpUY
	2WKO2KwO5Ecrb43vFOnx2FU15YjAe6XgdutkZm2rUsxpBLzVEFRFdVWp
X-Gm-Gg: AeBDievdKMWvpu7gY11m21tqCCzq4fVv3zh5hku1MKy/u9y3M43Woqz3lZdrDHUIHn3
	480Fl8BXFJM0PJd37uSbMNdnF9Fs0kVo/DU18jqsgm2rP74H4/zkOuPI6+NQfBBZelzcm3bLa8a
	urXWMMO0ULTGQYFoBVPYAViJj0qNGmX0N04JbxAWJFpwoUqOunk+xv8RszZMkHVHA1meSC/T/7E
	EegW9eaufsfQi0wAWJ2reT0XAJgvdL0mMZrYHLIDFItc0SEK8V4jy0uLWmR879yQZ3ZnSa/OaMy
	AZHog8pl4WhchNY4RzVuud5mEie9OVeCcrytX+mv1pbsKBiauoLWWSI5zsp7RLy7MINz0BgqAsL
	jPvdZj8ZMC/tHXc3O2PBLIQTmZsP8uJKdqTNGrTtfHc0mmHqo7xWtbKyBY2ZPAu/LkBAgmnoBXN
	NQdkp+H3bA6AZAoyEg4Ooshl8ODg6seNs5tQK7vyFTdINLs8F/4pOLgMaqOzhLaNdmL77LYIjBI
	gyjNgc7viIvxp8=
X-Received: by 2002:a17:90a:fc45:b0:35f:be11:b3e0 with SMTP id 98e67ed59e1d1-361403cd032mr37798355a91.2.1777193874362;
        Sun, 26 Apr 2026 01:57:54 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141868906sm27718937a91.3.2026.04.26.01.57.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 01:57:54 -0700 (PDT)
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
	fujita.tomonori@gmail.com,
	viresh.kumar@linaro.org,
	prafulrai522@gmail.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	tamird@kernel.org,
	mkchauras@gmail.com,
	lyude@redhat.com,
	airlied@gmail.com,
	j@jannau.net,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V14 1/7] rust: Fix "multiple candidates for rmeta dependency core" error
Date: Sun, 26 Apr 2026 14:27:19 +0530
Message-ID: <20260426085725.2090827-2-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426085725.2090827-1-mkchauras@gmail.com>
References: <20260426085725.2090827-1-mkchauras@gmail.com>
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
 rust/Makefile | 39 +++++++++++++++++++++------------------
 1 file changed, 21 insertions(+), 18 deletions(-)

diff --git a/rust/Makefile b/rust/Makefile
index b361bfedfdf0..f6369d121c50 100644
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
@@ -231,7 +234,7 @@ rustdoc-pin_init_internal: $(src)/pin-init/internal/src/lib.rs \
 
 rustdoc-pin_init: private rustdoc_host = yes
 rustdoc-pin_init: private rustc_target_flags = $(pin_init-flags) \
-    --extern alloc --cfg feature=\"alloc\"
+    -L$(objtree)/$(obj) --extern alloc --cfg feature=\"alloc\"
 rustdoc-pin_init: $(src)/pin-init/src/lib.rs rustdoc-pin_init_internal \
     rustdoc-macros FORCE
 	+$(call if_changed,rustdoc)
@@ -520,23 +523,23 @@ quiet_cmd_rustc_procmacrolibrary = $(RUSTC_OR_CLIPPY_QUIET) PL $@
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
@@ -545,20 +548,20 @@ quiet_cmd_rustc_procmacro = $(RUSTC_OR_CLIPPY_QUIET) P $@
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
2.53.0


