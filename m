Return-Path: <SRS0=8QQH=HI=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_CR_TRAILER,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABB7C433DB
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Feb 2021 07:25:26 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id B29AF64FD1
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Feb 2021 07:25:25 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org B29AF64FD1
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=codefail.de
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from bilbo.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 4DXkMl0ljTzDwtM
	for <linuxppc-dev@archiver.kernel.org>; Sat,  6 Feb 2021 18:25:23 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; spf=pass (sender SPF authorized)
 smtp.mailfrom=codefail.de (client-ip=198.54.127.59;
 helo=mta-06-3.privateemail.com; envelope-from=cmr@codefail.de;
 receiver=<UNKNOWN>)
Received: from MTA-06-3.privateemail.com (mta-06-3.privateemail.com
 [198.54.127.59])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4DXkL15YS2zDqCw
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2021 18:23:53 +1100 (AEDT)
Received: from MTA-06.privateemail.com (localhost [127.0.0.1])
 by MTA-06.privateemail.com (Postfix) with ESMTP id A0CBC6005F
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2021 02:23:47 -0500 (EST)
Received: from oc8246131445.ibm.com (unknown [10.20.151.216])
 by MTA-06.privateemail.com (Postfix) with ESMTPA id 70DBA6005E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  6 Feb 2021 07:23:47 +0000 (UTC)
From: "Christopher M. Riedl" <cmr@codefail.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2] powerpc64/idle: Fix SP offsets when saving GPRs
Date: Sat,  6 Feb 2021 01:23:42 -0600
Message-Id: <20210206072342.5067-1-cmr@codefail.de>
X-Mailer: git-send-email 2.26.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
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
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

The idle entry/exit code saves/restores GPRs in the stack "red zone"
(Protected Zone according to PowerPC64 ELF ABI v2). However, the offset
used for the first GPR is incorrect and overwrites the back chain - the
Protected Zone actually starts below the current SP. In practice this is
probably not an issue, but it's still incorrect so fix it.

Also expand the comments to explain why using the stack "red zone"
instead of creating a new stackframe is appropriate here.

Signed-off-by: Christopher M. Riedl <cmr@codefail.de>
---
 arch/powerpc/kernel/idle_book3s.S | 138 ++++++++++++++++--------------
 1 file changed, 73 insertions(+), 65 deletions(-)

diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 22f249b6f58d..f9e6d83e6720 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -52,28 +52,32 @@ _GLOBAL(isa300_idle_stop_mayloss)
 	std	r1,PACAR1(r13)
 	mflr	r4
 	mfcr	r5
-	/* use stack red zone rather than a new frame for saving regs */
-	std	r2,-8*0(r1)
-	std	r14,-8*1(r1)
-	std	r15,-8*2(r1)
-	std	r16,-8*3(r1)
-	std	r17,-8*4(r1)
-	std	r18,-8*5(r1)
-	std	r19,-8*6(r1)
-	std	r20,-8*7(r1)
-	std	r21,-8*8(r1)
-	std	r22,-8*9(r1)
-	std	r23,-8*10(r1)
-	std	r24,-8*11(r1)
-	std	r25,-8*12(r1)
-	std	r26,-8*13(r1)
-	std	r27,-8*14(r1)
-	std	r28,-8*15(r1)
-	std	r29,-8*16(r1)
-	std	r30,-8*17(r1)
-	std	r31,-8*18(r1)
-	std	r4,-8*19(r1)
-	std	r5,-8*20(r1)
+	/*
+	 * Use the stack red zone rather than a new frame for saving regs since
+	 * in the case of no GPR loss the wakeup code branches directly back to
+	 * the caller without deallocating the stack frame first.
+	 */
+	std	r2,-8*1(r1)
+	std	r14,-8*2(r1)
+	std	r15,-8*3(r1)
+	std	r16,-8*4(r1)
+	std	r17,-8*5(r1)
+	std	r18,-8*6(r1)
+	std	r19,-8*7(r1)
+	std	r20,-8*8(r1)
+	std	r21,-8*9(r1)
+	std	r22,-8*10(r1)
+	std	r23,-8*11(r1)
+	std	r24,-8*12(r1)
+	std	r25,-8*13(r1)
+	std	r26,-8*14(r1)
+	std	r27,-8*15(r1)
+	std	r28,-8*16(r1)
+	std	r29,-8*17(r1)
+	std	r30,-8*18(r1)
+	std	r31,-8*19(r1)
+	std	r4,-8*20(r1)
+	std	r5,-8*21(r1)
 	/* 168 bytes */
 	PPC_STOP
 	b	.	/* catch bugs */
