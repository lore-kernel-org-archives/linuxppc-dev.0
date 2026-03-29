Return-Path: <linuxppc-dev+bounces-18973-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 3EB82F3D605
	for <linuxppc-dev@archiver.kernel.org>; Sun, 29 Mar 2026 16:03:31 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fkK1B748xz2xlK;
	Mon, 30 Mar 2026 03:03:26 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62b"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1774800206;
	cv=none; b=GlWmZnh5CpnSsIMXmHZhJpycJTJAmhfcxFFCR1oC6/O9+0hs1AIy2LwhUy8uL7pQy1XLFl9cFRbZG2csj6sln8iHqhCyrAbvlkBZOo8oi1Eq7qVjukpRN4Ek6tEAFX9O6X/RKqhaTZ13XgDTXP69h9NGM/OltBPuZwtzR1dlKBicNFRQl/eTpOg8H+bomVBF8Zki/Tj56nD1B9pWaeJMBLZPs6asUXDhwfKIG11lSHtmI2pAJ8A7UXy3xFmlFjQjd5sXG+sNsBs2l0+Yxt/Vg2e5i0Ow+SD7KeLb5AtyOqNmjwhPHfVXgJ2+FtlMb6KT56LgRLi7T9AQr+zrHJBsyA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1774800206; c=relaxed/relaxed;
	bh=GWQDA/EkiuOrnzzQZpTgk67yZSDsyGvnGU0WBzxGHSc=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=EB+V4lOhl+yluGl3Sfn807foC5d2SAyLKwti6HDLkwPKGKgOO5ysZVzIGE/VUAoUwKuBM17QyS7FYO/6RJeg5MfkYUeucj/+OwKBIP7+o7FB+S/Hbp804CkRi7fQOqt9yu8zSstu+k2V5/dM5XrBBqhyYKAAuv5diHbgQ3q5TkJyviVsZQ5YDST8jRrb4ZIrZA1paMKP6bGnELvpQaYOr4qOlVhsJ4ZCFx6AaX9Gk5+PDNnj9mbOXTflUOM9QUvBOtakRSoMMQJV509v9N5cERwUsSwzQVeYBSDUgTg5lHbU+4ytz8FiZuWQ04HU1GbIXYgscHoQ0vHLEUzPoodV9A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ux9OrL31; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=Ux9OrL31;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62b; helo=mail-pl1-x62b.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62b.google.com (mail-pl1-x62b.google.com [IPv6:2607:f8b0:4864:20::62b])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fkK1B1Njlz2yYs
	for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Mar 2026 03:03:26 +1100 (AEDT)
Received: by mail-pl1-x62b.google.com with SMTP id d9443c01a7336-2aaf59c4f7cso15012965ad.1
        for <linuxppc-dev@lists.ozlabs.org>; Sun, 29 Mar 2026 09:03:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1774800204; x=1775405004; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GWQDA/EkiuOrnzzQZpTgk67yZSDsyGvnGU0WBzxGHSc=;
        b=Ux9OrL31n6/jndJjRQrywHKVudnKEpCCa2qoiNs/dsVwQE15s7aAtamg/wBFKOHpQb
         JaiEmBuJ/09jmoXIb1S8DxSZJr5tgZlh3bvTmV/K+sPJzbRbaqzsnligzT8nRlRNd8ia
         ouiuUH8y4e5f43Unq9KVznV+pRjWR3KvJPwVW8Na0y+klVR6Sz8Icf5A6BvZbdwo5kOl
         SqtSM/tNO9iU3NrB+/kbQBgB6RFYhzzSpu/G1Db8E3L2GXNxtbl1u0eyDb4yATbfXHjN
         zminMe0Mn8J2ZIN26M6xLK0US7dLdUoOHqOpxnby0lkpQgc9a6tcOQKfcLFTET0H0nSy
         tRpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1774800204; x=1775405004;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=GWQDA/EkiuOrnzzQZpTgk67yZSDsyGvnGU0WBzxGHSc=;
        b=mtpJg/1UdWssRRWGUJd3XeT+8Bhdp2AQUZeZBTOt75fwiVCIGdLxFe0GcbeleFBHJC
         VplPQA9T7BnhfEbUF27er1mTcAVQas/8JHkKaUov+RKjqmTr/FYwQ2xLSDksOaIYiLA1
         WaQf0aC0dtq/ZUjfrEZ9c1w7f2V3gLGB7aIFiopYTAHOg6cXe8pJXTppibZ78yJ/+fix
         M5eSMfP4DYDaBZwFAw1ek7GvhHCUZelXUKqHF6CQQESfVKAPSVw2kFoU7IfciJs7HRZN
         HJ2bMoPZzAka4SMSgQNjdxVFgcnLh3Gn88K2ZH83A+ld4WGb0/fwzJW4ZtDX6MyCjY5L
         DEnw==
