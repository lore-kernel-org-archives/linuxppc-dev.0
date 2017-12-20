Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3z1gv33bZtzF08V
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 Dec 2017 14:56:47 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 vBK3sbwf062987
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:56:44 -0500
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2eyb49ukj8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Dec 2017 22:56:44 -0500
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 20 Dec 2017 03:56:42 -0000
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@kernel.crashing.org, anton@samba.org, paulus@samba.org,
 npiggin@gmail.com, linuxppc-dev@lists.ozlabs.org,
 Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Subject: [PATCH v10 10/17] powerpc/64: Rename soft_enabled to irq_soft_mask
Date: Wed, 20 Dec 2017 09:25:50 +0530
In-Reply-To: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
References: <1513742157-28768-1-git-send-email-maddy@linux.vnet.ibm.com>
Message-Id: <1513742157-28768-11-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Rename the paca->soft_enabled to paca->irq_soft_mask as it is no
longer used as a flag for interrupt state, but a mask.

Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/exception-64s.h |  6 +--
 arch/powerpc/include/asm/hw_irq.h        | 70 +++++++++++++++++---------------
 arch/powerpc/include/asm/irqflags.h      | 12 +++---
 arch/powerpc/include/asm/kvm_ppc.h       |  2 +-
 arch/powerpc/include/asm/paca.h          |  2 +-
 arch/powerpc/kernel/asm-offsets.c        |  2 +-
 arch/powerpc/kernel/entry_64.S           | 26 ++++++------
 arch/powerpc/kernel/exceptions-64e.S     | 16 ++++----
 arch/powerpc/kernel/head_64.S            | 12 +++---
 arch/powerpc/kernel/idle_book3e.S        |  4 +-
 arch/powerpc/kernel/idle_power4.S        |  4 +-
 arch/powerpc/kernel/irq.c                | 23 +++--------
 arch/powerpc/kernel/optprobes_head.S     |  2 +-
 arch/powerpc/kernel/process.c            |  2 +-
 arch/powerpc/kernel/ptrace.c             |  2 +-
 arch/powerpc/kernel/setup_64.c           |  4 +-
 arch/powerpc/kernel/time.c               |  6 +--
 arch/powerpc/kvm/book3s_hv_rmhandlers.S  |  2 +-
 arch/powerpc/mm/hugetlbpage.c            |  2 +-
 arch/powerpc/perf/core-book3s.c          |  2 +-
 arch/powerpc/xmon/xmon.c                 |  4 +-
 21 files changed, 99 insertions(+), 106 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index b8f8a78ffa09..f9a9269df62e 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -432,7 +432,7 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 	mflr	r9;			/* Get LR, later save to stack	*/ \
 	ld	r2,PACATOC(r13);	/* get kernel TOC into r2	*/ \
 	std	r9,_LINK(r1);						   \
-	lbz	r10,PACASOFTIRQEN(r13);				   \
+	lbz	r10,PACAIRQSOFTMASK(r13);				   \
 	mfspr	r11,SPRN_XER;		/* save XER in stackframe	*/ \
 	std	r10,SOFTE(r1);						   \
 	std	r11,_XER(r1);						   \
@@ -498,8 +498,8 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
 #define SOFTEN_VALUE_0xea0	PACA_IRQ_EE
 
 #define __SOFTEN_TEST(h, vec)						\
-	lbz	r10,PACASOFTIRQEN(r13);					\
-	andi.	r10,r10,IRQ_DISABLE_MASK;				\
+	lbz	r10,PACAIRQSOFTMASK(r13);				\
+	andi.	r10,r10,IRQ_SOFT_MASK_STD;				\
 	li	r10,SOFTEN_VALUE_##vec;					\
 	bne	masked_##h##interrupt
 
diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
index 82c4e3572aa9..6022aa6d1dd4 100644
--- a/arch/powerpc/include/asm/hw_irq.h
+++ b/arch/powerpc/include/asm/hw_irq.h
@@ -29,10 +29,10 @@
 #define PACA_IRQ_HMI		0x20
 
 /*
- * flags for paca->soft_enabled
+ * flags for paca->irq_soft_mask
  */
-#define IRQ_DISABLE_MASK_NONE	0x00
-#define IRQ_DISABLE_MASK	0x01
+#define IRQ_SOFT_MASK_NONE	0x00
+#define IRQ_SOFT_MASK_STD	0x01
 
 #endif /* CONFIG_PPC64 */
 
