Return-Path: <afleming@freescale.com>
Received: from motgate8.mot.com (motgate8.mot.com [129.188.136.8])
	by ozlabs.org (Postfix) with ESMTP id 112282BDEB
	for <linuxppc-embedded@ozlabs.org>;
	Tue,  2 Nov 2004 04:03:30 +1100 (EST)
Received: from il06exr02.mot.com (il06exr02.mot.com [129.188.137.132])
	by motgate8.mot.com (Motorola/Motgate8) with ESMTP id iA1H4qnQ007578
	for <linuxppc-embedded@ozlabs.org>; Mon, 1 Nov 2004 10:04:52 -0700 (MST)
In-Reply-To: <0329659A-2BC9-11D9-A949-000393DBC2E8@freescale.com>
References: <642F8D42-2A11-11D9-A860-000393C30512@freescale.com>
	<0329659A-2BC9-11D9-A949-000393DBC2E8@freescale.com>
Mime-Version: 1.0 (Apple Message framework v619)
Content-Type: multipart/mixed; boundary=Apple-Mail-7-762314055
Message-Id: <ED6D9FBD-2C27-11D9-801F-000393C30512@freescale.com>
From: Andy Fleming <afleming@freescale.com>
Date: Mon, 1 Nov 2004 11:03:18 -0600
To: Kumar Gala <kumar.gala@freescale.com>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: RFC: performance monitor/oprofile support for e500
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


--Apple-Mail-7-762314055
Content-Transfer-Encoding: 7bit
Content-Type: text/plain;
	charset=US-ASCII;
	format=flowed

Well, it looks like I messed up the patch, and included some stuff I'm 
working on for generalizing the PHY interface.  Strange, because I 
thought I had hand-inspected that patch...  Ah, I see: I copied the 
wrong patch, which was done against linux-2.6, rather than my internal 
tree.  Please ignore the patch, since much of that code is obsolete.

Anyway, I will respond to Kumar's comments, and have attached the 
CORRECT patch:

On Oct 31, 2004, at 23:43, Kumar Gala wrote:

> Andy,
>
> Some feedback:
>
> * Any reason to get ride of the 604 code now,w/o replacing it with 
> something?

Well, it doesn't really do much, and I was told that no one was using 
it.  If people want, I can add it back.

> * Why have you introduce two CPU features (CPU_FTR_CAN_USE_PMON_INTR & 
> CPU_FTR_FSL_BOOKE_PMON) you dont use ?

Ah, this is for the near future, when I implement support for 74xx 
processors.  The non-Freescale-Book-E parts use a different perfmon 
scheme, and I wanted a way to distinguish.  It may not be useful, 
though, I agree, since I am using CONFIG_FSL_BOOKE to do this.  
CAN_USE_PMON_INTR is important, though, to detect the errata which 
could send the processor into never-neverland.  Eventually, some 74xx 
processors will have this bit set, while some will not.

> * In the PerformanceMonitor can't you use regs->nip for the same 
> purpose of regs->sia?

Hmmm.... somehow I missed this when I was looking for a way to get the 
sampled address.  I will change this if no one thinks of a good reason 
to do otherwise.

> * Does arch/ppc/kernel/perfmon.c really need all the headers you are 
> including?

Probably not.  Does anyone know an easy way to determine which headers 
are needed?

> * Does perfmon.c make more sense as perfmon_fsl_booke.c

Well, I thought about that, but I figured that it was ok to put all of 
the code into one file, and use #ifdef to distinguish.  I'm willing to 
divide it into two (one for FSL booke, and one for classic), though.

> * op_ppc32_setup, I'd prefer the saving & restoring of the perf_irq 
> like arch/ppc64/oprofile/common.c does

Well, does this really make sense?  If one driver grabs the interrupt, 
and a subsequent driver tries to grab it, do we want the second driver 
to win, but nicely restore the handler later, or do we want the second 
driver to fail, and give the user the chance to disable the other 
driver?  I definitely won't use the method in ppc64, since that isn't 
thread-safe if more than one driver wants the perfmon interrupt.

> * a number of issues related to SMP

I admit, I haven't carefully worked this out, as there aren't any SMP 
e500 systems out there.

> * any reason get_kernel is a function?

Nope.  Just legacy from having copied the ppc64 code.

> * Do ctr_read & ctr_write really belong in op_impl.h, especially since 
> different implementations will be needed for classic ppc.

