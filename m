Return-Path: <linuxppc-dev+bounces-19409-linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
Received: from lists.ozlabs.org (lists.ozlabs.org [112.213.38.117])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by smtp.lore.kernel.org (Postfix) with ESMTPS id B515FF46C78
	for <linuxppc-dev@archiver.kernel.org>; Mon,  6 Apr 2026 20:02:26 +0000 (UTC)
Received: from boromir.ozlabs.org (localhost [127.0.0.1])
	by lists.ozlabs.org (Postfix) with ESMTP id 4fqKxF0VSMz2ygG;
	Tue, 07 Apr 2026 06:02:25 +1000 (AEST)
Authentication-Results: lists.ozlabs.org; arc=none smtp.remote-ip="2607:f8b0:4864:20::636"
ARC-Seal: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707; t=1775505745;
	cv=none; b=G8kTC+SraOEF3b/bc63CqVxpU4X9QrO5hjS0+WyL+ylyX6ANp00xu3bYdVpvzWjiXhEwy41fJrGiAyjv7DJ3hrLygWSATGr8EZvbVF1A1Ewa4RrdSUzqrKLukVO7ve1T0C3fLjK8PWbE3uS8iYin1L1zHV06wqxkxdpqC3Sow7x1hVi91u9r6q7m7MvWpl+BrOzxBSUDIFxRi6091slYyHTeWkF/ADGfo+JRSuWpAwcsPR5cNVr7dhcZoALmRUnG/t1bzB00peOIyR9YxHtMcsuaF/XhWhzlrKesf8xlRWt63DzbvGQAFBjlXd0B+TRnejIwGPocUn55/07ZpI+nIg==
ARC-Message-Signature: i=1; a=rsa-sha256; d=lists.ozlabs.org; s=201707;
	t=1775505745; c=relaxed/relaxed;
	bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
	h=From:To:Cc:Subject:Date:Message-ID:In-Reply-To:References:
	 MIME-Version; b=lWfyv1RoIVMjtHPBpUnIdcIejFLtm+lCZqIAtR6f7+IuRrsJXL+8t/n2DudFb5ukHN3f9xbDhK6vNIQC3A1HxVqETUQ7i1McBxRb+LhpwRqkJo3JfqgaBKQ2bHlmIDTZ0a49+4cS999FON8S4pbyWByP5u/6GxhSi+H78Hxg/63Eaej8wLzAX5U0hB9hw/UgNJS/Sd3v3oyhmuZ2L0/XUenDXhD+6G+q84ufRSpKMJJy7+5viJ5ClAnFJFFxEolzIcnrGl/227igXrKOqBWGQ7vFthEbVA6TgRx1D6Tg+OuoTKOiS5HSLCRYBgvIxe5jhQEXZJ2ICrVBQf1EmFssEQ==
