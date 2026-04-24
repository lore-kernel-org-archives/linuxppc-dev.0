Return-Path: <linuxppc-dev+bounces-20037-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 28EDCFB44A6
	for <linuxppc-dev@archiver.kernel.org>; Fri, 24 Apr 2026 05:48:35 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g227j3Wjvz2ySc;
	Fri, 24 Apr 2026 15:48:33 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::634"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777009713;
	cv=none; b=OBudmSDoDRPKPqsWICTMJ9dgzuA/YCRFoElQF0c7cfB6fYPP2ncqe5qYAM+f8ETKJjRfdRyUObG7C0Jft0xPydHp3Wpm4EvTKGl8zasSUjWk4y56CY+w7pMI6uY3Z0Zueur7B0odUg0Tsa6iLn2pVFx88DJtaFJeFMQfiAwxrc07EDsKp62lRQGV2WSU6pcPYDCXe10MRGOgk2+P4bfoaiYGKZlB8gcP0/Cyy9SeWAkQIvJ2975qN64JwgR9SPMVHAxCR1AYtwIThgGiaAfntt9nLqPSI/UAUFTAlIJ1vOJVewQ07dybR5ee0FIaqUUM9jpK8KHysIGC0SUSTSaaGg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777009713; c=relaxed/relaxed;
	bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=kUdFb2WxryRiGEfLG//oO+9eJbwuzp1xreVPYV8lHGBOtsjVyzBhkB+6BgHhGwy5SbnwjfhIHGKtntIdGN9GXZnROWGQHlu9El5CJ/lfLn175EQF3EaKN14+Eq97PHZ80qbukmOO4ANm6nJ1i7FotYe4dTYtJtoDcdtuzBlKveuzpfaCAcyYMrTip/J7pSiV7uUhF6mHWexOIP8k7CF54CtWjWRZ59X1ZLXxygKe/0cFKGI791+xOYclWQBobAjJJx4bfIgXJsrbAi4gTdktHwW+D8ukEEcVS7ijSCP1r+1AIQH7QGsqR+zUgbCjBW3dn9mF7V/41GVkePyDEpTy9g==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kyLCqN99; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kyLCqN99;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::634; helo=mail-pl1-x634.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g227h3jl2z2xfR
	for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Apr 2026 15:48:32 +1000 (AEST)
Received: by mail-pl1-x634.google.com with SMTP id d9443c01a7336-2ad617d5b80so43610515ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Apr 2026 22:48:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777009710; x=1777614510; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
        b=kyLCqN99nXsxzIt4Wl9wVcR2mC4EU1RSF8NcgzbPEXwgkiODgkOJJweCAWP+XKvY0w
         JAi7r0MXSbqzlJH4qpl+v1QwljNFPcHRLnstqCWcTnEhnH55+aL+B03avw15aEi9al3D
         4rCs24EVC7nP46cwiAocJcfGxa0jdpk0UFBAhVEXCwxJ98u0zpqBUw7h88QAHtLy0A2n
         e6oBzTRMnAZ+bmngHebo5BX1e4hjoIYdTIln/3u+weBH8y4SMTtb1FId5Q8ehVLW+63j
         h4h21YNslaq1aNbTCkPMkrmKkJJ+chncbp/6EG6STExlMH5efVNa9OLwblqNPsn3scNe
         fjug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777009710; x=1777614510;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
        b=Jt4xaeVPnG9YnfvmI+7RK3hdKXVT7OXZLJaLZ2Hl1AO+GktUs98EDH+WTCbepuo9lK
         /+BM6IaHUUym2HSpqdWIWk72fbaL524aOEyWSjzLxhMFxrt4IZ+wQQ10VGCWdJOU5XS7
         mFtk9Yqc/zr7MZY0SUVz4n+QRVGBtAIi4gQz4MA6doJ/M44nOTsQdp7dETJEKtcJKrC9
         Q/4ka1iESC69K5RKNpuPXoLnQFLwU+rCijFNPe4LlMeYm/wCX3CVWC+NuHCewDoxkMpH
         8t6Kk/YtlL6pPc/vSSWOZ1FpriRCNTRdO39MSpJBll3feQK7iIwxfFAi0ZD2NqM815x6
         FTOQ==
X-Forwarded-Encrypted: i=1; AFNElJ8bWNN2uw5hipCSIrQ7u78DjOh7WYdpy5SaaCdu1cp5mDaiJDDS/JGAevkWxwr2G3Ds++5OjCm+ZXG77YM=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yw37cI8D91mN5AQvX0pRgmVhglSgkJV/heKjgSFG4fsgXcfVVi0
	cB0mr9mR8UjPGyB+/6JbAruy0vWPvuwyNwNZd76vWLPT27US20503f+w
