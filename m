Return-Path: <galak@linen.sps.mot.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 24FBE2BDB5
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  1 Dec 2004 08:21:47 +1100 (EST)
Received: from il06exr04.mot.com (il06exr04.mot.com [129.188.137.134])
	by motgate8.mot.com (Motorola/Motgate8) with ESMTP id iAULNCNi017118
	for <linuxppc-embedded@ozlabs.org>;
	Tue, 30 Nov 2004 14:23:12 -0700 (MST)
Received: from linen.sps.mot.com (linen.sps.mot.com [10.82.19.0])
	by il06exr04.mot.com (Motorola/il06exr04) with ESMTP id iAULKI40009851
	for <linuxppc-embedded@ozlabs.org>; Tue, 30 Nov 2004 15:20:18 -0600
Date: Tue, 30 Nov 2004 15:21:23 -0600 (CST)
From: Kumar Gala <galak@linen.sps.mot.com>
To: akpm@osdl.org
Message-ID: <Pine.LNX.4.61.0411301517300.15307@linen.sps.mot.com>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-embedded@ozlabs.org
Subject: [PATCH][PPC32] Performance Monitor/Oprofile support for e500
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

Andrew,

Adds oprofile support for the e500 PowerPC core.

Signed-off-by: Andy Fleming <afleming@freescale.com>
Signed-off-by: Kumar Gala <kumar.gala@freescale.com>

--

diff -Nru a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
--- a/arch/ppc/kernel/Makefile	2004-11-29 15:04:37 -06:00
+++ b/arch/ppc/kernel/Makefile	2004-11-29 15:04:37 -06:00
@@ -14,7 +14,7 @@
 obj-y				:= entry.o traps.o irq.o idle.o time.o misc.o \
 					process.o signal.o ptrace.o align.o \
 					semaphore.o syscalls.o setup.o \
-					cputable.o ppc_htab.o
+					cputable.o ppc_htab.o perfmon.o
 obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
 obj-$(CONFIG_POWER4)		+= cpu_setup_power4.o
 obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
@@ -24,6 +24,7 @@
 obj-$(CONFIG_SMP)		+= smp.o smp-tbsync.o
 obj-$(CONFIG_TAU)		+= temp.o
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
+obj-$(CONFIG_FSL_BOOKE)		+= perfmon_fsl_booke.o
 
 ifndef CONFIG_MATH_EMULATION
 obj-$(CONFIG_8xx)		+= softemu8xx.o
diff -Nru a/arch/ppc/kernel/head_e500.S b/arch/ppc/kernel/head_e500.S
--- a/arch/ppc/kernel/head_e500.S	2004-11-29 15:04:37 -06:00
+++ b/arch/ppc/kernel/head_e500.S	2004-11-29 15:04:37 -06:00
@@ -666,7 +666,8 @@
 	EXCEPTION(0x2050, SPEFloatingPointRound, UnknownException, EXC_XFER_EE)
 
 	/* Performance Monitor */
-	EXCEPTION(0x2060, PerformanceMonitor, UnknownException, EXC_XFER_EE)
+	EXCEPTION(0x2060, PerformanceMonitor, PerformanceMonitorException, EXC_XFER_STD)
+
 
 	/* Debug Interrupt */
 	DEBUG_EXCEPTION
