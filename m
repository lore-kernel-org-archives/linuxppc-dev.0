Return-Path: <linuxppc-dev+bounces-20035-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 10B7AFB44B1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 05:48:13 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g227J45wkz2xnl;
	Fri, 24 Apr 2026 15:48:12 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777009692;
	cv=none; b=cu34/bNIxK5TcCzFr8JzerLgnoyIzctBYOdzEi8ItNgq7fteGRLzwR5m8GZp2GLIMi7N+uPsZ/r/zcKzkwxZpH67xPWZICLujM+Ec+KtsiZCCe5M5DgrhqSvphiP9sgVn9RCxV0KJ98+Sj+SnwaTcfPsCtRfywE1YEH/GaQeBwoutHyzalno+S8Ksl68k7Wd4EnjQQ8hXewUvtXr29BEj4cy2sgtihnw55Bk502h268SurgsPvZw79G9P4KvuL2uOqBSVHZvdL3ntXUohoOPEtYIndQ7mOMXGv0/y4HBGu+U9INy9EOplUbBNeamA3p2Rsgib3kxFqALRWmCKf3VXg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777009692; c=relaxed/relaxed;
	bh=avSEhYLX24df+mZ+6wWnK3u2AMb0siNB32CpS+CSjqU=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=jGvmwQTyWbQ9SK5Qg1myJjRQG+oO3UbMyu1fIS/yu6CvZMACR7xes6ObziIMFw6kaTTcUJ3bHrxy1rM0GSgJL6TRtM3Br95JjntmbohzEJfNsOEd3PYCja/k465ypvuoDTmyBWPQx1m2Jg2h7XzZozify7WfK6IfvhdHq/APeMSkf51Y2ZWoksgaFm7Zjz8CpS0vk+l+NAwm0KOA765i0tdRRbUbjDWi2MrbZPLLzH2nM9Ur0/upj1SeyzfgZfRGpwRVpZGV6TTzM4c3pbMLcWeM1glFccwpGMSzSBRqXadrsAI6dw5/fgPSZbxhIvkCQRZZQmDKiM7UHcrlPeq2Fg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FrykrzQM; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=FrykrzQM;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g227H3My4z2xfR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 15:48:11 +1000 (AEST)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2b45cb89f7eso48231835ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 22:48:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009689; x=1777614489; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=avSEhYLX24df+mZ+6wWnK3u2AMb0siNB32CpS+CSjqU=;
        b=FrykrzQM1m4MDLOk0NnQ0K1miKk5W89kJ7rp3UPUFZvt5tIp+XejtvZyGQpy/n4OiO
         Gim4x5DurMjk44ecljdH8ytXDBJh0GvD/Gu+b7QANSf1egZbMDQZW1bJleN6rXcgpIFg
         R3Co7ldEaqbPq2ojpjzm3l3gxtefdArwFytl2uIKpxkWxA5dv4AVJ9wKyh1+5n8KvByb
         qo5ltcB39y97YztFDSaUY12NqoheIVh/LHYBZnoT2NMFC+j5Hg3CRLnn+upyVZlgzCRy
         plEnpr/Hla9uBDcGliELzlARnF/eFcRKiqQiqh575C/dwyXW6SEy0Qy5OANOmfBx+o5S
         lzwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009689; x=1777614489;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=avSEhYLX24df+mZ+6wWnK3u2AMb0siNB32CpS+CSjqU=;
        b=YUPeF66NcsxUrL3t+2zHwzEs+/a7dHYXgf6BPooySyIDAyVptme4hP1NoQlNwNdq7j
         2Xgc/Z+55ntPi4YYmSx3LaJPG+iji/Juni5VD4CrLpZk2UafABtmCF1+7f9ihNAdqMek
         deiMucWKgejLIpigsvQWRZCDUnC0OI2ppE7EGfQPNjIUG3f3hRhRhh+LbdahnZD+x2P3
         wc6qpoiFWedHl0OuBcChFWMLZr5QoD7Ba4lvutbW1uVvpyUNkyLvGTCTUCElgDVlwS6D
         yqqwI12IxldrC5/UG1ONnmg+kReGa5m6M2FtxC47NzIpLaJOQDYzt3q9YhkoSzjKhAqC
         A0tQ==
