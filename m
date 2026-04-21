Return-Path: <linuxppc-dev+bounces-19884-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 90B1AF8FA6A
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 12:10:41 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0Llz6vHgz2yv9;
	Tue, 21 Apr 2026 22:10:39 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776773439;
	cv=none; b=oZCeK5S5pkmfAhkcR5nakczwnU3hVCrH3gX6adAm93VCaTBSDjPsfnBzM023aXw0486uJ/fPLASYJiuqLyYTliuiSceIu8RZ1cbqmKc9m62utu/RsCtT7XrpoiXwIHizB6roWq2VzTHxqfLvYDU8XHJ3beFiySiHc36nOiyoWwjWSzWz8LpLY/g6TvnpRjvVQWGoYuy44/9JyEPVuUGQ9pObhYvm1k8Pa0H8q80bU9ZkP2XjOw6Hu7auHSvz8J/L1fpspY2CY9oJGNdE6ZkQmAjljYyX0xpYPcBFioRauSGim2W1put73KQKPZophPZjBgK1z9HLQ6YhVLBRfRp7Cw==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776773439; c=relaxed/relaxed;
	bh=3BeysMzI6zwGD6joEXhhGssagLKkCvhT6RVRv5CKQ4U=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=ofpipvBtU39zCdclvgZTdcw2QX6VlJzzOPTOdMhskzfR7ZSLsw5QFJoBXLblLHJyDMNi9CZQYTBzuXshO1oTdfMwfNB6rVGX2yu5CL6zI4oPyjbbaQzo7MjGe7YVM4q8U2KWsJDLKoXfgksLqcSCGnmEgDiK5ECrSEzvMJ1BETeZQuhzG1l2kt4vyPJnzn+L1nYjj4NuWE0mN8Ds0itNz87lvtEjmW91MjSZ8HxBErrS5FRkZ5K0wwY4RaJgiSRC0cSEDDSaB9BJ+93kEcdm9zUgNOnhbLsJYfd+nZJ+hmKxsqjaG+kxEWsmXCSDBpWgQ4fgDaFylsQUzTQ1F/OcSQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ia4rDgIV; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=ia4rDgIV;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52c; helo=mail-pg1-x52c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0Llz28VGz2ySW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 22:10:39 +1000 (AEST)
Received: by mail-pg1-x52c.google.com with SMTP id 41be03b00d2f7-c79467f124dso1495174a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 05:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776773437; x=1777378237; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3BeysMzI6zwGD6joEXhhGssagLKkCvhT6RVRv5CKQ4U=;
        b=ia4rDgIVryf5m2oOrdfFBT76QzGVfvptTvSdOGEMqexvfF3Fao6Pah6eQrniBxhLXu
         WupB4x4PM+J4NGPhoXUg3KXd1xFrLfqF9kIA9kAt0CbvxD+PJnE0cA1cWe0BkKSPlDGo
         DO/pB6Hrx6O4+1Q+IQw1zIYlBa20YePJZGl+l+29dPIpARvopOEKNTRBvzfiBgP5pFPV
         K89gaAXmvrzOc9oAfyyQMT6EN8G1kOcvsDl7iBI8RWjYLUnPLlS3OVSTKMM+U0HWvkfs
         oKKjDFuVd7pSZv3bdXYQsic0/f1DNQV5cEVIUNaIc5xHQHO4K46BiaZezLWN8+G3ZRQK
         eTQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776773437; x=1777378237;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=3BeysMzI6zwGD6joEXhhGssagLKkCvhT6RVRv5CKQ4U=;
        b=btP6iplsQRLeYYB32B8VB827P3SONje0bxbH0F1q8L2cWzjyr/cSrnxCy0Or502nVF
         mf78wcNyLCYRz00cE1LGwvU7RmOVfEQ7nub+aI1LN+pxKfxV0Uaru/YCZsdTOAy0B2h3
         rEAaDODWRPdWw01F5FWpW0RN/OHyQYYOMuEaPxZGxbiNGTjyYLPks39KQ2gP6vRNp8tM
         d1qdNK56mV5BVV9BieBDNTjsK+O3VbH8bjMaqulYv/z8T4l6c4GgufsTLi8xpaQ7TOxE
         zGXV663ViAO5Y6KcDXVtyS3IBOIIGr7Ik2t5ddZMk6Ff9uzx8EWKj8TGcx58W5S4X3GP
         QWTg==
X-Forwarded-Encrypted: i=1; AFNElJ9lSx/Sz6FPHTtWRWw2MuWoBCrrXuD7Lzxae1dYpKnuKnkeIq0rmKEwZF7+ntrL8hW9DhAaCnRvNdDay+c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyJNbFuXxupVwmIQVWopDwSH/IxBfCu2iAhDGB2Fqsjx3tJNQiO
	aHSd47UXnejY0J3czyU5yHdC8vicTRdRMtKxiE32fl8MjYIBNYC1pRpE
X-Gm-Gg: AeBDieuCOu4XyZVPDCMLz5DXTMCs8N7aTEc0NGr5oW0aoP+Spaq3Q/OaNTTQtIskhwc
	Uqx8muKpGz9D0rD7Ni4KrBkPvfYU9bhsOgSj90D5k1B6Qys+Au58g3AvarJHc5y94GQ1RM/p6p1
	VONGmMtxxXo/4Lks/orkGbUSjcen++B5Wuy0yjQuRGmoqyjSeSRrJrOf4FxDU3v9JiV36/zQF+p
	8Z9QKOCskA58DIxA4suscnLl2uaIBO75Ckghmh4ztj2tbT05tSHDI7NQpcvO9JK1fSnBt6rAFTW
	vH2t3WMMPW3+ejb9ZAWQYDz1+ymUZiNKwPBhQ2sC2wc7+KimHcykE4XVouehdWbned7OjjvxYZU
	D10V0kSQ9+5LfInBD2F4UtbyryBfEsmYSIZulWD9JvsL5EIxJ3J4aGIEmi0EZSEM/kQS3+RGrkj
	Fd7NUSEkZ1xfZalkV00mDUJ4kFhXdcAryg01bcpC8dAG+ZVyyX0iya8yT99X6g5FGdSqFkOpO7g
	fjNkySMMp+r5ks=
X-Received: by 2002:a05:6a20:e211:b0:39c:783:e42b with SMTP id adf61e73a8af0-3a08d6eee6fmr19057917637.21.1776773436940;
        Tue, 21 Apr 2026 05:10:36 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797701d9bfsm10045274a12.16.2026.04.21.05.10.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:10:36 -0700 (PDT)
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
Subject: [PATCH V12 3/4] rust: Add PowerPC support
Date: Tue, 21 Apr 2026 17:39:57 +0530
Message-ID: <20260421120958.190430-4-mkchauras@gmail.com>
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
index e93df95b79e7..4ac897b650d4 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -285,6 +285,7 @@ config PPC
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
index 2a5428a5503d..c90811a2f564 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -400,13 +400,15 @@ bindgen_skip_c_flags := -mno-fp-ret-in-387 -mpreferred-stack-boundary=% \
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


