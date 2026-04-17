Return-Path: <linuxppc-dev+bounces-19836-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id C747AF436B8
	for <linuxppc-dev@archiver.kernel.org>; Fri, 17 Apr 2026 15:23:49 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fxzDh29M2z2ynH;
	Sat, 18 Apr 2026 01:23:48 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::52e"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1776439428;
	cv=none; b=EuU3/UvsRpBOtLZD7AsXGcj5GZsl8VmCktvQSW119DGXzdvxwlvlFIA26B7EW0cKOxfv6+BHjaw3AKTd3kKUNB1YLuz4bfEcIJCitK2HA9ZAENZf13fci1W4IxFdnMtF8YekjkRbimhntyYx6wETGco9hrwXCosGZu/vf3NqwNGOSOAvDBQg/FKjnbeeIwDYRApncsCu6ccqzUyHcg1pblduQMHKhceHuq4A+vtN3OGNSg0G43rGVZzD5L7zc/zTU4QDfgU15DVE5OKEHfbB5PdKK4XQr4TYRHgQmu+hNqqT+oqJY48LLXZ6wCKZPhwGLEa2+bIhIFnos9UWJlDMYA==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1776439428; c=relaxed/relaxed;
	bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=djbJxyVAXGCq8BTdoO4q9jVUOtKouTdXl/27rZ/eGzvCOEtTowTqRjUElzP/5ObKiTRrde8psUTQHgZk2Mqv73ci+mVsWViS51uonOlO7EIadSI68FoeHLRy19pxuUMK8WPjHenZ27I3R3YNXR+L8HBijTpUc3w0bmpjwfNsbeRnYB4UYByUmoJfc/rQJ8zpYSfYsLfqSpWtomPx7r8xitk0eyZf9JL/2+mVsXyfzQJJqP+ESj01VGggbw9jIN58Y58nxgK0RoGrxisnPdX/TaEE7pcw1pR6f2iLZysqk5J/MkHPlz2CM1iDYmjLUZbfEnoUDTY51oJhG/a1PlG+4A==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DkNGNMV9; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=DkNGNMV9;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::52e; helo=mail-pg1-x52e.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fxzDg4W4Pz2xS3
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Apr 2026 01:23:47 +1000 (AEST)
Received: by mail-pg1-x52e.google.com with SMTP id 41be03b00d2f7-c6e2355739dso319126a12.2
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Apr 2026 08:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1776439425; x=1777044225; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
        b=DkNGNMV9+b6IF6DzoFytPcjBxaIejPoS9pmvijAk2jKb/kwXCJROwKGnrJOgA+NAdJ
         cBaSHVhHDI6GsYk+Ob4stOCb/oolbEK7rycTA9WicbjXpHTkDpezN3INsJ+wJ5fTOP38
         JRIaAZcYJnf5eUkrffJ7uN8KoZB1YRiWSFUWDESh4dz+aYqE6Ze8NJzC+NweKjrajeIg
         vXjIx2Bk/2WsU5raLkl4XyK+K8J/m44vzIVgMIuB7T6NzmhpfELqZTT8+mZv1sdoqh7k
         0oMfPL2H70e98l24NhlQlG76j9lcvbrmvtK0MnZX2jkCr3HNxxwSdx7ep5MbzczIjVXm
         1Cvw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1776439425; x=1777044225;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
        b=mucpDkg1wqRoYdlWUHIWK/Ou4yAheIONN9a2c7Qlh0c43cyD4OuRr8lN5dDimIVpiB
         HFg8izKLoTezuViTZpIzWWNBjPrXuGmrLUlYTbz0VoNaTaKeHd1IJGwTem7X5BRUZ5Yi
         DwoMH2QQzmQVYB5aCIas7OUi2w0FwfkIwjaAK8AX8brmlWBDHEF55BMVNBZamOgM4Gyo
         fLFEebO9P/AR4PdffNlLPi2tKkHBOBll1EdBQ1il83o9nhUNK0dgd8uI6hJBkPnSXyBe
         o4p5I09a5pzKHIUZK7/MWSvUsYZ6Xku5hMk4SEyXV9A5FTes077ens9K8Jassdl0UNv6
         nXOg==
X-Forwarded-Encrypted: i=1; AFNElJ/7ofN8bqwxSAcOt3aI8p/mpCQ28wjSuiuzc+GLnX/FtKQi+TfhG5QJA+LplqQn9YnoudAcTsn1+Pdgv8M=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzKxZ9VHmtZOeT5r7eq7IVmDlFS846hFLLl8Qk3gf5ZUvm5E9s/
	4aO+0nPe9u9rqZFV4Rt51ywXQy6l6Ga3Vsydf5O1tfjDf3I8jnRd/8FU
X-Gm-Gg: AeBDievfCXauz9att78VAaLWzx1oi+p/J4tL0MamNkM7HgtSAyhfBAs5lnBMX/592Oz
	NAUNz8W26Hwe4IfL7Hm9GooEIQwExL0vowHzQQDqWeZEaS+VB+qxDLO/OMxrqM7Xq285xKIXogA
	UG1oZ7OoVY7QU53v0o04TOiZKQexYnNPnoF9baMjXtQqOBqwcbj3+lN+AOD6cdG8jk2bW+VWH6i
	tBjpDhwLMyD94hcuI9qbBILjukvQBu8B/kqaeXf4VhfLL9pBSrXHtKsqS2tM2ozqUUAlJn8Zy5Z
	xvd4xBK73n8CTNo+k0O2OsizZyYCn2ZG3AlpXNs/Q16i6q1Wgd3lFh5ScqMOddWrJx2bYnS+Ahk
	PBE95N4xhQwnmmtJLMR+tjMHeJWZuXtxgfGllygzpylIXDvjYwV0nTugSc+kyDrXNHA2OWwaUD1
	xgerVfYZOVNgNJrMfWqWLOquPf1+baGfqKPeqArdHygnLgkhNhZbZXqcqmc7IIUUdzOFnHYA/lw
	3Rpcdon4zD6QWE=
X-Received: by 2002:a05:6a20:7491:b0:398:ac0d:9a06 with SMTP id adf61e73a8af0-3a08d933c68mr3614755637.55.1776439425364;
        Fri, 17 Apr 2026 08:23:45 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.164.157])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82f8ebb3829sm2384373b3a.31.2026.04.17.08.23.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 17 Apr 2026 08:23:45 -0700 (PDT)
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
Subject: [PATCH V11 2/4] powerpc/jump_label: adjust inline asm to be consistent
Date: Fri, 17 Apr 2026 20:52:51 +0530
Message-ID: <20260417152253.2312961-3-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260417152253.2312961-1-mkchauras@gmail.com>
References: <20260417152253.2312961-1-mkchauras@gmail.com>
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


