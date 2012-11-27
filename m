Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH 07/16] powerpc: Add helper functions for transactional memory
 context switching
Date: Tue, 27 Nov 2012 13:47:59 +1100
Message-Id: <1353984488-1283-8-git-send-email-mikey@neuling.org>
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

Here we add the helper functions to be used when context switching.  These
allow us to fully reclaim and recheckpoint a transaction.

Signed-off-by: Matt Evans <matt@ozlabs.org>
Signed-off-by: Michael Neuling <mikey@neuling.org>
---
 arch/powerpc/include/asm/reg.h |    2 +-
 arch/powerpc/include/asm/tm.h  |   19 ++
 arch/powerpc/kernel/Makefile   |    2 +
 arch/powerpc/kernel/tm.S       |  378 ++++++++++++++++++++++++++++++++++++++++
 4 files changed, 400 insertions(+), 1 deletion(-)
 create mode 100644 arch/powerpc/include/asm/tm.h
 create mode 100644 arch/powerpc/kernel/tm.S

diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
index bea823f..895020f 100644
--- a/arch/powerpc/include/asm/reg.h
+++ b/arch/powerpc/include/asm/reg.h
@@ -784,7 +784,7 @@
  *        HV mode in which case it is HSPRG0
  *
  * 64-bit server:
- *	- SPRG0 unused (reserved for HV on Power4)
+ *	- SPRG0 scratch for TM recheckpoint/reclaim (reserved for HV on Power4)
  *	- SPRG2 scratch for exception vectors
  *	- SPRG3 CPU and NUMA node for VDSO getcpu (user visible)
  *      - HSPRG0 stores PACA in HV mode
diff --git a/arch/powerpc/include/asm/tm.h b/arch/powerpc/include/asm/tm.h
new file mode 100644
index 0000000..18f6bf7
--- /dev/null
+++ b/arch/powerpc/include/asm/tm.h
@@ -0,0 +1,19 @@
+/*
+ * Transactional memory support routines to reclaim and recheckpoint
+ * transactional process state.
+ *
+ * Copyright 2012 Matt Evans & Michael Neuling, IBM Corporation.
+ */
+
+#ifdef CONFIG_TRANSACTIONAL_MEM
+extern void do_load_up_transact_fpu(struct thread_struct *thread);
+extern void do_load_up_transact_altivec(struct thread_struct *thread);
+#endif
+
+extern void tm_enable(void);
+extern void tm_reclaim(struct thread_struct *thread,
+		       unsigned long orig_msr, uint8_t cause);
+extern void tm_recheckpoint(struct thread_struct *thread,
+			    unsigned long orig_msr);
+extern void tm_save_sprs(struct thread_struct *thread);
+extern void tm_restore_sprs(struct thread_struct *thread);
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 44fbbea..abf8469 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -122,6 +122,8 @@ ifneq ($(CONFIG_PPC_INDIRECT_IO),y)
 obj-y				+= iomap.o
 endif
 
+obj64-$(CONFIG_TRANSACTIONAL_MEM)	+= tm.o
+
 obj-$(CONFIG_PPC64)		+= $(obj64-y)
 obj-$(CONFIG_PPC32)		+= $(obj32-y)
 
