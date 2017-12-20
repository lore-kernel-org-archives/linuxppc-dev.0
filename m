Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x243.google.com (mail-pl0-x243.google.com
 [IPv6:2607:f8b0:400e:c01::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1yRs0JnkzF07C
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 01:52:40 +1100 (AEDT)
Received: by mail-pl0-x243.google.com with SMTP id i6so9132793plt.13
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 06:52:40 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 7/8] powerpc/64s: put irq_soft_mask and irq_happened bits
 into r14
Date: Thu, 21 Dec 2017 00:52:05 +1000
Message-Id: <20171220145206.12234-8-npiggin@gmail.com>
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

This should be split into two patches. irq_happened and soft_mask.
It may not be worth putting all irq_happened bits into r14, just a
single "an irq did happen" bit may be good enough to then load a
paca variable.
---
 arch/powerpc/include/asm/hw_irq.h    | 23 +++++++++----
 arch/powerpc/include/asm/irqflags.h  | 21 +++++-------
 arch/powerpc/include/asm/kvm_ppc.h   |  4 +--
 arch/powerpc/include/asm/paca.h      |  7 ++--
 arch/powerpc/kernel/asm-offsets.c    |  9 +++++-
 arch/powerpc/kernel/entry_64.S       | 13 ++++----
 arch/powerpc/kernel/exceptions-64s.S |  4 +--
 arch/powerpc/kernel/head_64.S        | 15 ++-------
 arch/powerpc/kernel/irq.c            | 62 ++++++++++++++----------------------
 arch/powerpc/kvm/book3s_hv.c         |  6 ++--
 arch/powerpc/xmon/xmon.c             |  4 +--
 11 files changed, 76 insertions(+), 92 deletions(-)

diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 9ba445de989d..f492a7779ea3 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -22,6 +22,7 @@
  * and allow a proper replay. Additionally, PACA_IRQ_HARD_DIS
  * is set whenever we manually hard disable.
  */
+#ifdef CONFIG_PPC_BOOK3E
 #define PACA_IRQ_HARD_DIS	0x01
 #define PACA_IRQ_DBELL		0x02
 #define PACA_IRQ_EE		0x04
@@ -30,14 +31,22 @@
 #define PACA_IRQ_HMI		0x20
 #define PACA_IRQ_PMI		0x40
 
+#else /* CONFIG_PPC_BOOK3E */
 /*
- * 64s uses r14 rather than paca for irq_soft_mask
+ * 64s uses r14 rather than paca for irq_soft_mask and irq_happened
  */
-#ifdef CONFIG_PPC_BOOK3S
+
+#define PACA_IRQ_HARD_DIS	(0x01 << R14_BIT_IRQ_HAPPENED_SHIFT)
+#define PACA_IRQ_DBELL		(0x02 << R14_BIT_IRQ_HAPPENED_SHIFT)
+#define PACA_IRQ_EE		(0x04 << R14_BIT_IRQ_HAPPENED_SHIFT)
+#define PACA_IRQ_DEC		(0x08 << R14_BIT_IRQ_HAPPENED_SHIFT)
+#define PACA_IRQ_HMI		(0x10 << R14_BIT_IRQ_HAPPENED_SHIFT)
+#define PACA_IRQ_PMI		(0x20 << R14_BIT_IRQ_HAPPENED_SHIFT)
+
 #define IRQ_SOFT_MASK_STD	(0x01 << R14_BIT_IRQ_SOFT_MASK_SHIFT)
 #define IRQ_SOFT_MASK_PMU	(0x02 << R14_BIT_IRQ_SOFT_MASK_SHIFT)
 #define IRQ_SOFT_MASK_ALL	(0x03 << R14_BIT_IRQ_SOFT_MASK_SHIFT)
-#endif /* CONFIG_PPC_BOOK3S */
+#endif /* CONFIG_PPC_BOOK3E */
 
 #endif /* CONFIG_PPC64 */
 
@@ -206,14 +215,14 @@ static inline bool arch_irqs_disabled(void)
 	unsigned long flags;						\
 	__hard_irq_disable();						\
 	flags = irq_soft_mask_set_return(IRQ_SOFT_MASK_ALL);		\
-	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;			\
+	r14_set_bits(PACA_IRQ_HARD_DIS);				\
 	if (!arch_irqs_disabled_flags(flags))				\
 		trace_hardirqs_off();					\
 } while(0)
 
 static inline bool lazy_irq_pending(void)
 {
-	return !!(get_paca()->irq_happened & ~PACA_IRQ_HARD_DIS);
+	return !!(local_r14 & R14_BIT_IRQ_HAPPENED_MASK & ~PACA_IRQ_HARD_DIS);
 }
 
 /*
@@ -223,8 +232,8 @@ static inline bool lazy_irq_pending(void)
  */
 static inline void may_hard_irq_enable(void)
 {
-	get_paca()->irq_happened &= ~PACA_IRQ_HARD_DIS;
-	if (!(get_paca()->irq_happened & PACA_IRQ_EE))
+	r14_clear_bits(PACA_IRQ_HARD_DIS);
+	if (!(local_r14 & PACA_IRQ_EE))
 		__hard_irq_enable();
 }
 
