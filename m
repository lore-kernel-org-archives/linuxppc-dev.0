Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Tue, 29 May 2007 16:45:21 +1000
Subject: [RFC/PATCH 2/5] powerpc: Cleanup ptrace bits
Message-Id: <20070529064531.D874CDDF70@ozlabs.org>
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

The powerpc ptrace code has some weirdness, like a ptrace-common.h file that
is actually ppc64 only and some of the 32 bits code ifdef'ed inside ptrace.c.

There are also separate implementations for things like get/set_vrregs for
32 and 64 bits which is totally unnecessary.

This patch cleans that up a bit by having a ptrace-common.h which contains
really common code (and makes a lot more code common), and ptrace-ppc32.h and
ptrace-ppc64.h files that contain the few remaining different bits.

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

 arch/powerpc/kernel/ptrace-common.h |   89 +++++++---------
 arch/powerpc/kernel/ptrace-ppc32.h  |  100 ++++++++++++++++++
 arch/powerpc/kernel/ptrace-ppc64.h  |   51 +++++++++
 arch/powerpc/kernel/ptrace.c        |  198 ------------------------------------
 arch/powerpc/kernel/ptrace32.c      |    1 
 5 files changed, 197 insertions(+), 242 deletions(-)

Index: linux-cell/arch/powerpc/kernel/ptrace-common.h
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace-common.h	2007-05-29 13:05:55.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/ptrace-common.h	2007-05-29 16:22:00.000000000 +1000
@@ -1,5 +1,6 @@
 /*
  *    Copyright (c) 2002 Stephen Rothwell, IBM Coproration
+ *    Copyright (c) 2007 Benjamin Herrenschmidt, IBM Coproration
  *    Extracted from ptrace.c and ptrace32.c
  *
  * This file is subject to the terms and conditions of the GNU General
@@ -7,15 +8,8 @@
  * this archive for more details.
  */
 
-#ifndef _PPC64_PTRACE_COMMON_H
-#define _PPC64_PTRACE_COMMON_H
-
-#include <asm/system.h>
-
-/*
- * Set of msr bits that gdb can change on behalf of a process.
- */
-#define MSR_DEBUGCHANGE	(MSR_FE0 | MSR_SE | MSR_BE | MSR_FE1)
+#ifndef _POWERPC_PTRACE_COMMON_H
+#define _POWERPC_PTRACE_COMMON_H
 
 /*
  * Get contents of register REGNO in task TASK.
@@ -24,18 +18,18 @@ static inline unsigned long get_reg(stru
 {
 	unsigned long tmp = 0;
 
-	/*
-	 * Put the correct FP bits in, they might be wrong as a result
-	 * of our lazy FP restore.
-	 */
+	if (task->thread.regs == NULL)
+		return -EIO;
+
 	if (regno == PT_MSR) {
 		tmp = ((unsigned long *)task->thread.regs)[PT_MSR];
-		tmp |= task->thread.fpexc_mode;
-	} else if (regno < (sizeof(struct pt_regs) / sizeof(unsigned long))) {
-		tmp = ((unsigned long *)task->thread.regs)[regno];
+		return PT_MUNGE_MSR(tmp, task);
 	}
 
-	return tmp;
+	if (regno < (sizeof(struct pt_regs) / sizeof(unsigned long)))
+		return ((unsigned long *)task->thread.regs)[regno];
+
+	return -EIO;
 }
 
 /*
@@ -44,7 +38,10 @@ static inline unsigned long get_reg(stru
 static inline int put_reg(struct task_struct *task, int regno,
 			  unsigned long data)
 {
-	if (regno < PT_SOFTE) {
+	if (task->thread.regs == NULL)
+		return -EIO;
+
+	if (regno <= PT_MAX_PUT_REG) {
 		if (regno == PT_MSR)
 			data = (data & MSR_DEBUGCHANGE)
 				| (task->thread.regs->msr & ~MSR_DEBUGCHANGE);
@@ -54,21 +51,6 @@ static inline int put_reg(struct task_st
 	return -EIO;
 }
 
-static inline void set_single_step(struct task_struct *task)
-{
-	struct pt_regs *regs = task->thread.regs;
-	if (regs != NULL)
-		regs->msr |= MSR_SE;
-	set_tsk_thread_flag(task, TIF_SINGLESTEP);
-}
-
-static inline void clear_single_step(struct task_struct *task)
-{
-	struct pt_regs *regs = task->thread.regs;
-	if (regs != NULL)
-		regs->msr &= ~MSR_SE;
-	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
-}
 
 #ifdef CONFIG_ALTIVEC
 /*
@@ -137,25 +119,36 @@ static inline int set_vrregs(struct task
 
 	return 0;
 }
-#endif
+#endif /* CONFIG_ALTIVEC */
 