Good point.  I will move these to op_model_e500.c

>
>
> I sent a note to Paul M. about putting num_counters into cpu_specs 
> table.

That would be good.



--Apple-Mail-7-762314055
Content-Transfer-Encoding: 7bit
Content-Type: application/octet-stream; x-unix-mode=0644;
	name="oprofile-kernel-patch2"
Content-Disposition: attachment;
	filename=oprofile-kernel-patch2

diff -Nru a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
--- a/arch/ppc/kernel/Makefile	2004-10-29 20:05:30 -05:00
+++ b/arch/ppc/kernel/Makefile	2004-10-29 20:05:30 -05:00
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
--- a/arch/ppc/kernel/asm-offsets.c	2004-10-29 20:05:30 -05:00
+++ b/arch/ppc/kernel/asm-offsets.c	2004-10-29 20:05:30 -05:00
@@ -118,6 +118,7 @@
 	DEFINE(ORIG_GPR3, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, orig_gpr3));
 	DEFINE(RESULT, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, result));
 	DEFINE(TRAP, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, trap));
+	DEFINE(SIA, STACK_FRAME_OVERHEAD+offsetof(struct pt_regs, sia));
 	DEFINE(CLONE_VM, CLONE_VM);
 	DEFINE(CLONE_UNTRACED, CLONE_UNTRACED);
 	DEFINE(MM_PGD, offsetof(struct mm_struct, pgd));
diff -Nru a/arch/ppc/kernel/cputable.c b/arch/ppc/kernel/cputable.c
--- a/arch/ppc/kernel/cputable.c	2004-10-29 20:05:30 -05:00
+++ b/arch/ppc/kernel/cputable.c	2004-10-29 20:05:30 -05:00
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
--- a/arch/ppc/kernel/head_e500.S	2004-10-29 20:05:30 -05:00
+++ b/arch/ppc/kernel/head_e500.S	2004-10-29 20:05:30 -05:00
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
+++ b/arch/ppc/kernel/perfmon.c	2004-10-29 20:05:30 -05:00
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
--- a/arch/ppc/kernel/ppc_htab.c	2004-10-29 20:05:30 -05:00
+++ b/arch/ppc/kernel/ppc_htab.c	2004-10-29 20:05:30 -05:00
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
--- a/arch/ppc/kernel/traps.c	2004-10-29 20:05:30 -05:00
+++ b/arch/ppc/kernel/traps.c	2004-10-29 20:05:30 -05:00
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
--- a/arch/ppc/oprofile/Makefile	2004-10-29 20:05:30 -05:00
+++ b/arch/ppc/oprofile/Makefile	2004-10-29 20:05:30 -05:00
@@ -6,4 +6,4 @@
 		oprofilefs.o oprofile_stats.o \
 		timer_int.o )
 
-oprofile-y := $(DRIVER_OBJS) init.o
+oprofile-y := $(DRIVER_OBJS) common.o op_model_e500.o
diff -Nru a/arch/ppc/oprofile/common.c b/arch/ppc/oprofile/common.c
--- /dev/null	Wed Dec 31 16:00:00 196900
+++ b/arch/ppc/oprofile/common.c	2004-10-29 20:05:30 -05:00
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
--- a/arch/ppc/oprofile/init.c	2004-10-29 20:05:30 -05:00
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
+++ b/arch/ppc/oprofile/op_impl.h	2004-10-29 20:05:30 -05:00
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
+++ b/arch/ppc/oprofile/op_model_e500.c	2004-10-29 20:05:30 -05:00
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
diff -Nru a/include/asm-ppc/cputable.h b/include/asm-ppc/cputable.h
--- a/include/asm-ppc/cputable.h	2004-10-29 20:05:30 -05:00
+++ b/include/asm-ppc/cputable.h	2004-10-29 20:05:30 -05:00
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
+++ b/include/asm-ppc/perfmon.h	2004-10-29 20:05:30 -05:00
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
--- a/include/asm-ppc/ptrace.h	2004-10-29 20:05:30 -05:00
+++ b/include/asm-ppc/ptrace.h	2004-10-29 20:05:30 -05:00
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
--- a/include/asm-ppc/reg_booke.h	2004-10-29 20:05:30 -05:00
+++ b/include/asm-ppc/reg_booke.h	2004-10-29 20:05:30 -05:00
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

--Apple-Mail-7-762314055--
