Return-Path: <linuxppc-dev+bounces-20110-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 73C13FF885D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 08:58:48 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3LGH04gKz2yqW;
	Sun, 26 Apr 2026 18:58:47 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1036"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777193926;
	cv=none; b=KHFDx9SRDGOKKFlmZyvRS27A4KAd1HY2eMYGnK/blEiHtOj/CEOqGjf+6ThC983m5qKSJlrBXB/UBR8X0DCOdfNeYOuZnGyq1EW1DRq8NqAN2+H54e2UPLTPLHXd3DPSAQDaLuViQlF8xvaFT/wenwkIihGMLeUCdUrRxepY4dcSCCl2uUTfELrcVuKuAaoV+9fecRkAf90dnTC1SnkuNlvXg3Qz4UT4vN5wfaT6R4jphJFhwxnqHAsqWr+ihlpDoZqbg5oN1beYkpi2b8+UQkSCZdRx91kqc4ZdBlK6EFFca7w6XnyBlKRG6y8ay5gQuuIwJzJHgvyUD6DQL/M/xQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777193926; c=relaxed/relaxed;
	bh=9SYhnvPVAJd1oaQ7E3w3ymi0iyxJM6QAUXA089o3vB8=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=oPVmulQrRnRP/s0TFuuCGE95UqllZHzcFQimmgJI2XssRukFLkW5tJ33iu/b20FnWj+DvyQTVeWBl9DVBOsTF9Xeu6JnHdC/QKjPhA25d/u57ztGfkV5XNXbN6F4vuSEy91XoB2NZ5pZemTUpQGO1PK741eXRM9xRvj1Xh9Htk+L5SilsjcVaBOUDJxypWtDLyrbqT5Jm8PQDDWoUuhJjCWXOqgiZqGX6jMODqu7dv0lhVsOA36UypQAlVdqkOS7tNFqkrkfUoBuBO+dsixn9/UP+JoOVpCsUgZcgZ+7zpOFc9hPzq3hibDtwYyCARGUKDenwdLFfWi9ZbsUmLKylw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d0ylMLxf; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=d0ylMLxf;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1036; helo=mail-pj1-x1036.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1036.google.com (mail-pj1-x1036.google.com [IPv6:2607:f8b0:4864:20::1036])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3LGG2V31z2yqT
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 18:58:46 +1000 (AEST)
Received: by mail-pj1-x1036.google.com with SMTP id 98e67ed59e1d1-35fb166b0c6so4960150a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 01:58:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777193924; x=1777798724; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=9SYhnvPVAJd1oaQ7E3w3ymi0iyxJM6QAUXA089o3vB8=;
        b=d0ylMLxfHQYUAgjriyalmh+aXwbmBF78SFyH5lyBitte9J5JkzcUfpyqPwVGQ6SGrE
         ldEdqFbzOqXkNPIVilQV2QdWPMgnZ8DR0Cy3/QuNSaO6LK1LK8rUxD8m6LAVYVE7sy7q
         UNzU6nHogo2tUrg2/aG3nyCQYwDtwNSHa4lAs7Ugvgxh6+1RtSK9hkT2Ddj67eYaxwjO
         6/7G953xyqx53lI6SwHDV++FhEEGxPUiPFDaxDpxKhsnZOcTBiSlg5inqrXtsMTyjP2A
         i/FbGgqCvYnEeQMwPKM+SCJDRcEYWqbQwf6Q8cyfEdCDfIKZihIEkL0Vucs0f+3eE/24
         4inA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777193924; x=1777798724;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=9SYhnvPVAJd1oaQ7E3w3ymi0iyxJM6QAUXA089o3vB8=;
        b=WKAMvVp0XkJertPEyY/lln6f/YRMawPr3Mufi100c1XhPBNotHlbJzadjK8Rhwqibj
         kaVd9jmyoVaWsZtAXOJv7F3i1ZjFfwhkQjvd12HVJNxGL3zGbW9niQYEq7mF6k4B92Xp
         GLqe2C0OhN5KSS5SidZeRe/CTC4bCGmrXZB/Jbx6ytj8wR/mLD6KYy4ES6JdT+Np4niQ
         PlueJyx98wGFqTE5BwkvXxf7cinx4g1GBfFcI0nsuz8fC6lqMmwcfSf/DuG7Bx7WS6h4
         SZ8M4CFDNHR4qbdyhgYmqgdZyNhqdaSDWK1hgV05o0gS566Xzr+JB4MuW4PbzNma5X1G
         nSiw==
