Return-Path: <SRS0=YrVw=SA=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 75EF1C43381
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 16:54:21 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id E218D218D0
	for <linuxppc-dev@archiver.kernel.org>; Fri, 29 Mar 2019 16:54:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="XupG5xB5"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org E218D218D0
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 44W7B26dFVzDqXJ
	for <linuxppc-dev@archiver.kernel.org>; Sat, 30 Mar 2019 03:54:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="XupG5xB5"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 44W6qt0yGLzDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Mar 2019 03:38:34 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 44W6qm25Hpz9tyQY;
 Fri, 29 Mar 2019 17:38:28 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=XupG5xB5; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id 0sQozyTGBGry; Fri, 29 Mar 2019 17:38:28 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 44W6qm0nLCz9tyQP;
 Fri, 29 Mar 2019 17:38:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1553877508; bh=UEfco3xFmDtL+J9Ha0etejQ5oWCRVbwOfEw33gtHK8c=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=XupG5xB516gTKkNqKe6mYMpgR39eIh59S/Z/3XSDcdjFhmnMso0GIpaMiYm8OSlCk
 LKAZ2+PEHMRmzddnNy3LwJpKuogA2gi9TN/l+sr+euNNWj871E66ZS+WwXqjLKUP4k
 3w4nHhLr2u1xmK7hgL6fMCp5lXYpDb9NajuPE+8c=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id AEBC48B93D;
 Fri, 29 Mar 2019 17:38:29 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id dgIjzigZv-BA; Fri, 29 Mar 2019 17:38:29 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 8A5528B938;
 Fri, 29 Mar 2019 17:38:29 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 78F6B6FC56; Fri, 29 Mar 2019 16:38:29 +0000 (UTC)
Message-Id: <e048acf9c8bc517396a740172c6ce4c74204dc0d.1553877076.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1553877076.git.christophe.leroy@c-s.fr>
References: <cover.1553877076.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v2 07/17] powerpc/40x: Refactor exception entry macros by
 using head_32.h
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Fri, 29 Mar 2019 16:38:29 +0000 (UTC)
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

Refactor exception entry macros by using the ones defined in head_32.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_32.h  |  4 ++
 arch/powerpc/kernel/head_40x.S | 88 +-----------------------------------------
 2 files changed, 6 insertions(+), 86 deletions(-)

diff --git a/arch/powerpc/kernel/head_32.h b/arch/powerpc/kernel/head_32.h
index 985758cbf577..aa0131bb09b5 100644
--- a/arch/powerpc/kernel/head_32.h
+++ b/arch/powerpc/kernel/head_32.h
@@ -59,8 +59,12 @@
 	stw	r1,GPR1(r11)
 	stw	r1,0(r11)
 	tovirt(r1,r11)			/* set new kernel sp */
+#ifdef CONFIG_40x
+	rlwinm	r9,r9,0,14,12		/* clear MSR_WE (necessary?) */
+#else
 	li	r10,MSR_KERNEL & ~(MSR_IR|MSR_DR) /* can take exceptions */
 	MTMSRD(r10)			/* (except for mach check in rtas) */
+#endif
 	stw	r0,GPR0(r11)
 	lis	r10,STACK_FRAME_REGS_MARKER@ha /* exception frame marker */
 	addi	r10,r10,STACK_FRAME_REGS_MARKER@l
diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index 1547750567b6..cce9bd33a176 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -44,6 +44,8 @@
 #include <asm/export.h>
 #include <asm/asm-405.h>
 
