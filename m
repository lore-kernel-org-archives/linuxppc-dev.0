Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 12/16] powerpc: Hook in new transactional memory code
Date: Tue, 27 Nov 2012 13:48:04 +1100
Message-Id: <1353984488-1283-13-git-send-email-mikey@neuling.org>
In-Reply-To: <1353984488-1283-1-git-send-email-mikey@neuling.org>
References: <1353984488-1283-1-git-send-email-mikey@neuling.org>
Cc: Michael Neuling <mikey@neuling.org>, linuxppc-dev@lists.ozlabs.org,
 Matt Evans <matt@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This hooks the new transactional memory code into context switching, FP/VMX/VMX
unavailable and exception return.

Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/kernel/entry_64.S       |   22 ++++++++++++++++
 arch/powerpc/kernel/exceptions-64s.S |   48 ++++++++++++++++++++++++++++++++--
 arch/powerpc/kernel/fpu.S            |    1 -
 arch/powerpc/kernel/process.c        |   15 +++++++++--
 arch/powerpc/kernel/traps.c          |   32 +++++++++++++++++++++++
 arch/powerpc/kernel/vector.S         |    1 -
 6 files changed, 113 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/entry_64.S b/arch/powerpc/kernel/entry_64.S
index 5ae8e51..b3590c3 100644
--- a/arch/powerpc/kernel/entry_64.S
+++ b/arch/powerpc/kernel/entry_64.S
@@ -602,7 +602,29 @@ _GLOBAL(ret_from_except_lite)
 	beq	1f
 	bl	.restore_interrupts
 	bl	.schedule
+#ifdef CONFIG_TRANSACTIONAL_MEM
+BEGIN_FTR_SECTION
+	/* If TIF_RESTOREALL was set by switch_to, we MUST clear it before
+	 * any return to userspace -- no one else is going to.  TRAP.0 has been
+	 * cleared to flag full regs to ret_from_except.
+	 * Try to avoid the slow atomic clear if the flag isn't set.
+	 * (This is OK as no one else will be clearing this flag.)
+         */
+	clrrdi	r9,r1,THREAD_SHIFT	/* current_thread_info() */
+	li	r4,_TIF_RESTOREALL
+	addi	r9, r9, TI_FLAGS
+	ld	r3, 0(r9)		/* Test TIF_RESTOREALL first! */
+	and.	r0, r3, r4
+	beq	.ret_from_except
+3:	ldarx	r10, 0, r9		/* If set, clear. */
+	andc	r10, r10, r4
+	stdcx.	r10, 0, r9
+	bne	3b
+	b	.ret_from_except	/* Not _lite; we may have full regs! */
+END_FTR_SECTION_IFSET(CPU_FTR_TM)
+#else
 	b	.ret_from_except_lite
+#endif
 
 1:	bl	.save_nvgprs
 	bl	.restore_interrupts
diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d97cea4..220b896 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1144,9 +1144,24 @@ fp_unavailable_common:
 	addi	r3,r1,STACK_FRAME_OVERHEAD
 	bl	.kernel_fp_unavailable_exception
 	BUG_OPCODE
-1:	bl	.load_up_fpu
+1:
+#ifdef CONFIG_TRANSACTIONAL_MEM
+BEGIN_FTR_SECTION
+	srdi	r0, r12, MSR_TS_LG
+	andi.	r0, r0, 3
+	bne-	2f
+END_FTR_SECTION_IFSET(CPU_FTR_TM)
+#endif
+	bl	.load_up_fpu
+	std     r12,_MSR(r1)
 	b	fast_exception_return
-
+#ifdef CONFIG_TRANSACTIONAL_MEM
+2:	/* User process was in a transaction */
+	bl	.save_nvgprs
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.fp_unavailable_tm
+	b	.ret_from_except
+#endif
 	.align	7
 	.globl altivec_unavailable_common
 altivec_unavailable_common:
@@ -1154,8 +1169,23 @@ altivec_unavailable_common:
 #ifdef CONFIG_ALTIVEC
 BEGIN_FTR_SECTION
 	beq	1f
+#ifdef CONFIG_TRANSACTIONAL_MEM
+  BEGIN_FTR_SECTION_NESTED(69)
+	srdi	r0, r12, MSR_TS_LG
+	andi.	r0, r0, 3
+	bne-	2f
+  END_FTR_SECTION_NESTED(CPU_FTR_TM, CPU_FTR_TM, 69)
+#endif
 	bl	.load_up_altivec
+	std	r12,_MSR(r1)
 	b	fast_exception_return
+#ifdef CONFIG_TRANSACTIONAL_MEM
+2:	/* User process was in a transaction */
+	bl	.save_nvgprs
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.altivec_unavailable_tm
+	b	.ret_from_except
+#endif
 1:
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
 #endif
@@ -1172,7 +1202,21 @@ vsx_unavailable_common:
 #ifdef CONFIG_VSX
 BEGIN_FTR_SECTION
 	beq	1f
+#ifdef CONFIG_TRANSACTIONAL_MEM
+  BEGIN_FTR_SECTION_NESTED(69)
+	srdi	r0, r12, MSR_TS_LG
+	andi.	r0, r0, 3
+	bne-	2f
+  END_FTR_SECTION_NESTED(CPU_FTR_TM, CPU_FTR_TM, 69)
+#endif
 	b	.load_up_vsx
