Return-Path: <afleming@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id 4198B68869
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Dec 2005 13:02:09 +1100 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	jBG2CsM4028852
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 19:12:54 -0700 (MST)
Received: from mailserv2.am.freescale.net (mailserv2.am.freescale.net
	[10.82.65.62])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id jBG29Ii3023045
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 20:09:19 -0600 (CST)
Received: from ld0175-tx32.am.freescale.net (ld0175-tx32 [10.82.19.125])
	by mailserv2.am.freescale.net (8.13.3/8.13.3) with ESMTP id
	jBG20vNB028663
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 20:00:58 -0600 (CST)
Received: from ld0175-tx32.am.freescale.net (localhost [127.0.0.1])
	by ld0175-tx32.am.freescale.net (Postfix) with ESMTP id D949B4F8CC
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 20:02:04 -0600 (CST)
Received: from localhost (afleming@localhost)
	by ld0175-tx32.am.freescale.net (8.12.11/8.12.11/Submit) with ESMTP id
	jBG224Rd014742
	for <linuxppc-dev@ozlabs.org>; Thu, 15 Dec 2005 20:02:04 -0600
Date: Thu, 15 Dec 2005 20:02:04 -0600 (CST)
From: Andy Fleming <afleming@freescale.com>
To: linuxppc-dev@ozlabs.org
Message-ID: <Pine.LNX.4.61.0512151953550.14329@ld0175-tx32.am.freescale.net>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Subject: [PATCH] G4+ oprofile support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds oprofile support for the 7450 and all its multitudinous 
derivatives.

Signed-off-by: Andy Fleming <afleming@freescale.com>


* Added 7450 (and derivatives) support for oprofile
* Changed e500 cputable to have oprofile model and cpu_type fields
* Added support for classic 32-bit performance monitor interrupt
* Cleaned up common powerpc oprofile code to be as common as possible
* Cleaned up oprofile_impl.h to reflect 32 bit classic code
* Added 32-bit MMCRx bitfield definitions and SPR numbers

---
commit 44e22e7c3358c79517685e7b66ffae17da6f8399
tree 2f8ee433f01d70e176b074af50fa0bca384699b8
parent 49d7bc64283970ee83d2c954d04ba00d04e5943d
author Andrew Fleming <afleming@freescale.com> Thu, 15 Dec 2005 15:36:31 -0600
committer Andrew Fleming <afleming@ld0175-tx32.(none)> Thu, 15 Dec 2005 15:36:31 -0600

 arch/powerpc/kernel/cputable.c        |   74 ++++++++++--
 arch/powerpc/kernel/head_32.S         |   12 +-
 arch/powerpc/kernel/pmc.c             |    5 +
 arch/powerpc/kernel/traps.c           |    2 
 arch/powerpc/oprofile/Makefile        |    1 
 arch/powerpc/oprofile/common.c        |   61 ++--------
 arch/powerpc/oprofile/op_model_7450.c |  206 +++++++++++++++++++++++++++++++++
 include/asm-powerpc/oprofile_impl.h   |   31 ++++-
 include/asm-powerpc/reg.h             |   36 +++++-
 9 files changed, 344 insertions(+), 84 deletions(-)

diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index 1d85ced..f7f2a83 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -545,7 +545,11 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
-		.cpu_setup		= __setup_cpu_745x
+		.cpu_setup		= __setup_cpu_745x,
+#ifdef CONFIG_OPROFILE
+		.oprofile_cpu_type      = "ppc/7450",
+		.oprofile_model         = &op_model_7450,
+#endif
 	},
 	{	/* 7450 2.1 */
 		.pvr_mask		= 0xffffffff,
@@ -556,7 +560,11 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
-		.cpu_setup		= __setup_cpu_745x
+		.cpu_setup		= __setup_cpu_745x,
+#ifdef CONFIG_OPROFILE
+		.oprofile_cpu_type      = "ppc/7450",
+		.oprofile_model         = &op_model_7450,
+#endif
 	},
 	{	/* 7450 2.3 and newer */
 		.pvr_mask		= 0xffff0000,
@@ -567,7 +575,11 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
-		.cpu_setup		= __setup_cpu_745x
+		.cpu_setup		= __setup_cpu_745x,
+#ifdef CONFIG_OPROFILE
+		.oprofile_cpu_type      = "ppc/7450",
+		.oprofile_model         = &op_model_7450,
+#endif
 	},
 	{	/* 7455 rev 1.x */
 		.pvr_mask		= 0xffffff00,
@@ -578,7 +590,11 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
-		.cpu_setup		= __setup_cpu_745x
+		.cpu_setup		= __setup_cpu_745x,
+#ifdef CONFIG_OPROFILE
+		.oprofile_cpu_type      = "ppc/7450",
+		.oprofile_model         = &op_model_7450,
+#endif
 	},
 	{	/* 7455 rev 2.0 */
 		.pvr_mask		= 0xffffffff,
@@ -589,7 +605,11 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
-		.cpu_setup		= __setup_cpu_745x
+		.cpu_setup		= __setup_cpu_745x,
+#ifdef CONFIG_OPROFILE
+		.oprofile_cpu_type      = "ppc/7450",
+		.oprofile_model         = &op_model_7450,
+#endif
 	},
 	{	/* 7455 others */
 		.pvr_mask		= 0xffff0000,
@@ -600,7 +620,11 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
-		.cpu_setup		= __setup_cpu_745x
+		.cpu_setup		= __setup_cpu_745x,
+#ifdef CONFIG_OPROFILE
+		.oprofile_cpu_type      = "ppc/7450",
+		.oprofile_model         = &op_model_7450,
+#endif
 	},
 	{	/* 7447/7457 Rev 1.0 */
 		.pvr_mask		= 0xffffffff,
@@ -611,7 +635,11 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
-		.cpu_setup		= __setup_cpu_745x
+		.cpu_setup		= __setup_cpu_745x,
+#ifdef CONFIG_OPROFILE
+		.oprofile_cpu_type      = "ppc/7450",
+		.oprofile_model         = &op_model_7450,
+#endif
 	},
 	{	/* 7447/7457 Rev 1.1 */
 		.pvr_mask		= 0xffffffff,
@@ -622,7 +650,11 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
-		.cpu_setup		= __setup_cpu_745x
+		.cpu_setup		= __setup_cpu_745x,
+#ifdef CONFIG_OPROFILE
+		.oprofile_cpu_type      = "ppc/7450",
+		.oprofile_model         = &op_model_7450,
+#endif
 	},
 	{	/* 7447/7457 Rev 1.2 and later */
 		.pvr_mask		= 0xffff0000,
@@ -633,7 +665,11 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
-		.cpu_setup		= __setup_cpu_745x
+		.cpu_setup		= __setup_cpu_745x,
+#ifdef CONFIG_OPROFILE
+		.oprofile_cpu_type      = "ppc/7450",
+		.oprofile_model         = &op_model_7450,
+#endif
 	},
 	{	/* 7447A */
 		.pvr_mask		= 0xffff0000,
@@ -644,7 +680,11 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
-		.cpu_setup		= __setup_cpu_745x
+		.cpu_setup		= __setup_cpu_745x,
+#ifdef CONFIG_OPROFILE
+		.oprofile_cpu_type      = "ppc/7450",
+		.oprofile_model         = &op_model_7450,
+#endif
 	},
 	{	/* 7448 */
 		.pvr_mask		= 0xffff0000,
@@ -655,7 +695,11 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 6,
-		.cpu_setup		= __setup_cpu_745x
+		.cpu_setup		= __setup_cpu_745x,
+#ifdef CONFIG_OPROFILE
+		.oprofile_cpu_type      = "ppc/7450",
+		.oprofile_model         = &op_model_7450,
+#endif
 	},
 	{	/* 82xx (8240, 8245, 8260 are all 603e cores) */
 		.pvr_mask		= 0x7fff0000,
@@ -979,6 +1023,10 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
+#ifdef CONFIG_OPROFILE
+		.oprofile_cpu_type	= "ppc/e500",
+		.oprofile_model		= &op_model_fsl_booke,
+#endif
 	},
 	{	/* e500v2 */
 		.pvr_mask		= 0xffff0000,
@@ -992,6 +1040,10 @@ struct cpu_spec	cpu_specs[] = {
 		.icache_bsize		= 32,
 		.dcache_bsize		= 32,
 		.num_pmcs		= 4,
+#ifdef CONFIG_OPROFILE
+		.oprofile_cpu_type	= "ppc/e500",
+		.oprofile_model		= &op_model_fsl_booke,
+#endif
 	},
 #endif
 #if !CLASSIC_PPC
diff --git a/arch/powerpc/kernel/head_32.S b/arch/powerpc/kernel/head_32.S
index ccdf947..34ff064 100644
--- a/arch/powerpc/kernel/head_32.S
+++ b/arch/powerpc/kernel/head_32.S
@@ -450,16 +450,11 @@ SystemCall:
  * by executing an altivec instruction.
  */
 	. = 0xf00
-	b	Trap_0f
+	b	PerformanceMonitor
 
 	. = 0xf20
 	b	AltiVecUnavailable
 
-Trap_0f:
-	EXCEPTION_PROLOG
-	addi	r3,r1,STACK_FRAME_OVERHEAD
-	EXC_XFER_EE(0xf00, unknown_exception)
-
 /*
  * Handle TLB miss for instruction on 603/603e.
  * Note: we get an alternate set of r0 - r3 to use automatically.
@@ -703,6 +698,11 @@ AltiVecUnavailable:
 #endif /* CONFIG_ALTIVEC */
 	EXC_XFER_EE_LITE(0xf20, altivec_unavailable_exception)
 
+PerformanceMonitor:
+	EXCEPTION_PROLOG
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	EXC_XFER_STD(0xf00, performance_monitor_exception)
+
 #ifdef CONFIG_ALTIVEC
 /* Note that the AltiVec support is closely modeled after the FP
  * support.  Changes to one are likely to be applicable to the
diff --git a/arch/powerpc/kernel/pmc.c b/arch/powerpc/kernel/pmc.c
index 2d333cc..e6fb194 100644
--- a/arch/powerpc/kernel/pmc.c
+++ b/arch/powerpc/kernel/pmc.c
@@ -43,8 +43,13 @@ static void dummy_perf(struct pt_regs *r
 	mtspr(SPRN_MMCR0, mmcr0);
 }
 #else
+/* Ensure exceptions are disabled */
 static void dummy_perf(struct pt_regs *regs)
 {
+	unsigned int mmcr0 = mfspr(SPRN_MMCR0);
+
+	mmcr0 &= ~(MMCR0_PMXE);
+	mtspr(SPRN_MMCR0, mmcr0);
 }
 #endif
 
diff --git a/arch/powerpc/kernel/traps.c b/arch/powerpc/kernel/traps.c
index 1511454..8c91369 100644
--- a/arch/powerpc/kernel/traps.c
+++ b/arch/powerpc/kernel/traps.c
@@ -886,12 +886,10 @@ void altivec_unavailable_exception(struc
 	die("Unrecoverable VMX/Altivec Unavailable Exception", regs, SIGABRT);
 }
 
-#if defined(CONFIG_PPC64) || defined(CONFIG_E500)
 void performance_monitor_exception(struct pt_regs *regs)
 {
 	perf_irq(regs);
 }
-#endif
 
 #ifdef CONFIG_8xx
 void SoftwareEmulation(struct pt_regs *regs)
diff --git a/arch/powerpc/oprofile/Makefile b/arch/powerpc/oprofile/Makefile
index 0782d0c..554cd7c 100644
--- a/arch/powerpc/oprofile/Makefile
+++ b/arch/powerpc/oprofile/Makefile
@@ -9,3 +9,4 @@ DRIVER_OBJS := $(addprefix ../../../driv
 oprofile-y := $(DRIVER_OBJS) common.o
 oprofile-$(CONFIG_PPC64) += op_model_rs64.o op_model_power4.o
 oprofile-$(CONFIG_FSL_BOOKE) += op_model_fsl_booke.o
+oprofile-$(CONFIG_PPC32) += op_model_7450.o
diff --git a/arch/powerpc/oprofile/common.c b/arch/powerpc/oprofile/common.c
index af2c05d..a370778 100644
--- a/arch/powerpc/oprofile/common.c
+++ b/arch/powerpc/oprofile/common.c
@@ -14,9 +14,6 @@
  */
 
 #include <linux/oprofile.h>
-#ifndef __powerpc64__
-#include <linux/slab.h>
-#endif /* ! __powerpc64__ */
 #include <linux/init.h>
 #include <linux/smp.h>
 #include <linux/errno.h>
@@ -31,10 +28,6 @@ static struct op_powerpc_model *model;
 static struct op_counter_config ctr[OP_MAX_COUNTER];
 static struct op_system_config sys;
 
-#ifndef __powerpc64__
-static char *cpu_type;
-#endif /* ! __powerpc64__ */
-
 static void op_handle_interrupt(struct pt_regs *regs)
 {
 	model->handle_interrupt(regs, ctr);
@@ -53,14 +46,7 @@ static int op_powerpc_setup(void)
 	model->reg_setup(ctr, &sys, model->num_counters);
 
 	/* Configure the registers on all cpus.  */
-#ifdef __powerpc64__
 	on_each_cpu(model->cpu_setup, NULL, 0, 1);
-#else /* __powerpc64__ */
-#if 0
-	/* FIXME: Make multi-cpu work */
-	on_each_cpu(model->reg_setup, NULL, 0, 1);
-#endif
-#endif /* __powerpc64__ */
 
 	return 0;
 }
@@ -95,7 +81,7 @@ static int op_powerpc_create_files(struc
 {
 	int i;
 
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 	/*
 	 * There is one mmcr0, mmcr1 and mmcra for setting the events for
 	 * all of the counters.
@@ -103,7 +89,7 @@ static int op_powerpc_create_files(struc
 	oprofilefs_create_ulong(sb, root, "mmcr0", &sys.mmcr0);
 	oprofilefs_create_ulong(sb, root, "mmcr1", &sys.mmcr1);
 	oprofilefs_create_ulong(sb, root, "mmcra", &sys.mmcra);
-#endif /* __powerpc64__ */
+#endif
 
 	for (i = 0; i < model->num_counters; ++i) {
 		struct dentry *dir;
@@ -115,65 +101,46 @@ static int op_powerpc_create_files(struc
 		oprofilefs_create_ulong(sb, dir, "enabled", &ctr[i].enabled);
 		oprofilefs_create_ulong(sb, dir, "event", &ctr[i].event);
 		oprofilefs_create_ulong(sb, dir, "count", &ctr[i].count);
-#ifdef __powerpc64__
+
 		/*
-		 * We dont support per counter user/kernel selection, but
-		 * we leave the entries because userspace expects them
+		 * Classic PowerPC doesn't support per-counter
+		 * control like this, but the options are
+		 * expected, so they remain.  For Freescale
+		 * Book-E style performance monitors, we do
+		 * support them.
 		 */
-#endif /* __powerpc64__ */
 		oprofilefs_create_ulong(sb, dir, "kernel", &ctr[i].kernel);
 		oprofilefs_create_ulong(sb, dir, "user", &ctr[i].user);
 
-#ifndef __powerpc64__
-		/* FIXME: Not sure if this is used */
-#endif /* ! __powerpc64__ */
 		oprofilefs_create_ulong(sb, dir, "unit_mask", &ctr[i].unit_mask);
 	}
 
 	oprofilefs_create_ulong(sb, root, "enable_kernel", &sys.enable_kernel);
 	oprofilefs_create_ulong(sb, root, "enable_user", &sys.enable_user);
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 	oprofilefs_create_ulong(sb, root, "backtrace_spinlocks",
 				&sys.backtrace_spinlocks);
-#endif /* __powerpc64__ */
+#endif
 
 	/* Default to tracing both kernel and user */
 	sys.enable_kernel = 1;
 	sys.enable_user = 1;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 	/* Turn on backtracing through spinlocks by default */
 	sys.backtrace_spinlocks = 1;
-#endif /* __powerpc64__ */
+#endif
 
 	return 0;
 }
 
 int __init oprofile_arch_init(struct oprofile_operations *ops)
 {
-#ifndef __powerpc64__
-#ifdef CONFIG_FSL_BOOKE
-	model = &op_model_fsl_booke;
-#else
-	return -ENODEV;
-#endif
-
-	cpu_type = kmalloc(32, GFP_KERNEL);
-	if (NULL == cpu_type)
-		return -ENOMEM;
-
-	sprintf(cpu_type, "ppc/%s", cur_cpu_spec->cpu_name);
-
-	model->num_counters = cur_cpu_spec->num_pmcs;
-
-	ops->cpu_type = cpu_type;
-#else /* __powerpc64__ */
 	if (!cur_cpu_spec->oprofile_model || !cur_cpu_spec->oprofile_cpu_type)
 		return -ENODEV;
 	model = cur_cpu_spec->oprofile_model;
 	model->num_counters = cur_cpu_spec->num_pmcs;
 
 	ops->cpu_type = cur_cpu_spec->oprofile_cpu_type;
-#endif /* __powerpc64__ */
 	ops->create_files = op_powerpc_create_files;
 	ops->setup = op_powerpc_setup;
 	ops->shutdown = op_powerpc_shutdown;
@@ -188,8 +155,4 @@ int __init oprofile_arch_init(struct opr
 
 void oprofile_arch_exit(void)
 {
-#ifndef __powerpc64__
-	kfree(cpu_type);
-	cpu_type = NULL;
-#endif /* ! __powerpc64__ */
 }
diff --git a/arch/powerpc/oprofile/op_model_7450.c b/arch/powerpc/oprofile/op_model_7450.c
new file mode 100644
index 0000000..32abfdb
--- /dev/null
+++ b/arch/powerpc/oprofile/op_model_7450.c
@@ -0,0 +1,206 @@
+/*
+ * oprofile/op_model_7450.c
+ *
+ * Freescale 745x/744x oprofile support, based on fsl_booke support
+ * Copyright (C) 2004 Anton Blanchard <anton@au.ibm.com>, IBM
+ *
+ * Copyright (c) 2004 Freescale Semiconductor, Inc
+ *
+ * Author: Andy Fleming
+ * Maintainer: Kumar Gala <galak@kernel.crashing.org>
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
+#include <asm/page.h>
+#include <asm/pmc.h>
+#include <asm/oprofile_impl.h>
+
+static unsigned long reset_value[OP_MAX_COUNTER];
+
+static int oprofile_running;
+static u32 mmcr0_val, mmcr1_val, mmcr2_val;
+
+#define MMCR0_PMC1_SHIFT	6
+#define MMCR0_PMC2_SHIFT	0
+#define MMCR1_PMC3_SHIFT	27
+#define MMCR1_PMC4_SHIFT	22
+#define MMCR1_PMC5_SHIFT	17
+#define MMCR1_PMC6_SHIFT	11
+
+#define mmcr0_event1(event) \
+	((event << MMCR0_PMC1_SHIFT) & MMCR0_PMC1SEL)
+#define mmcr0_event2(event) \
+	((event << MMCR0_PMC2_SHIFT) & MMCR0_PMC2SEL)
+
+#define mmcr1_event3(event) \
+	((event << MMCR1_PMC3_SHIFT) & MMCR1_PMC3SEL)
+#define mmcr1_event4(event) \
+	((event << MMCR1_PMC4_SHIFT) & MMCR1_PMC4SEL)
+#define mmcr1_event5(event) \
+	((event << MMCR1_PMC5_SHIFT) & MMCR1_PMC5SEL)
+#define mmcr1_event6(event) \
+	((event << MMCR1_PMC6_SHIFT) & MMCR1_PMC6SEL)
+
+#define MMCR0_INIT (MMCR0_FC | MMCR0_FCS | MMCR0_FCP | MMCR0_FCM1 | MMCR0_FCM0)
+
+/* Unfreezes the counters on this CPU, enables the interrupt,
+ * enables the counters to trigger the interrupt, and sets the
+ * counters to only count when the mark bit is not set.
+ */
+static void pmc_start_ctrs(void)
+{
+	u32 mmcr0 = mfspr(SPRN_MMCR0);
+
+	mmcr0 &= ~(MMCR0_FC | MMCR0_FCM0);
+	mmcr0 |= (MMCR0_FCECE | MMCR0_PMC1CE | MMCR0_PMCnCE | MMCR0_PMXE);
+
+	mtspr(SPRN_MMCR0, mmcr0);
+}
+
+/* Disables the counters on this CPU, and freezes them */
+static void pmc_stop_ctrs(void)
+{
+	u32 mmcr0 = mfspr(SPRN_MMCR0);
+
+	mmcr0 |= MMCR0_FC;
+	mmcr0 &= ~(MMCR0_FCECE | MMCR0_PMC1CE | MMCR0_PMCnCE | MMCR0_PMXE);
+
+	mtspr(SPRN_MMCR0, mmcr0);
+}
+
+/* Configures the counters on this CPU based on the global
+ * settings */
+static void fsl7450_cpu_setup(void *unused)
+{
+	/* freeze all counters */
+	pmc_stop_ctrs();
+
+	mtspr(SPRN_MMCR0, mmcr0_val);
+	mtspr(SPRN_MMCR1, mmcr1_val);
+	mtspr(SPRN_MMCR2, mmcr2_val);
+}
+
+#define NUM_CTRS 6
+
+/* Configures the global settings for the countes on all CPUs. */
+static void fsl7450_reg_setup(struct op_counter_config *ctr,
+			     struct op_system_config *sys,
+			     int num_ctrs)
+{
+	int i;
+
+	/* Our counters count up, and "count" refers to
+	 * how much before the next interrupt, and we interrupt
+	 * on overflow.  So we calculate the starting value
+	 * which will give us "count" until overflow.
+	 * Then we set the events on the enabled counters */
+	for (i = 0; i < NUM_CTRS; ++i)
+		reset_value[i] = 0x80000000UL - ctr[i].count;
+
+	/* Set events for Counters 1 & 2 */
+	mmcr0_val = MMCR0_INIT | mmcr0_event1(ctr[0].event)
+		| mmcr0_event2(ctr[1].event);
+
+	/* Setup user/kernel bits */
+	if (sys->enable_kernel)
+		mmcr0_val &= ~(MMCR0_FCS);
+
+	if (sys->enable_user)
+		mmcr0_val &= ~(MMCR0_FCP);
+
+	/* Set events for Counters 3-6 */
+	mmcr1_val = mmcr1_event3(ctr[2].event)
+		| mmcr1_event4(ctr[3].event)
+		| mmcr1_event5(ctr[4].event)
+		| mmcr1_event6(ctr[5].event);
+
+	mmcr2_val = 0;
+}
+
+/* Sets the counters on this CPU to the chosen values, and starts them */
+static void fsl7450_start(struct op_counter_config *ctr)
+{
+	int i;
+
+	mtmsr(mfmsr() | MSR_PMM);
+
+	for (i = 0; i < NUM_CTRS; ++i) {
+		if (ctr[i].enabled)
+			ctr_write(i, reset_value[i]);
+		else
+			ctr_write(i, 0);
+	}
+
+	/* Clear the freeze bit, and enable the interrupt.
+	 * The counters won't actually start until the rfi clears
+	 * the PMM bit */
+	pmc_start_ctrs();
+
+	oprofile_running = 1;
+}
+
+/* Stop the counters on this CPU */
+static void fsl7450_stop(void)
+{
+	/* freeze counters */
+	pmc_stop_ctrs();
+
+	oprofile_running = 0;
+
+	mb();
+}
+
+
+/* Handle the interrupt on this CPU, and log a sample for each
+ * event that triggered the interrupt */
+static void fsl7450_handle_interrupt(struct pt_regs *regs,
+				    struct op_counter_config *ctr)
+{
+	unsigned long pc;
+	int is_kernel;
+	int val;
+	int i;
+
+	/* set the PMM bit (see comment below) */
+	mtmsr(mfmsr() | MSR_PMM);
+
+	pc = mfspr(SPRN_SIAR);
+	is_kernel = (pc >= KERNELBASE);
+
+	for (i = 0; i < NUM_CTRS; ++i) {
+		val = ctr_read(i);
+		if (val < 0) {
+			if (oprofile_running && ctr[i].enabled) {
+				oprofile_add_pc(pc, is_kernel, i);
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
+	pmc_start_ctrs();
+}
+
+struct op_powerpc_model op_model_7450= {
+	.reg_setup		= fsl7450_reg_setup,
+	.cpu_setup		= fsl7450_cpu_setup,
+	.start			= fsl7450_start,
+	.stop			= fsl7450_stop,
+	.handle_interrupt	= fsl7450_handle_interrupt,
+};
diff --git a/include/asm-powerpc/oprofile_impl.h b/include/asm-powerpc/oprofile_impl.h
index 8013cd2..b48d35e 100644
--- a/include/asm-powerpc/oprofile_impl.h
+++ b/include/asm-powerpc/oprofile_impl.h
@@ -22,24 +22,22 @@ struct op_counter_config {
 	unsigned long enabled;
 	unsigned long event;
 	unsigned long count;
+	/* Classic doesn't support per-counter user/kernel selection */
 	unsigned long kernel;
-#ifdef __powerpc64__
-	/* We dont support per counter user/kernel selection */
-#endif
 	unsigned long user;
 	unsigned long unit_mask;
 };
 
 /* System-wide configuration as set via oprofilefs.  */
 struct op_system_config {
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 	unsigned long mmcr0;
 	unsigned long mmcr1;
 	unsigned long mmcra;
 #endif
 	unsigned long enable_kernel;
 	unsigned long enable_user;
-#ifdef __powerpc64__
+#ifdef CONFIG_PPC64
 	unsigned long backtrace_spinlocks;
 #endif
 };
@@ -49,9 +47,7 @@ struct op_powerpc_model {
 	void (*reg_setup) (struct op_counter_config *,
 			   struct op_system_config *,
 			   int num_counters);
-#ifdef __powerpc64__
 	void (*cpu_setup) (void *);
-#endif
 	void (*start) (struct op_counter_config *);
 	void (*stop) (void);
 	void (*handle_interrupt) (struct pt_regs *,
@@ -59,10 +55,19 @@ struct op_powerpc_model {
 	int num_counters;
 };
 
-#ifdef __powerpc64__
+#ifdef CONFIG_FSL_BOOKE
+extern struct op_powerpc_model op_model_fsl_booke;
+#else /* Otherwise, it's classic */
+
+#ifdef CONFIG_PPC64
 extern struct op_powerpc_model op_model_rs64;
 extern struct op_powerpc_model op_model_power4;
 
+#else /* Otherwise, CONFIG_PPC32 */
+extern struct op_powerpc_model op_model_7450;
+#endif
+
+/* All the classic PPC parts use these */
 static inline unsigned int ctr_read(unsigned int i)
 {
 	switch(i) {
@@ -78,10 +83,14 @@ static inline unsigned int ctr_read(unsi
 		return mfspr(SPRN_PMC5);
 	case 5:
 		return mfspr(SPRN_PMC6);
+
+/* No PPC32 chip has more than 6 so far */
+#ifdef CONFIG_PPC64
 	case 6:
 		return mfspr(SPRN_PMC7);
 	case 7:
 		return mfspr(SPRN_PMC8);
+#endif
 	default:
 		return 0;
 	}
@@ -108,16 +117,20 @@ static inline void ctr_write(unsigned in
 	case 5:
 		mtspr(SPRN_PMC6, val);
 		break;
+
+/* No PPC32 chip has more than 6, yet */
+#ifdef CONFIG_PPC64
 	case 6:
 		mtspr(SPRN_PMC7, val);
 		break;
 	case 7:
 		mtspr(SPRN_PMC8, val);
 		break;
+#endif
 	default:
 		break;
 	}
 }
-#endif /* __powerpc64__ */
+#endif /* !CONFIG_FSL_BOOKE */
 
 #endif /* _ASM_POWERPC_OPROFILE_IMPL_H */
diff --git a/include/asm-powerpc/reg.h b/include/asm-powerpc/reg.h
index eb392d0..a9a7685 100644
--- a/include/asm-powerpc/reg.h
+++ b/include/asm-powerpc/reg.h
@@ -443,12 +443,35 @@
 #define SPRN_SDAR	781
 
 #else /* 32-bit */
-#define SPRN_MMCR0	0x3B8	/* Monitor Mode Control Register 0 */
-#define SPRN_MMCR1	0x3BC	/* Monitor Mode Control Register 1 */
-#define SPRN_PMC1	0x3B9	/* Performance Counter Register 1 */
-#define SPRN_PMC2	0x3BA	/* Performance Counter Register 2 */
-#define SPRN_PMC3	0x3BD	/* Performance Counter Register 3 */
-#define SPRN_PMC4	0x3BE	/* Performance Counter Register 4 */
+#define SPRN_MMCR0	952	/* Monitor Mode Control Register 0 */
+#define   MMCR0_FC	0x80000000UL /* freeze counters */
+#define   MMCR0_FCS	0x40000000UL /* freeze in supervisor state */
+#define   MMCR0_FCP	0x20000000UL /* freeze in problem state */
+#define   MMCR0_FCM1	0x10000000UL /* freeze counters while MSR mark = 1 */
+#define   MMCR0_FCM0	0x08000000UL /* freeze counters while MSR mark = 0 */
+#define   MMCR0_PMXE	0x04000000UL /* performance monitor exception enable */
+#define   MMCR0_FCECE	0x02000000UL /* freeze ctrs on enabled cond or event */
+#define   MMCR0_TBEE	0x00400000UL /* time base exception enable */
+#define   MMCR0_PMC1CE	0x00008000UL /* PMC1 count enable*/
+#define   MMCR0_PMCnCE	0x00004000UL /* count enable for all but PMC 1*/
+#define   MMCR0_TRIGGER	0x00002000UL /* TRIGGER enable */
+#define   MMCR0_PMC1SEL	0x00001fc0UL /* PMC 1 Event */
+#define   MMCR0_PMC2SEL	0x0000003fUL /* PMC 2 Event */
+
+#define SPRN_MMCR1	956
+#define   MMCR1_PMC3SEL	0xf8000000UL /* PMC 3 Event */
+#define   MMCR1_PMC4SEL	0x07c00000UL /* PMC 4 Event */
+#define   MMCR1_PMC5SEL	0x003e0000UL /* PMC 5 Event */
+#define   MMCR1_PMC6SEL 0x0001f800UL /* PMC 6 Event */
+#define SPRN_MMCR2	944
+#define SPRN_PMC1	953	/* Performance Counter Register 1 */
+#define SPRN_PMC2	954	/* Performance Counter Register 2 */
+#define SPRN_PMC3	957	/* Performance Counter Register 3 */
+#define SPRN_PMC4	958	/* Performance Counter Register 4 */
+#define SPRN_PMC5	945	/* Performance Counter Register 5 */
+#define SPRN_PMC6	946	/* Performance Counter Register 6 */
+
+#define SPRN_SIAR	955	/* Sampled Instruction Address Register */
 
 /* Bit definitions for MMCR0 and PMC1 / PMC2. */
 #define MMCR0_PMC1_CYCLES	(1 << 7)
@@ -458,7 +481,6 @@
 #define MMCR0_PMC2_CYCLES	0x1
 #define MMCR0_PMC2_ITLB		0x7
 #define MMCR0_PMC2_LOADMISSTIME	0x5
-#define MMCR0_PMXE	(1 << 26)
 #endif
 
 /* Processor Version Register (PVR) field extraction */
