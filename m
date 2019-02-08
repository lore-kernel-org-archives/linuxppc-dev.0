Return-Path: <SRS0=r06i=QP=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_PASS,URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5058CC169C4
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 13:24:32 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id C4F9E20869
	for <linuxppc-dev@archiver.kernel.org>; Fri,  8 Feb 2019 13:24:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=c-s.fr header.i=@c-s.fr header.b="ILNT8Jel"
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org C4F9E20869
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43wwrY2bVTzDqBS
	for <linuxppc-dev@archiver.kernel.org>; Sat,  9 Feb 2019 00:24:29 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org;
 spf=pass (mailfrom) smtp.mailfrom=c-s.fr
 (client-ip=93.17.236.30; helo=pegase1.c-s.fr;
 envelope-from=christophe.leroy@c-s.fr; receiver=<UNKNOWN>)
Authentication-Results: lists.ozlabs.org;
 dmarc=none (p=none dis=none) header.from=c-s.fr
Authentication-Results: lists.ozlabs.org; dkim=pass (1024-bit key;
 unprotected) header.d=c-s.fr header.i=@c-s.fr header.b="ILNT8Jel"; 
 dkim-atps=neutral
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43ww7k3WL1zDqV6
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Feb 2019 23:52:34 +1100 (AEDT)
Received: from localhost (mailhub1-int [192.168.12.234])
 by localhost (Postfix) with ESMTP id 43ww7f10g0z9v0dJ;
 Fri,  8 Feb 2019 13:52:30 +0100 (CET)
Authentication-Results: localhost; dkim=pass
 reason="1024-bit key; insecure key"
 header.d=c-s.fr header.i=@c-s.fr header.b=ILNT8Jel; dkim-adsp=pass;
 dkim-atps=neutral
X-Virus-Scanned: Debian amavisd-new at c-s.fr
Received: from pegase1.c-s.fr ([192.168.12.234])
 by localhost (pegase1.c-s.fr [192.168.12.234]) (amavisd-new, port 10024)
 with ESMTP id S8JwDQahEa_o; Fri,  8 Feb 2019 13:52:30 +0100 (CET)
Received: from messagerie.si.c-s.fr (messagerie.si.c-s.fr [192.168.25.192])
 by pegase1.c-s.fr (Postfix) with ESMTP id 43ww7d756bz9v0dH;
 Fri,  8 Feb 2019 13:52:29 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=c-s.fr; s=mail;
 t=1549630350; bh=20GCv/fiQPoQFx7rP9aeZEnvfwQXA/ISPhMiEPkNe6E=;
 h=In-Reply-To:References:From:Subject:To:Cc:Date:From;
 b=ILNT8JelP59dCAPGCmdyCGaLj+Lu2SzGlhPi59kLOETR9Kfhe4bVD0GBjeG+5HrHo
 s3i4M07DmKXxtn6wKj6RbLWjyaw5Tm1V6clg/tRQX80UiVlOvEVwF/vnTjVNi/dOxR
 bCw5AyhWLnQHTE7oFBgnMB4N3sbmGiEyFwMPWF24=
Received: from localhost (localhost [127.0.0.1])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 4F9C48B8D7;
 Fri,  8 Feb 2019 13:52:31 +0100 (CET)
X-Virus-Scanned: amavisd-new at c-s.fr
Received: from messagerie.si.c-s.fr ([127.0.0.1])
 by localhost (messagerie.si.c-s.fr [127.0.0.1]) (amavisd-new, port 10023)
 with ESMTP id XlkxHtQ0LuPp; Fri,  8 Feb 2019 13:52:31 +0100 (CET)
Received: from po16846vm.idsi0.si.c-s.fr (po15451.idsi0.si.c-s.fr
 [172.25.231.2])
 by messagerie.si.c-s.fr (Postfix) with ESMTP id 2CD288B756;
 Fri,  8 Feb 2019 13:52:31 +0100 (CET)
Received: by po16846vm.idsi0.si.c-s.fr (Postfix, from userid 0)
 id 16C28653E8; Fri,  8 Feb 2019 12:52:31 +0000 (UTC)
Message-Id: <9d62f57416746490d8553efa38c9cebd6db336eb.1549630193.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1549630193.git.christophe.leroy@c-s.fr>
References: <cover.1549630193.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v1 07/16] powerpc/40x: Split and rename NORMAL_EXCEPTION_PROLOG
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Date: Fri,  8 Feb 2019 12:52:31 +0000 (UTC)
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

This patch splits NORMAL_EXCEPTION_PROLOG in the same way as in
head_8xx.S and head_32.S and renames it EXCEPTION_PROLOG() as well
to match head_32.h

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/kernel/head_40x.S | 26 ++++++++++++++++----------
 1 file changed, 16 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/kernel/head_40x.S b/arch/powerpc/kernel/head_40x.S
