Return-Path: <linuxppc-dev+bounces-19838-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 92B14F436B7
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2026 15:24:09 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxzF429svz2yvK;
	Sat, 18 Apr 2026 01:24:08 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::42f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776439448;
	cv=none; b=b98xEQYIbTmznNI7+FcFP4ccr/KQEVXlzAlYYizmIz2Lzhf0kIQplFyFi/Jwrrf/ahmZDbC+8NXdxSqZD7VGV+6fhgIX+FdCO160c2lYOEATDGBowTSoFv0d5xhuVx6q5XgikPJz3ro34xTybMBuCFkWHHDtSx48qeCCHx83J/rxhbXzmAq7Hi17vD9ArgA8hAfjJcWkV2tV2D8x+WYWVxUL1YSAwlwkovxUQBdVrgo/vuZJdyQH+wbAMBuwjyT/VX3xwkn/ehtEyaagicrCiOl3DleGpTKrvpCzRDol11rviU2obH7ivvmVfoyZcUJE6FzGwUrTqTfJd2Zsr+Q+7w==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776439448; c=relaxed/relaxed;
	bh=B58d6JHjS7h5Y5vjFZ6dbGJt4nx8a8vTRSygt806S6s=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=DwQsfTQUdLM2cP20h4/hF8qjPFVhNALpjg9mDrjkh+RwCfIL36kFbX4XU3B6cR1rXqVNOastuBxE7bgCztvxRlnrxZyq+Jd6iCPhCdWj7THNXaRTuFNtO2b8w3H7Rep+42eZDKkzrze7zkdnooWwR7Tjv6o++qHqVUIht6/InKceTEKPqJ79EsQTSlfUxnQcbGs37VdoCZr94U6DbJoSubgwPxbJER1h0pFsapFo1kw2nDdkAhoKoOORPUCPiM9l22qPbkjAEufakFzCprujRcBg08W0PQdxp4lriClCr023sqyVAgcN3TmP18WJV9LU4726Vlz6++gm8p1ZDsIN3Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GNs+fjZj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=GNs+fjZj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::42f; helo=mail-pf1-x42f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxzF33xCvz2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2026 01:24:07 +1000 (AEST)
Received: by mail-pf1-x42f.google.com with SMTP id d2e1a72fcca58-82f1f6103afso398104b3a.1
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 08:24:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776439445; x=1777044245; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=B58d6JHjS7h5Y5vjFZ6dbGJt4nx8a8vTRSygt806S6s=;
        b=GNs+fjZj8t7kLVjmrgLZJBjWvosKg6vvFKNoajWVkIgE2jQjlzD0okc4HOl2hqBaRN
         TlGVdx6YDPOywnAXDxNveSpTbE7V7Q0jMvULyLnnpmeB+oQr078k+JzCvV6tjRcepq3f
         Onyclv9eM9to2JA9lRhJ/ByYmM3IGVvbp6XfxjT0ChIDyRMWxRCuu/6Xt+bAL9A2VGR2
         YENurfVgspleeW0kNNzkxj0juR9rIqfZ8vPnV4sMIlqyUcsxUMCNcYlViQeztrlQ6oJV
         cNeEvHY/fr7Z7BpWD+Dr9ak6TyVCC1TIFtBHSWjspBb+i7Dz7Hk5N3TvSCC+6rJ5Q6ry
         P9ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776439445; x=1777044245;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=B58d6JHjS7h5Y5vjFZ6dbGJt4nx8a8vTRSygt806S6s=;
        b=RPWxQRZDzzqyNb+Dd31EnFqkBgn61e6OHtP4JkeQFlS4vxBp89vmgf96tC83u171hm
         NFmeVeEJqV1fthpD5yZpRwt2SmT+/0mIVY+z2eJq4uHhVrTJdlYhGmSWKmuliZoh3HW6
         ZvF2YuZBNp3COxhVNoAkdRsszMdyfUBgF4/kQ4hf9VFIQob0Shj692Jodmkp6NmLtnuk
         D99WUmwIx0UjxTsuBTJhunVXenpcQCRACU3S7mwngyGJGOzyAaeIwBnlwOkd6QgJdTpL
         2yii5jaA+XaX/Gsv1W3LH7X8KuQBx/og6zTSqByT0OE2h/4pXd2KcFSpH6iea0P4BRg7
         s/zg==
X-Forwarded-Encrypted: i=1; AFNElJ87Tlj6eqA8izdB16toXUT+pYWZjakkZlFivYVpQ86vhDNXU4zzrcJjE4W/MwLYAxpectcY5gENJRbLtLA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwTVfByLbMP1wXnzCdpyg+2SKJAmdgqVLhcYnMSuSyDCo6EUEFl
	LKTgXmY+VXOZB+X//NHpltdoeCnS5ie79d9TniXdvOsQRM32f2DiGJo4
X-Gm-Gg: AeBDiev5ac4/RUjU3uMzozWeciHb5EJsGeoblPt4fpNarIdRBdAZAN9Z4k3oDMuuv9Y
	aRHQuBjyKfeHHHKCDPoIP7TICk/bOb5pUjSQsMA4ihz5aJnPJu/FdeIwq9+Ux4N4NqveeseUWg0
	xsVZ0+2yHvGmaGpAltrzGpIu3k3aBzl+aQv4RL0qdocXzVbo9glhTzf9dTdtIRduiieSfNb/adp
	m9uV0a+eFAL5HLOOnvxm5Vk6bvJ3M1dASWHuGoRwsqhLU09FgHozTeTovVbtFt20H2Ypj/XUb99
	rRpAjQLwqNJgd7StbDu317yMXMNCuDT9l2KNPq5iiiEIDlFqZP5HPdVezBkgG92y1DuELX2B1LM
	WmZ3E3yObYCr9up/PgPyPMknWpSZt6n9jymPln8o56dQ6ufmY59JThd7urz1hqU99PPtOGbfR74
	J9edmNK8DNRFBT+rtxWwrWCamlZA8z3hl+xnEWa7mxhvRPRafodZ4xZ5Cc8iKQszG8bBET0G5bA
	nQL2kwH+Xk/e/tADiJ/ZPwBsw==