diff --git a/arch/powerpc/include/asm/irqflags.h b/arch/powerpc/include/asm/irqflags.h
index 19a2752868f8..140e51b9f436 100644
--- a/arch/powerpc/include/asm/irqflags.h
+++ b/arch/powerpc/include/asm/irqflags.h
@@ -45,26 +45,21 @@
  *
  * NB: This may call C code, so the caller must be prepared for volatiles to
  * be clobbered.
+ * XXX: could make this single-register now
  */
-#define RECONCILE_IRQ_STATE(__rA, __rB)		\
-	lbz	__rB,PACAIRQHAPPENED(r13);	\
-	andi.	__rA,r14,IRQ_SOFT_MASK_STD;	\
-	ori	r14,r14,IRQ_SOFT_MASK_STD;	\
-	ori	__rB,__rB,PACA_IRQ_HARD_DIS;	\
-	stb	__rB,PACAIRQHAPPENED(r13);	\
-	bne	44f;				\
-	TRACE_DISABLE_INTS;			\
+#define RECONCILE_IRQ_STATE(__rA, __rB)					\
+	andi.	__rA,r14,IRQ_SOFT_MASK_STD;				\
+	ori	r14,r14,(PACA_IRQ_HARD_DIS | IRQ_SOFT_MASK_STD);	\
+	bne	44f;							\
+	TRACE_DISABLE_INTS;						\
 44:
 
 #else
 #define TRACE_ENABLE_INTS
 #define TRACE_DISABLE_INTS
 
-#define RECONCILE_IRQ_STATE(__rA, __rB)		\
-	lbz	__rA,PACAIRQHAPPENED(r13);	\
-	ori	r14,r14,IRQ_SOFT_MASK_STD;	\
-	ori	__rA,__rA,PACA_IRQ_HARD_DIS;	\
-	stb	__rA,PACAIRQHAPPENED(r13)
+#define RECONCILE_IRQ_STATE(__rA, __rB)					\
+	ori	r14,r14,(PACA_IRQ_HARD_DIS | IRQ_SOFT_MASK_STD)
 #endif
 #endif
 
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 028b7cefe089..45202e124003 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -869,10 +869,10 @@ static inline void kvmppc_fix_ee_before_entry(void)
 	 * To avoid races, the caller must have gone directly from having
 	 * interrupts fully-enabled to hard-disabled.
 	 */
-	WARN_ON(local_paca->irq_happened != PACA_IRQ_HARD_DIS);
+	WARN_ON((local_r14 & R14_BIT_IRQ_HAPPENED_MASK) != PACA_IRQ_HARD_DIS);
 
 	/* Only need to enable IRQs by hard enabling them after this */