diff -Nru a/arch/ppc/kernel/perfmon.c b/arch/ppc/kernel/perfmon.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/kernel/perfmon.c	2004-11-29 15:04:37 -06:00
@@ -0,0 +1,94 @@
+/* kernel/perfmon.c
+ * PPC 32 Performance Monitor Infrastructure
+ *
+ * Author: Andy Fleming
+ * Copyright (c) 2004 Freescale Semiconductor, Inc
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */ 
+
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+#include <linux/ptrace.h>
+#include <linux/slab.h>
+#include <linux/user.h>
+#include <linux/a.out.h>
+#include <linux/interrupt.h>
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/prctl.h>
+
+#include <asm/pgtable.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/reg.h>
+#include <asm/xmon.h>
+
+/* A lock to regulate grabbing the interrupt */
+spinlock_t perfmon_lock = SPIN_LOCK_UNLOCKED;
+
+#ifdef CONFIG_FSL_BOOKE
+static void dummy_perf(struct pt_regs *regs)
+{
+	unsigned int pmgc0 = mfpmr(PMRN_PMGC0);
+
+	pmgc0 &= ~PMGC0_PMIE;
+	mtpmr(PMRN_PMGC0, pmgc0);
+}
+
+#else
+/* Ensure exceptions are disabled */
+#define MMCR0_PMXE      (1UL << (31 - 5))
+
+static void dummy_perf(struct pt_regs *regs)
+{
+	unsigned int mmcr0 = mfspr(SPRN_MMCR0);
+
+	mmcr0 &= ~MMCR0_PMXE;
+	mtspr(SPRN_MMCR0, mmcr0);
+}
+#endif
+
+void (*perf_irq)(struct pt_regs *) = dummy_perf;
+
+/* Grab the interrupt, if it's free.
+ * Returns 0 on success, -1 if the interrupt is taken already */
+int request_perfmon_irq(void (*handler)(struct pt_regs *))
+{
+	int err = 0;
+
+	spin_lock(&perfmon_lock);
+
+	if (perf_irq == dummy_perf)
+		perf_irq = handler;
+	else {
+		pr_info("perfmon irq already handled by %p\n", perf_irq);
+		err = -1;
+	}
+
+	spin_unlock(&perfmon_lock);
+
+	return err;
+}
+
+void free_perfmon_irq(void)
+{
+	spin_lock(&perfmon_lock);
+
+	perf_irq = dummy_perf;
+
+	spin_unlock(&perfmon_lock);
+}
+
+EXPORT_SYMBOL(perf_irq);
+EXPORT_SYMBOL(request_perfmon_irq);
+EXPORT_SYMBOL(free_perfmon_irq);
diff -Nru a/arch/ppc/kernel/perfmon_fsl_booke.c b/arch/ppc/kernel/perfmon_fsl_booke.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/kernel/perfmon_fsl_booke.c	2004-11-29 15:04:37 -06:00
@@ -0,0 +1,230 @@
+/* kernel/perfmon_fsl_booke.c
+ * Freescale Book-E Performance Monitor code
+ *
+ * Author: Andy Fleming
+ * Copyright (c) 2004 Freescale Semiconductor, Inc
+ *
+ *  This program is free software; you can redistribute it and/or
+ *  modify it under the terms of the GNU General Public License
+ *  as published by the Free Software Foundation; either version
+ *  2 of the License, or (at your option) any later version.
+ */ 
+
+#include <linux/errno.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/mm.h>
+#include <linux/stddef.h>
+#include <linux/unistd.h>
+#include <linux/ptrace.h>
+#include <linux/slab.h>
+#include <linux/user.h>
+#include <linux/a.out.h>
+#include <linux/interrupt.h>
+#include <linux/config.h>
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/prctl.h>
+
+#include <asm/pgtable.h>
+#include <asm/uaccess.h>
+#include <asm/system.h>
+#include <asm/io.h>
+#include <asm/reg.h>
+#include <asm/xmon.h>
+
+void init_pmc_stop(int ctr);
+void set_pmc_event(int ctr, int event);
+void set_pmc_user_kernel(int ctr, int user, int kernel);
+void set_pmc_marked(int ctr, int mark0, int mark1);
+void pmc_start_ctr(int ctr, int enable);
+void pmc_start_ctrs(int enable);
+void pmc_stop_ctrs(void);
+void dump_pmcs(void);
+
+static inline u32 get_pmlca(int ctr);
+static inline void set_pmlca(int ctr, u32 pmlca);
+
+static inline u32 get_pmlca(int ctr)
+{
+	u32 pmlca;
+
+	switch (ctr) {
+		case 0:
+			pmlca = mfpmr(PMRN_PMLCA0);
+			break;
+		case 1:
+			pmlca = mfpmr(PMRN_PMLCA1);
+			break;
+		case 2:
+			pmlca = mfpmr(PMRN_PMLCA2);
+			break;
+		case 3:
+			pmlca = mfpmr(PMRN_PMLCA3);
+			break;
+		default:
+			panic("Bad ctr number\n");
+	}
+
+	return pmlca;
+}
+
+static inline void set_pmlca(int ctr, u32 pmlca)
+{
+	switch (ctr) {
+		case 0:
+			mtpmr(PMRN_PMLCA0, pmlca);
+			break;
+		case 1:
+			mtpmr(PMRN_PMLCA1, pmlca);
+			break;
+		case 2:
+			mtpmr(PMRN_PMLCA2, pmlca);
+			break;
+		case 3:
+			mtpmr(PMRN_PMLCA3, pmlca);
+			break;
+		default:
+			panic("Bad ctr number\n");
+	}
+}
+
+void init_pmc_stop(int ctr)
+{
+	u32 pmlca = (PMLCA_FC | PMLCA_FCS | PMLCA_FCU |
+			PMLCA_FCM1 | PMLCA_FCM0);
+	u32 pmlcb = 0;
+
+	switch (ctr) {
+		case 0:
+			mtpmr(PMRN_PMLCA0, pmlca);
+			mtpmr(PMRN_PMLCB0, pmlcb);
+			break;
+		case 1:
+			mtpmr(PMRN_PMLCA1, pmlca);
+			mtpmr(PMRN_PMLCB1, pmlcb);
+			break;
+		case 2:
+			mtpmr(PMRN_PMLCA2, pmlca);
+			mtpmr(PMRN_PMLCB2, pmlcb);
+			break;
+		case 3:
+			mtpmr(PMRN_PMLCA3, pmlca);
+			mtpmr(PMRN_PMLCB3, pmlcb);
+			break;
+		default:
+			panic("Bad ctr number!\n");
+	}
+}
+
+void set_pmc_event(int ctr, int event)
+{
+	u32 pmlca;
+
+	pmlca = get_pmlca(ctr);
+
+	pmlca = (pmlca & ~PMLCA_EVENT_MASK) |
+		((event << PMLCA_EVENT_SHIFT) &
+		 PMLCA_EVENT_MASK);
+
+	set_pmlca(ctr, pmlca);
+}
+
+void set_pmc_user_kernel(int ctr, int user, int kernel)
+{
+	u32 pmlca;
+
+	pmlca = get_pmlca(ctr);
+
+	if(user)
+		pmlca &= ~PMLCA_FCU;
+	else
+		pmlca |= PMLCA_FCU;
+
+	if(kernel)
+		pmlca &= ~PMLCA_FCS;
+	else
+		pmlca |= PMLCA_FCS;
+
+	set_pmlca(ctr, pmlca);
+}
+
+void set_pmc_marked(int ctr, int mark0, int mark1)
+{
+	u32 pmlca = get_pmlca(ctr);
+
+	if(mark0)
+		pmlca &= ~PMLCA_FCM0;
+	else
+		pmlca |= PMLCA_FCM0;
+
+	if(mark1)
+		pmlca &= ~PMLCA_FCM1;
+	else
+		pmlca |= PMLCA_FCM1;
+
+	set_pmlca(ctr, pmlca);
+}
+
+void pmc_start_ctr(int ctr, int enable)
+{
+	u32 pmlca = get_pmlca(ctr);
+
+	pmlca &= ~PMLCA_FC;
+
+	if (enable)
+		pmlca |= PMLCA_CE;
+	else
+		pmlca &= ~PMLCA_CE;
+
+	set_pmlca(ctr, pmlca);
+}
+
+void pmc_start_ctrs(int enable)
+{
+	u32 pmgc0 = mfpmr(PMRN_PMGC0);
+
+	pmgc0 &= ~PMGC0_FAC;
+	pmgc0 |= PMGC0_FCECE;
+
+	if (enable)
+		pmgc0 |= PMGC0_PMIE;
+	else
+		pmgc0 &= ~PMGC0_PMIE;
+
+	mtpmr(PMRN_PMGC0, pmgc0);
+}
+
+void pmc_stop_ctrs(void)
+{
+	u32 pmgc0 = mfpmr(PMRN_PMGC0);
+
+	pmgc0 |= PMGC0_FAC;
+
+	pmgc0 &= ~(PMGC0_PMIE | PMGC0_FCECE);
+
+	mtpmr(PMRN_PMGC0, pmgc0);
+}
+
+void dump_pmcs(void)
+{
+	printk("pmgc0: %x\n", mfpmr(PMRN_PMGC0));
+	printk("pmc\t\tpmlca\t\tpmlcb\n");
+	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC0),
+			mfpmr(PMRN_PMLCA0), mfpmr(PMRN_PMLCB0));
+	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC1),
+			mfpmr(PMRN_PMLCA1), mfpmr(PMRN_PMLCB1));
+	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC2),
+			mfpmr(PMRN_PMLCA2), mfpmr(PMRN_PMLCB2));
+	printk("%8x\t%8x\t%8x\n", mfpmr(PMRN_PMC3),
+			mfpmr(PMRN_PMLCA3), mfpmr(PMRN_PMLCB3));
+}
+
+EXPORT_SYMBOL(init_pmc_stop);
+EXPORT_SYMBOL(set_pmc_event);
+EXPORT_SYMBOL(set_pmc_user_kernel);
+EXPORT_SYMBOL(set_pmc_marked);
+EXPORT_SYMBOL(pmc_start_ctr);
+EXPORT_SYMBOL(pmc_start_ctrs);
+EXPORT_SYMBOL(pmc_stop_ctrs);
+EXPORT_SYMBOL(dump_pmcs);
diff -Nru a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
--- a/arch/ppc/kernel/traps.c	2004-11-29 15:04:37 -06:00
+++ b/arch/ppc/kernel/traps.c	2004-11-29 15:04:37 -06:00
@@ -71,6 +71,7 @@
  * Trap & Exception support
  */
 
