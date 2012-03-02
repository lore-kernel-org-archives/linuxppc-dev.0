Return-Path: <benh@kernel.crashing.org>
Received: from e23smtp01.au.ibm.com (e23smtp01.au.ibm.com [202.81.31.143])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp01.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9BC5E1007D6
 for <linuxppc-dev@ozlabs.org>; Fri,  2 Mar 2012 20:36:17 +1100 (EST)
Received: from /spool/local
 by e23smtp01.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <benh@kernel.crashing.org>;
 Fri, 2 Mar 2012 09:29:41 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 q229UYws3576010
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Mar 2012 20:30:37 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 q229a4Lf005254
 for <linuxppc-dev@ozlabs.org>; Fri, 2 Mar 2012 20:36:04 +1100
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 03/12] powerpc: Rework runlatch code
Date: Fri,  2 Mar 2012 20:35:13 +1100
Message-Id: <1330680922-6894-4-git-send-email-benh@kernel.crashing.org>
In-Reply-To: <1330680922-6894-1-git-send-email-benh@kernel.crashing.org>
References: <1330680922-6894-1-git-send-email-benh@kernel.crashing.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This moves the inlines into system.h and changes the runlatch
code to use the thread local flags (non-atomic) rather than
the TIF flags (atomic) to keep track of the latch state.

The code to turn it back on in an asynchronous interrupt is
now simplified and partially inlined.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---
 arch/powerpc/include/asm/exception-64s.h |   50 ++++++++++++++++--------------
 arch/powerpc/include/asm/reg.h           |   22 +------------
 arch/powerpc/include/asm/system.h        |   38 ++++++++++++++++++++++
 arch/powerpc/include/asm/thread_info.h   |    9 +++++-
 arch/powerpc/kernel/exceptions-64s.S     |    3 ++
 arch/powerpc/kernel/process.c            |   24 ++++++--------
 6 files changed, 89 insertions(+), 57 deletions(-)

diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
index 041b222..bdc9eeb 100644
--- a/arch/powerpc/include/asm/exception-64s.h
+++ b/arch/powerpc/include/asm/exception-64s.h
@@ -284,35 +284,39 @@ label##_hv:								\
 	rlwimi	r11,r12,0,MSR_EE;		\
 	mtmsrd	r11,1
 
-#define STD_EXCEPTION_COMMON(trap, label, hdlr)		\
-	.align	7;					\
-	.globl label##_common;				\
-label##_common:						\
-	EXCEPTION_PROLOG_COMMON(trap, PACA_EXGEN);	\
-	DISABLE_INTS;					\
-	bl	.save_nvgprs;				\
-	addi	r3,r1,STACK_FRAME_OVERHEAD;		\
-	bl	hdlr;					\
-	b	.ret_from_except
+#define ADD_NVGPRS				\
+	bl	.save_nvgprs
+
+#define RUNLATCH_ON				\
+BEGIN_FTR_SECTION				\
+	clrrdi	r3,r1,THREAD_SHIFT;		\
+	ld	r4,TI_LOCAL_FLAGS(r3);		\
+	andi.	r0,r4,_TLF_RUNLATCH;		\
+	beql	ppc64_runlatch_on_trampoline;	\
+END_FTR_SECTION_IFSET(CPU_FTR_CTRL)
+
+#define EXCEPTION_COMMON(trap, label, hdlr, ret, additions)	\
+	.align	7;						\
+	.globl label##_common;					\
+label##_common:							\
+	EXCEPTION_PROLOG_COMMON(trap, PACA_EXGEN);		\
+	additions;						\
+	addi	r3,r1,STACK_FRAME_OVERHEAD;			\
+	bl	hdlr;						\
+	b	ret
+
+#define STD_EXCEPTION_COMMON(trap, label, hdlr)			\
+	EXCEPTION_COMMON(trap, label, hdlr, ret_from_except,	\
+			 ADD_NVGPRS;DISABLE_INTS)
 
 /*
  * Like STD_EXCEPTION_COMMON, but for exceptions that can occur
  * in the idle task and therefore need the special idle handling
  * (finish nap and runlatch)
  */
