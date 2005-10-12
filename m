Return-Path: <afleming@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103]) by ozlabs.org (Postfix) with ESMTP id CF8A368515
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 13 Oct 2005 08:38:10 +1000 (EST)
Date: Wed, 12 Oct 2005 17:37:54 -0500 (CDT)
From: Andy Fleming <afleming@freescale.com>
To: Oprofile List <oprofile-list@lists.sourceforge.net>
Message-ID: <Pine.LNX.4.61.0510121735390.10159@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] Oprofile backtrace support for e500
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


Signed-off-by Andy Fleming <afleming@freescale.com>

* Added support for callgraphs (ie backtracing)

---
commit f3bcff9f931bdd36e8cd527408418ed5f3f7a85b
tree d08362251f25801221ff2c71e0371757b1fc49d0
parent 3294b2b37eb56ee4ad287776998293485a7c122e
author Andrew Fleming <afleming@freescale.com> Wed, 12 Oct 2005 16:09:23 -0500
committer Andrew Fleming <afleming@freescale.com> Wed, 12 Oct 2005 16:09:23 -0500

 arch/ppc/oprofile/Makefile             |    2 -
 arch/ppc/oprofile/backtrace.c          |  126 ++++++++++++++++++++++++++++++++
 arch/ppc/oprofile/common.c             |    6 +-
 arch/ppc/oprofile/op_model_fsl_booke.c |    7 --
 4 files changed, 133 insertions(+), 8 deletions(-)

diff --git a/arch/ppc/oprofile/Makefile b/arch/ppc/oprofile/Makefile
--- a/arch/ppc/oprofile/Makefile
+++ b/arch/ppc/oprofile/Makefile
@@ -6,7 +6,7 @@ DRIVER_OBJS := $(addprefix ../../../driv
 		oprofilefs.o oprofile_stats.o \
 		timer_int.o )
 
-oprofile-y := $(DRIVER_OBJS) common.o
+oprofile-y := $(DRIVER_OBJS) common.o backtrace.o
 
 ifeq ($(CONFIG_FSL_BOOKE),y)
 	oprofile-y += op_model_fsl_booke.o
diff --git a/arch/ppc/oprofile/backtrace.c b/arch/ppc/oprofile/backtrace.c
new file mode 100644
--- /dev/null
+++ b/arch/ppc/oprofile/backtrace.c
@@ -0,0 +1,126 @@
+/*
+ * PPC 32 oprofile support
+ * Based on PPC64 oprofile backtrace support
+ * Copyright (C) 2005 Brian Rogan <bcr6@cornell.edu>, IBM
+ *
+ * Copyright (C) Freescale Semiconductor, Inc 2005
+ *
+ * Author: Andy Fleming
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/oprofile.h>
+#include <linux/sched.h>
+#include <asm/processor.h>
+#include <asm/uaccess.h>
+
+static unsigned int user_putsp32(unsigned int sp, int *is_first) {
+	unsigned int stack_frame[2], rv;
+	unsigned long t = sp;
+
+	/* If the page isn't accessible, then we've done all that we can do,
+	 * a partial stack trace is better than none. 
+	*/
+	rv = __copy_from_user_inatomic(stack_frame, (void *) t, sizeof(stack_frame));
+	if(rv != 0) {
+		/* The most likely reason for this is that we returned -EFAULT, 
+		 * which means that we've done all that we can do from interrupt 
+		 * context.  All other errors though are equally valid reasons to
+		 * abort our backtrace. */
+		return 0;
+	}
+
+
+	/* SVR4 compliant executables have the Link Register offset by 4 bytes 
+	 * from the beginning of the stack page */
+	//printk("Link was: %p\n", stack_frame[1]);
+	if(! *is_first) {
+		oprofile_add_trace(stack_frame[1]);
+	} else {
+		*is_first = 0;
+	}
+
+	/* Sanity check to make sure that the previous stack frame is actually above
+	 * us in memory, like we would expect it to be from the PPC spec. 
+ 	 * 
+	 * The last stack pointer is always at offset 0 from the beginning of the 
+   	 * stack frame.
+	 */
+	rv = stack_frame[0];
+	if(rv > sp) {
+		return rv;
+	} else {
+		return 0;
+	}
+}
+
+static int validate_sp(unsigned long sp)
+{
+	unsigned long prev_sp;
+	unsigned long stack_top;
+
+	prev_sp = (unsigned long) (current->thread_info + 1);
+	stack_top = (unsigned long) current->thread_info + THREAD_SIZE;
+
+	if (sp > prev_sp && sp < stack_top && (sp & 3) == 0)
+		return 1;
+
+	return 0;
+}
+
+static unsigned long kernel_putsp32(unsigned long sp, int *is_first) {
+	unsigned long * stack_frame = (unsigned long *) sp;
+	unsigned long rv;
+
+	if(!validate_sp(sp)) {
+		return 0;
+	}
+
+	//printk("Link was: %p\n", stack_frame[1]);
+	if(! *is_first) {
+		/* Same as before LR is offset 4 bytes from the beginning */
+		oprofile_add_trace(stack_frame[1]);		
+	} else {
+		*is_first = 0;
+	}
+
+	rv = stack_frame[0];
+	if(rv > sp) {
+		return rv;
+	} else {
+		return 0;
+	}
+}
+
+
+void
+op_ppc32_backtrace(struct pt_regs * const regs, unsigned int depth)
+{
+	unsigned long cursp = regs->gpr[1];
+	int first_frame = 1;
+
+	//printk("backtracing\n");
+	if (!user_mode(regs)) {
+		unsigned long sp = cursp;
+		while (depth--)
+		{
+			sp = kernel_putsp32(sp, &first_frame);
+			if(!sp) {
+				break;
+			}
+		}
+		return;
+	} else {
+		unsigned long sp = cursp;	
+		while(depth--) {
+			sp = user_putsp32(sp, &first_frame);
+			if(!sp) {
+				break;
+			}
+		}
+	}
+}
diff --git a/arch/ppc/oprofile/common.c b/arch/ppc/oprofile/common.c
--- a/arch/ppc/oprofile/common.c
+++ b/arch/ppc/oprofile/common.c
@@ -84,6 +84,9 @@ static void op_ppc32_stop(void)
 	on_each_cpu(op_ppc32_cpu_stop, NULL, 0, 1);
 }
 
