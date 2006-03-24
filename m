Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17443.49609.63829.380622@cargo.ozlabs.ibm.com>
Date: Fri, 24 Mar 2006 20:54:17 +1100
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Unify the 32 and 64 bit idle loops
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This unifies the 32-bit (ARCH=ppc and ARCH=powerpc) and 64-bit idle
loops.  It brings over the concept of having a ppc_md.power_save
function from 32-bit to ARCH=powerpc, which lets us get rid of
native_idle().  With that, we can also reduce the amount of special
code for pSeries and cell because the special code has only to do what
needs to be done when there is no work to do, rather than being a
complete idle loop.

iSeries still has its own idle loops because it wants to test
hvlpevents_pending() as well as need_resched() etc.  I don't know if
that is essential but I have left it as-is for now.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
diff --git a/arch/powerpc/kernel/Makefile b/arch/powerpc/kernel/Makefile
index 80e9fe2..f2c47e9 100644
--- a/arch/powerpc/kernel/Makefile
+++ b/arch/powerpc/kernel/Makefile
@@ -10,16 +10,16 @@ CFLAGS_prom_init.o      += -fPIC
 CFLAGS_btext.o		+= -fPIC
 endif
 
 obj-y				:= semaphore.o cputable.o ptrace.o syscalls.o \
 				   irq.o align.o signal_32.o pmc.o vdso.o \
-				   init_task.o process.o systbl.o
+				   init_task.o process.o systbl.o idle.o
 obj-y				+= vdso32/
 obj-$(CONFIG_PPC64)		+= setup_64.o binfmt_elf32.o sys_ppc32.o \
 				   signal_64.o ptrace32.o \
 				   paca.o cpu_setup_power4.o \
-				   firmware.o sysfs.o idle_64.o
+				   firmware.o sysfs.o
 obj-$(CONFIG_PPC64)		+= vdso64/
 obj-$(CONFIG_ALTIVEC)		+= vecemu.o vector.o
 obj-$(CONFIG_POWER4)		+= idle_power4.o
 obj-$(CONFIG_PPC_OF)		+= of_device.o prom_parse.o
 procfs-$(CONFIG_PPC64)		:= proc_ppc64.o
@@ -32,10 +32,11 @@ obj-$(CONFIG_LPARCFG)		+= lparcfg.o
 obj-$(CONFIG_IBMVIO)		+= vio.o
 obj-$(CONFIG_IBMEBUS)           += ibmebus.o
 obj-$(CONFIG_GENERIC_TBSYNC)	+= smp-tbsync.o
 obj64-$(CONFIG_PPC_MULTIPLATFORM) += nvram_64.o
 obj-$(CONFIG_CRASH_DUMP)	+= crash_dump.o
+obj-$(CONFIG_6xx)		+= idle_6xx.o
 
 ifeq ($(CONFIG_PPC_MERGE),y)
 
 extra-$(CONFIG_PPC_STD_MMU)	:= head_32.o
 extra-$(CONFIG_PPC64)		:= head_64.o
@@ -49,11 +50,10 @@ obj-y				+= time.o prom.o traps.o setup-
 obj-$(CONFIG_PPC32)		+= entry_32.o setup_32.o misc_32.o
 obj-$(CONFIG_PPC64)		+= misc_64.o dma_64.o iommu.o
 obj-$(CONFIG_PPC_MULTIPLATFORM)	+= prom_init.o
 obj-$(CONFIG_MODULES)		+= ppc_ksyms.o
 obj-$(CONFIG_BOOTX_TEXT)	+= btext.o
-obj-$(CONFIG_6xx)		+= idle_6xx.o
 obj-$(CONFIG_SMP)		+= smp.o
 obj-$(CONFIG_KPROBES)		+= kprobes.o
 obj-$(CONFIG_PPC_UDBG_16550)	+= legacy_serial.o udbg_16550.o
 module-$(CONFIG_PPC64)		+= module_64.o
 obj-$(CONFIG_MODULES)		+= $(module-y)
diff --git a/arch/powerpc/kernel/entry_32.S b/arch/powerpc/kernel/entry_32.S
index 4827ca1..b3a9794 100644
--- a/arch/powerpc/kernel/entry_32.S
+++ b/arch/powerpc/kernel/entry_32.S
@@ -133,14 +133,14 @@ transfer_to_handler:
          */
 #ifdef CONFIG_6xx
 	mfspr	r11,SPRN_HID0
 	mtcr	r11
 BEGIN_FTR_SECTION
-	bt-	8,power_save_6xx_restore	/* Check DOZE */
+	bt-	8,4f			/* Check DOZE */
 END_FTR_SECTION_IFSET(CPU_FTR_CAN_DOZE)
 BEGIN_FTR_SECTION
-	bt-	9,power_save_6xx_restore	/* Check NAP */
+	bt-	9,4f			/* Check NAP */
 END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
 #endif /* CONFIG_6xx */
 	.globl transfer_to_handler_cont
 transfer_to_handler_cont:
 	lwz	r11,THREAD_INFO-THREAD(r12)
@@ -155,10 +155,14 @@ transfer_to_handler_cont:
 	mtspr	SPRN_SRR1,r10
 	mtlr	r9
 	SYNC
 	RFI				/* jump to handler, enable MMU */
 
+#ifdef CONFIG_6xx	
+4:	b	power_save_6xx_restore
+#endif
+
 /*
  * On kernel stack overflow, load up an initial stack pointer
  * and call StackOverflow(regs), which should not return.
  */
 stack_ovf:
