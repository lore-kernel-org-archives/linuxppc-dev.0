Date: Thu, 1 Aug 2002 11:14:57 -0700
From: Tom Rini <trini@kernel.crashing.org>
To: linuxppc-dev <linuxppc-dev@lists.linuxppc.org>
Subject: [RFC/PATCH] idle loop changes, take 2
Message-ID: <20020801181457.GE3519@opus.bloom.county>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Sender: owner-linuxppc-dev@lists.linuxppc.org
List-Id: <linuxppc-dev@lists.linuxppc.org>


The following is my next cut at changes to the idle loop.  Since the
last time, I've made two minor changes:
1) On CONFIG_6xx, we set pm_idle before the call to platform_init().
This means that every platform will have the option of changing pm_idle
to something more board specific, if desired by that platform.  This
should hopefully will out Dan Malek's request (or as much as can be done
in this part.  Changing drivers for clock speeds is platform dependant.
:)).

2) This makes the powersave-nap sysctl CONFIG_6xx-specific, as it's
functionality is only currently useful there.

Any more comments?

--
Tom Rini (TR1265)
http://gate.crashing.org/~trini/

===== arch/ppc/kernel/Makefile 1.107 vs edited =====
--- 1.107/arch/ppc/kernel/Makefile	Fri Jul 26 11:01:16 2002
+++ edited/arch/ppc/kernel/Makefile	Wed Jul 31 13:39:21 2002
@@ -41,7 +41,7 @@
 					process.o signal.o ptrace.o align.o \
 					semaphore.o syscalls.o setup.o \
 					cputable.o ppc_htab.o
-obj-$(CONFIG_6xx)		+= l2cr.o
+obj-$(CONFIG_6xx)		+= l2cr.o ppc6xx_idle.o
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
 obj-$(CONFIG_PCI)		+= pci.o
 ifneq ($(CONFIG_PPC_ISERIES),y)
===== arch/ppc/kernel/idle.c 1.32 vs edited =====
--- 1.32/arch/ppc/kernel/idle.c	Sun Jul 28 22:00:01 2002
+++ edited/arch/ppc/kernel/idle.c	Wed Jul 31 13:39:21 2002
@@ -11,6 +11,11 @@
  * modify it under the terms of the GNU General Public License
  * as published by the Free Software Foundation; either version
  * 2 of the License, or (at your option) any later version.
+ *
+ *  07/27/02 - Armin & Tom.
+ *  added powersave idle loop indirection scheme borrowed from
+ *  i386 & arm so other PPC archs can have their own if the
+ *  default is not sufficiant.
  */
 #include <linux/config.h>
 #include <linux/errno.h>
@@ -50,9 +55,9 @@

 void zero_paged(void);
 void power_save(void);
+void (*pm_idle)(void);

 unsigned long zero_paged_on = 0;
-unsigned long powersave_nap = 0;

 unsigned long *zero_cache;    /* head linked list of pre-zero'd pages */
 atomic_t zerototal;      /* # pages zero'd over time */
@@ -96,8 +101,12 @@
 			}
 		}
 #endif
+		void (*idle)(void) = pm_idle;
+		if (!idle)
+			idle = power_save;
+
 		if (do_power_save && !current->need_resched)
-			power_save();
+			idle();

 		if (current->need_resched) {
 			run_light_on(1);
@@ -262,17 +271,11 @@
 }
 #endif /* 0 */