-#define STD_EXCEPTION_COMMON_ASYNC(trap, label, hdlr)	\
-	.align	7;					\
-	.globl label##_common;				\
-label##_common:						\
-	EXCEPTION_PROLOG_COMMON(trap, PACA_EXGEN);	\
-	FINISH_NAP;					\
-	DISABLE_INTS;					\
-BEGIN_FTR_SECTION					\
-	bl	.ppc64_runlatch_on;			\
-END_FTR_SECTION_IFSET(CPU_FTR_CTRL)			\
-	addi	r3,r1,STACK_FRAME_OVERHEAD;		\
-	bl	hdlr;					\
-	b	.ret_from_except_lite
+#define STD_EXCEPTION_COMMON_ASYNC(trap, label, hdlr)		  \
+	EXCEPTION_COMMON(trap, label, hdlr, ret_from_except_lite, \
+			 FINISH_NAP;RUNLATCH_ON;DISABLE_INTS)
 
 /*
  * When the idle code in power4_idle puts the CPU into NAP mode,
diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index 7fdc2c0..b1a215e 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -1079,30 +1079,12 @@
 
 #define proc_trap()	asm volatile("trap")
 
-#ifdef CONFIG_PPC64
-
-extern void ppc64_runlatch_on(void);
-extern void __ppc64_runlatch_off(void);
-
-#define ppc64_runlatch_off()					\
-	do {							\
-		if (cpu_has_feature(CPU_FTR_CTRL) &&		\
-		    test_thread_flag(TIF_RUNLATCH))		\
-			__ppc64_runlatch_off();			\
-	} while (0)
+#define __get_SP()	({unsigned long sp; \
+			asm volatile("mr %0,1": "=r" (sp)); sp;})
 
 extern unsigned long scom970_read(unsigned int address);
 extern void scom970_write(unsigned int address, unsigned long value);
 
-#else
-#define ppc64_runlatch_on()
-#define ppc64_runlatch_off()
-
-#endif /* CONFIG_PPC64 */
-
-#define __get_SP()	({unsigned long sp; \
-			asm volatile("mr %0,1": "=r" (sp)); sp;})
-
 struct pt_regs;
 
 extern void ppc_save_regs(struct pt_regs *regs);
diff --git a/arch/powerpc/include/asm/system.h b/arch/powerpc/include/asm/system.h
index c377457..a02883d 100644
--- a/arch/powerpc/include/asm/system.h
+++ b/arch/powerpc/include/asm/system.h
@@ -550,5 +550,43 @@ extern void reloc_got2(unsigned long);
 
 extern struct dentry *powerpc_debugfs_root;
 
+#ifdef CONFIG_PPC64
+
+extern void __ppc64_runlatch_on(void);
+extern void __ppc64_runlatch_off(void);
+
+/*
+ * We manually hard enable-disable, this is called
+ * in the idle loop and we don't want to mess up
+ * with soft-disable/enable & interrupt replay.
+ */
+#define ppc64_runlatch_off()					\
+	do {							\
+		if (cpu_has_feature(CPU_FTR_CTRL) &&		\
+		    test_thread_local_flags(_TLF_RUNLATCH)) {	\
+			unsigned long msr = mfmsr();		\
+			__hard_irq_disable();			\
+			__ppc64_runlatch_off();			\
+			if (msr & MSR_EE)			\
+				__hard_irq_enable();		\
+		}      						\
+	} while (0)
+
+#define ppc64_runlatch_on()					\
+	do {							\
+		if (cpu_has_feature(CPU_FTR_CTRL) &&		\
+		    !test_thread_local_flags(_TLF_RUNLATCH)) {	\
+			unsigned long msr = mfmsr();		\
+			__hard_irq_disable();			\
+			__ppc64_runlatch_on();			\
+			if (msr & MSR_EE)			\
+				__hard_irq_enable();		\
+		}      						\
+	} while (0)
+#else
+#define ppc64_runlatch_on()
+#define ppc64_runlatch_off()
+#endif /* CONFIG_PPC64 */
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_SYSTEM_H */
diff --git a/arch/powerpc/include/asm/thread_info.h b/arch/powerpc/include/asm/thread_info.h
index 96471494..4a741c7 100644
--- a/arch/powerpc/include/asm/thread_info.h
+++ b/arch/powerpc/include/asm/thread_info.h
@@ -110,7 +110,6 @@ static inline struct thread_info *current_thread_info(void)
 #define TIF_NOERROR		12	/* Force successful syscall return */
 #define TIF_NOTIFY_RESUME	13	/* callback before returning to user */
 #define TIF_SYSCALL_TRACEPOINT	15	/* syscall tracepoint instrumentation */
