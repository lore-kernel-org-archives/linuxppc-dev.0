Return-Path: <SRS0=nAMm=V2=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E5CAC7618B
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 15:12:34 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id 144EE21655
	for <linuxppc-dev@archiver.kernel.org>; Mon, 29 Jul 2019 15:12:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pZiZx5sM"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org 144EE21655
Authentication-Results: mail.kernel.org; dmarc=fail (p=none dis=none) header.from=gmail.com
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 45y38H0c00zDqCC
	for <linuxppc-dev@archiver.kernel.org>; Tue, 30 Jul 2019 01:12:30 +1000 (AEST)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=gmail.com
 (client-ip=2607:f8b0:4864:20::442; helo=mail-pf1-x442.google.com;
 envelope-from=npiggin@gmail.com; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=pass (p=none dis=none) header.from=gmail.com
Authentication-Results: lists.ozlabs.org; dkim=pass (2048-bit key;
 unprotected) header.d=gmail.com header.i=@gmail.com header.b="pZiZx5sM"; 
 dkim-atps=neutral
Received: from mail-pf1-x442.google.com (mail-pf1-x442.google.com
 [IPv6:2607:f8b0:4864:20::442])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 45y1rr42ZgzDqF7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2019 00:14:04 +1000 (AEST)
Received: by mail-pf1-x442.google.com with SMTP id r1so28104972pfq.12
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 Jul 2019 07:14:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=gmail.com; s=20161025;
 h=from:to:cc:subject:date:message-id:in-reply-to:references
 :mime-version:content-transfer-encoding;
 bh=pDNDUQIQ0cNELMGQhdbvwhrnsDW2mIZ9RIWJWa6mCMQ=;
 b=pZiZx5sMQ1NAGZK9BvPQ3wOPCwwnLkaldB1X9SwJfpwep4sw4rg3sLptOviGUA1cWw
 LEAPuwPWjFwPf5GCZj2MYzFm4fZ6Ccz6yD8A9HiSg4wJzAo/vbB1yd2ZorCQZah0SCUp
 G1vut37XXpwEvyFg2Ci3ky34W2DlUP+pfzmGcnKxFTlgC54xugjHArPHdNVi164+UdBk
 4PMeYcy3jwuBfPj1OzKOKdq40KV1xGvL8sqdrZdeJ4yy07yFfZOkNJzQ1LOezwKnzDNe
 2SgI0CDP/ie6UuCOT0xGbdQTvIA7j4OAvcBx78gxiQiZFaRIIJ2vIuXqNWIAOG0NX5Qj
 2xVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=1e100.net; s=20161025;
 h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
 :references:mime-version:content-transfer-encoding;
 bh=pDNDUQIQ0cNELMGQhdbvwhrnsDW2mIZ9RIWJWa6mCMQ=;
 b=M9RCdsdouypZa/OBMOTEX0Hzceyrtkt4wKwoY/uutl9Ko1WADQD0PXLU5onlublDou
 Gac0MOTS30X/PrFfd5eMSwg7L5FbgQ9k5ST2tkRasUkzSfZsSDz9SqdSzBDdbRXzsbUo
 qrPV83mvm8QpRqoxK6kFU02JdiXJnjniOFW1OtBnpo5/Hiq4xuKvZnub/yqDXUT33YJ1
 bDZLRv14zzR8ChTvABWCND/dD/Xy6+9/ERdzEchtvWh7d/0B3QwPd7twVC8CUpGTx019
 VPLsqZE5ogdIcZwVlLuG+Cf1/hxndqZoKkykusQ58EFPlUqUReK8835UfLgvxwjuPpGV
 +miw==
X-Gm-Message-State: APjAAAUv5hu5ucrHxXbz4e2JW9ap/gLHGhmbDDnawEWoOpX/wJEIq9SP
 ref2ddeHuRP9VD2IBZ9jEY933FFc2XM=
X-Google-Smtp-Source: APXvYqxAD+vq4xI5jByk1lwS1ZXJydERlhZ403vs3Ur56QLXjWnXOlRDQfELqMvdHKAeFufuOBWwrg==
X-Received: by 2002:a17:90a:a407:: with SMTP id
 y7mr112446992pjp.97.1564409642076; 
 Mon, 29 Jul 2019 07:14:02 -0700 (PDT)
Received: from bobo.local0.net (61-68-184-39.tpgi.com.au. [61.68.184.39])
 by smtp.gmail.com with ESMTPSA id u7sm53960083pfm.96.2019.07.29.07.14.00
 (version=TLS1_3 cipher=AEAD-AES256-GCM-SHA384 bits=256/256);
 Mon, 29 Jul 2019 07:14:01 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 15/18] powerpc/64s/exception: Expand EXCEPTION_PROLOG_COMMON_1
 and 2 into caller
