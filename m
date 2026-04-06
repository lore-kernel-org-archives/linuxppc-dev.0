Return-Path: <linuxppc-dev+bounces-19411-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 76E7CF46C78
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 20:02:45 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqKxc1X75z2yhv;
	Tue, 07 Apr 2026 06:02:44 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::633"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775505764;
	cv=none; b=lo0ocTC5DI7yWLlUMvJdGUUTpNWHinK6YBILqP10C+8OdG1/1dW3LQyGJvymdKTcjkXdoTCfxMU9MOT+yBucOPgU0VJmoXBEFcfN7ovht7FxN/1wLLZb7SnSo6at83gDMF70vfjw7sKOKCL7dxVfkaXLsBb62ASSqWNczKXx9sgPKbgxOGj9Q+Ej9qeDYciAzoaaiRttpjUkNYaVYTZdyxbsTifo2khT8Lwwc/kqshj7WJ6+kSbDtXMXS2Ld1Kk+G8Yel+ViubKle484KzboKHg5mCYijKlAkkk3FL87q41u/L1GZeD4uzWdIdqA0qKoBJ+L/db5q+I3jL1uEDG9cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775505764; c=relaxed/relaxed;
	bh=d2r7y3l0YoAacVN6N8CSzvUk5PKNLzqAsC5O2toHlyY=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=jPcor2ufWkNLvZdA8o0Gbqa+ee+d/6ZJvJdwhC7O1gutAzVxjRzy7LOI4pDJQ7pDVHVx5aJ1+SNnjBEVx+OQ1se8JFFu1mak3dReGZzwSdPUggcTdEJ2e2srT3lTPbsyIPXF47D9loQJyLviEjATbPr+HrvmrADa7gdCTHAd5qjXeXk3QFKgcRTAoL4CjVg+CgppRMVUZwyaQkDkFoaLiIT74CRpqTi3gJPjP2mepT4IeT6yz/Zm7uNtpBAWqXkPsuhGkv1tw0kxfYJ2TR4LAFWoH1HtKsQIRlksGj+EbPjBLUhDiFLOseJzLGvTmhvlvabV4oAnUXndlQRiaiI+Ug==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J/RW6a8E; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=J/RW6a8E;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::633; helo=mail-pl1-x633.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqKxb44kzz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 06:02:43 +1000 (AEST)
Received: by mail-pl1-x633.google.com with SMTP id d9443c01a7336-2ad617d5b80so22598735ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 13:02:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775505761; x=1776110561; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=d2r7y3l0YoAacVN6N8CSzvUk5PKNLzqAsC5O2toHlyY=;
        b=J/RW6a8EDC52sLvSewo6+yckE+XhgbTyAJWeXtkwDyBVBt51jzJs7scJK49iHsu/Gn
         xcwHtZhD4YVJfXnh7gDpKgYRZl3d7w+1veAvcVjVNX6ndhovI5jl1UoB9GUF6JyZeyzH
         2NKabfu0R0dtyLJc1sUur4NBh9zIkfFVJb3Ju7yEA4NE872oYCBZHRm3aPH5MlC9Rd7W
         JfmT6x/CbhS254SvTr1zoCcajm4KbKyem8oI8vhin52kfnakPStkOuNoSLU9p6pE+pLf
         RuiErMd6rEg30+bR9ePx5g+Ai5Eqb9McRMOTBhXUa+hsK/m5Ltq0ActXERXGOx0a3qMA
         Vjig==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775505761; x=1776110561;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=d2r7y3l0YoAacVN6N8CSzvUk5PKNLzqAsC5O2toHlyY=;
        b=EZqU99/p+1U1E+FuhW18oHLu5JR/fBMjeaRAQCxBWC86tY0t9Ux83G67DlBLnD7qTH
         20nHSShyx/dlDLD4NMgfXBPNkr+UG4bjqqKdVQqnM6Jw2YXqQek7heKjz4BxsAsCor5E
         oyj5tk6gj7FZnzYhSJfQ7DlpolNrPV4Vu4gI9A1g1E8skNsKeVJTPOTrapUkcJDbHrN2
         HGC/2vmqTrG1gf57u4HfVucCNf5+we7CnetaIfcnh2E75DPMvwX1ejCNGuar3gd8F8jL
         m2+frYKy+rE3e5aDqSMj8kMagXSqEm/iy9Dl9gYy+07FnXg8BrAhdEZ10um/ZNQx5Kme
         12ZQ==
X-Forwarded-Encrypted: i=1; AJvYcCWhlKi2zbvjrl7UolJZLcpNKc2RIl4bXdcq4FPVlvFHnVkFp/rGkR/gUPg52zy3iTViuu1+1yto7KJmwH8=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Ywl4kyiBJxcMFjRru4yOp5+a8umo+f3jhlRKS0x2RMZeaitGm9R
	ZUnxyvRb7ofzJ9n5YNhxem7iZIOtQ+k/xFWbX1HaFrBot25Qc/ATJLIB
X-Gm-Gg: AeBDieu7VYf2xcJ147+pytV5hnIq07lP6f7LQlpU0JoVxbxKy+ceh5nYhGPV5Qin+qF
	VrHVMgi0ojiIinM/Nj9r+P+rsIuSwkCkKD7TkIWW+QNE4TjtICjlBZbE/I2HmQpjKtO8on3ztjb
	CPDpNQYBZQbrP9UvzBu4LvqlpJNmWVDZLuQv1kBMCmbwA34IvtS/SS7Ih1uGagzcq7hSQTdInTt
	ymUJQ+XtSSPOTqBcDuqB1Kjmd7uk2oRS42PzUwyfLJw+AghnMxpyxt8PY6csbo9vWdAIeKRjMWf
	5aad34hDjn6mDJ0fODC34bxK4HwPHGy+j236SvtzkwXScVZPhQHQtWULweQJ1xu5hHEE0HTLDbM
	IZn78Rwsrdqlapfvy15EeYKX4myFC79qAHSGBvxBYGNcrdFlbUrHcv1xXhrDdppEm7oNBgCBmPy
	a5aMOtjjorWckwN1/YrrVIm7jSdAd1ZmPtNkDhWIelK7umzdO5bKaHKJrByOeJCZJWjQXIHFCD8
	Vg=
X-Received: by 2002:a17:903:2ac5:b0:2b2:42da:25cc with SMTP id d9443c01a7336-2b28163ad55mr150030455ad.1.1775505761363;
        Mon, 06 Apr 2026 13:02:41 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497af26sm151098205ad.49.2026.04.06.13.02.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 13:02:41 -0700 (PDT)
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
Subject: [PATCH V10 4/4] powerpc: Enable Rust for ppc64le
Date: Tue,  7 Apr 2026 01:31:49 +0530
Message-ID: <20260406200149.3727922-5-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406200149.3727922-1-mkchauras@gmail.com>
References: <20260406200149.3727922-1-mkchauras@gmail.com>
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
index e53cb16c06c1..e106d6feb8da 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -413,7 +413,13 @@ BINDGEN_TARGET_x86	:= x86_64-linux-gnu
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


