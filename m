Return-Path: <npiggin@gmail.com>
Received: from mail-pl0-x244.google.com (mail-pl0-x244.google.com
 [IPv6:2607:f8b0:400e:c01::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1yRm1h7zzF07J
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 Dec 2017 01:52:35 +1100 (AEDT)
Received: by mail-pl0-x244.google.com with SMTP id z5so9131917plo.10
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 06:52:35 -0800 (PST)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>
Subject: [RFC PATCH 6/8] powerpc/64s: put irq_soft_mask bits into r14
Date: Thu, 21 Dec 2017 00:52:04 +1000
Message-Id: <20171220145206.12234-7-npiggin@gmail.com>
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

Put the STD and PMI interrupt mask bits into r14. This benefits
IRQ disabling (enabling to a lesser extent), and soft mask check
in the interrupt entry handler.
---
 arch/powerpc/include/asm/exception-64s.h |  6 +-
 arch/powerpc/include/asm/hw_irq.h        | 98 ++++++++++++--------------------
 arch/powerpc/include/asm/irqflags.h      |  9 +--
 arch/powerpc/include/asm/kvm_ppc.h       |  2 +-
 arch/powerpc/include/asm/paca.h          | 18 +++++-
 arch/powerpc/kernel/asm-offsets.c        |  7 ++-
 arch/powerpc/kernel/entry_64.S           | 19 +++----
 arch/powerpc/kernel/idle_book3s.S        |  3 +
 arch/powerpc/kernel/irq.c                | 12 ++--
 arch/powerpc/kernel/optprobes_head.S     |  3 +-
 arch/powerpc/kernel/process.c            |  2 +-
 arch/powerpc/kernel/setup_64.c           | 11 ++--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |  3 +-
 arch/powerpc/xmon/xmon.c                 |  5 +-
 14 files changed, 95 insertions(+), 103 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index dadaa7471755..5602454ae56f 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -459,9 +459,8 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	mflr	r9;			/* Get LR, later save to stack	*/ \
 	ld	r2,PACATOC(r13);	/* get kernel TOC into r2	*/ \
 	std	r9,_LINK(r1);						   \
-	lbz	r10,PACAIRQSOFTMASK(r13);				   \
 	mfspr	r11,SPRN_XER;		/* save XER in stackframe	*/ \
-	std	r10,SOFTE(r1);						   \
+	std	r14,SOFTE(r1);		/* full r14 not just softe XXX	*/ \
 	std	r11,_XER(r1);						   \
 	li	r9,(n)+1;						   \
 	std	r9,_TRAP(r1);		/* set trap number		*/ \
@@ -526,8 +525,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define SOFTEN_VALUE_0xf00	PACA_IRQ_PMI
 
 #define __SOFTEN_TEST(h, vec, bitmask)					\
-	lbz	r10,PACAIRQSOFTMASK(r13);				\
-	andi.	r10,r10,bitmask;					\
+	andi.	r10,r14,bitmask;					\
 	li	r10,SOFTEN_VALUE_##vec;					\
 	bne	masked_##h##interrupt
 
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index eea02cbf5699..9ba445de989d 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -12,8 +12,9 @@
 #include <asm/ptrace.h>
 #include <asm/processor.h>
 
-#ifdef CONFIG_PPC64
+#ifndef __ASSEMBLY__
 
+#ifdef CONFIG_PPC64
 /*
  * PACA flags in paca->irq_happened.
  *
@@ -30,21 +31,16 @@
 #define PACA_IRQ_PMI		0x40
 
 /*
- * flags for paca->irq_soft_mask
+ * 64s uses r14 rather than paca for irq_soft_mask
  */
-#define IRQ_SOFT_MASK_NONE	0x00
-#define IRQ_SOFT_MASK_STD	0x01 /* local_irq_disable() interrupts */
 #ifdef CONFIG_PPC_BOOK3S
-#define IRQ_SOFT_MASK_PMU	0x02
-#define IRQ_SOFT_MASK_ALL	0x03
-#else
-#define IRQ_SOFT_MASK_ALL	0x01
-#endif
+#define IRQ_SOFT_MASK_STD	(0x01 << R14_BIT_IRQ_SOFT_MASK_SHIFT)
+#define IRQ_SOFT_MASK_PMU	(0x02 << R14_BIT_IRQ_SOFT_MASK_SHIFT)
+#define IRQ_SOFT_MASK_ALL	(0x03 << R14_BIT_IRQ_SOFT_MASK_SHIFT)
+#endif /* CONFIG_PPC_BOOK3S */
 
 #endif /* CONFIG_PPC64 */
 
-#ifndef __ASSEMBLY__
-
 extern void replay_system_reset(void);
 extern void __replay_interrupt(unsigned int vector);
 
@@ -56,24 +52,16 @@ extern void unknown_exception(struct pt_regs *regs);
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 
-static inline notrace unsigned long irq_soft_mask_return(void)
+/*
+ * __irq_soft_mask_set/clear do not have memory clobbers so they
+ * should not be used by themselves to disable/enable irqs.
+ */
+static inline notrace void __irq_soft_mask_set(unsigned long disable_mask)
 {
-	unsigned long flags;
-
-	asm volatile(
-		"lbz %0,%1(13)"
-		: "=r" (flags)
-		: "i" (offsetof(struct paca_struct, irq_soft_mask)));
-
-	return flags;
+	r14_set_bits(disable_mask);
 }
 
-/*
- * The "memory" clobber acts as both a compiler barrier
- * for the critical section and as a clobber because
- * we changed paca->irq_soft_mask
- */
-static inline notrace void irq_soft_mask_set(unsigned long mask)
+static inline notrace void __irq_soft_mask_insert(unsigned long new_mask)
 {
 #ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
 	/*
@@ -90,49 +78,37 @@ static inline notrace void irq_soft_mask_set(unsigned long mask)
 	 * unmasks to be replayed, among other things. For now, take
 	 * the simple approach.
 	 */
-	WARN_ON(mask && !(mask & IRQ_SOFT_MASK_STD));
+	WARN_ON(new_mask && !(new_mask & IRQ_SOFT_MASK_STD));
 #endif
 
-	asm volatile(
-		"stb %0,%1(13)"
-		:
-		: "r" (mask),
-		  "i" (offsetof(struct paca_struct, irq_soft_mask))
-		: "memory");
+	r14_insert_bits(new_mask, IRQ_SOFT_MASK_ALL);
 }
 
-static inline notrace unsigned long irq_soft_mask_set_return(unsigned long mask)
+static inline notrace void __irq_soft_mask_clear(unsigned long enable_mask)
 {
-	unsigned long flags;
-
-#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
-	WARN_ON(mask && !(mask & IRQ_SOFT_MASK_STD));
-#endif
-
-	asm volatile(
-		"lbz %0,%1(13); stb %2,%1(13)"
-		: "=&r" (flags)
-		: "i" (offsetof(struct paca_struct, irq_soft_mask)),
-		  "r" (mask)
-		: "memory");
+	r14_clear_bits(enable_mask);
+}
 
-	return flags;
+static inline notrace unsigned long irq_soft_mask_return(void)
+{
+	return local_r14 & IRQ_SOFT_MASK_ALL;
 }
 
-static inline notrace unsigned long irq_soft_mask_or_return(unsigned long mask)
+static inline notrace void irq_soft_mask_set(unsigned long disable_mask)
 {
-	unsigned long flags, tmp;
+	barrier();
+	__irq_soft_mask_set(disable_mask);
+	barrier();
+}
 
-	asm volatile(
-		"lbz %0,%2(13); or %1,%0,%3; stb %1,%2(13)"
-		: "=&r" (flags), "=r" (tmp)
-		: "i" (offsetof(struct paca_struct, irq_soft_mask)),
-		  "r" (mask)
-		: "memory");
+static inline notrace unsigned long irq_soft_mask_set_return(unsigned long disable_mask)
+{
+	unsigned long flags;
 
-#ifdef CONFIG_PPC_IRQ_SOFT_MASK_DEBUG
-	WARN_ON((mask | flags) && !((mask | flags) & IRQ_SOFT_MASK_STD));
-#endif
+	barrier();
+	flags = irq_soft_mask_return();
+	__irq_soft_mask_set(disable_mask);
+	barrier();
 
 	return flags;
 }
@@ -151,7 +127,7 @@ extern void arch_local_irq_restore(unsigned long);
 
 static inline void arch_local_irq_enable(void)
 {
-	arch_local_irq_restore(IRQ_SOFT_MASK_NONE);
+	arch_local_irq_restore(0);
 }
 
 static inline unsigned long arch_local_irq_save(void)
@@ -179,8 +155,8 @@ static inline bool arch_irqs_disabled(void)
 #define raw_local_irq_pmu_save(flags)					\
 	do {								\
 		typecheck(unsigned long, flags);			\
-		flags = irq_soft_mask_or_return(IRQ_SOFT_MASK_STD |	\
-				IRQ_SOFT_MASK_PMU);			\
+		flags = irq_soft_mask_set_return(			\
+				IRQ_SOFT_MASK_STD | IRQ_SOFT_MASK_PMU);	\
 	} while(0)
 
 #define raw_local_irq_pmu_restore(flags)				\
diff --git a/arch/powerpc/include/asm/irqflags.h b/arch/powerpc/include/asm/irqflags.h
index 492b0a9fa352..19a2752868f8 100644
--- a/arch/powerpc/include/asm/irqflags.h
+++ b/arch/powerpc/include/asm/irqflags.h
@@ -47,14 +47,12 @@
  * be clobbered.
  */
 #define RECONCILE_IRQ_STATE(__rA, __rB)		\
-	lbz	__rA,PACAIRQSOFTMASK(r13);	\
 	lbz	__rB,PACAIRQHAPPENED(r13);	\
-	andi.	__rA,__rA,IRQ_SOFT_MASK_STD;	\
-	li	__rA,IRQ_SOFT_MASK_STD;		\
+	andi.	__rA,r14,IRQ_SOFT_MASK_STD;	\
+	ori	r14,r14,IRQ_SOFT_MASK_STD;	\
 	ori	__rB,__rB,PACA_IRQ_HARD_DIS;	\
 	stb	__rB,PACAIRQHAPPENED(r13);	\
 	bne	44f;				\
-	stb	__rA,PACAIRQSOFTMASK(r13);	\
 	TRACE_DISABLE_INTS;			\
 44:
 
@@ -64,9 +62,8 @@
 
 #define RECONCILE_IRQ_STATE(__rA, __rB)		\
 	lbz	__rA,PACAIRQHAPPENED(r13);	\
-	li	__rB,IRQ_SOFT_MASK_STD;		\
+	ori	r14,r14,IRQ_SOFT_MASK_STD;	\
 	ori	__rA,__rA,PACA_IRQ_HARD_DIS;	\
-	stb	__rB,PACAIRQSOFTMASK(r13);	\
 	stb	__rA,PACAIRQHAPPENED(r13)
 #endif
 #endif
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 08053e596753..028b7cefe089 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -873,7 +873,7 @@ static inline void kvmppc_fix_ee_before_entry(void)
 
 	/* Only need to enable IRQs by hard enabling them after this */
 	local_paca->irq_happened = 0;
-	irq_soft_mask_set(IRQ_SOFT_MASK_NONE);
+	__irq_soft_mask_clear(IRQ_SOFT_MASK_ALL);
 #endif
 }
 
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index cd3637f4ee4e..dbf80fff2f53 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -36,8 +36,10 @@
 register struct paca_struct *local_paca asm("r13");
 #ifdef CONFIG_PPC_BOOK3S
 
-#define R14_BIT_IO_SYNC			0x0001
-#define R14_BIT_IRQ_WORK_PENDING	0x0002 /* IRQ_WORK interrupt while soft-disable */
+#define R14_BIT_IRQ_SOFT_MASK_SHIFT	0
+#define R14_BIT_IRQ_SOFT_MASK		(0x3 << R14_BIT_IRQ_SOFT_MASK_SHIFT)
+#define R14_BIT_IO_SYNC			0x0004
+#define R14_BIT_IRQ_WORK_PENDING	0x0008 /* IRQ_WORK interrupt while soft-disable */
 
 /*
  * The top 32-bits of r14 is used as the per-cpu offset, shifted by PAGE_SHIFT.
@@ -79,6 +81,17 @@ static inline void r14_flip_bits(unsigned long mask)
 				: "0" (local_r14), "r" (mask));
 }
 
+static inline void r14_insert_bits(unsigned long source, unsigned long mask)
+{
+	unsigned long first = ffs(mask) - 1;
+	unsigned long last = fls64(mask) - 1;
+
+	mask >>= first;
+	asm volatile("rldimi	%0,%2,%3,%4\n"
+			: "=r" (local_r14)
+			: "0" (local_r14), "r" (source), "i" (first), "i" (63 - last));
+}
+
 static inline void r14_clear_bits(unsigned long mask)
 {
 	asm volatile("andc	%0,%0,%2\n"
@@ -211,7 +224,6 @@ struct paca_struct {
 	u64 saved_r1;			/* r1 save for RTAS calls or PM */
 	u64 saved_msr;			/* MSR saved here by enter_rtas */
 	u16 trap_save;			/* Used when bad stack is encountered */
-	u8 irq_soft_mask;		/* mask for irq soft masking */
 	u8 irq_happened;		/* irq happened while soft-disabled */
 	u8 nap_state_lost;		/* NV GPR values lost in power7_idle */
 	u64 sprg_vdso;			/* Saved user-visible sprg */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 32d393f55a96..c5c005d354b0 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -83,6 +83,12 @@ int main(void)
 #ifdef CONFIG_PPC64
 	DEFINE(SIGSEGV, SIGSEGV);
 	DEFINE(NMI_MASK, NMI_MASK);
+	DEFINE(R14_BIT_IRQ_SOFT_MASK_SHIFT, R14_BIT_IRQ_SOFT_MASK_SHIFT);
+	DEFINE(R14_BIT_IRQ_SOFT_MASK, R14_BIT_IRQ_SOFT_MASK);
+	DEFINE(IRQ_SOFT_MASK_STD, IRQ_SOFT_MASK_STD);
+	DEFINE(IRQ_SOFT_MASK_PMU, IRQ_SOFT_MASK_PMU);
+	DEFINE(IRQ_SOFT_MASK_ALL, IRQ_SOFT_MASK_ALL);
+
 	OFFSET(TASKTHREADPPR, task_struct, thread.ppr);
 #else
 	OFFSET(THREAD_INFO, task_struct, stack);
@@ -178,7 +184,6 @@ int main(void)
 	OFFSET(PACATOC, paca_struct, kernel_toc);
 	OFFSET(PACAKBASE, paca_struct, kernelbase);
 	OFFSET(PACAKMSR, paca_struct, kernel_msr);
-	OFFSET(PACAIRQSOFTMASK, paca_struct, irq_soft_mask);
 	OFFSET(PACAIRQHAPPENED, paca_struct, irq_happened);
 #ifdef CONFIG_PPC_BOOK3S
 	OFFSET(PACACONTEXTID, paca_struct, mm_ctx_id);
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 6b0e3ac311e8..dd06f8f874f3 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -141,8 +141,8 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	 * is correct
 	 */
 #if defined(CONFIG_PPC_IRQ_SOFT_MASK_DEBUG) && defined(CONFIG_BUG)
-	lbz	r10,PACAIRQSOFTMASK(r13)
-1:	tdnei	r10,IRQ_SOFT_MASK_NONE
+	andi.	r10,r14,R14_BIT_IRQ_SOFT_MASK
+1:	tdnei	r10,0
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
 
@@ -158,7 +158,7 @@ system_call:			/* label this so stack traces look sane */
 	/* We do need to set SOFTE in the stack frame or the return
 	 * from interrupt will be painful
 	 */
-	li	r10,IRQ_SOFT_MASK_NONE
+	li	r10,0
 	std	r10,SOFTE(r1)
 
 	CURRENT_THREAD_INFO(r11, r1)
@@ -793,13 +793,12 @@ restore:
 	 * are about to re-enable interrupts
 	 */
 	ld	r5,SOFTE(r1)
-	lbz	r6,PACAIRQSOFTMASK(r13)
 	andi.	r5,r5,IRQ_SOFT_MASK_STD
 	bne	.Lrestore_irq_off
 
 	/* We are enabling, were we already enabled ? Yes, just return */
-	andi.	r6,r6,IRQ_SOFT_MASK_STD
-	beq	cr0,.Ldo_restore
+	andi.	r5,r14,IRQ_SOFT_MASK_STD
+	beq	.Ldo_restore
 
 	/*
 	 * We are about to soft-enable interrupts (we are hard disabled
@@ -817,8 +816,8 @@ restore:
 	 */
 .Lrestore_no_replay:
 	TRACE_ENABLE_INTS
-	li	r0,IRQ_SOFT_MASK_NONE
-	stb	r0,PACAIRQSOFTMASK(r13);
+	li	r0,R14_BIT_IRQ_SOFT_MASK
+	andc	r14,r14,r0
 
 	/*
 	 * Final return path. BookE is handled in a different file
@@ -1056,8 +1055,8 @@ _GLOBAL(enter_rtas)
 	/* There is no way it is acceptable to get here with interrupts enabled,
 	 * check it with the asm equivalent of WARN_ON
 	 */
-	lbz	r0,PACAIRQSOFTMASK(r13)
-1:	tdeqi	r0,IRQ_SOFT_MASK_NONE
+	andi.	r0,r14,R14_BIT_IRQ_SOFT_MASK
+1:	tdeqi	r0,0
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
 
diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
index 3b6de0ba4e03..0a7de4e13cf8 100644
--- a/arch/powerpc/kernel/idle_book3s.S
+++ b/arch/powerpc/kernel/idle_book3s.S
@@ -510,12 +510,15 @@ pnv_powersave_wakeup:
 BEGIN_FTR_SECTION
 BEGIN_FTR_SECTION_NESTED(70)
 	bl	power9_dd1_recover_paca
+	ld	r14,PACA_R14(r13)
 END_FTR_SECTION_NESTED_IFSET(CPU_FTR_POWER9_DD1, 70)
 	bl	pnv_restore_hyp_resource_arch300
 FTR_SECTION_ELSE
 	bl	pnv_restore_hyp_resource_arch207
 ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
 
+	ori	r14,r14,PACA_IRQ_HARD_DIS
+
 	li	r0,PNV_THREAD_RUNNING
 	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
 
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index e7619d144c15..2341029653e4 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -230,10 +230,13 @@ notrace void arch_local_irq_restore(unsigned long mask)
 	unsigned int replay;
 
 	/* Write the new soft-enabled value */
-	irq_soft_mask_set(mask);
+	__irq_soft_mask_insert(mask);
+	/* any bits still disabled */
 	if (mask)
 		return;
 
+	barrier();
+
 	/*
 	 * From this point onward, we can take interrupts, preempt,
 	 * etc... unless we got hard-disabled. We check if an event
@@ -261,6 +264,7 @@ notrace void arch_local_irq_restore(unsigned long mask)
 	 * then we are already hard disabled (there are other less
 	 * common cases that we'll ignore for now), so we skip the
 	 * (expensive) mtmsrd.
+	 * XXX: why not test & IRQ_HARD_DIS?
 	 */
 	if (unlikely(irq_happened != PACA_IRQ_HARD_DIS))
 		__hard_irq_disable();
@@ -277,7 +281,7 @@ notrace void arch_local_irq_restore(unsigned long mask)
 	}
 #endif
 
