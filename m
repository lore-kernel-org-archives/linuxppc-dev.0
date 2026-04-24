Return-Path: <linuxppc-dev+bounces-20040-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 64789FB44A6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 05:49:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g228L0TKrz2ypW;
	Fri, 24 Apr 2026 15:49:06 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777009746;
	cv=none; b=PoEW/gQmjuy0ruZFtF22i+QNs3p2Ovb8xR3nlBEo80j8qRebcZqUR9i4c/x7gobKBB01oPhCbg78Bi2m48Z8+ijwXWDsECtRcQ0LBAytW5ItmpmwfAJgfkhwikbe60VxLJssvfICAiC5Ud84cYdhC/VgrH80waYS/UKJwntMneD4LM0XW8FHMs4uV/UXHxEG5Bv+JODR8NOMRDcrnqEEVaPRRxVR29OqRkAJTsw1GbJARcIP+0IzugIUSaIR8RKlwZJva49ujx4qxTmfUDaJEiiGvGIrj/VBMWdrKhNA05D7Vspc/edMdUcdCyhFFkQ5Q5B1fTcHTa7Cea1AdFj89Q==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777009746; c=relaxed/relaxed;
	bh=begHw2Fh55YIAbwVuxIcFKYuQNkyXTaAo0Peazo3t08=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=TyfDCtiVLMeF3xqRZx2lAxI9lx0xxpIfj9ZHqwj6kvSercXbzFiSUf/sU6aKEtotwRLuOpP+5+xfuYqgR6fEwHGkMYfsMhHGhjjeje+hWrWOf+Ga72VGBneOM4zg444cLN94F2Xlkoh8pd/KMVG2/izJ9ZOyZxTOjuhmKfdjQnsOE2E7tSO2lQzzZaWr3dWY1LrXfW+8isL6nZR3q/Iu3DlXiUZRzr435fHVccdF2Uk4aq2VvX31XdBXKsXLXoph/k6KOHHelOaE+fILT6hKhXB2vFUdz3BUuN+Q5IVbRmfMeGaBr0//OvBzSrB4FlzFTv889p3IiNAcavlfBzYNsg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OpH+FZgA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=OpH+FZgA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g228K2zc7z2xfR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 15:49:05 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-c76c067bc51so2904746a12.0
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 22:49:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009743; x=1777614543; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=begHw2Fh55YIAbwVuxIcFKYuQNkyXTaAo0Peazo3t08=;
        b=OpH+FZgAoe/fEndYJUnVZjFcVY2oMK7MZOl9If9aiImZHvloUCVmobTsTwkUvZNBc4
         ogb6UuZLQ+zbwlhFOKRBVVptwUdNGsxSdflzfkIozw50S3HOMbyhs8TZZWmVppeqWEH4
         omsHJIuXygYgBNtsh2SNwGnajgy9hBtY5JWie9eJJyEbqR5wylXBkvcx1XR7i1Nzu4yb
         r2T8XaKlVJLHbGaaB4UbSZLI1Ri3mzG3HnTIvnQ7X/0TcZnBfH8fv3eY7x5VyLIByW3N
         jiffydE/96MV0hz/ANfk5N74NpGbLYDfMsGdQwcNhZuHv8iennnkSbVUeFfCV8IYk+vI
         M0pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009743; x=1777614543;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=begHw2Fh55YIAbwVuxIcFKYuQNkyXTaAo0Peazo3t08=;
        b=b6tmsVQuL4AxZSrHqdTmrU6WbDMErtJqGMb2mjPNSezMGv85k+hJiGGk7ZrY5NWGsM
         RnVcg7XkAVfmZOrVY7/VwJYvUxT2b07L6KQ0eFSepcX5dSvID/DNGHKW8YkjOXq2nPDN
         D7xk0bZfcC/2/XKH4nNpENofDTpxeVVWEhkKqSHtZa4/dvINKVSBELZ57wO/Jv1do1c0
         TO1HHIrmrfYpMtYOS7ELKRAqDnufQ6m6VqcfB/lUTihBHAu6n1kUr3Dl0Y+FPffwjzVK
         2LfkBVwLEN01e3y9Ua4SRRWS0voZbwTUlAh6/WGevGnQPLjd8CoqOS97YofgR+Ky8NsF
         h0wg==
X-Forwarded-Encrypted: i=1; AFNElJ8uBtzyW7XmXUhSp25NliWDgJjfTKmfN4i4dTY92G1/qRFZAjqj7j+kkmQ8EOXvICh9hV+9hvYqfPLckV0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyP96aet+bkxLKKWAbB16gU8w8jKg/9ZbEdqRE/MyT0tQE4ft4u
	0SV3YjQ0BXZgQxbFD3ttheT7446g2svM2Jh91w6/mmHvbGTZzXjcZxfb
