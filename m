Return-Path: <linuxppc-dev+bounces-18975-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 8EA6AF3D60A
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Mar 2026 16:03:44 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkK1V6S62z2yft;
	Mon, 30 Mar 2026 03:03:42 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::629"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774800222;
	cv=none; b=GjO7qsLy57O2hS7t9L/KY1JmGRuAQhpPLAOrCUGEC/RQnuwaqr6qXST1iQiOyBoR3tQ1JB2vWJGFKI7Tinz5y/s9CY1pvug8jGarqNH6Mg3ZtBcrw4GLYGm4TunU4lQBATKOx60j1u23+GKBF+k0jpyDqjTVd7sftiFWz6QYbJLAjmXzhe5v89hMhljaDUdEPp9GzNB29AE5SXuUJkv4lyueMvIYww3UWUQkjyC47FktBlaEF7wQP2NbAgVMoXzRE+UwDPM3HHLjGhVU2c2aaxo8j22re67PYGWGgWTPouRgwPB8hS4AYR+xC3SaWrGSvb+/gMxDU0LKbONlPfJG3A==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774800222; c=relaxed/relaxed;
	bh=288wnweBkfKS80Aih7eMbYVxj6PiM5xDcY9weWSozU0=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=SkiQGsefJOokrhRVDLyMnGrZ5BKmzb9re0lFwz8ER6QN6ETxD2rW/OKOIdwLEE96u7FIG+1RidQsbiOSsCmaXGjm5PIIH++42yCTY7ZnMmqugp3fFXcfReJW5nyyPUkuQHtNcscfVi7+wXhcZxo5b1KoUKiocaUsFWk9aG1RLCrWA9wxUdK1nFMdetRL2Qyt8mG7Nqkj2sn30tWgGgGCODqylCb/PHKe+pkKgdFLuOJu5KrdlfeLPxcU9PlkaqHp/78kSjyjG+RFH1XVaVSbHo/u9NlHAT9eFMb4hBt22bgkU9JiGRsxaWs7RuqiJLGkeam7vreZ9yTY/zCySh1qRQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bhnnkwdf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=bhnnkwdf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::629; helo=mail-pl1-x629.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkK1V11JZz2ySS
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 03:03:42 +1100 (AEDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-2ab39b111b9so15792355ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2026 09:03:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774800220; x=1775405020; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=288wnweBkfKS80Aih7eMbYVxj6PiM5xDcY9weWSozU0=;
        b=bhnnkwdfGO+MpVKmKAXITjCzb1LOeqg+LqwfQKCin7aOTZSCHR0daLi+BAymPIIS2b
         Ez492JGw+6prrYpfsL8s+Lv82uL62XVlPTvbYSmIPKs9cMfSwKng3W+32JnF3Fq6Yq5H
         ZLnxk+NerZEpYInWhW8UYXO8Lp0ou8DMHYEJ33b7izz0PEYoobQko1Kcih8N+U77tk4n
         asIO6MALksfolAXnUAUcW6iURqAJydVgS24gzL06j7qEh5KPzqndeF0LwMJe4v5FmGnA
         OXWQLBLLyAgtriJ2Ke8UYfqEw15eoQQEzV+hcYZWpX8dc914JWvce2HROA1yOrTnzRKb
         d5Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774800220; x=1775405020;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=288wnweBkfKS80Aih7eMbYVxj6PiM5xDcY9weWSozU0=;
        b=Mi+lrZ3ap/mlrszpXDgdwF79Mta6eBcLxmj5Exyb95NemUqBtJtxRF6fVVTgiXliHO
         cRJXSihhIeMLZQPqUUUH2EwGzSRP3vbv4QhYQGLbbMrCqWwMs7SqEI5leaU2pz4m3IbN
         BGbVBRyTSxWE20Vvp7NJneGnaeEtFbz+q+vmmIc7MLSfgLAtDZGv1xUvTFn0YvbUxohD
         RkF7oc7yQeE/PExp6lU/pCKvFb8neVAuq7faG9fvC8mUHudEordtMtpZjrpJJz3mgEvZ
         xtlhxUryeb6jG8k3m21EBiD8Xnk/lYosd2YDPRoy1ZUf6L3ohshNmH23fTemLh4DRgKR
         juGg==
X-Forwarded-Encrypted: i=1; AJvYcCXEdpHDqbH0NXKcGE2mV8uf3PjxWNxOD95uY17rgN8cF/vhTHrcV4NRELOffiAMy9swsGyh/XAbDwyA3CE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yy5u7QPdkx6mnbjVcCsPI9qOejtDIdLrZYot6aCU42gpBgjHOs3
	jF8lGYNHNGLNGpr6SShIr8i8YeosEz6iYenon7AzpObf5s0gQt3vdT9r
X-Gm-Gg: ATEYQzx4MifjiWQWh8iIrBIEZgLtF5w0AmCkJkHg4scM5/IRUn3PHKdUKj7tDlz+Cw4
	xy3L1qE2eSqkytkYzulTZPPgwzIxLGA2Bk6bzcaZwHI5SGoPdL+kdWLlO5h+sKR1yb1MoTy+Ubx
	Q+pmycwrkTjAZbim1R408XJBLI0TZQdNJa1AHyDNDN6Ysa1sTbNxew19CyKc5C2nz+X/6VHUDZV
	yk/dqoFF/MWuWs/Irtms49FBwXSBh3W5OOScE86rYcmYCTSYc4ciJr2i2vrONE5n9Qop1OPxi6a
	oi8nn1SAyXnXs1YCZhsH6LbLAmhsBDxoNxrrFBzmXFuMe6n12EIUwYao3Ss4uOByqc0Pa0v5898
	F9rsZ87RA6EyohlYiZcuTUJKRE+Asm9z23084hUxdAgolq1iYiG1Xfio+R0YgPwT8MMpmplBAGZ
	pyd/izKTa+YLl3wkllBkvTodWIXl1tCFku5KesIpD6vThoEVSGXSmW9/q622dwMW5jWq2Equnwq
	yg=
X-Received: by 2002:a17:902:e847:b0:2b2:5124:d068 with SMTP id d9443c01a7336-2b25124d224mr13168265ad.10.1774800220154;
        Sun, 29 Mar 2026 09:03:40 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c176fsm52521175ad.77.2026.03.29.09.03.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:03:39 -0700 (PDT)
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
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>,
	Link Mauve <linkmauve@linkmauve.fr>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH V7 4/4] powerpc: Enable Rust for ppc64le