X-Forwarded-Encrypted: i=1; AJvYcCUF7hoX4x7CNEfZzN39FULgCwBKPzFr0H43jF15qLRx6s8p38AiXJILZD5mzO9DE11Xa3IQwMhFcTWsP1g=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzH0VVAHishVR/tJT9UWZv0+A8PFLcieIXlsawIdRqgK9wiJu9S
	xts1v1ihEUoHNeRDUW4J/n5ucUjU41eewcXgNMR+X2V7GsmP3zU/FiZ7
X-Gm-Gg: ATEYQzwMbBq/z9nUvrE5HMONCha83Hw8nGXxQb27A5+tl59pN9itpqZtKV3xg+rDelP
	irW0Nrg0TSoDfTiclKjJhpSORRN55jlhhsoT8jjfz8icC+/gzwlkfSlBe5RR3PHa2CeYERmisSI
	v/DBRBtfB9W4QGz3sXg7d7J6D6GuDYuRheYa/URvo+vip9/VZU60lApJtkFcxGWhWtYR5d5Tlmx
	MEktDetjvnHQ1Dn8uRdQlSZ6TgZFCHN82Yi9LAe/YtZVJoK/FNJpw8CaX5pxieClMhPwgFDpYmv
	2ou7ptB2ZlGdIjNLZNSVlRgxif64dxl/SGq4b6pDrqJdnt5yO+4Uq34YA+S0fn1/CYC6wKoqNn0
	0cuq8X1qJeIrAJ7NQ6K4md4pO8KtuyJof5bF1mRaM0gKIkZN2FAIVuKynHVrD9dcLZ9HJSPzkyO
	peK3sbtgddBjzS9GKu3fU3CMa03LEHSs7zb0ji10GnRL4SMRN6AuEHCp6YOIVSFBVTYYuuH4omw
	z0=
X-Received: by 2002:a17:902:da91:b0:2b0:9101:1b77 with SMTP id d9443c01a7336-2b0cdc4389cmr105487125ad.17.1774800204027;
        Sun, 29 Mar 2026 09:03:24 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.14])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b2427c176fsm52521175ad.77.2026.03.29.09.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 29 Mar 2026 09:03:23 -0700 (PDT)
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
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: [PATCH V7 2/4] powerpc/jump_label: adjust inline asm to be consistent
Date: Sun, 29 Mar 2026 21:32:52 +0530
Message-ID: <20260329160254.2592207-3-mkchauras@gmail.com>
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

Added support for a new macro ARCH_STATIC_BRANCH_ASM in powerpc
to avoid duplication of inline asm between C and Rust. This is
inline with commit aecaf181651c '("jump_label: adjust inline asm to be consistent")'

Co-developed-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Signed-off-by: Madhavan Srinivasan <maddy@linux.ibm.com>
Reviewed-by: Alice Ryhl <aliceryhl@google.com>
Reviewed-by: Christophe Leroy (CS GROUP) <chleroy@kernel.org>
Signed-off-by: Mukesh Kumar Chaurasiya (IBM) <mkchauras@gmail.com>
---
 arch/powerpc/include/asm/jump_label.h | 23 +++++++++++++----------
 1 file changed, 13 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/jump_label.h b/arch/powerpc/include/asm/jump_label.h
index d4eaba459a0e..a6b211502bfe 100644
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
+	JUMP_TABLE_ENTRY(key,label)
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


