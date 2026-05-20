Return-Path: <linuxppc-dev+bounces-21212-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id E7095CD4F5E
	for <linuxppc-dev@archiver.kernel.org>; Wed, 20 May 2026 06:47:54 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gL2D93HTKz3bqQ;
	Wed, 20 May 2026 16:47:53 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::1032"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1779259673;
	cv=none; b=iPQ3c0YJVu7S2fKpNb88Ufkq6MzFyUzZLeLzIswN9QPrdVbbmYz4V2igtIoFt+uxQyrJoJas9yulNQYLrGmFf1D0f0phDicd7kd+w/4a6pgZNKmPZtWHiAl23BKaec+5mT6GdnPseNGzM5cgkPq88MOF+uKPqlMojbUNCW0hxoax1u7akBd2fGpPNF0oZMMP+rxo/mDtEr3/T1pELb/xKFuzKXwrYxR0NZqUoLvpKRCLtAh86ZV16FH/dHskEMWuUTfuegwDmNTeLT7fjx7qxsM3AdkLupJqhZi6lqDxMwXIHWzHkkX/n+sh7jKni6JVhtVtAtwQNCZ0WI8ZyPOrxQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1779259673; c=relaxed/relaxed;
	bh=DwFpdmrQysTo8snbwtDD0b/CRHKgzW4YRIXP8JLk4/Y=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version:Content-Type; b=EBbf7WrcBmcxNq32sM1iG9WZ/FrRO5fR7z43657bwBQx4jVmeplStYC7QaUlUzQp7g2S2eNJBZHfI8GEqikBY/VCPOrioJBDmT88DLqDnSl4zEIJlmtbXet8LNcpNtjlq2Zlcpy5hPwVMBmdsgS1ihIFgPp7xQV9tewINQoM6jkjqTFIG5hOU0Qqba+6QBuX1V9XxnU/dUtz1p3gKScXW5eksAGNJtz3ncOpIJVWEQZpTZDy3/WLpfC0jfklUABZpC5G4peCrAhHwVQoYssXqRniwjhuOq0Jg4JhUBr3SdBXkhexl/1IIretnORXDoFipSxjewIzivDd5fl6ZUh+ZQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pAZZDqWz; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=pAZZDqWz;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::1032; helo=mail-pj1-x1032.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gL2D85MXSz2yFQ
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2026 16:47:52 +1000 (AEST)
Received: by mail-pj1-x1032.google.com with SMTP id 98e67ed59e1d1-366330b6751so3543705a91.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 May 2026 23:47:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1779259671; x=1779864471; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=DwFpdmrQysTo8snbwtDD0b/CRHKgzW4YRIXP8JLk4/Y=;
        b=pAZZDqWzRvXerABvt9oSmO03DD9nTr04lBwqb4fuBTSBGuAxFLuEM2gu3+rJMgXUsg
         nwfjlRhViCGOpyJ0b7tz3H+mEn49RfVEURl71lONv3K16LBLE7urXHGkAlLWnocNh7dK
         oPcY2c7zHjdD6owcBHxxAy6q/YyCbtvh4MBoNoiBy3qLFU0mf/dyecHid3p3a1uk2VWd
         7nIuyi2OiaXSKG4iJlaD/haDVAFTvKDbA455bXO5DejZ75ecW+Z1XuCGSoJVvFjIkiho
         Zhy/e06lItmLWSickEkPkRerg1pXht2ewSb4xKGTKXSiPt5mr6nNpYbv0it8GVUMwXsn
         ndnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1779259671; x=1779864471;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=DwFpdmrQysTo8snbwtDD0b/CRHKgzW4YRIXP8JLk4/Y=;
        b=mFYyTUsGqUbbNiEEI7J3JYgfm7Pd9COmzY2sr77mLbYYBd4zogVZn8fS9TEMXxICFU
         DDGCTc5TNoyP/mkIP2bxgDa0UnsPPvoE8aup5aISTy7BY/jisOzUPEzc9fY6/3bD89GV
         O3lmyIxs3m9waLY+Tte0pN1mvYTE1o4H2nh3dgm5c41oKXDDo4tJnNlXaqZyfHbe9tZT
         bS6GuZTjwt6AnN9uE8d9XTl/ttrx6c8kgXCR03+WvWakjFgiCmitnKnTf/d020wQLQE3
         cYicmtl1c9Bo3sYs+ZC7Jvhv3Me7Jj9utgn/QR+vPWHzNeDRLvKyzT1o/VxO72Mue3HQ
         ju6g==
X-Forwarded-Encrypted: i=1; AFNElJ/sOcjm4ww06qWdAWs8dUbzG9qho16rCNPxK2/XL3y67i4Ikioq89xHmKGeYvy11ueM1JFpSctpn3/SAGk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw3xmMqJuvVEnN2kWQwt0mOlXxc31qDLbYWWfmkfiybU+RNVUVS
	iLFjfvFUd9ouIWN27k2UZ+OljVYMXT+Su8AuEv4AUeMopfrtxw3NN+e3
X-Gm-Gg: Acq92OEhcJ+QoZYGirAip4gUjiEpxnAYX/iByqJ85VDSpBlw4sMjVkPDn7EjEvZQx3g
	CfH5sfVdy8zFs4NiJiQNHrDr+165rYdtskHx19WLK/e6HmtOT+fS6i04eS+AI9GYezuz0G3AWWL
	O6Gkeak9/08WDtOxe4lSGjEZD+BJZQMR8epvpABtfKuR08+FGrRdHFg3esLVm8z580pkgYahPTi
	d8yJVVK2fsCREWKJzxsnWuBzFSzCPxQgP9QgU/Sns5E8r5heqHyAPFLvJATVxGK+4rJjQI3zJPf
	ssqhhdGUTzxJCU3gHAWh1SyqNmgKUlkSdeQyND9TAcvCgoV6nPHjBe+7eZhr8k7tpzYMYaViwX1
	xTjpYke4j9n3C+OHZ0Qe05flmHmO7nPNSdDhBR6unZ22BgbPYj1gNfFg/dwSIZcso8PRu2BboHB
	vYfDtm7MlGF00k5+xIX9P6r+R7UZRbIqFWS4dXCbqY+8KocrNOn0WF5KDwvSocLzpH8mymDECM3
	seQ
X-Received: by 2002:a17:90b:5290:b0:368:a297:bd38 with SMTP id 98e67ed59e1d1-36951a044b5mr22090513a91.7.1779259670620;
        Tue, 19 May 2026 23:47:50 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-3695a0e93e0sm6069970a91.10.2026.05.19.23.47.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2026 23:47:50 -0700 (PDT)
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
Cc: Link Mauve <linkmauve@linkmauve.fr>
Subject: [PATCH V16 5/7] rust: Make __udivdi3() and __umoddi3() panic
Date: Wed, 20 May 2026 12:16:27 +0530
Message-ID: <20260520064630.1785283-6-mkchauras@gmail.com>
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
index 6d7ed7a1ff18..8ce4fa0e5e57 100644
--- a/rust/Makefile
+++ b/rust/Makefile
@@ -618,6 +618,10 @@ ifneq ($(or $(CONFIG_ARM64),$(and $(CONFIG_RISCV),$(CONFIG_64BIT))),)
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
2.54.0