-	local_paca->irq_happened = 0;
+	r14_clear_bits(R14_BIT_IRQ_HAPPENED_MASK);
 	__irq_soft_mask_clear(IRQ_SOFT_MASK_ALL);
 #endif
 }
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index dbf80fff2f53..4edfcdecb268 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -38,8 +38,10 @@ register struct paca_struct *local_paca asm("r13");
 
 #define R14_BIT_IRQ_SOFT_MASK_SHIFT	0
 #define R14_BIT_IRQ_SOFT_MASK		(0x3 << R14_BIT_IRQ_SOFT_MASK_SHIFT)
-#define R14_BIT_IO_SYNC			0x0004
-#define R14_BIT_IRQ_WORK_PENDING	0x0008 /* IRQ_WORK interrupt while soft-disable */
+#define R14_BIT_IRQ_HAPPENED_SHIFT	2
+#define R14_BIT_IRQ_HAPPENED_MASK	(0x3f << R14_BIT_IRQ_HAPPENED_SHIFT) /* irq happened while soft-disabled */
+#define R14_BIT_IO_SYNC			0x0100
+#define R14_BIT_IRQ_WORK_PENDING	0x0200 /* IRQ_WORK interrupt while soft-disable */
 
 /*
  * The top 32-bits of r14 is used as the per-cpu offset, shifted by PAGE_SHIFT.
@@ -224,7 +226,6 @@ struct paca_struct {
 	u64 saved_r1;			/* r1 save for RTAS calls or PM */
 	u64 saved_msr;			/* MSR saved here by enter_rtas */
 	u16 trap_save;			/* Used when bad stack is encountered */
-	u8 irq_happened;		/* irq happened while soft-disabled */
 	u8 nap_state_lost;		/* NV GPR values lost in power7_idle */
 	u64 sprg_vdso;			/* Saved user-visible sprg */
 #ifdef CONFIG_PPC_TRANSACTIONAL_MEM
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index c5c005d354b0..2f03f778baf2 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -88,6 +88,14 @@ int main(void)
 	DEFINE(IRQ_SOFT_MASK_STD, IRQ_SOFT_MASK_STD);
 	DEFINE(IRQ_SOFT_MASK_PMU, IRQ_SOFT_MASK_PMU);
 	DEFINE(IRQ_SOFT_MASK_ALL, IRQ_SOFT_MASK_ALL);
+	DEFINE(R14_BIT_IRQ_HAPPENED_SHIFT, R14_BIT_IRQ_HAPPENED_SHIFT);
+	DEFINE(R14_BIT_IRQ_HAPPENED_MASK, R14_BIT_IRQ_HAPPENED_MASK);
+	DEFINE(PACA_IRQ_HARD_DIS, PACA_IRQ_HARD_DIS);
+	DEFINE(PACA_IRQ_EE, PACA_IRQ_EE);
+	DEFINE(PACA_IRQ_DBELL, PACA_IRQ_DBELL);
+	DEFINE(PACA_IRQ_DEC, PACA_IRQ_DEC);
+	DEFINE(PACA_IRQ_HMI, PACA_IRQ_HMI);
+	DEFINE(PACA_IRQ_PMI, PACA_IRQ_PMI);
 
 	OFFSET(TASKTHREADPPR, task_struct, thread.ppr);
 #else
@@ -184,7 +192,6 @@ int main(void)
 	OFFSET(PACATOC, paca_struct, kernel_toc);
 	OFFSET(PACAKBASE, paca_struct, kernelbase);
 	OFFSET(PACAKMSR, paca_struct, kernel_msr);
-	OFFSET(PACAIRQHAPPENED, paca_struct, irq_happened);
 #ifdef CONFIG_PPC_BOOK3S
 	OFFSET(PACACONTEXTID, paca_struct, mm_ctx_id);
 #ifdef CONFIG_PPC_MM_SLICES
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index dd06f8f874f3..33e596d587fb 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -805,8 +805,7 @@ restore:
 	 * at this point). We check if there's anything that needs to
 	 * be replayed first.
 	 */
