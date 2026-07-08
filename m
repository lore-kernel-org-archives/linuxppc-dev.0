Return-Path: <linuxppc-dev+bounces-23787-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E13AAC43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 08:26:17 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwB544L17z30BJ;
	Wed, 08 Jul 2026 18:26:16 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52f"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783499176;
	cv=none; b=fPmu4lIANMg8W6WQESUbS5BhK02TDv+uwYa7+Sqxerpykz35X8BT2wYF8U0Atz1UV02OIootLBCfpVliJHGNtgYH41oyxcJpl1woBg6Ngzm6+YCimUzlVwusCtja2B0ZLEjT5kp3yw47J8zUDr064U2LJiq7CWlMRS/icZ/LktK5Gt3CQAjfA/lebtmbE1sLd13BrzrhA+lzc+ZjHeT0pcOGGmF5wiMqOJ7zKBAQnHGhj1Nh+bk25VmxraTWtCOJxhwUyGTkNOTYRp/p02Zak+yIpJM6gsqT0vSFLC3cVDfSSAqzu4VmZP2Z2/tqWR3S4wC4Gk540y5ZEqti0UE0/g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783499176; c=relaxed/relaxed;
	bh=pXAgQLPERGwooEzHznzvpg6SzocRRloWRn0CUVpxEzA=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=WLLFcJPeivuMoWmbfA6eL49JDOpgmXX+/hna2oWURnzBMsmcw6XhghLNfisJHrlk5sawj54tWadwagCVlS1kLWwufPorNu8F7frj05+xovdjWYNqWKlLFPDImrf9G8jlQYSt3dS0dBn/JVEY1pq4d1vUCj9Ne2ADqiU7mUM+DcCZ0Q3qZPRNSuseJ+kqVALPmMDg3jVk3uB/Cri+qmaCkRS6FAMqegvt9UdA72SP3EG9CxdMdDUImgh7H52vAHnYpXe10OXOtrWA9uaFwn7k0o8S0SgdwKia8N7FBeTflDPbI3QXnhj+WSx10l9CQbYUVnEx2ZLmJ4GMoB0k9sqdNg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hVBSzzLB; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=hVBSzzLB;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52f; helo=mail-pg1-x52f.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwB536jDxz30BH
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 18:26:15 +1000 (AEST)
Received: by mail-pg1-x52f.google.com with SMTP id 41be03b00d2f7-c88a4d79ba5so226479a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 01:26:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783499174; x=1784103974; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=pXAgQLPERGwooEzHznzvpg6SzocRRloWRn0CUVpxEzA=;
        b=hVBSzzLBqm0tG+6uXpgXzCW6z07BdTiTI7Cp2sEyi6boEon2VpQZw5g26TR6oThkX0
         h7jVGOMIDV4F9369cUaSYWLRRbl08B8L/9Hp5js3OOUlAafhnuz6OeSWhXazOvBy2Pfc
         mPK+gJMF8D3SqystxJ7Gb1S6H9mxlKUYv1b8+UhjFD4+3vE4zRTXDbu25MSbZc+pb9xs
         TgQ0HtiuFAY5Qj9PtcvqPJuCI0mzpsy6Qtwojak1JKWtGu73T0pe9/Q63GhXB0yHQ2B/
         hu/EV0FiZ2R9mH7Gx5/X7BsQQzZsTN6TabuGYhJgx/u270WXB6jbvbaM1RYwaTIkdVBe
         Eg8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783499174; x=1784103974;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=pXAgQLPERGwooEzHznzvpg6SzocRRloWRn0CUVpxEzA=;
        b=UD43d7H0b5Xn48LtUOAkqaUPJwh2hKz+FZ0tDW+KZYf1ecIXQiHs/QVdhqqKKWcb4o
         HLo+uESX8wJBFqm9QOYehCcK8HYf6lyqtltV/zyLyC/dkOACSh/9gQVDuMItahY7p/Cz
         6kfxE2bDcptCsMzDr/ORAJITLljxTa1QAGRRhr7jgyhsp6gQBUWvqb3Y/Y/L2rwXCXBX
         Tjy7OAUhiao5xm00su/4ffJ1y7gkZ0f6FvMBloLe57cAnQHclMgzlL4oJnp2JOXf/UhW
         7njLiBSjW/YSkRPuvkI4cDznWgf9xmARyUfbPkG6FlPT+pg3JJk6csZzzqlJYaCEcXaz
         a2bQ==
X-Forwarded-Encrypted: i=1; AHgh+Roe5Rx528+ThgEbX2TKzoVM9XYym89uJIoxLo/EbhRpZrKENlYGPM2JVLSrVfKJNVw6jG5/CIV73M2uZJE=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzPnh1CYdmzV8sNiBfpp6DB7vmk2BIGQ3QinAjccR1g27a/tP8V
	kd2GLi6DVOwez+mj100eKZnIUao1WDgSn6vwgKMxdkSb1kvSKelFmOWh
X-Gm-Gg: AfdE7cmM+3nRB+Awa0GTQMTCtUBNMzl2NsOiB+pp2HpFA27lCgjhe4YMpQYyaBAJFPN
	tInKSKUBDH6bM18nMnVClLTW/86ZGlOblqErrHMgzNKVOIrUpwYx6usaUqc5FOjZzTN3AiZCFOX
	9qOEmoJEgLgrQmq8z1Osc6Z9D4UgSqcrfpJ9GqZEuHaT4UVoadvVpPCX5OUX8r+OdhkhOwqJy65
	gt1pIAAbUX9+MTOb3MOy5Do0t7gEqUOC3Cr2kR7XMP0RwR2nEtGGZ5EeioMxdMUhrn0+LmhBjbp
	KbenSv4rtD4HfthnLpwBhMWg1OfY5175Vp3GjlRKNWnikROXZLuZMd0AAKbZbClTLVIj6sJgCrb
	YUIn/fsQD+2CQRR9MR3Ko6n+hS52GijoY1CvPSfna0T0pGtH1f6PAk5haEDZ/ng1vwgXbfUTPip
	UOgGoxMbTPcHHEepyz/rNkI67WwSUwzucxxeIPjv5CbjXdjJmhN/MhZmOSJ1AxW+qqUA==
X-Received: by 2002:a05:6a21:9148:b0:3b3:f46:1eea with SMTP id adf61e73a8af0-3c0bcbe9c3fmr1852518637.7.1783499173930;
        Wed, 08 Jul 2026 01:26:13 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm19975117eec.0.2026.07.08.01.26.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:26:13 -0700 (PDT)
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
Cc: Link Mauve <linkmauve@linkmauve.fr>
Subject: [PATCH V17 5/7] rust: Make __udivdi3() and __umoddi3() panic
Date: Wed,  8 Jul 2026 13:54:52 +0530
Message-ID: <20260708082454.1254320-6-mkchauras@gmail.com>
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
index 17b2f329c13d..7aa8fcad4c43 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -677,6 +677,10 @@ ifneq ($(or $(CONFIG_ARM64),$(and $(CONFIG_RISCV),$(CONFIG_64BIT))),)
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
2.55.0


