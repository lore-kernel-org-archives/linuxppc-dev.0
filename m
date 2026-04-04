Return-Path: <linuxppc-dev+bounces-19313-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 19090E88D80
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 12:17:10 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnvjJ3LSvz2ynC;
	Sat, 04 Apr 2026 23:17:08 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775305028;
	cv=none; b=S2MuzJwPICIqyCpgbxESTn217zrMSL6xCIFJu57bD1+iaiIygVPySGV5YKzDMtkt8KwZKNMA7ugEBef9bEyPwdRJEVMRqfdKWbt84LyE9zA01V9dqWiGQkL4RbAIcexQiTIuYUDYsd6jRZ2azlb+et3Kv9kThFJU0myMnEIUD6ELA5/AqvMIFaxv+M+CTWJVsrGbmuIEwEVF4XSQ9oDKnML8s76/bP3xvmWvovkXPugvm25LxYPFkk9Z8+54mHEIwQJTc/YmxnnWL6T4TVqTtuEyTNDJ6pW5HtSK259tFCty20lP74SCa9ZzUXw2mC+ngLVrYdN0kjI3is+K5suwgw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775305028; c=relaxed/relaxed;
	bh=PlujDU3RFaKkdVl6Jrm/784UPIvYVhHJ3sm/SZ244fs=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=F7zhWejn8rrS24/wdintyAe64x3AlHkKexqS/QiNh1tx6dFVtP5I8hld6Tm+yW6looqHPJCwrB9e+rUa2AcEG4IgqOdXUXTkog3vPVqvMiWqOWjon7r8tThJMbHZgQxM0ZY0usAIynxAka95WBWH2JzwMUdZYJsqPG6bxmPJHhNTx1kIOekjUkzIsCHIH9o2CqopS0u9G6lKNJIIDniORYAhbKky1RZ5Nx6IWBmzk5tYq4E8x4ewrR1deEOY2u9qVgw6MIXI3fdZT87d3EuoQ/6C7ZLhg7ENu7p5VpeP523FKZEcysdwCZypJXcJfIn6mg3PttdqDpgsDg48/vnrAw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EL2cWirU; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=EL2cWirU;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnvjH56FNz2ygd
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 23:17:07 +1100 (AEDT)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-35d9c7bf9a1so2308667a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 05:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775305026; x=1775909826; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=PlujDU3RFaKkdVl6Jrm/784UPIvYVhHJ3sm/SZ244fs=;
        b=EL2cWirUTYJPowayAaeI53fhRu5u+zLvfwh/+x6PgeDPn8zQEXDz+HBJw1kNUdotp4
         KQ4pPnjKE9hIoqwdb5HliscWHj4vpmyK79OtmOA8/KrVDDlUIZPOPZrd9cMzKbE1vACY
         SX9CjlArNKTq50PPEKu6NumqkfK3JzouY2Bf96vA5Sz82eSuI3/tuytZyyOhdkFzmKe2
         emMBZBpODBWk71GtwbnLJzDjSP6cQ9DgNUwmfK88huaMfP+dMyFqnKnRn9mOgEC6IhHo
         SNYiNLSXTY6X9n91Amcf++BnwUdO8Fnj8OsNLWL0kj+ATLjpuoghYSNdaMvq96wRI5+T
         m3xQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775305026; x=1775909826;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=PlujDU3RFaKkdVl6Jrm/784UPIvYVhHJ3sm/SZ244fs=;
        b=cd1Z6Cc+HQCncLGXzkOQwVuqAtOb/NCSN7SRDsebwWZlle3GVER1tnQ+KJOAe4p40m
         RayrlhEARJWRDoYXbvLV2T1uAxiYjmELdJ20L+b3i4src8xS31HWYurpC9su17ADJ1E1
         e7Wovfn479b5CdwgIlrauEYfyge9xPNJkUB29ymALHzwJsXhX7Mo3N/u8pbReCvNLq9G
         7KOxqJDSB84BnLy40JwbTGQ6MgwSrgiGLVKyjIDTMweCeTqTkSPbcK5bAIuFeRh88rXy
         GYMPCm+Ediqv++xgZA7Md7pKQ3YXQBEfCHY22IGWlWRTPR9lLfuYPyIlefSUtf/IRPqB
         OEQw==
X-Forwarded-Encrypted: i=1; AJvYcCVj/gzztpf+GPThYztGNFyVl1EFJ7KHkV5dOCuiX62JYZRveymoBG1uXFY9nuwNs4M3xHi5RZHa0qux+f8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwDfxx4oBExek6ZR5kktQ+qF4fFoQ/E4U7q+DFxJIPgPAXIuEc/
	iGrHbR14mwNIU5tCoZvWF6br4AKe+8BUo/BmUqaaVQHx9nHxDaM6gKF0
X-Gm-Gg: AeBDievA6K9EdBsJT/cnwVI0URg86oJLZMFGXyCDIORwBmzYsQKkHv1KVFA6ExjO15E
	htx8fqUPXUdxW0c06iOtdgzLXf3v9Lj8oYeYFNf1vd889Y5BnvPm90CDiooXQs+mWlyIKnvggbf
	U1ScyJWF0Luo4MfeYtn6Qqdgi7khc830FjxySNHQiAfiaRFMi+5WJspgauCTejYkIoSAUjWn0rG
	gWjNc1bfcg+waeDGcy8/nrffsOzq5d89Y7+rjkB5nVVRHUwxjPDuw1Qx6RE1Z+U9lH66HMzWaej
	/GYrH7rQlCo+GnL31wNw+Wh7CKk0hvdILWWJkiS3AyLexxU6WpBY2SWrj3AeY6eVZWFfrtDWRKH
	UOro6VCU+HiNHimruKVnboHFO+v1G8N4v+0isHPutIBU3fq2HGsx4ctGiimzJBG9c0w/B+XwL7t
	CYfsS6fI5o5l49QThLGeEYOVFEcvAN4ISnFFwiHezzV8B3s3po6rWr2oQk1PqIzKzdAflAMSzyo
	f4=
X-Received: by 2002:a17:90b:4fc4:b0:359:f22:8879 with SMTP id 98e67ed59e1d1-35de691c094mr5252459a91.22.1775305025722;
        Sat, 04 Apr 2026 05:17:05 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de500c42fsm2702745a91.0.2026.04.04.05.16.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 05:17:05 -0700 (PDT)
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
Subject: [PATCH V9 4/4] powerpc: Enable Rust for ppc64le
Date: Sat,  4 Apr 2026 17:46:10 +0530
Message-ID: <20260404121610.1956528-5-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404121610.1956528-1-mkchauras@gmail.com>
References: <20260404121610.1956528-1-mkchauras@gmail.com>
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
index 04d8a849c6e4..92c1f6fe69e9 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -418,7 +418,13 @@ BINDGEN_TARGET_x86	:= x86_64-linux-gnu
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