index f3bfb695f952..2961e2aa1d18 100644
--- a/arch/powerpc/kernel/head_40x.S
+++ b/arch/powerpc/kernel/head_40x.S
@@ -103,10 +103,14 @@ _ENTRY(saved_ksp_limit)
  * turned off (i.e. using physical addresses). We assume SPRG_THREAD has
  * the physical address of the current task thread_struct.
  */
-#define NORMAL_EXCEPTION_PROLOG						     \
+#define EXCEPTION_PROLOG						     \
 	mtspr	SPRN_SPRG_SCRATCH0,r10;	/* save two registers to work with */\
 	mtspr	SPRN_SPRG_SCRATCH1,r11;					     \
 	mfcr	r10;			/* save CR in r10 for now	   */\
+	EXCEPTION_PROLOG_1;						     \
+	EXCEPTION_PROLOG_2
+
+#define EXCEPTION_PROLOG_1						     \
 	mfspr	r11,SPRN_SRR1;		/* check whether user or kernel    */\
 	andi.	r11,r11,MSR_PR;						     \
 	tophys(r11,r1);							     \
@@ -115,7 +119,9 @@ _ENTRY(saved_ksp_limit)
 	lwz	r11,TASK_STACK-THREAD(r11); /* this thread's kernel stack */\
 	addi	r11,r11,THREAD_SIZE;					     \
 	tophys(r11,r11);						     \
-1:	subi	r11,r11,INT_FRAME_SIZE;	/* Allocate an exception frame     */\
+1:	subi	r11,r11,INT_FRAME_SIZE	/* Allocate an exception frame     */
+
+#define EXCEPTION_PROLOG_2						     \
 	stw	r10,_CCR(r11);          /* save various registers	   */\
 	stw	r12,GPR12(r11);						     \
 	stw	r9,GPR9(r11);						     \
@@ -205,7 +211,7 @@ label:
 
 #define EXCEPTION(n, label, hdlr, xfer)				\
 	START_EXCEPTION(n, label);				\
-	NORMAL_EXCEPTION_PROLOG;				\
+	EXCEPTION_PROLOG;				\
 	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
 	xfer(n, hdlr)
 
@@ -396,7 +402,7 @@ label:
  * This is caused by a fetch from non-execute or guarded pages.
  */
 	START_EXCEPTION(0x0400, InstructionAccess)
-	NORMAL_EXCEPTION_PROLOG
+	EXCEPTION_PROLOG
 	mr	r4,r12			/* Pass SRR0 as arg2 */
 	li	r5,0			/* Pass zero as arg3 */
 	EXC_XFER_LITE(0x400, handle_page_fault)
@@ -406,7 +412,7 @@ label:
 
 /* 0x0600 - Alignment Exception */
 	START_EXCEPTION(0x0600, Alignment)
-	NORMAL_EXCEPTION_PROLOG
+	EXCEPTION_PROLOG
 	mfspr	r4,SPRN_DEAR		/* Grab the DEAR and save it */
 	stw	r4,_DEAR(r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -414,7 +420,7 @@ label:
 
 /* 0x0700 - Program Exception */
 	START_EXCEPTION(0x0700, ProgramCheck)
-	NORMAL_EXCEPTION_PROLOG
+	EXCEPTION_PROLOG
 	mfspr	r4,SPRN_ESR		/* Grab the ESR and save it */
 	stw	r4,_ESR(r11)
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -427,7 +433,7 @@ label:
 
 /* 0x0C00 - System Call Exception */
 	START_EXCEPTION(0x0C00,	SystemCall)
-	NORMAL_EXCEPTION_PROLOG
+	EXCEPTION_PROLOG
 	EXC_XFER_EE_LITE(0xc00, DoSyscall)
 
 	EXCEPTION(0x0D00, Trap_0D, unknown_exception, EXC_XFER_EE)
@@ -733,7 +739,7 @@ label:
 
 	/* Programmable Interval Timer (PIT) Exception. (from 0x1000) */
 Decrementer:
-	NORMAL_EXCEPTION_PROLOG
+	EXCEPTION_PROLOG
 	lis	r0,TSR_PIS@h
 	mtspr	SPRN_TSR,r0		/* Clear the PIT exception */
 	addi	r3,r1,STACK_FRAME_OVERHEAD
@@ -741,7 +747,7 @@ Decrementer:
 
 	/* Fixed Interval Timer (FIT) Exception. (from 0x1010) */
 FITException:
-	NORMAL_EXCEPTION_PROLOG
+	EXCEPTION_PROLOG
 	addi	r3,r1,STACK_FRAME_OVERHEAD;
 	EXC_XFER_EE(0x1010, unknown_exception)
 
@@ -759,7 +765,7 @@ WDTException:
  * if they can't resolve the lightweight TLB fault.
  */
 DataAccess:
-	NORMAL_EXCEPTION_PROLOG
+	EXCEPTION_PROLOG
 	mfspr	r5,SPRN_ESR		/* Grab the ESR, save it, pass arg3 */
 	stw	r5,_ESR(r11)
 	mfspr	r4,SPRN_DEAR		/* Grab the DEAR, save it, pass arg2 */
-- 
2.13.3