-	irq_soft_mask_set(IRQ_SOFT_MASK_ALL);
+	__irq_soft_mask_set(IRQ_SOFT_MASK_ALL);
 	trace_hardirqs_off();
 
 	/*
@@ -289,7 +293,7 @@ notrace void arch_local_irq_restore(unsigned long mask)
 
 	/* We can soft-enable now */
 	trace_hardirqs_on();
-	irq_soft_mask_set(IRQ_SOFT_MASK_NONE);
+	__irq_soft_mask_clear(IRQ_SOFT_MASK_ALL);
 
 	/*
 	 * And replay if we have to. This will return with interrupts
@@ -364,7 +368,7 @@ bool prep_irq_for_idle(void)
 	 * of entering the low power state.
 	 */
 	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
-	irq_soft_mask_set(IRQ_SOFT_MASK_NONE);
+	__irq_soft_mask_clear(IRQ_SOFT_MASK_ALL);
 
 	/* Tell the caller to enter the low power state */
 	return true;
diff --git a/arch/powerpc/kernel/optprobes_head.S b/arch/powerpc/kernel/optprobes_head.S
index 98a3aeeb3c8c..c8f106e6bc70 100644
--- a/arch/powerpc/kernel/optprobes_head.S
+++ b/arch/powerpc/kernel/optprobes_head.S
@@ -58,8 +58,7 @@ optprobe_template_entry:
 	std	r5,_XER(r1)
 	mfcr	r5
 	std	r5,_CCR(r1)