@@ -49,14 +49,14 @@ extern void unknown_exception(struct pt_regs *regs);
 #ifdef CONFIG_PPC64
 #include <asm/paca.h>
 
-static inline notrace unsigned long soft_enabled_return(void)
+static inline notrace unsigned long irq_soft_mask_return(void)
 {
 	unsigned long flags;
 
 	asm volatile(
 		"lbz %0,%1(13)"
 		: "=r" (flags)
-		: "i" (offsetof(struct paca_struct, soft_enabled)));
+		: "i" (offsetof(struct paca_struct, irq_soft_mask)));
 
 	return flags;
 }
@@ -64,42 +64,48 @@ static inline notrace unsigned long soft_enabled_return(void)
 /*
  * The "memory" clobber acts as both a compiler barrier
  * for the critical section and as a clobber because
- * we changed paca->soft_enabled
+ * we changed paca->irq_soft_mask
  */
-static inline notrace void soft_enabled_set(unsigned long enable)
+static inline notrace void irq_soft_mask_set(unsigned long mask)
 {
 #ifdef CONFIG_TRACE_IRQFLAGS
 	/*
-	 * mask must always include LINUX bit if any are set, and
-	 * interrupts don't get replayed until the Linux interrupt is
-	 * unmasked. This could be changed to replay partial unmasks
-	 * in future, which would allow Linux masks to nest inside
-	 * other masks, among other things. For now, be very dumb and
-	 * simple.
+	 * The irq mask must always include the STD bit if any are set.
+	 *
+	 * and interrupts don't get replayed until the standard
+	 * interrupt (local_irq_disable()) is unmasked.
+	 *
+	 * Other masks must only provide additional masking beyond
+	 * the standard, and they are also not replayed until the
+	 * standard interrupt becomes unmasked.
+	 *
+	 * This could be changed, but it will require partial
+	 * unmasks to be replayed, among other things. For now, take
+	 * the simple approach.
 	 */
-	WARN_ON(mask && !(mask & IRQ_DISABLE_MASK));
+	WARN_ON(mask && !(mask & IRQ_SOFT_MASK_STD));
 #endif
 
 	asm volatile(
 		"stb %0,%1(13)"
 		:
-		: "r" (enable),
-		  "i" (offsetof(struct paca_struct, soft_enabled))
+		: "r" (mask),
+		  "i" (offsetof(struct paca_struct, irq_soft_mask))
 		: "memory");
 }
 
-static inline notrace unsigned long soft_enabled_set_return(unsigned long mask)
+static inline notrace unsigned long irq_soft_mask_set_return(unsigned long mask)
 {
 	unsigned long flags;
 
 #ifdef CONFIG_TRACE_IRQFLAGS
-	WARN_ON(mask && !(mask & IRQ_DISABLE_MASK));
+	WARN_ON(mask && !(mask & IRQ_SOFT_MASK_STD));
 #endif
 
 	asm volatile(
 		"lbz %0,%1(13); stb %2,%1(13)"
 		: "=&r" (flags)
-		: "i" (offsetof(struct paca_struct, soft_enabled)),
+		: "i" (offsetof(struct paca_struct, irq_soft_mask)),
 		  "r" (mask)
 		: "memory");
 
@@ -108,29 +114,29 @@ static inline notrace unsigned long soft_enabled_set_return(unsigned long mask)
 
 static inline unsigned long arch_local_save_flags(void)
 {
-	return soft_enabled_return();
+	return irq_soft_mask_return();
 }
 
 static inline void arch_local_irq_disable(void)
 {
-	soft_enabled_set(IRQ_DISABLED);
+	irq_soft_mask_set(IRQ_SOFT_MASK_STD);
 }
 
 extern void arch_local_irq_restore(unsigned long);
 
 static inline void arch_local_irq_enable(void)
 {
-	arch_local_irq_restore(IRQ_DISABLE_MASK_NONE);
+	arch_local_irq_restore(IRQ_SOFT_MASK_NONE);
 }
 
 static inline unsigned long arch_local_irq_save(void)
 {
-	return soft_enabled_set_return(IRQ_DISABLE_MASK);
+	return irq_soft_mask_set_return(IRQ_SOFT_MASK_STD);
 }
 
 static inline bool arch_irqs_disabled_flags(unsigned long flags)
 {
-	return flags & IRQ_DISABLE_MASK;
+	return flags & IRQ_SOFT_MASK_STD;
 }
 
 static inline bool arch_irqs_disabled(void)
@@ -146,13 +152,13 @@ static inline bool arch_irqs_disabled(void)
 #define __hard_irq_disable()	__mtmsrd(local_paca->kernel_msr, 1)
 #endif
 
-#define hard_irq_disable()	do {			\
-	unsigned long flags;				\
-	__hard_irq_disable();				\
-	flags = soft_enabled_set_return(IRQ_DISABLE_MASK);\
-	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;	\
-	if (!arch_irqs_disabled_flags(flags))		\
-		trace_hardirqs_off();			\
+#define hard_irq_disable()	do {				\
+	unsigned long flags;					\
+	__hard_irq_disable();					\
+	flags = irq_soft_mask_set_return(IRQ_SOFT_MASK_STD);	\
+	local_paca->irq_happened |= PACA_IRQ_HARD_DIS;		\
+	if (!arch_irqs_disabled_flags(flags))			\
+		trace_hardirqs_off();				\
 } while(0)
 
 static inline bool lazy_irq_pending(void)
