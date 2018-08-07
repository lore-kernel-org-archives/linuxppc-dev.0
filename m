Return-Path: <npiggin@gmail.com>
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com
 [IPv6:2607:f8b0:4864:20::543])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41lFYF0f3dzDqCG
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Aug 2018 23:22:08 +1000 (AEST)
Received: by mail-pg1-x543.google.com with SMTP id k3-v6so7851684pgq.5
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Aug 2018 06:22:08 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH] powerpc/64s: idle_power4 fix PACA_IRQ_HARD_DIS accounting
Date: Tue,  7 Aug 2018 23:21:56 +1000
Message-Id: <20180807132156.6183-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When idle_power4 hard disables interrupts then finds a soft pending
interrupt, it returns with interrupts hard disabled but without
PACA_IRQ_HARD_DIS set. Commit 9b81c0211c ("powerpc/64s: make
PACA_IRQ_HARD_DIS track MSR[EE] closely") added a warning for that
condition.

Fix this by adding the PACA_IRQ_HARD_DIS for that case.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

---
This was half tested by modifying power4_idle to work on later CPUs
because I have no G5.

 arch/powerpc/kernel/idle_power4.S | 16 ++++++++++++++--
 1 file changed, 14 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index dd7471fe20bd..a09b3c7ca176 100644
--- a/arch/powerpc/kernel/idle_power4.S
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -32,6 +32,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
 	cmpwi	0,r4,0
 	beqlr
 
+	/* This sequence is similar to prep_irq_for_idle() */
+
 	/* Hard disable interrupts */
 	mfmsr	r7
 	rldicl	r0,r7,48,1
@@ -41,10 +43,15 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
 	/* Check if something happened while soft-disabled */
 	lbz	r0,PACAIRQHAPPENED(r13)
 	cmpwi	cr0,r0,0
-	bnelr
+	bne-	2f
 
-	/* Soft-enable interrupts */
+	/*
+	 * Soft-enable interrupts. This will make power4_fixup_nap return
+	 * to our caller with interrupts enabled (soft and hard). The caller
+	 * can cope with either interrupts disabled or enabled upon return.
+	 */
 #ifdef CONFIG_TRACE_IRQFLAGS
+	/* Tell the tracer interrupts are on, because idle responds to them. */
 	mflr	r0
 	std	r0,16(r1)
 	stdu    r1,-128(r1)
@@ -73,3 +80,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 	isync
 	b	1b
 
+2:	/* Return if an interrupt had happened while soft disabled */
+	/* Set the HARD_DIS flag because interrupts are now hard disabled */
+	ori	r0,r0,PACA_IRQ_HARD_DIS
+	stb	r0,PACAIRQHAPPENED(r13)
+	blr
-- 
2.17.0