diff --git a/arch/powerpc/kernel/idle.c b/arch/powerpc/kernel/idle.c
new file mode 100644
index 0000000..e9f321d
--- /dev/null
+++ b/arch/powerpc/kernel/idle.c
@@ -0,0 +1,122 @@
+/*
+ * Idle daemon for PowerPC.  Idle daemon will handle any action
+ * that needs to be taken when the system becomes idle.
+ *
+ * Originally written by Cort Dougan (cort@cs.nmt.edu).
+ * Subsequent 32-bit hacking by Tom Rini, Armin Kuster,
+ * Paul Mackerras and others.
+ *
+ * iSeries supported added by Mike Corrigan <mikejc@us.ibm.com>
+ *
+ * Additional shared processor, SMT, and firmware support
+ *    Copyright (c) 2003 Dave Engebretsen <engebret@us.ibm.com>
+ *
+ * 32-bit and 64-bit versions merged by Paul Mackerras <paulus@samba.org>
+ *
+ * This program is free software; you can redistribute it and/or
+ * modify it under the terms of the GNU General Public License
+ * as published by the Free Software Foundation; either version
+ * 2 of the License, or (at your option) any later version.
+ */
+
+#include <linux/config.h>
+#include <linux/sched.h>
+#include <linux/kernel.h>
+#include <linux/smp.h>
+#include <linux/cpu.h>
+#include <linux/sysctl.h>
+
+#include <asm/system.h>
+#include <asm/processor.h>
+#include <asm/cputable.h>
+#include <asm/time.h>
+#include <asm/machdep.h>
+#include <asm/smp.h>
+
+#ifdef CONFIG_HOTPLUG_CPU
+#define cpu_should_die()	(cpu_is_offline(smp_processor_id()) && \
+				 system_state == SYSTEM_RUNNING)
+#else
+#define cpu_should_die()	0
+#endif
+
+/*
+ * The body of the idle task.
+ */
+void cpu_idle(void)
+{
+	if (ppc_md.idle_loop)
+		ppc_md.idle_loop();	/* doesn't return */
+
+	set_thread_flag(TIF_POLLING_NRFLAG);
+	while (1) {
+		ppc64_runlatch_off();
+
+		while (!need_resched() && !cpu_should_die()) {
+			if (ppc_md.power_save) {
+				clear_thread_flag(TIF_POLLING_NRFLAG);
+				/*
+				 * smp_mb is so clearing of TIF_POLLING_NRFLAG
+				 * is ordered w.r.t. need_resched() test.
+				 */
+				smp_mb();
+				local_irq_disable();
+
+				/* check again after disabling irqs */
+				if (!need_resched() && !cpu_should_die())
+					ppc_md.power_save();
+
+				local_irq_enable();
+				set_thread_flag(TIF_POLLING_NRFLAG);
+
+			} else {
+				/*
+				 * Go into low thread priority and possibly
+				 * low power mode.
+				 */
+				HMT_low();
+				HMT_very_low();
+			}
+		}
+
+		HMT_medium();
+		ppc64_runlatch_on();
+		if (cpu_should_die())
+			cpu_die();
+		preempt_enable_no_resched();
+		schedule();
+		preempt_disable();
+	}
+}
+
+int powersave_nap;
+
+#ifdef CONFIG_SYSCTL
+/*
+ * Register the sysctl to set/clear powersave_nap.
+ */
+static ctl_table powersave_nap_ctl_table[]={
+	{
+		.ctl_name	= KERN_PPC_POWERSAVE_NAP,
+		.procname	= "powersave-nap",
+		.data		= &powersave_nap,
+		.maxlen		= sizeof(int),
+		.mode		= 0644,
+		.proc_handler	= &proc_dointvec,
+	},
+	{ 0, },
+};
+static ctl_table powersave_nap_sysctl_root[] = {
+	{ 1, "kernel", NULL, 0, 0755, powersave_nap_ctl_table, },
+ 	{ 0,},
+};
+
+static int __init
+register_powersave_nap_sysctl(void)
+{
+	register_sysctl_table(powersave_nap_sysctl_root, 0);
+
+	return 0;
+}
+__initcall(register_powersave_nap_sysctl);
+#endif
diff --git a/arch/powerpc/kernel/idle_64.c b/arch/powerpc/kernel/idle_64.c
deleted file mode 100644
index b879d30..0000000
--- a/arch/powerpc/kernel/idle_64.c
+++ /dev/null
@@ -1,121 +0,0 @@
-/*
- * Idle daemon for PowerPC.  Idle daemon will handle any action
- * that needs to be taken when the system becomes idle.
- *
- * Originally Written by Cort Dougan (cort@cs.nmt.edu)
- *
- * iSeries supported added by Mike Corrigan <mikejc@us.ibm.com>
- *
- * Additional shared processor, SMT, and firmware support
- *    Copyright (c) 2003 Dave Engebretsen <engebret@us.ibm.com>
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-
-#include <linux/config.h>
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/smp.h>
-#include <linux/cpu.h>
-#include <linux/sysctl.h>
-
-#include <asm/system.h>
-#include <asm/processor.h>
-#include <asm/cputable.h>
-#include <asm/time.h>
-#include <asm/machdep.h>
-#include <asm/smp.h>
-
-extern void power4_idle(void);
-
-void default_idle(void)
-{
-	unsigned int cpu = smp_processor_id();
-	set_thread_flag(TIF_POLLING_NRFLAG);
-
-	while (1) {
-		if (!need_resched()) {
-			while (!need_resched() && !cpu_is_offline(cpu)) {
-				ppc64_runlatch_off();
-
-				/*
-				 * Go into low thread priority and possibly
-				 * low power mode.
-				 */
-				HMT_low();
-				HMT_very_low();
-			}
-
-			HMT_medium();
-		}
-
-		ppc64_runlatch_on();
-		preempt_enable_no_resched();
-		schedule();
-		preempt_disable();
-		if (cpu_is_offline(cpu) && system_state == SYSTEM_RUNNING)
-			cpu_die();
-	}
-}
-
-void native_idle(void)
-{
-	while (1) {
-		ppc64_runlatch_off();
-
-		if (!need_resched())
-			power4_idle();
-
-		if (need_resched()) {
-			ppc64_runlatch_on();
-			preempt_enable_no_resched();
-			schedule();
-			preempt_disable();
-		}
-
-		if (cpu_is_offline(smp_processor_id()) &&
-		    system_state == SYSTEM_RUNNING)
-			cpu_die();
-	}
-}
-
-void cpu_idle(void)
-{
-	BUG_ON(NULL == ppc_md.idle_loop);
-	ppc_md.idle_loop();
-}
-
-int powersave_nap;
-
-#ifdef CONFIG_SYSCTL
-/*
- * Register the sysctl to set/clear powersave_nap.
- */
-static ctl_table powersave_nap_ctl_table[]={
-	{
-		.ctl_name	= KERN_PPC_POWERSAVE_NAP,
-		.procname	= "powersave-nap",
-		.data		= &powersave_nap,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
-	},
-	{ 0, },
-};
-static ctl_table powersave_nap_sysctl_root[] = {
-	{ 1, "kernel", NULL, 0, 0755, powersave_nap_ctl_table, },
- 	{ 0,},
-};
-
-static int __init
-register_powersave_nap_sysctl(void)
-{
-	register_sysctl_table(powersave_nap_sysctl_root, 0);
-
-	return 0;
-}
-__initcall(register_powersave_nap_sysctl);
-#endif
diff --git a/arch/powerpc/kernel/idle_6xx.S b/arch/powerpc/kernel/idle_6xx.S
index 444fdcc..1647ea3 100644
--- a/arch/powerpc/kernel/idle_6xx.S
+++ b/arch/powerpc/kernel/idle_6xx.S
@@ -85,23 +85,10 @@ BEGIN_FTR_SECTION
 1:	
 END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
 	cmpwi	0,r3,0
 	beqlr
 
