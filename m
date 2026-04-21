Return-Path: <linuxppc-dev+bounces-19885-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 33023F8FA6A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 12:10:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0Lm85C5Dz2yv4;
	Tue, 21 Apr 2026 22:10:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::531"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776773448;
	cv=none; b=LZq2h453VCf5KEsyHH/kZ8UOPAsSmNwc1s2zPVvVAie0ArUr7JxGPPO0VTYzHioJy9YZSVECHjckD8BaaEVwuS0wC3oz1vshpSGZikKzKXv+fsjfA3BHRVyrgxOISA5ddtntaZSAB6hk2B544ZkZbXGH/0NJi1twVHZ+UtnPGyjqFCMa26xegwIIILj7BczGEM+505jBnWHb4ZWk8cYD9YLHPxSAjyz1gL4Ut+EskQq1bXkqJSmDvgi8jr3J+tAqTTAwWdmAPBMA7lCF4y2cIrMiNtVukKLje5oUSXyLXOFVSINA6kFFAafKzSTXvZMWCFUV3eypX9B2JyVU6VojLg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776773448; c=relaxed/relaxed;
	bh=pFBtEobc7yIaM1eVkOtXcJsieQCaSzPZbTXZ7JIsJxk=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=hCefQEniFw1HOA69Mdj3oJNnWOtq9kduQUQPS5SRjaRUbsB4+hw0p9ox5ihg4hz34sWlCiFDDQHnf9Pqy7erXEzxbbzNhDB65Cekdb4/l8fUnEXI8wIdd+UAW6SZCfGH8/bGwRBacuKj3yGLMATkm4dEqGV5PGXBKYY8ucQHGMihT9CT7spQo98geQId74GgNlXkpOavnyB/FORKhkdMI1ZbN2YgFok5fvSTA6ToP5QQadPY0e9D0f2DvUmv1UHWmza6Fx52y0PDcEJKhy8jDxCQDONlYju+hVAPNPX2AENo1kg0ECkCNmgRJUITsUUJdvhvPyp5tRPk0d84ObGwsA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DL5qCsV8; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DL5qCsV8;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::531; helo=mail-pg1-x531.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0Lm80VLYz2ySW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 22:10:47 +1000 (AEST)
Received: by mail-pg1-x531.google.com with SMTP id 41be03b00d2f7-c79467f128cso1505634a12.3
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 05:10:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776773446; x=1777378246; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pFBtEobc7yIaM1eVkOtXcJsieQCaSzPZbTXZ7JIsJxk=;
        b=DL5qCsV8opD6HXxisI/A7cPONmyn4jm/SeQQs4XSdhJfhwRMhTjaQrnM+0gewKDhnk
         RT/QNS/nqiIJCY7k92uofeh3YZ0eS8dYLVInL/Zip50GNxaxEM4dkd+XCserefu3VsPa
         5R/oBt2KSW6WwUnM5inaCts1cTzTS7Wvc/ZrOpidw7s7lfzBNgxMoSuDQz5W1SYocsn2
         iQvHOhIgKZnM4yhSMU85y0WLXtGqEF4KKb/C3lW+yGqzR3KRWOwHeXNF3seGevH5ALgS
         1/VXsXrftOapJ153tK1ubTpVteaXMdFZt79F1lEmLdLXJgjHTTugKgXsFs1nRBinU96z
         bhyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776773446; x=1777378246;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pFBtEobc7yIaM1eVkOtXcJsieQCaSzPZbTXZ7JIsJxk=;
        b=NIplPfpjV89MXQvnMu6EHzSU6vQPujtYyqaI3f5Tis7d4OSxP3re2mlSroWgh6Qr0r
         DZVx8Yxv/RcZaYO+bmLFhi89kPLOQX9MBEXkpNzCa/eg4FnPM/dZ8yXU6rgfAo0+6L9l
         Jywxlext7rTGUo44X0sL0mzSDUVVvtyNS2skdObUnnnFpzHvThfxqvwU80zuYwOzF7T5
         /3D50QlVv4iRiQ8+4gBmpEkF+wzDHGxaZR6bKxJYz3OYZkEY2vxtzXIHfXxFvopug4if
         ahnkYBSqWA53o6NTRayq3A59vp57SYCvFTtrEN2YIWMW5KRaiAbTtXa1NDeVS7R/Kx82
         4DcQ==
X-Forwarded-Encrypted: i=1; AFNElJ96fJ6s5+ll16FQkogzsoNCf3ajITly23t0IC/8/7KEt4ANkXL1yQYSKifr34A/cMUFHdb8FbX68HeVdAY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz4v83QrmqNUXnrpJ7Auz2QQq7B3bBtB81JKN+WIrxiqoaPBcJJ
	4FTflAmUyyYX6ZwmC4ffi4VS1EkEedUX/Ch9Tupb8x2w3ta4AAcGjEeL
X-Gm-Gg: AeBDievp+W2R3lhD92RvT+ds40ZhBl2vOlHYSIpzgZ35Lt6qHZ5NwIvBUJEStnVR1yR
	SOkqCFTAJhfi0Lm8947ivAUNfftdvqqUv9DIfntV6n/4ihxR17hHPBUbPO/HXi2UZw1Jz4kNesu
	ecWKgZgg430kQZ++mPcRcc91Q1ThzVN0jhEQgwn8151QoYTh8Nks8T1Btuc+EYdeYJGbg+K0ZWY
	vEPhF1qJ+vNRPBEgnrxOAIV8BscU0NoWW5LWljrcCovbLeO/4M1G5k9EA9aYScK9DkVeyXZtGPO
	jP8SpFUIkGRVEicXMqvYUs2uPTExUOuXzAB6yVhYKjCDC7IRgfIMkIc0/w0FuPQvpg3JPbz5jW+
	KtbFYeYxVSZ+YeaJ5R3t41hRaCWNMQXVzuWH/4E05HykzQHrFLYGpDbONcfE2z7rO87xhBL9N2c
	iHAs79Y2g6wBlLLCjMtZ744iuXVHpnhtiCXo6wx6MhDX1iUloJG1emrX6BoSaFwuCp2HfAfvBbX
	oIPPxvUGUWNnfwRTSOl50uWwA==
X-Received: by 2002:a05:6a20:918b:b0:3a0:b9d8:966 with SMTP id adf61e73a8af0-3a0b9d83334mr11249808637.55.1776773445911;
        Tue, 21 Apr 2026 05:10:45 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797701d9bfsm10045274a12.16.2026.04.21.05.10.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:10:45 -0700 (PDT)
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
Subject: [PATCH V12 4/4] powerpc: Enable Rust for ppc64le
Date: Tue, 21 Apr 2026 17:39:58 +0530
Message-ID: <20260421120958.190430-5-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260421120958.190430-1-mkchauras@gmail.com>
References: <20260421120958.190430-1-mkchauras@gmail.com>
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
index c90811a2f564..846fe1a45056 100644
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