-	lbz	r0,PACAIRQHAPPENED(r13)
-	cmpwi	cr0,r0,0
+	andi.	r0,r14,R14_BIT_IRQ_HAPPENED_MASK
 	bne-	.Lrestore_check_irq_replay
 
 	/*
@@ -919,16 +918,16 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 	 */
 .Lrestore_irq_off:
 	ld	r3,_MSR(r1)
-	lbz	r7,PACAIRQHAPPENED(r13)
+	ori	r14,r14,IRQ_SOFT_MASK_STD
 	andi.	r0,r3,MSR_EE
 	beq	1f
-	rlwinm	r7,r7,0,~PACA_IRQ_HARD_DIS
-	stb	r7,PACAIRQHAPPENED(r13)
+	li	r0,PACA_IRQ_HARD_DIS
+	andc	r14,r14,r0
 1:
 #if defined(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG) && defined(CONFIG_BUG)
 	/* The interrupt should not have soft enabled. */
-	lbz	r7,PACAIRQSOFTMASK(r13)
-	tdeqi	r7,IRQ_SOFT_MASK_NONE
+	andi.	r7,r14,R14_BIT_IRQ_SOFT_MASK
+1:	tdeqi	r7,0
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
 	b	.Ldo_restore
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index ca962bf85b8a..4da2b586e29e 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1404,9 +1404,7 @@ EXC_COMMON_BEGIN(soft_nmi_common)
  */
 #define MASKED_INTERRUPT(_H)				\
 masked_##_H##interrupt:					\
-	lbz	r11,PACAIRQHAPPENED(r13);		\
-	or	r11,r11,r10;				\
-	stb	r11,PACAIRQHAPPENED(r13);		\
+	or	r14,r14,r10;				\
 	cmpwi	r10,PACA_IRQ_DEC;			\
 	bne	1f;					\
 	lis	r10,0x7fff;				\
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index cdb710f43681..60de1aa6ef85 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -767,10 +767,7 @@ _GLOBAL(pmac_secondary_start)
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
 	 */
-	li	r0,IRQ_SOFT_MASK_STD
-	stb	r0,PACAIRQSOFTMASK(r13)
-	li	r0,PACA_IRQ_HARD_DIS
-	stb	r0,PACAIRQHAPPENED(r13)
+	ori	r14,r14,(IRQ_SOFT_MASK_STD | PACA_IRQ_HARD_DIS)
 
 	/* Create a temp kernel stack for use before relocation is on.	*/
 	ld	r1,PACAEMERGSP(r13)
@@ -824,10 +821,7 @@ __secondary_start:
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
 	 */
-	li	r7,IRQ_SOFT_MASK_STD
-	stb	r7,PACAIRQSOFTMASK(r13)
-	li	r0,PACA_IRQ_HARD_DIS
-	stb	r0,PACAIRQHAPPENED(r13)
+	ori	r14,r14,(IRQ_SOFT_MASK_STD | PACA_IRQ_HARD_DIS)
 
 	/* enable MMU and jump to start_secondary */
 	LOAD_REG_ADDR(r3, start_secondary_prolog)
@@ -991,10 +985,7 @@ start_here_common:
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
 	 */
-	li	r0,IRQ_SOFT_MASK_STD
-	stb	r0,PACAIRQSOFTMASK(r13)
-	li	r0,PACA_IRQ_HARD_DIS
-	stb	r0,PACAIRQHAPPENED(r13)
+	ori	r14,r14,(IRQ_SOFT_MASK_STD | PACA_IRQ_HARD_DIS)
 
 	/* Generic kernel entry */
 	bl	start_kernel
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index 2341029653e4..ebaf210a7406 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -99,12 +99,7 @@ int distribute_irqs = 1;
 
 static inline notrace unsigned long get_irq_happened(void)
 {
-	unsigned long happened;
-
-	__asm__ __volatile__("lbz %0,%1(13)"
-	: "=r" (happened) : "i" (offsetof(struct paca_struct, irq_happened)));
-
-	return happened;
+	return local_r14 & R14_BIT_IRQ_HAPPENED_MASK;
 }
 
 static inline notrace int decrementer_check_overflow(void)
