Return-Path: <linuxppc-dev+bounces-19311-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 21950E88D8B
	for <linuxppc-dev@archiver.kernel.org>; Sat,  4 Apr 2026 12:16:50 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnvhw5bybz2yVL;
	Sat, 04 Apr 2026 23:16:48 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::102c"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775305008;
	cv=none; b=N1EDJqTxUcVDLHn+D+rRyewW7L/rrDKT6ZkHhAbhSgmaHn/NeIEYWIGJAp4Y3HqCLrmdF2OkBi5jfwj+nLFXJlN9iXnkm5uihe6w9F1SmEvRtGWdAhD+AW2WY2S8iegW5WhBuD5Q8EudDubdA2llIO2DG4UgvzFl9nG2G/fIFTlVlyqCpyiJxZ9dlG9PONFVHdS+ukMTEix9BSkh2tzCJR0K19T9z/TG3mJoDTbql6HFF34pl838LEB3RAQkVkTvQqF0wqZE7XKFYosGnsMVcgBh2gPvKqeCGJfHZr4xk6ogUAgCh4urv7ckIc5oTZa57DXUZcl9fFil4Y7EPICAoQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775305008; c=relaxed/relaxed;
	bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=BLA6qtpE9qz6mviyorD3mYEromEYfLn3Xce7PRBAhS/65ELVwKJ8h1vKTefK0YZ5mr+HOwM2BDUyQMCEQfp53I88YBYAdQoUB6ZUHNPWETeSa3vm2Wkijog4BcKn8rSnL5yAP8W09nz677CDjuVEnWW32dZ2v1rc4j2qoc6bqXZxZGUxae6dNPaIPo10/Blso49sV1E49oi/6hznGu4bdRFlV+VrChs2yDLomA19XoS8pqsR3Yc5H/WfdzaTWmKqajehWsmVYN5IxIEieeEi4CqiAmFFRgyeD+QEl3t38IGgcNn5kOQkXf9zIeIdxdrjimSXYkU8aVSIt6PMHoeepg==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tGYp4uhA; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=tGYp4uhA;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::102c; helo=mail-pj1-x102c.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnvhw126zz2yC9
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 23:16:48 +1100 (AEDT)
Received: by mail-pj1-x102c.google.com with SMTP id 98e67ed59e1d1-358e3cc5e7eso1316853a91.0
        for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 05:16:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775305006; x=1775909806; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
        b=tGYp4uhADo+An3jVNTFiK9lyNHwnY4+B5z/V49sw3hUmnt+SGQ7zv3tO3nhwxh7gft
         sVpoaKXOIICQgzq05kAEnv4uiPjWhxFbT8yeEPI2jr2mlhGMh1OdA5OzM9vWCuEQOtyy
         t5YIroSFe4VqG5B+Q63isQzYraM3FakTtEwAuBluGrsixSlN1Xc1XDIhcWR+YZ163WOb
         yh8qALCEuqXaQYidp9r+2vvM6P8bPlUmGee2HLqOdwCILylccypVwgEUeSarSm7EKsxz
         8VTUZpENnqgKCt56l+kXVVF0zsYVt3+gBf2odJ0Q0wi4GUl0Xhcyt91VzeCR0f3sm+GR
         PTag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775305006; x=1775909806;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
        b=eiWLy/yLD/HKQxuZMY0r440N0iCvGI8bpoxmnCRG4DRC8WHJiDowwsUwj2KwM/r4Ut
         mVJwgoyWXvx1fQRPTWoJeDiibj1TjrvY2vgzGUK77iXc9sJ8rkKJf6icNVQOYSmLUC4Q
         dWsclEp13OZiRImr9l78o30D8B9cmfnVIrfukwRxse+uL9zp0fQK9EtzpKDKePJ4h3xi
         lR1Mq/t7zKp4VGW54evSO3Zg7hfbXZCMubKgEkX3rcaEmVfQihXCNWISlj9xwsCpn+/X
         kfEMxKsomWQyNiN+aPxOLPGUpSBSufWSKrx4rBmmPzosLMlIuUGzm0hvdbM5HQlxg5yG
         koJw==
X-Forwarded-Encrypted: i=1; AJvYcCVEHwVFG0030yEsNH7x3liTFPI45w8upKA6S18vbtFfSdDAtwutxyGVp4zMy94AMN1DHxJWfscb2j1RLJk=@lists.ozlabs.org
X-Gm-Message-State: AOJu0Yz2IsI3jROVCpE0RYuSYQMVRSwcbybuNGFPeplCdJbl7KDM+sUm
	zhkA60SYNUEzCuVBFAR9ItAmJ3FfPCOSZ4d9WJLiHmlmOsqNC8eFyGzE
X-Gm-Gg: AeBDievgla/nKMHOVZbn0HqBQ/j7LNag2dD26SJNR5qJ0XE4Zn/i1WT83HcTS0MpFtA
	zroOYbRYgFCMoWw2+p1ihJpdMDJ9P7amAc9hu4qKcErvrEyl1/GTn2sFYB6qqEsV7anxvrawupe
	s7Fm09HgJr8iUZZuN2OGzLpE+pZmlt7ufutxWilqYhINofRnuFrOfJpU0tGiMXgtlCg77rMw1Is
	Cl+m/RY/8vd2nW6anxQX+h++zc71YtV/mohe335oStzVqpaIxtfmJMLUi+DbabqIX2qqWv+8cfA
	0NLpJHf5T3Ffp8sdkj/HLCGCzumrot2jlzL7ttuZ1aqFQFXSVnIWRWRoQ9yOhmlbu3uzLOcaX1k
	Odk2hl/HP+y5ld+qGMZa8/lwGhvAt6zb64JATGorU93ldUmhtP7GmbfPMJmSodL4Yp3kUlA9yLI
	b3xY3l+4g6voWJ0Wi2mzYK4VPueAoN8TAc2eXLPWFcbSWywxTwuDez7HvzrDnzNffvVUssL9+R1
	KU=
X-Received: by 2002:a17:90a:dfc3:b0:35d:8fdb:4f36 with SMTP id 98e67ed59e1d1-35de6941208mr5104917a91.18.1775305006017;
        Sat, 04 Apr 2026 05:16:46 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.44])
        by smtp.gmail.com with ESMTPSA id 98e67ed59e1d1-35de500c42fsm2702745a91.0.2026.04.04.05.16.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Apr 2026 05:16:45 -0700 (PDT)
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
Subject: [PATCH V9 2/4] powerpc/jump_label: adjust inline asm to be consistent
Date: Sat,  4 Apr 2026 17:46:08 +0530
Message-ID: <20260404121610.1956528-3-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260404121610.1956528-1-mkchauras@gmail.com>
References: <20260404121610.1956528-1-mkchauras@gmail.com>
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


