Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Wed, 30 May 2007 17:17:16 +1000
Subject: [RFC/PATCH 4/6] powerpc: uninline common ptrace bits
Message-Id: <20070530071728.1A173DDFEF@ozlabs.org>
Cc: ulrich.weigand@de.ibm.com, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This folds back the ptrace-common.h bits back into ptrace.c and removes
that file. The FSL SPE bits from ptrace-ppc32.h are folded back in as
well.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/ptrace-common.h |  177 ---------------------------
 arch/powerpc/kernel/ptrace-ppc32.h  |   65 ----------
 arch/powerpc/kernel/ptrace.c        |  233 +++++++++++++++++++++++++++++++++++-
 arch/powerpc/kernel/ptrace32.c      |   11 -
 include/asm-powerpc/ptrace.h        |    5 
 5 files changed, 237 insertions(+), 254 deletions(-)

Index: linux-cell/arch/powerpc/kernel/ptrace-common.h
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace-common.h	2007-05-30 15:50:42.000000000 +1000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,177 +0,0 @@
-/*
- *    Copyright (c) 2002 Stephen Rothwell, IBM Coproration
- *    Copyright (c) 2007 Benjamin Herrenschmidt, IBM Coproration
- *    Extracted from ptrace.c and ptrace32.c
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file README.legal in the main directory of
- * this archive for more details.
- */
-
-#ifndef _POWERPC_PTRACE_COMMON_H
-#define _POWERPC_PTRACE_COMMON_H
-
-/*
- * Get contents of register REGNO in task TASK.
- */
-static inline unsigned long get_reg(struct task_struct *task, int regno)
-{
-	unsigned long tmp = 0;
-
-	if (task->thread.regs == NULL)
-		return -EIO;
-
-	if (regno == PT_MSR) {
-		tmp = ((unsigned long *)task->thread.regs)[PT_MSR];
-		return PT_MUNGE_MSR(tmp, task);
-	}
-
-	if (regno < (sizeof(struct pt_regs) / sizeof(unsigned long)))
-		return ((unsigned long *)task->thread.regs)[regno];
-
-	return -EIO;
-}
-
-/*
- * Write contents of register REGNO in task TASK.
- */
-static inline int put_reg(struct task_struct *task, int regno,
-			  unsigned long data)
-{
-	if (task->thread.regs == NULL)
-		return -EIO;
-
-	if (regno <= PT_MAX_PUT_REG) {
-		if (regno == PT_MSR)
-			data = (data & MSR_DEBUGCHANGE)
-				| (task->thread.regs->msr & ~MSR_DEBUGCHANGE);
-		((unsigned long *)task->thread.regs)[regno] = data;
-		return 0;
-	}
-	return -EIO;
-}
-
-
-static inline int get_fpregs(void __user *data,
-			     struct task_struct *task,
-			     int has_fpscr)
-{
-	unsigned int count = has_fpscr ? 33 : 32;
-
-	if (copy_to_user(data, task->thread.fpr, count * sizeof(double)))
-		return -EFAULT;
-	return 0;
-}
-
-static inline int set_fpregs(void __user *data,
-			     struct task_struct *task,
-			     int has_fpscr)
-{
-	unsigned int count = has_fpscr ? 33 : 32;
-
-	if (copy_from_user(task->thread.fpr, data, count * sizeof(double)))
-		return -EFAULT;
-	return 0;
-}
-
-
-#ifdef CONFIG_ALTIVEC
-/*
- * Get/set all the altivec registers vr0..vr31, vscr, vrsave, in one go.
- * The transfer totals 34 quadword.  Quadwords 0-31 contain the
- * corresponding vector registers.  Quadword 32 contains the vscr as the
- * last word (offset 12) within that quadword.  Quadword 33 contains the
- * vrsave as the first word (offset 0) within the quadword.
- *
- * This definition of the VMX state is compatible with the current PPC32
- * ptrace interface.  This allows signal handling and ptrace to use the
- * same structures.  This also simplifies the implementation of a bi-arch
- * (combined (32- and 64-bit) gdb.
- */
-
-/*
- * Get contents of AltiVec register state in task TASK
- */
-static inline int get_vrregs(unsigned long __user *data,
-			     struct task_struct *task)
-{
-	unsigned long regsize;
-
-	/* copy AltiVec registers VR[0] .. VR[31] */
-	regsize = 32 * sizeof(vector128);
-	if (copy_to_user(data, task->thread.vr, regsize))
-		return -EFAULT;
-	data += (regsize / sizeof(unsigned long));
-
-	/* copy VSCR */
-	regsize = 1 * sizeof(vector128);
-	if (copy_to_user(data, &task->thread.vscr, regsize))
-		return -EFAULT;
-	data += (regsize / sizeof(unsigned long));
-
-	/* copy VRSAVE */
-	if (put_user(task->thread.vrsave, (u32 __user *)data))
-		return -EFAULT;
-
-	return 0;
-}
-
-/*
- * Write contents of AltiVec register state into task TASK.
- */
-static inline int set_vrregs(struct task_struct *task,
-			     unsigned long __user *data)
-{
-	unsigned long regsize;
-
-	/* copy AltiVec registers VR[0] .. VR[31] */
-	regsize = 32 * sizeof(vector128);
-	if (copy_from_user(task->thread.vr, data, regsize))
-		return -EFAULT;
-	data += (regsize / sizeof(unsigned long));
-
-	/* copy VSCR */
-	regsize = 1 * sizeof(vector128);
-	if (copy_from_user(&task->thread.vscr, data, regsize))
-		return -EFAULT;
-	data += (regsize / sizeof(unsigned long));
-
-	/* copy VRSAVE */
-	if (get_user(task->thread.vrsave, (u32 __user *)data))
-		return -EFAULT;
-
-	return 0;
-}
-#endif /* CONFIG_ALTIVEC */
-
-static inline void set_single_step(struct task_struct *task)
-{
-	struct pt_regs *regs = task->thread.regs;
-
-	if (regs != NULL) {
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
-		task->thread.dbcr0 = DBCR0_IDM | DBCR0_IC;
-		regs->msr |= MSR_DE;
-#else
-		regs->msr |= MSR_SE;
-#endif
-	}
-	set_tsk_thread_flag(task, TIF_SINGLESTEP);
-}
-
-static inline void clear_single_step(struct task_struct *task)
-{
-	struct pt_regs *regs = task->thread.regs;
-
-	if (regs != NULL) {
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
-		task->thread.dbcr0 = 0;
-		regs->msr &= ~MSR_DE;
-#else
-		regs->msr &= ~MSR_SE;
-#endif
-	}
-	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
-}
-
-#endif /* _POWERPC_PTRACE_COMMON_H */
Index: linux-cell/arch/powerpc/kernel/ptrace-ppc32.h
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace-ppc32.h	2007-05-30 15:50:42.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/ptrace-ppc32.h	2007-05-30 15:51:01.000000000 +1000
@@ -32,69 +32,4 @@
 #define PT_MUNGE_MSR(msr, task)	(msr)
 
 