X-Received: by 2002:a05:6a00:984:b0:82f:6cd5:1ead with SMTP id d2e1a72fcca58-82f8c86b573mr3320740b3a.16.1776439445297;
        Fri, 17 Apr 2026 08:24:05 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb3829sm2384373b3a.31.2026.04.17.08.23.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 08:24:05 -0700 (PDT)
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
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
	Link Mauve <linkmauve@linkmauve.fr>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH V11 4/4] powerpc: Enable Rust for ppc64le
Date: Fri, 17 Apr 2026 20:52:53 +0530
Message-ID: <20260417152253.2312961-5-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417152253.2312961-1-mkchauras@gmail.com>
References: <20260417152253.2312961-1-mkchauras@gmail.com>
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

Enabling rust support for ppc64le.

Tested on pseries Power11:
╰─❯ dmesg | grep rust
[    0.225728] Initialise system trusted keyrings
[    0.270961] rust_minimal: Rust minimal sample (init)
[    0.270968] rust_minimal: Am I built-in? true
[    0.270974] rust_minimal: test_parameter: 1
[    0.270983] rust_misc_device: Initialising Rust Misc Device Sample
[    0.271012] rust_print: Rust printing macros sample (init)
[    0.271019] rust_print: Emergency message (level 0) without args
[    0.271023] rust_print: Alert message (level 1) without args
[    0.271026] rust_print: Critical message (level 2) without args
[    0.271030] rust_print: Error message (level 3) without args
[    0.271033] rust_print: Warning message (level 4) without args
[    0.271037] rust_print: Notice message (level 5) without args
[    0.271040] rust_print: Info message (level 6) without args
[    0.271043] rust_print: A line that is continued without args
[    0.271054] rust_print: Emergency message (level 0) with args
[    0.271064] rust_print: Alert message (level 1) with args
[    0.271072] rust_print: Critical message (level 2) with args
[    0.271077] rust_print: Error message (level 3) with args
[    0.271083] rust_print: Warning message (level 4) with args
[    0.271091] rust_print: Notice message (level 5) with args
[    0.271097] rust_print: Info message (level 6) with args
[    0.271102] rust_print: A line that is continued with args
[    0.271110] rust_print: 1
[    0.271113] rust_print: "hello, world"
[    0.271121] rust_print: [samples/rust/rust_print_main.rs:35:5] c = "hello, world"
[    0.271129] rust_print: Arc<dyn Display> says 42
[    0.271130] rust_print: Arc<dyn Display> says hello, world
[    0.271136] rust_print: "hello, world"
[    0.271198] usbcore: registered new interface driver rust_driver_usb
[    0.271207] rust_faux_driver: Initialising Rust Faux Device Sample
[    0.271227] faux_driver rust-faux-sample-device: Hello from faux device!
[    0.271297] rust_configfs: Rust configfs sample (init)

Reviewed-by: Link Mauve <linkmauve@linkmauve.fr>
Tested-by: Link Mauve <linkmauve@linkmauve.fr>
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Link: https://github.com/Rust-for-Linux/linux/issues/105
Link: https://github.com/linuxppc/issues/issues/451
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/Kconfig  | 1 +
 arch/powerpc/Makefile | 7 ++++++-
 rust/Makefile         | 6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 1246b3add8ff..a5f50434daf3 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -285,6 +285,7 @@ config PPC
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RSEQ
 	select HAVE_RUST			if PPC32
+	select HAVE_RUST			if PPC64 && CPU_LITTLE_ENDIAN
 	select HAVE_SAMPLE_FTRACE_DIRECT	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SETUP_PER_CPU_AREA		if PPC64
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index 589613eaa5dc..9385db478c59 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -61,7 +61,12 @@ else
 KBUILD_LDFLAGS_MODULE += $(objtree)/arch/powerpc/lib/crtsavres.o
 endif
 
-KBUILD_RUSTFLAGS 	+= --target=powerpc-unknown-linux-gnu
+ifdef CONFIG_PPC64
+KBUILD_RUSTFLAGS	+= --target=powerpc64le-unknown-linux-gnu
+KBUILD_RUSTFLAGS	+= -Ctarget-feature=-mma,-vsx,-hard-float,-altivec
+else
+KBUILD_RUSTFLAGS	+= --target=powerpc-unknown-linux-gnu
+endif
 
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 KBUILD_CPPFLAGS	+= -mlittle-endian
diff --git a/rust/Makefile b/rust/Makefile
index af0c8ab2e5b6..99537c2c55ee 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -414,7 +414,13 @@ BINDGEN_TARGET_x86	:= x86_64-linux-gnu
 BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
 BINDGEN_TARGET_arm	:= arm-linux-gnueabi
 BINDGEN_TARGET_loongarch	:= loongarch64-linux-gnusf
+
+ifdef CONFIG_PPC64
+BINDGEN_TARGET_powerpc	:= powerpc64le-linux-gnu
+else
 BINDGEN_TARGET_powerpc	:= powerpc-linux-gnu
+endif
+
 BINDGEN_TARGET_um	:= $(BINDGEN_TARGET_$(SUBARCH))
 BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
 
-- 
2.53.0


