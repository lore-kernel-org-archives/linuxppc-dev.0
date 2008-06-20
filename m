Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Fri, 20 Jun 2008 14:13:52 +1000
Subject: [PATCH 2/9] powerpc: Add macros to access floating point registers in
	thread_struct.
In-Reply-To: <1213935232.194904.168421502953.qpush@coopers>
Message-Id: <20080620041352.4350D70293@localhost.localdomain>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

We are going to change where the floating point registers are stored
in the thread_struct, so in preparation add some macros to access the
floating point registers.  Update all code to use these new macros.

Signed-off-by: Michael Neuling <mikey@neuling.org>
---

 arch/powerpc/kernel/align.c       |    6 ++--
 arch/powerpc/kernel/asm-offsets.c |    2 -
 arch/powerpc/kernel/process.c     |    5 ++-
 arch/powerpc/kernel/ptrace.c      |   14 +++++----
 arch/powerpc/kernel/ptrace32.c    |    9 ++++--
 arch/powerpc/kernel/signal_32.c   |    6 ++--
 arch/powerpc/kernel/signal_64.c   |   13 +++++---
 arch/powerpc/kernel/softemu8xx.c  |    4 +-
 arch/powerpc/math-emu/math.c      |   56 +++++++++++++++++++-------------------
 include/asm-powerpc/ppc_asm.h     |    5 ++-
 include/asm-powerpc/processor.h   |    7 ++++
 11 files changed, 71 insertions(+), 56 deletions(-)

Index: linux-2.6-ozlabs/arch/powerpc/kernel/align.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/align.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/align.c
@@ -366,7 +366,7 @@ static int emulate_multiple(struct pt_re
 static int emulate_fp_pair(struct pt_regs *regs, unsigned char __user *addr,
 			   unsigned int reg, unsigned int flags)
 {
-	char *ptr = (char *) &current->thread.fpr[reg];
+	char *ptr = (char *) &current->thread.TS_FPR(reg);
 	int i, ret;
 
 	if (!(flags & F))
@@ -784,7 +784,7 @@ int fix_alignment(struct pt_regs *regs)
 				return -EFAULT;
 		}
 	} else if (flags & F) {
-		data.dd = current->thread.fpr[reg];
+		data.dd = current->thread.TS_FPR(reg);
 		if (flags & S) {
 			/* Single-precision FP store requires conversion... */
 #ifdef CONFIG_PPC_FPU
@@ -862,7 +862,7 @@ int fix_alignment(struct pt_regs *regs)
 		if (unlikely(ret))
 			return -EFAULT;
 	} else if (flags & F)
-		current->thread.fpr[reg] = data.dd;
+		current->thread.TS_FPR(reg) = data.dd;
 	else
 		regs->gpr[reg] = data.ll;
 
Index: linux-2.6-ozlabs/arch/powerpc/kernel/asm-offsets.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/asm-offsets.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/asm-offsets.c
@@ -66,7 +66,7 @@ int main(void)
 	DEFINE(KSP_LIMIT, offsetof(struct thread_struct, ksp_limit));
 	DEFINE(PT_REGS, offsetof(struct thread_struct, regs));
 	DEFINE(THREAD_FPEXC_MODE, offsetof(struct thread_struct, fpexc_mode));
-	DEFINE(THREAD_FPR0, offsetof(struct thread_struct, fpr[0]));
+	DEFINE(THREAD_FPR0, offsetof(struct thread_struct, TS_FPR(0)));
 	DEFINE(THREAD_FPSCR, offsetof(struct thread_struct, fpscr));
 #ifdef CONFIG_ALTIVEC
 	DEFINE(THREAD_VR0, offsetof(struct thread_struct, vr[0]));
Index: linux-2.6-ozlabs/arch/powerpc/kernel/process.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/process.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/process.c
@@ -110,7 +110,7 @@ int dump_task_fpu(struct task_struct *ts
 		return 0;
 	flush_fp_to_thread(current);
 
-	memcpy(fpregs, &tsk->thread.fpr[0], sizeof(*fpregs));
+	memcpy(fpregs, &tsk->thread.TS_FPR(0), sizeof(*fpregs));
 
 	return 1;
 }
@@ -689,7 +689,8 @@ void start_thread(struct pt_regs *regs, 
 #endif
 
 	discard_lazy_cpu_state();
-	memset(current->thread.fpr, 0, sizeof(current->thread.fpr));
+	memset(current->thread.TS_FPRSTART, 0,
+	       sizeof(current->thread.TS_FPRSTART));
 	current->thread.fpscr.val = 0;
 #ifdef CONFIG_ALTIVEC
 	memset(current->thread.vr, 0, sizeof(current->thread.vr));
Index: linux-2.6-ozlabs/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/ptrace.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/ptrace.c
@@ -218,10 +218,10 @@ static int fpr_get(struct task_struct *t
 	flush_fp_to_thread(target);
 
 	BUILD_BUG_ON(offsetof(struct thread_struct, fpscr) !=
-		     offsetof(struct thread_struct, fpr[32]));
+		     offsetof(struct thread_struct, TS_FPR(32)));
 
 	return user_regset_copyout(&pos, &count, &kbuf, &ubuf,
-				   &target->thread.fpr, 0, -1);
+				   &target->thread.TS_FPRSTART, 0, -1);
 }
 
 static int fpr_set(struct task_struct *target, const struct user_regset *regset,
@@ -231,10 +231,10 @@ static int fpr_set(struct task_struct *t
 	flush_fp_to_thread(target);
 
 	BUILD_BUG_ON(offsetof(struct thread_struct, fpscr) !=
-		     offsetof(struct thread_struct, fpr[32]));
+		     offsetof(struct thread_struct, TS_FPR(32)));
 
 	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				  &target->thread.fpr, 0, -1);