X-Forwarded-Encrypted: i=1; AFNElJ8/ODASqUXpEHxg9a8T6/B0Al5WsiJaXUFoGVqJ3jEWKnRNXS97O6h+wGBhXO3hIEPxI+Ti/N1li4wGMZI=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyKgHHC/G1BZ0asFyTvuxhJnszvUhKMK/iycdUARkHzqrxUrKUV
	jC3Wavx9xcki/Eo5gvG7oizeaZcVPyoKyum36xXVd/y1A8B5XXqagQa3
X-Gm-Gg: AeBDieutcrMjcVMN6VFTpL3CQKds5+nmwRsEiWBdCKU29qMQc5ZDsjnFEUgUE5nRofs
	JFeL57i5G1eVJurwwsBrEpyYYTCdW0DHGrG/QqxDn+1cNTB4xX4QmuRBO+f8iorqxSxcvx2nhqp
	06o29qqY9zWfE4Se24jTOKqdheUo2EtozCkn27dN8OTcVCThL/uNWy1w6re34unHEiTwpt9fn4j
	vLVJEGnuYAwR2LBTC6jXfo9IL2WVSnNmFDwW+cPj9fKTv07jxlF1HnV2fAAYPrl/rmtd2talELH
	yNq5GGc+EBIc7t1hLH8gEebxesA6mfSuqzXLaznj1AdPP98rCr4C0AWDjtr2rY1ZARoe6+GV9g7
	dKyxXHWfIYhI0ZUrdrf2Q7FWacBqfhmT3NDNaikknMGLjbgBUXZWVpvkqzPuhjsIeApkujciwYZ
	Vl3wvH+Jhwf4qX/CMDQPiS1V825ZfuFdAy9GnTbZMgoONvKYxmhn5x0n+5+i+LsAlaUMSlX/tL3
	e3FF4iQOlaFpPM=
X-Received: by 2002:a17:90b:52cf:b0:35f:b9f1:fded with SMTP id 98e67ed59e1d1-361402edcc2mr27986180a91.12.1777193924145;
        Sun, 26 Apr 2026 01:58:44 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141868906sm27718937a91.3.2026.04.26.01.58.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 01:58:43 -0700 (PDT)
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
	fujita.tomonori@gmail.com,
	viresh.kumar@linaro.org,
	prafulrai522@gmail.com,
	gregkh@linuxfoundation.org,
	arnd@arndb.de,
	tamird@kernel.org,
	mkchauras@gmail.com,
	lyude@redhat.com,
	airlied@gmail.com,
	j@jannau.net,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Link Mauve <linkmauve@linkmauve.fr>
Subject: [PATCH V14 5/7] rust: Make __udivdi3() and __umoddi3() panic
Date: Sun, 26 Apr 2026 14:27:23 +0530
Message-ID: <20260426085725.2090827-6-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426085725.2090827-1-mkchauras@gmail.com>
References: <20260426085725.2090827-1-mkchauras@gmail.com>
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

The core crate currently depends on these two functions for i64/u64/
i128/u128/core::time::Duration formatting, but we shouldn’t use that in
the kernel so let’s panic if they are ever called.

This doesn’t yet fix drm_panic_qr.rs, which also uses __udivdi3 when
CONFIG_CC_OPTIMIZE_FOR_SIZE=y, but at least makes the rest of the kernel
build on PPC32.

Signed-off-by: Link Mauve <linkmauve@linkmauve.fr>
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 rust/Makefile             | 4 ++++
 rust/compiler_builtins.rs | 6 ++++++
 2 files changed, 10 insertions(+)

diff --git a/rust/Makefile b/rust/Makefile
index f6369d121c50..9aa18cff2fae 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -615,6 +615,10 @@ ifneq ($(or $(CONFIG_ARM64),$(and $(CONFIG_RISCV),$(CONFIG_64BIT))),)
 		__ashrti3 \
 		__ashlti3 __lshrti3
 endif
+ifdef CONFIG_PPC32
+	redirect-intrinsics += \
+		__udivdi3 __umoddi3
+endif
 
 ifdef CONFIG_MODVERSIONS
 cmd_gendwarfksyms = $(if $(skip_gendwarfksyms),, \
diff --git a/rust/compiler_builtins.rs b/rust/compiler_builtins.rs
index dd16c1dc899c..fc6b54636dd5 100644
--- a/rust/compiler_builtins.rs
+++ b/rust/compiler_builtins.rs
@@ -97,5 +97,11 @@ pub extern "C" fn $ident() {
     __aeabi_uldivmod,
 });
 
+#[cfg(target_arch = "powerpc")]
+define_panicking_intrinsics!("`u64` division/modulo should not be used", {
+    __udivdi3,
+    __umoddi3,
+});
+
 // NOTE: if you are adding a new intrinsic here, you should also add it to
 // `redirect-intrinsics` in `rust/Makefile`.
-- 
2.53.0