Date: Tue, 30 Jul 2019 00:12:44 +1000
Message-Id: <20190729141247.26762-16-npiggin@gmail.com>
X-Mailer: git-send-email 2.22.0
In-Reply-To: <20190729141247.26762-1-npiggin@gmail.com>
References: <20190729141247.26762-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-BeenThere: linuxppc-dev@lists.ozlabs.org
X-Mailman-Version: 2.1.29
Precedence: list
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>
Cc: Nicholas Piggin <npiggin@gmail.com>
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

No generated code change except BUG line number constants.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/kernel/exceptions-64s.S | 85 +++++++++++++---------------
 1 file changed, 40 insertions(+), 45 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index ff949d6139d3..dcb60f082fdc 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -390,49 +390,6 @@ END_FTR_SECTION_NESTED(CPU_FTR_HAS_PPR,CPU_FTR_HAS_PPR,948)
 .endm
 #endif
 
-#define EXCEPTION_PROLOG_COMMON_1()					   \
-	std	r9,_CCR(r1);		/* save CR in stackframe	*/ \
-	std	r11,_NIP(r1);		/* save SRR0 in stackframe	*/ \
-	std	r12,_MSR(r1);		/* save SRR1 in stackframe	*/ \
-	std	r10,0(r1);		/* make stack chain pointer	*/ \
-	std	r0,GPR0(r1);		/* save r0 in stackframe	*/ \
-	std	r10,GPR1(r1);		/* save r1 in stackframe	*/ \
-
-/* Save original regs values from save area to stack frame. */
-#define EXCEPTION_PROLOG_COMMON_2(area, trap)				   \
-	ld	r9,area+EX_R9(r13);	/* move r9, r10 to stackframe	*/ \
-	ld	r10,area+EX_R10(r13);					   \
-	std	r9,GPR9(r1);						   \
-	std	r10,GPR10(r1);						   \
-	ld	r9,area+EX_R11(r13);	/* move r11 - r13 to stackframe	*/ \
-	ld	r10,area+EX_R12(r13);					   \
-	ld	r11,area+EX_R13(r13);					   \
-	std	r9,GPR11(r1);						   \
-	std	r10,GPR12(r1);						   \
-	std	r11,GPR13(r1);						   \
-BEGIN_FTR_SECTION_NESTED(66);						   \
-	ld	r10,area+EX_CFAR(r13);					   \
-	std	r10,ORIG_GPR3(r1);					   \
-END_FTR_SECTION_NESTED(CPU_FTR_CFAR, CPU_FTR_CFAR, 66);			   \
-	GET_CTR(r10, area);						   \
-	std	r10,_CTR(r1);						   \
-	std	r2,GPR2(r1);		/* save r2 in stackframe	*/ \
-	SAVE_4GPRS(3, r1);		/* save r3 - r6 in stackframe   */ \
-	SAVE_2GPRS(7, r1);		/* save r7, r8 in stackframe	*/ \
-	mflr	r9;			/* Get LR, later save to stack	*/ \
-	ld	r2,PACATOC(r13);	/* get kernel TOC into r2	*/ \
-	std	r9,_LINK(r1);						   \
-	lbz	r10,PACAIRQSOFTMASK(r13);				   \
-	mfspr	r11,SPRN_XER;		/* save XER in stackframe	*/ \
-	std	r10,SOFTE(r1);						   \
-	std	r11,_XER(r1);						   \
-	li	r9,(trap)+1;						   \
-	std	r9,_TRAP(r1);		/* set trap number		*/ \
-	li	r10,0;							   \
-	ld	r11,exception_marker@toc(r2);				   \
-	std	r10,RESULT(r1);		/* clear regs->result		*/ \
-	std	r11,STACK_FRAME_OVERHEAD-16(r1); /* mark the frame	*/
-
 /*
  * On entry r13 points to the paca, r9-r13 are saved in the paca,
  * r9 contains the saved CR, r11 and r12 contain the saved SRR0 and
@@ -452,7 +409,13 @@ END_FTR_SECTION_NESTED(CPU_FTR_CFAR, CPU_FTR_CFAR, 66);			   \
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,0
 3:
 	.endif
-	EXCEPTION_PROLOG_COMMON_1()
+
+	std	r9,_CCR(r1)		/* save CR in stackframe	*/
+	std	r11,_NIP(r1)		/* save SRR0 in stackframe	*/
+	std	r12,_MSR(r1)		/* save SRR1 in stackframe	*/
+	std	r10,0(r1)		/* make stack chain pointer	*/
+	std	r0,GPR0(r1)		/* save r0 in stackframe	*/
+	std	r10,GPR1(r1)		/* save r1 in stackframe	*/
 
 	.if \stack
 	.if \kaup
