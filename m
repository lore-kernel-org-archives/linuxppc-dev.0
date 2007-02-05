Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 137ADDE15E
	for <linuxppc-dev@ozlabs.org>; Tue,  6 Feb 2007 06:09:28 +1100 (EST)
Message-Id: <20070205185837.640324000@sipsolutions.net>
References: <20070205183026.989209000@sipsolutions.net>
Date: Mon, 05 Feb 2007 19:30:34 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 07/10] powermac: support G5 CPU hotplug
Mime-Version: 1.0
Cc: linux-pm@lists.osdl.org, Torrance <torrance123@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch allows "hotplugging" of CPUs on G5 machines. CPUs that are
disabled are put into an idle loop with interrupts hard-disabled, to wake
them up again we kick them just like when bringing them up.

Maybe there's some way to actually turn off those CPUs even more?

Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>

--- mb-wireless.orig/arch/powerpc/platforms/powermac/smp.c	2007-02-05 16:07:09.164524763 +0100
+++ mb-wireless/arch/powerpc/platforms/powermac/smp.c	2007-02-05 16:07:50.774524763 +0100
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
--- mb-wireless.orig/arch/powerpc/platforms/powermac/setup.c	2007-02-05 16:07:22.024524763 +0100
+++ mb-wireless/arch/powerpc/platforms/powermac/setup.c	2007-02-05 16:07:50.784524763 +0100
@@ -490,6 +490,9 @@ static int pmac_late_init(void)
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	pm_set_ops(&pmac_pm_ops);
 #endif /* CONFIG_SOFTWARE_SUSPEND */
+	/* this is udbg (which is __init) and we can later use it during
+	 * cpu hotplug (in smp_core99_kick_cpu) */
+	ppc_md.progress = NULL;
 	return 0;
 }
 
@@ -716,6 +719,33 @@ static int pmac_pci_probe_mode(struct pc
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
+	hard_irq_disable();
+
+	printk(KERN_DEBUG "CPU#%d offline\n", smp_processor_id());
+	__get_cpu_var(cpu_state) = CPU_DEAD;
+	smp_wmb();
+	while (1) {
+		ppc64_runlatch_off();
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
@@ -769,6 +799,6 @@ define_machine(powermac) {
 	.phys_mem_access_prot	= pci_phys_mem_access_prot,
 #endif
 #if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC64)
-	.cpu_die		= generic_mach_cpu_die,
+	.cpu_die		= pmac_cpu_die,
 #endif
 };
--- mb-wireless.orig/arch/powerpc/kernel/smp.c	2007-02-05 16:07:09.274524763 +0100
+++ mb-wireless/arch/powerpc/kernel/smp.c	2007-02-05 18:15:51.114524763 +0100
@@ -558,6 +558,11 @@ int __devinit start_secondary(void *unus
 
 	local_irq_enable();
 
+	/* it seems to be possible that we died from within
+	 * an interrupt ... reset the in-irq counts */
+	task_thread_info(paca[cpu].__current)->preempt_count &=
+		~(SOFTIRQ_MASK|HARDIRQ_MASK);
+
 	cpu_idle();
 	return 0;
 }

--
