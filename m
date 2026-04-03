Return-Path: <linuxppc-dev+bounces-19276-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 1A8ECE85373
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 14:53:56 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnMDf5s0tz2yjw;
	Sat, 04 Apr 2026 01:53:54 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::431"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775228034;
	cv=none; b=IWz64JsdPtOJPulNdy9UcbCf6Or3PNRaluVlWcGcI4IV72I8WS+R0gX4fc9/KUA5w16/Vf/DMCwCWF7rpOwX1hN6r3z/dW9HbyWv0EBVf+30rI7oIt3XbNOLR9eXcAMpIWOtjQQJL4734sMGgNEExSCkQzX6RMWwElwtXvbUVJB0EhXuRe1SNwVC1/k95vN5RprChCkdU7lt1FAqNhKn5cmOy5xBMQ13bkzBGJKGNnoh8qy+aOlpIFdoONvDOg9hpdbipY99TxPNrW94C/Opbhz8nJWG28xGW3nsJsCFhYEjH5k9caY4byUX5JJPXoRePkxPr5yYApsNc9o8KFITrA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775228034; c=relaxed/relaxed;
	bh=Mk/c1eJYvsg8D8dqxhQYhJf46vVg1VoFShzT3q2jtfA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=kSuf1tE+8hP+Mznw+IuhsuUgNByTPF1ow491C5h1WD/vKcS69klSOXoatX5qCkuKBsTNvdk+gXxbzY0WJYdfpSoD89YnkSSxDt3AbsyMJzmGMSROfBzWJWSBoui1K8bzCox5L4Eg2glAE+hauCPa/gVPs6C/YpKdCW3qSXv8izGBl7hXx2n3H/n8HUtMukkmBP97lo/MxNA0dLnwPmuJjSDJXmbug3mEmFj3kyQqjDlwJlhlLaL6a+gnIGuTX7c+CXyAsnWKOCQDoCE/TF4Zt2RmP0dxN7D5BY/6+W5qYJu++724HDcMX34m5N14/1jh0If8P4tshCu0ZiBxuVeXuQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KPWaoMkR; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=KPWaoMkR;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::431; helo=mail-pf1-x431.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x431.google.com (mail-pf1-x431.google.com [IPv6:2607:f8b0:4864:20::431])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnMDf15Xvz2yWK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 01:53:54 +1100 (AEDT)
Received: by mail-pf1-x431.google.com with SMTP id d2e1a72fcca58-827270d50d4so1806647b3a.3
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 07:53:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775228032; x=1775832832; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Mk/c1eJYvsg8D8dqxhQYhJf46vVg1VoFShzT3q2jtfA=;
        b=KPWaoMkRgLXO+GYlh8ESPlqvcOe3SYT6kRNsBYEt9yuvIhgqmUUTfh37qLuyqkrxEo
         XzTzEubBOTkwlHTfMi94dgGdkS5CWM1WOo2MsjRFiGhSRWXRoFTPc+FhgC5V1YFQ0DJD
         amTmBTZmp2gaViFSI9dJdpxK8B0vy0a9O9zeIkTH0WTSqTCu76lYu+I4Ifc3xS16kGCl
         05a1e6spAs5MzI9Mv0m/pYuGoEpSOqq2NNnAgQ0ZhqvanLN56Ccs0lZkRLrXr7AB14Oy
         0eBFUxAW5ervoRJCnzRUzOJw5U/N9sx/p5Z7c3k5ZC9zhtOiQuxGBoWL5/MH4U3RxUrb
         aOYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228032; x=1775832832;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=Mk/c1eJYvsg8D8dqxhQYhJf46vVg1VoFShzT3q2jtfA=;
        b=HKTdgMpAvUGOrL5h1Qp6kEg+G7ZQ56BI08c555TvYS8FRewSqiA6gUSVxaieNdz6uj
         3YlB+3Pm3+qP+CyIru6YJryV19Iv7kM4/BDT13aFZfg+6HanzPiX2Qj5fGS7Vx30fj42
         nCS3DgQ8Wjap6AfYJ/YcfBv8biMlhZv8t3jARZFW0w9VONGB6K6vN6l+Hs6/HdPMkXuz
         o02klJTNTSbKP3RiJL9P9JQqF82wzMdSgwG1pmE/8o33UBjDFRDUWNX5cpI+NHuGt0wj
         am4Knit2JoGBXr0fJaD9xxvlTo4BSgqyMp3utTy+kliWnL6aIlvwzmCKLzwhKVW+wZ4j
         8QLg==
X-Forwarded-Encrypted: i=1; AJvYcCW1EkQn657l0EKJRSo66Tf6VlX8bH8UJL9K7gg/6gA5U1CiCHYGAsNEMtuGBdusJSKxQeSEhyvyovUhHO0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YxoD8JJ3RG+wZnQhqHHp2z49lo7U81M5E8ZaNrnxdZnmARxK7bb
	NnjLuidvQ5jlENndnUHp85LerpYkBKryT8FEL7/4jOqCLpwl5VS7ZCp3