+extern void 
+op_ppc32_backtrace(struct pt_regs * const regs, unsigned int depth);
+
 static int op_ppc32_create_files(struct super_block *sb, struct dentry *root)
 {
 	int i;
@@ -121,7 +124,8 @@ static struct oprofile_operations oprof_
 	.shutdown	= op_ppc32_shutdown,
 	.start		= op_ppc32_start,
 	.stop		= op_ppc32_stop,
-	.cpu_type	= NULL		/* To be filled in below. */
+	.cpu_type	= NULL,		/* To be filled in below. */
+	.backtrace	= op_ppc32_backtrace,
 };
 
 int __init oprofile_arch_init(struct oprofile_operations *ops)
diff --git a/arch/ppc/oprofile/op_model_fsl_booke.c b/arch/ppc/oprofile/op_model_fsl_booke.c
--- a/arch/ppc/oprofile/op_model_fsl_booke.c
+++ b/arch/ppc/oprofile/op_model_fsl_booke.c
@@ -146,22 +146,17 @@ static void fsl_booke_stop(void)
 static void fsl_booke_handle_interrupt(struct pt_regs *regs,
 				    struct op_counter_config *ctr)
 {
-	unsigned long pc;
-	int is_kernel;
 	int val;
 	int i;
 
 	/* set the PMM bit (see comment below) */
 	mtmsr(mfmsr() | MSR_PMM);
 
-	pc = regs->nip;
-	is_kernel = (pc >= KERNELBASE);
-
 	for (i = 0; i < num_counters; ++i) {
 		val = ctr_read(i);
 		if (val < 0) {
 			if (oprofile_running && ctr[i].enabled) {
-				oprofile_add_pc(pc, is_kernel, i);
+				oprofile_add_sample(regs, i);
 				ctr_write(i, reset_value[i]);
 			} else {
 				ctr_write(i, 0);

* Removed commented code

---
commit 7f50cb2cd6153dda4d999b13418dd8e3609def5c
tree 47ddd0af393ee7cb8dfa911fe5c3d383865fc217
parent f3bcff9f931bdd36e8cd527408418ed5f3f7a85b
author Andrew Fleming <afleming@freescale.com> Wed, 12 Oct 2005 16:12:05 -0500
committer Andrew Fleming <afleming@freescale.com> Wed, 12 Oct 2005 16:12:05 -0500

 arch/ppc/oprofile/backtrace.c |    3 ---
 1 files changed, 0 insertions(+), 3 deletions(-)

diff --git a/arch/ppc/oprofile/backtrace.c b/arch/ppc/oprofile/backtrace.c
--- a/arch/ppc/oprofile/backtrace.c
+++ b/arch/ppc/oprofile/backtrace.c
@@ -37,7 +37,6 @@ static unsigned int user_putsp32(unsigne
 
 	/* SVR4 compliant executables have the Link Register offset by 4 bytes 
 	 * from the beginning of the stack page */
-	//printk("Link was: %p\n", stack_frame[1]);
 	if(! *is_first) {
 		oprofile_add_trace(stack_frame[1]);
 	} else {
@@ -80,7 +79,6 @@ static unsigned long kernel_putsp32(unsi
 		return 0;
 	}
 
-	//printk("Link was: %p\n", stack_frame[1]);
 	if(! *is_first) {
 		/* Same as before LR is offset 4 bytes from the beginning */
 		oprofile_add_trace(stack_frame[1]);		
@@ -103,7 +101,6 @@ op_ppc32_backtrace(struct pt_regs * cons
 	unsigned long cursp = regs->gpr[1];
 	int first_frame = 1;
 
-	//printk("backtracing\n");
 	if (!user_mode(regs)) {
 		unsigned long sp = cursp;
 		while (depth--)
