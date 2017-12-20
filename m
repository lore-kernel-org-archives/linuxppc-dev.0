Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1yRs3ShjzDql5
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 01:52:41 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id m25so11995878pgv.12
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 06:52:41 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 8/8] powerpc/64s: inline local_irq_enable/restore
Date: Thu, 21 Dec 2017 00:52:06 +1000
Message-Id: <20171220145206.12234-9-npiggin@gmail.com>
In-Reply-To: <20171220145206.12234-1-npiggin@gmail.com>
References: <20171220145206.12234-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This does increase kernel text size by about 0.4%, but code is often
improved by putting the interrupt-replay call out of line, and gcc
function "shrink wrapping" can more often avoid setting up a stack
frame, e.g., _raw_spin_unlock_irqrestore fastpath before:

	<_raw_spin_unlock_irqrestore>:
	addis   r2,r12,63
	addi    r2,r2,24688
	mflr    r0
	andi.   r9,r14,256
	mr      r9,r3
	std     r0,16(r1)
	stdu    r1,-32(r1)
	bne     c0000000009fd1e0 <_raw_spin_unlock_irqrestore+0x50>
	lwsync
	li      r10,0
	mr      r3,r4
	stw     r10,0(r9)
	bl      c000000000013f98 <arch_local_irq_restore+0x8>

		<arch_local_irq_restore>:
		addis   r2,r12,222
		addi    r2,r2,-3472
		rldimi  r14,r3,0,62
		cmpdi   cr7,r3,0
		bnelr   cr7
		andi.   r9,r14,252
		beqlr

	nop
	addi    r1,r1,32
	ld      r0,16(r1)
	mtlr    r0
	blr

And after:

	<_raw_spin_unlock_irqrestore>:
	addis   r2,r12,64
	addi    r2,r2,-15200
	andi.   r9,r14,256
	bne     c000000000a06dd0 <_raw_spin_unlock_irqrestore+0x70>
	lwsync
	li      r9,0
	stw     r9,0(r3)
	rldimi  r14,r4,0,62
	cmpdi   cr7,r4,0
	bne     cr7,c000000000a06d90 <_raw_spin_unlock_irqrestore+0x30>
	andi.   r9,r14,252
	bne     c000000000a06da0 <_raw_spin_unlock_irqrestore+0x40>
	blr

GCC can still improve code size for the slow paths by avoiding aligning
branch targets too, so there is room to reduce the text size cost there.
---
 arch/powerpc/include/asm/hw_irq.h | 15 +++++++++++++--
 arch/powerpc/kernel/irq.c         | 28 ++++++----------------------
 2 files changed, 19 insertions(+), 24 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index f492a7779ea3..8690e0d5605d 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -132,11 +132,22 @@ static inline void arch_local_irq_disable(void)
 	irq_soft_mask_set(IRQ_SOFT_MASK_STD);
 }
 
-extern void arch_local_irq_restore(unsigned long);
+extern void __arch_local_irq_enable(void);
 
 static inline void arch_local_irq_enable(void)
 {
-	arch_local_irq_restore(0);
+	__irq_soft_mask_clear(IRQ_SOFT_MASK_ALL);
+	if (unlikely(local_r14 & R14_BIT_IRQ_HAPPENED_MASK))
+		__arch_local_irq_enable();
+}
+
+static inline void arch_local_irq_restore(unsigned long flags)
+{
+	__irq_soft_mask_insert(flags);
+	if (!flags) {
+		if (unlikely(local_r14 & R14_BIT_IRQ_HAPPENED_MASK))
+			__arch_local_irq_enable();
+	}
 }
 
 static inline unsigned long arch_local_irq_save(void)
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index ebaf210a7406..e2ff0210477e 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -97,11 +97,6 @@ extern int tau_interrupts(int);
 
 int distribute_irqs = 1;
 
-static inline notrace unsigned long get_irq_happened(void)
-{
-	return local_r14 & R14_BIT_IRQ_HAPPENED_MASK;
-}
-
 static inline notrace int decrementer_check_overflow(void)
 {
  	u64 now = get_tb_or_rtc();
@@ -210,19 +205,10 @@ notrace unsigned int __check_irq_replay(void)
 	return 0;
 }
 
-notrace void arch_local_irq_restore(unsigned long mask)
+notrace void __arch_local_irq_enable(void)
 {
-	unsigned char irq_happened;
 	unsigned int replay;
 
-	/* Write the new soft-enabled value */
-	__irq_soft_mask_insert(mask);
-	/* any bits still disabled */
-	if (mask)
-		return;
-
-	barrier();
-
 	/*
 	 * From this point onward, we can take interrupts, preempt,
 	 * etc... unless we got hard-disabled. We check if an event
@@ -236,9 +222,6 @@ notrace void arch_local_irq_restore(unsigned long mask)
 	 * be hard-disabled, so there is no problem, we
 	 * cannot have preempted.
 	 */
-	irq_happened = get_irq_happened();
-	if (!irq_happened)
-		return;
 
 	/*
 	 * We need to hard disable to get a trusted value from
@@ -252,10 +235,11 @@ notrace void arch_local_irq_restore(unsigned long mask)
 	 * (expensive) mtmsrd.
 	 * XXX: why not test & IRQ_HARD_DIS?
 	 */
-	if (unlikely(irq_happened != PACA_IRQ_HARD_DIS))
+	if (unlikely((local_r14 & R14_BIT_IRQ_HAPPENED_MASK) !=
+						PACA_IRQ_HARD_DIS)) {
 		__hard_irq_disable();
 #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
-	else {
+	} else {
 		/*
 		 * We should already be hard disabled here. We had bugs
 		 * where that wasn't the case so let's dbl check it and
@@ -264,8 +248,8 @@ notrace void arch_local_irq_restore(unsigned long mask)
 		 */
 		if (WARN_ON(mfmsr() & MSR_EE))
 			__hard_irq_disable();
-	}
 #endif
+	}
 
 	__irq_soft_mask_set(IRQ_SOFT_MASK_ALL);
 	trace_hardirqs_off();
@@ -293,7 +277,7 @@ notrace void arch_local_irq_restore(unsigned long mask)
 	/* Finally, let's ensure we are hard enabled */
 	__hard_irq_enable();
 }
-EXPORT_SYMBOL(arch_local_irq_restore);
+EXPORT_SYMBOL(__arch_local_irq_enable);
 
 /*
  * This is specifically called by assembly code to re-enable interrupts
-- 
2.15.0