@@ -468,7 +431,39 @@ END_FTR_SECTION_NESTED(CPU_FTR_CFAR, CPU_FTR_CFAR, 66);			   \
 	.endif
 	.endif
 
-	EXCEPTION_PROLOG_COMMON_2(\area, \vec)
+	/* Save original regs values from save area to stack frame. */
+	ld	r9,\area+EX_R9(r13)	/* move r9, r10 to stackframe	*/
+	ld	r10,\area+EX_R10(r13)
+	std	r9,GPR9(r1)
+	std	r10,GPR10(r1)
+	ld	r9,\area+EX_R11(r13)	/* move r11 - r13 to stackframe	*/
+	ld	r10,\area+EX_R12(r13)
+	ld	r11,\area+EX_R13(r13)
+	std	r9,GPR11(r1)
+	std	r10,GPR12(r1)
+	std	r11,GPR13(r1)
+BEGIN_FTR_SECTION_NESTED(66)
+	ld	r10,\area+EX_CFAR(r13)
+	std	r10,ORIG_GPR3(r1)
+END_FTR_SECTION_NESTED(CPU_FTR_CFAR, CPU_FTR_CFAR, 66)
+	GET_CTR(r10, \area)
+	std	r10,_CTR(r1)
+	std	r2,GPR2(r1)		/* save r2 in stackframe	*/
+	SAVE_4GPRS(3, r1)		/* save r3 - r6 in stackframe   */
+	SAVE_2GPRS(7, r1)		/* save r7, r8 in stackframe	*/
+	mflr	r9			/* Get LR, later save to stack	*/
+	ld	r2,PACATOC(r13)		/* get kernel TOC into r2	*/
+	std	r9,_LINK(r1)
+	lbz	r10,PACAIRQSOFTMASK(r13)
+	mfspr	r11,SPRN_XER		/* save XER in stackframe	*/
+	std	r10,SOFTE(r1)
+	std	r11,_XER(r1)
+	li	r9,(\vec)+1
+	std	r9,_TRAP(r1)		/* set trap number		*/
+	li	r10,0
+	ld	r11,exception_marker@toc(r2)
+	std	r10,RESULT(r1)		/* clear regs->result		*/
+	std	r11,STACK_FRAME_OVERHEAD-16(r1) /* mark the frame	*/
 
 	.if \stack
 	ACCOUNT_STOLEN_TIME
-- 
2.22.0

