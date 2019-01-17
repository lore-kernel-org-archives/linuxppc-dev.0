Return-Path: <SRS0=IbMY=PZ=lists.ozlabs.org=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B8247C43387
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 11:37:23 +0000 (UTC)
Received: from lists.ozlabs.org (lists.ozlabs.org [203.11.71.2])
	(using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
	(No client certificate requested)
	by mail.kernel.org (Postfix) with ESMTPS id EB25C2054F
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 11:37:22 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 mail.kernel.org EB25C2054F
Authentication-Results: mail.kernel.org; dmarc=none (p=none dis=none) header.from=ellerman.id.au
Authentication-Results: mail.kernel.org; spf=pass smtp.mailfrom=linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Received: from lists.ozlabs.org (lists.ozlabs.org [IPv6:2401:3900:2:1::3])
	by lists.ozlabs.org (Postfix) with ESMTP id 43gMW45cxnzDqfJ
	for <linuxppc-dev@archiver.kernel.org>; Thu, 17 Jan 2019 22:37:20 +1100 (AEDT)
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
 key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 43gMSk0VZxzDqfJ
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 17 Jan 2019 22:35:18 +1100 (AEDT)
Authentication-Results: lists.ozlabs.org; dmarc=none (p=none dis=none)
 header.from=ellerman.id.au
Received: by ozlabs.org (Postfix)
 id 43gMSj5RPcz9sCX; Thu, 17 Jan 2019 22:35:17 +1100 (AEDT)
Received: by ozlabs.org (Postfix, from userid 1034)
 id 43gMSj4czyz9sCh; Thu, 17 Jan 2019 22:35:17 +1100 (AEDT)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc/64s: Remove MSR_RI optimisation in system_call_exit()
Date: Thu, 17 Jan 2019 22:35:10 +1100
Message-Id: <20190117113510.4265-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.20.1
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
Cc: npiggin@gmail.com
Errors-To: linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org
Sender: "Linuxppc-dev"
 <linuxppc-dev-bounces+linuxppc-dev=archiver.kernel.org@lists.ozlabs.org>

Currently in system_call_exit() we have an optimisation where we
disable MSR_RI (recoverable interrupt) and MSR_EE (external interrupt
enable) in a single mtmsrd instruction.

Unfortunately this will no longer work with THREAD_INFO_IN_TASK,
because then the load of TI_FLAGS might fault and faulting with MSR_RI
clear is treated as an unrecoverable exception which leads to a
panic().

So change the code to only clear MSR_EE prior to loading TI_FLAGS,
leaving the clear of MSR_RI until later. We have some latitude in
where do the clear of MSR_RI. A bit of experimentation has shown that
this location gives the least slow down.

This still causes a noticeable slow down in our null_syscall
performance. On a Power9 DD2.2:

  Before        After         Delta     Delta %
  955 cycles    999 cycles    -44	-4.6%

On the plus side this does simplify the code somewhat, because we
don't have to reenable MSR_RI on the restore_math() or
syscall_exit_work() paths which was necessitated previously by the
optimisation.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/kernel/entry_64.S | 34 ++++++++++++++--------------------
 1 file changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 83bddacd7a17..b1aea6680a9d 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -236,18 +236,14 @@ system_call:			/* label this so stack traces look sane */
 	/*
 	 * Disable interrupts so current_thread_info()->flags can't change,
 	 * and so that we don't get interrupted after loading SRR0/1.
+	 *
+	 * Leave MSR_RI enabled for now, because with THREAD_INFO_IN_TASK we
+	 * could fault on the load of the TI_FLAGS below.
 	 */
 #ifdef CONFIG_PPC_BOOK3E
 	wrteei	0
 #else
-	/*
-	 * For performance reasons we clear RI the same time that we
-	 * clear EE. We only need to clear RI just before we restore r13
-	 * below, but batching it with EE saves us one expensive mtmsrd call.
-	 * We have to be careful to restore RI if we branch anywhere from
-	 * here (eg syscall_exit_work).
-	 */
-	li	r11,0
+	li	r11,MSR_RI
 	mtmsrd	r11,1
 #endif /* CONFIG_PPC_BOOK3E */
 
@@ -263,15 +259,7 @@ system_call:			/* label this so stack traces look sane */
 	bne	3f
 #endif
 2:	addi    r3,r1,STACK_FRAME_OVERHEAD
-#ifdef CONFIG_PPC_BOOK3S
-	li	r10,MSR_RI
-	mtmsrd	r10,1		/* Restore RI */
-#endif
 	bl	restore_math
-#ifdef CONFIG_PPC_BOOK3S
-	li	r11,0
-	mtmsrd	r11,1
-#endif
 	ld	r8,_MSR(r1)
 	ld	r3,RESULT(r1)
 	li	r11,-MAX_ERRNO
@@ -287,6 +275,16 @@ END_FTR_SECTION_IFCLR(CPU_FTR_STCX_CHECKS_ADDRESS)
 	andi.	r6,r8,MSR_PR
 	ld	r4,_LINK(r1)
 
+#ifdef CONFIG_PPC_BOOK3S
+	/*
+	 * Clear MSR_RI, MSR_EE is already and remains disabled. We could do
+	 * this later, but testing shows that doing it here causes less slow
+	 * down than doing it closer to the rfid.
+	 */
+	li	r11,0
+	mtmsrd	r11,1
+#endif
+
 	beq-	1f
 	ACCOUNT_CPU_USER_EXIT(r13, r11, r12)
 
@@ -363,10 +361,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	b	.Lsyscall_exit
 	
 .Lsyscall_exit_work:
-#ifdef CONFIG_PPC_BOOK3S
-	li	r10,MSR_RI
-	mtmsrd	r10,1		/* Restore RI */
-#endif
 	/* If TIF_RESTOREALL is set, don't scribble on either r3 or ccr.
 	 If TIF_NOERROR is set, just save r3 as it is. */
 
-- 
2.20.1

