Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 0F68FDDE3F
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Feb 2007 00:31:34 +1100 (EST)
Subject: Re: [PATCH 02/12] powermac: support G5 CPU hotplug
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1170940494.4385.51.camel@johannes.berg>
References: <20070207124536.963531000@sipsolutions.net>
	<20070207124610.392302000@sipsolutions.net>
	<1170940494.4385.51.camel@johannes.berg>
Content-Type: text/plain
Date: Thu, 08 Feb 2007 14:28:41 +0100
Message-Id: <1170941321.4385.61.camel@johannes.berg>
Mime-Version: 1.0
Cc: linux-pm@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch allows "hotplugging" of CPUs on G5 machines. CPUs that are
disabled are put into an idle loop with the decrementer frequency set
to minimum. To wake them up again we kick them just like when bringing
them up. To stop those CPUs from messing with any global state we stop
them from entering the timer interrupt.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

--- linux-2.6-git.orig/arch/powerpc/platforms/powermac/smp.c	2007-02-08 12:52:47.694172211 +0100
+++ linux-2.6-git/arch/powerpc/platforms/powermac/smp.c	2007-02-08 12:52:56.835172211 +0100
@@ -898,7 +898,7 @@ void smp_core99_cpu_die(unsigned int cpu
 	cpu_dead[cpu] = 0;
 }
 
-#endif
+#endif /* CONFIG_HOTPLUG_CPU && CONFIG_PP32 */
 
 /* Core99 Macs (dual G4s and G5s) */
 struct smp_ops_t core99_smp_ops = {
@@ -908,8 +908,16 @@ struct smp_ops_t core99_smp_ops = {
 	.setup_cpu	= smp_core99_setup_cpu,
 	.give_timebase	= smp_core99_give_timebase,
 	.take_timebase	= smp_core99_take_timebase,
-#if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC32)
+#if defined(CONFIG_HOTPLUG_CPU)
+# if defined(CONFIG_PPC32)
 	.cpu_disable	= smp_core99_cpu_disable,
 	.cpu_die	= smp_core99_cpu_die,
+# endif
+# if defined(CONFIG_PPC64)
+	.cpu_disable	= generic_cpu_disable,
+	.cpu_die	= generic_cpu_die,
+	/* intentionally do *NOT* assign cpu_enable,
+	 * the generic code will use kick_cpu then! */
+# endif
 #endif
 };
--- linux-2.6-git.orig/arch/powerpc/platforms/powermac/setup.c	2007-02-08 12:52:47.722172211 +0100
+++ linux-2.6-git/arch/powerpc/platforms/powermac/setup.c	2007-02-08 13:17:06.436651035 +0100
@@ -490,6 +490,9 @@ static int pmac_late_init(void)
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	pm_set_ops(&pmac_pm_ops);
 #endif /* CONFIG_SOFTWARE_SUSPEND */
+	/* this is udbg (which is __init) and we can later use it during
+	 * cpu hotplug (in smp_core99_kick_cpu) */
+	ppc_md.progress = NULL;
 	return 0;
 }
 
@@ -716,6 +719,44 @@ static int pmac_pci_probe_mode(struct pc
 		return PCI_PROBE_NORMAL;
 	return PCI_PROBE_DEVTREE;
 }
+
+#ifdef CONFIG_HOTPLUG_CPU
+/* access per cpu vars from generic smp.c */
+DECLARE_PER_CPU(int, cpu_state);
+
+static void pmac_cpu_die(void)
+{
+	/* turn off as much as possible, we'll be
+	 * kicked out as this will only be invoked
+	 * on core99 platforms for now ... */
+
+	hard_irq_disable();
+
+	printk(KERN_INFO "CPU#%d offline\n", smp_processor_id());
+	__get_cpu_var(cpu_state) = CPU_DEAD;
+	smp_wmb();
+
+	/* during the path that leads here preemption is disabled,
+	 * reenable it now so that when coming up preempt count is
+	 * zero correctly */
+	preempt_enable();
+
+	while (1) {
+		ppc64_runlatch_off();
+
+		/* let's not take timer interrupts too often ... */
+		set_dec(0x7fffffff);
+
+		if (ppc_md.power_save) {
+			ppc_md.power_save();
+		} else {
+			HMT_low();
+			HMT_very_low();
+		}
+	}
+}
+#endif
+
 #endif
 
 static void __init pmac_init_irq(void)
@@ -769,6 +810,6 @@ define_machine(powermac) {
 	.phys_mem_access_prot	= pci_phys_mem_access_prot,
 #endif
 #if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC64)
-	.cpu_die		= generic_mach_cpu_die,
+	.cpu_die		= pmac_cpu_die,
 #endif
 };
--- linux-2.6-git.orig/arch/powerpc/kernel/time.c	2007-02-08 12:54:22.776172211 +0100
+++ linux-2.6-git/arch/powerpc/kernel/time.c	2007-02-08 13:17:41.666651035 +0100
@@ -597,6 +597,11 @@ static void iSeries_tb_recal(void)
 }
 #endif
 
+#ifdef CONFIG_CPU_HOTPLUG
+/* from smp.c, see below in timer_interrupt() */
+DECLARE_PER_CPU(int, cpu_state);
+#endif
+
 /*
  * For iSeries shared processors, we have to let the hypervisor
  * set the hardware decrementer.  We set a virtual decrementer
@@ -619,6 +624,15 @@ void timer_interrupt(struct pt_regs * re
 	unsigned long ticks;
 	u64 tb_next_jiffy;
 
+#ifdef CONFIG_CPU_HOTPLUG
+	/* if we have fake CPU hotplug just to support suspend to disk
+	 * and can't really turn off a CPU, it may be taking timer interrupts
+	 * even when it is dead. Avoid doing anything in that case so global
+	 * state is not modified for and by a CPU that doesn't really exist. */
+	if (__get_cpu_var(cpu_state) == CPU_DEAD)
+		return;
+#endif
+
 #ifdef CONFIG_PPC32
 	if (atomic_read(&ppc_n_lost_interrupts) != 0)
 		do_IRQ(regs);
