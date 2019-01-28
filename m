Return-Path: <SRS0=7Eaw=QE=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B301C282C8
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 11:26:27 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id BB8D5214DA
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 11:26:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="rQIL2cNy"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org BB8D5214DA
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43p6lN58h7zDqH4
	for <linuxppc-dev@archiver.kernel.org>; Mon, 28 Jan 2019 22:26:24 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="rQIL2cNy"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43p6Q83bm3zDqF5
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 28 Jan 2019 22:11:28 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43p6Py6sbxz9v1q8;
 Mon, 28 Jan 2019 12:11:18 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=rQIL2cNy; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id dJ56Zrl193WH; Mon, 28 Jan 2019 12:11:18 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43p6Py5rWNz9v1q3;
 Mon, 28 Jan 2019 12:11:18 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1548673878; bh=6gmFeRrno51iQ4ACcN7AdeuYqB03iY0XtpQoX1FBkwg=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=rQIL2cNyOMDxSbVlTyAUDobliZn96eWHutdvwnFQQPIzCaU7sYhveiMR61HXU4h3v
 8/mhr582IWEL5RQjANLnnGkvp+I4pzT44dKfWD9Vo4IpHre5nSUS6uknDY7p9WvnUW
 O4mOEaoEd9xBJSJwCL33LeHIW4bB+rXmhzUJusYo=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4415B8B79D;
 Mon, 28 Jan 2019 12:11:25 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id Wx04JYdY9Xsj; Mon, 28 Jan 2019 12:11:25 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2E0258B796;
 Mon, 28 Jan 2019 12:11:25 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 2324E72DE6; Mon, 28 Jan 2019 11:11:25 +0000 (UTC)
Message-Id: <fd74576c52a83e00563af0476c719fd26fd77145.1548673552.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1548673552.git.christophe.leroy@c-s.fr>
References: <cover.1548673552.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 07/11] powerpc/40x: Don't use SPRN_SPRG_SCRATCH2 in
 EXCEPTION_PROLOG
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>
Date: Mon, 28 Jan 2019 11:11:25 +0000 (UTC)
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
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Unlike said in the comment, r1 is not reused by the critical
exception handler, as it uses a dedicated critirq_ctx stack.
Decrementing r1 early is then unneeded.

Should the above be valid, the code is crap buggy anyway as
r1 gets some intermediate values that would jeopardise the
whole process (for instance after mfspr   r1,SPRN_SPRG_THREAD)

Using SPRN_SPRG_SCRATCH2 to save r1 is then not needed, r11 can be
used instead. This avoids one mtspr and one mfspr and makes the
prolog closer to what's done on 6xx and 8xx.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_40x.S | 21 +++++++++------------
 1 file changed, 9 insertions(+), 12 deletions(-)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 3088c9f29f5e..59f6f53f1ac2 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -102,23 +102,20 @@ _ENTRY(saved_ksp_limit)
  * Exception vector entry code. This code runs with address translation
  * turned off (i.e. using physical addresses). We assume SPRG_THREAD has
  * the physical address of the current task thread_struct.
- * Note that we have to have decremented r1 before we write to any fields
- * of the exception frame, since a critical interrupt could occur at any
- * time, and it will write to the area immediately below the current r1.
  */
 #define NORMAL_EXCEPTION_PROLOG						     \
 	mtspr	SPRN_SPRG_SCRATCH0,r10;	/* save two registers to work with */\
 	mtspr	SPRN_SPRG_SCRATCH1,r11;					     \
-	mtspr	SPRN_SPRG_SCRATCH2,r1;					     \
 	mfcr	r10;			/* save CR in r10 for now	   */\
 	mfspr	r11,SPRN_SRR1;		/* check whether user or kernel    */\
 	andi.	r11,r11,MSR_PR;						     \
-	beq	1f;							     \
-	mfspr	r1,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
-	lwz	r1,TASK_STACK-THREAD(r1); /* this thread's kernel stack   */\
-	addi	r1,r1,THREAD_SIZE;					     \
-1:	subi	r1,r1,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
 	tophys(r11,r1);							     \
+	beq	1f;							     \
+	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
+	lwz	r11,TASK_STACK-THREAD(r11); /* this thread's kernel stack */\
+	addi	r11,r11,THREAD_SIZE;					     \
+	tophys(r11,r11);						     \
+1:	subi	r11,r11,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
 	stw	r10,_CCR(r11);          /* save various registers	   */\
 	stw	r12,GPR12(r11);						     \
 	stw	r9,GPR9(r11);						     \
@@ -128,11 +125,11 @@ _ENTRY(saved_ksp_limit)
 	stw	r12,GPR11(r11);						     \
 	mflr	r10;							     \
 	stw	r10,_LINK(r11);						     \
-	mfspr	r10,SPRN_SPRG_SCRATCH2;					     \
 	mfspr	r12,SPRN_SRR0;						     \
-	stw	r10,GPR1(r11);						     \
+	stw	r1,GPR1(r11);						     \
 	mfspr	r9,SPRN_SRR1;						     \
-	stw	r10,0(r11);						     \
+	stw	r1,0(r11);						     \
+	tovirt(r1,r11);			/* set new kernel sp */	\
 	rlwinm	r9,r9,0,14,12;		/* clear MSR_WE (necessary?)	   */\
 	stw	r0,GPR0(r11);						     \
 	SAVE_4GPRS(3, r11);						     \
-- 
2.13.3