+extern void (*perf_irq)(struct pt_regs *);
 
 spinlock_t die_lock = SPIN_LOCK_UNLOCKED;
 
@@ -725,6 +726,11 @@
 	}
 }
 #endif /* CONFIG_ALTIVEC */
+
+void PerformanceMonitorException(struct pt_regs *regs)
+{
+	perf_irq(regs);
+}
 
 #ifdef CONFIG_FSL_BOOKE
 void CacheLockingException(struct pt_regs *regs, unsigned long address,
diff -Nru a/arch/ppc/oprofile/Makefile b/arch/ppc/oprofile/Makefile
--- a/arch/ppc/oprofile/Makefile	2004-11-29 15:04:37 -06:00
+++ b/arch/ppc/oprofile/Makefile	2004-11-29 15:04:37 -06:00
@@ -6,4 +6,4 @@
 		oprofilefs.o oprofile_stats.o \
 		timer_int.o )
 
-oprofile-y := $(DRIVER_OBJS) init.o
+oprofile-y := $(DRIVER_OBJS) common.o op_model_fsl_booke.o
diff -Nru a/arch/ppc/oprofile/common.c b/arch/ppc/oprofile/common.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/oprofile/common.c	2004-11-29 15:04:37 -06:00
@@ -0,0 +1,163 @@
+/*
+ * PPC 32 oprofile support
+ * Based on PPC64 oprofile support
+ * Copyright (C) 2004 Anton Blanchard <anton@au.ibm.com>, IBM
+ *
+ * Copyright (C) Freescale Semiconductor, Inc 2004
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
+#include <linux/slab.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/errno.h>
+#include <asm/ptrace.h>
+#include <asm/system.h>
+#include <asm/perfmon.h>
+#include <asm/cputable.h>
+
+#include "op_impl.h"
+
+extern struct op_ppc32_model op_model_fsl_booke;
+static struct op_ppc32_model *model;
+
+static struct op_counter_config ctr[OP_MAX_COUNTER];
+static struct op_system_config sys;
+
+static void op_handle_interrupt(struct pt_regs *regs)
+{
+	model->handle_interrupt(regs, ctr);
+}
+
+static int op_ppc32_setup(void)
+{
+	/* Install our interrupt handler into the existing hook.  */
+	if(request_perfmon_irq(&op_handle_interrupt))
+		return -EBUSY;
+
+	mb();
+
+	/* Pre-compute the values to stuff in the hardware registers.  */
+	model->reg_setup(ctr, &sys, model->num_counters);
+
+#if 0
+	/* FIXME: Make multi-cpu work */
+	/* Configure the registers on all cpus.  */
+	on_each_cpu(model->reg_setup, NULL, 0, 1);
+#endif
+
+	return 0;
+}
+
+static void op_ppc32_shutdown(void)
+{
+	mb();
+
+	/* Remove our interrupt handler. We may be removing this module. */
+	free_perfmon_irq();
+}
+
+static void op_ppc32_cpu_start(void *dummy)
+{
+	model->start(ctr);
+}
+
+static int op_ppc32_start(void)
+{
+	on_each_cpu(op_ppc32_cpu_start, NULL, 0, 1);
+	return 0;
+}
+
+static inline void op_ppc32_cpu_stop(void *dummy)
+{
+	model->stop();
+}
+
+static void op_ppc32_stop(void)
+{
+	on_each_cpu(op_ppc32_cpu_stop, NULL, 0, 1);
+}
+
+static int op_ppc32_create_files(struct super_block *sb, struct dentry *root)
+{
+	int i;
+
+	for (i = 0; i < model->num_counters; ++i) {
+		struct dentry *dir;
+		char buf[3];
+
+		snprintf(buf, sizeof buf, "%d", i);
+		dir = oprofilefs_mkdir(sb, root, buf);
+
+		oprofilefs_create_ulong(sb, dir, "enabled", &ctr[i].enabled);
+		oprofilefs_create_ulong(sb, dir, "event", &ctr[i].event);
+		oprofilefs_create_ulong(sb, dir, "count", &ctr[i].count);
+		oprofilefs_create_ulong(sb, dir, "kernel", &ctr[i].kernel);
+		oprofilefs_create_ulong(sb, dir, "user", &ctr[i].user);
+
+		/* FIXME: Not sure if this is used */
+		oprofilefs_create_ulong(sb, dir, "unit_mask", &ctr[i].unit_mask);
+	}
+
+	oprofilefs_create_ulong(sb, root, "enable_kernel", &sys.enable_kernel);
+	oprofilefs_create_ulong(sb, root, "enable_user", &sys.enable_user);
+
+	/* Default to tracing both kernel and user */
+	sys.enable_kernel = 1;
+	sys.enable_user = 1;
+
+	return 0;
+}
+
+static struct oprofile_operations oprof_ppc32_ops = {
+	.create_files	= op_ppc32_create_files,
+	.setup		= op_ppc32_setup,
+	.shutdown	= op_ppc32_shutdown,
+	.start		= op_ppc32_start,
+	.stop		= op_ppc32_stop,
+	.cpu_type	= NULL		/* To be filled in below. */
+};
+
+int __init oprofile_arch_init(struct oprofile_operations **ops)
+{
+	char *name;
+	int cpu_id = smp_processor_id();
+
+#ifdef CONFIG_FSL_BOOKE
+	model = &op_model_fsl_booke;
+#else
+	printk(KERN_ERR "oprofile enabled on unsupported processor!\n");
+	return -ENODEV;
+#endif
+
+	name = kmalloc(32, GFP_KERNEL);
+
+	if (NULL == name)
+		return -ENOMEM;
+
+	sprintf(name, "ppc/%s", cur_cpu_spec[cpu_id]->cpu_name);
+
+	oprof_ppc32_ops.cpu_type = name;
+
+	model->num_counters = cur_cpu_spec[cpu_id]->num_pmcs;
+
+	*ops = &oprof_ppc32_ops;
+
+	printk(KERN_INFO "oprofile: using %s performance monitoring.\n",
+	       oprof_ppc32_ops.cpu_type);
+
+	return 0;
+}
+
+void oprofile_arch_exit(void)
+{
+	kfree(oprof_ppc32_ops.cpu_type);
+	oprof_ppc32_ops.cpu_type = NULL;
+}
diff -Nru a/arch/ppc/oprofile/init.c b/arch/ppc/oprofile/init.c
--- a/arch/ppc/oprofile/init.c	2004-11-29 15:04:37 -06:00
+++ /dev/null	Wed Dec 31 16:00:00 196900
@@ -1,23 +0,0 @@
-/**
- * @file init.c
- *
- * @remark Copyright 2002 OProfile authors
- * @remark Read the file COPYING
- *
- * @author John Levon <levon@movementarian.org>
- */
-
-#include <linux/kernel.h>
-#include <linux/oprofile.h>
-#include <linux/init.h>
-#include <linux/errno.h>
-
-int __init oprofile_arch_init(struct oprofile_operations ** ops)
-{
-	return -ENODEV;
-}
-
-
-void oprofile_arch_exit(void)
-{
-}
diff -Nru a/arch/ppc/oprofile/op_impl.h b/arch/ppc/oprofile/op_impl.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/oprofile/op_impl.h	2004-11-29 15:04:37 -06:00
@@ -0,0 +1,45 @@
+/*
+ * Copyright (C) 2004 Anton Blanchard <anton@au.ibm.com>, IBM
+ *
+ * Based on alpha version.
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#ifndef OP_IMPL_H
+#define OP_IMPL_H 1
+
+#define OP_MAX_COUNTER 8
+
+/* Per-counter configuration as set via oprofilefs.  */
+struct op_counter_config {
+	unsigned long enabled;
+	unsigned long event;
+	unsigned long count;
+	unsigned long kernel;
+	unsigned long user;
+	unsigned long unit_mask;
+};
+
+/* System-wide configuration as set via oprofilefs.  */
+struct op_system_config {
+	unsigned long enable_kernel;
+	unsigned long enable_user;
+};
+
+/* Per-arch configuration */
+struct op_ppc32_model {
+	void (*reg_setup) (struct op_counter_config *,
+			   struct op_system_config *,
+			   int num_counters);
+	void (*start) (struct op_counter_config *);
+	void (*stop) (void);
+	void (*handle_interrupt) (struct pt_regs *,
+				  struct op_counter_config *);
+	int num_counters;
+};
+
+#endif /* OP_IMPL_H */
diff -Nru a/arch/ppc/oprofile/op_model_fsl_booke.c b/arch/ppc/oprofile/op_model_fsl_booke.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/oprofile/op_model_fsl_booke.c	2004-11-29 15:04:37 -06:00
@@ -0,0 +1,185 @@
+/*
+ * oprofile/op_model_e500.c
+ *
+ * Freescale Book-E oprofile support, based on ppc64 oprofile support
+ * Copyright (C) 2004 Anton Blanchard <anton@au.ibm.com>, IBM
+ *
+ * Copyright (c) 2004 Freescale Semiconductor, Inc
+ *
+ * Author: Andy Fleming
+ * Maintainer: Kumar Gala <Kumar.Gala@freescale.com>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/oprofile.h>
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <asm/ptrace.h>
+#include <asm/system.h>
+#include <asm/processor.h>
+#include <asm/cputable.h>
+#include <asm/reg_booke.h>
+#include <asm/page.h>
+#include <asm/perfmon.h>
+
+#include "op_impl.h"
+
+static unsigned long reset_value[OP_MAX_COUNTER];
+
+static int num_counters;
+static int oprofile_running;
+
+static inline unsigned int ctr_read(unsigned int i)
+{
+	switch(i) {
+		case 0:
+			return mfpmr(PMRN_PMC0);
+		case 1:
+			return mfpmr(PMRN_PMC1);
+		case 2:
+			return mfpmr(PMRN_PMC2);
+		case 3:
+			return mfpmr(PMRN_PMC3);
+		default:
+			return 0;
+	}
+}
+
+static inline void ctr_write(unsigned int i, unsigned int val)
+{
+	switch(i) {
+		case 0:
+			mtpmr(PMRN_PMC0, val);
+			break;
+		case 1:
+			mtpmr(PMRN_PMC1, val);
+			break;
+		case 2:
+			mtpmr(PMRN_PMC2, val);
+			break;
+		case 3:
+			mtpmr(PMRN_PMC3, val);
+			break;
+		default:
+			break;
+	}
+}
+
+
+static void fsl_booke_reg_setup(struct op_counter_config *ctr,
+			     struct op_system_config *sys,
+			     int num_ctrs)
+{
+	int i;
+
+	num_counters = num_ctrs;
+
+	/* freeze all counters */
+	pmc_stop_ctrs();
+
+	/* Our counters count up, and "count" refers to
+	 * how much before the next interrupt, and we interrupt
+	 * on overflow.  So we calculate the starting value
+	 * which will give us "count" until overflow.
+	 * Then we set the events on the enabled counters */
+	for (i = 0; i < num_counters; ++i) {
+		reset_value[i] = 0x80000000UL - ctr[i].count;
+
+		init_pmc_stop(i);
+
+		set_pmc_event(i, ctr[i].event);
+
+		set_pmc_user_kernel(i, ctr[i].user, ctr[i].kernel);
+	}
+}
+
+static void fsl_booke_start(struct op_counter_config *ctr)
+{
+	int i;
+
+	mtmsr(mfmsr() | MSR_PMM);
+
+	for (i = 0; i < num_counters; ++i) {
+		if (ctr[i].enabled) {
+			ctr_write(i, reset_value[i]);
+			/* Set Each enabled counterd to only
+			 * count when the Mark bit is not set */
+			set_pmc_marked(i, 1, 0);
+			pmc_start_ctr(i, 1);
+		} else {
+			ctr_write(i, 0);
+
+			/* Set the ctr to be stopped */
+			pmc_start_ctr(i, 0);
+		}
+	}
+
+	/* Clear the freeze bit, and enable the interrupt.
+	 * The counters won't actually start until the rfi clears
+	 * the PMM bit */
+	pmc_start_ctrs(1);
+
+	oprofile_running = 1;
+
+	pr_debug("start on cpu %d, pmgc0 %x\n", smp_processor_id(),
+			mfpmr(PMRN_PMGC0));
+}
+
+static void fsl_booke_stop(void)
+{
+	/* freeze counters */
+	pmc_stop_ctrs();
+
+	oprofile_running = 0;
+
+	pr_debug("stop on cpu %d, pmgc0 %x\n", smp_processor_id(),
+			mfpmr(PMRN_PMGC0));
+
+	mb();
+}
+
+
+static void fsl_booke_handle_interrupt(struct pt_regs *regs,
+				    struct op_counter_config *ctr)
+{
+	unsigned long pc;
+	int is_kernel;
+	int val;
+	int i;
+	unsigned int cpu = smp_processor_id();
+
+	/* set the PMM bit (see comment below) */
+	mtmsr(mfmsr() | MSR_PMM);
+
+	pc = regs->nip;
+	is_kernel = (pc >= KERNELBASE);
+
+	for (i = 0; i < num_counters; ++i) {
+		val = ctr_read(i);
+		if (val < 0) {
+			if (oprofile_running && ctr[i].enabled) {
+				oprofile_add_sample(pc, is_kernel, i, cpu);
+				ctr_write(i, reset_value[i]);
+			} else {
+				ctr_write(i, 0);
+			}
+		}
+	}
+
+	/* The freeze bit was set by the interrupt. */
+	/* Clear the freeze bit, and reenable the interrupt.
+	 * The counters won't actually start until the rfi clears
+	 * the PMM bit */
+	pmc_start_ctrs(1);
+}
+
+struct op_ppc32_model op_model_fsl_booke = {
+	.reg_setup		= fsl_booke_reg_setup,
+	.start			= fsl_booke_start,
+	.stop			= fsl_booke_stop,
+	.handle_interrupt	= fsl_booke_handle_interrupt,
+};
diff -Nru a/include/asm-ppc/perfmon.h b/include/asm-ppc/perfmon.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-ppc/perfmon.h	2004-11-29 15:04:37 -06:00
@@ -0,0 +1,18 @@
+#ifndef __PERFMON_H
+#define __PERFMON_H
+
+int request_perfmon_irq(void (*handler)(struct pt_regs *));
+void free_perfmon_irq(void);
+
+#ifdef CONFIG_FSL_BOOKE
+void init_pmc_stop(int ctr);
+void set_pmc_event(int ctr, int event);
+void set_pmc_user_kernel(int ctr, int user, int kernel);
+void set_pmc_marked(int ctr, int mark0, int mark1);
+void pmc_start_ctr(int ctr, int enable);
+void pmc_start_ctrs(int enable);
+void pmc_stop_ctrs(void);
+void dump_pmcs(void);
+#endif
+
+#endif /* __PERFMON_H */
diff -Nru a/include/asm-ppc/reg_booke.h b/include/asm-ppc/reg_booke.h
--- a/include/asm-ppc/reg_booke.h	2004-11-29 15:04:37 -06:00
+++ b/include/asm-ppc/reg_booke.h	2004-11-29 15:04:37 -06:00
@@ -51,6 +51,59 @@
 #define mtpmr(rn, v)	asm volatile("mtpmr " __stringify(rn) ",%0" : : "r" (v))
 #endif /* __ASSEMBLY__ */
 