-	lbz     r5,PACAIRQSOFTMASK(r13)
-	std     r5,SOFTE(r1)
+	std     r14,SOFTE(r1)
 
 	/*
 	 * We may get here from a module, so load the kernel TOC in r2.
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index f56e42f06f24..5914da5db7d9 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1675,7 +1675,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 			childregs->gpr[FIRST_NVGPR] = ppc_function_entry((void *)usp);
 #ifdef CONFIG_PPC64
 		clear_tsk_thread_flag(p, TIF_32BIT);
-		childregs->softe = IRQ_SOFT_MASK_NONE;
+		childregs->softe = 0;
 #endif
 		childregs->gpr[FIRST_NVGPR + 1] = kthread_arg;
 		p->thread.regs = NULL;	/* no user register state */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index f4a96ebb523a..6e4f4e46b76b 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -190,11 +190,12 @@ static void __init fixup_boot_paca(void)
 	get_paca()->cpu_start = 1;
 	/* Allow percpu accesses to work until we setup percpu data */
 	get_paca()->data_offset = 0;
-	/* Mark interrupts disabled in PACA */
-	irq_soft_mask_set(IRQ_SOFT_MASK_STD);
 	/* Set r14 and paca_r14 to zero */
 	get_paca()->r14 = 0;
 	local_r14 = get_paca()->r14;
