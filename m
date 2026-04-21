Return-Path: <linuxppc-dev+bounces-19883-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id F0896F8FA65
	for <linuxppc-dev@archiver.kernel.org>; Tue, 21 Apr 2026 12:10:32 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4g0Llq3pfSz2yv6;
	Tue, 21 Apr 2026 22:10:31 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::533"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776773431;
	cv=none; b=J+IV0w0MpFBL6o3Gwu2AJ9VsDh9SsqZxoNl3tYOGNMllMqGGVNpA9L/mKNi5Mlxutquw+cO7NDETYids+WBNwCrryoqSI+2LLpxaj3XYL5CPK3zMQrzqf/50SXZZdwZmLz+HxN/XQa0HCjxVRRIuAISaMJaDpEOHQRywkNaEDVbeX182iZlhnhNp8MDKiM7t/otvvctohWC6RNCILQwzIGBriVtWG3zS/g67/71jbROXOP2pXiVXTtzeiMiy+t3ceuNnKhyXAGulUzHXcqFuHEdtkmythVkw/uRyop6jQC91Up/TFv5E496wd81gzP3yCi0lDntGq/HvnxCxvdRDlA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776773431; c=relaxed/relaxed;
	bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=f6i+/lrxCcV2ppZOGMA8wcGbV0yXTG52B1XTDmLpav7hBljhBD7SkwOUHTPzlQ51ClIfZPf0pwTyveXayCo/odvMJLylKp2awLx/WEkh2o+mJl7xHjyY7jzlmbRSJQDP+caK0AfRRR68Ar92dh0nHC/DhiCKXs1LqCcYCqCNUNydHu8svCA5uTgfA/GdBp42WxZX1/0RHEBAawZkxxEi3Ez6Ia8QQjy+ugCiaqc5dZWn0sTI+2l4kmkSHtCHEahaqN7fdu/YjpZl32J+hjVbebdE7TzyN62m6/YuB+poL7SoRK0SPhVvGMXNR8d4Ube9hN3hyM0+iKGqQSjdnUoBIw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aeUBb0hC; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=aeUBb0hC;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::533; helo=mail-pg1-x533.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4g0Llp6Bptz2ySW
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 22:10:30 +1000 (AEST)
Received: by mail-pg1-x533.google.com with SMTP id 41be03b00d2f7-c741692db4cso1175833a12.1
        for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Apr 2026 05:10:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776773429; x=1777378229; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
        b=aeUBb0hCV1WfNvi/hSHER420gOxxiSMBw3szsqmc9iB9AMYq6hLqO1DtQfxqYy93Hm
         0QU+DmOunbXDTUj3gc5cK/jng84S0mUNz9L0BTdx8sUCH3nDSms59LVKv/bfh4rSxq+T
         4CHa9+M51eZO7LJagHtNoYl4z+l7ICyC7xlpIZXJLIFmzBpITBbn8GCQZFYAjAlqlpwX
         D8C0/VRNWOpcP3ICgM3A0Rjxes3M6wZyijIBQLxW74EOoYr/WmRML20SDOCf3Yjk7r17
         nfodbfShsABn03+iqAeeCfK8q+NNeHgrHDTE55PdIgLJygGt3t3/j8I+MMtYlHJDmjoW
         BeNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776773429; x=1777378229;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
        b=UePVg5ooAsQYFg7v18fA6WamnqwocjutJ0zs14Gp1WuBoss1v2yQZu650dUz6Wqu71
         i8I0togkM98Ys49aw2PgqvtauZiNdx+FQIH7XAG0IKRt26ZgR23hh5/XHByMCqDQ0EyB
         vWxvXbm9VSnLpbj/fy+O6LhzGwNxHPEP+Qx77HDKIbM0EhyI/45zpf9VxLGWR2lrESiq
         oTECc71Q8i2bKf9cH2XXbQFdG8sgpin+jBDaUyazBwv3iID6O6JYZQ7etBQvlPgmoe/y
         JYCBuE7sxrwvsKW7WT+/gXtXjUxgqkmny4VikyxcvcPpy3MDpl0JoqeBkPuSnXU8mj6W
         molw==
X-Forwarded-Encrypted: i=1; AFNElJ/Sooro8c3o7aViuN+gePe4rgjs9svLR59AxnDMHepc0GoqEfIxjabWPQmVLkyxbRGVlqgNQR+DjBtlTfA=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwPFQzyjLicGfoRjRKGjLzwaqaav+N5QBDfBt086hzeE2Uc2ogL
	hIUjFijSO/Jc9+JJYdusZKtJgFlTPXEgGEunZW1I8fo7diMUMpKGBXYF
X-Gm-Gg: AeBDieuRd2yS7VJNuFFe0i9qyuZOGL5ap9kDquC8mSRJtG3vHp5P1LsBV2gCnvFUHw+
	zKh+8nEv/EPFdnlSNI6g01vGAEW79LIW3/bST1rxpcy4CtUlWjpp9sipuVqc6SIe8/cBiFdBEga
	zD7mQutaB9Xb4mG4mrQM7wBMKm6Fy5SiCCg4/ADNChElASKt8dcDyRTDmS+v7A+thkT6jUZEjLP
	jjFvV+ryMw8QJ+bITZV1EXLxLgS68r3+jnTjLSRSzYNyPCBKx3HdYilfzrZKk1gP8M0PjUxWJYi
	JFQd6f19fWBHK27AEMgX9/yYuIvZefXhOUBnP7cTNHo/0ltCpZHMH3+ZJDY2Iz/bOKm3DJVQhu1
	Lgu7HdR22emqwliWSeDvd1a0PkV4d4uiQLOg5boZ9KK5Bs+xYQO4P/CsjPhcR5PVKX97ie2Du5a
	I3q/I3ythBXIqTIw3HNbCOgoSUcDqWMOKIM+j1BVXBoDJCgMkNfkRUkMQtkuzuQsOMIuhkxJ4SC
	baX52tomiIXsqsNaJUfngIwlw==
X-Received: by 2002:a05:6a20:6a10:b0:3a2:edff:296b with SMTP id adf61e73a8af0-3a2edff3a32mr1965327637.21.1776773428601;
        Tue, 21 Apr 2026 05:10:28 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.bl1-in.ibm.com ([129.41.58.4])
        by smtp.gmail.com with ESMTPSA id 41be03b00d2f7-c797701d9bfsm10045274a12.16.2026.04.21.05.10.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Apr 2026 05:10:27 -0700 (PDT)
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
Cc: "Mukesh Kumar Chaurasiya (IBM)" <mkchauras@gmail.com>
Subject: [PATCH V12 2/4] powerpc/jump_label: adjust inline asm to be consistent
Date: Tue, 21 Apr 2026 17:39:56 +0530
Message-ID: <20260421120958.190430-3-mkchauras@gmail.com>
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


