Return-Path: <chenhui.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0112.outbound.protection.outlook.com [207.46.100.112])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 482D41A0B13
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Mar 2015 21:51:43 +1100 (AEDT)
From: Chenhui Zhao <chenhui.zhao@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <devicetree@vger.kernel.org>
Subject: [PATCH 3/4] powerpc: support CPU hotplug for e500mc, e5500 and e6500
Date: Thu, 26 Mar 2015 18:18:14 +0800
Message-ID: <1427365095-26396-3-git-send-email-chenhui.zhao@freescale.com>
In-Reply-To: <1427365095-26396-1-git-send-email-chenhui.zhao@freescale.com>
References: <1427365095-26396-1-git-send-email-chenhui.zhao@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: scottwood@freescale.com, linux-kernel@vger.kernel.org,
 Jason.Jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Implemented CPU hotplug on e500mc, e5500 and e6500, and support
multiple threads mode and 64-bits mode.

For e6500 with two threads, if one thread is online, it can
enable/disable the other thread in the same core. If two threads of
one core are offline, the core will enter the PH20 state (a low power
state). When the core is up again, Thread0 is up first, and it will be
bound with the present booting cpu. This way, all CPUs can hotplug
separately.

Signed-off-by: Chenhui Zhao <chenhui.zhao@freescale.com>
---
 arch/powerpc/Kconfig              |   2 +-
 arch/powerpc/include/asm/fsl_pm.h |   4 +
 arch/powerpc/include/asm/smp.h    |   2 +
 arch/powerpc/kernel/head_64.S     |  20 +++--
 arch/powerpc/kernel/smp.c         |   5 ++
 arch/powerpc/platforms/85xx/smp.c | 182 +++++++++++++++++++++++++++++---------
 arch/powerpc/sysdev/fsl_rcpm.c    |  56 ++++++++++++
 7 files changed, 220 insertions(+), 51 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 22b0940..9846c83 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -380,7 +380,7 @@ config SWIOTLB
 config HOTPLUG_CPU
 	bool "Support for enabling/disabling CPUs"
 	depends on SMP && (PPC_PSERIES || \
-	PPC_PMAC || PPC_POWERNV || (PPC_85xx && !PPC_E500MC))
+	PPC_PMAC || PPC_POWERNV || FSL_SOC_BOOKE)
 	---help---
 	  Say Y here to be able to disable and re-enable individual
 	  CPUs at runtime on SMP machines.