-#define TIF_RUNLATCH		16	/* Is the runlatch enabled? */
 
 /* as above, but as bit values */
 #define _TIF_SYSCALL_TRACE	(1<<TIF_SYSCALL_TRACE)
@@ -141,11 +140,13 @@ static inline struct thread_info *current_thread_info(void)
 #define TLF_SLEEPING		1	/* suspend code enabled SLEEP mode */
 #define TLF_RESTORE_SIGMASK	2	/* Restore signal mask in do_signal */
 #define TLF_LAZY_MMU		3	/* tlb_batch is active */
+#define TLF_RUNLATCH		4	/* Is the runlatch enabled? */
 
 #define _TLF_NAPPING		(1 << TLF_NAPPING)
 #define _TLF_SLEEPING		(1 << TLF_SLEEPING)
 #define _TLF_RESTORE_SIGMASK	(1 << TLF_RESTORE_SIGMASK)
 #define _TLF_LAZY_MMU		(1 << TLF_LAZY_MMU)
+#define _TLF_RUNLATCH		(1 << TLF_RUNLATCH)
 
 #ifndef __ASSEMBLY__
 #define HAVE_SET_RESTORE_SIGMASK	1
@@ -156,6 +157,12 @@ static inline void set_restore_sigmask(void)
 	set_bit(TIF_SIGPENDING, &ti->flags);
 }
 
+static inline bool test_thread_local_flags(unsigned int flags)
+{
+	struct thread_info *ti = current_thread_info();
+	return (ti->local_flags & flags) != 0;
+}
+
 #ifdef CONFIG_PPC64
 #define is_32bit_task()	(test_thread_flag(TIF_32BIT))
 #else
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index 2240d4e..3af80e8 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -483,6 +483,9 @@ machine_check_common:
 system_call_entry:
 	b	system_call_common
 
+ppc64_runlatch_on_trampoline:
+	b	.__ppc64_runlatch_on
+
 /*
  * Here we have detected that the kernel stack pointer is bad.
  * R9 contains the saved CR, r13 points to the paca,
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index d817ab0..bf80a1d 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -1220,34 +1220,32 @@ void dump_stack(void)
 EXPORT_SYMBOL(dump_stack);
 
 #ifdef CONFIG_PPC64
-void ppc64_runlatch_on(void)
+/* Called with hard IRQs off */
+void __ppc64_runlatch_on(void)
 {
+	struct thread_info *ti = current_thread_info();
 	unsigned long ctrl;
 
-	if (cpu_has_feature(CPU_FTR_CTRL) && !test_thread_flag(TIF_RUNLATCH)) {
-		HMT_medium();
-
-		ctrl = mfspr(SPRN_CTRLF);
-		ctrl |= CTRL_RUNLATCH;
-		mtspr(SPRN_CTRLT, ctrl);
+	ctrl = mfspr(SPRN_CTRLF);
+	ctrl |= CTRL_RUNLATCH;
+	mtspr(SPRN_CTRLT, ctrl);
 
-		set_thread_flag(TIF_RUNLATCH);
-	}
+	ti->local_flags |= TLF_RUNLATCH;
 }
 
+/* Called with hard IRQs off */
 void __ppc64_runlatch_off(void)
 {
+	struct thread_info *ti = current_thread_info();
 	unsigned long ctrl;
 
-	HMT_medium();
-
-	clear_thread_flag(TIF_RUNLATCH);
+	ti->local_flags &= ~TLF_RUNLATCH;
 
 	ctrl = mfspr(SPRN_CTRLF);
 	ctrl &= ~CTRL_RUNLATCH;
 	mtspr(SPRN_CTRLT, ctrl);
 }
-#endif
+#endif /* CONFIG_PPC64 */
 
 #if THREAD_SHIFT < PAGE_SHIFT
 
-- 
1.7.9