@@ -174,7 +180,7 @@ static inline void may_hard_irq_enable(void)
 
 static inline bool arch_irq_disabled_regs(struct pt_regs *regs)
 {
-	return (regs->softe & IRQ_DISABLE_MASK);
+	return (regs->softe & IRQ_SOFT_MASK_STD);
 }
 
 extern bool prep_irq_for_idle(void);
diff --git a/arch/powerpc/include/asm/irqflags.h b/arch/powerpc/include/asm/irqflags.h
index 0fd6ec7d8797..492b0a9fa352 100644
--- a/arch/powerpc/include/asm/irqflags.h
+++ b/arch/powerpc/include/asm/irqflags.h
@@ -47,14 +47,14 @@
  * be clobbered.
  */
 #define RECONCILE_IRQ_STATE(__rA, __rB)		\
-	lbz	__rA,PACASOFTIRQEN(r13);	\
+	lbz	__rA,PACAIRQSOFTMASK(r13);	\
 	lbz	__rB,PACAIRQHAPPENED(r13);	\
-	andi.	__rA,__rA,IRQ_DISABLE_MASK;\
-	li	__rA,IRQ_DISABLE_MASK;	\
+	andi.	__rA,__rA,IRQ_SOFT_MASK_STD;	\
+	li	__rA,IRQ_SOFT_MASK_STD;		\
 	ori	__rB,__rB,PACA_IRQ_HARD_DIS;	\
 	stb	__rB,PACAIRQHAPPENED(r13);	\
 	bne	44f;				\
-	stb	__rA,PACASOFTIRQEN(r13);	\
+	stb	__rA,PACAIRQSOFTMASK(r13);	\
 	TRACE_DISABLE_INTS;			\
 44:
 
@@ -64,9 +64,9 @@
 
 #define RECONCILE_IRQ_STATE(__rA, __rB)		\
 	lbz	__rA,PACAIRQHAPPENED(r13);	\
-	li	__rB,IRQ_DISABLE_MASK;	\
+	li	__rB,IRQ_SOFT_MASK_STD;		\
 	ori	__rA,__rA,PACA_IRQ_HARD_DIS;	\
-	stb	__rB,PACASOFTIRQEN(r13);	\
+	stb	__rB,PACAIRQSOFTMASK(r13);	\
 	stb	__rA,PACAIRQHAPPENED(r13)
 #endif
 #endif
diff --git a/arch/powerpc/include/asm/kvm_ppc.h b/arch/powerpc/include/asm/kvm_ppc.h
index 09992b9d9401..08053e596753 100644
--- a/arch/powerpc/include/asm/kvm_ppc.h
+++ b/arch/powerpc/include/asm/kvm_ppc.h
@@ -873,7 +873,7 @@ static inline void kvmppc_fix_ee_before_entry(void)
 
 	/* Only need to enable IRQs by hard enabling them after this */
 	local_paca->irq_happened = 0;
-	soft_enabled_set(IRQ_DISABLE_MASK_NONE);
+	irq_soft_mask_set(IRQ_SOFT_MASK_NONE);
 #endif
 }
 
diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
index 3892db93b837..e2ee193eb24d 100644
--- a/arch/powerpc/include/asm/paca.h
+++ b/arch/powerpc/include/asm/paca.h
@@ -159,7 +159,7 @@ struct paca_struct {
 	u64 saved_r1;			/* r1 save for RTAS calls or PM */
 	u64 saved_msr;			/* MSR saved here by enter_rtas */
 	u16 trap_save;			/* Used when bad stack is encountered */
-	u8 soft_enabled;		/* irq soft-enable flag */
+	u8 irq_soft_mask;		/* mask for irq soft masking */
 	u8 irq_happened;		/* irq happened while soft-disabled */
 	u8 io_sync;			/* writel() needs spin_unlock sync */
 	u8 irq_work_pending;		/* IRQ_WORK interrupt while soft-disable */
diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
index 6b958414b4e0..397681f43eed 100644
--- a/arch/powerpc/kernel/asm-offsets.c
+++ b/arch/powerpc/kernel/asm-offsets.c
@@ -178,7 +178,7 @@ int main(void)
 	OFFSET(PACATOC, paca_struct, kernel_toc);
 	OFFSET(PACAKBASE, paca_struct, kernelbase);
 	OFFSET(PACAKMSR, paca_struct, kernel_msr);
-	OFFSET(PACASOFTIRQEN, paca_struct, soft_enabled);
+	OFFSET(PACAIRQSOFTMASK, paca_struct, irq_soft_mask);
 	OFFSET(PACAIRQHAPPENED, paca_struct, irq_happened);
 #ifdef CONFIG_PPC_BOOK3S
 	OFFSET(PACACONTEXTID, paca_struct, mm_ctx_id);
diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 62d615328f57..25951224b383 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -129,8 +129,8 @@ END_FW_FTR_SECTION_IFSET(FW_FEATURE_SPLPAR)
 	 * is correct
 	 */
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_BUG)
-	lbz	r10,PACASOFTIRQEN(r13)
-1:	tdnei	r10,IRQ_DISABLE_MASK_NONE
+	lbz	r10,PACAIRQSOFTMASK(r13)
+1:	tdnei	r10,IRQ_SOFT_MASK_NONE
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
 
@@ -146,7 +146,7 @@ system_call:			/* label this so stack traces look sane */
 	/* We do need to set SOFTE in the stack frame or the return
 	 * from interrupt will be painful
 	 */
-	li	r10,IRQ_DISABLE_MASK_NONE
+	li	r10,IRQ_SOFT_MASK_NONE
 	std	r10,SOFTE(r1)
 
 	CURRENT_THREAD_INFO(r11, r1)
@@ -743,7 +743,7 @@ resume_kernel:
 	cmpwi	cr0,r8,0
 	bne	restore
 	ld	r0,SOFTE(r1)
-	andi.	r0,r0,IRQ_DISABLE_MASK
+	andi.	r0,r0,IRQ_SOFT_MASK_STD
 	bne	restore
 
 	/*
@@ -781,12 +781,12 @@ restore:
 	 * are about to re-enable interrupts
 	 */
 	ld	r5,SOFTE(r1)
-	lbz	r6,PACASOFTIRQEN(r13)
-	andi.	r5,r5,IRQ_DISABLE_MASK
+	lbz	r6,PACAIRQSOFTMASK(r13)
+	andi.	r5,r5,IRQ_SOFT_MASK_STD
 	bne	.Lrestore_irq_off
 
 	/* We are enabling, were we already enabled ? Yes, just return */
-	andi.	r6,r6,IRQ_DISABLE_MASK
+	andi.	r6,r6,IRQ_SOFT_MASK_STD
 	beq	cr0,.Ldo_restore
 
 	/*
@@ -805,8 +805,8 @@ restore:
 	 */
 .Lrestore_no_replay:
 	TRACE_ENABLE_INTS
-	li	r0,IRQ_DISABLE_MASK_NONE
-	stb	r0,PACASOFTIRQEN(r13);
+	li	r0,IRQ_SOFT_MASK_NONE
+	stb	r0,PACAIRQSOFTMASK(r13);
 
 	/*
 	 * Final return path. BookE is handled in a different file
@@ -913,8 +913,8 @@ END_FTR_SECTION_IFSET(CPU_FTR_HAS_PPR)
 1:
 #if defined(CONFIG_TRACE_IRQFLAGS) && defined(CONFIG_BUG)
 	/* The interrupt should not have soft enabled. */