+
+	/* Mark interrupts disabled in PACA or r14 */
+	__irq_soft_mask_set(IRQ_SOFT_MASK_STD);
 }
 
 static void __init configure_exceptions(void)
@@ -356,8 +357,8 @@ void __init early_setup(unsigned long dt_ptr)
 #ifdef CONFIG_SMP
 void early_setup_secondary(void)
 {
-	/* Mark interrupts disabled in PACA */
-	irq_soft_mask_set(IRQ_SOFT_MASK_STD);
+	/* Mark interrupts disabled in r14 */
+	__irq_soft_mask_set(IRQ_SOFT_MASK_STD);
 
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu_secondary();
@@ -768,7 +769,7 @@ void __init setup_per_cpu_areas(void)
 		/* The top 48 bits are used for per-cpu data */
 		paca[cpu].r14 |= paca[cpu].data_offset << 16;
 	}
-	local_r14 = paca[smp_processor_id()].r14;
+	local_r14 |= paca[smp_processor_id()].r14;
 }
 #endif
 
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index a92ad8500917..88455123352c 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -3249,11 +3249,10 @@ kvmppc_bad_host_intr:
 	mfctr	r4
 #endif
 	mfxer	r5
-	lbz	r6, PACAIRQSOFTMASK(r13)
 	std	r3, _LINK(r1)
 	std	r4, _CTR(r1)
 	std	r5, _XER(r1)
