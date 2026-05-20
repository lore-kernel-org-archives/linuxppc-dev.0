Return-Path: <linuxppc-dev+bounces-21214-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id DA6EFCD4F5E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 06:48:19 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL2Df4Q6Sz3brB;
	Wed, 20 May 2026 16:48:18 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1034"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779259698;
	cv=none; b=cQEs8eF7HcA8epb/X9wpHpHTk3tq3OCmXIQZVKesyjMHHGUwXuRxXzdv7eo+BYPt4/JcUMPB3HLqtKj0y6PnpcYgtdlgvWlZC/8z+VgGezGAcfK6m5BOzgqDJjtlrQiKjjDAOPRqzIi7tpCfNXfA2GcwT2OoATnlrRDV90msN0XRV464eS343fexKlS9MUK/0IVzRLAKGw92L6pTXfU82BEHDMO4AtV2slVbZaG63EN+UlQNIcGhA9r3mGYA/ol+XEwutEWKLuiC93Rj41r+TUHPRlW40Shf2HZfjGSgI+WY6ATVgO2ParwarhkRm/DkOjutqfshFStVFBe82Ls9yg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779259698; c=relaxed/relaxed;
	bh=hlYuip95dmigZkw4KVozqME9yuDvS7t6KmHEYjYBjUM=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=lirWuKaF4lCe72cJbfHN2M3dbCTminWev1YjzSW/NckeubQu7/a9/o2uWRL1bgAkWVsgEgC1Brfnq0jL7wg3aWSL0bZ+/kf8UUGz4aQtW5EcgFzQve2HJlBVvNlC8aTEhKamzEKRqDm+a9HL6Ew1D4n/nGdraol80Ysm86o7C5ZmvOrzSz8QfiOFjFP62m/NbAr7JOOrz2JtdjZ7El/lnS0PNbv0b4+Sx1u0dl9sHJ1MrLQaDcZp5caVBJidIjjJA0eqJew8ABqn9odKzK9W/iCd63aZ5GURkMFlsJU2NWetKxc4YbrT4cEc0/Kwikl2krFPS+pGe9n/2L/pOPKP0Q==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lcpm99fj; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=lcpm99fj;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1034; helo=mail-pj1-x1034.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1034.google.com (mail-pj1-x1034.google.com [IPv6:2607:f8b0:4864:20::1034])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL2Dd6xJsz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 16:48:17 +1000 (AEST)
Received: by mail-pj1-x1034.google.com with SMTP id 98e67ed59e1d1-36974221f93so2292874a91.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 23:48:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779259696; x=1779864496; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=hlYuip95dmigZkw4KVozqME9yuDvS7t6KmHEYjYBjUM=;
        b=lcpm99fjqf/HQyp2AxIXX+wojRgPna3GGtrA3Y0zyTmNYNMf77ztM5O4o2OCewIGTC
         RlCMm1zB0ljXeOPfWQA+cxY3JbFg+p09A77JhbD8aT7Uz+LPXn3EnytRO+WBmDTKFDkF
         WPqRY2LLrlZVMmvdMBX8zhNrEw/yDG+IclNZR1ODSVfaR3XzpoZ7vr89v6GZlcIXnXa/
         Gq7T/5PZuHJMwYDEw8cRE53UEcX6IPonXaHAsB+NLoUJ5TGF6M8tY9+53lVAIIVexIQY
         cqZw4LI7sOPJHxN6WSzg/JfCWzrygA5X8mAITfJs5MeNE73vImd1ykQPiuIbsDQguYOZ
         Z8bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779259696; x=1779864496;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=hlYuip95dmigZkw4KVozqME9yuDvS7t6KmHEYjYBjUM=;
        b=Wmktb694Ae5iIrKfSCcU5jbEM4nuikYEijPRZ87JF89c9aZ+dNmFsDAqjlaTe48P7t
         8rrlOL6uUmRrP9OBIVKgeZpvxpEnbCkv0V5BRN4Pr8AY54uAjIDyeGbalI0xcCMYkfgt
         OajWFvRS9TXq7L5XpIxr41GtcuT4hwLT/8bVO28iOylhgJEkBqTjUTVCQMkDZQhdC8GH
         qiTdm90Wv13PJFHwiCXCj7LW3WQ8baXIp7bwA1/tI99I3UYldtzBT0inqgamGC3OAgmY
         0d+ciXML3DyLhhV+63Q0PXspFVYBRe3ZK9g6EFaUE5euRoEjH3t3HywlTut7Y2+8/Dkv
         XJaw==