diff --git a/arch/powerpc/kernel/tm.S b/arch/powerpc/kernel/tm.S
new file mode 100644
index 0000000..b368e4a
--- /dev/null
+++ b/arch/powerpc/kernel/tm.S
@@ -0,0 +1,378 @@
+/*
+ * Transactional memory support routines to reclaim and recheckpoint
+ * transactional process state.
+ *
+ * Copyright 2012 Matt Evans & Michael Neuling, IBM Corporation.
+ */
+
+#include <asm/asm-offsets.h>
+#include <asm/ppc_asm.h>
+#include <asm/ppc-opcode.h>
+#include <asm/ptrace.h>
+#include <asm/reg.h>
+
+#ifdef CONFIG_VSX
+/* See fpu.S, this is very similar but to save/restore checkpointed FPRs/VSRs */
+#define __SAVE_32FPRS_VSRS_TRANSACT(n,c,base)	\
+BEGIN_FTR_SECTION				\
+	b	2f;				\
+END_FTR_SECTION_IFSET(CPU_FTR_VSX);		\
+	SAVE_32FPRS_TRANSACT(n,base);		\
+	b	3f;				\
+2:	SAVE_32VSRS_TRANSACT(n,c,base);		\
+3:
+/* ...and this is just plain borrowed from there. */
+#define __REST_32FPRS_VSRS(n,c,base)		\
+BEGIN_FTR_SECTION				\
+	b	2f;				\
+END_FTR_SECTION_IFSET(CPU_FTR_VSX);		\
+	REST_32FPRS(n,base);			\
+	b	3f;				\
+2:	REST_32VSRS(n,c,base);			\
+3:
+#else
+#define __SAVE_32FPRS_VSRS_TRANSACT(n,c,base) SAVE_32FPRS_TRANSACT(n, base)
+#define __REST_32FPRS_VSRS(n,c,base)	      REST_32FPRS(n, base)
+#endif
+#define SAVE_32FPRS_VSRS_TRANSACT(n,c,base) \
+	__SAVE_32FPRS_VSRS_TRANSACT(n,__REG_##c,__REG_##base)
+#define REST_32FPRS_VSRS(n,c,base) \
+	__REST_32FPRS_VSRS(n,__REG_##c,__REG_##base)
+
+/* Stack frame offsets for local variables. */
+#define TM_FRAME_L0	TM_FRAME_SIZE-16
+#define TM_FRAME_L1	TM_FRAME_SIZE-8
+#define STACK_PARAM(x)	(48+((x)*8))
+
+
+/* In order to access the TM SPRs, TM must be enabled.  So, do so: */
+_GLOBAL(tm_enable)
+	mfmsr	r4
+	li	r3, MSR_TM >> 32
+	sldi	r3, r3, 32
+	and.	r0, r4, r3
+	bne	1f
+	or	r4, r4, r3
+	mtmsrd	r4
+1:	blr
+
+_GLOBAL(tm_save_sprs)
+	mfspr	r0, SPRN_TFHAR
+	std	r0, THREAD_TM_TFHAR(r3)
+	mfspr	r0, SPRN_TEXASR
+	std	r0, THREAD_TM_TEXASR(r3)
+	mfspr	r0, SPRN_TFIAR
+	std	r0, THREAD_TM_TFIAR(r3)
+	blr
+
+_GLOBAL(tm_restore_sprs)
+	ld	r0, THREAD_TM_TFHAR(r3)
+	mtspr	SPRN_TFHAR, r0
+	ld	r0, THREAD_TM_TEXASR(r3)
+	mtspr	SPRN_TEXASR, r0
+	ld	r0, THREAD_TM_TFIAR(r3)
+	mtspr	SPRN_TFIAR, r0
+	blr
+
+
+/* void tm_reclaim(struct thread_struct *thread,
+ *                 unsigned long orig_msr,
+ *		   uint8_t cause)
+ *
+ *	- Performs a full reclaim.  This destroys outstanding
+ *	  transactions and updates thread->regs.tm_ckpt_* with the
+ *	  original checkpointed state.  Note that thread->regs is
+ *	  unchanged.
+ *	- FP regs are written back to thread->transact_fpr before
+ *	  reclaiming.  These are the transactional (current) versions.
+ *
+ * Purpose is to both abort transactions of, and preserve the state of,
+ * a transactions at a context switch. We preserve/restore both sets of process
+ * state to restore them when the thread's scheduled again.  We continue in
+ * userland as though nothing happened, but when the transaction is resumed
+ * they will abort back to the checkpointed state we save out here.
+ */
+_GLOBAL(tm_reclaim)
+	mfcr	r6
+	mflr	r0
+	std	r6, 8(r1)
+	std	r0, 16(r1)
+	std	r2, 40(r1)
+	stdu	r1, -TM_FRAME_SIZE(r1)
+
+	/* We've a struct pt_regs at [r1+STACK_FRAME_OVERHEAD]. */
+
+	std	r3, STACK_PARAM(0)(r1)
+	SAVE_NVGPRS(r1)
+
+	/* hard_irq_disable */
+	mfmsr	r14
+	li	r6, MSR_EE-1
+	addi	r6, r6, 1			/* Get around sxt on 0x8000 */
+	andc	r15, r14, r6
+	ori	r15, r15, MSR_FP
+	oris	r15, r15, MSR_VEC@h
+#ifdef CONFIG_VSX
+	BEGIN_FTR_SECTION
+	oris	r15,r15, MSR_VSX@h
+	END_FTR_SECTION_IFSET(CPU_FTR_VSX)
+#endif
+	mtmsrd	r15
+	std	r14, TM_FRAME_L0(r1)
+
+	std	r1, PACAR1(r13)
+
+	/* ******************** FPR/VR/VSRs ************
+	 * Before reclaiming, capture the current/transactional FPR/VR
+	* versions /if used/.
+	 *
+	 * (If VSX used, FP and VMX are implied.  Or, we don't need to look
+	 * at MSR.VSX as copying FP regs if .FP, vector regs if .VMX covers it.)
+	 *
+	 * We're passed the thread's MSR as parameter 2.
+	 *
+	 * We enabled VEC/FP/VSX in the msr above, so we can execute these
+	 * instructions!
+	 */
+	andis.		r0, r4, MSR_VEC@h
+	beq	dont_backup_vec
+
+	SAVE_32VRS_TRANSACT(0, r6, r3)	/* r6 scratch, r3 thread */
+	mfvscr	vr0
+	li	r6, THREAD_TRANSACT_VSCR
+	stvx	vr0, r3, r6
+	mfspr	r0, SPRN_VRSAVE
+	std	r0, THREAD_TRANSACT_VRSAVE(r3)
+
+dont_backup_vec:
+	andi.	r0, r4, MSR_FP
+	beq	dont_backup_fp
+
+	SAVE_32FPRS_VSRS_TRANSACT(0, R6, R3)	/* r6 scratch, r3 thread */
+
+	mffs    fr0
+	stfd    fr0,THREAD_TRANSACT_FPSCR(r3)
+
+dont_backup_fp:
+	/* The moment we treclaim, ALL of our GPRs will switch
+	 * to user register state.  (FPRs, CCR etc. also!)
+	 * Use an sprg and a scratch dword in the PACA to shuffle.
+	 */
+	TRECLAIM(R5)				/* Cause in r5 */
+
+	/* ******************** GPRs ******************** */
+	SET_SCRATCH0(r13)
+	GET_PACA(r13)
+	std	r1, PACATMSCRATCH(r13)
+
+	ld	r1, PACAR1(r13)		/* Get our stack back */
+	/* Temporarily stash checkpointed r0 here to get another
+	 * scratch reg for our userland pt_regs pointer:
+	 */
+	std	r7, GPR7(r1)			/* Temporary stash */
+	std	r12, GPR12(r1)			/* ''   ''    ''   */
+	ld	r12, STACK_PARAM(0)(r1)		/* Param 0, thread_struct * */
+
+	addi	r7, r12, PT_CKPT_REGS		/* Thread's ckpt_regs */
+
+	/* Make r7 look like an exception frame so that we
+	 * can use the neat GPRx(n) macros.  r7 is NOT a pt_regs ptr!
+	 */
+	subi	r7, r7, STACK_FRAME_OVERHEAD
+
+	/* Sync the userland GPRs 2-12, 14-31 to thread->regs: */
+	SAVE_GPR(0, r7)				/* user r0 */
+	SAVE_GPR(2, r7)			/* user r2 */
+	SAVE_4GPRS(3, r7)			/* user r3-r6 */
+	SAVE_4GPRS(8, r7)			/* user r8-r11 */
+	ld	r3, PACATMSCRATCH(r13)		/* user r1 */
+	ld	r4, GPR7(r1)			/* user r7 */
+	ld	r5, GPR12(r1)			/* user r12 */
+	GET_SCRATCH0(6)				/* user r13 */
+	std	r3, GPR1(r7)
+	std	r4, GPR7(r7)
+	std	r5, GPR12(r7)
+	std	r6, GPR13(r7)
+
+	SAVE_NVGPRS(r7)				/* user r14-r31 */
+
+	/* ******************** NIP ******************** */
+	mfspr	r3, SPRN_TFHAR
+	std	r3, _NIP(r7)			/* Returns to failhandler */
+	/* The checkpointed NIP is ignored when rescheduling/rechkpting,
+	 * but is used in signal return to 'wind back' to the abort handler.
+	 */
+
+	/* ******************** CR,LR,CCR,MSR ********** */
+	mfctr	r3
+	mflr	r4
+	mfcr	r5
+	mfxer	r6
+
+	std	r3, _CTR(r7)
+	std	r4, _LINK(r7)
+	std	r5, _CCR(r7)
+	std	r6, _XER(r7)
+
+	/* MSR and flags:  We don't change CRs, and we don't need to alter
+	 * MSR.
+	 */
+
+	/* TM regs, incl TEXASR -- these live in thread_struct.  Note they've
+	 * been updated by the treclaim, to explain to userland the failure
+	 * cause (aborted).
+	 */
+	mfspr	r0, SPRN_TEXASR
+	mfspr	r3, SPRN_TFHAR
+	mfspr	r4, SPRN_TFIAR
+	std	r0, THREAD_TM_TEXASR(r12)
+	std	r3, THREAD_TM_TFHAR(r12)
+	std	r4, THREAD_TM_TFIAR(r12)
+
+	/* AMR and PPR are checkpointed too, but are unsupported by Linux. */
+
+	/* Restore original MSR/IRQ state & clear TM mode */
+	ld	r14, TM_FRAME_L0(r1)		/* Orig MSR */
+	li	r15, 0
+	rldimi  r14, r15, MSR_TS_LG, (63-MSR_TS_LG)-1
+	mtmsrd  r14
+
+	REST_NVGPRS(r1)
+
+	addi    r1, r1, TM_FRAME_SIZE
+	ld	r4, 8(r1)
+	ld	r0, 16(r1)
+	mtcr	r4
+	mtlr	r0
+	ld	r2, 40(r1)
+	blr
+
+
+	/* void tm_recheckpoint(struct thread_struct *thread,
+	 *			unsigned long orig_msr)
+	 *	- Restore the checkpointed register state saved by tm_reclaim
+	 *	  when we switch_to a process.
+	 *
+	 *	Call with IRQs off, stacks get all out of sync for
+	 *	some periods in here!
+	 */
+_GLOBAL(tm_recheckpoint)
+	mfcr	r5
+	mflr	r0
+	std	r5, 8(r1)
+	std	r0, 16(r1)
+	std	r2, 40(r1)
+	stdu	r1, -TM_FRAME_SIZE(r1)
+
+	/* We've a struct pt_regs at [r1+STACK_FRAME_OVERHEAD].
+	 * This is used for backing up the NVGPRs:
+	 */
+	SAVE_NVGPRS(r1)
+
+	std	r1, PACAR1(r13)
+
+	/* Load complete register state from ts_ckpt* registers */
+
+	addi	r7, r3, PT_CKPT_REGS		/* Thread's ckpt_regs */
+
+	/* Make r7 look like an exception frame so that we
+	 * can use the neat GPRx(n) macros.  r7 is now NOT a pt_regs ptr!
+	 */
+	subi	r7, r7, STACK_FRAME_OVERHEAD
+
+	SET_SCRATCH0(r1)
+
+	mfmsr	r6
+	/* R4 = original MSR to indicate whether thread used FP/Vector etc. */
+
+	/* Enable FP/vec in MSR if necessary! */
+	lis	r5, MSR_VEC@h
+	ori	r5, r5, MSR_FP
+	and.	r5, r4, r5
+	beq	restore_gprs			/* if neither, skip both */
+
+#ifdef CONFIG_VSX
+	BEGIN_FTR_SECTION
+	oris	r5, r5, MSR_VSX@h
+	END_FTR_SECTION_IFSET(CPU_FTR_VSX)
+#endif
+	or	r5, r6, r5			/* Set MSR.FP+.VSX/.VEC */
+	mtmsr	r5
+
+	/* FP and VEC registers:  These are recheckpointed from thread.fpr[]
+	 * and thread.vr[] respectively.  The thread.transact_fpr[] version
+	 * is more modern, and will be loaded subsequently by any FPUnavailable
+	 * trap.
+	 */
+	andis.	r0, r4, MSR_VEC@h
+	beq	dont_restore_vec
+
+	li	r5, THREAD_VSCR
+	lvx	vr0, r3, r5
+	mtvscr	vr0
+	REST_32VRS(0, r5, r3)			/* r5 scratch, r3 THREAD ptr */
+	ld	r5, THREAD_VRSAVE(r3)
+	mtspr	SPRN_VRSAVE, r5
+
+dont_restore_vec:
+	andi.	r0, r4, MSR_FP
+	beq	dont_restore_fp
+
+	lfd	fr0, THREAD_FPSCR(r3)
+	MTFSF_L(fr0)
+	REST_32FPRS_VSRS(0, R4, R3)
+
+dont_restore_fp:
+	mtmsr	r6				/* FP/Vec off again! */
+
+restore_gprs:
+	/* ******************** CR,LR,CCR,MSR ********** */
+	ld	r3, _CTR(r7)
+	ld	r4, _LINK(r7)
+	ld	r5, _CCR(r7)
+	ld	r6, _XER(r7)
+
+	mtctr	r3
+	mtlr	r4
+	mtcr	r5
+	mtxer	r6
+
+	/* MSR and flags:  We don't change CRs, and we don't need to alter
+	 * MSR.
+	 */
+
+	REST_4GPRS(0, r7)			/* GPR0-3 */
+	REST_GPR(4, r7)				/* GPR4-6 */
+	REST_GPR(5, r7)
+	REST_GPR(6, r7)
+	REST_4GPRS(8, r7)			/* GPR8-11 */
+	REST_2GPRS(12, r7)			/* GPR12-13 */
+
+	REST_NVGPRS(r7)				/* GPR14-31 */
+
+	ld	r7, GPR7(r7)			/* GPR7 */
+
+	/* Commit register state as checkpointed state: */
+	TRECHKPT
+
+	/* Our transactional state has now changed.
+	 *
+	 * Now just get out of here.  Transactional (current) state will be
+	 * updated once restore is called on the return path in the _switch-ed
+	 * -to process.
+	 */
+
+	GET_PACA(r13)
+	GET_SCRATCH0(r1)
+
+	REST_NVGPRS(r1)
+
+	addi    r1, r1, TM_FRAME_SIZE
+	ld	r4, 8(r1)
+	ld	r0, 16(r1)
+	mtcr	r4
+	mtlr	r0
+	ld	r2, 40(r1)
+	blr
+
+	/* ****************************************************************** */
-- 
1.7.9.5