+				  &target->thread.TS_FPRSTART, 0, -1);
 }
 
 
@@ -728,7 +728,8 @@ long arch_ptrace(struct task_struct *chi
 			tmp = ptrace_get_reg(child, (int) index);
 		} else {
 			flush_fp_to_thread(child);
-			tmp = ((unsigned long *)child->thread.fpr)[index - PT_FPR0];
+			tmp = ((unsigned long *)child->thread.TS_FPRSTART)
+				[TS_FPRSPACING * (index - PT_FPR0)];
 		}
 		ret = put_user(tmp,(unsigned long __user *) data);
 		break;
@@ -755,7 +756,8 @@ long arch_ptrace(struct task_struct *chi
 			ret = ptrace_put_reg(child, index, data);
 		} else {
 			flush_fp_to_thread(child);
-			((unsigned long *)child->thread.fpr)[index - PT_FPR0] = data;
+			((unsigned long *)child->thread.TS_FPRSTART)
+				[TS_FPRSPACING * (index - PT_FPR0)] = data;
 			ret = 0;
 		}
 		break;
Index: linux-2.6-ozlabs/arch/powerpc/kernel/ptrace32.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/ptrace32.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/ptrace32.c
@@ -122,7 +122,8 @@ long compat_arch_ptrace(struct task_stru
 			 * to be an array of unsigned int (32 bits) - the
 			 * index passed in is based on this assumption.
 			 */
-			tmp = ((unsigned int *)child->thread.fpr)[index - PT_FPR0];
+			tmp = ((unsigned int *)child->thread.TS_FPRSTART)
+				[TS_FPRSPACING * (index - PT_FPR0)];
 		}
 		ret = put_user((unsigned int)tmp, (u32 __user *)data);
 		break;
