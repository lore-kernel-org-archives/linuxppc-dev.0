Return-Path: <linuxppc-dev+bounces-20126-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 35D6BFF885D
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 11:01:00 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3NzG6nW0z2yqc;
	Sun, 26 Apr 2026 21:00:58 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777201258;
	cv=none; b=HrDdazd7ZHjrRuixvdqyqvSO/FlKOgiFumvBE75D57qumhuUlYF4GWEZU8Z6RYo1qybqfgqvyyUmdChJD+csqCIFjQkhhqUkjuPnU4OK41n/0ERjChTr7U0A3Pp4hhZsR3VDtZ/7Gepz1pqNtbpft+2xED4bm/5ww/Vo39vzfQwhXszozUbi6HT1bmOtKJ9hpjfdU6Re3ZzLpThKQCTAOCCUdSZsmx6bV8yiJ3S8rxdu5M7Q5m/6rsuOxxnIpJvxhkbhhbcBTNdz9ijzfXSJoORHk0LmeQXx551ZEpe5r/pR3xtvUUJleGmiBKAq2FDY5hwBz37kCNl741ojVofK2g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777201258; c=relaxed/relaxed;
	bh=edTE4+K3AUC8N+XPcCOjDXD3S338RUHsqJvIH7+h8+A=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=SLgv6fO4bLMM6mFysieePWFRk77RawY0k9qIs8QkHgeUO5NyyRioHF47DJLm5fvwDmRe+QBhAToIGQOFSOuWc0yQg+BWgS3pnGUz9DQB9lPAQ5C+DFY1YfXBL+AZXCnDTK26NmqL73YPhO8MTG8UzIfgFh+7FuZfj/s0kHHphaaCe1m0X2j3C0HUjrpuc7bABNgXWOfdkJV1p4R7frutfoUY1xNolkjR/Lxu9CcUKPIB4KOTPJ9hydwnba9Ua/FDgy+uvfl2+c9f0V8KYm5QMlwHVQxfPstK5/teeVV00mxCdqr9O0FHAZiK/Qs2/ui7D+pmrgV4DWa1ODWCEqU5Dw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VhHu93pK; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=VhHu93pK;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3NzG1YVsz2yqW
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 21:00:58 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2b788a98557so41960545ad.2
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 04:00:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777201256; x=1777806056; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=edTE4+K3AUC8N+XPcCOjDXD3S338RUHsqJvIH7+h8+A=;
        b=VhHu93pKIIlOME9by1q5WRaSPzmJ0efCURw6UQ/YDpOWxS7+dsIxJOYEDAznQ6+kO4
         HoHcn28ufH8359ASRcmMR3/BrURSV2qLJVqcO5r1Sbe3sob1omUyJSlBqvXZVkUo8yq+
         4Yv762e3eCjRG6qqXa7J21rcK1qpWURJfVXbBICdb45gXkwpODnVnDIqGiODWptGGGP1
         CfVQCbQz0eAwFMQq9FUlKHO/ohJteyvcCfJjnlq77JFpXfCg8vcP9ulaJ2PDz09muOJd
         aQyBHkAP8fuK5u+TiOc6G//XKVP9YePRQlbMfmtQwpqpeia2ngib7yrCjMzGD4xI1iwF
         RHAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777201256; x=1777806056;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=edTE4+K3AUC8N+XPcCOjDXD3S338RUHsqJvIH7+h8+A=;
        b=Qj0d8fEyQg104D0N+qpqrePZNwAf/n7NBWJpVVahgvzaOiqrZ0Ay0YfuKXVqOgsEXO
         M/2Rd7nzqIqhW+xe3k0flSzqERwF2tL1Kpj93ltp5ytQ9ZgNtMjDf9CdDNZs2shfgAD3
         vI1wUnyTKugALCapMnmXL+jdpMy5pOrUABbCHey7v8noW9PkasdtrD3vKC6ZY5gkiETJ
         Zjdat5sGYuVn0nZA57v4hHvUUnnd8OYfdO1dgGzcOjK2NHiq/hsbWt9RiQ3RrSCCC01B
         Fw4kPKHv6Ts54eegVUFkR+DUpi+vgq1KYs9T+HWjPxya2j0X8GjLtHTdX+eueK8lDUzE
         RQXQ==
X-Forwarded-Encrypted: i=1; AFNElJ/j9/PdlCWeDrAl6mX5wu9j69HpjHzEpUNLIrt4LQCqncCWnk+4UvsMcQ7z/dhenabk0ZM+8mxPu7+XHHA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yx1XlcgRHVBwNvLTzYlsR1V45HnAiOW+rW6xfe0eCZIZO5RvQPt
	rzTvk4+xoiZA0IJ9CUqe4wGuM48rJiLdjF8cRiOLzrzpRySrIhq2XWco
X-Gm-Gg: AeBDiescYwivsHK6TiE2WY86XMFuxuKrq9JHKg18s2CDZedg4JjGKyVO5wES+e2SebM
	QkPTJQUSWVt1lhYNNUHt4qPU4HmyuoIaCejOpwM8G2MRXxvDkdkj/LU0l5wPNxcJc2v/w6WIrx2
	Tq9eNJ+YKuuhtWVMUkggiexgHvAERG/i7KrfLYvBK3jBwmwA4xaucg48ibbWNXDSUww+vy+8tAk
	YzVt6Kp1TypJFfHkim2ZW5PBI4BhQkiw7BF4NMUOhZzPXwWgmZVRzt50ht+cjkW2UszVTHYQfge
	fNhPs089PFoemkC4qVqFwQBAFODgBOiYD6F3JGO2V2Dn/Wf0d04R4ZRsJcnokL5WLQLnRTne3zw
	7GFEL/HpOe/qpMKcFalUi72JX6f2kshazYh5GhRVE0oW7dnV1Aa9wjQ5lgJXs7kS3pD3YdpZJe8
	iIBSFyRps0mzxeEASLGii/9tc1+qofa1VasRdeO7PvzHNxTu39k4QGuxeY9AzwGcb5gzOeS0HaJ
	mnm9iG4eWX3sCA=
X-Received: by 2002:a17:903:2284:b0:2b2:5822:7a70 with SMTP id d9443c01a7336-2b5f9fcfc2dmr396373895ad.38.1777201254932;
        Sun, 26 Apr 2026 04:00:54 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa2f129sm256667235ad.29.2026.04.26.04.00.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 04:00:54 -0700 (PDT)
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
	mark.rutland@arm.com,
	mkchauras@gmail.com,
	lyude@redhat.com,
	lina+kernel@asahilina.net,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Cc: Link Mauve <linkmauve@linkmauve.fr>
Subject: [PATCH V15 5/7] rust: Make __udivdi3() and __umoddi3() panic
Date: Sun, 26 Apr 2026 16:29:30 +0530
Message-ID: <20260426105932.2270364-6-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260426105932.2270364-1-mkchauras@gmail.com>
References: <20260426105932.2270364-1-mkchauras@gmail.com>
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
index 44ec1634714a..d70fb186cae9 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -616,6 +616,10 @@ ifneq ($(or $(CONFIG_ARM64),$(and $(CONFIG_RISCV),$(CONFIG_64BIT))),)
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


