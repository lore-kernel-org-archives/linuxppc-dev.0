Return-Path: <afleming@freescale.com>
Received: from ftpbox.mot.com (ftpbox.mot.com [129.188.136.101])
	by ozlabs.org (Postfix) with ESMTP id D085E2BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Sat, 30 Oct 2004 11:17:04 +1000 (EST)
Received: from az33exr03.mot.com (az33exr03.mot.com [10.64.251.233])
	by ftpbox.mot.com (Motorola/Ftpbox) with ESMTP id i9U1H07W007170
	for <linuxppc-embedded@ozlabs.org>;
	Fri, 29 Oct 2004 18:17:00 -0700 (MST)
Received: from [10.82.16.241] ([10.82.16.241])
	by az33exr03.mot.com (Motorola/az33exr03) with ESMTP id i9U1Gg6I031663
	for <linuxppc-embedded@ozlabs.org>; Fri, 29 Oct 2004 20:16:42 -0500
Mime-Version: 1.0 (Apple Message framework v619)
To: "<linuxppc-embedded@ozlabs.org> <linuxppc-embedded@ozlabs.org>"
	<linuxppc-embedded@ozlabs.org>
Message-Id: <642F8D42-2A11-11D9-A860-000393C30512@freescale.com>
Content-Type: multipart/mixed; boundary=Apple-Mail-3-532732548
From: Andy Fleming <afleming@freescale.com>
Date: Fri, 29 Oct 2004 20:16:56 -0500
Subject: RFC: performance monitor/oprofile support for e500
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Apple-Mail-3-532732548
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

This patch:
* Adds support for using the performance monitor counters and the 
associated interrupt, but only enables it currently for e500
* Removes the old 604 performance monitor code, suggested by various 
people on IRC
* Adds oprofile support for the e500, with potential for expansion to 
support other ppc32 processors

Andy Fleming
NCSG Open Source Team
Freescale Semiconductor, Inc


--Apple-Mail-3-532732548
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream; x-unix-mode=0644;
	name="oprofile-kernel-patch"
Content-Disposition: attachment;
	filename=oprofile-kernel-patch

diff -Nru a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
--- a/arch/ppc/kernel/Makefile	2004-10-29 19:58:14 -05:00
+++ b/arch/ppc/kernel/Makefile	2004-10-29 19:58:14 -05:00
@@ -14,7 +14,7 @@
 obj-y				:= entry.o traps.o irq.o idle.o time.o misc.o \
 					process.o signal.o ptrace.o align.o \
 					semaphore.o syscalls.o setup.o \
-					cputable.o ppc_htab.o
+					cputable.o ppc_htab.o perfmon.o
 obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
 obj-$(CONFIG_POWER4)		+= cpu_setup_power4.o
 obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
diff -Nru a/arch/ppc/kernel/asm-offsets.c b/arch/ppc/kernel/asm-offsets.c
--- a/arch/ppc/kernel/asm-offsets.c	2004-10-29 19:58:14 -05:00
+++ b/arch/ppc/kernel/asm-offsets.c	2004-10-29 19:58:14 -05:00
@@ -118,6 +118,7 @@
 	DEFINE(ORIG_GPR3, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, orig_gpr3));
 	DEFINE(RESULT, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, result));
 	DEFINE(TRAP, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, trap));
+	DEFINE(SIA, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, sia));
 	DEFINE(CLONE_VM, CLONE_VM);
 	DEFINE(CLONE_UNTRACED, CLONE_UNTRACED);
 	DEFINE(MM_PGD, offsetof(struct mm_struct, pgd));
