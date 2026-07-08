Return-Path: <linuxppc-dev+bounces-23789-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 15D53C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 08:26:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwB5Z5zsJz30Cj;
	Wed, 08 Jul 2026 18:26:42 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1030"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783499202;
	cv=none; b=EIyXi1jQsSKHZ0Qol8nnrh8ioK8MbKu2J+TBSJBlBK4Ue/6D6Bk8OL5zf5H6eDRMJpAtIWWZ8fV5z4M77dZxDtYXM1VgtkZ6w29dMJN9Z/zUsEI4ytJhH9YJsLopCJ8BlktaKxnt8Hcu35SBqZhPf+ObWWRPlDNcgkYiivDQZ2OuCZ//MkjxIlqApWv9fP8DnIL76BPQhw6+pmKZvRCMo4uRWdYnMLTq53UctUOaP0YaMOHjSC8+i582zoVjMFdepVy+1UAbOJJT8V2tJKuUJhEmPIfwiNrYGsnCHiAV4oOYg2naLvLDiTMkoPnJmvKguQIeM88godU9DqQQ7QVKTQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783499202; c=relaxed/relaxed;
	bh=7Uzn/NdDPosTQtig+uiLwEMPj/JQxR6heV7Be4pIXTc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=AFE7KEYj/4+hfx+T4i20rYGqrsicza4zUSZD22FaZPnTrUdTvzrq/3FeTXrplhlGND/uYpTI+9w/fTM1ndMNqBKCdDTlo2JgCoaLzalO5rzEfe9iswv0jmEyrJsY9wo2bMnDqp66Lzr7cdeUAonMaJHloV+Jfd3L+gur+8oqv0RDvUylcBkzXJaxz4XDmwbiEfm41sMYZ/DLUfSuvtsC+F40kWcaKILLLLlEseajiGvxuCRdtMVsckUWuMe21QfbXvGD0FQAQw8mYk5qdN5eAkLqUaq3C6krDRIcnKsjH6iJyTZgPqyqkx8v6yGjbFVIIcxC86ew/O+B8fIYj7qfqg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Mxp5cOpe; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Mxp5cOpe;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1030; helo=mail-pj1-x1030.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1030.google.com (mail-pj1-x1030.google.com [IPv6:2607:f8b0:4864:20::1030])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwB5Z1X3Wz307v
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 18:26:42 +1000 (AEST)
Received: by mail-pj1-x1030.google.com with SMTP id 98e67ed59e1d1-381ed661712so434134a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 01:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783499200; x=1784104000; darn=lists.ozlabs.org;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:from:to:cc:subject
         :date:message-id:reply-to:content-type;
        bh=7Uzn/NdDPosTQtig+uiLwEMPj/JQxR6heV7Be4pIXTc=;
        b=Mxp5cOpeEqwsj0FO/FHyji36hI58usjrEzklOHTO4FAqpqqFFc1fg3qz88LDILv/dR
         WabI8sRUiy4AaWrYbFLJAlsWIKDx5K+RQBS9hBowSvLuTtmsyBeuTXgsegBRPuRfqD4G
         1aRNh/fTlTZqZaYnrd+S/X9TJaxEkD41e9htfLpGebK9vSSN0MaQ7SCobYIOULHwspep
         /oCTg3Hyz5OWCY8W65raQe3C3bAWKc2+O6dtz9EGNUq8UoqIxj1/ATtEcGZjgIDgV9db
         BRQSNsJyVQXBm0peUoQlReLuaifRrq31O6wGhJ7IP2GBDlaMYbhcPQy38eFLVp4BA6W2
         1w5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783499200; x=1784104000;
        h=content-transfer-encoding:content-type:mime-version:references
         :in-reply-to:message-id:date:subject:cc:to:from:x-gm-gg
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to
         :content-type;
        bh=7Uzn/NdDPosTQtig+uiLwEMPj/JQxR6heV7Be4pIXTc=;
        b=QDiLMtFgmsVDIvJKdrXvbIMLCoL4Ik8nlpjF1ZnSmc0ZLhf/dvm3dOir5o11VO/eEX
         b6xSR+Ag76uF5mOAfy5GDL0TBQp2Ofjko0MRrJjJvwN3xMdC4ri4XBBjkjLGz2cmz8qJ
         H34sNN23dAK+nlMH0Ckzc35H71QCeJF3mCBbDFB3uqdyOi05uQ5gI3zSj41FbDIPlQF+
         VUKGkiIuPIMPOTeCk+70cj0gy7q/UaLk+XVGEkwRDqK4lt/Azmk8zhp3u+egaezEOYCG
         KSjFsQOzcW12wKBXR2GbhE6XYpFUW1VmW41qtXimtTPXiWv18HVWyZ9KIXoyxt/VMSDO
         pHng==