+#ifdef CONFIG_TRANSACTIONAL_MEM
+2:	/* User process was in a transaction */
+	bl	.save_nvgprs
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	bl	.vsx_unavailable_tm
+	b	.ret_from_except
+#endif
 1:
 END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 #endif
diff --git a/arch/powerpc/kernel/fpu.S b/arch/powerpc/kernel/fpu.S
index 6ab0e87..08b6a12f 100644
--- a/arch/powerpc/kernel/fpu.S
+++ b/arch/powerpc/kernel/fpu.S
@@ -170,7 +170,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_VSX)
 	lwz	r4,THREAD_FPEXC_MODE(r5)
 	ori	r12,r12,MSR_FP
 	or	r12,r12,r4
-	std	r12,_MSR(r1)
 #endif
 	lfd	fr0,THREAD_FPSCR(r5)
 	MTFSF_L(fr0)
diff --git a/arch/powerpc/kernel/process.c b/arch/powerpc/kernel/process.c
index 1bf2c6c7..a0bfd97 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -455,7 +455,7 @@ out_and_saveregs:
 	tm_save_sprs(thr);
 }
 
-static inline void __maybe_unused tm_recheckpoint_new_task(struct task_struct *new)
+static inline void tm_recheckpoint_new_task(struct task_struct *new)
 {
 	unsigned long msr;
 
@@ -530,6 +530,8 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	struct ppc64_tlb_batch *batch;
 #endif
 
+	__switch_to_tm(prev);
+
 #ifdef CONFIG_SMP
 	/* avoid complexity of lazy save/restore of fpu
 	 * by just saving it every time we switch out if
@@ -645,6 +647,9 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	 * of sync. Hard disable here.
 	 */
 	hard_irq_disable();
+
+	tm_recheckpoint_new_task(new);
+
 	last = _switch(old_thread, new_thread);
 
 #ifdef CONFIG_PPC_BOOK3S_64
@@ -1019,7 +1024,6 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 		regs->msr = MSR_USER32;
 	}
 #endif
-
 	discard_lazy_cpu_state();
 #ifdef CONFIG_VSX
 	current->thread.used_vsr = 0;
@@ -1039,6 +1043,13 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 	current->thread.spefscr = 0;
 	current->thread.used_spe = 0;
 #endif /* CONFIG_SPE */
+#ifdef CONFIG_TRANSACTIONAL_MEM
+	if (cpu_has_feature(CPU_FTR_TM))
+		regs->msr |= MSR_TM;
+	current->thread.tm_tfhar = 0;
+	current->thread.tm_texasr = 0;
+	current->thread.tm_tfiar = 0;
+#endif /* CONFIG_TRANSACTIONAL_MEM */
 }
 
 #define PR_FP_ALL_EXCEPT (PR_FP_EXC_DIV | PR_FP_EXC_OVF | PR_FP_EXC_UND \
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 7b9f160..cb04fc7 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -1032,6 +1032,38 @@ void __kprobes program_check_exception(struct pt_regs *regs)
 		_exception(SIGTRAP, regs, TRAP_BRKPT, regs->nip);
 		return;
 	}
+#ifdef CONFIG_TRANSACTIONAL_MEM
+	if (reason & REASON_TM) {
+		/* This is a TM "Bad Thing Exception" program check.
+		 * This occurs when:
+		 * -  An rfid/hrfid/mtmsrd attempts to cause an illegal
+		 *    transition in TM states.
+		 * -  A trechkpt is attempted when transactional.
+		 * -  A treclaim is attempted when non transactional.
+		 * -  A tend is illegally attempted.
+		 * -  writing a TM SPR when transactional.
+		 */
+		if (!user_mode(regs) &&
+		    report_bug(regs->nip, regs) == BUG_TRAP_TYPE_WARN) {
+			regs->nip += 4;
+			return;
+		}
+		/* If usermode caused this, it's done something illegal and
+		 * gets a SIGILL slap on the wrist.  We call it an illegal
+		 * operand to distinguish from the instruction just being bad
+		 * (e.g. executing a 'tend' on a CPU without TM!); it's an
+		 * illegal /placement/ of a valid instruction.
+		 */
+		if (user_mode(regs)) {
+			_exception(SIGILL, regs, ILL_ILLOPN, regs->nip);
+			return;
+		} else {
+			printk(KERN_EMERG "Unexpected TM Bad Thing exception "
+			       "at %lx (msr 0x%x)\n", regs->nip, reason);
+			die("Unrecoverable exception", regs, SIGABRT);
+		}
+	}
+#endif
 
 	/* We restore the interrupt state now */
 	if (!arch_irq_disabled_regs(regs))
diff --git a/arch/powerpc/kernel/vector.S b/arch/powerpc/kernel/vector.S
index 330fc8c..9b47306 100644
--- a/arch/powerpc/kernel/vector.S
+++ b/arch/powerpc/kernel/vector.S
@@ -123,7 +123,6 @@ _GLOBAL(load_up_altivec)
 	ld	r4,PACACURRENT(r13)
 	addi	r5,r4,THREAD		/* Get THREAD */
 	oris	r12,r12,MSR_VEC@h
-	std	r12,_MSR(r1)
 #endif
 	li	r4,1
 	li	r10,THREAD_VSCR
-- 
1.7.9.5
