Return-Path: <linuxppc-dev+bounces-19277-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 453A4E85373
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 14:54:07 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnMDs6r7hz2yjs;
	Sat, 04 Apr 2026 01:54:05 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::529"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775228045;
	cv=none; b=Z3WKPn2sYn9TgtA6+fpkU1lAc5pQefq6nV6rKsKjfM8WQp7PqhAYaah2eQvmvIn9qDF4XmKBMM/Nz240lZc4yIJ9M7jjXeFR5r7NhPy69wA8cF4QB2wGle89ZI59irzFEHZoLZPAgP3In+Uq1zeLvfGl6NPI9FrhDm+FmNwUWyi6R8FVfRjOLLFdZe3Ge789QAwXk4rU9MFdV/0FuHx7qCjVXdGllwFG91vNdWDgnD3QgTbMI586azwzJjLWAeb7tNtNevBf2FtLhkUVzreFsDhZ6q9wB8/MVCNpk9Mzf9pXwgwaHifAbgyCs9f2NCYfjXzbAq9hfkvmiDtEHM4yjQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775228045; c=relaxed/relaxed;
	bh=L5MnNEuF4jTrufZ1xjxpgz9Hp8B6c1d2sPYeGOGoVeo=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=h9rIu3ThiNFO9/HAY175iZwMgptwR3MH0bnAPW9JHR/C3KJ+8++0pzLvIMlgSdrA9Y0+/5sp+ypdbq7W2g3pU9LzdefOGd/Yd6uVBI/TMPHvvMy6598bjEkKgNqu461c/zVmrjt/qrzt1Xnr5zSBo53zUM6j+ai/Ukd8YUY3sQc//MqPTNwG4DM/3y0nr7HYDVA9DQk4hmtYOffJehngCJVv8utT3tlWZygoNcalxK9a57K/QpO41R1aJW750cKS8xGHvH/hWBOh9AyJpeD9LdiynWA4nvV0Oq5sKgDVyrtBrczk5WB1FquyeclwhGcLsR0tZcKhX46FBYeguDTwng==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i5BJFxMv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=i5BJFxMv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::529; helo=mail-pg1-x529.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnMDs2BlQz2yWK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 01:54:05 +1100 (AEDT)
Received: by mail-pg1-x529.google.com with SMTP id 41be03b00d2f7-c74244dc0b3so1167310a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 07:54:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775228042; x=1775832842; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=L5MnNEuF4jTrufZ1xjxpgz9Hp8B6c1d2sPYeGOGoVeo=;
        b=i5BJFxMvdShserkezPnZdz7hG6NdyKK8ix9hZ8lWxHyt8KZlmx0/5AA/TzyjPv+XXT
         /fmUgYE08JMOp+ppo79EHUG0OOfueD6tcogmKuB5UbbFqoNvUxjo0k59ymsCaXOlKaTR
         nJ6d8WC072wO64RyM0z1xpEV9Tcijq+QeWgAUyLHtGFRdtoJMXM0lGDT3314eTEahDTz
         EwehXOz3CeHVnmCbwg37rHtYfLCqvDIiARx0EvGTT5l9xtE1pikSzDZGb833BV+948HL
         K9QqPb8euhtw0jAenDahZNRTzXa26vQi5TRNM0sNZggFI8tL5Smf6DVNOqJbrH7jJE2g
         LWmA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228042; x=1775832842;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=L5MnNEuF4jTrufZ1xjxpgz9Hp8B6c1d2sPYeGOGoVeo=;
        b=TuuWC4vQum56PHNvGCINfMP8cw39Q7DFmT9C1kWe9X1QH4mbQAGcRHfci25bVkRUmh
         DOwL8p5A2pRf1SRrqA8jU1oncQIAwHrYtCS8iushRCg3Y8BWWZWriKOk9nCyjW7NsH1j
         sMNLWFAyhjCLwkN7GTz5OyUJWonhwUL4Q2pkUJTCzDuZvPkjAYPXuaH0KyttbUXfPbHU
         ZKpRyA0wL+wjri2HeEU2qhsg2LVDv+cER/M+j1kI92uD3AYlxBuyi+l7+cX+a+5ZF3Rg
         PcKRwQsuufBqf0Gy//3ZVQgTgBAOTfSkoNB3JvF74k77wdsAFELJw6hXJ/ZV3J73lfZO
         1kgg==
X-Forwarded-Encrypted: i=1; AJvYcCXZ9nRD2O1hQjO8NrsNkd8DnMkf5RCv6XSGiYyhTLGYYzwkJXc2vovuq3NnlvAA/5mD2/6JhAHBmlsQKGM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxZmmtexH9o9UL8gYZiyLGLds6bz5s1YeoiWWYWrfyY/N60poYP
	zaRQzlI15IGHLh3PweQODnKtTCr7f2LG4NS3wbRAd8a5YL02y8VxrpzO
X-Gm-Gg: ATEYQzzV789d+vdUmXxoBAf3dU77wkOhv2VyWMTQSTioFJCJD4TredYL2rzY6OCjf1M
	HlhW5iLnGeFwrYjB18tdt/4lVCJkotJ4zcIa8trHQjdpcLg1z2IlGvVbH/K5lo4DCx+4OOy/seC
	ImNlz310yRY6DdMVnYpUZL5dCVCb+4g+/PkMbLtYS+VatQR7+vg8Rcp7ZJ6SBY7WUlHUuD1X7qr
	knpBF0Gqbol+JjDB4jLK2DFaXQqdCExjpBkbQ/VK2SFQC/as5J80ozRTThXXrC6KVfjQzVJzhtx
	2RigMA9IRMM/jceolvLHZYzephBnOFs5SkBqhrx2KKtZ8xfHGYq+82CuSeM5B1E4Q460X+VPjq6
	Fusd+fMdoS/VFqOy5O8TTA2nqIOErb4i+eILe5gOs7JEhO48LtEhOnTqOLKvDJSLY64El2JP0+s
	LU6y4pkxrJ7CzhDYr6EfrrpYEzApPYTPCEvq05/GRcgvdzWMWn233zJl/mW3R/45ziI+bJIVT43
	L8=
X-Received: by 2002:a05:6a20:12cd:b0:398:a1ca:7a2a with SMTP id adf61e73a8af0-39f2f0ff7d9mr3381106637.48.1775228042226;
        Fri, 03 Apr 2026 07:54:02 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca4efesm6301682b3a.61.2026.04.03.07.53.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:54:01 -0700 (PDT)
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
Subject: [PATCH V8 4/4] powerpc: Enable Rust for ppc64le
Date: Fri,  3 Apr 2026 20:23:08 +0530
Message-ID: <20260403145308.1042622-5-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403145308.1042622-1-mkchauras@gmail.com>
References: <20260403145308.1042622-1-mkchauras@gmail.com>
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
index d05e76df15a8..321b7d0e15c7 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -421,7 +421,13 @@ BINDGEN_TARGET_x86	:= x86_64-linux-gnu
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