-	/* Clear MSR:EE */
-	mfmsr	r7
-	rlwinm	r0,r7,0,17,15
-	mtmsr	r0
-
-	/* Check current_thread_info()->flags */
-	rlwinm	r4,r1,0,0,18
-	lwz	r4,TI_FLAGS(r4)
-	andi.	r0,r4,_TIF_NEED_RESCHED
-	beq	1f
-	mtmsr	r7	/* out of line this ? */
-	blr
-1:	
 	/* Some pre-nap cleanups needed on some CPUs */
 	andis.	r0,r3,HID0_NAP@h
 	beq	2f
 BEGIN_FTR_SECTION
 	/* Disable L2 prefetch on some 745x and try to ensure
@@ -218,12 +205,10 @@ _GLOBAL(nap_save_msscr0)
 	.space	4*NR_CPUS
 
 _GLOBAL(nap_save_hid1)
 	.space	4*NR_CPUS
 
-_GLOBAL(powersave_nap)
-	.long	0
 _GLOBAL(powersave_lowspeed)
 	.long	0
 
 #ifdef DEBUG
 _GLOBAL(nap_enter_count)
diff --git a/arch/powerpc/kernel/idle_power4.S b/arch/powerpc/kernel/idle_power4.S
index c16b4af..692cf2e 100644
--- a/arch/powerpc/kernel/idle_power4.S
+++ b/arch/powerpc/kernel/idle_power4.S
@@ -47,25 +47,10 @@ END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
 	LOAD_REG_ADDRBASE(r3,powersave_nap)
 	lwz	r4,ADDROFF(powersave_nap)(r3)
 	cmpwi	0,r4,0
 	beqlr
 
-	/* Clear MSR:EE */
-	mfmsr	r7
-	li	r4,0
-	ori	r4,r4,MSR_EE
-	andc	r0,r7,r4
-	mtmsrd	r0
-
-	/* Check current_thread_info()->flags */
-	clrrdi	r4,r1,THREAD_SHIFT
-	ld	r4,TI_FLAGS(r4)
-	andi.	r0,r4,_TIF_NEED_RESCHED
-	beq	1f
-	mtmsrd	r7	/* out of line this ? */
-	blr
-1:
 	/* Go to NAP now */
 BEGIN_FTR_SECTION
 	DSSALL
 	sync
 END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
diff --git a/arch/powerpc/kernel/setup_32.c b/arch/powerpc/kernel/setup_32.c
index db72a92..791edcd 100644
--- a/arch/powerpc/kernel/setup_32.c
+++ b/arch/powerpc/kernel/setup_32.c
@@ -51,13 +51,10 @@
 #endif
 
 extern void platform_init(void);
 extern void bootx_init(unsigned long r4, unsigned long phys);
 
-extern void ppc6xx_idle(void);
-extern void power4_idle(void);
-
 boot_infos_t *boot_infos;
 struct ide_machdep_calls ppc_ide_md;
 
 int boot_cpuid;
 EXPORT_SYMBOL_GPL(boot_cpuid);
@@ -192,11 +189,13 @@ void __init machine_init(unsigned long d
 
 	/* Base init based on machine type */
 	platform_init();
 
 #ifdef CONFIG_6xx
-	ppc_md.power_save = ppc6xx_idle;
+	if (cpu_has_feature(CPU_FTR_CAN_DOZE) ||
+	    cpu_has_feature(CPU_FTR_CAN_NAP))
+		ppc_md.power_save = ppc6xx_idle;
 #endif
 
 	if (ppc_md.progress)
 		ppc_md.progress("id mach(): done", 0x200);
 }
diff --git a/arch/powerpc/kernel/setup_64.c b/arch/powerpc/kernel/setup_64.c
index 2f3fdad..f47b3cc 100644
--- a/arch/powerpc/kernel/setup_64.c
+++ b/arch/powerpc/kernel/setup_64.c
@@ -599,16 +599,10 @@ void __init setup_arch(char **cmdline_p)
 	conswitchp = &dummy_con;
 #endif
 
 	ppc_md.setup_arch();
 
-	/* Use the default idle loop if the platform hasn't provided one. */
-	if (NULL == ppc_md.idle_loop) {
-		ppc_md.idle_loop = default_idle;
-		printk(KERN_INFO "Using default idle loop\n");
-	}
-
 	paging_init();
 	ppc64_boot_msg(0x15, "Setup Done");
 }
 
 
diff --git a/arch/powerpc/platforms/cell/pervasive.c b/arch/powerpc/platforms/cell/pervasive.c
index e0e051c..07f0c33 100644
--- a/arch/powerpc/platforms/cell/pervasive.c
+++ b/arch/powerpc/platforms/cell/pervasive.c
@@ -98,50 +98,33 @@ static void __init cbe_enable_pause_zero
 
 out:
 	spin_unlock_irq(&cbe_pervasive_lock);
 }
 
-static void cbe_idle(void)
+static void cbe_idle_sleep(void)
 {
 	unsigned long ctrl;
 
 	cbe_enable_pause_zero();
 
-	while (1) {
-		if (!need_resched()) {
-			local_irq_disable();
-			while (!need_resched()) {
-				/* go into low thread priority */
-				HMT_low();
-
-				/*
-				 * atomically disable thread execution
-				 * and runlatch.
-				 * External and Decrementer exceptions
-				 * are still handled when the thread
-				 * is disabled but now enter in
-				 * cbe_system_reset_exception()
-				 */
-				ctrl = mfspr(SPRN_CTRLF);
-				ctrl &= ~(CTRL_RUNLATCH | CTRL_TE);
-				mtspr(SPRN_CTRLT, ctrl);
-			}
-			/* restore thread prio */
-			HMT_medium();
-			local_irq_enable();
-		}
+	/* go into low thread priority */
+	HMT_low();
 
-		/*
-		 * turn runlatch on again before scheduling the
-		 * process we just woke up
-		 */
-		ppc64_runlatch_on();
-
-		preempt_enable_no_resched();
-		schedule();
-		preempt_disable();
-	}
+	/*
+	 * atomically disable thread execution
+	 * and runlatch.
+	 * External and Decrementer exceptions
+	 * are still handled when the thread
+	 * is disabled but now enter in
+	 * cbe_system_reset_exception()
+	 */
+	ctrl = mfspr(SPRN_CTRLF);
+	ctrl &= ~(CTRL_RUNLATCH | CTRL_TE);
+	mtspr(SPRN_CTRLT, ctrl);
+
+	/* restore thread prio */
+	HMT_medium();
 }
 
 static int cbe_system_reset_exception(struct pt_regs *regs)
 {
 	switch (regs->msr & SRR1_WAKEMASK) {
@@ -222,8 +205,8 @@ void __init cell_pervasive_init(void)
 		ret = cbe_find_pmd_mmio(cpu, p);
 		if (ret)
 			return;
 	}
 
-	ppc_md.idle_loop = cbe_idle;
+	ppc_md.power_save = cbe_idle_sleep;
 	ppc_md.system_reset_exception = cbe_system_reset_exception;
 }