-	lbz	r7,PACASOFTIRQEN(r13)
-	tdeqi	r7,IRQ_DISABLE_MASK_NONE
+	lbz	r7,PACAIRQSOFTMASK(r13)
+	tdeqi	r7,IRQ_SOFT_MASK_NONE
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
 	b	.Ldo_restore
@@ -1034,8 +1034,8 @@ _GLOBAL(enter_rtas)
 	/* There is no way it is acceptable to get here with interrupts enabled,
 	 * check it with the asm equivalent of WARN_ON
 	 */
-	lbz	r0,PACASOFTIRQEN(r13)
-1:	tdeqi	r0,IRQ_DISABLE_MASK_NONE
+	lbz	r0,PACAIRQSOFTMASK(r13)
+1:	tdeqi	r0,IRQ_SOFT_MASK_NONE
 	EMIT_BUG_ENTRY 1b,__FILE__,__LINE__,BUGFLAG_WARNING
 #endif
 
diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
index 15dcc89dcbcc..7fdf4da0059e 100644
--- a/arch/powerpc/kernel/exceptions-64e.S
+++ b/arch/powerpc/kernel/exceptions-64e.S
@@ -139,7 +139,7 @@ END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 	mfspr	r10,SPRN_ESR
 	SPECIAL_EXC_STORE(r10,ESR)
 
-	lbz	r10,PACASOFTIRQEN(r13)
+	lbz	r10,PACAIRQSOFTMASK(r13)
 	SPECIAL_EXC_STORE(r10,SOFTE)
 	ld	r10,_NIP(r1)
 	SPECIAL_EXC_STORE(r10,CSRR0)
@@ -206,17 +206,17 @@ BEGIN_FTR_SECTION
 	mtspr	SPRN_MAS8,r10
 END_FTR_SECTION_IFSET(CPU_FTR_EMB_HV)
 
-	lbz	r6,PACASOFTIRQEN(r13)
+	lbz	r6,PACAIRQSOFTMASK(r13)
 	ld	r5,SOFTE(r1)
 
 	/* Interrupts had better not already be enabled... */
-	tweqi	r6,IRQ_DISABLE_MASK_NONE
+	tweqi	r6,IRQ_SOFT_MASK_NONE
 
-	andi.	r6,r5,IRQ_DISABLE_MASK
+	andi.	r6,r5,IRQ_SOFT_MASK_STD
 	bne	1f
 
 	TRACE_ENABLE_INTS
-	stb	r5,PACASOFTIRQEN(r13)
+	stb	r5,PACAIRQSOFTMASK(r13)
 1:
 	/*
 	 * Restore PACAIRQHAPPENED rather than setting it based on
@@ -351,8 +351,8 @@ ret_from_mc_except:
 #define PROLOG_ADDITION_NONE_MC(n)
 
 #define PROLOG_ADDITION_MASKABLE_GEN(n)					    \
-	lbz	r10,PACASOFTIRQEN(r13); /* are irqs soft-disabled ? */	    \
-	andi.	r10,r10,IRQ_DISABLE_MASK;	/* yes -> go out of line */ \
+	lbz	r10,PACAIRQSOFTMASK(r13);	/* are irqs soft-masked? */ \
+	andi.	r10,r10,IRQ_SOFT_MASK_STD;	/* yes -> go out of line */ \
 	bne	masked_interrupt_book3e_##n
 
 #define PROLOG_ADDITION_2REGS_GEN(n)					    \
@@ -397,7 +397,7 @@ exc_##n##_common:							    \
 	mfspr	r8,SPRN_XER;		/* save XER in stackframe */	    \
 	ld	r9,excf+EX_R1(r13);	/* load orig r1 back from PACA */   \
 	lwz	r10,excf+EX_CR(r13);	/* load orig CR back from PACA	*/  \
-	lbz	r11,PACASOFTIRQEN(r13);	/* get current IRQ softe */	    \
+	lbz	r11,PACAIRQSOFTMASK(r13); /* get current IRQ softe */	    \
 	ld	r12,exception_marker@toc(r2);				    \
 	li	r0,0;							    \
 	std	r3,GPR10(r1);		/* save r10 to stackframe */	    \
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index d43286208ee2..56f9e112b98d 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -765,8 +765,8 @@ _GLOBAL(pmac_secondary_start)
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
 	 */