X-Forwarded-Encrypted: i=1; AFNElJ+1NrAgihZ4sGF257cVHl/vocGzbMXG43b+XQHJ5dN3y8cEsn0bMNURiAeIylajFAX9hLcTEMu6mRiGH0E=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yxu7aVS5zDWMZtk2xyRSkCYBedVEEvfdECQDBoGszZ/R5kguBZ2
	T2kim6cVMaXjze6yd20IGMbznWcM1LUKCj7J9p85bNX3dB/ZCw8SUUxA
X-Gm-Gg: AeBDiesGmfvAKvEb0i785klp/phS8YRZsFuZBjXhj2dqX64F9B7X+6p0hYtKTVMuMKH
	b6YKzqBmdizRgTSXPD58X4v+S8xm636Eh6sYl1kp6B64dRqEkh1BYcAQ9R9sTdQWTuZGVdbliaE
	WAzChdmjmPJ2JbZlp+z8SOEyhiHCQqtQjJKbUiBMUCR6zqNEou+DVPAREYhX3Fi7Fb6nc7jgv2y
	F4ruuaQLUZiXgTG0KSak9hAfKhIAWuspJLc3ub6ak3F0r7zQlAe19OAsBHL1oICsctrelckwh7g
	cawnm+thqC6Vx+Uhb4b3eKw4TR9rAhsuuq/lKxunOYGUIhb/lkBKPjT8824On/blfZ0yS5o3TO8
	+xyJkhwsgAxFmDX1V2fCy0/o+5t8xYC7NhkhLZwG3/2tiJndO4LoR0uPnZVOxIEq8ZL8lDp5kXf
	WNsfoclkXn7OEAXYuqymuvsp+vJCcFg7gOwE8ZMy4nQlTTIYZcVLKieT/Qul9grXd3LGS7WPObJ
	1wqF3CdP1G2xSAOtnlcxpVPng==
X-Received: by 2002:a17:903:3b88:b0:2b2:ec31:25be with SMTP id d9443c01a7336-2b5f9f35acamr294635205ad.24.1777009689388;
        Thu, 23 Apr 2026 22:48:09 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa176e9sm208778245ad.20.2026.04.23.22.47.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:48:09 -0700 (PDT)
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
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
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
	tamird@kernel.org,
	arnd@arndb.de,
	nsc@kernel.org,
	mkchauras@gmail.com,
	simona.vetter@ffwll.ch,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V13 1/7] rust: Fix "multiple candidates for rmeta dependency core" error
Date: Fri, 24 Apr 2026 11:17:36 +0530
Message-ID: <20260424054742.45832-2-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424054742.45832-1-mkchauras@gmail.com>
References: <20260424054742.45832-1-mkchauras@gmail.com>
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
index b361bfedfdf0..2a5428a5503d 100644
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
@@ -520,23 +524,23 @@ quiet_cmd_rustc_procmacrolibrary = $(RUSTC_OR_CLIPPY_QUIET) PL $@
 	$(if $(skip_clippy),$(RUSTC),$(RUSTC_OR_CLIPPY)) \
 		$(filter-out $(skip_flags),$(rust_common_flags) $(rustc_target_flags)) \
 		--emit=dep-info=$(depfile) --emit=link=$@ --crate-type rlib -O \
-		--out-dir $(objtree)/$(obj) -L$(objtree)/$(obj) \
+		--out-dir $(objtree)/$(obj)/host -\L$(objtree)/$(obj)/host \
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
@@ -545,20 +549,20 @@ quiet_cmd_rustc_procmacro = $(RUSTC_OR_CLIPPY_QUIET) P $@
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