diff --git a/arch/powerpc/platforms/maple/setup.c b/arch/powerpc/platforms/maple/setup.c
index ec5c1e1..137d606 100644
--- a/arch/powerpc/platforms/maple/setup.c
+++ b/arch/powerpc/platforms/maple/setup.c
@@ -288,11 +288,11 @@ struct machdep_calls __initdata maple_md
        	.get_boot_time		= maple_get_boot_time,
        	.set_rtc_time		= maple_set_rtc_time,
        	.get_rtc_time		= maple_get_rtc_time,
       	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= maple_progress,
-	.idle_loop		= native_idle,
+	.power_save		= power4_idle,
 #ifdef CONFIG_KEXEC
 	.machine_kexec		= default_machine_kexec,
 	.machine_kexec_prepare	= default_machine_kexec_prepare,
 	.machine_crash_shutdown	= default_machine_crash_shutdown,
 #endif
diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 385aab9..c2696d0 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -731,11 +731,11 @@ struct machdep_calls __initdata pmac_md 
 	.feature_call		= pmac_do_feature_call,
 	.check_legacy_ioport	= pmac_check_legacy_ioport,
 	.progress		= udbg_progress,
 #ifdef CONFIG_PPC64
 	.pci_probe_mode		= pmac_pci_probe_mode,
-	.idle_loop		= native_idle,
+	.power_save		= power4_idle,
 	.enable_pmcs		= power4_enable_pmcs,
 #ifdef CONFIG_KEXEC
 	.machine_kexec		= default_machine_kexec,
 	.machine_kexec_prepare	= default_machine_kexec_prepare,
 	.machine_crash_shutdown	= default_machine_crash_shutdown,
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 44d5c7f..213bf98 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -79,12 +79,12 @@
 
 extern void find_udbg_vterm(void);
 
 int fwnmi_active;  /* TRUE if an FWNMI handler is present */
 