@@ -131,13 +126,6 @@ static inline notrace int decrementer_check_overflow(void)
  */
 notrace unsigned int __check_irq_replay(void)
 {
-	/*
-	 * We use local_paca rather than get_paca() to avoid all
-	 * the debug_smp_processor_id() business in this low level
-	 * function
-	 */
-	unsigned char happened = local_paca->irq_happened;
-
 	/*
 	 * We are responding to the next interrupt, so interrupt-off
 	 * latencies should be reset here.
@@ -145,20 +133,17 @@ notrace unsigned int __check_irq_replay(void)
 	trace_hardirqs_on();
 	trace_hardirqs_off();
 
-	if (happened & PACA_IRQ_HARD_DIS) {
+	if (local_r14 & PACA_IRQ_HARD_DIS) {
 		/* Clear bit 0 which we wouldn't clear otherwise */
-		local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
-
+		r14_clear_bits(PACA_IRQ_HARD_DIS);
 		/*
 		 * We may have missed a decrementer interrupt if hard disabled.
 		 * Check the decrementer register in case we had a rollover
 		 * while hard disabled.
 		 */
-		if (!(happened & PACA_IRQ_DEC)) {
-			if (decrementer_check_overflow()) {
-				local_paca->irq_happened |= PACA_IRQ_DEC;
-				happened |= PACA_IRQ_DEC;
-			}
+		if (!(local_r14 & PACA_IRQ_DEC)) {
+			if (decrementer_check_overflow())
+				r14_set_bits(PACA_IRQ_DEC);
 		}
 	}
 
@@ -176,23 +161,24 @@ notrace unsigned int __check_irq_replay(void)
 	 * This is a higher priority interrupt than the others, so
 	 * replay it first.
 	 */
-	if (happened & PACA_IRQ_HMI) {
-		local_paca->irq_happened &= ~PACA_IRQ_HMI;
+	if (local_r14 & PACA_IRQ_HMI) {
+		r14_clear_bits(PACA_IRQ_HMI);
 		return 0xe60;
 	}
 
-	if (happened & PACA_IRQ_DEC) {
-		local_paca->irq_happened &= ~PACA_IRQ_DEC;
+	if (local_r14 & PACA_IRQ_DEC) {
+		r14_clear_bits(PACA_IRQ_DEC);
 		return 0x900;
 	}
 
-	if (happened & PACA_IRQ_PMI) {
-		local_paca->irq_happened &= ~PACA_IRQ_PMI;
+	if (local_r14 & PACA_IRQ_PMI) {
+		r14_clear_bits(PACA_IRQ_PMI);
 		return 0xf00;
 	}
 
-	if (happened & PACA_IRQ_EE) {
-		local_paca->irq_happened &= ~PACA_IRQ_EE;
+	/* Finally check if an external interrupt happened */
+	if (local_r14 & PACA_IRQ_EE) {
+		r14_clear_bits(PACA_IRQ_EE);
 		return 0x500;
 	}
 
@@ -212,14 +198,14 @@ notrace unsigned int __check_irq_replay(void)
 		return 0x280;
 	}
 #else
-	if (happened & PACA_IRQ_DBELL) {
-		local_paca->irq_happened &= ~PACA_IRQ_DBELL;
+	if (local_r14 & PACA_IRQ_DBELL) {
+		r14_clear_bits(PACA_IRQ_DBELL);
 		return 0xa00;
 	}
 #endif /* CONFIG_PPC_BOOK3E */
 
 	/* There should be nothing left ! */
-	BUG_ON(local_paca->irq_happened != 0);
+	BUG_ON((local_r14 & R14_BIT_IRQ_HAPPENED_MASK) != 0);
 
 	return 0;
 }
@@ -321,7 +307,7 @@ EXPORT_SYMBOL(arch_local_irq_restore);
 void notrace restore_interrupts(void)
 {
 	if (irqs_disabled()) {
-		local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
+		r14_set_bits(PACA_IRQ_HARD_DIS);
 		local_irq_enable();
 	} else
 		__hard_irq_enable();
@@ -349,7 +335,7 @@ bool prep_irq_for_idle(void)
 	 * occurs before we effectively enter the low power state
 	 */
 	__hard_irq_disable();
-	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
+	r14_set_bits(PACA_IRQ_HARD_DIS);
 
 	/*
 	 * If anything happened while we were soft-disabled,
@@ -367,7 +353,7 @@ bool prep_irq_for_idle(void)
 	 * are about to hard enable as well as a side effect
 	 * of entering the low power state.
 	 */
-	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
+	r14_clear_bits(PACA_IRQ_HARD_DIS);
 	__irq_soft_mask_clear(IRQ_SOFT_MASK_ALL);
 
 	/* Tell the caller to enter the low power state */
@@ -390,7 +376,7 @@ bool prep_irq_for_idle_irqsoff(void)
 	 * occurs before we effectively enter the low power state
 	 */
 	__hard_irq_disable();
-	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;
+	r14_set_bits(PACA_IRQ_HARD_DIS);
 
 	/*
 	 * If anything happened while we were soft-disabled,
@@ -465,7 +451,7 @@ void irq_set_pending_from_srr1(unsigned long srr1)
 	 * If a future CPU was to designate this as an interrupt reason,
 	 * then a new index for no interrupt must be assigned.
 	 */
-	local_paca->irq_happened |= reason;
+	r14_set_bits(reason);
 }
 #endif /* CONFIG_PPC_BOOK3S */
 
@@ -481,7 +467,7 @@ void force_external_irq_replay(void)
 	WARN_ON(!arch_irqs_disabled());
 
 	/* Indicate in the PACA that we have an interrupt to replay */
-	local_paca->irq_happened |= PACA_IRQ_EE;
+	r14_set_bits(PACA_IRQ_EE);
 }
 
 #endif /* CONFIG_PPC64 */
diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
index 2d46037ce936..870dd835c8b6 100644
--- a/arch/powerpc/kvm/book3s_hv.c
+++ b/arch/powerpc/kvm/book3s_hv.c
@@ -2614,13 +2614,13 @@ static void set_irq_happened(int trap)
 {
 	switch (trap) {
 	case BOOK3S_INTERRUPT_EXTERNAL:
-		local_paca->irq_happened |= PACA_IRQ_EE;
+		r14_set_bits(PACA_IRQ_EE);
 		break;
 	case BOOK3S_INTERRUPT_H_DOORBELL:
-		local_paca->irq_happened |= PACA_IRQ_DBELL;
+		r14_set_bits(PACA_IRQ_DBELL);
 		break;
 	case BOOK3S_INTERRUPT_HMI:
-		local_paca->irq_happened |= PACA_IRQ_HMI;
+		r14_set_bits(PACA_IRQ_HMI);
 		break;
 	case BOOK3S_INTERRUPT_SYSTEM_RESET:
 		replay_system_reset();
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index d7d3885035f2..df73f8a1f030 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1622,8 +1622,7 @@ static void excprint(struct pt_regs *fp)
 
 	printf("  current = 0x%lx\n", current);
 #ifdef CONFIG_PPC64
-	printf("  paca    = 0x%lx\t r14: 0x%lx\t irq_happened: 0x%02x\n",
-	       local_paca, local_r14, local_paca->irq_happened);
+	printf("  paca    = 0x%lx\t r14: %lx\n", local_paca, local_r14);
 #endif
 	if (current) {
 		printf("    pid   = %ld, comm = %s\n",
@@ -2391,7 +2390,6 @@ static void dump_one_paca(int cpu)
 	DUMP(p, stab_rr, "lx");
 	DUMP(p, saved_r1, "lx");
 	DUMP(p, trap_save, "x");
-	DUMP(p, irq_happened, "x");
 	DUMP(p, nap_state_lost, "x");
 	DUMP(p, sprg_vdso, "llx");
 
-- 
2.15.0