-#ifdef CONFIG_SPE
-
-/*
- * For get_evrregs/set_evrregs functions 'data' has the following layout:
- *
- * struct {
- *   u32 evr[32];
- *   u64 acc;
- *   u32 spefscr;
- * }
- */
-
-/*
- * Get contents of SPE register state in task TASK.
- */
-static inline int get_evrregs(unsigned long *data, struct task_struct *task)
-{
-	int i;
-
-	if (!access_ok(VERIFY_WRITE, data, 35 * sizeof(unsigned long)))
-		return -EFAULT;
-
-	/* copy SPEFSCR */
-	if (__put_user(task->thread.spefscr, &data[34]))
-		return -EFAULT;
-
-	/* copy SPE registers EVR[0] .. EVR[31] */
-	for (i = 0; i < 32; i++, data++)
-		if (__put_user(task->thread.evr[i], data))
-			return -EFAULT;
-
-	/* copy ACC */
-	if (__put_user64(task->thread.acc, (unsigned long long *)data))
-		return -EFAULT;
-
-	return 0;
-}
-
-/*
- * Write contents of SPE register state into task TASK.
- */
-static inline int set_evrregs(struct task_struct *task, unsigned long *data)
-{
-	int i;
-
-	if (!access_ok(VERIFY_READ, data, 35 * sizeof(unsigned long)))
-		return -EFAULT;
-
-	/* copy SPEFSCR */
-	if (__get_user(task->thread.spefscr, &data[34]))
-		return -EFAULT;
-
-	/* copy SPE registers EVR[0] .. EVR[31] */
-	for (i = 0; i < 32; i++, data++)
-		if (__get_user(task->thread.evr[i], data))
-			return -EFAULT;
-	/* copy ACC */
-	if (__get_user64(task->thread.acc, (unsigned long long*)data))
-		return -EFAULT;
-
-	return 0;
-}
-#endif /* CONFIG_SPE */
-
-
 #endif /* _POWERPC_PTRACE_PPC32_H */