+/* Freescale Book E Performance Monitor APU Registers */
+#define PMRN_PMC0	0x010	/* Performance Monitor Counter 0 */
+#define PMRN_PMC1	0x011	/* Performance Monitor Counter 1 */
+#define PMRN_PMC2	0x012	/* Performance Monitor Counter 1 */
+#define PMRN_PMC3	0x013	/* Performance Monitor Counter 1 */
+#define PMRN_PMLCA0	0x090	/* PM Local Control A0 */
+#define PMRN_PMLCA1	0x091	/* PM Local Control A1 */
+#define PMRN_PMLCA2	0x092	/* PM Local Control A2 */
+#define PMRN_PMLCA3	0x093	/* PM Local Control A3 */
+
+#define PMLCA_FC	0x80000000	/* Freeze Counter */
+#define PMLCA_FCS	0x40000000	/* Freeze in Supervisor */
+#define PMLCA_FCU	0x20000000	/* Freeze in User */
+#define PMLCA_FCM1	0x10000000	/* Freeze when PMM==1 */
+#define PMLCA_FCM0	0x08000000	/* Freeze when PMM==0 */
+#define PMLCA_CE	0x04000000	/* Condition Enable */
+
+#define PMLCA_EVENT_MASK 0x007f0000	/* Event field */
+#define PMLCA_EVENT_SHIFT	16
+
+#define PMRN_PMLCB0	0x110	/* PM Local Control B0 */
+#define PMRN_PMLCB1	0x111	/* PM Local Control B1 */
+#define PMRN_PMLCB2	0x112	/* PM Local Control B2 */
+#define PMRN_PMLCB3	0x113	/* PM Local Control B3 */
+
+#define PMLCB_THRESHMUL_MASK	0x0700	/* Threshhold Multiple Field */
+#define PMLCB_THRESHMUL_SHIFT	8
+
+#define PMLCB_THRESHOLD_MASK	0x003f	/* Threshold Field */
+#define PMLCB_THRESHOLD_SHIFT	0
+
+#define PMRN_PMGC0	0x190	/* PM Global Control 0 */
+
+#define PMGC0_FAC	0x80000000	/* Freeze all Counters */
+#define PMGC0_PMIE	0x40000000	/* Interrupt Enable */
+#define PMGC0_FCECE	0x20000000	/* Freeze countes on
+					   Enabled Condition or
+					   Event */
+
+#define PMRN_UPMC0	0x000	/* User Performance Monitor Counter 0 */
+#define PMRN_UPMC1	0x001	/* User Performance Monitor Counter 1 */
+#define PMRN_UPMC2	0x002	/* User Performance Monitor Counter 1 */
+#define PMRN_UPMC3	0x003	/* User Performance Monitor Counter 1 */
+#define PMRN_UPMLCA0	0x080	/* User PM Local Control A0 */
+#define PMRN_UPMLCA1	0x081	/* User PM Local Control A1 */
+#define PMRN_UPMLCA2	0x082	/* User PM Local Control A2 */
+#define PMRN_UPMLCA3	0x083	/* User PM Local Control A3 */
+#define PMRN_UPMLCB0	0x100	/* User PM Local Control B0 */
+#define PMRN_UPMLCB1	0x101	/* User PM Local Control B1 */
+#define PMRN_UPMLCB2	0x102	/* User PM Local Control B2 */
+#define PMRN_UPMLCB3	0x103	/* User PM Local Control B3 */
+#define PMRN_UPMGC0	0x180	/* User PM Global Control 0 */
+
 
 /* Machine State Register (MSR) Fields */
 #define MSR_UCLE	(1<<26)	/* User-mode cache lock enable */