Date: Sun, 29 Mar 2026 21:32:54 +0530
Message-ID: <20260329160254.2592207-5-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260329160254.2592207-1-mkchauras@gmail.com>
References: <20260329160254.2592207-1-mkchauras@gmail.com>
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

Enabling rust support for ppc64le only.

Tested on powernv9:

$ uname -rm
6.19.0-rc8+ ppc64le

$ sudo modprobe rust_minimal
[  632.890850] rust_minimal: Rust minimal sample (init)
[  632.890881] rust_minimal: Am I built-in? false
[  632.890898] rust_minimal: test_parameter: 1

$ sudo rmmod rust_minimal
[  648.272832] rust_minimal: My numbers are [72, 108, 200]
[  648.272873] rust_minimal: Rust minimal sample (exit)

$ sudo modprobe rust_print
[  843.410391] rust_print: Rust printing macros sample (init)
[  843.410424] rust_print: Emergency message (level 0) without args
[  843.410451] rust_print: Alert message (level 1) without args
[  843.410477] rust_print: Critical message (level 2) without args
[  843.410503] rust_print: Error message (level 3) without args
[  843.410530] rust_print: Warning message (level 4) without args
[  843.410557] rust_print: Notice message (level 5) without args
[  843.410594] rust_print: Info message (level 6) without args
[  843.410617] rust_print: A line that is continued without args
[  843.410646] rust_print: Emergency message (level 0) with args
[  843.410675] rust_print: Alert message (level 1) with args
[  843.410691] rust_print: Critical message (level 2) with args
[  843.410727] rust_print: Error message (level 3) with args
[  843.410761] rust_print: Warning message (level 4) with args
[  843.410796] rust_print: Notice message (level 5) with args
[  843.410821] rust_print: Info message (level 6) with args
[  843.410854] rust_print: A line that is continued with args
[  843.410892] rust_print: 1
[  843.410895] rust_print: "hello, world"
[  843.410924] rust_print: [samples/rust/rust_print_main.rs:35:5] c = "hello, world"
[  843.410977] rust_print: Arc<dyn Display> says 42
[  843.410979] rust_print: Arc<dyn Display> says hello, world

$ sudo rmmod rust_print
[  843.411003] rust_print: "hello, world"
[  888.499935] rust_print: Rust printing macros sample (exit)

Reviewed-by: Link Mauve <linkmauve@linkmauve.fr>
Tested-by: Link Mauve <linkmauve@linkmauve.fr>
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Tested-by: Venkat Rao Bagalkote <venkat88@linux.ibm.com>
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
index 7ea7570e3f17..7fe4cbbd176e 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -410,7 +410,13 @@ BINDGEN_TARGET_x86	:= x86_64-linux-gnu
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