Index: linux-cell/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace.c	2007-05-30 15:50:42.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/ptrace.c	2007-05-30 15:51:34.000000000 +1000
@@ -41,14 +41,235 @@
 #include "ptrace-ppc32.h"
 #endif
 
-#include "ptrace-common.h"
-
 /*
  * does not yet catch signals sent when the child dies.
  * in exit.c or in signal.c.
  */
 
 /*
+ * Get contents of register REGNO in task TASK.
+ */
+unsigned long ptrace_get_reg(struct task_struct *task, int regno)
+{
+	unsigned long tmp = 0;
+
+	if (task->thread.regs == NULL)
+		return -EIO;
+
+	if (regno == PT_MSR) {
+		tmp = ((unsigned long *)task->thread.regs)[PT_MSR];
+		return PT_MUNGE_MSR(tmp, task);
+	}
+
+	if (regno < (sizeof(struct pt_regs) / sizeof(unsigned long)))
+		return ((unsigned long *)task->thread.regs)[regno];
+
+	return -EIO;
+}
+
+/*
+ * Write contents of register REGNO in task TASK.
+ */
+int ptrace_put_reg(struct task_struct *task, int regno, unsigned long data)
+{
+	if (task->thread.regs == NULL)
+		return -EIO;
+
+	if (regno <= PT_MAX_PUT_REG) {
+		if (regno == PT_MSR)
+			data = (data & MSR_DEBUGCHANGE)
+				| (task->thread.regs->msr & ~MSR_DEBUGCHANGE);
+		((unsigned long *)task->thread.regs)[regno] = data;
+		return 0;
+	}
+	return -EIO;
+}
+
+
+static int get_fpregs(void __user *data, struct task_struct *task,
+		      int has_fpscr)
+{
+	unsigned int count = has_fpscr ? 33 : 32;
+
+	if (copy_to_user(data, task->thread.fpr, count * sizeof(double)))
+		return -EFAULT;
+	return 0;
+}
+
+static int set_fpregs(void __user *data, struct task_struct *task,
+		      int has_fpscr)
+{
+	unsigned int count = has_fpscr ? 33 : 32;
+
+	if (copy_from_user(task->thread.fpr, data, count * sizeof(double)))
+		return -EFAULT;
+	return 0;
+}
+
+
+#ifdef CONFIG_ALTIVEC
+/*
+ * Get/set all the altivec registers vr0..vr31, vscr, vrsave, in one go.
+ * The transfer totals 34 quadword.  Quadwords 0-31 contain the
+ * corresponding vector registers.  Quadword 32 contains the vscr as the
+ * last word (offset 12) within that quadword.  Quadword 33 contains the
+ * vrsave as the first word (offset 0) within the quadword.
+ *
+ * This definition of the VMX state is compatible with the current PPC32
+ * ptrace interface.  This allows signal handling and ptrace to use the
+ * same structures.  This also simplifies the implementation of a bi-arch
+ * (combined (32- and 64-bit) gdb.
+ */
+
+/*
+ * Get contents of AltiVec register state in task TASK
+ */
+static int get_vrregs(unsigned long __user *data, struct task_struct *task)
+{
+	unsigned long regsize;
+
+	/* copy AltiVec registers VR[0] .. VR[31] */
+	regsize = 32 * sizeof(vector128);
+	if (copy_to_user(data, task->thread.vr, regsize))
+		return -EFAULT;
+	data += (regsize / sizeof(unsigned long));
+
+	/* copy VSCR */
+	regsize = 1 * sizeof(vector128);
+	if (copy_to_user(data, &task->thread.vscr, regsize))
+		return -EFAULT;
+	data += (regsize / sizeof(unsigned long));
+
+	/* copy VRSAVE */
+	if (put_user(task->thread.vrsave, (u32 __user *)data))
+		return -EFAULT;
+
+	return 0;
+}
+
+/*
+ * Write contents of AltiVec register state into task TASK.
+ */
+static int set_vrregs(struct task_struct *task, unsigned long __user *data)
+{
+	unsigned long regsize;
+
+	/* copy AltiVec registers VR[0] .. VR[31] */
+	regsize = 32 * sizeof(vector128);
+	if (copy_from_user(task->thread.vr, data, regsize))
+		return -EFAULT;
+	data += (regsize / sizeof(unsigned long));
+
+	/* copy VSCR */
+	regsize = 1 * sizeof(vector128);
+	if (copy_from_user(&task->thread.vscr, data, regsize))
+		return -EFAULT;
+	data += (regsize / sizeof(unsigned long));
+
+	/* copy VRSAVE */
+	if (get_user(task->thread.vrsave, (u32 __user *)data))
+		return -EFAULT;
+
+	return 0;
+}
+#endif /* CONFIG_ALTIVEC */
+
+#ifdef CONFIG_SPE
+
+/*
+ * For get_evrregs/set_evrregs functions 'data' has the following layout:
+ *
+ * struct {
+ *   u32 evr[32];
+ *   u64 acc;
+ *   u32 spefscr;
+ * }
+ */
+
+/*
+ * Get contents of SPE register state in task TASK.
+ */
+static int get_evrregs(unsigned long *data, struct task_struct *task)
+{
+	int i;
+
+	if (!access_ok(VERIFY_WRITE, data, 35 * sizeof(unsigned long)))
+		return -EFAULT;
+
+	/* copy SPEFSCR */
+	if (__put_user(task->thread.spefscr, &data[34]))
+		return -EFAULT;
+
+	/* copy SPE registers EVR[0] .. EVR[31] */
+	for (i = 0; i < 32; i++, data++)
+		if (__put_user(task->thread.evr[i], data))
+			return -EFAULT;
+
+	/* copy ACC */
+	if (__put_user64(task->thread.acc, (unsigned long long *)data))
+		return -EFAULT;
+
+	return 0;
+}
+
+/*
+ * Write contents of SPE register state into task TASK.
+ */
+static int set_evrregs(struct task_struct *task, unsigned long *data)
+{
+	int i;
+
+	if (!access_ok(VERIFY_READ, data, 35 * sizeof(unsigned long)))
+		return -EFAULT;
+
+	/* copy SPEFSCR */
+	if (__get_user(task->thread.spefscr, &data[34]))
+		return -EFAULT;
+
+	/* copy SPE registers EVR[0] .. EVR[31] */
+	for (i = 0; i < 32; i++, data++)
+		if (__get_user(task->thread.evr[i], data))
+			return -EFAULT;
+	/* copy ACC */
+	if (__get_user64(task->thread.acc, (unsigned long long*)data))
+		return -EFAULT;
+
+	return 0;
+}
+#endif /* CONFIG_SPE */
+
+
+static void set_single_step(struct task_struct *task)
+{
+	struct pt_regs *regs = task->thread.regs;
+
+	if (regs != NULL) {
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+		task->thread.dbcr0 = DBCR0_IDM | DBCR0_IC;
+		regs->msr |= MSR_DE;
+#else
+		regs->msr |= MSR_SE;
+#endif
+	}
+	set_tsk_thread_flag(task, TIF_SINGLESTEP);
+}
+
+static void clear_single_step(struct task_struct *task)
+{
+	struct pt_regs *regs = task->thread.regs;
+
+	if (regs != NULL) {
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+		task->thread.dbcr0 = 0;
+		regs->msr &= ~MSR_DE;
+#else
+		regs->msr &= ~MSR_SE;
+#endif
+	}
+	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
+}
+
+/*
  * Called by kernel/ptrace.c when detaching..
  *
  * Make sure single step bits etc are not set.
@@ -154,7 +375,7 @@ long arch_ptrace(struct task_struct *chi
 		CHECK_FULL_REGS(child->thread.regs);
 #endif
 		if (index < PT_FPR0) {
-			tmp = get_reg(child, (int) index);
+			tmp = ptrace_get_reg(child, (int) index);
 		} else {
 			flush_fp_to_thread(child);
 			tmp = ((unsigned long *)child->thread.fpr)[index - PT_FPR0];
@@ -195,7 +416,7 @@ long arch_ptrace(struct task_struct *chi
 		if (index == PT_ORIG_R3)
 			break;
 		if (index < PT_FPR0) {
-			ret = put_reg(child, index, data);
+			ret = ptrace_put_reg(child, index, data);
 		} else {
 			flush_fp_to_thread(child);
 			((unsigned long *)child->thread.fpr)[index - PT_FPR0] = data;
@@ -282,7 +503,7 @@ long arch_ptrace(struct task_struct *chi
 		}
 		ret = 0;
 		for (ui = 0; ui < PT_REGS_COUNT; ui ++) {
-			ret |= __put_user(get_reg(child, ui),
+			ret |= __put_user(ptrace_get_reg(child, ui),
 					  (unsigned long __user *) data);
 			data += sizeof(long);
 		}
@@ -305,7 +526,7 @@ long arch_ptrace(struct task_struct *chi
 			ret = __get_user(tmp, (unsigned long __user *) data);
 			if (ret)
 				break;
-			put_reg(child, ui, tmp);
+			ptrace_put_reg(child, ui, tmp);
 			data += sizeof(long);
 		}
 		break;
Index: linux-cell/arch/powerpc/kernel/ptrace32.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace32.c	2007-05-30 15:50:42.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/ptrace32.c	2007-05-30 15:51:39.000000000 +1000
@@ -34,7 +34,6 @@
 #include <asm/system.h>
 
 #include "ptrace-ppc64.h"
-#include "ptrace-common.h"
 
 /*
  * does not yet catch signals sent when the child dies.
@@ -168,7 +167,7 @@ long compat_sys_ptrace(int request, int 
 			break;
 
 		if (index < PT_FPR0) {
-			tmp = get_reg(child, index);
+			tmp = ptrace_get_reg(child, index);
 		} else {
 			flush_fp_to_thread(child);
 			/*
@@ -215,7 +214,7 @@ long compat_sys_ptrace(int request, int 
 			flush_fp_to_thread(child);
 			tmp = ((unsigned long int *)child->thread.fpr)[numReg - PT_FPR0];
 		} else { /* register within PT_REGS struct */