-static void pseries_shared_idle(void);
-static void pseries_dedicated_idle(void);
+static void pseries_shared_idle_sleep(void);
+static void pseries_dedicated_idle_sleep(void);
 
 struct mpic *pSeries_mpic;
 
 static void pSeries_show_cpuinfo(struct seq_file *m)
 {
@@ -234,18 +234,17 @@ static void __init pSeries_setup_arch(vo
 	/* Choose an idle loop */
 	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
 		vpa_init(boot_cpuid);
 		if (get_lppaca()->shared_proc) {
 			printk(KERN_INFO "Using shared processor idle loop\n");
-			ppc_md.idle_loop = pseries_shared_idle;
+			ppc_md.power_save = pseries_shared_idle_sleep;
 		} else {
 			printk(KERN_INFO "Using dedicated idle loop\n");
-			ppc_md.idle_loop = pseries_dedicated_idle;
+			ppc_md.power_save = pseries_dedicated_idle_sleep;
 		}
 	} else {
 		printk(KERN_INFO "Using default idle loop\n");
-		ppc_md.idle_loop = default_idle;
 	}
 
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		ppc_md.enable_pmcs = pseries_lpar_enable_pmcs;
 	else
@@ -391,140 +390,91 @@ static int __init pSeries_probe(int plat
 	return 1;
 }
 
 DECLARE_PER_CPU(unsigned long, smt_snooze_delay);
 
-static inline void dedicated_idle_sleep(unsigned int cpu)
-{
-	struct lppaca *plppaca = &lppaca[cpu ^ 1];
-
-	/* Only sleep if the other thread is not idle */
-	if (!(plppaca->idle)) {
-		local_irq_disable();
-
-		/*
-		 * We are about to sleep the thread and so wont be polling any
-		 * more.
-		 */
-		clear_thread_flag(TIF_POLLING_NRFLAG);
-		smp_mb__after_clear_bit();
-
-		/*
-		 * SMT dynamic mode. Cede will result in this thread going
-		 * dormant, if the partner thread is still doing work.  Thread
-		 * wakes up if partner goes idle, an interrupt is presented, or
-		 * a prod occurs.  Returning from the cede enables external
-		 * interrupts.
-		 */
-		if (!need_resched())
-			cede_processor();
-		else
-			local_irq_enable();
-		set_thread_flag(TIF_POLLING_NRFLAG);
-	} else {
-		/*
-		 * Give the HV an opportunity at the processor, since we are
-		 * not doing any work.
-		 */
-		poll_pending();
-	}
-}
-
-static void pseries_dedicated_idle(void)
+static void pseries_dedicated_idle_sleep(void)
 { 
 	unsigned int cpu = smp_processor_id();
 	unsigned long start_snooze;
 	unsigned long *smt_snooze_delay = &__get_cpu_var(smt_snooze_delay);
-	set_thread_flag(TIF_POLLING_NRFLAG);
 
-	while (1) {
-		/*
-		 * Indicate to the HV that we are idle. Now would be
-		 * a good time to find other work to dispatch.
-		 */
-		get_lppaca()->idle = 1;
-
-		if (!need_resched()) {
-			start_snooze = get_tb() +
-				*smt_snooze_delay * tb_ticks_per_usec;
-
-			while (!need_resched() && !cpu_is_offline(cpu)) {
-				ppc64_runlatch_off();
-
-				/*
-				 * Go into low thread priority and possibly
-				 * low power mode.
-				 */
-				HMT_low();
-				HMT_very_low();
-
-				if (*smt_snooze_delay != 0 &&
-				    get_tb() > start_snooze) {
-					HMT_medium();
-					dedicated_idle_sleep(cpu);
-				}
+	/*
+	 * Indicate to the HV that we are idle. Now would be
+	 * a good time to find other work to dispatch.
+	 */
+	get_lppaca()->idle = 1;
 
-			}
+	/*
+	 * We come in with interrupts disabled, and need_resched()
+	 * has been checked recently.  If we should poll for a little
+	 * while, do so.
+	 */
+	if (*smt_snooze_delay) {
+		start_snooze = get_tb() +
+			*smt_snooze_delay * tb_ticks_per_usec;
+		local_irq_enable();
+		set_thread_flag(TIF_POLLING_NRFLAG);
 
-			HMT_medium();
+		while (get_tb() < start_snooze) {
+			if (need_resched() || cpu_is_offline(cpu))
+				goto out;
+			ppc64_runlatch_off();
+			HMT_low();
+			HMT_very_low();
 		}
 
-		get_lppaca()->idle = 0;
-		ppc64_runlatch_on();
+		HMT_medium();
+		clear_thread_flag(TIF_POLLING_NRFLAG);
+		smp_mb();
+		local_irq_disable();
+		if (need_resched() || cpu_is_offline(cpu))
+			goto out;
+	}
 
-		preempt_enable_no_resched();
-		schedule();
-		preempt_disable();
+	/*
+	 * Cede if the other thread is not idle, so that it can
+	 * go single-threaded.  If the other thread is idle,
+	 * we ask the hypervisor if it has pending work it
+	 * wants to do and cede if it does.  Otherwise we keep
+	 * polling in order to reduce interrupt latency.
+	 *
+	 * Doing the cede when the other thread is active will
+	 * result in this thread going dormant, meaning the other
+	 * thread gets to run in single-threaded (ST) mode, which
+	 * is slightly faster than SMT mode with this thread at
+	 * very low priority.  The cede enables interrupts, which
+	 * doesn't matter here.
+	 */
+	if (!lppaca[cpu ^ 1].idle || poll_pending() == H_Pending)
+		cede_processor();
 
-		if (cpu_is_offline(cpu) && system_state == SYSTEM_RUNNING)
-			cpu_die();
-	}
+out:
+	HMT_medium();
+	get_lppaca()->idle = 0;
 }
 
-static void pseries_shared_idle(void)
+static void pseries_shared_idle_sleep(void)
 {
 	unsigned int cpu = smp_processor_id();
 
-	while (1) {
-		/*
-		 * Indicate to the HV that we are idle. Now would be
-		 * a good time to find other work to dispatch.
-		 */
-		get_lppaca()->idle = 1;
-
-		while (!need_resched() && !cpu_is_offline(cpu)) {
-			local_irq_disable();
-			ppc64_runlatch_off();
-
-			/*
-			 * Yield the processor to the hypervisor.  We return if
-			 * an external interrupt occurs (which are driven prior
-			 * to returning here) or if a prod occurs from another
-			 * processor. When returning here, external interrupts
-			 * are enabled.
-			 *
-			 * Check need_resched() again with interrupts disabled
-			 * to avoid a race.
-			 */
-			if (!need_resched())
-				cede_processor();
-			else
-				local_irq_enable();
-
-			HMT_medium();
-		}
-
-		get_lppaca()->idle = 0;
-		ppc64_runlatch_on();
+	/*
+	 * Indicate to the HV that we are idle. Now would be
+	 * a good time to find other work to dispatch.
+	 */
+	get_lppaca()->idle = 1;
 
-		preempt_enable_no_resched();
-		schedule();
-		preempt_disable();
+	/*
+	 * Yield the processor to the hypervisor.  We return if
+	 * an external interrupt occurs (which are driven prior
+	 * to returning here) or if a prod occurs from another
+	 * processor. When returning here, external interrupts
+	 * are enabled.
+	 */
+	cede_processor();
 
-		if (cpu_is_offline(cpu) && system_state == SYSTEM_RUNNING)
-			cpu_die();
-	}
+	get_lppaca()->idle = 0;
 }
 
 static int pSeries_pci_probe_mode(struct pci_bus *bus)
 {
 	if (firmware_has_feature(FW_FEATURE_LPAR))
diff --git a/arch/ppc/Makefile b/arch/ppc/Makefile
index 98e940b..e6154b6 100644
--- a/arch/ppc/Makefile
+++ b/arch/ppc/Makefile
@@ -57,12 +57,10 @@ head-y				:= arch/ppc/kernel/head.o
 head-$(CONFIG_8xx)		:= arch/ppc/kernel/head_8xx.o
 head-$(CONFIG_4xx)		:= arch/ppc/kernel/head_4xx.o
 head-$(CONFIG_44x)		:= arch/ppc/kernel/head_44x.o
 head-$(CONFIG_FSL_BOOKE)	:= arch/ppc/kernel/head_fsl_booke.o
 
-head-$(CONFIG_6xx)		+= arch/ppc/kernel/idle_6xx.o
-head-$(CONFIG_POWER4)		+= arch/ppc/kernel/idle_power4.o
 head-$(CONFIG_PPC_FPU)		+= arch/powerpc/kernel/fpu.o
 
 core-y				+= arch/ppc/kernel/ arch/powerpc/kernel/ \
 				   arch/ppc/platforms/ \
 				   arch/ppc/mm/ arch/ppc/lib/ \
diff --git a/arch/ppc/kernel/Makefile b/arch/ppc/kernel/Makefile
index e399bbb..1b2c745 100644
--- a/arch/ppc/kernel/Makefile
+++ b/arch/ppc/kernel/Makefile
@@ -6,14 +6,13 @@ ifneq ($(CONFIG_PPC_MERGE),y)
 extra-$(CONFIG_PPC_STD_MMU)	:= head.o
 extra-$(CONFIG_40x)		:= head_4xx.o
 extra-$(CONFIG_44x)		:= head_44x.o
 extra-$(CONFIG_FSL_BOOKE)	:= head_fsl_booke.o
 extra-$(CONFIG_8xx)		:= head_8xx.o
-extra-$(CONFIG_6xx)		+= idle_6xx.o
 extra-y				+= vmlinux.lds
 
-obj-y				:= entry.o traps.o idle.o time.o misc.o \
+obj-y				:= entry.o traps.o time.o misc.o \
 					setup.o \
 					ppc_htab.o
 obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
 obj-$(CONFIG_MODULES)		+= module.o ppc_ksyms.o
@@ -33,11 +32,10 @@ obj-$(CONFIG_8xx)		+= softemu8xx.o
 endif
 
 # These are here while we do the architecture merge
 
 else
-obj-y				:= idle.o
 obj-$(CONFIG_6xx)		+= l2cr.o cpu_setup_6xx.o
 obj-$(CONFIG_SOFTWARE_SUSPEND)	+= swsusp.o
 obj-$(CONFIG_MODULES)		+= module.o
 obj-$(CONFIG_NOT_COHERENT_CACHE)	+= dma-mapping.o
 obj-$(CONFIG_KGDB)		+= ppc-stub.o
diff --git a/arch/ppc/kernel/entry.S b/arch/ppc/kernel/entry.S
index 3a28159..fa8d497 100644
--- a/arch/ppc/kernel/entry.S
+++ b/arch/ppc/kernel/entry.S
@@ -133,14 +133,14 @@ transfer_to_handler:
          */
 #ifdef CONFIG_6xx
 	mfspr	r11,SPRN_HID0
 	mtcr	r11
 BEGIN_FTR_SECTION
-	bt-	8,power_save_6xx_restore	/* Check DOZE */
+	bt-	8,4f			/* Check DOZE */
 END_FTR_SECTION_IFSET(CPU_FTR_CAN_DOZE)
 BEGIN_FTR_SECTION
-	bt-	9,power_save_6xx_restore	/* Check NAP */
+	bt-	9,4f			/* Check NAP */
 END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
 #endif /* CONFIG_6xx */
 	.globl transfer_to_handler_cont
 transfer_to_handler_cont:
 	lwz	r11,THREAD_INFO-THREAD(r12)
@@ -155,10 +155,14 @@ transfer_to_handler_cont:
 	mtspr	SPRN_SRR1,r10
 	mtlr	r9
 	SYNC
 	RFI				/* jump to handler, enable MMU */
 
+#ifdef CONFIG_6xx
+4:	b	power_save_6xx_restore
+#endif
+
 /*
  * On kernel stack overflow, load up an initial stack pointer
  * and call StackOverflow(regs), which should not return.
  */
 stack_ovf:
diff --git a/arch/ppc/kernel/idle.c b/arch/ppc/kernel/idle.c
deleted file mode 100644
index 1be3ca5..0000000
--- a/arch/ppc/kernel/idle.c
+++ /dev/null
@@ -1,112 +0,0 @@
-/*
- * Idle daemon for PowerPC.  Idle daemon will handle any action
- * that needs to be taken when the system becomes idle.
- *
- * Written by Cort Dougan (cort@cs.nmt.edu).  Subsequently hacked
- * on by Tom Rini, Armin Kuster, Paul Mackerras and others.
- *
- * This program is free software; you can redistribute it and/or
- * modify it under the terms of the GNU General Public License
- * as published by the Free Software Foundation; either version
- * 2 of the License, or (at your option) any later version.
- */
-#include <linux/config.h>
-#include <linux/errno.h>
-#include <linux/sched.h>
-#include <linux/kernel.h>
-#include <linux/mm.h>
-#include <linux/smp.h>
-#include <linux/smp_lock.h>
-#include <linux/stddef.h>
-#include <linux/unistd.h>
-#include <linux/ptrace.h>
-#include <linux/slab.h>
-#include <linux/sysctl.h>
-#include <linux/cpu.h>
-
-#include <asm/pgtable.h>
-#include <asm/uaccess.h>
-#include <asm/system.h>
-#include <asm/io.h>
-#include <asm/mmu.h>
-#include <asm/cache.h>
-#include <asm/cputable.h>
-#include <asm/machdep.h>
-#include <asm/smp.h>
-
-void default_idle(void)
-{
-	void (*powersave)(void);
-
-	powersave = ppc_md.power_save;
-
-	if (!need_resched()) {
-		if (powersave != NULL)
-			powersave();
-#ifdef CONFIG_SMP
-		else {
-			set_thread_flag(TIF_POLLING_NRFLAG);
-			while (!need_resched() &&
-					!cpu_is_offline(smp_processor_id()))
-				barrier();
-			clear_thread_flag(TIF_POLLING_NRFLAG);
-		}
-#endif
-	}
-}
-
-/*
- * The body of the idle task.
- */
-void cpu_idle(void)
-{
-	int cpu = smp_processor_id();
-
-	for (;;) {
-		while (!need_resched()) {
-			if (ppc_md.idle != NULL)
-				ppc_md.idle();
-			else
-				default_idle();
-		}
-
-		if (cpu_is_offline(cpu) && system_state == SYSTEM_RUNNING)
-			cpu_die();
-		preempt_enable_no_resched();
-		schedule();
-		preempt_disable();
-	}
-}
-
-#if defined(CONFIG_SYSCTL) && defined(CONFIG_6xx)
-/*
- * Register the sysctl to set/clear powersave_nap.
- */
-extern int powersave_nap;
-
-static ctl_table powersave_nap_ctl_table[]={
-	{
-		.ctl_name	= KERN_PPC_POWERSAVE_NAP,
-		.procname	= "powersave-nap",
-		.data		= &powersave_nap,
-		.maxlen		= sizeof(int),
-		.mode		= 0644,
-		.proc_handler	= &proc_dointvec,
-	},
-	{ 0, },
-};
-static ctl_table powersave_nap_sysctl_root[] = {
-	{ 1, "kernel", NULL, 0, 0755, powersave_nap_ctl_table, },
- 	{ 0,},
-};
-
-static int __init
-register_powersave_nap_sysctl(void)
-{
-	register_sysctl_table(powersave_nap_sysctl_root, 0);
-
-	return 0;
-}
-
-__initcall(register_powersave_nap_sysctl);
-#endif
diff --git a/arch/ppc/kernel/idle_6xx.S b/arch/ppc/kernel/idle_6xx.S
deleted file mode 100644
index 1a2194c..0000000
--- a/arch/ppc/kernel/idle_6xx.S
+++ /dev/null
@@ -1,233 +0,0 @@
-/*
- *  This file contains the power_save function for 6xx & 7xxx CPUs
- *  rewritten in assembler
- *
- *  Warning ! This code assumes that if your machine has a 750fx
- *  it will have PLL 1 set to low speed mode (used during NAP/DOZE).
- *  if this is not the case some additional changes will have to
- *  be done to check a runtime var (a bit like powersave-nap)
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
- */
-
-#include <linux/config.h>
-#include <linux/threads.h>
-#include <asm/processor.h>
-#include <asm/page.h>
-#include <asm/cputable.h>
-#include <asm/thread_info.h>
-#include <asm/ppc_asm.h>
-#include <asm/asm-offsets.h>
-
-#undef DEBUG
-
-	.text
-
-/*
- * Init idle, called at early CPU setup time from head.S for each CPU
- * Make sure no rest of NAP mode remains in HID0, save default
- * values for some CPU specific registers. Called with r24
- * containing CPU number and r3 reloc offset
- */
-_GLOBAL(init_idle_6xx)
-BEGIN_FTR_SECTION
-	mfspr	r4,SPRN_HID0
-	rlwinm	r4,r4,0,10,8	/* Clear NAP */
-	mtspr	SPRN_HID0, r4
-	b	1f
-END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
-	blr
-1:
-	slwi	r5,r24,2
-	add	r5,r5,r3
-BEGIN_FTR_SECTION
-	mfspr	r4,SPRN_MSSCR0
-	addis	r6,r5, nap_save_msscr0@ha
-	stw	r4,nap_save_msscr0@l(r6)
-END_FTR_SECTION_IFSET(CPU_FTR_NAP_DISABLE_L2_PR)
-BEGIN_FTR_SECTION
-	mfspr	r4,SPRN_HID1
-	addis	r6,r5,nap_save_hid1@ha
-	stw	r4,nap_save_hid1@l(r6)
-END_FTR_SECTION_IFSET(CPU_FTR_DUAL_PLL_750FX)
-	blr
-
-/*
- * Here is the power_save_6xx function. This could eventually be
- * split into several functions & changing the function pointer
- * depending on the various features.
- */
-_GLOBAL(ppc6xx_idle)
-	/* Check if we can nap or doze, put HID0 mask in r3
-	 */
-	lis	r3, 0
-BEGIN_FTR_SECTION
-	lis	r3,HID0_DOZE@h
-END_FTR_SECTION_IFSET(CPU_FTR_CAN_DOZE)
-BEGIN_FTR_SECTION
-	/* We must dynamically check for the NAP feature as it
-	 * can be cleared by CPU init after the fixups are done
-	 */
-	lis	r4,cur_cpu_spec@ha
-	lwz	r4,cur_cpu_spec@l(r4)
-	lwz	r4,CPU_SPEC_FEATURES(r4)
-	andi.	r0,r4,CPU_FTR_CAN_NAP
-	beq	1f
-	/* Now check if user or arch enabled NAP mode */
-	lis	r4,powersave_nap@ha
-	lwz	r4,powersave_nap@l(r4)
-	cmpwi	0,r4,0
-	beq	1f
-	lis	r3,HID0_NAP@h
-1:	
-END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
-	cmpwi	0,r3,0
-	beqlr
-
-	/* Clear MSR:EE */
-	mfmsr	r7
-	rlwinm	r0,r7,0,17,15
-	mtmsr	r0
-
-	/* Check current_thread_info()->flags */
-	rlwinm	r4,r1,0,0,18
-	lwz	r4,TI_FLAGS(r4)
-	andi.	r0,r4,_TIF_NEED_RESCHED
-	beq	1f
-	mtmsr	r7	/* out of line this ? */
-	blr
-1:	
-	/* Some pre-nap cleanups needed on some CPUs */
-	andis.	r0,r3,HID0_NAP@h
-	beq	2f
-BEGIN_FTR_SECTION
-	/* Disable L2 prefetch on some 745x and try to ensure
-	 * L2 prefetch engines are idle. As explained by errata
-	 * text, we can't be sure they are, we just hope very hard
-	 * that well be enough (sic !). At least I noticed Apple
-	 * doesn't even bother doing the dcbf's here...
-	 */
-	mfspr	r4,SPRN_MSSCR0
-	rlwinm	r4,r4,0,0,29
-	sync
-	mtspr	SPRN_MSSCR0,r4
-	sync
-	isync
-	lis	r4,KERNELBASE@h
-	dcbf	0,r4
-	dcbf	0,r4
-	dcbf	0,r4
-	dcbf	0,r4
-END_FTR_SECTION_IFSET(CPU_FTR_NAP_DISABLE_L2_PR)
-#ifdef DEBUG
-	lis	r6,nap_enter_count@ha
-	lwz	r4,nap_enter_count@l(r6)
-	addi	r4,r4,1
-	stw	r4,nap_enter_count@l(r6)
-#endif	
-2:
-BEGIN_FTR_SECTION
-	/* Go to low speed mode on some 750FX */
-	lis	r4,powersave_lowspeed@ha
-	lwz	r4,powersave_lowspeed@l(r4)
-	cmpwi	0,r4,0
-	beq	1f
-	mfspr	r4,SPRN_HID1
-	oris	r4,r4,0x0001
-	mtspr	SPRN_HID1,r4
-1:	
-END_FTR_SECTION_IFSET(CPU_FTR_DUAL_PLL_750FX)
-
-	/* Go to NAP or DOZE now */	
-	mfspr	r4,SPRN_HID0
-	lis	r5,(HID0_NAP|HID0_SLEEP)@h
-BEGIN_FTR_SECTION
-	oris	r5,r5,HID0_DOZE@h
-END_FTR_SECTION_IFSET(CPU_FTR_CAN_DOZE)
-	andc	r4,r4,r5
-	or	r4,r4,r3
-BEGIN_FTR_SECTION
-	oris	r4,r4,HID0_DPM@h	/* that should be done once for all  */
-END_FTR_SECTION_IFCLR(CPU_FTR_NO_DPM)
-	mtspr	SPRN_HID0,r4
-BEGIN_FTR_SECTION
-	DSSALL
-	sync
-END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-	ori	r7,r7,MSR_EE /* Could be ommited (already set) */
-	oris	r7,r7,MSR_POW@h
-	sync
-	isync
-	mtmsr	r7
-	isync
-	sync
-	blr
-	
-/*
- * Return from NAP/DOZE mode, restore some CPU specific registers,
- * we are called with DR/IR still off and r2 containing physical
- * address of current.
- */
-_GLOBAL(power_save_6xx_restore)
-	mfspr	r11,SPRN_HID0
-	rlwinm.	r11,r11,0,10,8	/* Clear NAP & copy NAP bit !state to cr1 EQ */
-	cror	4*cr1+eq,4*cr0+eq,4*cr0+eq
-BEGIN_FTR_SECTION
-	rlwinm	r11,r11,0,9,7	/* Clear DOZE */
-END_FTR_SECTION_IFSET(CPU_FTR_CAN_DOZE)
-	mtspr	SPRN_HID0, r11
-
-#ifdef DEBUG
-	beq	cr1,1f
-	lis	r11,(nap_return_count-KERNELBASE)@ha
-	lwz	r9,nap_return_count@l(r11)
-	addi	r9,r9,1
-	stw	r9,nap_return_count@l(r11)
-1:
-#endif
-	
-	rlwinm	r9,r1,0,0,18
-	tophys(r9,r9)
-	lwz	r11,TI_CPU(r9)
-	slwi	r11,r11,2
-	/* Todo make sure all these are in the same page
-	 * and load r22 (@ha part + CPU offset) only once
-	 */
-BEGIN_FTR_SECTION
-	beq	cr1,1f
-	addis	r9,r11,(nap_save_msscr0-KERNELBASE)@ha
-	lwz	r9,nap_save_msscr0@l(r9)
-	mtspr	SPRN_MSSCR0, r9
-	sync
-	isync
-1:
-END_FTR_SECTION_IFSET(CPU_FTR_NAP_DISABLE_L2_PR)
-BEGIN_FTR_SECTION
-	addis	r9,r11,(nap_save_hid1-KERNELBASE)@ha
-	lwz	r9,nap_save_hid1@l(r9)
-	mtspr	SPRN_HID1, r9
-END_FTR_SECTION_IFSET(CPU_FTR_DUAL_PLL_750FX)
-	b	transfer_to_handler_cont
-
-	.data
-
-_GLOBAL(nap_save_msscr0)
-	.space	4*NR_CPUS
-
-_GLOBAL(nap_save_hid1)
-	.space	4*NR_CPUS
-
-_GLOBAL(powersave_nap)
-	.long	0
-_GLOBAL(powersave_lowspeed)
-	.long	0
-
-#ifdef DEBUG
-_GLOBAL(nap_enter_count)
-	.space	4
-_GLOBAL(nap_return_count)
-	.space	4
-#endif
diff --git a/arch/ppc/kernel/idle_power4.S b/arch/ppc/kernel/idle_power4.S
deleted file mode 100644
index cc0d535..0000000
--- a/arch/ppc/kernel/idle_power4.S
+++ /dev/null
@@ -1,91 +0,0 @@
-/*
- *  This file contains the power_save function for 6xx & 7xxx CPUs
- *  rewritten in assembler
- *
- *  Warning ! This code assumes that if your machine has a 750fx
- *  it will have PLL 1 set to low speed mode (used during NAP/DOZE).
- *  if this is not the case some additional changes will have to
- *  be done to check a runtime var (a bit like powersave-nap)
- *
- *  This program is free software; you can redistribute it and/or
- *  modify it under the terms of the GNU General Public License
- *  as published by the Free Software Foundation; either version
- *  2 of the License, or (at your option) any later version.
- */
-
-#include <linux/config.h>
-#include <linux/threads.h>
-#include <asm/processor.h>
-#include <asm/page.h>
-#include <asm/cputable.h>
-#include <asm/thread_info.h>
-#include <asm/ppc_asm.h>
-#include <asm/asm-offsets.h>
-
-#undef DEBUG
-
-	.text
-
-/*
- * Init idle, called at early CPU setup time from head.S for each CPU
- * So nothing for now. Called with r24 containing CPU number and r3
- * reloc offset
- */
- 	.globl	init_idle_power4
-init_idle_power4:
-	blr
-
-/*
- * Here is the power_save_6xx function. This could eventually be
- * split into several functions & changing the function pointer
- * depending on the various features.
- */
-	.globl	power4_idle
-power4_idle:
-BEGIN_FTR_SECTION
-	blr
-END_FTR_SECTION_IFCLR(CPU_FTR_CAN_NAP)
-	/* We must dynamically check for the NAP feature as it
-	 * can be cleared by CPU init after the fixups are done
-	 */
-	lis	r4,cur_cpu_spec@ha
-	lwz	r4,cur_cpu_spec@l(r4)
-	lwz	r4,CPU_SPEC_FEATURES(r4)
-	andi.	r0,r4,CPU_FTR_CAN_NAP
-	beqlr
-	/* Now check if user or arch enabled NAP mode */
-	lis	r4,powersave_nap@ha
-	lwz	r4,powersave_nap@l(r4)
-	cmpwi	0,r4,0
-	beqlr
-
-	/* Clear MSR:EE */
-	mfmsr	r7
-	rlwinm	r0,r7,0,17,15
-	mtmsr	r0
-
-	/* Check current_thread_info()->flags */
-	rlwinm	r4,r1,0,0,18
-	lwz	r4,TI_FLAGS(r4)
-	andi.	r0,r4,_TIF_NEED_RESCHED
-	beq	1f
-	mtmsr	r7	/* out of line this ? */
-	blr
-1:	
-	/* Go to NAP now */	
-BEGIN_FTR_SECTION
-	DSSALL
-	sync
-END_FTR_SECTION_IFSET(CPU_FTR_ALTIVEC)
-	ori	r7,r7,MSR_EE /* Could be ommited (already set) */
-	oris	r7,r7,MSR_POW@h
-	sync
-	isync
-	mtmsr	r7
-	isync
-	sync
-	blr
-	
-	.globl powersave_nap
-powersave_nap:
-	.long	0
diff --git a/include/asm-powerpc/hvcall.h b/include/asm-powerpc/hvcall.h
index 38ca9ad..b72c04f 100644
--- a/include/asm-powerpc/hvcall.h
+++ b/include/asm-powerpc/hvcall.h
@@ -7,10 +7,11 @@
 #define H_Success	0
 #define H_Busy		1	/* Hardware busy -- retry later */
 #define H_Closed	2	/* Resource closed */
 #define H_Constrained	4	/* Resource request constrained to max allowed */
 #define H_InProgress   14	/* Kind of like busy */
+#define H_Pending      17	/* returned from H_POLL_PENDING */
 #define H_Continue     18	/* Returned from H_Join on success */
 #define H_LongBusyStartRange   9900  /* Start of long busy range */
 #define H_LongBusyOrder1msec   9900  /* Long busy, hint that 1msec is a good time to retry */
 #define H_LongBusyOrder10msec  9901  /* Long busy, hint that 10msec is a good time to retry */
 #define H_LongBusyOrder100msec 9902  /* Long busy, hint that 100msec is a good time to retry */
diff --git a/include/asm-powerpc/machdep.h b/include/asm-powerpc/machdep.h
index 5348b82..21c8dc9 100644
--- a/include/asm-powerpc/machdep.h
+++ b/include/asm-powerpc/machdep.h
@@ -156,10 +156,16 @@ struct machdep_calls {
 						pgprot_t vma_prot);
 
 	/* Idle loop for this platform, leave empty for default idle loop */
 	void		(*idle_loop)(void);
 
+	/*
+	 * Function for waiting for work with reduced power in idle loop;
+	 * called with interrupts disabled.
+	 */
+	void		(*power_save)(void);
+
 	/* Function to enable performance monitor counters for this
 	   platform, called once per cpu. */
 	void		(*enable_pmcs)(void);
 
 	/* Set DABR for this platform, leave empty for default implemenation */
@@ -168,13 +174,10 @@ struct machdep_calls {
 #ifdef CONFIG_PPC32	/* XXX for now */
 	/* A general init function, called by ppc_init in init/main.c.
 	   May be NULL. */
 	void		(*init)(void);
 
-	void		(*idle)(void);
-	void		(*power_save)(void);
-
 	void		(*heartbeat)(void);
 	unsigned long	heartbeat_reset;
 	unsigned long	heartbeat_count;
 
 	void		(*setup_io_mappings)(void);
@@ -240,12 +243,12 @@ struct machdep_calls {
 	 */
 	void (*machine_kexec)(struct kimage *image);
 #endif /* CONFIG_KEXEC */
 };
 
-extern void default_idle(void);
-extern void native_idle(void);
+extern void power4_idle(void);
+extern void ppc6xx_idle(void);
 
 extern struct machdep_calls ppc_md;
 extern char cmd_line[COMMAND_LINE_SIZE];
 
 #ifdef CONFIG_PPC_PMAC
diff --git a/include/asm-powerpc/reg.h b/include/asm-powerpc/reg.h
index 72bfe3a..bd467bf 100644
--- a/include/asm-powerpc/reg.h
+++ b/include/asm-powerpc/reg.h
@@ -620,10 +620,14 @@ extern void ppc64_runlatch_on(void);
 extern void ppc64_runlatch_off(void);
 
 extern unsigned long scom970_read(unsigned int address);
 extern void scom970_write(unsigned int address, unsigned long value);
 
+#else
+#define ppc64_runlatch_on()
+#define ppc64_runlatch_off()
+
 #endif /* CONFIG_PPC64 */
 
 #define __get_SP()	({unsigned long sp; \
 			asm volatile("mr %0,1": "=r" (sp)); sp;})
 
diff --git a/include/asm-ppc/machdep.h b/include/asm-ppc/machdep.h
index a3e8a45..ebbef64 100644
--- a/include/asm-ppc/machdep.h
+++ b/include/asm-ppc/machdep.h
@@ -42,11 +42,11 @@ struct machdep_calls {
 
 	void		(*restart)(char *cmd);
 	void		(*power_off)(void);
 	void		(*halt)(void);
 
-	void		(*idle)(void);
+	void		(*idle_loop)(void);
 	void		(*power_save)(void);
 
 	long		(*time_init)(void); /* Optional, may be NULL */
 	int		(*set_rtc_time)(unsigned long nowtime);
 	unsigned long	(*get_rtc_time)(void);
