Return-Path: <benh@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Date: Mon, 04 Jun 2007 15:15:47 +1000
Subject: [PATCH 11/21] powerpc: ptrace shouldn't touch FP exec mode
In-Reply-To: <1180934134.603289.870346178920.qpush@grosgo>
Message-Id: <20070604051551.90F70DDEF6@ozlabs.org>
Cc: Paul Mackerras <paulus@samba.org>, Christoph Hellwig <hch@lst.de>,
	cbe-oss-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

One of the gratuituous difference between 32 and 64 bits ptrace is wether
you can whack the MSR:FE0 and FE1 bits from ptrace. This patch forbids it
unconditionally. In addition, 64 bits kernels used to return the exec mode
in the MSR on reads but not 32 bits. This patch makes it return those bits
on both.

Finally, since ptrace-ppc32.h and ptrace-ppc64.h are mostly empty now, and
since the previous patch made ptrace32.c no longer need the MSR_DEBUGCHANGE
definition, we just remove those 2 files and move back the remaining bits
to ptrace.c (they were short lived heh ?)

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

 arch/powerpc/kernel/ptrace-ppc32.h |   35 -------------------------
 arch/powerpc/kernel/ptrace-ppc64.h |   51 -------------------------------------
 arch/powerpc/kernel/ptrace.c       |   45 ++++++++++++++++++++++++++++----
 arch/powerpc/kernel/ptrace32.c     |    2 -
 4 files changed, 39 insertions(+), 94 deletions(-)

Index: linux-cell/arch/powerpc/kernel/ptrace-ppc32.h
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace-ppc32.h	2007-05-30 16:15:25.000000000 +1000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,35 +0,0 @@
-/*
- *    Copyright (c) 2007 Benjamin Herrenschmidt, IBM Coproration
- *    Extracted from ptrace.c and ptrace32.c
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file README.legal in the main directory of
- * this archive for more details.
- */
-
-#ifndef _POWERPC_PTRACE_PPC32_H
-#define _POWERPC_PTRACE_PPC32_H
-
-/*
- * Set of msr bits that gdb can change on behalf of a process.
- */
-#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
-#define MSR_DEBUGCHANGE	0
-#else
-#define MSR_DEBUGCHANGE	(MSR_SE | MSR_BE)
-#endif
-
-/*
- * Max register writeable via put_reg
- */
-#define PT_MAX_PUT_REG	PT_MQ
-
-/*
- * Munging of MSR on return from get_regs
- *
- * Nothing to do on ppc32
- */
-#define PT_MUNGE_MSR(msr, task)	(msr)
-
-
-#endif /* _POWERPC_PTRACE_PPC32_H */
Index: linux-cell/arch/powerpc/kernel/ptrace-ppc64.h
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace-ppc64.h	2007-05-30 16:15:25.000000000 +1000
+++ /dev/null	1970-01-01 00:00:00.000000000 +0000
@@ -1,51 +0,0 @@
-/*
- *    Copyright (c) 2002 Stephen Rothwell, IBM Coproration
- *    Extracted from ptrace.c and ptrace32.c
- *
- * This file is subject to the terms and conditions of the GNU General
- * Public License.  See the file README.legal in the main directory of
- * this archive for more details.
- */
-
-#ifndef _POWERPC_PTRACE_PPC64_H
-#define _POWERPC_PTRACE_PPC64_H
-
-/*
- * Set of msr bits that gdb can change on behalf of a process.
- */
-#define MSR_DEBUGCHANGE	(MSR_FE0 | MSR_SE | MSR_BE | MSR_FE1)
-
-/*
- * Max register writeable via put_reg
- */
-#define PT_MAX_PUT_REG	PT_CCR
-
-/*
- * Munging of MSR on return from get_regs
- *
- * Put the correct FP bits in, they might be wrong as a result
- * of our lazy FP restore.
- */
-
-#define PT_MUNGE_MSR(msr, task)	({ (msr) | (task)->thread.fpexc_mode; })
-
-static inline int ptrace_set_debugreg(struct task_struct *task,
-				      unsigned long addr, unsigned long data)
-{
-	/* We only support one DABR and no IABRS at the moment */
-	if (addr > 0)
-		return -EINVAL;
-
-	/* The bottom 3 bits are flags */
-	if ((data & ~0x7UL) >= TASK_SIZE)
-		return -EIO;
-
-	/* Ensure translation is on */
-	if (data && !(data & DABR_TRANSLATION))
-		return -EIO;
-
-	task->thread.dabr = data;
-	return 0;
-}
-
-#endif /* _POWERPC_PTRACE_PPC64_H */
Index: linux-cell/arch/powerpc/kernel/ptrace.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace.c	2007-05-30 16:15:39.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/ptrace.c	2007-05-30 16:29:06.000000000 +1000
@@ -35,16 +35,28 @@
 #include <asm/pgtable.h>
 #include <asm/system.h>
 
-#ifdef CONFIG_PPC64
-#include "ptrace-ppc64.h"
+/*
+ * does not yet catch signals sent when the child dies.
+ * in exit.c or in signal.c.
+ */
+
+/*
+ * Set of msr bits that gdb can change on behalf of a process.
+ */
+#if defined(CONFIG_40x) || defined(CONFIG_BOOKE)
+#define MSR_DEBUGCHANGE	0
 #else
-#include "ptrace-ppc32.h"
+#define MSR_DEBUGCHANGE	(MSR_SE | MSR_BE)
 #endif
 
 /*
- * does not yet catch signals sent when the child dies.
- * in exit.c or in signal.c.
+ * Max register writeable via put_reg
  */
+#ifdef CONFIG_PPC32
+#define PT_MAX_PUT_REG	PT_MQ
+#else
+#define PT_MAX_PUT_REG	PT_CCR
+#endif
 
 /*
  * Get contents of register REGNO in task TASK.
@@ -58,7 +70,7 @@ unsigned long ptrace_get_reg(struct task
 
 	if (regno == PT_MSR) {
 		tmp = ((unsigned long *)task->thread.regs)[PT_MSR];
-		return PT_MUNGE_MSR(tmp, task);
+		return tmp | task->thread.fpexc_mode;
 	}
 
 	if (regno < (sizeof(struct pt_regs) / sizeof(unsigned long)))
@@ -274,6 +286,27 @@ static void clear_single_step(struct tas
 	clear_tsk_thread_flag(task, TIF_SINGLESTEP);
 }
 
+#ifdef CONFIG_PPC64
+static int ptrace_set_debugreg(struct task_struct *task, unsigned long addr,
+			       unsigned long data)
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
+#endif
+
 /*
  * Called by kernel/ptrace.c when detaching..
  *
Index: linux-cell/arch/powerpc/kernel/ptrace32.c
===================================================================
--- linux-cell.orig/arch/powerpc/kernel/ptrace32.c	2007-05-30 16:15:39.000000000 +1000
+++ linux-cell/arch/powerpc/kernel/ptrace32.c	2007-05-30 16:15:40.000000000 +1000
@@ -33,8 +33,6 @@
 #include <asm/pgtable.h>
 #include <asm/system.h>
 
-#include "ptrace-ppc64.h"
-
 /*
  * does not yet catch signals sent when the child dies.
  * in exit.c or in signal.c.