diff -Nru a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c	2004-10-29 19:58:14 -05:00
+++ b/arch/ppc/kernel/cputable.c	2004-10-29 19:58:14 -05:00
@@ -114,8 +114,7 @@
     {	/* 604 */
     	0xffff0000, 0x00040000, "604",
 	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON |
-	CPU_FTR_HPTE_TABLE,
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
 	COMMON_PPC,
 	32, 32,
 	__setup_cpu_604
@@ -123,8 +122,7 @@
     {	/* 604e */
     	0xfffff000, 0x00090000, "604e",
 	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON |
-	CPU_FTR_HPTE_TABLE,
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
 	COMMON_PPC,
 	32, 32,
 	__setup_cpu_604
@@ -132,8 +130,7 @@
     {	/* 604r */
     	0xffff0000, 0x00090000, "604r",
 	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON |
-	CPU_FTR_HPTE_TABLE,
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
 	COMMON_PPC,
 	32, 32,
 	__setup_cpu_604
@@ -141,8 +138,7 @@
     {	/* 604ev */
     	0xffff0000, 0x000a0000, "604ev",
 	CPU_FTR_COMMON |
-    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_604_PERF_MON |
-	CPU_FTR_HPTE_TABLE,
+    	CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB | CPU_FTR_HPTE_TABLE,
 	COMMON_PPC,
 	32, 32,
 	__setup_cpu_604
@@ -612,7 +608,9 @@
     { /* e500 */
         0xffff0000, 0x80200000, "e500",
 	/* xxx - galak: add CPU_FTR_MAYBE_CAN_DOZE */
-        CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB,
+        CPU_FTR_SPLIT_ID_CACHE | CPU_FTR_USE_TB
+		| CPU_FTR_CAN_USE_PMON_INTR
+		| CPU_FTR_FSL_BOOKE_PMON,
         PPC_FEATURE_32 | PPC_FEATURE_HAS_MMU,
         32, 32,
         0, /*__setup_cpu_e500 */
diff -Nru a/arch/ppc/kernel/head_e500.S b/arch/ppc/kernel/head_e500.S
--- a/arch/ppc/kernel/head_e500.S	2004-10-29 19:58:14 -05:00
+++ b/arch/ppc/kernel/head_e500.S	2004-10-29 19:58:14 -05:00
@@ -666,7 +666,14 @@
 	EXCEPTION(0x2050, SPEFloatingPointRound, UnknownException, EXC_XFER_EE)
 
 	/* Performance Monitor */
-	EXCEPTION(0x2060, PerformanceMonitor, UnknownException, EXC_XFER_EE)
+#	EXCEPTION(0x2060, PerformanceMonitor, PerformanceMonitorException, EXC_XFER_STD)
+	START_EXCEPTION(PerformanceMonitor)
+	NORMAL_EXCEPTION_PROLOG
+	stw	r12,SIA(r11)	/* Save the old SRR0 */
+	addi	r3,r1,STACK_FRAME_OVERHEAD
+	EXC_XFER_STD(0x2060, PerformanceMonitorException)
+
+
 
 /* Check for a single step debug exception while in an exception
  * handler before state has been saved.  This is to catch the case
diff -Nru a/arch/ppc/kernel/perfmon.c b/arch/ppc/kernel/perfmon.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/kernel/perfmon.c	2004-10-29 19:58:14 -05:00
@@ -0,0 +1,291 @@
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
+/* A lock to regulate grabbing the interrupt */
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
+spinlock_t perfmon_lock = SPIN_LOCK_UNLOCKED;
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
+
+static inline u32 get_pmlca(int ctr);
+static inline void set_pmlca(int ctr, u32 pmlca);
+
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
+
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
+	else
+		err = -1;
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
+#ifdef CONFIG_FSL_BOOKE
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
+
+#endif
+EXPORT_SYMBOL(perf_irq);
+EXPORT_SYMBOL(request_perfmon_irq);
+EXPORT_SYMBOL(free_perfmon_irq);
diff -Nru a/arch/ppc/kernel/ppc_htab.c b/arch/ppc/kernel/ppc_htab.c
--- a/arch/ppc/kernel/ppc_htab.c	2004-10-29 19:58:14 -05:00
+++ b/arch/ppc/kernel/ppc_htab.c	2004-10-29 19:58:14 -05:00
@@ -59,42 +59,6 @@
 	.release	= single_release,
 };
 
-static char *pmc1_lookup(unsigned long mmcr0)
-{
-	switch ( mmcr0 & (0x7f<<7) )
-	{
-	case 0x0:
-		return "none";
-	case MMCR0_PMC1_CYCLES:
-		return "cycles";
-	case MMCR0_PMC1_ICACHEMISS:
-		return "ic miss";
-	case MMCR0_PMC1_DTLB:
-		return "dtlb miss";
-	default:
-		return "unknown";
-	}
-}
-
-static char *pmc2_lookup(unsigned long mmcr0)
-{
-	switch ( mmcr0 & 0x3f )
-	{
-	case 0x0:
-		return "none";
-	case MMCR0_PMC2_CYCLES:
-		return "cycles";
-	case MMCR0_PMC2_DCACHEMISS:
-		return "dc miss";
-	case MMCR0_PMC2_ITLB:
-		return "itlb miss";
-	case MMCR0_PMC2_LOADMISSTIME:
-		return "load miss time";
-	default:
-		return "unknown";
-	}
-}
-
 /*
  * print some useful info about the hash table.  This function
  * is _REALLY_ slow (see the nested for loops below) but nothing
@@ -102,29 +66,11 @@
  */
 static int ppc_htab_show(struct seq_file *m, void *v)
 {
-	unsigned long mmcr0 = 0, pmc1 = 0, pmc2 = 0;
 #if defined(CONFIG_PPC_STD_MMU) && !defined(CONFIG_PPC64BRIDGE)
 	unsigned int kptes = 0, uptes = 0;
 	PTE *ptr;
 #endif /* CONFIG_PPC_STD_MMU */
 
-	if (cur_cpu_spec[0]->cpu_features & CPU_FTR_604_PERF_MON) {
-		mmcr0 = mfspr(SPRN_MMCR0);
-		pmc1 = mfspr(SPRN_PMC1);
-		pmc2 = mfspr(SPRN_PMC2);
-		seq_printf(m,
-			      "604 Performance Monitoring\n"
-			      "MMCR0\t\t: %08lx %s%s ",
-			      mmcr0,
-			      ( mmcr0>>28 & 0x2 ) ? "(user mode counted)" : "",
-			      ( mmcr0>>28 & 0x4 ) ? "(kernel mode counted)" : "");
-		seq_printf(m,
-			      "\nPMC1\t\t: %08lx (%s)\n"
-			      "PMC2\t\t: %08lx (%s)\n",
-			      pmc1, pmc1_lookup(mmcr0),
-			      pmc2, pmc2_lookup(mmcr0));
-	}
-
 #ifdef CONFIG_PPC_STD_MMU
 	/* if we don't have a htab */
 	if ( Hash_size == 0 ) {
@@ -188,7 +134,7 @@
 }
 
 /*
- * Allow user to define performance counters and resize the hash table
+ * Allow user to resize the hash table
  */
 static ssize_t ppc_htab_write(struct file * file, const char __user * ubuffer,
 			      size_t count, loff_t *ppos)
@@ -209,106 +155,10 @@
 
 	if ( !strncmp( buffer, "reset", 5) )
 	{
-		if (cur_cpu_spec[0]->cpu_features & CPU_FTR_604_PERF_MON) {
-			/* reset PMC1 and PMC2 */
-			mtspr(SPRN_PMC1, 0);
-			mtspr(SPRN_PMC2, 0);
-		}
 		htab_reloads = 0;
 		htab_evicts = 0;
 		pte_misses = 0;
 		pte_errors = 0;
-	}
-
-	/* Everything below here requires the performance monitor feature. */
-	if ( !cur_cpu_spec[0]->cpu_features & CPU_FTR_604_PERF_MON )
-		return count;
-
-	/* turn off performance monitoring */
-	if ( !strncmp( buffer, "off", 3) )
-	{
-		mtspr(SPRN_MMCR0, 0);
-		mtspr(SPRN_PMC1, 0);
-		mtspr(SPRN_PMC2, 0);
-	}
-
-	if ( !strncmp( buffer, "user", 4) )
-	{
-		/* setup mmcr0 and clear the correct pmc */
-		tmp = (mfspr(SPRN_MMCR0) & ~(0x60000000)) | 0x20000000;
-		mtspr(SPRN_MMCR0, tmp);
-		mtspr(SPRN_PMC1, 0);
-		mtspr(SPRN_PMC2, 0);
-	}
-
-	if ( !strncmp( buffer, "kernel", 6) )
-	{
-		/* setup mmcr0 and clear the correct pmc */
-		tmp = (mfspr(SPRN_MMCR0) & ~(0x60000000)) | 0x40000000;
-		mtspr(SPRN_MMCR0, tmp);
-		mtspr(SPRN_PMC1, 0);
-		mtspr(SPRN_PMC2, 0);
-	}
-
-	/* PMC1 values */
-	if ( !strncmp( buffer, "dtlb", 4) )
-	{
-		/* setup mmcr0 and clear the correct pmc */
-		tmp = (mfspr(SPRN_MMCR0) & ~(0x7F << 7)) | MMCR0_PMC1_DTLB;
-		mtspr(SPRN_MMCR0, tmp);
-		mtspr(SPRN_PMC1, 0);
-	}
-
-	if ( !strncmp( buffer, "ic miss", 7) )
-	{
-		/* setup mmcr0 and clear the correct pmc */
-		tmp = (mfspr(SPRN_MMCR0) & ~(0x7F<<7)) | MMCR0_PMC1_ICACHEMISS;
-		mtspr(SPRN_MMCR0, tmp);
-		mtspr(SPRN_PMC1, 0);
-	}
-
-	/* PMC2 values */
-	if ( !strncmp( buffer, "load miss time", 14) )
-	{
-		/* setup mmcr0 and clear the correct pmc */
-	       asm volatile(
-		       "mfspr %0,%1\n\t"     /* get current mccr0 */
-		       "rlwinm %0,%0,0,0,31-6\n\t"  /* clear bits [26-31] */
-		       "ori   %0,%0,%2 \n\t" /* or in mmcr0 settings */
-		       "mtspr %1,%0 \n\t"    /* set new mccr0 */
-		       "mtspr %3,%4 \n\t"    /* reset the pmc */
-		       : "=r" (tmp)
-		       : "i" (SPRN_MMCR0),
-		       "i" (MMCR0_PMC2_LOADMISSTIME),
-		       "i" (SPRN_PMC2),  "r" (0) );
-	}
-
-	if ( !strncmp( buffer, "itlb", 4) )
-	{
-		/* setup mmcr0 and clear the correct pmc */
-	       asm volatile(
-		       "mfspr %0,%1\n\t"     /* get current mccr0 */
-		       "rlwinm %0,%0,0,0,31-6\n\t"  /* clear bits [26-31] */
-		       "ori   %0,%0,%2 \n\t" /* or in mmcr0 settings */
-		       "mtspr %1,%0 \n\t"    /* set new mccr0 */
-		       "mtspr %3,%4 \n\t"    /* reset the pmc */
-		       : "=r" (tmp)
-		       : "i" (SPRN_MMCR0), "i" (MMCR0_PMC2_ITLB),
-		       "i" (SPRN_PMC2),  "r" (0) );
-	}
-
-	if ( !strncmp( buffer, "dc miss", 7) )
-	{
-		/* setup mmcr0 and clear the correct pmc */
-	       asm volatile(
-		       "mfspr %0,%1\n\t"     /* get current mccr0 */
-		       "rlwinm %0,%0,0,0,31-6\n\t"  /* clear bits [26-31] */
-		       "ori   %0,%0,%2 \n\t" /* or in mmcr0 settings */
-		       "mtspr %1,%0 \n\t"    /* set new mccr0 */
-		       "mtspr %3,%4 \n\t"    /* reset the pmc */
-		       : "=r" (tmp)
-		       : "i" (SPRN_MMCR0), "i" (MMCR0_PMC2_DCACHEMISS),
-		       "i" (SPRN_PMC2),  "r" (0) );
 	}
 
 	return count;
diff -Nru a/arch/ppc/kernel/traps.c b/arch/ppc/kernel/traps.c
--- a/arch/ppc/kernel/traps.c	2004-10-29 19:58:14 -05:00
+++ b/arch/ppc/kernel/traps.c	2004-10-29 19:58:14 -05:00
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
--- a/arch/ppc/oprofile/Makefile	2004-10-29 19:58:14 -05:00
+++ b/arch/ppc/oprofile/Makefile	2004-10-29 19:58:14 -05:00
@@ -6,4 +6,4 @@
 		oprofilefs.o oprofile_stats.o \
 		timer_int.o )
 
-oprofile-y := $(DRIVER_OBJS) init.o
+oprofile-y := $(DRIVER_OBJS) common.o op_model_e500.o
diff -Nru a/arch/ppc/oprofile/common.c b/arch/ppc/oprofile/common.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/oprofile/common.c	2004-10-29 19:58:14 -05:00
@@ -0,0 +1,152 @@
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
+#include <linux/init.h>
+#include <linux/smp.h>
+#include <linux/errno.h>
+#include <asm/ptrace.h>
+#include <asm/system.h>
+#include <asm/perfmon.h>
+
+#include "op_impl.h"
+
+extern struct op_ppc32_model op_model_e500;
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
+	unsigned int pvr;
+
+	pvr = mfspr(SPRN_PVR);
+
+	switch (PVR_VER(pvr)) {
+		case PVR_VER(PVR_8540): /* Same as 8560 */
+			model = &op_model_e500;
+			model->num_counters = 4;
+			oprof_ppc32_ops.cpu_type = "ppc/e500";
+			break;
+		default:
+			return -ENODEV;
+	}
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
+}
diff -Nru a/arch/ppc/oprofile/init.c b/arch/ppc/oprofile/init.c
--- a/arch/ppc/oprofile/init.c	2004-10-29 19:58:14 -05:00
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
+++ b/arch/ppc/oprofile/op_impl.h	2004-10-29 19:58:14 -05:00
@@ -0,0 +1,81 @@
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
+#endif
diff -Nru a/arch/ppc/oprofile/op_model_e500.c b/arch/ppc/oprofile/op_model_e500.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/oprofile/op_model_e500.c	2004-10-29 19:58:15 -05:00
@@ -0,0 +1,159 @@
+/*
+ * oprofile/op_model_e500.c
+ *
+ * e500 oprofile support, based on ppc64 oprofile support
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
+/*#define dbg(args...) printk(args) */
+#define dbg
+
+#include "op_impl.h"
+
+static unsigned long reset_value[OP_MAX_COUNTER];
+
+static int num_counters;
+static int oprofile_running;
+
+static void e500_reg_setup(struct op_counter_config *ctr,
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
+static void e500_start(struct op_counter_config *ctr)
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
+	dbg("start on cpu %d, pmgc0 %x\n", smp_processor_id(),
+			mfpmr(PMRN_PMGC0));
+}
+
+static void e500_stop(void)
+{
+	/* freeze counters */
+	pmc_stop_ctrs();
+
+	oprofile_running = 0;
+
+	dbg("stop on cpu %d, pmgc0 %x\n", smp_processor_id(),
+			mfpmr(PMRN_PMGC0));
+
+	mb();
+}
+
+static inline int get_kernel(unsigned long pc)
+{
+	int is_kernel;
+
+	is_kernel = (pc >= KERNELBASE);
+
+	return is_kernel;
+}
+
+static void e500_handle_interrupt(struct pt_regs *regs,
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
+	pc = regs->sia;
+	is_kernel = get_kernel(pc);
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
+struct op_ppc32_model op_model_e500 = {
+	.reg_setup		= e500_reg_setup,
+	.start			= e500_start,
+	.stop			= e500_stop,
+	.handle_interrupt	= e500_handle_interrupt,
+};
-
-	return 0;
-}
-static int marvell_read_status(struct gfar_mii_info *mii_info)
-{
-	u16 status;
-	int err;
-
-	/* Update the link, but return if there
-	 * was an error */
-	err = genmii_update_link(mii_info);
-	if (err)
-		return err;
-
-	/* If the link is up, read the speed and duplex */
-	/* If we aren't autonegotiating, assume speeds 
-	 * are as set */
-	if (mii_info->autoneg && mii_info->link) {
-		int speed;
-		status = phy_read(mii_info, MII_M1011_PHY_SPEC_STATUS);
-
-#if 0
-		/* If speed and duplex aren't resolved,
-		 * return an error.  Isn't this handled
-		 * by checking aneg?
-		 */
-		if ((status & MII_M1011_PHY_SPEC_STATUS_RESOLVED) == 0)
-			return -EAGAIN;
-#endif
-
-		/* Get the duplexity */
-		if (status & MII_M1011_PHY_SPEC_STATUS_FULLDUPLEX)
-			mii_info->duplex = DUPLEX_FULL;
-		else
-			mii_info->duplex = DUPLEX_HALF;
-
-		/* Get the speed */
-		speed = status & MII_M1011_PHY_SPEC_STATUS_SPD_MASK;
-		switch(speed) {
-			case MII_M1011_PHY_SPEC_STATUS_1000:
-				mii_info->speed = SPEED_1000;
-				break;
-			case MII_M1011_PHY_SPEC_STATUS_100:
-				mii_info->speed = SPEED_100;
-				break;
-			default:
-				mii_info->speed = SPEED_10;
-				break;
-		}
-		mii_info->pause = 0;
-	}
-
-	return 0;
-}
-
-
-static int cis820x_read_status(struct gfar_mii_info *mii_info)
-{
-	u16 status;
-	int err;
-
-	/* Update the link, but return if there
-	 * was an error */
-	err = genmii_update_link(mii_info);
-	if (err)
-		return err;
-
-	/* If the link is up, read the speed and duplex */
-	/* If we aren't autonegotiating, assume speeds 
-	 * are as set */
-	if (mii_info->autoneg && mii_info->link) {
-		int speed;
-
-		status = phy_read(mii_info, MII_CIS8201_AUX_CONSTAT);
-		if (status & MII_CIS8201_AUXCONSTAT_DUPLEX)
-			mii_info->duplex = DUPLEX_FULL;
-		else
-			mii_info->duplex = DUPLEX_HALF;
-
-		speed = status & MII_CIS8201_AUXCONSTAT_SPEED;
-
-		switch (speed) {
-		case MII_CIS8201_AUXCONSTAT_GBIT:
-			mii_info->speed = SPEED_1000;
-			break;
-		case MII_CIS8201_AUXCONSTAT_100:
-			mii_info->speed = SPEED_100;
-			break;
-		default:
-			mii_info->speed = SPEED_10;
-			break;
-		}
-	}
-
-	return 0;
-}
-
-static int marvell_ack_interrupt(struct gfar_mii_info *mii_info)
-{
-	/* Clear the interrupts by reading the reg */
-	phy_read(mii_info, MII_M1011_IEVENT);
-
-	return 0;
-}
-
-static int marvell_config_intr(struct gfar_mii_info *mii_info)
-{
-	if(mii_info->interrupts == MII_INTERRUPT_ENABLED)
-		phy_write(mii_info, MII_M1011_IMASK, MII_M1011_IMASK_INIT);
-	else
-		phy_write(mii_info, MII_M1011_IMASK, MII_M1011_IMASK_CLEAR);
-
-	return 0;
-}
-
-static int cis820x_init(struct gfar_mii_info *mii_info)
-{
-	phy_write(mii_info, MII_CIS8201_AUX_CONSTAT, 
-			MII_CIS8201_AUXCONSTAT_INIT);
-	phy_write(mii_info, MII_CIS8201_EXT_CON1,
-			MII_CIS8201_EXTCON1_INIT);
-
-	return 0;
-}
-
-static int cis820x_ack_interrupt(struct gfar_mii_info *mii_info)
-{
-	phy_read(mii_info, MII_CIS8201_ISTAT);
-
-	return 0;
-}
-
-static int cis820x_config_intr(struct gfar_mii_info *mii_info)
-{
-	if(mii_info->interrupts == MII_INTERRUPT_ENABLED)
-		phy_write(mii_info, MII_CIS8201_IMASK, MII_CIS8201_IMASK_MASK);
-	else
-		phy_write(mii_info, MII_CIS8201_IMASK, 0);
-
-	return 0;
-}
-
-#define DM9161_DELAY 10
-
-static int dm9161_read_status(struct gfar_mii_info *mii_info)
-{
-	u16 status;
-	int err;
-
-	/* Update the link, but return if there
-	 * was an error */
-	err = genmii_update_link(mii_info);
-	if (err)
-		return err;
-
-	/* If the link is up, read the speed and duplex */
-	/* If we aren't autonegotiating, assume speeds 
-	 * are as set */
-	if (mii_info->autoneg && mii_info->link) {
-		status = phy_read(mii_info, MII_DM9161_SCSR);
-		if (status & (MII_DM9161_SCSR_100F | MII_DM9161_SCSR_100H))
-			mii_info->speed = SPEED_100;
-		else
-			mii_info->speed = SPEED_10;
-
-		if (status & (MII_DM9161_SCSR_100F | MII_DM9161_SCSR_10F))
-			mii_info->duplex = DUPLEX_FULL;
-		else
-			mii_info->duplex = DUPLEX_HALF;
-	}
-
-	return 0;
-}
-
-
-static int dm9161_config_aneg(struct gfar_mii_info *mii_info)
-{
-	struct dm9161_private *priv = mii_info->priv;
-
-	if(0 == priv->resetdone)
-		return -EAGAIN;
-
-	return 0;
-}
-
-static void dm9161_timer(unsigned long data)
-{
-	struct gfar_mii_info *mii_info = (struct gfar_mii_info *)data;
-	struct dm9161_private *priv = mii_info->priv;
-	u16 status = phy_read(mii_info, MII_BMSR);
-
-	if (status & BMSR_ANEGCOMPLETE) {
-		priv->resetdone = 1;
-	} else
-		mod_timer(&priv->timer, jiffies + DM9161_DELAY * HZ);
-}
-
-static int dm9161_init(struct gfar_mii_info *mii_info)
-{
-	struct dm9161_private *priv;
-
-	/* Allocate the private data structure */
-	priv = kmalloc(sizeof(struct dm9161_private), GFP_KERNEL);
-
-	if (NULL == priv)
-		return -ENOMEM;
-
-	mii_info->priv = priv;
-
-	/* Reset is not done yet */
-	priv->resetdone = 0;
-
-	/* Isolate the PHY */
-	phy_write(mii_info, MII_BMCR, BMCR_ISOLATE);
-
-	/* Do not bypass the scrambler/descrambler */
-	phy_write(mii_info, MII_DM9161_SCR, MII_DM9161_SCR_INIT);
-
-	/* Clear 10BTCSR to default */
-	phy_write(mii_info, MII_DM9161_10BTCSR, MII_DM9161_10BTCSR_INIT);
-
-	/* Reconnect the PHY, and enable Autonegotiation */
-	phy_write(mii_info, MII_BMCR, BMCR_ANENABLE);
-
-	/* Start a timer for DM9161_DELAY seconds to wait
-	 * for the PHY to be ready */
-	init_timer(&priv->timer);
-	priv->timer.function = &dm9161_timer;
-	priv->timer.data = (unsigned long) mii_info;
-	mod_timer(&priv->timer, jiffies + DM9161_DELAY * HZ);
-
-	return 0;
-}
-
-static void dm9161_close(struct gfar_mii_info *mii_info)
-{
-	struct dm9161_private *priv = mii_info->priv;
-
-	del_timer_sync(&priv->timer);
-	kfree(priv);
-}
-
-#if 0
-static int dm9161_ack_interrupt(struct gfar_mii_info *mii_info)
-{
-	phy_read(mii_info, MII_DM9161_INTR);
-
-	return 0;
-}
-#endif
-
-/* Cicada 820x */
-static struct phy_info phy_info_cis820x = {
-	0x000fc440,
-	"Cicada Cis8204",
-	0x000fffc0,
-	.features	= MII_GBIT_FEATURES,
-	.init		= &cis820x_init,
-	.config_aneg	= &gbit_config_aneg,
-	.read_status	= &cis820x_read_status,
-	.ack_interrupt	= &cis820x_ack_interrupt,
-	.config_intr	= &cis820x_config_intr,
-};
-
-static struct phy_info phy_info_dm9161 = {
-	.phy_id		= 0x0181b880,
-	.name		= "Davicom DM9161E",
-	.phy_id_mask	= 0x0ffffff0,
-	.init		= dm9161_init,
-	.config_aneg	= dm9161_config_aneg,
-	.read_status	= dm9161_read_status,
-	.close		= dm9161_close,
-};
-
-static struct phy_info phy_info_marvell = {
-	.phy_id		= 0x01410c00,
-	.phy_id_mask	= 0xffffff00,
-	.name		= "Marvell 88E1101",
-	.features	= MII_GBIT_FEATURES,
-	.config_aneg	= &marvell_config_aneg,
-	.read_status	= &marvell_read_status,
-	.ack_interrupt	= &marvell_ack_interrupt,
-	.config_intr	= &marvell_config_intr,
-};
-
-static struct phy_info phy_info_genmii= {
-	.phy_id		= 0x00000000,
-	.phy_id_mask	= 0x00000000,
-	.name		= "Generic MII",
-	.features	= MII_BASIC_FEATURES,
-	.config_aneg	= genmii_config_aneg,
-	.read_status	= genmii_read_status,
-};
-
-static struct phy_info *phy_info[] = {
-	&phy_info_cis820x,
-	&phy_info_marvell,
-	&phy_info_dm9161,
-	&phy_info_genmii,
-	NULL
-};
-
-u16 phy_read(struct gfar_mii_info *mii_info, u16 regnum)
-{
-	u16 retval;
-	unsigned long flags;
-
-	spin_lock_irqsave(&mii_info->mdio_lock, flags);
-	retval = mii_info->mdio_read(mii_info->dev, mii_info->mii_id, regnum);
-	spin_unlock_irqrestore(&mii_info->mdio_lock, flags);
-
-	return retval;
-}
-
-void phy_write(struct gfar_mii_info *mii_info, u16 regnum, u16 val)
-{
-	unsigned long flags;
-
-	spin_lock_irqsave(&mii_info->mdio_lock, flags);
-	mii_info->mdio_write(mii_info->dev, 
-			mii_info->mii_id, 
-			regnum, val);
-	spin_unlock_irqrestore(&mii_info->mdio_lock, flags);
-}
-
-/* Use the PHY ID registers to determine what type of PHY is attached
- * to device dev.  return a struct phy_info structure describing that PHY
- */
-struct phy_info * get_phy_info(struct gfar_mii_info *mii_info)
-{
-	u16 phy_reg;
-	u32 phy_ID;
-	int i;
-	struct phy_info *theInfo = NULL;
-	struct net_device *dev = mii_info->dev;
-
-	/* Grab the bits from PHYIR1, and put them in the upper half */
-	phy_reg = phy_read(mii_info, MII_PHYSID1);
-	phy_ID = (phy_reg & 0xffff) << 16;
-
-	/* Grab the bits from PHYIR2, and put them in the lower half */
-	phy_reg = phy_read(mii_info, MII_PHYSID2);
-	phy_ID |= (phy_reg & 0xffff);
-
-	/* loop through all the known PHY types, and find one that */
-	/* matches the ID we read from the PHY. */
-	for (i = 0; phy_info[i]; i++)
-		if (phy_info[i]->phy_id == 
-				(phy_ID & phy_info[i]->phy_id_mask)) {
-			theInfo = phy_info[i];
-			break;
-		}
-
-	/* This shouldn't happen, as we have generic PHY support */
-	if (theInfo == NULL) {
-		printk("%s: PHY id %x is not supported!\n", dev->name, phy_ID);
-		return NULL;
-	} else {
-		printk("%s: PHY is %s (%x)\n", dev->name, theInfo->name,
-		       phy_ID);
-	}
-
-	return theInfo;
 }
diff -Nru a/drivers/net/gianfar_phy.h b/drivers/net/gianfar_phy.h
--- a/drivers/net/gianfar_phy.h	2004-10-29 19:58:14 -05:00
+++ b/drivers/net/gianfar_phy.h	2004-10-29 19:58:14 -05:00
@@ -19,195 +19,13 @@
 #ifndef __GIANFAR_PHY_H
 #define __GIANFAR_PHY_H
 
-#define MII_end ((u32)-2)
-#define MII_read ((u32)-1)
-
 #define MIIMIND_BUSY            0x00000001
 #define MIIMIND_NOTVALID        0x00000004
 
 #define GFAR_AN_TIMEOUT         2000
 
-/* 1000BT control (Marvell & BCM54xx at least) */
-#define MII_1000BASETCONTROL			0x09
-#define MII_1000BASETCONTROL_FULLDUPLEXCAP	0x0200
-#define MII_1000BASETCONTROL_HALFDUPLEXCAP	0x0100
-
-/* Cicada Extended Control Register 1 */
-#define MII_CIS8201_EXT_CON1           0x17
-#define MII_CIS8201_EXTCON1_INIT       0x0000
-
-/* Cicada Interrupt Mask Register */
-#define MII_CIS8201_IMASK		0x19
-#define MII_CIS8201_IMASK_IEN		0x8000
-#define MII_CIS8201_IMASK_SPEED	0x4000
-#define MII_CIS8201_IMASK_LINK		0x2000
-#define MII_CIS8201_IMASK_DUPLEX	0x1000
-#define MII_CIS8201_IMASK_MASK		0xf000
-
-/* Cicada Interrupt Status Register */
-#define MII_CIS8201_ISTAT		0x1a
-#define MII_CIS8201_ISTAT_STATUS	0x8000
-#define MII_CIS8201_ISTAT_SPEED	0x4000
-#define MII_CIS8201_ISTAT_LINK		0x2000
-#define MII_CIS8201_ISTAT_DUPLEX	0x1000
-
-/* Cicada Auxiliary Control/Status Register */
-#define MII_CIS8201_AUX_CONSTAT        0x1c
-#define MII_CIS8201_AUXCONSTAT_INIT    0x0004
-#define MII_CIS8201_AUXCONSTAT_DUPLEX  0x0020
-#define MII_CIS8201_AUXCONSTAT_SPEED   0x0018
-#define MII_CIS8201_AUXCONSTAT_GBIT    0x0010
-#define MII_CIS8201_AUXCONSTAT_100     0x0008
-                                                                                
-/* 88E1011 PHY Status Register */
-#define MII_M1011_PHY_SPEC_STATUS		0x11
-#define MII_M1011_PHY_SPEC_STATUS_1000		0x8000
-#define MII_M1011_PHY_SPEC_STATUS_100		0x4000
-#define MII_M1011_PHY_SPEC_STATUS_SPD_MASK	0xc000
-#define MII_M1011_PHY_SPEC_STATUS_FULLDUPLEX	0x2000
-#define MII_M1011_PHY_SPEC_STATUS_RESOLVED	0x0800
-#define MII_M1011_PHY_SPEC_STATUS_LINK		0x0400
-
-#define MII_M1011_IEVENT		0x13
-#define MII_M1011_IEVENT_CLEAR		0x0000
-
-#define MII_M1011_IMASK			0x12
-#define MII_M1011_IMASK_INIT		0x6400
-#define MII_M1011_IMASK_CLEAR		0x0000
-
-#define MII_DM9161_SCR		0x10
-#define MII_DM9161_SCR_INIT	0x0610
-
-/* DM9161 Specified Configuration and Status Register */
-#define MII_DM9161_SCSR	0x11
-#define MII_DM9161_SCSR_100F	0x8000
-#define MII_DM9161_SCSR_100H	0x4000
-#define MII_DM9161_SCSR_10F	0x2000
-#define MII_DM9161_SCSR_10H	0x1000
-
-/* DM9161 Interrupt Register */
-#define MII_DM9161_INTR	0x15
-#define MII_DM9161_INTR_PEND		0x8000
-#define MII_DM9161_INTR_DPLX_MASK	0x0800
-#define MII_DM9161_INTR_SPD_MASK	0x0400
-#define MII_DM9161_INTR_LINK_MASK	0x0200
-#define MII_DM9161_INTR_MASK		0x0100
-#define MII_DM9161_INTR_DPLX_CHANGE	0x0010
-#define MII_DM9161_INTR_SPD_CHANGE	0x0008
-#define MII_DM9161_INTR_LINK_CHANGE	0x0004
-#define MII_DM9161_INTR_INIT 		0x0000
-#define MII_DM9161_INTR_STOP	\
-(MII_DM9161_INTR_DPLX_MASK | MII_DM9161_INTR_SPD_MASK \
- | MII_DM9161_INTR_LINK_MASK | MII_DM9161_INTR_MASK)
-
-/* DM9161 10BT Configuration/Status */
-#define MII_DM9161_10BTCSR	0x12
-#define MII_DM9161_10BTCSR_INIT	0x7800
-
-#define MII_BASIC_FEATURES	(SUPPORTED_10baseT_Half | \
-				 SUPPORTED_10baseT_Full | \
-				 SUPPORTED_100baseT_Half | \
-				 SUPPORTED_100baseT_Full | \
-				 SUPPORTED_Autoneg | \
-				 SUPPORTED_TP | \
-				 SUPPORTED_MII)
-
-#define MII_GBIT_FEATURES	(MII_BASIC_FEATURES | \
-				 SUPPORTED_1000baseT_Half | \
-				 SUPPORTED_1000baseT_Full)
-
 #define MII_READ_COMMAND       0x00000001
 
-#define MII_INTERRUPT_DISABLED 0x0
-#define MII_INTERRUPT_ENABLED 0x1
-/* Taken from mii_if_info and sungem_phy.h */
-struct gfar_mii_info {
-	/* Information about the PHY type */
-	/* And management functions */
-	struct phy_info *phyinfo;
-
-	/* forced speed & duplex (no autoneg)
-	 * partner speed & duplex & pause (autoneg)
-	 */
-	int speed;
-	int duplex;
-	int pause;
-
-	/* The most recently read link state */
-	int link;
-
-	/* Enabled Interrupts */
-	u32 interrupts;
-
-	u32 advertising;
-	int autoneg;
-	int mii_id;
-
-	/* private data pointer */
-	/* For use by PHYs to maintain extra state */
-	void *priv;
-
-	/* Provided by host chip */
-	struct net_device *dev;
-
-	/* A lock to ensure that only one thing can read/write
-	 * the MDIO bus at a time */
-	spinlock_t mdio_lock;
-
-	/* Provided by ethernet driver */
-	int (*mdio_read) (struct net_device *dev, int mii_id, int reg);
-	void (*mdio_write) (struct net_device *dev, int mii_id, int reg, int val);
-};
-
-/* struct phy_info: a structure which defines attributes for a PHY
- *
- * id will contain a number which represents the PHY.  During
- * startup, the driver will poll the PHY to find out what its
- * UID--as defined by registers 2 and 3--is.  The 32-bit result
- * gotten from the PHY will be ANDed with phy_id_mask to
- * discard any bits which may change based on revision numbers
- * unimportant to functionality
- *
- * There are 6 commands which take a gfar_mii_info structure.
- * Each PHY must declare config_aneg, and read_status.
- */
-struct phy_info {
-	u32 phy_id;
-	char *name;
-	unsigned int phy_id_mask;
-	u32 features;
-
-	/* Called to initialize the PHY */
-	int (*init)(struct gfar_mii_info *mii_info);
-
-	/* Called to suspend the PHY for power */
-	int (*suspend)(struct gfar_mii_info *mii_info);
-
-	/* Reconfigures autonegotiation (or disables it) */
-	int (*config_aneg)(struct gfar_mii_info *mii_info);
-
-	/* Determines the negotiated speed and duplex */
-	int (*read_status)(struct gfar_mii_info *mii_info);
-
-	/* Clears any pending interrupts */
-	int (*ack_interrupt)(struct gfar_mii_info *mii_info);
-
-	/* Enables or disables interrupts */
-	int (*config_intr)(struct gfar_mii_info *mii_info);
-
-	/* Clears up any memory if needed */
-	void (*close)(struct gfar_mii_info *mii_info);
-};
-
-struct phy_info *get_phy_info(struct gfar_mii_info *mii_info);
-int read_phy_reg(struct net_device *dev, int mii_id, int regnum);
-void write_phy_reg(struct net_device *dev, int mii_id, int regnum, int value);
-void mii_clear_phy_interrupt(struct gfar_mii_info *mii_info);
-void mii_configure_phy_interrupt(struct gfar_mii_info *mii_info, u32 interrupts);
-
-struct dm9161_private {
-	struct timer_list timer;
-	int resetdone;
-};
-
+int gfar_read_phy_reg(struct net_device *dev, int mii_id, int regnum);
+void gfar_write_phy_reg(struct net_device *dev, int mii_id, int regnum, int value);
 #endif /* GIANFAR_PHY_H */
diff -Nru a/drivers/net/phy.c b/drivers/net/phy.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/drivers/net/phy.c	2004-10-29 19:58:15 -05:00
@@ -0,0 +1,890 @@
+/* 
+ * drivers/net/phy.c
+ *
+ * Framework and drivers for configuring and reading different PHYs
+ * Based on code in sungem_phy.c and gianfar_phy.c
+ *
+ * Author: Andy Fleming
+ *
+ * Copyright (c) 2004 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+#include <linux/config.h>
+#include <linux/kernel.h>
+#include <linux/sched.h>
+#include <linux/string.h>
+#include <linux/errno.h>
+#include <linux/slab.h>
+#include <linux/interrupt.h>
+#include <linux/init.h>
+#include <linux/delay.h>
+#include <linux/netdevice.h>
+#include <linux/etherdevice.h>
+#include <linux/skbuff.h>
+#include <linux/spinlock.h>
+#include <linux/mm.h>
+#include <linux/module.h>
+#include <linux/version.h>
+#include <linux/mii.h>
+#include <linux/ethtool.h>
+#include <linux/phy.h>
+
+#include <asm/io.h>
+#include <asm/irq.h>
+#include <asm/uaccess.h>
+
+u16 phy_read(struct phy_mii_info *mii_info, u16 regnum);
+void phy_write(struct phy_mii_info *mii_info, u16 regnum, u16 val);
+static void genmii_config_advert(struct phy_mii_info *mii_info);
+static void genmii_setup_forced(struct phy_mii_info *mii_info);
+static void genmii_restart_aneg(struct phy_mii_info *mii_info);
+static int genmii_config_aneg(struct phy_mii_info *mii_info);
+static int gbit_config_aneg(struct phy_mii_info *mii_info);
+static int genmii_update_link(struct phy_mii_info *mii_info);
+static int genmii_read_status(struct phy_mii_info *mii_info);
+
+static struct phy_info *phy_info[];
+/* Use the PHY ID registers to determine what type of PHY is
+ * attached to device dev.  return a struct phy_info structure
+ * describing that PHY
+ */
+struct phy_info * get_phy_info(struct phy_mii_info *mii_info)
+{
+	u16 phy_reg;
+	u32 phy_ID;
+	int i;
+	struct phy_info *theInfo = NULL;
+	struct net_device *dev = mii_info->dev;
+
+	/* Grab the bits from PHYIR1, and put them 
+	 * in the upper half */
+	phy_reg = phy_read(mii_info, MII_PHYSID1);
+	phy_ID = (phy_reg & 0xffff) << 16;
+
+	/* Grab the bits from PHYIR2, and put them in the lower half */
+	phy_reg = phy_read(mii_info, MII_PHYSID2);
+	phy_ID |= (phy_reg & 0xffff);
+
+	/* loop through all the known PHY types, and find
+	 * one that matches the ID we read from the PHY. */
+	for (i = 0; phy_info[i]; i++)
+		if (phy_info[i]->phy_id == 
+				(phy_ID & phy_info[i]->phy_id_mask)) {
+			theInfo = phy_info[i];
+			break;
+		}
+
+	/* This shouldn't happen, as we have generic PHY support */
+	if (theInfo == NULL) {
+		printk("%s: PHY id %x is not supported!\n", dev->name,
+				phy_ID);
+		return NULL;
+	} else {
+		printk("%s: PHY is %s (%x)\n", dev->name,
+				theInfo->name, phy_ID);
+	}
+
+	return theInfo;
+}
+
+u16 phy_read(struct phy_mii_info *mii_info, u16 regnum)
+{
+	u16 retval;
+	unsigned long flags;
+
+	spin_lock_irqsave(&mii_info->mdio_lock, flags);
+	retval = mii_info->mdio_read(mii_info->dev, mii_info->mii_id, regnum);
+	spin_unlock_irqrestore(&mii_info->mdio_lock, flags);
+
+	return retval;
+}
+
+void phy_write(struct phy_mii_info *mii_info, u16 regnum, u16 val)
+{
+	unsigned long flags;
+
+	spin_lock_irqsave(&mii_info->mdio_lock, flags);
+	mii_info->mdio_write(mii_info->dev, mii_info->mii_id, regnum, val);
+	spin_unlock_irqrestore(&mii_info->mdio_lock, flags);
+}
+
+
+void mii_clear_phy_interrupt(struct phy_mii_info *mii_info)
+{
+	if(mii_info->phyinfo->ack_interrupt)
+		mii_info->phyinfo->ack_interrupt(mii_info);
+}
+
+
+void mii_configure_phy_interrupt(struct phy_mii_info *mii_info,
+		u32 interrupts)
+{
+	mii_info->interrupts = interrupts;
+	if(mii_info->phyinfo->config_intr)
+		mii_info->phyinfo->config_intr(mii_info);
+}
+
+/* Writes MII_ADVERTISE with the appropriate values, after
+ * sanitizing advertise to make sure only supported features
+ * are advertised 
+ */
+void genmii_config_advert(struct phy_mii_info *mii_info)
+{
+	u32 advertise;
+	u16 adv;
+
+	/* Only allow advertising what
+	 * this PHY supports */
+	mii_info->advertising &= mii_info->phyinfo->features;
+	advertise = mii_info->advertising;
+
+	/* Setup standard advertisement */
+	adv = phy_read(mii_info, MII_ADVERTISE);
+	adv &= ~(ADVERTISE_ALL | ADVERTISE_100BASE4);
+	if (advertise & ADVERTISED_10baseT_Half)
+		adv |= ADVERTISE_10HALF;
+	if (advertise & ADVERTISED_10baseT_Full)
+		adv |= ADVERTISE_10FULL;
+	if (advertise & ADVERTISED_100baseT_Half)
+		adv |= ADVERTISE_100HALF;
+	if (advertise & ADVERTISED_100baseT_Full)
+		adv |= ADVERTISE_100FULL;
+	phy_write(mii_info, MII_ADVERTISE, adv);
+}
+
+
+
+/* Configures MII_BMCR to force speed/duplex to the 
+ * values in mii_info */
+static void genmii_setup_forced(struct phy_mii_info *mii_info)
+{
+	u16 ctrl;
+	u32 features = mii_info->phyinfo->features;
+	
+	ctrl = phy_read(mii_info, MII_BMCR);
+
+	ctrl &= ~(BMCR_FULLDPLX|BMCR_SPEED100|BMCR_SPEED1000|BMCR_ANENABLE);
+	ctrl |= BMCR_RESET;
+
+	switch(mii_info->speed) {
+		case SPEED_1000:
+			if(features & (SUPPORTED_1000baseT_Half
+						| SUPPORTED_1000baseT_Full)) {
+				ctrl |= BMCR_SPEED1000;
+				break;
+			}
+			mii_info->speed = SPEED_100;
+		case SPEED_100:
+			if (features & (SUPPORTED_100baseT_Half
+						| SUPPORTED_100baseT_Full)) {
+				ctrl |= BMCR_SPEED100;
+				break;
+			}
+			mii_info->speed = SPEED_10;
+		case SPEED_10:
+			if (features & (SUPPORTED_10baseT_Half
+						| SUPPORTED_10baseT_Full))
+				break;
+		default: /* Unsupported speed! */
+			printk(KERN_ERR "%s: Bad speed!\n", 
+					mii_info->dev->name);
+			break;
+	}
+
+	phy_write(mii_info, MII_BMCR, ctrl);
+}
+
+
+/* Enable and Restart Autonegotiation */
+static void genmii_restart_aneg(struct phy_mii_info *mii_info)
+{
+	u16 ctl;
+
+	ctl = phy_read(mii_info, MII_BMCR);
+	ctl |= (BMCR_ANENABLE | BMCR_ANRESTART);
+	phy_write(mii_info, MII_BMCR, ctl);
+}
+
+
+static int gbit_config_aneg(struct phy_mii_info *mii_info)
+{
+	u16 adv;
+	u32 advertise;
+
+	if(mii_info->autoneg) {
+		/* Configure the ADVERTISE register */
+		genmii_config_advert(mii_info);
+		advertise = mii_info->advertising;
+
+		adv = phy_read(mii_info, MII_1000BASETCONTROL);
+		adv &= ~(MII_1000BASETCONTROL_FULLDUPLEXCAP |
+				MII_1000BASETCONTROL_HALFDUPLEXCAP);
+		if (advertise & SUPPORTED_1000baseT_Half)
+			adv |= MII_1000BASETCONTROL_HALFDUPLEXCAP;
+		if (advertise & SUPPORTED_1000baseT_Full)
+			adv |= MII_1000BASETCONTROL_FULLDUPLEXCAP;
+		phy_write(mii_info, MII_1000BASETCONTROL, adv);
+
+		/* Start/Restart aneg */
+		genmii_restart_aneg(mii_info);
+	} else
+		genmii_setup_forced(mii_info);
+
+	return 0;
+}
+
+
+static int genmii_config_aneg(struct phy_mii_info *mii_info)
+{
+	if (mii_info->autoneg) {
+		genmii_config_advert(mii_info);
+		genmii_restart_aneg(mii_info);
+	} else
+		genmii_setup_forced(mii_info);
+
+	return 0;
+}
+
+
+static int genmii_update_link(struct phy_mii_info *mii_info)
+{
+	u16 status;
+
+	/* Do a fake read */
+	phy_read(mii_info, MII_BMSR);
+
+	/* Read link and autonegotiation status */
+	status = phy_read(mii_info, MII_BMSR);
+	if ((status & BMSR_LSTATUS) == 0)
+		mii_info->link = 0;
+	else
+		mii_info->link = 1;
+
+	/* If we are autonegotiating, and not done, 
+	 * return an error */
+	if (mii_info->autoneg && !(status & BMSR_ANEGCOMPLETE))
+		return -EAGAIN;
+
+	return 0;
+}
+
+static int genmii_read_status(struct phy_mii_info *mii_info)
+{
+	u16 status;
+	int err;
+
+	/* Update the link, but return if there
+	 * was an error */
+	err = genmii_update_link(mii_info);
+	if (err)
+		return err;
+
+	if (mii_info->autoneg) {
+		status = phy_read(mii_info, MII_LPA);
+
+		if (status & (LPA_10FULL | LPA_100FULL))
+			mii_info->duplex = DUPLEX_FULL;
+		else
+			mii_info->duplex = DUPLEX_HALF;
+		if (status & (LPA_100FULL | LPA_100HALF))
+			mii_info->speed = SPEED_100;
+		else
+			mii_info->speed = SPEED_10;
+		mii_info->pause = 0;
+	}
+	/* On non-aneg, we assume what we put in BMCR is the speed,
+	 * though magic-aneg shouldn't prevent this case from occurring
+	 */
+
+	return 0;
+}
+
+static int marvell_read_status(struct phy_mii_info *mii_info)
+{
+	u16 status;
+	int err;
+
+	/* Update the link, but return if there
+	 * was an error */
+	err = genmii_update_link(mii_info);
+	if (err)
+		return err;
+
+	/* If the link is up, read the speed and duplex */
+	/* If we aren't autonegotiating, assume speeds 
+	 * are as set */
+	if (mii_info->autoneg && mii_info->link) {
+		int speed;
+		status = phy_read(mii_info, MII_M1011_PHY_SPEC_STATUS);
+
+#if 0
+		/* If speed and duplex aren't resolved,
+		 * return an error.  Isn't this handled
+		 * by checking aneg?
+		 */
+		if ((status & MII_M1011_PHY_SPEC_STATUS_RESOLVED) == 0)
+			return -EAGAIN;
+#endif
+
+		/* Get the duplexity */
+		if (status & MII_M1011_PHY_SPEC_STATUS_FULLDUPLEX)
+			mii_info->duplex = DUPLEX_FULL;
+		else
+			mii_info->duplex = DUPLEX_HALF;
+
+		/* Get the speed */
+		speed = status & MII_M1011_PHY_SPEC_STATUS_SPD_MASK;
+		switch(speed) {
+			case MII_M1011_PHY_SPEC_STATUS_1000:
+				mii_info->speed = SPEED_1000;
+				break;
+			case MII_M1011_PHY_SPEC_STATUS_100:
+				mii_info->speed = SPEED_100;
+				break;
+			default:
+				mii_info->speed = SPEED_10;
+				break;
+		}
+		mii_info->pause = 0;
+	}
+
+	return 0;
+}
+
+static int marvell_ack_interrupt(struct phy_mii_info *mii_info)
+{
+	/* Clear the interrupts by reading the reg */
+	phy_read(mii_info, MII_M1011_IEVENT);
+
+	return 0;
+}
+
+static int marvell_config_intr(struct phy_mii_info *mii_info)
+{
+	if(mii_info->interrupts == MII_INTERRUPT_ENABLED)
+		phy_write(mii_info, MII_M1011_IMASK, MII_M1011_IMASK_INIT);
+	else
+		phy_write(mii_info, MII_M1011_IMASK, MII_M1011_IMASK_CLEAR);
+
+	return 0;
+}
+
+static int marvell_config_aneg(struct phy_mii_info *mii_info)
+{
+	/* The Marvell PHY has an errata which requires
+	 * that certain registers get written in order
+	 * to restart autonegotiation */
+	phy_write(mii_info, MII_BMCR, BMCR_RESET);
+
+	phy_write(mii_info, 0x1d, 0x1f);
+	phy_write(mii_info, 0x1e, 0x200c);
+	phy_write(mii_info, 0x1d, 0x5);
+	phy_write(mii_info, 0x1e, 0);
+	phy_write(mii_info, 0x1e, 0x100);
+
+	gbit_config_aneg(mii_info);
+
+	return 0;
+}
+
+
+static int cis820x_read_status(struct phy_mii_info *mii_info)
+{
+	u16 status;
+	int err;
+
+	/* Update the link, but return if there
+	 * was an error */
+	err = genmii_update_link(mii_info);
+	if (err)
+		return err;
+
+	/* If the link is up, read the speed and duplex */
+	/* If we aren't autonegotiating, assume speeds 
+	 * are as set */
+	if (mii_info->autoneg && mii_info->link) {
+		int speed;
+
+		status = phy_read(mii_info, MII_CIS8201_AUX_CONSTAT);
+		if (status & MII_CIS8201_AUXCONSTAT_DUPLEX)
+			mii_info->duplex = DUPLEX_FULL;
+		else
+			mii_info->duplex = DUPLEX_HALF;
+
+		speed = status & MII_CIS8201_AUXCONSTAT_SPEED;
+
+		switch (speed) {
+		case MII_CIS8201_AUXCONSTAT_GBIT:
+			mii_info->speed = SPEED_1000;
+			break;
+		case MII_CIS8201_AUXCONSTAT_100:
+			mii_info->speed = SPEED_100;
+			break;
+		default:
+			mii_info->speed = SPEED_10;
+			break;
+		}
+	}
+
+	return 0;
+}
+
+static int cis820x_init(struct phy_mii_info *mii_info)
+{
+	phy_write(mii_info, MII_CIS8201_AUX_CONSTAT, 
+			MII_CIS8201_AUXCONSTAT_INIT);
+	phy_write(mii_info, MII_CIS8201_EXT_CON1,
+			MII_CIS8201_EXTCON1_INIT);
+
+	return 0;
+}
+
+static int cis820x_ack_interrupt(struct phy_mii_info *mii_info)
+{
+	phy_read(mii_info, MII_CIS8201_ISTAT);
+
+	return 0;
+}
+
+static int cis820x_config_intr(struct phy_mii_info *mii_info)
+{
+	if(mii_info->interrupts == MII_INTERRUPT_ENABLED)
+		phy_write(mii_info, MII_CIS8201_IMASK, MII_CIS8201_IMASK_MASK);
+	else
+		phy_write(mii_info, MII_CIS8201_IMASK, 0);
+
+	return 0;
+}
+
+#define DM9161_DELAY 10
+
+static int dm9161_read_status(struct phy_mii_info *mii_info)
+{
+	u16 status;
+	int err;
+
+	/* Update the link, but return if there
+	 * was an error */
+	err = genmii_update_link(mii_info);
+	if (err)
+		return err;
+
+	/* If the link is up, read the speed and duplex */
+	/* If we aren't autonegotiating, assume speeds 
+	 * are as set */
+	if (mii_info->autoneg && mii_info->link) {
+		status = phy_read(mii_info, MII_DM9161_SCSR);
+		if (status & (MII_DM9161_SCSR_100F | MII_DM9161_SCSR_100H))
+			mii_info->speed = SPEED_100;
+		else
+			mii_info->speed = SPEED_10;
+
+		if (status & (MII_DM9161_SCSR_100F | MII_DM9161_SCSR_10F))
+			mii_info->duplex = DUPLEX_FULL;
+		else
+			mii_info->duplex = DUPLEX_HALF;
+	}
+
+	return 0;
+}
+
+
+static int dm9161_config_aneg(struct phy_mii_info *mii_info)
+{
+	struct dm9161_private *priv = mii_info->priv;
+
+	if(0 == priv->resetdone)
+		return -EAGAIN;
+
+	return 0;
+}
+
+static void dm9161_timer(unsigned long data)
+{
+	struct phy_mii_info *mii_info = (struct phy_mii_info *)data;
+	struct dm9161_private *priv = mii_info->priv;
+	u16 status = phy_read(mii_info, MII_BMSR);
+
+	if (status & BMSR_ANEGCOMPLETE) {
+		priv->resetdone = 1;
+	} else
+		mod_timer(&priv->timer, jiffies + DM9161_DELAY * HZ);
+}
+
+static int dm9161_init(struct phy_mii_info *mii_info)
+{
+	struct dm9161_private *priv;
+
+	/* Allocate the private data structure */
+	priv = kmalloc(sizeof(struct dm9161_private), GFP_KERNEL);
+
+	if (NULL == priv)
+		return -ENOMEM;
+
+	mii_info->priv = priv;
+
+	/* Reset is not done yet */
+	priv->resetdone = 0;
+
+	/* Isolate the PHY */
+	phy_write(mii_info, MII_BMCR, BMCR_ISOLATE);
+
+	/* Do not bypass the scrambler/descrambler */
+	phy_write(mii_info, MII_DM9161_SCR, MII_DM9161_SCR_INIT);
+
+	/* Clear 10BTCSR to default */
+	phy_write(mii_info, MII_DM9161_10BTCSR, MII_DM9161_10BTCSR_INIT);
+
+	/* Reconnect the PHY, and enable Autonegotiation */
+	phy_write(mii_info, MII_BMCR, BMCR_ANENABLE);
+
+	/* Start a timer for DM9161_DELAY seconds to wait
+	 * for the PHY to be ready */
+	init_timer(&priv->timer);
+	priv->timer.function = &dm9161_timer;
+	priv->timer.data = (unsigned long) mii_info;
+	mod_timer(&priv->timer, jiffies + DM9161_DELAY * HZ);
+
+	return 0;
+}
+
+static void dm9161_close(struct phy_mii_info *mii_info)
+{
+	struct dm9161_private *priv = mii_info->priv;
+
+	del_timer_sync(&priv->timer);
+	kfree(priv);
+}
+
+static int dm9161_ack_interrupt(struct phy_mii_info *mii_info)
+{
+	phy_read(mii_info, MII_DM9161_INTR);
+
+	return 0;
+}
+
+static int lxt970_read_status(struct phy_mii_info *mii_info)
+{
+	u16 status;
+	int err;
+
+	/* Update the link, but return if there
+	 * was an error */
+	err = genmii_update_link(mii_info);
+	if (err)
+		return err;
+
+	/* If the link is up, read the speed and duplex */
+	/* If we aren't autonegotiating, assume speeds 
+	 * are as set */
+	if (mii_info->autoneg && mii_info->link) {
+		status = phy_read(mii_info, MII_LXT970_CSR);
+		if (status & MII_LXT970_CSR_DUPLEX)
+			mii_info->duplex = DUPLEX_FULL;
+		else
+			mii_info->duplex = DUPLEX_HALF;
+
+		if (status & MII_LXT970_CSR_SPEED)
+			mii_info->speed = SPEED_100;
+		else
+			mii_info->speed = SPEED_10;
+	}
+
+	return 0;
+}
+
+static int lxt970_ack_interrupt(struct phy_mii_info *mii_info)
+{
+	phy_read(mii_info, MII_BMSR);
+	phy_read(mii_info, MII_LXT970_ISR);
+
+	return 0;
+}
+
+static int lxt970_config_intr(struct phy_mii_info *mii_info)
+{
+	if(mii_info->interrupts == MII_INTERRUPT_ENABLED)
+		phy_write(mii_info, MII_LXT970_IER, MII_LXT970_IER_IEN);
+	else
+		phy_write(mii_info, MII_LXT970_IER, 0);
+
+	return 0;
+}
+
+static int lxt970_init(struct phy_mii_info *mii_info)
+{
+	phy_write(mii_info, MII_LXT970_CONFIG, 0);
+
+	return 0;
+}
+
+
+static int lxt971_read_status(struct phy_mii_info *mii_info)
+{
+	u16 status;
+	int err;
+
+	/* Update the link, but return if there
+	 * was an error */
+	err = genmii_update_link(mii_info);
+	if (err)
+		return err;
+
+	/* If the link is up, read the speed and duplex */
+	/* If we aren't autonegotiating, assume speeds 
+	 * are as set */
+	if (mii_info->autoneg && mii_info->link) {
+		status = phy_read(mii_info, MII_LXT971_SR2);
+		if (status & MII_LXT971_SR2_DUPLEX)
+			mii_info->duplex = DUPLEX_FULL;
+		else
+			mii_info->duplex= DUPLEX_HALF;
+
+		if (status & MII_LXT971_SR2_SPEED)
+			mii_info->speed = SPEED_100;
+		else
+			mii_info->speed = SPEED_10;
+	}
+
+	return 0;
+}
+
+static int lxt971_ack_interrupt(struct phy_mii_info *mii_info)
+{
+	phy_read(mii_info, MII_LXT971_ISR);
+
+	return 0;
+}
+
+static int lxt971_config_intr(struct phy_mii_info *mii_info)
+{
+	if(mii_info->interrupts == MII_INTERRUPT_ENABLED)
+		phy_write(mii_info, MII_LXT971_IER, MII_LXT971_IER_IEN);
+	else
+		phy_write(mii_info, MII_LXT971_IER, 0);
+
+	return 0;
+}
+
+static int qs6612_read_status(struct phy_mii_info *mii_info)
+{
+	u16 status;
+	int err;
+
+	/* Update the link, but return if there
+	 * was an error */
+	err = genmii_update_link(mii_info);
+	if (err)
+		return err;
+
+	/* If the link is up, read the speed and duplex */
+	/* If we aren't autonegotiating, assume speeds 
+	 * are as set */
+	if (mii_info->autoneg && mii_info->link) {
+		status = phy_read(mii_info, MII_QS6612_PCR);
+		switch((status >> 2) & 7) {
+			case 1: mii_info->speed = 10;
+				mii_info->duplex = 0;
+				break;
+			case 2: mii_info->speed = 100;
+				mii_info->duplex = 0;
+				break;
+			case 5: mii_info->speed = 10;
+				mii_info->duplex = 1;
+				break;
+			case 6: mii_info->speed = 100;
+				mii_info->duplex = 1;
+				break;
+		}
+	}
+
+	return 0;
+}
+
+int qs6612_init(struct phy_mii_info *mii_info)
+{
+	/* The PHY powers up isolated on the RPX,
+	 * so send a command to allow operation.
+	 * XXX - I don't have the docs, so for 
+	 * now this constant is "magic" -Andy
+	 */
+	phy_write(mii_info, MII_QS6612_PCR, 0x0dc0);
+
+	return 0;
+}
+
+int qs6612_ack_interrupt(struct phy_mii_info *mii_info)
+{
+	phy_read(mii_info, MII_QS6612_ISR);
+	phy_read(mii_info, MII_BMSR);
+	phy_read(mii_info, MII_EXPANSION);
+
+	return 0;
+}
+
+int qs6612_config_intr(struct phy_mii_info *mii_info)
+{
+	if(mii_info->interrupts == MII_INTERRUPT_ENABLED)
+		phy_write(mii_info, MII_QS6612_IMR,
+				MII_QS6612_IMR_INIT);
+	else
+		phy_write(mii_info, MII_QS6612_IMR, 0);
+
+	return 0;
+
+}
+
+#if 0
+static struct phy_info phy_info_qs6612 = {
+	0x00181440,
+	"QS6612",
+	0,
+
+	(const struct phy_cmd []) {  /* config */
+		{ MII_QS6612_PCR, 0x0dc0, NULL },
+		{ miim_end, }
+	},
+	(const struct phy_cmd []) {  /* startup - enable interrupts */
+		/* parse cr and anar to get some info */
+		{ MII_QS6612_IMR, 0x003a, NULL },
+		{ MII_REG_CR, 0x1200, NULL }, /* autonegotiate */
+		{ miim_end, }
+	},
+	(const struct phy_cmd []) { /* ack_int */
+		/* we need to read ISR, SR and ANER to acknowledge */
+		{ MII_QS6612_ISR, miim_read, NULL },
+		{ MII_REG_SR, miim_read, mii_parse_sr },
+		{ MII_REG_ANER, miim_read, NULL },
+		{ miim_end, }
+	},
+	(const struct phy_cmd []) { /* handle_int */
+		/* read pcr to get info */
+		{ MII_REG_SR, miim_read, mii_parse_sr },
+		{ MII_QS6612_PCR, miim_read, mii_parse_qs6612_pcr },
+		{ miim_end, }
+	},
+	(const struct phy_cmd []) {  /* shutdown - disable interrupts */
+		{ MII_QS6612_IMR, 0x0000, NULL },
+		{ miim_end, }
+	},
+};
+#endif
+
+int dm9161_config_intr(struct phy_mii_info *mii_info)
+{
+	u16 temp;
+
+	temp = phy_read(mii_info, MII_DM9161_INTR);
+
+	if(mii_info->interrupts == MII_INTERRUPT_ENABLED)
+		temp &= ~(MII_DM9161_INTR_STOP);
+	else
+		temp |= MII_DM9161_INTR_STOP;
+
+	phy_write(mii_info, MII_DM9161_INTR, temp);
+
+	return 0;
+}
+
+static struct phy_info phy_info_marvell = {
+	.phy_id		= 0x01410c00,
+	.phy_id_mask	= 0xffffff00,
+	.name		= "Marvell 88E1101",
+	.features	= MII_GBIT_FEATURES,
+	.config_aneg	= &marvell_config_aneg,
+	.read_status	= &marvell_read_status,
+	.ack_interrupt	= &marvell_ack_interrupt,
+	.config_intr	= &marvell_config_intr,
+};
+
+/* Cicada 820x */
+static struct phy_info phy_info_cis820x = {
+	0x000fc440,
+	"Cicada Cis8204",
+	0x000fffc0,
+	.features	= MII_GBIT_FEATURES,
+	.init		= &cis820x_init,
+	.config_aneg	= &gbit_config_aneg,
+	.read_status	= &cis820x_read_status,
+	.ack_interrupt	= &cis820x_ack_interrupt,
+	.config_intr	= &cis820x_config_intr,
+};
+
+static struct phy_info phy_info_lxt970 = {
+	.phy_id		= 0x07810000,
+	.name		= "LXT970",
+	.phy_id_mask	= 0x0fffffff,
+	.init		= lxt970_init,
+	.config_aneg	= genmii_config_aneg,
+	.read_status	= lxt970_read_status,
+	.ack_interrupt	= lxt970_ack_interrupt,
+	.config_intr	= lxt970_config_intr,
+};
+
+static struct phy_info phy_info_lxt971 = {
+	.phy_id		= 0x0001378e,
+	.name		= "LXT971",
+	.phy_id_mask	= 0x0fffffff,
+	.config_aneg	= genmii_config_aneg,
+	.read_status	= lxt971_read_status,
+	.ack_interrupt	= lxt971_ack_interrupt,
+	.config_intr	= lxt971_config_intr,
+};
+
+static struct phy_info phy_info_dm9161 = {
+	.phy_id		= 0x0181b880,
+	.name		= "Davicom DM9161E",
+	.phy_id_mask	= 0x0ffffff0,
+	.init		= dm9161_init,
+	.config_aneg	= dm9161_config_aneg,
+	.read_status	= dm9161_read_status,
+	.close		= dm9161_close,
+};
+
+static struct phy_info phy_info_dm9131 = {
+	.phy_id		= 0x00181b80,
+	.name		= "Davicom DM9131",
+	.phy_id_mask	= 0x0ffffff0,
+	.config_aneg	= genmii_config_aneg,
+	.read_status	= dm9161_read_status,
+	.ack_interrupt	= dm9161_ack_interrupt,
+	.config_intr	= dm9161_config_intr,
+};
+
+static struct phy_info phy_info_qs6612 = {
+	.phy_id		= 0x00181440,
+	.name		= "QS6612",
+	.phy_id_mask	= 0xfffffff0,
+	.init		= qs6612_init,
+	.config_aneg	= genmii_config_aneg,
+	.read_status	= qs6612_read_status,
+	.ack_interrupt	= qs6612_ack_interrupt,
+	.config_intr	= qs6612_config_intr,
+};
+
+static struct phy_info phy_info_genmii= {
+	.phy_id		= 0x00000000,
+	.phy_id_mask	= 0x00000000,
+	.name		= "Generic MII",
+	.features	= MII_BASIC_FEATURES,
+	.config_aneg	= genmii_config_aneg,
+	.read_status	= genmii_read_status,
+};
+
+static struct phy_info *phy_info[] = {
+	&phy_info_cis820x,
+	&phy_info_marvell,
+	&phy_info_lxt970,
+	&phy_info_lxt971,
+	&phy_info_dm9131,
+	&phy_info_dm9161,
+	&phy_info_qs6612,
+	&phy_info_genmii,
+	NULL
+};
+
diff -Nru a/include/asm-ppc/cputable.h b/include/asm-ppc/cputable.h
--- a/include/asm-ppc/cputable.h	2004-10-29 19:58:14 -05:00
+++ b/include/asm-ppc/cputable.h	2004-10-29 19:58:14 -05:00
@@ -65,7 +65,7 @@
 #define CPU_FTR_TAU			0x00000010
 #define CPU_FTR_CAN_DOZE		0x00000020
 #define CPU_FTR_USE_TB			0x00000040
-#define CPU_FTR_604_PERF_MON		0x00000080
+#define CPU_FTR_CAN_USE_PMON_INTR	0x00000080
 #define CPU_FTR_601			0x00000100
 #define CPU_FTR_HPTE_TABLE		0x00000200
 #define CPU_FTR_CAN_NAP			0x00000400
@@ -77,6 +77,7 @@
 #define CPU_FTR_HAS_HIGH_BATS		0x00010000
 #define CPU_FTR_NEED_COHERENT           0x00020000
 #define CPU_FTR_NO_BTIC			0x00040000
+#define CPU_FTR_FSL_BOOKE_PMON		0x00080000
 
 #ifdef __ASSEMBLY__
 
diff -Nru a/include/asm-ppc/perfmon.h b/include/asm-ppc/perfmon.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/asm-ppc/perfmon.h	2004-10-29 19:58:14 -05:00
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
diff -Nru a/include/asm-ppc/ptrace.h b/include/asm-ppc/ptrace.h
--- a/include/asm-ppc/ptrace.h	2004-10-29 19:58:14 -05:00
+++ b/include/asm-ppc/ptrace.h	2004-10-29 19:58:14 -05:00
@@ -35,6 +35,10 @@
 	unsigned long dar;		/* Fault registers */
 	unsigned long dsisr;		/* on 4xx/Book-E used for ESR */
 	unsigned long result; 		/* Result of a system call */
+
+	/* Address of instruction which caused a performance
+	 * monitor interrupt */
+	unsigned long sia;
 };
 
 #endif /* __ASSEMBLY__ */
