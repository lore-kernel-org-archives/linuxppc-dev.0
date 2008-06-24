Return-Path: <mikey@neuling.org>
To: Paul Mackerras <paulus@samba.org>
From: Michael Neuling <mikey@neuling.org>
Date: Tue, 24 Jun 2008 20:57:49 +1000
Subject: [PATCH 2/9] powerpc: Add macros to access floating point registers in
	thread_struct.
In-Reply-To: <1214305069.538931.136638600960.qpush@coopers>
Message-Id: <20080624105750.0610170295@localhost.localdomain>
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

 arch/powerpc/kernel/align.c      |    6 ++--
 arch/powerpc/kernel/process.c    |    5 ++-
 arch/powerpc/kernel/ptrace.c     |   14 +++++----
 arch/powerpc/kernel/ptrace32.c   |   14 +++++++--
 arch/powerpc/kernel/softemu8xx.c |    4 +-
 arch/powerpc/math-emu/math.c     |   56 +++++++++++++++++++--------------------
 include/asm-powerpc/ppc_asm.h    |    5 ++-
 include/asm-powerpc/processor.h  |    3 ++
 8 files changed, 61 insertions(+), 46 deletions(-)

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
+	memset(current->thread.fpr, 0,
+	       sizeof(current->thread.fpr));
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
+				   target->thread.fpr, 0, -1);
 }
 
 static int fpr_set(struct task_struct *target, const struct user_regset *regset,
@@ -231,10 +231,10 @@ static int fpr_set(struct task_struct *t
 	flush_fp_to_thread(target);
 
 	BUILD_BUG_ON(offsetof(struct thread_struct, fpscr) !=
-		     offsetof(struct thread_struct, fpr[32]));
+		     offsetof(struct thread_struct, TS_FPR(32)));
 
 	return user_regset_copyin(&pos, &count, &kbuf, &ubuf,
-				  &target->thread.fpr, 0, -1);
+				  target->thread.fpr, 0, -1);
 }
 
 
@@ -728,7 +728,8 @@ long arch_ptrace(struct task_struct *chi
 			tmp = ptrace_get_reg(child, (int) index);
 		} else {
 			flush_fp_to_thread(child);
-			tmp = ((unsigned long *)child->thread.fpr)[index - PT_FPR0];
+			tmp = ((unsigned long *)child->thread.fpr)
+				[TS_FPRSPACING * (index - PT_FPR0)];
 		}
 		ret = put_user(tmp,(unsigned long __user *) data);
 		break;
@@ -755,7 +756,8 @@ long arch_ptrace(struct task_struct *chi
 			ret = ptrace_put_reg(child, index, data);
 		} else {
 			flush_fp_to_thread(child);
-			((unsigned long *)child->thread.fpr)[index - PT_FPR0] = data;
+			((unsigned long *)child->thread.fpr)
+				[TS_FPRSPACING * (index - PT_FPR0)] = data;
 			ret = 0;
 		}
 		break;
Index: linux-2.6-ozlabs/arch/powerpc/kernel/ptrace32.c
===================================================================
--- linux-2.6-ozlabs.orig/arch/powerpc/kernel/ptrace32.c
+++ linux-2.6-ozlabs/arch/powerpc/kernel/ptrace32.c
@@ -64,6 +64,11 @@ static long compat_ptrace_old(struct tas
 	return -EPERM;
 }
 
+/* Macros to workout the correct index for the FPR in the thread struct */
+#define FPRNUMBER(i) (((i) - PT_FPR0) >> 1)
+#define FPRHALF(i) (((i) - PT_FPR0) % 2)
+#define FPRINDEX(i) TS_FPRSPACING * FPRNUMBER(i) + FPRHALF(i)
+
 long compat_arch_ptrace(struct task_struct *child, compat_long_t request,
 			compat_ulong_t caddr, compat_ulong_t cdata)
 {
@@ -122,7 +127,8 @@ long compat_arch_ptrace(struct task_stru
 			 * to be an array of unsigned int (32 bits) - the
 			 * index passed in is based on this assumption.
 			 */
-			tmp = ((unsigned int *)child->thread.fpr)[index - PT_FPR0];
+			tmp = ((unsigned int *)child->thread.fpr)
+				[FPRINDEX(index)];
 		}
 		ret = put_user((unsigned int)tmp, (u32 __user *)data);
 		break;
@@ -162,7 +168,8 @@ long compat_arch_ptrace(struct task_stru
 		CHECK_FULL_REGS(child->thread.regs);
 		if (numReg >= PT_FPR0) {
 			flush_fp_to_thread(child);
-			tmp = ((unsigned long int *)child->thread.fpr)[numReg - PT_FPR0];
+			tmp = ((unsigned long int *)child->thread.fpr)
+				[FPRINDEX(numReg)];
 		} else { /* register within PT_REGS struct */
 			tmp = ptrace_get_reg(child, numReg);
 		} 
@@ -217,7 +224,8 @@ long compat_arch_ptrace(struct task_stru
 			 * to be an array of unsigned int (32 bits) - the
 			 * index passed in is based on this assumption.
 			 */
-			((unsigned int *)child->thread.fpr)[index - PT_FPR0] = data;
+			((unsigned int *)child->thread.fpr)
+				[TS_FPRSPACING * (index - PT_FPR0)] = data;
 			ret = 0;
 		}
 		break;
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
@@ -136,6 +136,8 @@ typedef struct {
 	unsigned long seg;
 } mm_segment_t;
 
+#define TS_FPR(i) fpr[i]
+
 struct thread_struct {
 	unsigned long	ksp;		/* Kernel stack pointer */
 	unsigned long	ksp_limit;	/* if ksp <= ksp_limit stack overflow */
@@ -289,4 +291,5 @@ static inline void prefetchw(const void 
 
 #endif /* __KERNEL__ */
 #endif /* __ASSEMBLY__ */
+#define TS_FPRSPACING 1
 #endif /* _ASM_POWERPC_PROCESSOR_H */
