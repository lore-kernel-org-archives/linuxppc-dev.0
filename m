Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3zpKBB01f7zF1lD
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Feb 2018 18:15:45 +1100 (AEDT)
Received: by mail-pl0-x244.google.com with SMTP id i6so6232041plt.7
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 23 Feb 2018 23:15:45 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [PATCH 2/3] powerpc/64s: make PACA_IRQ_HARD_DIS track MSR[EE]
Date: Sat, 24 Feb 2018 17:15:26 +1000
Message-Id: <20180224071527.5053-3-npiggin@gmail.com>
In-Reply-To: <20180224071527.5053-1-npiggin@gmail.com>
References: <20180224071527.5053-1-npiggin@gmail.com>
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
interrupt that has been masked).

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 arch/powerpc/include/asm/hw_irq.h    | 10 ++++++----
 arch/powerpc/kernel/exceptions-64s.S |  5 ++++-
 arch/powerpc/kernel/irq.c            | 14 ++++++--------
 3 files changed, 16 insertions(+), 13 deletions(-)

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
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 3ac87e53b3da..d1b0b0ef6658 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1446,7 +1446,10 @@ masked_##_H##interrupt:					\
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
index f88038847790..1c9ed0a3ba3f 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -256,16 +256,14 @@ notrace void arch_local_irq_restore(unsigned long mask)
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
@@ -274,8 +272,8 @@ notrace void arch_local_irq_restore(unsigned long mask)
 		 */
 		if (WARN_ON(mfmsr() & MSR_EE))
 			__hard_irq_disable();
-	}
 #endif
+	}
 
 	irq_soft_mask_set(IRQS_ALL_DISABLED);
 	trace_hardirqs_off();
-- 
2.16.1