diff -Nru a/include/asm-ppc/reg_booke.h b/include/asm-ppc/reg_booke.h
--- a/include/asm-ppc/reg_booke.h	2004-10-29 19:58:14 -05:00
+++ b/include/asm-ppc/reg_booke.h	2004-10-29 19:58:14 -05:00
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
diff -Nru a/include/linux/phy.h b/include/linux/phy.h
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/include/linux/phy.h	2004-10-29 19:58:15 -05:00
@@ -0,0 +1,251 @@
+/* 
+ * include/linux/phy.h
+ *
+ * Framework and drivers for configuring and reading different PHYs
+ * Based on code in sungem_phy.c and gianfar_phy.c
+ *
+ * Author: Andy Fleming
+ *
+ * Copyright (c) 2004 Freescale Semiconductor, Inc.
+ *
+ * This program is free software; you can redistribute  it and/or modify it
+ * under  the terms of  the GNU General  Public License as published by the
+ * Free Software Foundation;  either version 2 of the  License, or (at your
+ * option) any later version.
+ *
+ */
+
+#ifndef __PHY_H
+#define __PHY_H
+
+/* 1000BT control (Marvell & BCM54xx at least) */
+#define MII_1000BASETCONTROL			0x09
+#define MII_1000BASETCONTROL_FULLDUPLEXCAP	0x0200
+#define MII_1000BASETCONTROL_HALFDUPLEXCAP	0x0100
+
+/* Cicada Extended Control Register 1 */
+#define MII_CIS8201_EXT_CON1           0x17
+#define MII_CIS8201_EXTCON1_INIT       0x0000
+
+/* Cicada Interrupt Mask Register */
+#define MII_CIS8201_IMASK		0x19
+#define MII_CIS8201_IMASK_IEN		0x8000
+#define MII_CIS8201_IMASK_SPEED	0x4000
+#define MII_CIS8201_IMASK_LINK		0x2000
+#define MII_CIS8201_IMASK_DUPLEX	0x1000
+#define MII_CIS8201_IMASK_MASK		0xf000
+
+/* Cicada Interrupt Status Register */
+#define MII_CIS8201_ISTAT		0x1a
+#define MII_CIS8201_ISTAT_STATUS	0x8000
+#define MII_CIS8201_ISTAT_SPEED	0x4000
+#define MII_CIS8201_ISTAT_LINK		0x2000
+#define MII_CIS8201_ISTAT_DUPLEX	0x1000
+
+/* Cicada Auxiliary Control/Status Register */
+#define MII_CIS8201_AUX_CONSTAT        0x1c
+#define MII_CIS8201_AUXCONSTAT_INIT    0x0004
+#define MII_CIS8201_AUXCONSTAT_DUPLEX  0x0020
+#define MII_CIS8201_AUXCONSTAT_SPEED   0x0018
+#define MII_CIS8201_AUXCONSTAT_GBIT    0x0010
+#define MII_CIS8201_AUXCONSTAT_100     0x0008
+                                                                                
+/* 88E1011 PHY Status Register */
+#define MII_M1011_PHY_SPEC_STATUS		0x11
+#define MII_M1011_PHY_SPEC_STATUS_1000		0x8000
+#define MII_M1011_PHY_SPEC_STATUS_100		0x4000
+#define MII_M1011_PHY_SPEC_STATUS_SPD_MASK	0xc000
+#define MII_M1011_PHY_SPEC_STATUS_FULLDUPLEX	0x2000
+#define MII_M1011_PHY_SPEC_STATUS_RESOLVED	0x0800
+#define MII_M1011_PHY_SPEC_STATUS_LINK		0x0400
+
+#define MII_M1011_IEVENT		0x13
+#define MII_M1011_IEVENT_CLEAR		0x0000
+
+#define MII_M1011_IMASK			0x12
+#define MII_M1011_IMASK_INIT		0x6400
+#define MII_M1011_IMASK_CLEAR		0x0000
+
+#define MII_DM9161_SCR		0x10
+#define MII_DM9161_SCR_INIT	0x0610
+
+/* DM9161 Specified Configuration and Status Register */
+#define MII_DM9161_SCSR	0x11
+#define MII_DM9161_SCSR_100F	0x8000
+#define MII_DM9161_SCSR_100H	0x4000
+#define MII_DM9161_SCSR_10F	0x2000
+#define MII_DM9161_SCSR_10H	0x1000
+
+/* DM9161 Interrupt Register */
+#define MII_DM9161_INTR	0x15
+#define MII_DM9161_INTR_PEND		0x8000
+#define MII_DM9161_INTR_DPLX_MASK	0x0800
+#define MII_DM9161_INTR_SPD_MASK	0x0400
+#define MII_DM9161_INTR_LINK_MASK	0x0200
+#define MII_DM9161_INTR_MASK		0x0100
+#define MII_DM9161_INTR_DPLX_CHANGE	0x0010
+#define MII_DM9161_INTR_SPD_CHANGE	0x0008
+#define MII_DM9161_INTR_LINK_CHANGE	0x0004
+#define MII_DM9161_INTR_INIT 		0x0000
+#define MII_DM9161_INTR_STOP	\
+(MII_DM9161_INTR_DPLX_MASK | MII_DM9161_INTR_SPD_MASK \
+ | MII_DM9161_INTR_LINK_MASK | MII_DM9161_INTR_MASK)
+
+/* DM9161 10BT Configuration/Status */
+#define MII_DM9161_10BTCSR	0x12
+#define MII_DM9161_10BTCSR_INIT	0x7800
+
+/* The Level one LXT970 is used by many boards				     */
+
+#define MII_LXT970_MIRROR    16  /* Mirror register           */
+#define MII_LXT970_IER       17  /* Interrupt Enable Register */
+
+#define MII_LXT970_IER_IEN	0x0002
+
+#define MII_LXT970_ISR       18  /* Interrupt Status Register */
+
+#define MII_LXT970_CONFIG    19  /* Configuration Register    */
+#define MII_LXT970_CSR       20  /* Chip Status Register      */
+
+#define MII_LXT970_CSR_DUPLEX 0x1000
+#define MII_LXT970_CSR_SPEED 0x0800
+
+/* ------------------------------------------------------------------------- */
+/* The Level one LXT971 is used on some of my custom boards                  */
+
+/* register definitions for the 971 */
+
+#define MII_LXT971_PCR		16  /* Port Control Register     */
+
+#define MII_LXT971_SR2		17  /* Status Register 2         */
+#define MII_LXT971_SR2_DUPLEX	0x0200
+#define MII_LXT971_SR2_SPEED	0x4000
+
+#define MII_LXT971_IER		18  /* Interrupt Enable Register */
+#define MII_LXT971_IER_IEN	0x00f2
+
+#define MII_LXT971_ISR		19  /* Interrupt Status Register */
+
+#define MII_LXT971_LCR		20  /* LED Control Register      */
+
+#define MII_LXT971_TCR		30  /* Transmit Control Register */
+
+
+/* ------------------------------------------------------------------------- */
+/* The Quality Semiconductor QS6612 is used on the RPX CLLF                  */
+
+/* register definitions */
+
+#define MII_QS6612_MCR		17  /* Mode Control Register      */
+#define MII_QS6612_FTR		27  /* Factory Test Register      */
+#define MII_QS6612_MCO		28  /* Misc. Control Register     */
+#define MII_QS6612_ISR		29  /* Interrupt Source Register  */
+#define MII_QS6612_IMR		30  /* Interrupt Mask Register    */
+#define MII_QS6612_IMR_INIT	0x003a
+#define MII_QS6612_PCR		31  /* 100BaseTx PHY Control Reg. */
+
+#define MII_BASIC_FEATURES	(SUPPORTED_10baseT_Half | \
+				 SUPPORTED_10baseT_Full | \
+				 SUPPORTED_100baseT_Half | \
+				 SUPPORTED_100baseT_Full | \
+				 SUPPORTED_Autoneg | \
+				 SUPPORTED_TP | \
+				 SUPPORTED_MII)
+
+#define MII_GBIT_FEATURES	(MII_BASIC_FEATURES | \
+				 SUPPORTED_1000baseT_Half | \
+				 SUPPORTED_1000baseT_Full)
+
+#define MII_INTERRUPT_DISABLED 0x0
+#define MII_INTERRUPT_ENABLED 0x1
+/* Taken from mii_if_info and sungem_phy.h */
+struct phy_mii_info {
+	/* Information about the PHY type */
+	/* And management functions */
+	struct phy_info *phyinfo;
+
+	/* forced speed & duplex (no autoneg)
+	 * partner speed & duplex & pause (autoneg)
+	 */
+	int speed;
+	int duplex;
+	int pause;
+
+	/* The most recently read link state */
+	int link;
+
+	/* Enabled Interrupts */
+	u32 interrupts;
+
+	u32 advertising;
+	int autoneg;
+	int mii_id;
+
+	/* private data pointer */
+	/* For use by PHYs to maintain extra state */
+	void *priv;
+
+	/* Provided by host chip */
+	struct net_device *dev;
+
+	/* A lock to ensure that only one thing can read/write
+	 * the MDIO bus at a time */
+	spinlock_t mdio_lock;
+
+	/* Provided by ethernet driver */
+	int (*mdio_read) (struct net_device *dev, int mii_id, int reg);
+	void (*mdio_write) (struct net_device *dev, int mii_id, int reg, int val);
+};
+
+/* struct phy_info: a structure which defines attributes for a PHY
+ *
+ * id will contain a number which represents the PHY.  During
+ * startup, the driver will poll the PHY to find out what its
+ * UID--as defined by registers 2 and 3--is.  The 32-bit result
+ * gotten from the PHY will be ANDed with phy_id_mask to
+ * discard any bits which may change based on revision numbers
+ * unimportant to functionality
+ *
+ * There are 7 commands which take a phy_mii_info structure.
+ * Each PHY must declare config_aneg, and read_status.
+ */
+struct phy_info {
+	u32 phy_id;
+	char *name;
+	unsigned int phy_id_mask;
+	u32 features;
+
+	/* Called to initialize the PHY */
+	int (*init)(struct phy_mii_info *mii_info);
+
+	/* Called to suspend the PHY for power */
+	int (*suspend)(struct phy_mii_info *mii_info);
+
+	/* Reconfigures autonegotiation (or disables it) */
+	int (*config_aneg)(struct phy_mii_info *mii_info);
+
+	/* Determines the negotiated speed and duplex */
+	int (*read_status)(struct phy_mii_info *mii_info);
+
+	/* Clears any pending interrupts */
+	int (*ack_interrupt)(struct phy_mii_info *mii_info);
+
+	/* Enables or disables interrupts */
+	int (*config_intr)(struct phy_mii_info *mii_info);
+
+	/* Clears up any memory if needed */
+	void (*close)(struct phy_mii_info *mii_info);
+};
+
+struct dm9161_private {
+	struct timer_list timer;
+	int resetdone;
+};
+
+u16 phy_read(struct phy_mii_info *mii_info, u16 regnum);
+void phy_write(struct phy_mii_info *mii_info, u16 regnum, u16 val);
+struct phy_info * get_phy_info(struct phy_mii_info *mii_info);
+void mii_clear_phy_interrupt(struct phy_mii_info *mii_info);
+void mii_configure_phy_interrupt(struct phy_mii_info *mii_info, u32 interrupts);
+
+#endif /* __PHY_H */

--Apple-Mail-3-532732548--