-	li	r0,IRQ_DISABLE_MASK
-	stb	r0,PACASOFTIRQEN(r13)
+	li	r0,IRQ_SOFT_MASK_STD
+	stb	r0,PACAIRQSOFTMASK(r13)
 	li	r0,PACA_IRQ_HARD_DIS
 	stb	r0,PACAIRQHAPPENED(r13)
 
@@ -822,8 +822,8 @@ __secondary_start:
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
 	 */
-	li	r7,IRQ_DISABLE_MASK
-	stb	r7,PACASOFTIRQEN(r13)
+	li	r7,IRQ_SOFT_MASK_STD
+	stb	r7,PACAIRQSOFTMASK(r13)
 	li	r0,PACA_IRQ_HARD_DIS
 	stb	r0,PACAIRQHAPPENED(r13)
 
@@ -989,8 +989,8 @@ start_here_common:
 	/* Mark interrupts soft and hard disabled (they might be enabled
 	 * in the PACA when doing hotplug)
 	 */
-	li	r0,IRQ_DISABLE_MASK
-	stb	r0,PACASOFTIRQEN(r13)
+	li	r0,IRQ_SOFT_MASK_STD
+	stb	r0,PACAIRQSOFTMASK(r13)
 	li	r0,PACA_IRQ_HARD_DIS
 	stb	r0,PACAIRQHAPPENED(r13)
 
diff --git a/arch/powerpc/kernel/idle_book3e.S b/arch/powerpc/kernel/idle_book3e.S
index a459c306b04e..5466207c1027 100644
--- a/arch/powerpc/kernel/idle_book3e.S
+++ b/arch/powerpc/kernel/idle_book3e.S
@@ -47,8 +47,8 @@ _GLOBAL(\name)
 	bl	trace_hardirqs_on
 	addi    r1,r1,128
 #endif
-	li	r0,IRQ_DISABLE_MASK_NONE
-	stb	r0,PACASOFTIRQEN(r13)
+	li	r0,IRQ_SOFT_MASK_NONE
+	stb	r0,PACAIRQSOFTMASK(r13)
 	
 	/* Interrupts will make use return to LR, so get something we want
 	 * in there
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index 785e10619d8d..fc6e8aadc9c6 100644
--- a/arch/powerpc/kernel/idle_power4.S
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -54,8 +54,8 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
 	mfmsr	r7
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
-	li	r0,IRQ_DISABLE_MASK_NONE
-	stb	r0,PACASOFTIRQEN(r13)	/* we'll hard-enable shortly */
+	li	r0,IRQ_SOFT_MASK_NONE
+	stb	r0,PACAIRQSOFTMASK(r13)	/* we'll hard-enable shortly */
 BEGIN_FTR_SECTION
 	DSSALL
 	sync
diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
index f3b580d18f0d..4b21b502c148 100644
--- a/arch/powerpc/kernel/irq.c
+++ b/arch/powerpc/kernel/irq.c
@@ -225,22 +225,9 @@ notrace void arch_local_irq_restore(unsigned long mask)
 	unsigned int replay;
 
 	/* Write the new soft-enabled value */
-	soft_enabled_set(mask);
-	if (mask) {
-#ifdef CONFIG_TRACE_IRQFLAGS
-		/*
-		 * mask must always include LINUX bit if any
-		 * are set, and interrupts don't get replayed until
-		 * the Linux interrupt is unmasked. This could be
-		 * changed to replay partial unmasks in future,
-		 * which would allow Linux masks to nest inside
-		 * other masks, among other things. For now, be very
-		 * dumb and simple.
-		 */
-		WARN_ON(!(mask & IRQ_DISABLE_MASK));
-#endif
+	irq_soft_mask_set(mask);
+	if (mask)
 		return;
-	}
 
 	/*
 	 * From this point onward, we can take interrupts, preempt,
@@ -285,7 +272,7 @@ notrace void arch_local_irq_restore(unsigned long mask)
 	}
 #endif /* CONFIG_TRACE_IRQFLAGS */
 