X-Forwarded-Encrypted: i=1; AHgh+RrTh9puJ8rmTH132Cmx30stMU7qjhRQRlu/eHhewGPQ94dkdostklx5SS08pThnObUDwbrdQg2bS8pQSYs=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwcAdPTJZJfCMmquoxMdLLVImal13UamL5eM/QKQfPlhA7dI/uU
	UWnHOjtHk36PSX1PKcq7Cv7yj3fmmxJkl4Si27bwRmPVCxRNiSwmKPO/
X-Gm-Gg: AfdE7ckR1s0Lxws3bNlU91DDCC/JAyKDMloFDS9yQg5KwgoLIXIcaVpRlGD9nAtwtuo
	/gWPJs9ZTdCmuReIJlWfOETVIF5vErvM6s0PW22cC2pgQFD2j3lx3P+22gsXN552ChIkszLpxWK
	Tb2dLFk0gsnJ0HBkvOXlGDBbjg02WMctRRHp1Hdhy8RabQo1MKj/hfHSXjjdTSDaf4DHfwjYrFu
	OaYI+ihBQw6q8QsY6/iSJ1BaJ7KVO3MFfC6n8RVkS305mBpqoxD6QrOMPV9Hl/U4SuxNDh2/ZZP
	AMcl5Ikxyv6g5/nN9acX0/5VsncK7PP0xUW3Ew7tnPnU6JYEVwpL8uPRnUBtcFddC2kA4GIeuE1
	FT5mq+O8IQGKHlJKa/xVKUAPVXMN0Ys64ewIkCiFsqgLe0NwXP5gkPBl8I5YJ2AW4Kw9DyAmO9o
	2iB5Vj3ycM3jvqNbeGxNEaUvP38shoyox1cHIswt+qmy0JjMy6vWrw/b5s33fHTPfZa3jVRR1H8
	cIT
X-Received: by 2002:a05:6a20:7288:b0:3bf:a1e5:ff62 with SMTP id adf61e73a8af0-3c0bd0fa2e2mr1854023637.47.1783499199822;
        Wed, 08 Jul 2026 01:26:39 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm19975117eec.0.2026.07.08.01.26.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:26:39 -0700 (PDT)
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
	daniel.almeida@collabora.com,
	tamird@kernel.org,
	acourbot@nvidia.com,
	work@onurozkan.dev,
	nathan@kernel.org,
	ndesaulniers@google.com,
	morbo@google.com,
	justinstitt@google.com,
	fujita.tomonori@gmail.com,
	joelagnelf@nvidia.com,
	gregkh@linuxfoundation.org,
	prafulrai522@gmail.com,
	nsc@kernel.org,
	japo@linux.ibm.com,
	mkchauras@gmail.com,
	lina+kernel@asahilina.net,
	j@jannau.net,
	airlied@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH V17 7/7] powerpc: Enable Rust for ppc64le
Date: Wed,  8 Jul 2026 13:54:54 +0530
Message-ID: <20260708082454.1254320-8-mkchauras@gmail.com>
X-Mailer: git-send-email 2.55.0
In-Reply-To: <20260708082454.1254320-1-mkchauras@gmail.com>
References: <20260708082454.1254320-1-mkchauras@gmail.com>
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
Link: https://github.com/rust-lang/compiler-team/issues/987
Link: https://github.com/rust-lang/compiler-team/issues/988
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/Kconfig  | 1 +
 arch/powerpc/Makefile | 7 ++++++-
 rust/Makefile         | 6 ++++++
 3 files changed, 13 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index badd7c99b87f..650283107b92 100644
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
index 61e7dc496fe4..d2f74998d3c1 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -459,7 +459,13 @@ BINDGEN_TARGET_loongarch	:= loongarch64-linux-gnusf
 BINDGEN_TARGET_s390	:= s390x-linux-gnu
 # This is only for i386 UM builds, which need the 32-bit target not -m32
 BINDGEN_TARGET_i386	:= i386-linux-gnu
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
2.55.0