X-Gm-Gg: AeBDiet52Dgh+u6xmnZw6hTJJB8lUtqKX/+atYRt/0NBmPhqTqEAc1kxDJ9Dh8P3oC6
	7IF9otst1PP4nN0D4VlUUAOIFAYrBNL4NxENJu8UIgcP9VhFVl5Cqxp9KQKugbSncWKXawvfKW4
	NO8TLI0ZhahbNXYOBVm1p4p/R0sGoo9YM1b+cqMjP3Gco6yy/9uHGaXwnep/L6bm3dcPF/InU0c
	vKlbhORX2oR51yh96W5CHkWrOcEBMTZS0W0K8FXXwu8xWuXMQIp8KH0MNj4f5Jets7XmhapT12P
	h8u4HTs5DbcRbx5gNAqdfwOzUFFyb7AB64kDYR+c+9n9I6tUYbO55GzJ7oCTL0NfLYFr0Ky7wOo
	psoYlgSKZlrRLJuCPWtheiuHIP/ErN0k5F8n+jKlscqblfii4OIer1yRF2FoXT1s11P9S/I9H0b
	cURHaSRUiS7QhFSOzd9oQ3UuVRANfsld1xmipYc7sRqa3aBLeNR24wAjI+mLFNQq8aQCEtRtH1d
	KCyfZSt2ijBiAs=
X-Received: by 2002:a17:903:1a88:b0:2b2:5ec6:dcf6 with SMTP id d9443c01a7336-2b5f9e85f20mr310774475ad.8.1777009710516;
        Thu, 23 Apr 2026 22:48:30 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b5faa176e9sm208778245ad.20.2026.04.23.22.48.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Apr 2026 22:48:30 -0700 (PDT)
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
	sumit.semwal@linaro.org,
	christian.koenig@amd.com,
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
	tamird@kernel.org,
	arnd@arndb.de,
	nsc@kernel.org,
	mkchauras@gmail.com,
	simona.vetter@ffwll.ch,
	linuxppc-dev@lists.ozlabs.org,
	linux-kernel@vger.kernel.org,
	linux-media@vger.kernel.org,
	dri-devel@lists.freedesktop.org,
	linaro-mm-sig@lists.linaro.org,
	rust-for-linux@vger.kernel.org,
	llvm@lists.linux.dev
Subject: [PATCH V13 3/7] powerpc/jump_label: adjust inline asm to be consistent
Date: Fri, 24 Apr 2026 11:17:38 +0530
Message-ID: <20260424054742.45832-4-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260424054742.45832-1-mkchauras@gmail.com>
References: <20260424054742.45832-1-mkchauras@gmail.com>
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

Added support for a new macro ARCH_STATIC_BRANCH_ASM in powerpc
to avoid duplication of inline asm between C and Rust. This is
inline with 'commit aecaf181651c ("jump_label: adjust inline asm to be consistent")'

Co-developed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Reviewed-by: Gary Guo <gary@garyguo.net>
Link: https://github.com/Rust-for-Linux/linux/issues/105
Link: https://github.com/linuxppc/issues/issues/451
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/include/asm/jump_label.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/jump_label.h b/arch/powerpc/include/asm/jump_label.h
index d4eaba459a0e..3016e9c8d6bc 100644
--- a/arch/powerpc/include/asm/jump_label.h
+++ b/arch/powerpc/include/asm/jump_label.h
@@ -15,14 +15,20 @@
 #define JUMP_ENTRY_TYPE		stringify_in_c(FTR_ENTRY_LONG)
 #define JUMP_LABEL_NOP_SIZE	4
 
+#define JUMP_TABLE_ENTRY(key, label)			\
+	".pushsection __jump_table,  \"aw\"	\n\t"	\
+	".long 1b - ., " label " - .		\n\t"	\
+	JUMP_ENTRY_TYPE key " - .		\n\t"	\
+	".popsection 				\n\t"
+
+#define ARCH_STATIC_BRANCH_ASM(key, label)		\
+	"1:	nop				\n\t"	\
+	JUMP_TABLE_ENTRY(key, label)
+
 static __always_inline bool arch_static_branch(struct static_key *key, bool branch)
 {
-	asm goto("1:\n\t"
-		 "nop # arch_static_branch\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
-		 ".long 1b - ., %l[l_yes] - .\n\t"
-		 JUMP_ENTRY_TYPE "%c0 - .\n\t"
-		 ".popsection \n\t"
+	asm goto(
+		 ARCH_STATIC_BRANCH_ASM("%c0", "%l[l_yes]")
 		 : :  "i" (&((char *)key)[branch]) : : l_yes);
 
 	return false;
@@ -34,10 +40,7 @@ static __always_inline bool arch_static_branch_jump(struct static_key *key, bool
 {
 	asm goto("1:\n\t"
 		 "b %l[l_yes] # arch_static_branch_jump\n\t"
-		 ".pushsection __jump_table,  \"aw\"\n\t"
-		 ".long 1b - ., %l[l_yes] - .\n\t"
-		 JUMP_ENTRY_TYPE "%c0 - .\n\t"
-		 ".popsection \n\t"
+		 JUMP_TABLE_ENTRY("%c0", "%l[l_yes]")
 		 : :  "i" (&((char *)key)[branch]) : : l_yes);
 
 	return false;
-- 
2.53.0


