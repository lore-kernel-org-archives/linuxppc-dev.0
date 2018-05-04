Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x242.google.com (mail-pf0-x242.google.com
 [IPv6:2607:f8b0:400e:c00::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40czKV0T2hzDr4K
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  5 May 2018 03:19:58 +1000 (AEST)
Received: by mail-pf0-x242.google.com with SMTP id j20so3612889pff.10
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 May 2018 10:19:57 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 03/11] powerpc/64s: make PACA_IRQ_HARD_DIS track MSR[EE]
 closely
Date: Sat,  5 May 2018 03:19:27 +1000
Message-Id: <20180504171935.25410-4-npiggin@gmail.com>
In-Reply-To: <20180504171935.25410-1-npiggin@gmail.com>
References: <20180504171935.25410-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When the masked interrupt handler clears MSR[EE] for an interrupt in
the PACA_IRQ_MUST_HARD_MASK set, it does not set PACA_IRQ_HARD_DIS.
This makes them get out of synch.

With that taken into account, it's only low level irq manipulation
(and interrupt entry before reconcile) where they can be out of synch.
This makes the code less surprising.

It also allows the IRQ replay code to rely on the IRQ_HARD_DIS value
and not have to mtmsrd again in this case (e.g., for an external
interrupt that has been masked). The bigger benefit might just be
that there is not such an element of surprise in these two bits of
state.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/hw_irq.h    | 10 ++++++----
 arch/powerpc/kernel/entry_64.S       |  8 ++++++++
 arch/powerpc/kernel/exceptions-64s.S |  5 ++++-
 arch/powerpc/kernel/irq.c            | 28 +++++++++++++++++++---------
 4 files changed, 37 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 855e17d158b1..8004d7887ff6 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -248,14 +248,16 @@ static inline bool lazy_irq_pending(void)
 
 /*
  * This is called by asynchronous interrupts to conditionally
- * re-enable hard interrupts when soft-disabled after having
- * cleared the source of the interrupt
+ * re-enable hard interrupts after having cleared the source
+ * of the interrupt. They are kept disabled if there is a different
+ * soft-masked interrupt pending that requires hard masking.
  */
 static inline void may_hard_irq_enable(void)
 {
-	get_paca()->irq_happened &= ~PACA_IRQ_HARD_DIS;
-	if (!(get_paca()->irq_happened & PACA_IRQ_MUST_HARD_MASK))
+	if (!(get_paca()->irq_happened & PACA_IRQ_MUST_HARD_MASK)) {
+		get_paca()->irq_happened &= ~PACA_IRQ_HARD_DIS;
 		__hard_irq_enable();
+	}
 }
 
 static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 51695608c68b..db4df061c33a 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -973,6 +973,14 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	or	r4,r4,r3
 	std	r4,_TRAP(r1)
 
+	/*
+	 * PACA_IRQ_HARD_DIS won't always be set here, so set it now
+	 * to reconcile the IRQ state. Tracing is already accounted for.
+	 */
+	ld	r4,PACAIRQHAPPENED(r13)
+	ori	r4,r4,PACA_IRQ_HARD_DIS
+	stb	r4,PACAIRQHAPPENED(r13)
+
 	/*
 	 * Then find the right handler and call it. Interrupts are
 	 * still soft-disabled and we keep them that way.
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index ae6a849db60b..69172dd41b11 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1498,7 +1498,10 @@ masked_##_H##interrupt:					\
 	mfspr	r10,SPRN_##_H##SRR1;			\
 	xori	r10,r10,MSR_EE; /* clear MSR_EE */	\
 	mtspr	SPRN_##_H##SRR1,r10;			\
-2:	mtcrf	0x80,r9;				\
+	ori	r11,r11,PACA_IRQ_HARD_DIS;		\
+	stb	r11,PACAIRQHAPPENED(r13);		\
+2:	/* done */					\
+	mtcrf	0x80,r9;				\
 	ld	r9,PACA_EXGEN+EX_R9(r13);		\
 	ld	r10,PACA_EXGEN+EX_R10(r13);		\
 	ld	r11,PACA_EXGEN+EX_R11(r13);		\
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 061aa0f47bb1..6569b5ffff93 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -145,8 +145,20 @@ notrace unsigned int __check_irq_replay(void)
 	trace_hardirqs_on();
 	trace_hardirqs_off();
 
+	/*
+	 * We are always hard disabled here, but PACA_IRQ_HARD_DIS may
+	 * not be set, which means interrupts have only just been hard
+	 * disabled as part of the local_irq_restore or interrupt return
+	 * code. In that case, skip the decrementr check becaus it's
+	 * expensive to read the TB.
+	 *
+	 * HARD_DIS then gets cleared here, but it's reconciled later.
+	 * Either local_irq_disable will replay the interrupt and that
+	 * will reconcile state like other hard interrupts. Or interrupt
+	 * retur will replay the interrupt and in that case it sets
+	 * PACA_IRQ_HARD_DIS by hand (see comments in entry_64.S).
+	 */
 	if (happened & PACA_IRQ_HARD_DIS) {
-		/* Clear bit 0 which we wouldn't clear otherwise */
 		local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
 
 		/*
@@ -256,16 +268,14 @@ notrace void arch_local_irq_restore(unsigned long mask)
 	 * __check_irq_replay(). We also need to soft-disable
 	 * again to avoid warnings in there due to the use of
 	 * per-cpu variables.
-	 *
-	 * We know that if the value in irq_happened is exactly 0x01
-	 * then we are already hard disabled (there are other less
-	 * common cases that we'll ignore for now), so we skip the
-	 * (expensive) mtmsrd.
 	 */
-	if (unlikely(irq_happened != PACA_IRQ_HARD_DIS))
+	if (!(irq_happened & PACA_IRQ_HARD_DIS)) {
+#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
+		WARN_ON(!(mfmsr() & MSR_EE));
+#endif
 		__hard_irq_disable();
 #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
-	else {
+	} else {
 		/*
 		 * We should already be hard disabled here. We had bugs
 		 * where that wasn't the case so let's dbl check it and
@@ -274,8 +284,8 @@ notrace void arch_local_irq_restore(unsigned long mask)
 		 */
 		if (WARN_ON(mfmsr() & MSR_EE))
 			__hard_irq_disable();
-	}
 #endif
+	}
 
 	irq_soft_mask_set(IRQS_ALL_DISABLED);
 	trace_hardirqs_off();
-- 
2.17.0
