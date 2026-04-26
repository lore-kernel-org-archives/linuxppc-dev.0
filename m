Return-Path: <linuxppc-dev+bounces-20128-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id D8EB7FF885C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 11:01:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3Nzn48n4z2yl2;
	Sun, 26 Apr 2026 21:01:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777201285;
	cv=none; b=fuBxxcW1mRP8VCBMr6JiDj4JQLjt1BNQtYHppJQT/5HIWM1TKojuPFFStjPVD8hSLWO7TsHha/M3HOYlsI/Edc7WvO8CZyQlmgwfc2XuAiVw0eE3xDHTeiGpG5Jeq4wnOAiXWxyhiPs941GJrSBtkBepuPtV49ulFOLC9kQQGwLvgWsI5P9/9U9Au5FEfconyBiEjFy2z+1GBfTmw98ZDZhZhQx1tVcR1vkZ23mhRitN2DTkEpFDebyo1KMUwf2eXUfrHNQxwAk9YYxFRoJpHtTprW4CqUENeAgUX/ueQWyI6JtxXc3XoDXuIu8WpUTYl6rMccCIEyYvZF7M4dF2zg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777201285; c=relaxed/relaxed;
	bh=nVCy+fRcM1H3k57gN4SHcc3eo5iNGuSvVrAbRBe/Co8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=XdSRIswplBi0s2nhrFiLEgK6jV24IxEJSTTXoY6U19bVbbV1FzUq9c2vPaky/ZyXWsfqIHn/pUUWtbQoih1a2dyzl1Ky9wF2gaVSQvDA4L0aB3D2xn8TK03giUdDWr3Cui1V0Vgnhacm+R6nqZIrc4K4L62loC3cEQyPzE/WoqwuNuTWWBGGx71yrkpeZPh6Lyy1bcEGUKOas9md1h+rOzyFCQ+PWR47M8QGw6VN+sm/WSMHOrrgL4DQM1b/UDYhGpbb+Mp2JWrsuRfxEdt5RDPMF2/n68IbDYkQDj79dP7c6Cy+z5TEBLbZ7BnbztxR8QxlqYVLkEYwz+WmtyIRCg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TJbOynEq; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=TJbOynEq;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62f; helo=mail-pl1-x62f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3Nzm61j7z2yjm
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 21:01:24 +1000 (AEST)
Received: by mail-pl1-x62f.google.com with SMTP id d9443c01a7336-2adff872068so45055205ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 04:01:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777201283; x=1777806083; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nVCy+fRcM1H3k57gN4SHcc3eo5iNGuSvVrAbRBe/Co8=;
        b=TJbOynEqaWXEcTHwxjTs+UdEWR0J2kJn769NbrCRe7U+OJqO9hbXuvjyfQDdrFsWnn
         B49WKe7We8kPYI3nNIGHFjFE+ZSnHylE8Ayxta9NeEZdWKY5xXfMSPfHfRhbLqmcUfaC
         bSJuXFiQR5k0Em/GqWQc5JDPIbzFosAob4RbEfj5kHzvYTiccQKCRwK6A/uVhm4yIVuu
         WXvxGvErIaGbqfoED/7dGX+Af/XxOMiqYwI4/OXaWdr/e4PKd2MSRty0pdMkOp23XEw5
         519EofLzKisqxqU7iglHf3Q7IKdEUq+VEGlcCs9V8OJxq3P82gNE/cmfpxm9QYTUKuXM
         2k1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777201283; x=1777806083;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=nVCy+fRcM1H3k57gN4SHcc3eo5iNGuSvVrAbRBe/Co8=;
        b=KKwloxMxsyZvewTN1YZEecycQpi0/AB8BOTmHQxtkssSxIpjAfN0mtji1Y9a5r0160
         GQj6KkHJrZFYfhna0AqTIwNwSO/CULD70sjOpwah92HQR4R9P9Y+uLvTrLnGM/B3r/wj
         Bg+UPcL53dP+6sQTkMRQAh0pC3Yyrx/iMKow4VyDc2J0yAFdX0yTeu5hEQZQcnlXjvIc
         C1G1sM5aDWa4qsmT1/03dKkiB7iv+Yc8CwJ1ssg7ytGiOPzpbp5zhzkP2k45PzhCVBgv
         T7YSGQiV9AeZ5q9a6Jhm5ayjSKuwErpER7ASTVoxoWcdlBM3r6KXkJ2AP7LJo7I9GlsF
         /9EQ==
X-Forwarded-Encrypted: i=1; AFNElJ9LdrW1qziVCNJOpZotkHss2+AK2PdToKGFhvDmAjIGC3nczN4Li6QdgplEerc6wUg9NZ4YOLLf5T0u3rI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwifgFDilXo1lsOYx0T09ngyfA6qSO6X8QmBp5JAEmj7h05cXZv
	GhAJcFgLiAj9CrkyHq8QaUSUe/2d3ZUz6MRUimzboBa9cLltcFfxt5lh
X-Gm-Gg: AeBDietrIMY3qIQBmf+JWB8zTvrImeLU9okA9KCaZSJ9R5WrxHkQ2e2bBrZpIQXE9bZ
	xkqR9LgTSZJ5SI2srz9HNz9P5qM1gMTb+B8hXi7R+CKlPJOUUbhE9K3rXvoJINDEiGxs5fmrldU
	Qj9894nHBHLyO8vDEugLOxp0eqanEhSwGld+CHrZcA6L+k4zVUjxbenmjIoCidVw8Qt1mtwFaQX
	WIUiDF60GFDGveKmDtr4NtPIepzx5VGwvRlqMUJII4yF9bBKvts14zks920XNbr2cKMepdRGrSP
	b1obvTmbNfiLZLjVgMPBC5P/BAU+4tGTyjwCxmjWwit+jZjg+vI2b1LaS+eEuuLAOpvEUUeZdNo
	mSBgFooVjE7y9Mw16yWKycX/z1oO4wY1v29tz7kIOwsBFkH8/S9/CP9D7d/EYfd5XbMK9Oer/vd
	+UT0gArRlPgQYqwSXVIToiMIitHXhInjSB81oq9NOkyKX0JmaSn7s4cdv9nJb3qUvXDvcOXvP8W
	54xiC2rUecC7tk=
X-Received: by 2002:a17:903:1ac6:b0:2b2:5840:808e with SMTP id d9443c01a7336-2b5f9ee9487mr384368245ad.10.1777201282662;
        Sun, 26 Apr 2026 04:01:22 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa2f129sm256667235ad.29.2026.04.26.04.01.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:01:22 -0700 (PDT)
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
	mark.rutland@arm.com,
	mkchauras@gmail.com,
	lyude@redhat.com,
	lina+kernel@asahilina.net,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH V15 7/7] powerpc: Enable Rust for ppc64le
Date: Sun, 26 Apr 2026 16:29:32 +0530
Message-ID: <20260426105932.2270364-8-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426105932.2270364-1-mkchauras@gmail.com>
References: <20260426105932.2270364-1-mkchauras@gmail.com>
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
Acked-by: Gary Guo <gary@garyguo.net>
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/Kconfig  | 1 +
 arch/powerpc/Makefile | 7 ++++++-
 rust/Makefile         | 6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 4ac897b650d4..2e3065bce9cd 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -286,6 +286,7 @@ config PPC
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
index 54096ce8a675..068b6fc3e0aa 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -408,7 +408,13 @@ BINDGEN_TARGET_x86	:= x86_64-linux-gnu
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