diff --git a/arch/powerpc/include/asm/fsl_pm.h b/arch/powerpc/include/asm/fsl_pm.h
index bbe6089..579f495 100644
--- a/arch/powerpc/include/asm/fsl_pm.h
+++ b/arch/powerpc/include/asm/fsl_pm.h
@@ -34,6 +34,10 @@ struct fsl_pm_ops {
 	void (*cpu_enter_state)(int cpu, int state);
 	/* exit the CPU from the specified state */
 	void (*cpu_exit_state)(int cpu, int state);
+	/* cpu up */
+	void (*cpu_up)(int cpu);
+	/* cpu die */
+	void (*cpu_die)(int cpu);
 	/* place the platform in the sleep state */
 	int (*plat_enter_sleep)(void);
 	/* freeze the time base */
diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
index d607df5..1e500ed 100644
--- a/arch/powerpc/include/asm/smp.h
+++ b/arch/powerpc/include/asm/smp.h
@@ -67,6 +67,7 @@ void generic_cpu_die(unsigned int cpu);
 void generic_set_cpu_dead(unsigned int cpu);
 void generic_set_cpu_up(unsigned int cpu);
 int generic_check_cpu_restart(unsigned int cpu);
+int generic_check_cpu_dead(unsigned int cpu);
 #endif
 
 #ifdef CONFIG_PPC64
@@ -198,6 +199,7 @@ extern void generic_secondary_thread_init(void);
 extern unsigned long __secondary_hold_spinloop;
 extern unsigned long __secondary_hold_acknowledge;
 extern char __secondary_hold;
+extern unsigned int __cur_boot_cpu;
 
 extern void __early_start(void);
 #endif /* __ASSEMBLY__ */
diff --git a/arch/powerpc/kernel/head_64.S b/arch/powerpc/kernel/head_64.S
index d48125d..ac89050 100644
--- a/arch/powerpc/kernel/head_64.S
+++ b/arch/powerpc/kernel/head_64.S
@@ -181,6 +181,10 @@ exception_marker:
 #endif
 
 #ifdef CONFIG_PPC_BOOK3E
+	.globl	__cur_boot_cpu
+__cur_boot_cpu:
+	.long  0x0
+	.align 3
 _GLOBAL(fsl_secondary_thread_init)
 	/* Enable branch prediction */
 	lis     r3,BUCSR_INIT@h
@@ -189,16 +193,14 @@ _GLOBAL(fsl_secondary_thread_init)
 	isync
 
 	/*
-	 * Fix PIR to match the linear numbering in the device tree.
-	 *
-	 * On e6500, the reset value of PIR uses the low three bits for
-	 * the thread within a core, and the upper bits for the core
-	 * number.  There are two threads per core, so shift everything
-	 * but the low bit right by two bits so that the cpu numbering is
-	 * continuous.
+	 * The current thread has been in 64-bit mode,
+	 * see the value of TMRN_IMSR.
+	 * compute the address of __cur_boot_cpu
 	 */
-	mfspr	r3, SPRN_PIR
-	rlwimi	r3, r3, 30, 2, 30
+	bl	10f
+10:	mflr	r22
+	addi	r22,r22,(__cur_boot_cpu - 10b)
+	lwz	r3,0(r22)
 	mtspr	SPRN_PIR, r3
 #endif
 
diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
index ec9ec20..2cca27a 100644
--- a/arch/powerpc/kernel/smp.c
+++ b/arch/powerpc/kernel/smp.c
@@ -454,6 +454,11 @@ int generic_check_cpu_restart(unsigned int cpu)
 	return per_cpu(cpu_state, cpu) == CPU_UP_PREPARE;
 }
 