-	std	r6, SOFTE(r1)
+	std	r14, SOFTE(r1)
 	ld	r2, PACATOC(r13)
 	LOAD_REG_IMMEDIATE(3, 0x7265677368657265)
 	std	r3, STACK_FRAME_OVERHEAD-16(r1)
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index 7d2bb26ff333..d7d3885035f2 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1622,8 +1622,8 @@ static void excprint(struct pt_regs *fp)
 
 	printf("  current = 0x%lx\n", current);
 #ifdef CONFIG_PPC64
-	printf("  paca    = 0x%lx\t softe: %d\t irq_happened: 0x%02x\n",
-	       local_paca, local_paca->irq_soft_mask, local_paca->irq_happened);
+	printf("  paca    = 0x%lx\t r14: 0x%lx\t irq_happened: 0x%02x\n",
+	       local_paca, local_r14, local_paca->irq_happened);
 #endif
 	if (current) {
 		printf("    pid   = %ld, comm = %s\n",
@@ -2391,7 +2391,6 @@ static void dump_one_paca(int cpu)
 	DUMP(p, stab_rr, "lx");
 	DUMP(p, saved_r1, "lx");
 	DUMP(p, trap_save, "x");
-	DUMP(p, irq_soft_mask, "x");
 	DUMP(p, irq_happened, "x");
 	DUMP(p, nap_state_lost, "x");
 	DUMP(p, sprg_vdso, "llx");
-- 
2.15.0
