Return-Path: <linuxppc-dev+bounces-23785-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 178E1C43458
	for <linuxppc-dev@archiver.kernel.org>; Wed,  8 Jul 2026 08:25:52 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4gwB4Z5W4dz308X;
	Wed, 08 Jul 2026 18:25:50 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::62d"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1783499150;
	cv=none; b=l2PLqxZ+gxsmgp29wt2HvV5cUTyxZ/EqPQfZEMtHF+5bVPH6TphEUNAeuisaQRoi/OWfkUe4vYmt/NXEdFm3ISU/vqdBkzcE6qlGC7AGsJ4Tpcz0mANA4r0MCSJvWx6rAwL8aRXUl5QsbpVtQvr/vnY4hf7Q4Xi3+iqyFrsaCS5fldXZ9VVqvLbj+XymrGTB+8HfGDqkgnjM4CQdjKJu3aPCPqjw78NEZ6iwSxWWWbtPZX5xHiLTrYnarjJzMEkV85dPZANtq5dea4WwRqsltPw05MbxgRY8ts85mO/Y2g0lPUziInx5s8Sm6qdjzlAPLNeGX+/PpNfUFtqqolHbGQ==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1783499150; c=relaxed/relaxed;
	bh=IU8cHdVeDTqUeczB1eq13oLH6Kg182LaK9ECFYg1DHk=;
	h=From:To:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=UxFUK2rlB0XFurls5oJOCvG214XpXYNgjihyAusrQ6rsKjNfQ6EklBoxJALSFn6h2LjTclvjsJluUlxcP2fdM0dyN2CZNVlW+0Jq2SigMy0VPG1/dO19j4Cse5yaC/QVve2vM5KWks4fZ0U+C88wV+x2kU1ZSPZ4aXgYwa+0fkikc0b9BWIQT65MHIkAYs/XsTdTvwGbnC/sV6GKaPIPUo1puxX2BemTAuf6KlhigDzsyS6HQW41kCYAlOTrCb7q6pwTs7BYixPLhZ/Bsx88wqX7SHhMDwVBiSfeo/fZwbJT/1aOMHykgHouUVvoOc+BJDzx4TsEuTgoHyETrtwPiw==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UlUVDXR2; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=UlUVDXR2;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::62d; helo=mail-pl1-x62d.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x62d.google.com (mail-pl1-x62d.google.com [IPv6:2607:f8b0:4864:20::62d])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4gwB4Z10qmz308T
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 18:25:50 +1000 (AEST)
Received: by mail-pl1-x62d.google.com with SMTP id d9443c01a7336-2cab973140bso5498015ad.3
        for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jul 2026 01:25:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1783499148; x=1784103948; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:from:to:cc:subject:date:message-id
         :reply-to:content-type;
        bh=IU8cHdVeDTqUeczB1eq13oLH6Kg182LaK9ECFYg1DHk=;
        b=UlUVDXR2Wdm+Pj7ycce59nNyY0JWx0tsnu+ceGQfg7Qrymjl7WEY9xXz0js+hpTjgl
         WkcioOOE2/qNnjpFmiisBHxU5b4mf8Go2xGspGYNCyXAsZumfTsxSh5juXKM/ZNOdqMf
         74tgBD+rbZmEs2ok980oDYVWj/4nVm1b4V01/ISy+UW1NBP0bd+pUbewJtTqOGNBIX/4
         V2G+z3225x/B5PNmchqmhjqkWtOs1vR/y2dAkGojd6FVauNZfGxT1fIgdTxTRTM27xHj
         xnU//8nljg19IoscMnVnc3LxZM32J/M95RYdmTwOQBQ4pG1xvapu6lYXT4jiZuBjM/H+
         GR3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1783499148; x=1784103948;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:to:from:x-gm-gg:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to:content-type;
        bh=IU8cHdVeDTqUeczB1eq13oLH6Kg182LaK9ECFYg1DHk=;
        b=ecxm7v80zv51G33EHfmeb2k8q1yRC3OJwNscYDD7f5ddCEhd0uYwSJIrpqrgTdrG18
         xK7k0uXhflHLGUhp5MWaqGC5i28SOkbGbz7b5Fc2qWx54nm+j5w5zQa0vLzfTFF16DDk
         Hj7mrjQJ9xlAabudQVwGsCElELEhBgrbCXvJLJymdAif761Oc+YRj2Jxarrjbna9O9AU
         j44yMG5mSF6sa7F1eZjzbLxAa0WO6pD5pP5ZO5ZdpD6/nmv2PtvdnIiHsa6yCLhFzRdX
         mdYKEXT42jyHPcqT7aX8a+Vv6O0aebRn+W6vjHsp/5Nf3WXSBeTRbH+D7APl+0vwcSNR
         +smA==
X-Forwarded-Encrypted: i=1; AHgh+RoQy4JUgUnVrbLswvtX4WY1uvC34UR6RvpIOED2MHrpQLnIhJrFXfDsKzTEKGaW24Ak3xGaKYDS3VOBA5Q=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YwaZRBB2HN8azsrkVGOdtGo2YEp3sV3GA6kys4YOeymlRARHjT+
	P4+NbjKv9e+Nn3IKMDCZx3gUy2IWUhhkb7hA0HfQnc/GLJri6dq07kt8
X-Gm-Gg: AfdE7ckHZxnV1t4c+cMni1yXc4dEpdxkXK58EG4P/r6Qn719ntO7AaCbhcKlW3UG9pG
	1P+SZ3+jgtfVnt5w0GCKE/vSaffA1ujjUTdTjbBxWek89zLByEjL4cO/2OBIpzeCDJlN0xvlH6T
	v43DJiHPkq0fOzblIXZvfppJB1QMPi1uH5+ql8gN70RA7IZEXA7QBnmzdvme0DJF/JUTn2sWrNm
	56R0NO2P3SNqCc+vwWgG25jyB82wZO+/fr+X8fLT5EZq9XGbeZgiKgIJyUIbjVmxlvLnoXon9u2
	3ICz0tufUnz72B+CGVID+Uvanzw9H1EVdR+D9HzYjtZnNttuP8FlWTd2Q8BRuXzwJl70hRHD3kG
	7fBAzezNPKpjkREuBEc5U0CNmHdNJ0rU8TGHP8Ma6X9mhn2W3jNw26X0CKd4KxR40ViIZAZpuQd
	kKfchb1oFIoFoHEIfuv1r5mqXiK7+o0CIIeuSVpJ4gX+AWbkGrBqA4x7CKJwACO36FSbZCqpkKF
	dyV
X-Received: by 2002:a05:6a20:4308:b0:3c0:9c19:65c3 with SMTP id adf61e73a8af0-3c0bcd26715mr1623869637.75.1783499147997;
        Wed, 08 Jul 2026 01:25:47 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.236])
        by smtp.gmail.com with ESMTPSA id 5a478bee46e88-3117462f5c7sm19975117eec.0.2026.07.08.01.25.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2026 01:25:47 -0700 (PDT)
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
Subject: [PATCH V17 3/7] powerpc/jump_label: adjust inline asm to be consistent
Date: Wed,  8 Jul 2026 13:54:50 +0530
Message-ID: <20260708082454.1254320-4-mkchauras@gmail.com>
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
2.55.0


