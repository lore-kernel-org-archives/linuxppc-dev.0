Return-Path: <linuxppc-dev+bounces-20041-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3DA7BFB44B1
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 05:49:18 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g228X6jTQz2yqP;
	Fri, 24 Apr 2026 15:49:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1029"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777009756;
	cv=none; b=TDpNaCpWI4XvO5Sjq2GtvFdbnh0PTBbpPJJ4DeS6GcuQY0QYdkW22S40B+gxnNb/KLoUHlb06fPUnTNvCW+w9MYkAx0T6yhnqVQcNhYpC21+zicwu1RKaO3o9npUlxgwHTj9o8TeuL8V1oCyPvx7phRlcz7fYMAMDvPhnjUatsfAJQSlxgogCs6AuK8cA3cGQWnHhvJ/oqJkp8CXOfIXbV8Pb4BFexMRucpzpYV/rTk01yCkPBBfGt27DKokxVFQbivOnzeqyUKThs0r/6i7Mgb4NowdLcS3ekeWvDyXTGRGTjnvegxvh2X4L/ZWkDLOlxJV5zRnxD4ALtkKaM74aw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777009756; c=relaxed/relaxed;
	bh=RoXnYHhu5OJq+pQQ/T7jeG1ntNKoLYxlZRpY7d5kjto=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=nmFTel6wqzUEtaimAWZZAX18hIo1rBdN9Ezv7cP3DG6YtSKY50rdctIe2AAJ9m5wYFdYuks8ekpBJkKLrC5Ha64g7JVM/JzXlvxWuZ/f1+oXYk7EehpfSlI+ntFQ4ms1mhnJkDKYYdzqIrzvgu87zf9CbXEe8HAsum+OpPthX9j8FZXnSVHUc0RuIB2WIVxwrv2kY6v/xuUDLpLF8Kcf5RMkUrC5rPF9yNG43phiurAr1Ds1uyXm02XGCeeMEpbaA+FgfTqMEq7i6gtq4rI1g6M+IS+5DsPbCMysyMGgdAGiXNINPFiG88MefjYjYtXTYxLmFxO7QP89PdkpiQDQYA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ymts1ol4; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ymts1ol4;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1029; helo=mail-pj1-x1029.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g228X28TNz2xfR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 15:49:16 +1000 (AEST)
Received: by mail-pj1-x1029.google.com with SMTP id 98e67ed59e1d1-35fb0bb27e7so4859256a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 22:49:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009754; x=1777614554; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=RoXnYHhu5OJq+pQQ/T7jeG1ntNKoLYxlZRpY7d5kjto=;
        b=Ymts1ol4JZzsI2PgblGrKQNX8XkHnvmHizBvN+3fN9zxVLBQxx95kHUHpSyBBVSC+E
         SyNgv2OMxj5YNuOPjKavmRwUE2ybbirxoXRLCYHuAR9Q61DHfuqwGUqszCkpC1caHe0j
         P50RVKWg6OwfVg50EOVIh6cTjmHgRhW8OcL9SScfTH8VrVDfd152zJiCjJiY/IA/81su
         j56Wa7Gj+uyAsCtxp2fDwbecQYsO3jlnPGgK0SCg6uv8Gwo3KZYXoYmhz4dVjtT3LKb1
         iX9xnxcrzqnZDtGsvFWQ8NtsjEpfduFmaoSZKSylE/Pqg4Si/Zgw7dCvhRIockvZiKME
         iyvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009754; x=1777614554;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=RoXnYHhu5OJq+pQQ/T7jeG1ntNKoLYxlZRpY7d5kjto=;
        b=VxLhdeti7KwMipQbjeugC6Ot5EYTHZZNA/JlS3HnAEEz4SvrkBeADf6fh4tmqKW8bZ
         Y4dSD589pkQsCDikfqVWukatM7RDSblU2MMXbVlNJR+okVD3QzaV/UC+JdB4HMkILjL7
         FA2dBN0KgmB+ILeGeWLSdEZbOHngtJ2GE8ix90OR2mTXeGFtsIIxht3mmcDXo6QoyPeV
         elTRwP2YHlgnRcw2VlW4MVJjM6hQVCq4tTfMCVU57xSFdMQYjKzMQdKn56PcHpx7t44j
         t2d5BC6RYqpMOvKHM0I+/TAgXRUCd1wds1SRvAgsNZlV0mT7guqGrw8PqtwBBKhIZ/k4
         LeEw==
X-Forwarded-Encrypted: i=1; AFNElJ+5r0RC46mSYNL7nkNrjbOwY810zUDu5Vj4LD8LTfdog7qiMSdTb3KsjrZKlvcIX48xAh9fNNZXYuF4QyY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyalQTEY0gEV7yUFoUqjcmJ1J66waypppLBwz7Ph5c1zEvGPnOO
	x2QGu4s7lcllLaQTZ+2HDOqlcEORdeFdEVmkrX9ZljQGn58s0i8/4bXV
X-Gm-Gg: AeBDievndZlXoLFtyo/9IElLWIds8PhxlIICSS0BqSBBhnGAuVpMBSqUzEYZcemY8dy
	2+xJSC/z6ynrAOiFfsmuqhWQN87bVtRFN6txLE29p7JaA18aAJ5qPx1ZLQkV+A4UcQMhO6bNkRa
	rpnkqdiywWZldSfn9HT/hJFs5LMmM2MUox9QHtQ4zEbV2qwXLSWd/j0R+BxnQ3LUOFYr+o0ZXD0
	rPNFOQAZ3ZeWleL/jhRmqbiayvoAHvi8861bRs/6VfT1CxP5+kul4d6l1PFZ+ENDso0koS7tZoz
	EwHD2BYtmR3glPQD0+viohh2qNfCnTj4GJxsh5dC18CYZujUqs1SCt1d+OmuqGeaHWDRJnq7NKB
	dUpLOQaLllIDGE3myDIn9Or6mENZ07cFcS/o5iJRY20sBa4Fai3NLxmFeO7phDyuoF7bReK+WH8
	Z6zXrgr60NoqtvE/z4JPArv06L0zvTkJRwvAKugLl4FBhADMkLrNPmY/FW0Zh1cC8hFxaY/QAmr
	2ZiwW7VdbCcXMg=
X-Received: by 2002:a17:903:1446:b0:2b2:42b1:ad95 with SMTP id d9443c01a7336-2b5f9ee2835mr352292775ad.16.1777009754030;
        Thu, 23 Apr 2026 22:49:14 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa176e9sm208778245ad.20.2026.04.23.22.49.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:49:13 -0700 (PDT)
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
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH V13 7/7] powerpc: Enable Rust for ppc64le
Date: Fri, 24 Apr 2026 11:17:42 +0530
Message-ID: <20260424054742.45832-8-mkchauras@gmail.com>
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
index fd9c1bf026ca..d7b74b209a33 100644
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


