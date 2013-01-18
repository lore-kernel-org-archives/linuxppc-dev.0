Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 12/17] powerpc: Hook in new transactional memory code
Date: Fri, 18 Jan 2013 16:48:32 +1100
Message-Id: <1358488117-17363-13-git-send-email-mikey@neuling.org>
In-Reply-To: <1358488117-17363-1-git-send-email-mikey@neuling.org>
References: <1358488117-17363-1-git-send-email-mikey@neuling.org>
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
 arch/powerpc/kernel/exceptions-64s.S |   48 ++++++++++++++++++++++++++++++++--
 arch/powerpc/kernel/fpu.S            |    1 -
 arch/powerpc/kernel/process.c        |   15 +++++++++--
 arch/powerpc/kernel/traps.c          |   32 +++++++++++++++++++++++
 arch/powerpc/kernel/vector.S         |    1 -
 arch/powerpc/mm/hash_utils_64.c      |   13 +++++++++
 6 files changed, 104 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
index d0cc657..c4a20d1 100644
--- a/arch/powerpc/kernel/exceptions-64s.S
+++ b/arch/powerpc/kernel/exceptions-64s.S
@@ -1147,9 +1147,24 @@ fp_unavailable_common:
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
@@ -1157,8 +1172,23 @@ altivec_unavailable_common:
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
@@ -1175,7 +1205,21 @@ vsx_unavailable_common:
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
index 14fabd1..bccc81b 100644
--- a/arch/powerpc/kernel/process.c
+++ b/arch/powerpc/kernel/process.c
@@ -510,7 +510,7 @@ out_and_saveregs:
 	tm_save_sprs(thr);
 }
 
-static inline void __maybe_unused tm_recheckpoint_new_task(struct task_struct *new)
+static inline void tm_recheckpoint_new_task(struct task_struct *new)
 {
 	unsigned long msr;
 
@@ -585,6 +585,8 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	struct ppc64_tlb_batch *batch;
 #endif
 
+	__switch_to_tm(prev);
+
 #ifdef CONFIG_SMP
 	/* avoid complexity of lazy save/restore of fpu
 	 * by just saving it every time we switch out if
@@ -700,6 +702,9 @@ struct task_struct *__switch_to(struct task_struct *prev,
 	 * of sync. Hard disable here.
 	 */
 	hard_irq_disable();
+
+	tm_recheckpoint_new_task(new);
+
 	last = _switch(old_thread, new_thread);
 
 #ifdef CONFIG_PPC_BOOK3S_64
@@ -1075,7 +1080,6 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
 		regs->msr = MSR_USER32;
 	}
 #endif
-
 	discard_lazy_cpu_state();
 #ifdef CONFIG_VSX
 	current->thread.used_vsr = 0;
@@ -1095,6 +1099,13 @@ void start_thread(struct pt_regs *regs, unsigned long start, unsigned long sp)
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
index 311770d..486712b 100644
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
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 3a292be..03a4c4a 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -55,6 +55,7 @@
 #include <asm/code-patching.h>
 #include <asm/fadump.h>
 #include <asm/firmware.h>
+#include <asm/tm.h>
 
 #ifdef DEBUG
 #define DBG(fmt...) udbg_printf(fmt)
@@ -1171,6 +1172,18 @@ void flush_hash_page(unsigned long vpn, real_pte_t pte, int psize, int ssize,
 		DBG_LOW(" sub %ld: hash=%lx, hidx=%lx\n", index, slot, hidx);
 		ppc_md.hpte_invalidate(slot, vpn, psize, ssize, local);
 	} pte_iterate_hashed_end();
+
+#ifdef CONFIG_TRANSACTIONAL_MEM
+	/* Transactions are not aborted by tlbiel, only tlbie.
+	 * Without, syncing a page back to a block device w/ PIO could pick up
+	 * transactional data (bad!) so we force an abort here.  Before the
+	 * sync the page will be made read-only, which will flush_hash_page.
+	 */
+	if (local && cpu_has_feature(CPU_FTR_TM)) {
+		tm_enable();
+		tm_abort(TM_CAUSE_TLBI);
+	}
+#endif
 }
 
 void flush_hash_range(unsigned long number, int local)
-- 
1.7.10.4
