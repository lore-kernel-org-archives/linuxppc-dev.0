Return-Path: <linuxppc-dev+bounces-19275-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id 5A761E85373
	for <linuxppc-dev@archiver.kernel.org>; Fri,  3 Apr 2026 14:53:46 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fnMDT02pYz2yjV;
	Sat, 04 Apr 2026 01:53:45 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::432"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775228024;
	cv=none; b=H+uXRKf2shpGEp33R39XwXs+eoDg0fUIOpv/xTnEhn1ze7ViCNpmhKeP003vw7iOcfkqIi56oaMevYE+Rxi6YTvhAxigHNb1LK4tbd4yMbd5IUX1R57pzgeaTV0xXG+OyDbuVjrpDgSngFyydMwXE/HVeMZceD59mCXG/nK1vq2k3ml/J9fvvXPGGCQcFh6if+7H+VD5LKa3V/lv2+GR4lDYE6D4vDoiL7JkAeWjfgEDFzXjJbZe6HRWVc4aOXXAPMtH+QlWVFGL3egW4UcG74sZ1WDscNqWEkViyNpgiepQM0/WOapW/Sx16eLfnFx+v6cjtIq+ipgow8kMGE1iVg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775228024; c=relaxed/relaxed;
	bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=DBueWsVlvf/YttSt29q2xm20vRJIniG19koFxT+Maq3XEuAlE/4LD4Q85qpJRhT8pAPfoAHp6EKp3loxtLAC0q5KCpQigKWemvrGkVHaeBlxr2N59pv+zHH7ZSraKvURaR+80M3QDLpJgwMbMANq2FN894yMeK21tTccAHM978ZV+wY1RUaAqpG/tWvmV2fN3XxWIFllSWTOb66tLWvNvQQfc5cGhD5UF51m7DWdG+tvuViUW1Uqjv/GHTa0ofY/RHsvqgmRBgbqJg561Pqd6rselg/EXRgUzlcm4mzTbs80SIYPwDejnJFJIUUw6B3zKfbQ9IE6H0WPkKSJ99hBLQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kY3hIj5Q; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=kY3hIj5Q;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::432; helo=mail-pf1-x432.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pf1-x432.google.com (mail-pf1-x432.google.com [IPv6:2607:f8b0:4864:20::432])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fnMDS1l6kz2yWK
	for <linuxppc-dev@lists.ozlabs.org>; Sat, 04 Apr 2026 01:53:44 +1100 (AEDT)
Received: by mail-pf1-x432.google.com with SMTP id d2e1a72fcca58-82cf83bf375so813534b3a.0
        for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Apr 2026 07:53:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775228022; x=1775832822; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
        b=kY3hIj5Qg8kk1oynP4EWn3M6MojBiQGrwsWUTCbLC8Phqif1T3gqaJp5IXshBMkEh4
         8+ALmsuyHzojMCI3PfRgA4NQj6oml5gGGYwWjTddEEN3JDKsYaB4yhLLQGa9BmsOsj0q
         gM2kk6NmuMxhHb8uUa1dk2XTuEbEbQrUwQAv5+kGwpQ3YNNTAaIW0UtA+PPKj9W+/Zhb
         tpPxwiRU/gcHhtnNSMOuqxKiiJ3LGhXsD9N7TOLr2D5NnJMPESq9ePyPrCn1slsTYtF0
         HLf2o7k3ZD61x4xWSXUgK8oJYDaD51RrfSwbHRM8PWKBxPO546uwJVXvRXnj/VXUbRdW
         Xojw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775228022; x=1775832822;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
        b=Kpw6/lybiZP/cx0rUBXtt13BhKs4hzreiIEQaBaeiA3BE0IcLWXXgVMdrOSVoPduHb
         xEwgZq6rOt3Cluz2GzXc1XZh65LzjoBYpggo9kh6sMxAbJrYo09L+2w+WdY4qw50K+SG
         TMPyHXbqVjYgejfgktlM99kCmzULgIG+Fz0Ph+4od9vjXRZu1DlbogPlPqjvsUuxdxlH
         Qi0OTUEY4WfZAGaHFKTKbRA5pJukTopCio5VC6/+M6IQ7HC1k3GNeaSqsf4vFDg++f9o
         fjW9KhKQQv+YElP97rzbADX4tMrKBSFL4CcOQDidbglUzDG61j9F3ENn1uY+NmVw8nAZ
         R2Ug==
X-Forwarded-Encrypted: i=1; AJvYcCXsNzcCF/DyTIuYVtsZuFQyMrmDFAeX5mi5eULcXh95oHuKb5CF5+g/2SfPw30C+uAsp25ZJUm2jpI56a0=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YyELebhfI+fzf7TGMzdWI/XxJm32VWRtqRHe/MzVzGOHZz/OSni
	zKotQgEBI5qAJhvTWTS2R4PSiYbTE1GTIzK2XTKdM4pt/ZT0tSGQ2oSb
X-Gm-Gg: ATEYQzzSw126kyl60gAIpMiNJm3LpmfndHQZJLarrHth9+bXGN34wXYaEYbL/7n4Kc2
	TSxT4ALurUOBmNq3UHfptFwHPzLEpACnx4m+tktImgpqvOQNI+Ul0hM7v9OtrOSPF1J+CnObCrY
	g1cp3/3sWGRitI+0WQXapE3JTf1AEF8Hl6/AyDVfSRZRa2LVlOnlXfQzMJtiwRVFiF1ySGhUGOP
	bIb6TYPTOvycRPa+5TXpPY1Uw+JlJc6wRp10BC33chHKohnkx8Ki7obRE4fDv440uAr6lvTAI2Y
	ZOpg5TLmNxCjAO/9lGFcjR9edRuGsPZN53rK3nsT3fE80tviMSRbIWrKZckTSwsHF/NRm+cqqVe
	/o5CLhEsUOjAtZvkDpsoEnkP5DeD11B2YvLc+ILpQn1PD2pP6rS0ODNwZCofiIP7ulcTfZbpKCm
	k50ynbaSyKVSLlOLMEuzx4uzK1DtZoAXkTs028iOMzXqqAhlXcZP+OHPHlapA/NMYfAvc0MiuJ6
	Ko=
X-Received: by 2002:a05:6a00:414c:b0:82c:fe17:5af5 with SMTP id d2e1a72fcca58-82d0db96d9emr2983355b3a.44.1775228022326;
        Fri, 03 Apr 2026 07:53:42 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.44])
        by smtp.gmail.com with ESMTPSA id d2e1a72fcca58-82cf9ca4efesm6301682b3a.61.2026.04.03.07.53.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 03 Apr 2026 07:53:41 -0700 (PDT)
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
Subject: [PATCH V8 2/4] powerpc/jump_label: adjust inline asm to be consistent
Date: Fri,  3 Apr 2026 20:23:06 +0530
Message-ID: <20260403145308.1042622-3-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260403145308.1042622-1-mkchauras@gmail.com>
References: <20260403145308.1042622-1-mkchauras@gmail.com>
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