-#define DSSALL		.long	(0x1f<<26)+(0x10<<21)+(0x336<<1)
-
 void power_save(void)
 {
-	unsigned long hid0;
-	int nap = powersave_nap;
-
-	/* 7450 has no DOZE mode mode, we return if powersave_nap
-	 * isn't enabled
-	 */
-	if (!(nap || (cur_cpu_spec[smp_processor_id()]->cpu_features & CPU_FTR_CAN_DOZE)))
+	/* Make sure the CPU has the DOZE feature set. */
+	if (!(cur_cpu_spec[smp_processor_id()]->cpu_features
+				& CPU_FTR_CAN_DOZE))
 		return;
 	/*
 	 * Disable interrupts to prevent a lost wakeup
@@ -287,28 +290,7 @@
 	 *  -- Cort
 	 */
 	_nmask_and_or_msr(MSR_EE, 0);
-	if (!current->need_resched)
-	{
-#ifndef CONFIG_4xx
-		__asm__ __volatile__("mfspr %0,1008" : "=r" (hid0) :);
-		hid0 &= ~(HID0_NAP | HID0_SLEEP | HID0_DOZE);
-		hid0 |= (powersave_nap? HID0_NAP: HID0_DOZE) | HID0_DPM;
-		__asm__ __volatile__("mtspr 1008,%0" : : "r" (hid0));
-		/* Flush pending data streams, consider this instruction
-		 * exist on all altivec capable CPUs
-		 */
-		__asm__ __volatile__(
-			"98:	" __stringify(DSSALL) "\n"
-			"	sync\n"
-			"99:\n"
-			".section __ftr_fixup,\"a\"\n"
-			"	.long %0\n"
-			"	.long %1\n"
-			"	.long 98b\n"
-			"	.long 99b\n"
-			".previous" : : "i" (CPU_FTR_ALTIVEC), "i" (CPU_FTR_ALTIVEC));
-#endif /* !CONFIG_4xx */
-
+	if (!current->need_resched) {
 		/* set the POW bit in the MSR, and enable interrupts
 		 * so we wake up sometime! */
 		_nmask_and_or_msr(0, MSR_POW | MSR_EE);
===== arch/ppc/kernel/setup.c 1.104 vs edited =====
--- 1.104/arch/ppc/kernel/setup.c	Wed Jul  3 09:23:02 2002
+++ edited/arch/ppc/kernel/setup.c	Wed Jul 31 13:40:33 2002
@@ -55,6 +55,9 @@
 extern void kgdb_map_scc(void);
 #endif

+extern void (*pm_idle)(void);
+extern void ppc6xx_pm_idle(void);
+
 extern boot_infos_t *boot_infos;
 char saved_command_line[512];
 extern char cmd_line[512];
@@ -509,6 +512,10 @@
 #ifdef CONFIG_CMDLINE
 	strcpy(cmd_line, CONFIG_CMDLINE);
 #endif /* CONFIG_CMDLINE */
+
+#ifdef CONFIG_6xx
+	pm_idle = ppc6xx_pm_idle;
+#endif

 	platform_init(r3, r4, r5, r6, r7);

===== kernel/sysctl.c 1.23 vs edited =====
--- 1.23/kernel/sysctl.c	Tue Jul 16 21:19:52 2002
+++ edited/kernel/sysctl.c	Thu Aug  1 09:51:57 2002
@@ -87,8 +87,9 @@
 #endif

 #ifdef CONFIG_PPC32
-extern unsigned long zero_paged_on, powersave_nap;
+extern unsigned long zero_paged_on;
 #ifdef CONFIG_6xx
+extern unsigned long powersave_nap;
 int proc_dol2crvec(ctl_table *table, int write, struct file *filp,
 		  void *buffer, size_t *lenp);
 #endif
@@ -190,9 +191,9 @@
 #ifdef CONFIG_PPC32
 	{KERN_PPC_ZEROPAGED, "zero-paged", &zero_paged_on, sizeof(int),
 	 0644, NULL, &proc_dointvec},
+#ifdef CONFIG_6xx
 	{KERN_PPC_POWERSAVE_NAP, "powersave-nap", &powersave_nap, sizeof(int),
 	 0644, NULL, &proc_dointvec},
-#ifdef CONFIG_6xx
 	{KERN_PPC_L2CR, "l2cr", NULL, 0,
 	 0644, NULL, &proc_dol2crvec},
 #endif
--- a/arch/ppc/kernel/ppc6xx_idle.c	1969-12-31 17:00:00.000000000 -0700
+++ b/arch/ppc/kernel/ppc6xx_idle.c	2002-07-31 13:39:21.000000000 -0700
@@ -0,0 +1,76 @@
+/*
+ * BK Id: %F% %I% %G% %U% %#%
+ */
+/*
+ * power_save() rountine for classic PPC CPUs.
+ *
+ * Written by Cort Dougan (cort@cs.nmt.edu)
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ *
+ */
+#include <linux/sched.h>
+#include <linux/smp.h>
+#include <linux/stringify.h>
+
+#include <asm/cputable.h>
+#include <asm/current.h>
+#include <asm/processor.h>
+
+unsigned long powersave_nap = 0;
+
+#define DSSALL		.long	(0x1f<<26)+(0x10<<21)+(0x336<<1)
+
+void
+ppc6xx_pm_idle(void)
+{
+	unsigned long hid0;
+	int nap = powersave_nap;
+
+	/* 7450 has no DOZE mode mode, we return if powersave_nap
+	 * isn't enabled
+	 */
+	if (!(nap || (cur_cpu_spec[smp_processor_id()]->cpu_features
+		      & CPU_FTR_CAN_DOZE)))
+		return;
+	/*
+	 * Disable interrupts to prevent a lost wakeup
+	 * when going to sleep.  This is necessary even with
+	 * RTLinux since we are not guaranteed an interrupt
+	 * didn't come in and is waiting for a __sti() before
+	 * emulating one.  This way, we really do hard disable.
+	 *
+	 * We assume that we're sti-ed when we come in here.  We
+	 * are in the idle loop so if we're cli-ed then it's a bug
+	 * anyway.
+	 *  -- Cort
+	 */
+	_nmask_and_or_msr(MSR_EE, 0);
+	if (!current->need_resched) {
+		__asm__ __volatile__("mfspr %0,1008":"=r"(hid0):);
+		hid0 &= ~(HID0_NAP | HID0_SLEEP | HID0_DOZE);
+		hid0 |= (powersave_nap ? HID0_NAP : HID0_DOZE) | HID0_DPM;
+		__asm__ __volatile__("mtspr 1008,%0"::"r"(hid0));
+		/* Flush pending data streams, consider this instruction
+		 * exist on all altivec capable CPUs
+		 */
+		__asm__ __volatile__("98:	" __stringify(DSSALL) "\n"
+				     "	sync\n"
+				     "99:\n"
+				     ".section __ftr_fixup,\"a\"\n"
+				     "	.long %0\n"
+				     "	.long %1\n"
+				     "	.long 98b\n"
+				     "	.long 99b\n"
+				     ".previous"::"i"
+				     (CPU_FTR_ALTIVEC), "i"(CPU_FTR_ALTIVEC));
+
+		/* set the POW bit in the MSR, and enable interrupts
+		 * so we wake up sometime! */
+		_nmask_and_or_msr(0, MSR_POW | MSR_EE);
+	}
+	_nmask_and_or_msr(0, MSR_EE);
+}

** Sent via the linuxppc-dev mail list. See http://lists.linuxppc.org/
