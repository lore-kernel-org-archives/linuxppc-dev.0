Return-Path: <anton@ozlabs.org>
Date: Mon, 27 Mar 2006 11:57:01 +1100
From: Anton Blanchard <anton@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Add oprofile calltrace support
Message-ID: <20060327005701.GC4962@krispykreme>
References: <20060327002329.GA4962@krispykreme>
	<20060327004618.GB4962@krispykreme>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20060327004618.GB4962@krispykreme>
Cc: bcr6@cornell.edu, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


From: Brian Rogan <bcr6@cornell.edu>

Add oprofile calltrace support to powerpc. Disable spinlock backtracing
now we can use calltrace info.

(Updated to work on both 32bit and 64bit by me).

Signed-off-by: Anton Blanchard <anton@samba.org>
---

This patch depends on a patch currently in -mm:

http://marc.theaimsgroup.com/?l=linux-kernel&m=114333745914386&w=2

Index: build/arch/powerpc/oprofile/backtrace.c
===================================================================
--- /dev/null	1970-01-01 00:00:00.000000000 +0000
+++ build/arch/powerpc/oprofile/backtrace.c	2006-03-26 15:13:57.000000000 +1000
@@ -0,0 +1,126 @@
+/**
+ * Copyright (C) 2005 Brian Rogan <bcr6@cornell.edu>, IBM
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+**/
+
+#include <linux/oprofile.h>
+#include <linux/sched.h>
+#include <asm/processor.h>
+#include <asm/uaccess.h>
+
+#define STACK_SP(STACK)		*(STACK)
+
+#define STACK_LR64(STACK)	*((unsigned long *)(STACK) + 2)
+#define STACK_LR32(STACK)	*((unsigned int *)(STACK) + 1)
+
+#ifdef CONFIG_PPC64
+#define STACK_LR(STACK)		STACK_LR64(STACK)
+#else
+#define STACK_LR(STACK)		STACK_LR32(STACK)
+#endif
+
+static unsigned int user_getsp32(unsigned int sp, int is_first)
+{
+	unsigned int stack_frame[2];
+
+	if (!access_ok(VERIFY_READ, sp, sizeof(stack_frame)))
+		return 0;
+
+	/*
+	 * The most likely reason for this is that we returned -EFAULT,
+	 * which means that we've done all that we can do from
+	 * interrupt context.
+	 */
+	if (__copy_from_user_inatomic(stack_frame, (void *)(long)sp,
+					sizeof(stack_frame)))
+		return 0;
+
+	if (!is_first)
+		oprofile_add_trace(STACK_LR32(stack_frame));
+
+	/*
+	 * We do not enforce increasing stack addresses here because
+	 * we may transition to a different stack, eg a signal handler.
+	 */
+	return STACK_SP(stack_frame);
+}
+
+#ifdef CONFIG_PPC64
+static unsigned long user_getsp64(unsigned long sp, int is_first)
+{
+	unsigned long stack_frame[3];
+
+	if (!access_ok(VERIFY_READ, sp, sizeof(stack_frame)))
+		return 0;
+
+	if (__copy_from_user_inatomic(stack_frame, (void *)sp,
+					sizeof(stack_frame)))
+		return 0;
+
+	if (!is_first)
+		oprofile_add_trace(STACK_LR64(stack_frame));
+
+	return STACK_SP(stack_frame);
+}
+#endif
+
+static unsigned long kernel_getsp(unsigned long sp, int is_first)
+{
+	unsigned long *stack_frame = (unsigned long *)sp;
+
+	if (!validate_sp(sp, current, STACK_FRAME_OVERHEAD))
+		return 0;
+
+	if (!is_first)
+		oprofile_add_trace(STACK_LR(stack_frame));
+
+	/*
+	 * We do not enforce increasing stack addresses here because
+	 * we might be transitioning from an interrupt stack to a kernel
+	 * stack. validate_sp() is designed to understand this, so just
+	 * use it.
+	 */
+	return STACK_SP(stack_frame);
+}
+
+void op_powerpc_backtrace(struct pt_regs * const regs, unsigned int depth)
+{
+	unsigned long sp = regs->gpr[1];
+	int first_frame = 1;
+
+	/* We ditch the top stackframe so need to loop through an extra time */
+	depth += 1;
+
+	if (!user_mode(regs)) {
+		while (depth--) {
+			sp = kernel_getsp(sp, first_frame);
+			if (!sp)
+				break;
+			first_frame = 0;
+		}
+	} else {
+#ifdef CONFIG_PPC64
+		if (!test_thread_flag(TIF_32BIT)) {
+			while (depth--) {
+				sp = user_getsp64(sp, first_frame);
+				if (!sp)
+					break;
+				first_frame = 0;
+			}
+
+			return;
+		}
+#endif
+
+		while (depth--) {
+			sp = user_getsp32(sp, first_frame);
+			if (!sp)
+				break;
+			first_frame = 0;
+		}
+	}
+}
Index: build/arch/powerpc/oprofile/common.c
===================================================================
--- build.orig/arch/powerpc/oprofile/common.c	2006-01-16 00:05:48.000000000 +1100
+++ build/arch/powerpc/oprofile/common.c	2006-03-26 13:09:34.000000000 +1000
@@ -126,8 +126,7 @@ static int op_powerpc_create_files(struc
 	sys.enable_kernel = 1;
 	sys.enable_user = 1;
 #ifdef CONFIG_PPC64
-	/* Turn on backtracing through spinlocks by default */
-	sys.backtrace_spinlocks = 1;
+	sys.backtrace_spinlocks = 0;
 #endif
 
 	return 0;
@@ -168,6 +167,7 @@ int __init oprofile_arch_init(struct opr
 	ops->shutdown = op_powerpc_shutdown;
 	ops->start = op_powerpc_start;
 	ops->stop = op_powerpc_stop;
+	ops->backtrace = op_powerpc_backtrace;
 
 	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
 	       ops->cpu_type);
Index: build/arch/powerpc/oprofile/Makefile
===================================================================
--- build.orig/arch/powerpc/oprofile/Makefile	2006-03-26 10:40:14.000000000 +1000
+++ build/arch/powerpc/oprofile/Makefile	2006-03-26 13:09:34.000000000 +1000
@@ -10,7 +10,7 @@ DRIVER_OBJS := $(addprefix ../../../driv
 		oprofilefs.o oprofile_stats.o \
 		timer_int.o )
 
-oprofile-y := $(DRIVER_OBJS) common.o
+oprofile-y := $(DRIVER_OBJS) common.o backtrace.o
 oprofile-$(CONFIG_PPC64) += op_model_rs64.o op_model_power4.o
 oprofile-$(CONFIG_FSL_BOOKE) += op_model_fsl_booke.o
 oprofile-$(CONFIG_PPC32) += op_model_7450.o
Index: build/arch/powerpc/oprofile/op_model_power4.c
===================================================================
--- build.orig/arch/powerpc/oprofile/op_model_power4.c	2006-03-24 15:51:18.000000000 +1100
+++ build/arch/powerpc/oprofile/op_model_power4.c	2006-03-26 13:09:34.000000000 +1000
@@ -293,7 +293,7 @@ static void power4_handle_interrupt(stru
 		val = ctr_read(i);
 		if (val < 0) {
 			if (oprofile_running && ctr[i].enabled) {
-				oprofile_add_pc(pc, is_kernel, i);
+				oprofile_add_ext_sample(pc, regs, i, is_kernel);
 				ctr_write(i, reset_value[i]);
 			} else {
 				ctr_write(i, 0);
Index: build/include/asm-powerpc/oprofile_impl.h
===================================================================
--- build.orig/include/asm-powerpc/oprofile_impl.h	2006-03-26 12:48:01.000000000 +1000
+++ build/include/asm-powerpc/oprofile_impl.h	2006-03-26 13:09:34.000000000 +1000
@@ -126,5 +126,7 @@ static inline void ctr_write(unsigned in
 }
 #endif /* !CONFIG_FSL_BOOKE */
 
+extern void op_powerpc_backtrace(struct pt_regs * const regs, unsigned int depth);
+
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_OPROFILE_IMPL_H */