-	soft_enabled_set(IRQ_DISABLE_MASK);
+	irq_soft_mask_set(IRQ_SOFT_MASK_STD);
 	trace_hardirqs_off();
 
 	/*
@@ -297,7 +284,7 @@ notrace void arch_local_irq_restore(unsigned long mask)
 
 	/* We can soft-enable now */
 	trace_hardirqs_on();
-	soft_enabled_set(IRQ_DISABLE_MASK_NONE);
+	irq_soft_mask_set(IRQ_SOFT_MASK_NONE);
 
 	/*
 	 * And replay if we have to. This will return with interrupts
@@ -372,7 +359,7 @@ bool prep_irq_for_idle(void)
 	 * of entering the low power state.
 	 */
 	local_paca->irq_happened &= ~PACA_IRQ_HARD_DIS;
-	soft_enabled_set(IRQ_DISABLE_MASK_NONE);
+	irq_soft_mask_set(IRQ_SOFT_MASK_NONE);
 
 	/* Tell the caller to enter the low power state */
 	return true;
diff --git a/arch/powerpc/kernel/optprobes_head.S b/arch/powerpc/kernel/optprobes_head.S
index 52fc864cdec4..98a3aeeb3c8c 100644
--- a/arch/powerpc/kernel/optprobes_head.S
+++ b/arch/powerpc/kernel/optprobes_head.S
@@ -58,7 +58,7 @@ optprobe_template_entry:
 	std	r5,_XER(r1)
 	mfcr	r5
 	std	r5,_CCR(r1)
-	lbz     r5,PACASOFTIRQEN(r13)
+	lbz     r5,PACAIRQSOFTMASK(r13)
 	std     r5,SOFTE(r1)
 
 	/*
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 30fe22639dd9..2a63cc78257d 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1675,7 +1675,7 @@ int copy_thread(unsigned long clone_flags, unsigned long usp,
 			childregs->gpr[14] = ppc_function_entry((void *)usp);
 #ifdef CONFIG_PPC64
 		clear_tsk_thread_flag(p, TIF_32BIT);
-		childregs->softe = IRQ_DISABLE_MASK_NONE;
+		childregs->softe = IRQ_SOFT_MASK_NONE;
 #endif
 		childregs->gpr[15] = kthread_arg;
 		p->thread.regs = NULL;	/* no user register state */
diff --git a/arch/powerpc/kernel/ptrace.c b/arch/powerpc/kernel/ptrace.c
index bd2c49475473..aef08e579946 100644
--- a/arch/powerpc/kernel/ptrace.c
+++ b/arch/powerpc/kernel/ptrace.c
@@ -285,7 +285,7 @@ int ptrace_get_reg(struct task_struct *task, int regno, unsigned long *data)
 
 #ifdef CONFIG_PPC64
 	/*
-	 * softe copies paca->soft_enabled variable state. Since soft_enabled is
+	 * softe copies paca->irq_soft_mask variable state. Since irq_soft_mask is
 	 * no more used as a flag, lets force usr to alway see the softe value as 1
 	 * which means interrupts are not soft disabled.
 	 */
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 0931f626fdc4..a4408a7e6f14 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -191,7 +191,7 @@ static void __init fixup_boot_paca(void)
 	/* Allow percpu accesses to work until we setup percpu data */
 	get_paca()->data_offset = 0;
 	/* Mark interrupts disabled in PACA */
-	soft_enabled_set(IRQ_DISABLE_MASK);
+	irq_soft_mask_set(IRQ_SOFT_MASK_STD);
 }
 
 static void __init configure_exceptions(void)