X-Gm-Gg: AeBDiesptc8lGR3nDOXPqEuRDF+b8+o4xIdm+1cE7l6WHmAiKqxy/ZWhVxflxpHpni7
	63V4By/VoPNDlgPrcsaYAE3pDQF1btTJpt/NtlihUKmLqui1sxcFUMuv4QGJHSWNQdv+caBslkd
	A0mP+EszUkyY8MxujQS+GvSRsTvQSsRW18WF33GdhA6cSEUwDfIlqBp8lDgB8zRTDjNTlWgP7LV
	zgUWgGUJM+4zlrXxqifJtoFz8SlsTOPEUQtSXchls3uZiKMKHCPBSEXXep/2KDyPzvE9+GZ7Y5D
	POluu2VPGN9Dtv/eco3LkBuyNOhQdeftO/AQdf0jEBSyqQ71AjFsA2aNOcCrK/shjRNUohA6wZT
	GdOMzikAYAhzEVEyjZg7jv2GvmuljlcHEAGV560DWfrNyGE5iSi9CYM6kqkV9r2lotIwyicKQ9H
	HY52xGj7miCVnAAktQvogAoHwpjq3LLjJoMqHDIE0x51+FgkwF1Rrw7dn5TC1ZAWCi6R9ocyivx
	try80dFbnL16qo=
X-Received: by 2002:a17:903:1a45:b0:2b2:65db:8c5f with SMTP id d9443c01a7336-2b5f9f4f562mr323157805ad.27.1777009743184;
        Thu, 23 Apr 2026 22:49:03 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa176e9sm208778245ad.20.2026.04.23.22.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:49:02 -0700 (PDT)
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
Cc: Link Mauve <linkmauve@linkmauve.fr>
Subject: [PATCH V13 6/7] rust: Add PowerPC support
Date: Fri, 24 Apr 2026 11:17:41 +0530
Message-ID: <20260424054742.45832-7-mkchauras@gmail.com>
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
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

From: Link Mauve <linkmauve@linkmauve.fr>

For now only Big Endian 32-bit PowerPC is supported, as that is the only
hardware I have.  This has been tested on the Nintendo Wii so far, but I
plan on also using it on the GameCube, Wii U and Apple G4.

These changes aren’t the only ones required to get the kernel to compile
and link on PowerPC, libcore will also have to be changed to not use
integer division to format u64, u128 and core::time::Duration, otherwise
__udivdi3() and __umoddi3() will have to be added.  I have tested this
change by replacing the three implementations with unimplemented!() and
it linked just fine.

Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
Link: https://github.com/Rust-for-Linux/linux/issues/105
Link: https://github.com/linuxppc/issues/issues/451
Acked-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/Kconfig  | 1 +
 arch/powerpc/Makefile | 2 ++
 rust/Makefile         | 4 +++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index e93df95b79e7..4ac897b650d4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -285,6 +285,7 @@ config PPC
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RSEQ
+	select HAVE_RUST			if PPC32
 	select HAVE_SAMPLE_FTRACE_DIRECT	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SETUP_PER_CPU_AREA		if PPC64
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a58b1029592c..589613eaa5dc 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -61,6 +61,8 @@ else
 KBUILD_LDFLAGS_MODULE += $(objtree)/arch/powerpc/lib/crtsavres.o
 endif
 
+KBUILD_RUSTFLAGS 	+= --target=powerpc-unknown-linux-gnu
+
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 KBUILD_CPPFLAGS	+= -mlittle-endian
 KBUILD_LDFLAGS	+= -EL
diff --git a/rust/Makefile b/rust/Makefile
index ee11fba7a03d..fd9c1bf026ca 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -400,13 +400,15 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
 	-fstrict-flex-arrays=% -fmin-function-alignment=% \
 	-fzero-init-padding-bits=% -mno-fdpic \
 	-fdiagnostics-show-context -fdiagnostics-show-context=% \
-	--param=% --param asan-% -fno-isolate-erroneous-paths-dereference
+	--param=% --param asan-% -fno-isolate-erroneous-paths-dereference \
+	-ffixed-r2 -mmultiple -mno-readonly-in-sdata
 
 # Derived from `scripts/Makefile.clang`.
 BINDGEN_TARGET_x86	:= x86_64-linux-gnu
 BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
 BINDGEN_TARGET_arm	:= arm-linux-gnueabi
 BINDGEN_TARGET_loongarch	:= loongarch64-linux-gnusf
+BINDGEN_TARGET_powerpc	:= powerpc-linux-gnu
 BINDGEN_TARGET_um	:= $(BINDGEN_TARGET_$(SUBARCH))
 BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
 
-- 
2.53.0


