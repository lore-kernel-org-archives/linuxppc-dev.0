Return-Path: <linuxppc-dev+bounces-20108-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 80C48FF885C
	for <linuxppc-dev@archiver.kernel.org>; Sun, 26 Apr 2026 08:58:23 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g3LFp1ZtYz2yng;
	Sun, 26 Apr 2026 18:58:22 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102a"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1777193902;
	cv=none; b=CXVJIiFaNiW70YjzET8bYfCBzzgV0DiGQrPQ0Tc/Ekde60EztFIMGYQqLl9Ugyte39zQ2v2KcbuGsp6cxTJubiD6Sp115T1DjsbFB1jcVCXXyBZ1L9ANpw7JcfHMn4/05rw/HcFXiffiboOoO7Ebs2OsEYAbprDW0942ecWbnBE8buPWvdTfiebWCY0U12QpOW8p2jm7oMpu2W9J+mNQsAYGZsYuHRQa5IPiCfzhZcmIoejJQ++1hGu5I79uPHFiVsTyzegkqK+ACnhuxzaAvrDUeoWJ3wdNiOAdSwkWSKYg0N3O2KKnGvP/oJ/YVbU+e6ofSJdpcl0aIWo6+oBO6g==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1777193902; c=relaxed/relaxed;
	bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=ZjaFwTJxSZkJ4nKUAX7nyyG+MhfisO9I7b+uhjnHDcOf624AJtT2j1x66+rX/IwfGHyHfHEBs4Oog9RxMyZL3uDjBaG0rUXZt/2NDkNtds57bvx1fPp2wgcjHugJ2J47vH+ipm8/IOEi6HEr0AJYfO9sHWiJ6A84hsAAiwb3I9f5D5OEr2StBOIRr4vN6k4tboHFMzItR5YFo+qFp8grFHvEz6VspIwRz4HMT8Z1etpqHRILcTzvGK1FrGL3siH35aKfQwfdIkwkLTFasAJXSzQGMht/5S9QuYceB4lXFKDLOyAc2HR8HBfgLAdNd4HyH/oxuLlBl3jccySivLHqmA==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hz1QDeEv; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Hz1QDeEv;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102a; helo=mail-pj1-x102a.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g3LFn4N9Lz2ygY
	for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 18:58:21 +1000 (AEST)
Received: by mail-pj1-x102a.google.com with SMTP id 98e67ed59e1d1-362e30526f8so1200881a91.3
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 26 Apr 2026 01:58:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1777193899; x=1777798699; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
        b=Hz1QDeEvFYKppmQPolS0whae1jPg+v+uPa0QuXYl8a0fQq5xvh375UBWksWXTkVyyt
         nFYQ6xAiK8U/Hpq6UWfeW2sci5lITdUR6mJTabgkbZdmSaHlWUfasy7TBrw7ivNqAk0O
         MyMedsfgDLBFu9buu58AaBZwi+PSTQd8qmsC/gzOEpOpechRQS0vFjeoRlI3Xbu2ACG7
         l6Mn7YT4RCPRkkT85kH0tkQ2nmPtsZ7ihFuUk7aP8AJtiJcUdcOtZ4S24EI6G6QwVvFt
         VRBTDX9XskfTbEN/7HMkrdbvA5uWGtU+zXng0do6RELSB4QHQFRBlrTiRTT53h1vVjPG
         5WiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1777193899; x=1777798699;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
        b=PczEey4LTZK2OFyEl5+9ufJ4EulpREsJitYdSuCmMATUeRJ+J7DVOG/vgijJ7HHRPV
         H/xQrtqGdGHW1JfSQ/DJYugljzQFFA/xteh9ZJkGXX3+RBjgxchAMpKUiHAM94aE+8on
         OLXU7zyBicFOkGFKkYw6Nhy3dUbkUq82MOmo402qfDYWOCrERpJ2htTf1U/AU/iS0IzA
         zmxA5mW7MZtmexm61TD4Ae6Smn3o9beR2kj+eJocKXGyLdzYxLC85SPZm4RTBppg9a+S
         RSi8Yni8rvbEtLO+EYavC/uQokdBEN8TLqTD28/Pwcl/WRI1E/5hBfTcJONJ5i1bykmM
         lVBw==
X-Forwarded-Encrypted: i=1; AFNElJ92G2Q5a3tVTIB3heykCqWNMMb718b0CGD9UPUHZ9OjMfamWZtReG5IPsW1xjbhA0UL/SdTAminp0+OM5c=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyFFU/oEqaEtJcqNDqn0a819CUpEr7gZp+kBdrV3e+a/F/uqLQX
	cQfl8hEvyJoJtHuskD/FfmU2mwSaZ4mHg6KhgZfCkteMZRxaRTWgTyey
X-Gm-Gg: AeBDievLu0/gW5KKue2H63vvxCQAT+6uXXfemAnC6DFF1ob8M/MoaXoXlWstS0B1zef
	H9wbxSf2H7HgvOD6BgQxVYBgNgriC7ysTKj4nlIiVkzXqoHh55ViOQngMlgH96BEB1+84dndTnm
	hNNFucMEspIZ+ohN+OkG1ZuRPE5jA3jjWaK+A8jLRGx/Ud0QOxz8PIThAyiJ+aZj18A2xTHUK5K
	CQNkDqKveZJCqvVccYkRofUq4ATKd+JYBqdxlHP9FYIkqwuEyh16qjfA5+QyJKcVU87C+3JV5mP
	ajrLH+rqO+IFHgh6XeUA735Ka+aIofxbUkXin0zo6HtW6Al9yFR8HY7yDt9FiR1X5cTBDQWcv5E
	5lOlFduhFRezsTNkrK0Otll8ysuTHV3wBE1BHFQDrC5IyGSleHL4xJhsxX3QXxxNOv+Nw+d8gpA
	z7GS/ii9ftLHfxtUSeav52E+hHXJKm54zvKF3+HK2kOgOJUv8YE81SjeDK9re3Myv/rGXbXIWyb
	77L3t9bI0mfen4=
X-Received: by 2002:a17:90b:3f47:b0:35f:b1ad:fded with SMTP id 98e67ed59e1d1-36140474686mr40098125a91.18.1777193899315;
        Sun, 26 Apr 2026 01:58:19 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-36141868906sm27718937a91.3.2026.04.26.01.58.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 26 Apr 2026 01:58:18 -0700 (PDT)
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
Subject: [PATCH V14 3/7] powerpc/jump_label: adjust inline asm to be consistent
Date: Sun, 26 Apr 2026 14:27:21 +0530
Message-ID: <20260426085725.2090827-4-mkchauras@gmail.com>
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