+#include "head_32.h"
+
 /* As with the other PowerPC ports, it is expected that when code
  * execution begins here, the following registers contain valid, yet
  * optional, information:
@@ -99,52 +101,6 @@ _ENTRY(saved_ksp_limit)
 	.space	4
 
 /*
- * Exception vector entry code. This code runs with address translation
- * turned off (i.e. using physical addresses). We assume SPRG_THREAD has
- * the physical address of the current task thread_struct.
- */
-#define EXCEPTION_PROLOG						     \
-	mtspr	SPRN_SPRG_SCRATCH0,r10;	/* save two registers to work with */\
-	mtspr	SPRN_SPRG_SCRATCH1,r11;					     \
-	mfcr	r10;			/* save CR in r10 for now	   */\
-	EXCEPTION_PROLOG_1;						     \
-	EXCEPTION_PROLOG_2
-
-#define EXCEPTION_PROLOG_1						     \
-	mfspr	r11,SPRN_SRR1;		/* check whether user or kernel    */\
-	andi.	r11,r11,MSR_PR;						     \
-	tophys(r11,r1);							     \
-	beq	1f;							     \
-	mfspr	r11,SPRN_SPRG_THREAD;	/* if from user, start at top of   */\
-	lwz	r11,TASK_STACK-THREAD(r11); /* this thread's kernel stack */\
-	addi	r11,r11,THREAD_SIZE;					     \
-	tophys(r11,r11);						     \
-1:	subi	r11,r11,INT_FRAME_SIZE	/* Allocate an exception frame     */
-
-#define EXCEPTION_PROLOG_2						     \
-	stw	r10,_CCR(r11);          /* save various registers	   */\
-	stw	r12,GPR12(r11);						     \
-	stw	r9,GPR9(r11);						     \
-	mfspr	r10,SPRN_SPRG_SCRATCH0;					     \
-	stw	r10,GPR10(r11);						     \
-	mfspr	r12,SPRN_SPRG_SCRATCH1;					     \
-	stw	r12,GPR11(r11);						     \
-	mflr	r10;							     \
-	stw	r10,_LINK(r11);						     \
-	mfspr	r12,SPRN_SRR0;						     \
-	stw	r1,GPR1(r11);						     \
-	mfspr	r9,SPRN_SRR1;						     \
-	stw	r1,0(r11);						     \
-	tovirt(r1,r11);			/* set new kernel sp */	\
-	rlwinm	r9,r9,0,14,12;		/* clear MSR_WE (necessary?)	   */\
-	stw	r0,GPR0(r11);						     \
-	lis	r10, STACK_FRAME_REGS_MARKER@ha; /* exception frame marker */\
-	addi	r10, r10, STACK_FRAME_REGS_MARKER@l;			     \
-	stw	r10, 8(r11);						     \
-	SAVE_4GPRS(3, r11);						     \
-	SAVE_2GPRS(7, r11)
-
-/*
  * Exception prolog for critical exceptions.  This is a little different
  * from the normal exception prolog above since a critical exception
  * can potentially occur at any point during normal exception processing.
@@ -205,16 +161,6 @@ _ENTRY(saved_ksp_limit)
 /*
  * Exception vectors.
  */
-#define	START_EXCEPTION(n, label)					     \
-	. = n;								     \
-label:
-
-#define EXCEPTION(n, label, hdlr, xfer)				\
-	START_EXCEPTION(n, label);				\
-	EXCEPTION_PROLOG;				\
-	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
-	xfer(n, hdlr)
-
 #define CRITICAL_EXCEPTION(n, label, hdlr)			\
 	START_EXCEPTION(n, label);				\
 	CRITICAL_EXCEPTION_PROLOG;				\
@@ -223,36 +169,6 @@ label:
 			  NOCOPY, crit_transfer_to_handler,	\
 			  ret_from_crit_exc)
 
-#define EXC_XFER_TEMPLATE(hdlr, trap, msr, copyee, tfer, ret)	\
-	li	r10,trap;					\
-	stw	r10,_TRAP(r11);					\
-	lis	r10,msr@h;					\
-	ori	r10,r10,msr@l;					\
-	copyee(r10, r9);					\
-	bl	tfer;		 				\
-	.long	hdlr;						\
-	.long	ret
-
-#define COPY_EE(d, s)		rlwimi d,s,0,16,16
-#define NOCOPY(d, s)
-
-#define EXC_XFER_STD(n, hdlr)		\
-	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, NOCOPY, transfer_to_handler_full, \
-			  ret_from_except_full)
-
-#define EXC_XFER_LITE(n, hdlr)		\
-	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, NOCOPY, transfer_to_handler, \
-			  ret_from_except)
-
-#define EXC_XFER_EE(n, hdlr)		\
-	EXC_XFER_TEMPLATE(hdlr, n, MSR_KERNEL, COPY_EE, transfer_to_handler_full, \
-			  ret_from_except_full)
-
-#define EXC_XFER_EE_LITE(n, hdlr)	\
-	EXC_XFER_TEMPLATE(hdlr, n+1, MSR_KERNEL, COPY_EE, transfer_to_handler, \
-			  ret_from_except)
-
-
 /*
  * 0x0100 - Critical Interrupt Exception
  */
-- 
2.13.3