-			tmp = get_reg(child, numReg);
+			tmp = ptrace_get_reg(child, numReg);
 		} 
 		reg32bits = ((u32*)&tmp)[part];
 		ret = put_user(reg32bits, (u32 __user *)data);
@@ -274,7 +273,7 @@ long compat_sys_ptrace(int request, int 
 		if (index == PT_ORIG_R3)
 			break;
 		if (index < PT_FPR0) {
-			ret = put_reg(child, index, data);
+			ret = ptrace_put_reg(child, index, data);
 		} else {
 			flush_fp_to_thread(child);
 			/*
@@ -346,7 +345,7 @@ long compat_sys_ptrace(int request, int 
 		}
 		ret = 0;
 		for (ui = 0; ui < PT_REGS_COUNT; ui ++) {
-			ret |= __put_user(get_reg(child, ui),
+			ret |= __put_user(ptrace_get_reg(child, ui),
 					  (unsigned int __user *) data);
 			data += sizeof(int);
 		}
@@ -366,7 +365,7 @@ long compat_sys_ptrace(int request, int 
 			ret = __get_user(tmp, (unsigned int __user *) data);
 			if (ret)
 				break;
-			put_reg(child, ui, tmp);
+			ptrace_put_reg(child, ui, tmp);
 			data += sizeof(int);
 		}
 		break;
Index: linux-cell/include/asm-powerpc/ptrace.h
===================================================================
--- linux-cell.orig/include/asm-powerpc/ptrace.h	2007-05-30 15:50:42.000000000 +1000
+++ linux-cell/include/asm-powerpc/ptrace.h	2007-05-30 15:51:19.000000000 +1000
@@ -92,6 +92,11 @@ extern unsigned long profile_pc(struct p
 		set_thread_flag(TIF_NOERROR); \
 	} while(0)
 
+struct task_struct;
+extern unsigned long ptrace_get_reg(struct task_struct *task, int regno);
+extern int ptrace_put_reg(struct task_struct *task, int regno,
+			  unsigned long data);
+
 /*
  * We use the least-significant bit of the trap field to indicate
  * whether we have saved the full set of registers, or only a