@@ -89,8 +93,8 @@ _GLOBAL(isa300_idle_stop_mayloss)
  */
 _GLOBAL(idle_return_gpr_loss)
 	ld	r1,PACAR1(r13)
-	ld	r4,-8*19(r1)
-	ld	r5,-8*20(r1)
+	ld	r4,-8*20(r1)
+	ld	r5,-8*21(r1)
 	mtlr	r4
 	mtcr	r5
 	/*
@@ -98,25 +102,25 @@ _GLOBAL(idle_return_gpr_loss)
 	 * from PACATOC. This could be avoided for that less common case
 	 * if KVM saved its r2.
 	 */
-	ld	r2,-8*0(r1)
-	ld	r14,-8*1(r1)
-	ld	r15,-8*2(r1)
-	ld	r16,-8*3(r1)
-	ld	r17,-8*4(r1)
-	ld	r18,-8*5(r1)
-	ld	r19,-8*6(r1)
-	ld	r20,-8*7(r1)
-	ld	r21,-8*8(r1)
-	ld	r22,-8*9(r1)
-	ld	r23,-8*10(r1)
-	ld	r24,-8*11(r1)
-	ld	r25,-8*12(r1)
-	ld	r26,-8*13(r1)
-	ld	r27,-8*14(r1)
-	ld	r28,-8*15(r1)
-	ld	r29,-8*16(r1)
-	ld	r30,-8*17(r1)
-	ld	r31,-8*18(r1)
+	ld	r2,-8*1(r1)
+	ld	r14,-8*2(r1)
+	ld	r15,-8*3(r1)
+	ld	r16,-8*4(r1)
+	ld	r17,-8*5(r1)
+	ld	r18,-8*6(r1)
+	ld	r19,-8*7(r1)
+	ld	r20,-8*8(r1)
+	ld	r21,-8*9(r1)
+	ld	r22,-8*10(r1)
+	ld	r23,-8*11(r1)
+	ld	r24,-8*12(r1)
+	ld	r25,-8*13(r1)
+	ld	r26,-8*14(r1)
+	ld	r27,-8*15(r1)
+	ld	r28,-8*16(r1)
+	ld	r29,-8*17(r1)
+	ld	r30,-8*18(r1)
+	ld	r31,-8*19(r1)
 	blr
 
 /*
@@ -154,28 +158,32 @@ _GLOBAL(isa206_idle_insn_mayloss)
 	std	r1,PACAR1(r13)
 	mflr	r4
 	mfcr	r5
-	/* use stack red zone rather than a new frame for saving regs */
-	std	r2,-8*0(r1)
-	std	r14,-8*1(r1)
-	std	r15,-8*2(r1)
-	std	r16,-8*3(r1)
-	std	r17,-8*4(r1)
-	std	r18,-8*5(r1)
-	std	r19,-8*6(r1)
-	std	r20,-8*7(r1)
-	std	r21,-8*8(r1)
-	std	r22,-8*9(r1)
-	std	r23,-8*10(r1)
-	std	r24,-8*11(r1)
-	std	r25,-8*12(r1)
-	std	r26,-8*13(r1)
-	std	r27,-8*14(r1)
-	std	r28,-8*15(r1)
-	std	r29,-8*16(r1)
-	std	r30,-8*17(r1)
-	std	r31,-8*18(r1)
-	std	r4,-8*19(r1)
-	std	r5,-8*20(r1)
+	/*
+	 * Use the stack red zone rather than a new frame for saving regs since
+	 * in the case of no GPR loss the wakeup code branches directly back to
+	 * the caller without deallocating the stack frame first.
+	 */
+	std	r2,-8*1(r1)
+	std	r14,-8*2(r1)
+	std	r15,-8*3(r1)
+	std	r16,-8*4(r1)
+	std	r17,-8*5(r1)
+	std	r18,-8*6(r1)
+	std	r19,-8*7(r1)
+	std	r20,-8*8(r1)
+	std	r21,-8*9(r1)
+	std	r22,-8*10(r1)
+	std	r23,-8*11(r1)
+	std	r24,-8*12(r1)
+	std	r25,-8*13(r1)
+	std	r26,-8*14(r1)
+	std	r27,-8*15(r1)
+	std	r28,-8*16(r1)
+	std	r29,-8*17(r1)
+	std	r30,-8*18(r1)
+	std	r31,-8*19(r1)
+	std	r4,-8*20(r1)
+	std	r5,-8*21(r1)
 	cmpwi	r3,PNV_THREAD_NAP
 	bne	1f
 	IDLE_STATE_ENTER_SEQ_NORET(PPC_NAP)
-- 
2.26.1