@@ -162,7 +163,8 @@ long compat_arch_ptrace(struct task_stru
 		CHECK_FULL_REGS(child->thread.regs);
 		if (numReg >= PT_FPR0) {
 			flush_fp_to_thread(child);
-			tmp = ((unsigned long int *)child->thread.fpr)[numReg - PT_FPR0];
+			tmp = ((unsigned long int *)child->thread.TS_FPRSTART)
+				[TS_FPRSPACING * (numReg - PT_FPR0)];
 		} else { /* register within PT_REGS struct */
 			tmp = ptrace_get_reg(child, numReg);
 		} 
@@ -217,7 +219,8 @@ long compat_arch_ptrace(struct task_stru
 			 * to be an array of unsigned int (32 bits) - the
 			 * index passed in is based on this assumption.
 			 */
-			((unsigned int *)child->thread.fpr)[index - PT_FPR0] = data;
+			((unsigned int *)child->thread.TS_FPRSTART)
+				[TS_FPRSPACING * (index - PT_FPR0)] = data;
 			ret = 0;
 		}
 		break;
Index: linux-2.6-ozlabs/arch/powerpc/kernel/signal_32.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/signal_32.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/signal_32.c
@@ -343,7 +343,7 @@ static int save_user_regs(struct pt_regs
 
 	/* save general and floating-point registers */
 	if (save_general_regs(regs, frame) ||
-	    __copy_to_user(&frame->mc_fregs, current->thread.fpr,
+	    __copy_to_user(&frame->mc_fregs, current->thread.TS_FPRSTART,
 		    ELF_NFPREG * sizeof(double)))
 		return 1;
 
@@ -431,7 +431,7 @@ static long restore_user_regs(struct pt_
 
 	/*
 	 * Do this before updating the thread state in
-	 * current->thread.fpr/vr/evr.  That way, if we get preempted
+	 * current->thread.FPR/vr/evr.  That way, if we get preempted
 	 * and another task grabs the FPU/Altivec/SPE, it won't be
 	 * tempted to save the current CPU state into the thread_struct
 	 * and corrupt what we are writing there.
@@ -441,7 +441,7 @@ static long restore_user_regs(struct pt_
 	/* force the process to reload the FP registers from
 	   current->thread when it next does FP instructions */
 	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1);
-	if (__copy_from_user(current->thread.fpr, &sr->mc_fregs,
+	if (__copy_from_user(current->thread.TS_FPRSTART, &sr->mc_fregs,
 			     sizeof(sr->mc_fregs)))
 		return 1;
 
Index: linux-2.6-ozlabs/arch/powerpc/kernel/signal_64.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/signal_64.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/signal_64.c
@@ -116,7 +116,8 @@ static long setup_sigcontext(struct sigc
 	WARN_ON(!FULL_REGS(regs));
 	err |= __copy_to_user(&sc->gp_regs, regs, GP_REGS_SIZE);
 	err |= __put_user(msr, &sc->gp_regs[PT_MSR]);
-	err |= __copy_to_user(&sc->fp_regs, &current->thread.fpr, FP_REGS_SIZE);
+	err |= __copy_to_user(&sc->fp_regs, &current->thread.TS_FPRSTART,
+			      FP_REGS_SIZE);
 	err |= __put_user(signr, &sc->signal);
 	err |= __put_user(handler, &sc->handler);
 	if (set != NULL)
@@ -168,7 +169,7 @@ static long restore_sigcontext(struct pt
 
 	/*
 	 * Do this before updating the thread state in
-	 * current->thread.fpr/vr.  That way, if we get preempted
+	 * current->thread.TS_FPR/vr.  That way, if we get preempted
 	 * and another task grabs the FPU/Altivec, it won't be
 	 * tempted to save the current CPU state into the thread_struct
 	 * and corrupt what we are writing there.
@@ -177,12 +178,14 @@ static long restore_sigcontext(struct pt
 
 	/*
 	 * Force reload of FP/VEC.
-	 * This has to be done before copying stuff into current->thread.fpr/vr
-	 * for the reasons explained in the previous comment.
+	 * This has to be done before copying stuff into
+	 * current->thread.TS_FPR/vr for the reasons explained in the
+	 * previous comment.
 	 */
 	regs->msr &= ~(MSR_FP | MSR_FE0 | MSR_FE1 | MSR_VEC);
 
-	err |= __copy_from_user(&current->thread.fpr, &sc->fp_regs, FP_REGS_SIZE);
+	err |= __copy_from_user(&current->thread.TS_FPRSTART, &sc->fp_regs,
+				FP_REGS_SIZE);
 
 #ifdef CONFIG_ALTIVEC
 	err |= __get_user(v_regs, &sc->v_regs);
Index: linux-2.6-ozlabs/arch/powerpc/kernel/softemu8xx.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/softemu8xx.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/softemu8xx.c
@@ -124,7 +124,7 @@ int Soft_emulate_8xx(struct pt_regs *reg
 	disp = instword & 0xffff;
 
 	ea = (u32 *)(regs->gpr[idxreg] + disp);
-	ip = (u32 *)&current->thread.fpr[flreg];
+	ip = (u32 *)&current->thread.TS_FPR(flreg);
 
 	switch ( inst )
 	{
@@ -168,7 +168,7 @@ int Soft_emulate_8xx(struct pt_regs *reg
 		break;
 	case FMR:
 		/* assume this is a fp move -- Cort */
-		memcpy(ip, &current->thread.fpr[(instword>>11)&0x1f],
+		memcpy(ip, &current->thread.TS_FPR((instword>>11)&0x1f),
 		       sizeof(double));
 		break;
 	default:
Index: linux-2.6-ozlabs/arch/powerpc/math-emu/math.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/math-emu/math.c
+++ linux-2.6-ozlabs/arch/powerpc/math-emu/math.c
@@ -230,14 +230,14 @@ do_mathemu(struct pt_regs *regs)
 	case LFD:
 		idx = (insn >> 16) & 0x1f;
 		sdisp = (insn & 0xffff);
-		op0 = (void *)&current->thread.fpr[(insn >> 21) & 0x1f];
+		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
 		op1 = (void *)((idx ? regs->gpr[idx] : 0) + sdisp);
 		lfd(op0, op1, op2, op3);
 		break;
 	case LFDU:
 		idx = (insn >> 16) & 0x1f;
 		sdisp = (insn & 0xffff);
-		op0 = (void *)&current->thread.fpr[(insn >> 21) & 0x1f];
+		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
 		op1 = (void *)((idx ? regs->gpr[idx] : 0) + sdisp);
 		lfd(op0, op1, op2, op3);
 		regs->gpr[idx] = (unsigned long)op1;
@@ -245,21 +245,21 @@ do_mathemu(struct pt_regs *regs)
 	case STFD:
 		idx = (insn >> 16) & 0x1f;
 		sdisp = (insn & 0xffff);
-		op0 = (void *)&current->thread.fpr[(insn >> 21) & 0x1f];
+		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
 		op1 = (void *)((idx ? regs->gpr[idx] : 0) + sdisp);
 		stfd(op0, op1, op2, op3);
 		break;
 	case STFDU:
 		idx = (insn >> 16) & 0x1f;
 		sdisp = (insn & 0xffff);
-		op0 = (void *)&current->thread.fpr[(insn >> 21) & 0x1f];
+		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
 		op1 = (void *)((idx ? regs->gpr[idx] : 0) + sdisp);
 		stfd(op0, op1, op2, op3);
 		regs->gpr[idx] = (unsigned long)op1;
 		break;
 	case OP63:
-		op0 = (void *)&current->thread.fpr[(insn >> 21) & 0x1f];
-		op1 = (void *)&current->thread.fpr[(insn >> 11) & 0x1f];
+		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
+		op1 = (void *)&current->thread.TS_FPR((insn >> 11) & 0x1f);
 		fmr(op0, op1, op2, op3);
 		break;
 	default:
@@ -356,28 +356,28 @@ do_mathemu(struct pt_regs *regs)
 
 	switch (type) {
 	case AB:
-		op0 = (void *)&current->thread.fpr[(insn >> 21) & 0x1f];
-		op1 = (void *)&current->thread.fpr[(insn >> 16) & 0x1f];
-		op2 = (void *)&current->thread.fpr[(insn >> 11) & 0x1f];
+		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
+		op1 = (void *)&current->thread.TS_FPR((insn >> 16) & 0x1f);
+		op2 = (void *)&current->thread.TS_FPR((insn >> 11) & 0x1f);
 		break;
 
 	case AC:
-		op0 = (void *)&current->thread.fpr[(insn >> 21) & 0x1f];
-		op1 = (void *)&current->thread.fpr[(insn >> 16) & 0x1f];
-		op2 = (void *)&current->thread.fpr[(insn >>  6) & 0x1f];
+		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
+		op1 = (void *)&current->thread.TS_FPR((insn >> 16) & 0x1f);
+		op2 = (void *)&current->thread.TS_FPR((insn >>  6) & 0x1f);
 		break;
 
 	case ABC:
-		op0 = (void *)&current->thread.fpr[(insn >> 21) & 0x1f];
-		op1 = (void *)&current->thread.fpr[(insn >> 16) & 0x1f];
-		op2 = (void *)&current->thread.fpr[(insn >> 11) & 0x1f];
-		op3 = (void *)&current->thread.fpr[(insn >>  6) & 0x1f];
+		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
+		op1 = (void *)&current->thread.TS_FPR((insn >> 16) & 0x1f);
+		op2 = (void *)&current->thread.TS_FPR((insn >> 11) & 0x1f);
+		op3 = (void *)&current->thread.TS_FPR((insn >>  6) & 0x1f);
 		break;
 
 	case D:
 		idx = (insn >> 16) & 0x1f;
 		sdisp = (insn & 0xffff);
-		op0 = (void *)&current->thread.fpr[(insn >> 21) & 0x1f];
+		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
 		op1 = (void *)((idx ? regs->gpr[idx] : 0) + sdisp);
 		break;
 
@@ -387,27 +387,27 @@ do_mathemu(struct pt_regs *regs)
 			goto illegal;
 
 		sdisp = (insn & 0xffff);
-		op0 = (void *)&current->thread.fpr[(insn >> 21) & 0x1f];
+		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
 		op1 = (void *)(regs->gpr[idx] + sdisp);
 		break;
 
 	case X:
-		op0 = (void *)&current->thread.fpr[(insn >> 21) & 0x1f];
+		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
 		break;
 
 	case XA:
-		op0 = (void *)&current->thread.fpr[(insn >> 21) & 0x1f];
-		op1 = (void *)&current->thread.fpr[(insn >> 16) & 0x1f];
+		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
+		op1 = (void *)&current->thread.TS_FPR((insn >> 16) & 0x1f);
 		break;
 
 	case XB:
-		op0 = (void *)&current->thread.fpr[(insn >> 21) & 0x1f];
-		op1 = (void *)&current->thread.fpr[(insn >> 11) & 0x1f];
+		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
+		op1 = (void *)&current->thread.TS_FPR((insn >> 11) & 0x1f);
 		break;
 
 	case XE:
 		idx = (insn >> 16) & 0x1f;
-		op0 = (void *)&current->thread.fpr[(insn >> 21) & 0x1f];
+		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
 		if (!idx) {
 			if (((insn >> 1) & 0x3ff) == STFIWX)
 				op1 = (void *)(regs->gpr[(insn >> 11) & 0x1f]);
@@ -421,7 +421,7 @@ do_mathemu(struct pt_regs *regs)
 
 	case XEU:
 		idx = (insn >> 16) & 0x1f;
-		op0 = (void *)&current->thread.fpr[(insn >> 21) & 0x1f];
+		op0 = (void *)&current->thread.TS_FPR((insn >> 21) & 0x1f);
 		op1 = (void *)((idx ? regs->gpr[idx] : 0)
 				+ regs->gpr[(insn >> 11) & 0x1f]);
 		break;
@@ -429,8 +429,8 @@ do_mathemu(struct pt_regs *regs)
 	case XCR:
 		op0 = (void *)&regs->ccr;
 		op1 = (void *)((insn >> 23) & 0x7);
-		op2 = (void *)&current->thread.fpr[(insn >> 16) & 0x1f];
-		op3 = (void *)&current->thread.fpr[(insn >> 11) & 0x1f];
+		op2 = (void *)&current->thread.TS_FPR((insn >> 16) & 0x1f);
+		op3 = (void *)&current->thread.TS_FPR((insn >> 11) & 0x1f);
 		break;
 
 	case XCRL:
@@ -450,7 +450,7 @@ do_mathemu(struct pt_regs *regs)
 
 	case XFLB:
 		op0 = (void *)((insn >> 17) & 0xff);
-		op1 = (void *)&current->thread.fpr[(insn >> 11) & 0x1f];
+		op1 = (void *)&current->thread.TS_FPR((insn >> 11) & 0x1f);
 		break;
 
 	default:
Index: linux-2.6-ozlabs/include/asm-powerpc/ppc_asm.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/ppc_asm.h
+++ linux-2.6-ozlabs/include/asm-powerpc/ppc_asm.h
@@ -6,6 +6,7 @@
 
 #include <linux/stringify.h>
 #include <asm/asm-compat.h>
+#include <asm/processor.h>
 
 #ifndef __ASSEMBLY__
 #error __FILE__ should only be used in assembler files
@@ -83,13 +84,13 @@ END_FTR_SECTION_IFCLR(CPU_FTR_PURR);				
 #define REST_8GPRS(n, base)	REST_4GPRS(n, base); REST_4GPRS(n+4, base)
 #define REST_10GPRS(n, base)	REST_8GPRS(n, base); REST_2GPRS(n+8, base)
 
-#define SAVE_FPR(n, base)	stfd	n,THREAD_FPR0+8*(n)(base)
+#define SAVE_FPR(n, base)	stfd	n,THREAD_FPR0+8*TS_FPRSPACING*(n)(base)
 #define SAVE_2FPRS(n, base)	SAVE_FPR(n, base); SAVE_FPR(n+1, base)
 #define SAVE_4FPRS(n, base)	SAVE_2FPRS(n, base); SAVE_2FPRS(n+2, base)
 #define SAVE_8FPRS(n, base)	SAVE_4FPRS(n, base); SAVE_4FPRS(n+4, base)
 #define SAVE_16FPRS(n, base)	SAVE_8FPRS(n, base); SAVE_8FPRS(n+8, base)
 #define SAVE_32FPRS(n, base)	SAVE_16FPRS(n, base); SAVE_16FPRS(n+16, base)
-#define REST_FPR(n, base)	lfd	n,THREAD_FPR0+8*(n)(base)
+#define REST_FPR(n, base)	lfd	n,THREAD_FPR0+8*TS_FPRSPACING*(n)(base)
 #define REST_2FPRS(n, base)	REST_FPR(n, base); REST_FPR(n+1, base)
 #define REST_4FPRS(n, base)	REST_2FPRS(n, base); REST_2FPRS(n+2, base)
 #define REST_8FPRS(n, base)	REST_4FPRS(n, base); REST_4FPRS(n+4, base)
Index: linux-2.6-ozlabs/include/asm-powerpc/processor.h
===================================================================
--- linux-2.6-ozlabs.orig/include/asm-powerpc/processor.h
+++ linux-2.6-ozlabs/include/asm-powerpc/processor.h
@@ -136,6 +136,9 @@ typedef struct {
 	unsigned long seg;
 } mm_segment_t;
 
+#define TS_FPR(i) fpr[i]
+#define TS_FPRSTART fpr
+
 struct thread_struct {
 	unsigned long	ksp;		/* Kernel stack pointer */
 	unsigned long	ksp_limit;	/* if ksp <= ksp_limit stack overflow */
@@ -197,12 +200,13 @@ struct thread_struct {
 	.fpexc_mode = MSR_FE0 | MSR_FE1, \
 }
 #else
+#define	FPVSR_INIT_THREAD .fpr = {0}
 #define INIT_THREAD  { \
 	.ksp = INIT_SP, \
 	.ksp_limit = INIT_SP_LIMIT, \
 	.regs = (struct pt_regs *)INIT_SP - 1, /* XXX bogus, I think */ \
 	.fs = KERNEL_DS, \
-	.fpr = {0}, \
+	FPVSR_INIT_THREAD, \
 	.fpscr = { .val = 0, }, \
 	.fpexc_mode = 0, \
 }
@@ -289,4 +293,5 @@ static inline void prefetchw(const void 
 
 #endif /* __KERNEL__ */
 #endif /* __ASSEMBLY__ */
+#define TS_FPRSPACING 1
 #endif /* _ASM_POWERPC_PROCESSOR_H */