X-Forwarded-Encrypted: i=1; AFNElJ95y1KZnfsEONq1WpIx/uHbn9agyHxOlWNSfBPY1KbZZG1gLGPVAUo98nYyOMifp4Z6p5MH8BJZ80gAkcY=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwMZpo9NYDa0IrqokvgxHw1z8xhtMarNZ+yRDmYo3aWOKFOkLUV
	SzndCmkeTcutEAKyTqOy9K2u1VAv4Q7aua7fLP/22ZBg7kElOKexjObh
X-Gm-Gg: Acq92OF3UO2ZU62q6N9M0In2KVgjqL7XgM1QcIdwODKeWP7Og9BeiUb4HrWJZZTCwc5
	biR2RgEMAvyl1lSUCNLrCKnz2Ynlu1p7b0xTzTTkV5uj4nl9QEfNHSqwq41QmH5H3BXUvRNhSew
	3GAbafA05YsdCEzR7uT1Q9UQC3/FkYdtkFGY5ZPxv3b3Zo5/5ksjAI4kxR7ZvKAKjWc0ydzcpOh
	V8yksZBsGf9AhAjzV3Qi92o3dgkBmPQUBiSZlDUZlxDbkf3KHFjPx0++I+qmPYaBrSSqLk03OF0
	7qaFL/nxUFudjAOnHGqu9bgCJP0Z9WZaI9eunxtC+zcej+KwDPC6xZyqyWN8zIl2IIaQWmuFmaR
	+Pzz+TjbYqJeTKGluZsLnecfCwDYn0mHmtHvxrEQbPXQTF5UbyufVdekv1fKL7cSy4BhxNBa3gy
	7PPx8OJgVD/vhMLCwcsnYN7mmWmRi120UzP9dPLs1e/nP4MByHx7OjZyianI50Zb8/MOTZ6OmCo
	Os4
X-Received: by 2002:a17:90b:5863:b0:368:3854:3a2e with SMTP id 98e67ed59e1d1-36951dc4062mr21724088a91.26.1779259696091;
        Tue, 19 May 2026 23:48:16 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695a0e93e0sm6069970a91.10.2026.05.19.23.48.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 23:48:15 -0700 (PDT)
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
	acourbot@nvidia.com,
	fujita.tomonori@gmail.com,
	gregkh@linuxfoundation.org,
	prafulrai522@gmail.com,
	tamird@kernel.org,
	kees@kernel.org,
	mkchauras@gmail.com,
	lyude@redhat.com,
	airlied@gmail.com,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	Venkat Rao Bagalkote <venkat88@linux.ibm.com>
Subject: [PATCH V16 7/7] powerpc: Enable Rust for ppc64le
Date: Wed, 20 May 2026 12:16:29 +0530
Message-ID: <20260520064630.1785283-8-mkchauras@gmail.com>
X-Mailer: git-send-email 2.54.0
In-Reply-To: <20260520064630.1785283-1-mkchauras@gmail.com>
References: <20260520064630.1785283-1-mkchauras@gmail.com>
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
index d9485f5e95e6..91c6d5fac15f 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -410,7 +410,13 @@ BINDGEN_TARGET_arm	:= arm-linux-gnueabi
 BINDGEN_TARGET_loongarch	:= loongarch64-linux-gnusf
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
2.54.0