+int generic_check_cpu_dead(unsigned int cpu)
+{
+	return per_cpu(cpu_state, cpu) == CPU_DEAD;
+}
+
 static bool secondaries_inhibited(void)
 {
 	return kvm_hv_mode_active();
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index fba474f..f51441b 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -2,7 +2,7 @@
  * Author: Andy Fleming <afleming@freescale.com>
  * 	   Kumar Gala <galak@kernel.crashing.org>
  *
- * Copyright 2006-2008, 2011-2012 Freescale Semiconductor Inc.
+ * Copyright 2006-2008, 2011-2012, 2015 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -29,6 +29,7 @@
 #include <asm/fsl_guts.h>
 #include <asm/code-patching.h>
 #include <asm/cputhreads.h>
+#include <asm/fsl_pm.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/mpic.h>
@@ -43,10 +44,20 @@ struct epapr_spin_table {
 	u32	pir;
 };
 
-static struct ccsr_guts __iomem *guts;
+#ifdef CONFIG_HOTPLUG_CPU
 static u64 timebase;
 static int tb_req;
 static int tb_valid;
+/* if it is non-zero, synchronize time base */
+static int sync_tb;
+
+#ifdef CONFIG_PPC_E500MC
+static void mpc85xx_timebase_freeze(int freeze)
+{
+	qoriq_pm_ops->freeze_time_base(freeze);
+}
+#else
+static struct ccsr_guts __iomem *guts;
 
 static void mpc85xx_timebase_freeze(int freeze)
 {
@@ -60,11 +71,15 @@ static void mpc85xx_timebase_freeze(int freeze)
 
 	in_be32(&guts->devdisr);
 }
+#endif
 
 static void mpc85xx_give_timebase(void)
 {
 	unsigned long flags;
 
+	if (!sync_tb)
+		return;
+
 	local_irq_save(flags);
 
 	while (!tb_req)
@@ -113,6 +128,9 @@ static void mpc85xx_take_timebase(void)
 {
 	unsigned long flags;
 
+	if (!sync_tb)
+		return;
+
 	local_irq_save(flags);
 
 	tb_req = 1;
@@ -126,7 +144,46 @@ static void mpc85xx_take_timebase(void)
 	local_irq_restore(flags);
 }
 
-#ifdef CONFIG_HOTPLUG_CPU
+#ifdef CONFIG_PPC_E500MC
+static void qoriq_cpu_wait_die(void)
+{
+	unsigned int cpu = smp_processor_id();
+
+	hard_irq_disable();
+	/* mask all irqs to prevent cpu wakeup */
+	qoriq_pm_ops->irq_mask(cpu);
+	idle_task_exit();
+
+	mtspr(SPRN_TCR, 0);
+	mtspr(SPRN_TSR, mfspr(SPRN_TSR));
+
+	cur_cpu_spec->cpu_flush_caches();
+
+	generic_set_cpu_dead(cpu);
+	smp_mb();
+	while (1)
+	;
+}
+
+static void qoriq_real_cpu_die(unsigned int cpu)
+{
+	int i;
+
+	for (i = 0; i < 100; i++) {
+		smp_rmb();
+		if (generic_check_cpu_dead(cpu)) {
+			qoriq_pm_ops->cpu_die(cpu);
+#ifdef CONFIG_PPC64
+			paca[cpu].cpu_start = 0;
+#endif
+			return;
+		}
+		msleep(10);
+	}
+	pr_err("%s: CPU%d didn't die...\n", __func__, cpu);
+}
+
+#else
 static void smp_85xx_mach_cpu_die(void)
 {
 	unsigned int cpu = smp_processor_id();
@@ -156,6 +213,7 @@ static void smp_85xx_mach_cpu_die(void)
 		;
 }
 #endif
+#endif /* CONFIG_HOTPLUG_CPU */
 
 static inline void flush_spin_table(void *spin_table)
 {
@@ -174,17 +232,29 @@ static inline u32 read_spin_table_addr_l(void *spin_table)
 static void wake_hw_thread(void *info)
 {
 	void fsl_secondary_thread_init(void);
-	unsigned long imsr1, inia1;
+	unsigned long imsr, inia;
 	int nr = *(const int *)info;
-
-	imsr1 = MSR_KERNEL;
-	inia1 = *(unsigned long *)fsl_secondary_thread_init;
-
-	mttmr(TMRN_IMSR1, imsr1);
-	mttmr(TMRN_INIA1, inia1);
-	mtspr(SPRN_TENS, TEN_THREAD(1));
+	int hw_cpu = get_hard_smp_processor_id(nr);
+	int thread_idx = cpu_thread_in_core(hw_cpu);
+
+	__cur_boot_cpu = (u32)hw_cpu;
+	imsr = MSR_KERNEL;
+	inia = *(unsigned long *)fsl_secondary_thread_init;
+	smp_mb();
+	if (thread_idx == 0) {
+		mttmr(TMRN_IMSR0, imsr);
+		mttmr(TMRN_INIA0, inia);
+	} else {
+		mttmr(TMRN_IMSR1, imsr);
+		mttmr(TMRN_INIA1, inia);
+	}
+	isync();
+	mtspr(SPRN_TENS, TEN_THREAD(thread_idx));
 
 	smp_generic_kick_cpu(nr);
+#ifdef CONFIG_HOTPLUG_CPU
+	generic_set_cpu_up(nr);
+#endif
 }
 #endif
 
@@ -203,28 +273,46 @@ static int smp_85xx_kick_cpu(int nr)
 
 	pr_debug("smp_85xx_kick_cpu: kick CPU #%d\n", nr);
 
+#ifdef CONFIG_HOTPLUG_CPU
+	sync_tb = 0;
+	smp_mb();
+#endif
 #ifdef CONFIG_PPC64
-	/* Threads don't use the spin table */
-	if (cpu_thread_in_core(nr) != 0) {
+	if (threads_per_core > 1) {
 		int primary = cpu_first_thread_sibling(nr);
 
 		if (WARN_ON_ONCE(!cpu_has_feature(CPU_FTR_SMT)))
 			return -ENOENT;
 
-		if (cpu_thread_in_core(nr) != 1) {
-			pr_err("%s: cpu %d: invalid hw thread %d\n",
-			       __func__, nr, cpu_thread_in_core(nr));
-			return -ENOENT;
+		/*
+		 * If either one of threads in the same core is online,
+		 * use the online one to start the other.
+		 */
+		if (cpu_online(primary) || cpu_online(primary + 1)) {
+			qoriq_pm_ops->cpu_up(nr);
+			if (cpu_online(primary))
+				smp_call_function_single(primary,
+						wake_hw_thread, &nr, 1);
+			else
+				smp_call_function_single(primary + 1,
+						wake_hw_thread, &nr, 1);
+			return 0;
 		}
-
-		if (!cpu_online(primary)) {
-			pr_err("%s: cpu %d: primary %d not online\n",
-			       __func__, nr, primary);
-			return -ENOENT;
+		/*
+		 * If both threads are offline, reset core to start.
+		 * When core is up, Thread 0 always gets up first,
+		 * so bind the current logical cpu with Thread 0.
+		 */
+		if (hw_cpu != cpu_first_thread_sibling(hw_cpu)) {
+			int hw_cpu1, hw_cpu2;
+
+			hw_cpu1 = get_hard_smp_processor_id(primary);
+			hw_cpu2 = get_hard_smp_processor_id(primary + 1);
+			set_hard_smp_processor_id(primary, hw_cpu2);
+			set_hard_smp_processor_id(primary + 1, hw_cpu1);
+			/* get new physical cpu id */
+			hw_cpu = get_hard_smp_processor_id(nr);
 		}
-
-		smp_call_function_single(primary, wake_hw_thread, &nr, 0);
-		return 0;
 	}
 #endif
 
@@ -252,11 +340,7 @@ static int smp_85xx_kick_cpu(int nr)
 		spin_table = phys_to_virt(*cpu_rel_addr);
 
 	local_irq_save(flags);
-#ifdef CONFIG_PPC32
 #ifdef CONFIG_HOTPLUG_CPU
-	/* Corresponding to generic_set_cpu_dead() */
-	generic_set_cpu_up(nr);
-
 	if (system_state == SYSTEM_RUNNING) {
 		/*
 		 * To keep it compatible with old boot program which uses
@@ -269,11 +353,16 @@ static int smp_85xx_kick_cpu(int nr)
 		out_be32(&spin_table->addr_l, 0);
 		flush_spin_table(spin_table);
 
+#ifdef CONFIG_PPC_E500MC
+		qoriq_pm_ops->cpu_up(nr);
+#endif
 		/*
 		 * We don't set the BPTR register here since it already points
 		 * to the boot page properly.
 		 */
 		mpic_reset_core(nr);
+		sync_tb = 1;
+		smp_mb();
 
 		/*
 		 * wait until core is ready...
@@ -292,7 +381,12 @@ static int smp_85xx_kick_cpu(int nr)
 		/*  clear the acknowledge status */
 		__secondary_hold_acknowledge = -1;
 	}
+
+	/* Corresponding to generic_set_cpu_dead() */
+	generic_set_cpu_up(nr);
 #endif
+
+#ifdef CONFIG_PPC32
 	flush_spin_table(spin_table);
 	out_be32(&spin_table->pir, hw_cpu);
 	out_be32(&spin_table->addr_l, __pa(__early_start));
@@ -304,9 +398,7 @@ static int smp_85xx_kick_cpu(int nr)
 		pr_err("%s: timeout waiting for core %d to ack\n",
 						__func__, hw_cpu);
 		ret = -ENOENT;
-		goto out;
 	}
-out:
 #else
 	smp_generic_kick_cpu(nr);
 
@@ -317,6 +409,9 @@ out:
 	flush_spin_table(spin_table);
 #endif
 
+#ifdef CONFIG_HOTPLUG_CPU
+out:
+#endif
 	local_irq_restore(flags);
 
 	if (ioremappable)
@@ -328,10 +423,6 @@ out:
 struct smp_ops_t smp_85xx_ops = {
 	.kick_cpu = smp_85xx_kick_cpu,
 	.cpu_bootable = smp_generic_cpu_bootable,
-#ifdef CONFIG_HOTPLUG_CPU
-	.cpu_disable	= generic_cpu_disable,
-	.cpu_die	= generic_cpu_die,
-#endif
 #ifdef CONFIG_KEXEC
 	.give_timebase	= smp_generic_give_timebase,
 	.take_timebase	= smp_generic_take_timebase,
@@ -447,6 +538,7 @@ static void smp_85xx_setup_cpu(int cpu_nr)
 	smp_85xx_basic_setup(cpu_nr);
 }
 
+#ifdef CONFIG_HOTPLUG_CPU
 static const struct of_device_id mpc85xx_smp_guts_ids[] = {
 	{ .compatible = "fsl,mpc8572-guts", },
 	{ .compatible = "fsl,p1020-guts", },
@@ -456,12 +548,12 @@ static const struct of_device_id mpc85xx_smp_guts_ids[] = {
 	{ .compatible = "fsl,p2020-guts", },
 	{},
 };
+#endif
 
 void __init mpc85xx_smp_init(void)
 {
 	struct device_node *np;
 
-
 	np = of_find_node_by_type(NULL, "open-pic");
 	if (np) {
 		smp_85xx_ops.probe = smp_mpic_probe;
@@ -480,6 +572,11 @@ void __init mpc85xx_smp_init(void)
 		smp_85xx_ops.probe = NULL;
 	}
 
+#ifdef CONFIG_HOTPLUG_CPU
+#ifdef CONFIG_PPC_E500MC
+	smp_85xx_ops.cpu_die = qoriq_real_cpu_die;
+	ppc_md.cpu_die = qoriq_cpu_wait_die;
+#else
 	np = of_find_matching_node(NULL, mpc85xx_smp_guts_ids);
 	if (np) {
 		guts = of_iomap(np, 0);
@@ -489,13 +586,16 @@ void __init mpc85xx_smp_init(void)
 								__func__);
 			return;
 		}
-		smp_85xx_ops.give_timebase = mpc85xx_give_timebase;
-		smp_85xx_ops.take_timebase = mpc85xx_take_timebase;
-#ifdef CONFIG_HOTPLUG_CPU
-		ppc_md.cpu_die = smp_85xx_mach_cpu_die;
-#endif
 	}
 
+	smp_85xx_ops.cpu_die = generic_cpu_die;
+	ppc_md.cpu_die = smp_85xx_mach_cpu_die;
+#endif
+	smp_85xx_ops.give_timebase = mpc85xx_give_timebase;
+	smp_85xx_ops.take_timebase = mpc85xx_take_timebase;
+	smp_85xx_ops.cpu_disable = generic_cpu_disable;
+#endif /* CONFIG_HOTPLUG_CPU */
+
 	smp_ops = &smp_85xx_ops;
 
 #ifdef CONFIG_KEXEC
diff --git a/arch/powerpc/sysdev/fsl_rcpm.c b/arch/powerpc/sysdev/fsl_rcpm.c
index e30f1bc..a507fd0 100644
--- a/arch/powerpc/sysdev/fsl_rcpm.c
+++ b/arch/powerpc/sysdev/fsl_rcpm.c
@@ -131,6 +131,46 @@ static void rcpm_v2_cpu_enter_state(int cpu, int state)
 	}
 }
 
+static void rcpm_v1_cpu_die(int cpu)
+{
+	rcpm_v1_cpu_enter_state(cpu, E500_PM_PH15);
+}
+
+static void qoriq_disable_thread(void *info)
+{
+	int hw_cpu = get_hard_smp_processor_id(*(const int *)info);
+	int thread = cpu_thread_in_core(hw_cpu);
+
+	mtspr(SPRN_TENC, TEN_THREAD(thread));
+}
+
+static void rcpm_v2_cpu_die(int cpu)
+{
+	int primary;
+
+	if (threads_per_core == 1) {
+		rcpm_v2_cpu_enter_state(cpu, E500_PM_PH20);
+		return;
+	}
+
+	primary = cpu_first_thread_sibling(cpu);
+	if (cpu_is_offline(primary) && cpu_is_offline(primary + 1)) {
+		/* when two threads are all offline, put core in PH20 */
+		rcpm_v2_cpu_enter_state(cpu, E500_PM_PH20);
+	} else {
+		/*
+		 * When one thread is offline, disable the thread
+		 * by running qoriq_disable_thread() on the other thread.
+		 */
+		if (cpu_online(primary))
+			smp_call_function_single(primary,
+					qoriq_disable_thread, &cpu, 1);
+		else
+			smp_call_function_single(primary + 1,
+					qoriq_disable_thread, &cpu, 1);
+	}
+}
+
 static void rcpm_v1_cpu_exit_state(int cpu, int state)
 {
 	int hw_cpu = get_hard_smp_processor_id(cpu);
@@ -149,6 +189,12 @@ static void rcpm_v1_cpu_exit_state(int cpu, int state)
 	}
 }
 
+static void rcpm_v1_cpu_up(int cpu)
+{
+	rcpm_v1_cpu_exit_state(cpu, E500_PM_PH15);
+	rcpm_v1_irq_unmask(cpu);
+}
+
 static void rcpm_v2_cpu_exit_state(int cpu, int state)
 {
 	int hw_cpu = get_hard_smp_processor_id(cpu);
@@ -172,6 +218,12 @@ static void rcpm_v2_cpu_exit_state(int cpu, int state)
 	}
 }
 
+static void rcpm_v2_cpu_up(int cpu)
+{
+	rcpm_v2_cpu_exit_state(cpu, E500_PM_PH20);
+	rcpm_v2_irq_unmask(cpu);
+}
+
 static int rcpm_v1_plat_enter_state(int state)
 {
 	u32 *pmcsr_reg = &rcpm_v1_regs->powmgtcsr;
@@ -280,6 +332,8 @@ static const struct fsl_pm_ops qoriq_rcpm_v1_ops = {
 	.irq_unmask = rcpm_v1_irq_unmask,
 	.cpu_enter_state = rcpm_v1_cpu_enter_state,
 	.cpu_exit_state = rcpm_v1_cpu_exit_state,
+	.cpu_up = rcpm_v1_cpu_up,
+	.cpu_die = rcpm_v1_cpu_die,
 	.plat_enter_sleep = rcpm_v1_plat_enter_sleep,
 	.set_ip_power = rcpm_v1_set_ip_power,
 	.freeze_time_base = rcpm_v1_freeze_time_base,
@@ -291,6 +345,8 @@ static const struct fsl_pm_ops qoriq_rcpm_v2_ops = {
 	.irq_unmask = rcpm_v2_irq_unmask,
 	.cpu_enter_state = rcpm_v2_cpu_enter_state,
 	.cpu_exit_state = rcpm_v2_cpu_exit_state,
+	.cpu_up = rcpm_v2_cpu_up,
+	.cpu_die = rcpm_v2_cpu_die,
 	.plat_enter_sleep = rcpm_v2_plat_enter_sleep,
 	.set_ip_power = rcpm_v2_set_ip_power,
 	.freeze_time_base = rcpm_v2_freeze_time_base,
-- 
1.9.1