@@ -354,7 +354,7 @@ void __init early_setup(unsigned long dt_ptr)
 void early_setup_secondary(void)
 {
 	/* Mark interrupts disabled in PACA */
-	soft_enabled_set(IRQ_DISABLE_MASK);
+	irq_soft_mask_set(IRQ_SOFT_MASK_STD);
 
 	/* Initialize the hash table or TLB handling */
 	early_init_mmu_secondary();
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index e0d83df2b5e1..80a5594d5953 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -244,7 +244,7 @@ static u64 scan_dispatch_log(u64 stop_tb)
 void accumulate_stolen_time(void)
 {
 	u64 sst, ust;
-	unsigned long save_soft_enabled = soft_enabled_return();
+	unsigned long save_irq_soft_mask = irq_soft_mask_return();
 	struct cpu_accounting_data *acct = &local_paca->accounting;
 
 	/* We are called early in the exception entry, before
@@ -253,7 +253,7 @@ void accumulate_stolen_time(void)
 	 * needs to reflect that so various debug stuff doesn't
 	 * complain
 	 */
-	soft_enabled_set(IRQ_DISABLE_MASK);
+	irq_soft_mask_set(IRQ_SOFT_MASK_STD);
 
 	sst = scan_dispatch_log(acct->starttime_user);
 	ust = scan_dispatch_log(acct->starttime);
@@ -261,7 +261,7 @@ void accumulate_stolen_time(void)
 	acct->utime -= ust;
 	acct->steal_time += ust + sst;
 
-	soft_enabled_set(save_soft_enabled);
+	irq_soft_mask_set(save_irq_soft_mask);
 }
 
 static inline u64 calculate_stolen_time(u64 stop_tb)
diff --git a/arch/powerpc/kvm/book3s_hv_rmhandlers.S b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
index 2659844784b8..a92ad8500917 100644
--- a/arch/powerpc/kvm/book3s_hv_rmhandlers.S
+++ b/arch/powerpc/kvm/book3s_hv_rmhandlers.S
@@ -3249,7 +3249,7 @@ kvmppc_bad_host_intr:
 	mfctr	r4
 #endif
 	mfxer	r5
-	lbz	r6, PACASOFTIRQEN(r13)
+	lbz	r6, PACAIRQSOFTMASK(r13)
 	std	r3, _LINK(r1)
 	std	r4, _CTR(r1)
 	std	r5, _XER(r1)
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index f445e6037687..4bae16244138 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -752,7 +752,7 @@ void flush_dcache_icache_hugepage(struct page *page)
  * So long as we atomically load page table pointers we are safe against teardown,
  * we can follow the address down to the the page and take a ref on it.
  * This function need to be called with interrupts disabled. We use this variant
- * when we have MSR[EE] = 0 but the paca->soft_enabled = IRQ_DISABLE_MASK_NONE
+ * when we have MSR[EE] = 0 but the paca->irq_soft_mask = IRQ_SOFT_MASK_NONE
  */
 pte_t *__find_linux_pte(pgd_t *pgdir, unsigned long ea,
 			bool *is_thp, unsigned *hpage_shift)
diff --git a/arch/powerpc/perf/core-book3s.c b/arch/powerpc/perf/core-book3s.c
index 9f0dbbc50d5e..67153fa4cbd5 100644
--- a/arch/powerpc/perf/core-book3s.c
+++ b/arch/powerpc/perf/core-book3s.c
@@ -322,7 +322,7 @@ static inline void perf_read_regs(struct pt_regs *regs)
  */
 static inline int perf_intr_is_nmi(struct pt_regs *regs)
 {
-	return (regs->softe & IRQ_DISABLE_MASK);
+	return (regs->softe & IRQ_SOFT_MASK_STD);
 }
 
 /*
diff --git a/arch/powerpc/xmon/xmon.c b/arch/powerpc/xmon/xmon.c
index cab24f549e7c..a53454f61d09 100644
--- a/arch/powerpc/xmon/xmon.c
+++ b/arch/powerpc/xmon/xmon.c
@@ -1623,7 +1623,7 @@ static void excprint(struct pt_regs *fp)
 	printf("  current = 0x%lx\n", current);
 #ifdef CONFIG_PPC64
 	printf("  paca    = 0x%lx\t softe: %d\t irq_happened: 0x%02x\n",
-	       local_paca, local_paca->soft_enabled, local_paca->irq_happened);
+	       local_paca, local_paca->irq_soft_mask, local_paca->irq_happened);
 #endif
 	if (current) {
 		printf("    pid   = %ld, comm = %s\n",
@@ -2391,7 +2391,7 @@ static void dump_one_paca(int cpu)
 	DUMP(p, stab_rr, "lx");
 	DUMP(p, saved_r1, "lx");
 	DUMP(p, trap_save, "x");
-	DUMP(p, soft_enabled, "x");
+	DUMP(p, irq_soft_mask, "x");
 	DUMP(p, irq_happened, "x");
 	DUMP(p, io_sync, "x");
 	DUMP(p, irq_work_pending, "x");
-- 
2.7.4