X-Gm-Gg: AeBDieud+EKHIdytDu3xufwp1j5SNli6yrTyZ22EfTCeGvbjbEYk7bjpuhOXWh3Ra3l
	kiW3LoZL9KIfsLdcrjnHKI4e/T7XjYpKOuLuqMT3GCSShiPE9RSPcGZhOiZJOtWoebUl0uMtE0A
	qEUqpeglLuHNTcEGth1ui0zph5i11fzQu+x2KyGLUIP3kjhZ+I0UgVUlLxQrben8k3Ognm0GcfV
	r7pyWCKT5qFjTxSHX3GFVIxlaDzF2LpnQd1zQZCP463fmh9Un78qw/K+YwrYP+ffF7IOCVyNRcA
	RRZelQU2aLGaGgu1PtqD4qh0CXtKAW+v5srM9u1M6xYi/Kl6oxrjt6MVUNFpp5Eicf2c5Svcpad
	Yl++tvQaiWV+PXvEHH+pbdJunddwrJcw1X7OuFUMtXLNTlu/1pbLQEeUwOUytvCOgEkMK7lzimj
	Y9eaB9X07nkxYCdsQWXOAOk1MwqfO4YweMXpXKoYjOXu52dP1Mp4AMNcpuA6iw3sspoec42lska
	6k=
X-Received: by 2002:a05:6a00:f93:b0:824:a635:4181 with SMTP id d2e1a72fcca58-82d0da84bafmr3123650b3a.15.1775228031997;
        Fri, 03 Apr 2026 07:53:51 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca4efesm6301682b3a.61.2026.04.03.07.53.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:53:51 -0700 (PDT)
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
Cc: Link Mauve <linkmauve@linkmauve.fr>,
	"Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: [PATCH V8 3/4] rust: Add PowerPC support
Date: Fri,  3 Apr 2026 20:23:07 +0530
Message-ID: <20260403145308.1042622-4-mkchauras@gmail.com>
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

From: Link Mauve <linkmauve@linkmauve.fr>

For now only Big Endian 32-bit PowerPC is supported, as that is the only
hardware I have.  This has been tested on the Nintendo Wii so far, but I
plan on also using it on the GameCube, Wii U and Apple G4.

These changes aren’t the only ones required to get the kernel to compile
and link on PowerPC, libcore will also have to be changed to not use
integer division to format u64, u128 and core::time::Duration, otherwise
__udivdi3() and __umoddi3() will have to be added.  I have tested this
change by replacing the three implementations with unimplemented!() and
it linked just fine.

Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
Link: https://github.com/Rust-for-Linux/linux/issues/105
Link: https://github.com/linuxppc/issues/issues/451
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/Kconfig  | 1 +
 arch/powerpc/Makefile | 2 ++
 rust/Makefile         | 4 +++-
 3 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 10240cb80904..1246b3add8ff 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -284,6 +284,7 @@ config PPC
 	select HAVE_REGS_AND_STACK_ACCESS_API
 	select HAVE_RELIABLE_STACKTRACE
 	select HAVE_RSEQ
+	select HAVE_RUST			if PPC32
 	select HAVE_SAMPLE_FTRACE_DIRECT	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SAMPLE_FTRACE_DIRECT_MULTI	if HAVE_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	select HAVE_SETUP_PER_CPU_AREA		if PPC64
diff --git a/arch/powerpc/Makefile b/arch/powerpc/Makefile
index a58b1029592c..589613eaa5dc 100644
--- a/arch/powerpc/Makefile
+++ b/arch/powerpc/Makefile
@@ -61,6 +61,8 @@ else
 KBUILD_LDFLAGS_MODULE += $(objtree)/arch/powerpc/lib/crtsavres.o
 endif
 
+KBUILD_RUSTFLAGS 	+= --target=powerpc-unknown-linux-gnu
+
 ifdef CONFIG_CPU_LITTLE_ENDIAN
 KBUILD_CPPFLAGS	+= -mlittle-endian
 KBUILD_LDFLAGS	+= -EL
diff --git a/rust/Makefile b/rust/Makefile
index 762bddc868e4..d05e76df15a8 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -413,13 +413,15 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
 	-fstrict-flex-arrays=% -fmin-function-alignment=% \
 	-fzero-init-padding-bits=% -mno-fdpic \
 	-fdiagnostics-show-context -fdiagnostics-show-context=% \
-	--param=% --param asan-% -fno-isolate-erroneous-paths-dereference
+	--param=% --param asan-% -fno-isolate-erroneous-paths-dereference \
+	-ffixed-r2 -mmultiple -mno-readonly-in-sdata
 
 # Derived from `scripts/Makefile.clang`.
 BINDGEN_TARGET_x86	:= x86_64-linux-gnu
 BINDGEN_TARGET_arm64	:= aarch64-linux-gnu
 BINDGEN_TARGET_arm	:= arm-linux-gnueabi
 BINDGEN_TARGET_loongarch	:= loongarch64-linux-gnusf
+BINDGEN_TARGET_powerpc	:= powerpc-linux-gnu
 BINDGEN_TARGET_um	:= $(BINDGEN_TARGET_$(SUBARCH))
 BINDGEN_TARGET		:= $(BINDGEN_TARGET_$(SRCARCH))
 
-- 
2.53.0