ARC-Authentication-Results: i=1; lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com; dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eXe4DM0Y; dkim-atps=neutral; spf=pass (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org) smtp.mailfrom=gmail.com
Authentication-Results: lists.ozlabs.org; dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org;
	dkim=pass (2048-bit key; unprotected) header.d=gmail.com header.i=@gmail.com header.a=rsa-sha256 header.s=20251104 header.b=eXe4DM0Y;
	dkim-atps=neutral
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized) smtp.mailfrom=gmail.com (client-ip=2607:f8b0:4864:20::636; helo=mail-pl1-x636.google.com; envelope-from=mkchauras@gmail.com; receiver=lists.ozlabs.org)
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
	(using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
	 key-exchange x25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
	(No client certificate requested)
	by lists.ozlabs.org (Postfix) with ESMTPS id 4fqKxD1xVKz2xHX
	for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Apr 2026 06:02:24 +1000 (AEST)
Received: by mail-pl1-x636.google.com with SMTP id d9443c01a7336-2aaed195901so18602545ad.0
        for <linuxppc-dev@lists.ozlabs.org>; Mon, 06 Apr 2026 13:02:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20251104; t=1775505742; x=1776110542; darn=lists.ozlabs.org;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
        b=eXe4DM0Yz3P7TL7QXflPqDO4Amjli3LtTaMnKbbUPRx5STVNhQqb2wiPNiWhDE660E
         BiJMV20Zl1kGT8kXl8TJDb01j65CIbOanBh30Dd/bIvZrrPcCs6mhth2x6xIO2c4ebe6
         /cP80PGB8FVfCpt+sMK8hXbEfe0ksaceGhbEvtxc/w3u44eu7KQrniij2XfYS6bFqfCp
         5GcejpypAQqI4E9mSJZsLx+fMa9I847M4NKdOgQjSpkj/dzrYEyxgEcFMYzbQj+EbLKj
         JDzJQiNpzP3UNBirnJr9SGg0kPoOLKnF5YyG2cADA3ZPzvl79danQPlXR79hl3rtmrFx
         aE9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20251104; t=1775505742; x=1776110542;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-gg:x-gm-message-state:from
         :to:cc:subject:date:message-id:reply-to;
        bh=SIf376OZyXcpY0mdrIrP1nTWV/VE0v5g8114Fjjgl84=;
        b=iAJct7MxmsGKJ+3OmWtpISZWbKS03mbWUtlUpj7lkyyzwuMPWcm5GnftAMC+W/jEi6
         6frud7vyQucGCc+i5SnOGrNl1lrQFXQgJIu/JFO3XYL5KiW7kvmzbJxPvwa7qT+vcuUL
         vlV8zp3ZVGDkhfO89w1A8wWO70FYxrO+uK/WorNE6lb+yduIngkZPtYKyXwzne3V3uiE
         t7xuracGWn+nGtL319xwk7dQi2EdmlLNAvLy1Lb3LD73dBcbg7r/K1J9Eme5f4SYkNAb
         ++vXIkdCJCwDT9SRBkjzhmx+jAK7+uCFdiVkWMs0ZVhRumlcrOTWgb7CWkEl5qDV2PAC
         6kXA==
X-Forwarded-Encrypted: i=1; AJvYcCXsOWgRlS59N5e56fgw4KmYGUaOd02lZRw9HS5ipk1QcaahcAaSJcIAYTAXfKIm7vhpt877HiGwUVaxhA4=@lists.ozlabs.org
X-Gm-Message-State: AOJu0YzX0uM+xLRP5uKUxmaglxhT6E/LR8HUfmKBgmFQ/PTGy0qS41Xl
	3esnYpplfcwEKMwiIMm/PkE7xc+YXszuo1+FHs8+RF+5pVmmv1SoI8Vw
X-Gm-Gg: AeBDiesq6F8AiHLsJicqlqAuXWZCMGpfFZ1QLKNze8Nc1MpKdk3atZuZvlcSJtgHEDE
	Gqas1IojB2zuyOA7snLQNRPk66ovdVNgfr2bzojcbqMRj6Azj432Fx+L8rwEgR27dQRUb4DEZAs
	iXfaZGmdCQPfWw2doBIuWdV4MPLAnAnAoqLeVOEmk4vzNyehB1jlGBc6bJ6fCRsnGmE4cr+9Ca1
	PT4FgKo3tsTDOt3AwPF9e3nPCGPFkDeJe95DYdKouH7l5Ewc6LRt2DKXr8nWkqaz92Y271SatKY
	0iAvNoJ2kUOM5gitirr8nMqTk9M3/qrRMCE5o14VQMuDvM4KI4MIEcFZAEOUV4gbelGLAVrYAaR
	/Vwli7NPpH6hbMtASR9YnYUWmKK+Dem0QCRafy97MXRDObil2co2gxb3DlIZF2J1dSENbYq3mef
	TJBbY8mza+oALsZB7VYAiXLoflp+GhIYf3SOIU2dgP/rLoTAothhpd2RaFuF8QwCBivpsGvyw4E
	fh+tL7sIuvauQ==
X-Received: by 2002:a17:902:f54f:b0:2ae:5eab:132e with SMTP id d9443c01a7336-2b28173fa9dmr143439795ad.12.1775505741829;
        Mon, 06 Apr 2026 13:02:21 -0700 (PDT)
Received: from li-1a3e774c-28e4-11b2-a85c-acc9f2883e29.ibm.com.com ([106.51.160.44])
        by smtp.gmail.com with ESMTPSA id d9443c01a7336-2b27497af26sm151098205ad.49.2026.04.06.13.02.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Apr 2026 13:02:21 -0700 (PDT)
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
Subject: [PATCH V10 2/4] powerpc/jump_label: adjust inline asm to be consistent
Date: Tue,  7 Apr 2026 01:31:47 +0530
Message-ID: <20260406200149.3727922-3-mkchauras@gmail.com>
X-Mailer: git-send-email 2.53.0
In-Reply-To: <20260406200149.3727922-1-mkchauras@gmail.com>
References: <20260406200149.3727922-1-mkchauras@gmail.com>
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