-static inline int ptrace_set_debugreg(struct task_struct *task,
-				      unsigned long addr, unsigned long data)
+static inline void set_single_step(struct task_struct *task)
 {
-	/* We only support one DABR and no IABRS at the moment */
-	if (addr > 0)
-		return -EINVAL;
+	struct pt_regs *regs = task->thread.regs;
 
-	/* The bottom 3 bits are flags */
-	if ((data & ~0x7UL) >= TASK_SIZE)
-		return -EIO;
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
 
-	/* Ensure translation is on */
-	if (data && !(data & DABR_TRANSLATION))
-		return -EIO;
+static inline void clear_single_step(struct task_struct *task)
+{
+	struct pt_regs *regs = task->thread.regs;
 
-	task->thread.dabr = data;
-	return 0;
+	if (regs != NULL) {
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+		task->thread.dbcr0 = 0;
+		regs->msr &= ~MSR_DE;
+#else
+		regs->msr &= ~MSR_SE;
+#endif
+	}
+	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
-#endif /* _PPC64_PTRACE_COMMON_H */
+#endif /* _POWERPC_PTRACE_COMMON_H */
Index: linux-cell/arch/powerpc/kernel/ptrace-ppc32.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/arch/powerpc/kernel/ptrace-ppc32.h	2007-05-29 13:05:58.000000000 +1000
@@ -0,0 +1,100 @@
+/*
+ *    Copyright (c) 2007 Benjamin Herrenschmidt, IBM Coproration
+ *    Extracted from ptrace.c and ptrace32.c
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file README.legal in the main directory of
+ * this archive for more details.
+ */
+
+#ifndef _POWERPC_PTRACE_PPC32_H
+#define _POWERPC_PTRACE_PPC32_H
+
+/*
+ * Set of msr bits that gdb can change on behalf of a process.
+ */
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+#define MSR_DEBUGCHANGE	0
+#else
+#define MSR_DEBUGCHANGE	(MSR_SE | MSR_BE)
+#endif
+
+/*
+ * Max register writeable via put_reg
+ */
+#define PT_MAX_PUT_REG	PT_MQ
+
+/*
+ * Munging of MSR on return from get_regs
+ *
+ * Nothing to do on ppc32
+ */
+#define PT_MUNGE_MSR(msr, task)	(msr)
+
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
+static inline int get_evrregs(unsigned long *data, struct task_struct *task)
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
+static inline int set_evrregs(struct task_struct *task, unsigned long *data)
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
+#endif /* _POWERPC_PTRACE_PPC32_H */
Index: linux-cell/arch/powerpc/kernel/ptrace-ppc64.h
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ linux-cell/arch/powerpc/kernel/ptrace-ppc64.h	2007-05-29 13:05:58.000000000 +1000
@@ -0,0 +1,51 @@
+/*
+ *    Copyright (c) 2002 Stephen Rothwell, IBM Coproration
+ *    Extracted from ptrace.c and ptrace32.c
+ *
+ * This file is subject to the terms and conditions of the GNU General
+ * Public License.  See the file README.legal in the main directory of
+ * this archive for more details.
+ */
+
+#ifndef _POWERPC_PTRACE_PPC64_H
+#define _POWERPC_PTRACE_PPC64_H
+
+/*
+ * Set of msr bits that gdb can change on behalf of a process.
+ */
+#define MSR_DEBUGCHANGE	(MSR_FE0 | MSR_SE | MSR_BE | MSR_FE1)
+
+/*
+ * Max register writeable via put_reg
+ */
+#define PT_MAX_PUT_REG	PT_CCR
+
+/*
+ * Munging of MSR on return from get_regs
+ *
+ * Put the correct FP bits in, they might be wrong as a result
+ * of our lazy FP restore.
+ */
+
+#define PT_MUNGE_MSR(msr, task)	({ (msr) | (task)->thread.fpexc_mode; })
+
+static inline int ptrace_set_debugreg(struct task_struct *task,
+				      unsigned long addr, unsigned long data)
+{
+	/* We only support one DABR and no IABRS at the moment */
+	if (addr > 0)
+		return -EINVAL;
+
+	/* The bottom 3 bits are flags */
+	if ((data & ~0x7UL) >= TASK_SIZE)
+		return -EIO;
+
+	/* Ensure translation is on */
+	if (data && !(data & DABR_TRANSLATION))
+		return -EIO;
+
+	task->thread.dabr = data;
+	return 0;
+}
+
+#endif /* _POWERPC_PTRACE_PPC64_H */
Index: linux-cell/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace.c	2007-05-29 13:05:55.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/ptrace.c	2007-05-29 16:21:50.000000000 +1000
@@ -36,208 +36,18 @@
 #include <asm/system.h>
 
 #ifdef CONFIG_PPC64
-#include "ptrace-common.h"
-#endif
-
-#ifdef CONFIG_PPC32
-/*
- * Set of msr bits that gdb can change on behalf of a process.
- */
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
-#define MSR_DEBUGCHANGE	0
+#include "ptrace-ppc64.h"
 #else
-#define MSR_DEBUGCHANGE	(MSR_SE | MSR_BE)
+#include "ptrace-ppc32.h"
 #endif
-#endif /* CONFIG_PPC32 */
+
+#include "ptrace-common.h"
 
 /*
  * does not yet catch signals sent when the child dies.
  * in exit.c or in signal.c.
  */
 
-#ifdef CONFIG_PPC32
-/*
- * Get contents of register REGNO in task TASK.
- */
-static inline unsigned long get_reg(struct task_struct *task, int regno)
-{
-	if (regno < sizeof(struct pt_regs) / sizeof(unsigned long)
-	    && task->thread.regs != NULL)
-		return ((unsigned long *)task->thread.regs)[regno];
-	return (0);
-}
-
-/*
- * Write contents of register REGNO in task TASK.
- */
-static inline int put_reg(struct task_struct *task, int regno,
-			  unsigned long data)
-{
-	if (regno <= PT_MQ && task->thread.regs != NULL) {
-		if (regno == PT_MSR)
-			data = (data & MSR_DEBUGCHANGE)
-				| (task->thread.regs->msr & ~MSR_DEBUGCHANGE);
-		((unsigned long *)task->thread.regs)[regno] = data;
-		return 0;
-	}
-	return -EIO;
-}
-
-#ifdef CONFIG_ALTIVEC
-/*
- * Get contents of AltiVec register state in task TASK
- */
-static inline int get_vrregs(unsigned long __user *data, struct task_struct *task)
-{
-	int i, j;
-
-	if (!access_ok(VERIFY_WRITE, data, 133 * sizeof(unsigned long)))
-		return -EFAULT;
-
-	/* copy AltiVec registers VR[0] .. VR[31] */
-	for (i = 0; i < 32; i++)
-		for (j = 0; j < 4; j++, data++)
-			if (__put_user(task->thread.vr[i].u[j], data))
-				return -EFAULT;
-
-	/* copy VSCR */
-	for (i = 0; i < 4; i++, data++)
-		if (__put_user(task->thread.vscr.u[i], data))
-			return -EFAULT;
-
-        /* copy VRSAVE */
-	if (__put_user(task->thread.vrsave, data))
-		return -EFAULT;
-
-	return 0;
-}
-
-/*
- * Write contents of AltiVec register state into task TASK.
- */
-static inline int set_vrregs(struct task_struct *task, unsigned long __user *data)
-{
-	int i, j;
-
-	if (!access_ok(VERIFY_READ, data, 133 * sizeof(unsigned long)))
-		return -EFAULT;
-
-	/* copy AltiVec registers VR[0] .. VR[31] */
-	for (i = 0; i < 32; i++)
-		for (j = 0; j < 4; j++, data++)
-			if (__get_user(task->thread.vr[i].u[j], data))
-				return -EFAULT;
-
-	/* copy VSCR */
-	for (i = 0; i < 4; i++, data++)
-		if (__get_user(task->thread.vscr.u[i], data))
-			return -EFAULT;
-
-	/* copy VRSAVE */
-	if (__get_user(task->thread.vrsave, data))
-		return -EFAULT;
-
-	return 0;
-}
-#endif
-
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
-static inline void
-set_single_step(struct task_struct *task)
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
-static inline void
-clear_single_step(struct task_struct *task)
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
-#endif /* CONFIG_PPC32 */
-
 /*
  * Called by kernel/ptrace.c when detaching..
  *
Index: linux-cell/arch/powerpc/kernel/ptrace32.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace32.c	2007-05-29 13:05:55.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/ptrace32.c	2007-05-29 16:21:50.000000000 +1000
@@ -33,6 +33,7 @@
 #include <asm/pgtable.h>
 #include <asm/system.h>
 
+#include "ptrace-ppc64.h"
 #include "ptrace-common.h"
 
 /*
