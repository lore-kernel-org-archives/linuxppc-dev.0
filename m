Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id C4BA567D8F
	for <linuxppc-dev@ozlabs.org>; Tue, 12 Dec 2006 22:27:56 +1100 (EST)
Message-Id: <20061211230754.380263000@sipsolutions.net>>
References: <20061211230208.526233000@sipsolutions.net>>
Date: Tue, 12 Dec 2006 00:02:09 +0100
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
Subject: [RFC 1/3] support powermac G5 CPU hotplug
Mime-Version: 1.0
Cc: Torrance <torrance123@gmail.com>, linux-pm@lists.osdl.org,
	Michael Buesch <mb@bu3sch.de>
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

--- linux-2.6-git.orig/arch/powerpc/platforms/powermac/smp.c	2006-12-11 23:34:47.612716759 +0100
+++ linux-2.6-git/arch/powerpc/platforms/powermac/smp.c	2006-12-11 23:37:54.971716759 +0100
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
--- linux-2.6-git.orig/arch/powerpc/platforms/powermac/setup.c	2006-12-11 23:34:47.648716759 +0100
+++ linux-2.6-git/arch/powerpc/platforms/powermac/setup.c	2006-12-11 23:37:54.974716759 +0100
@@ -490,6 +490,9 @@ static int pmac_late_init(void)
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	pm_set_ops(&pmac_pm_ops);
 #endif /* CONFIG_SOFTWARE_SUSPEND */
+	/* this is udbg (which is __init) and we can later use it during
+	 * cpu hotplug (in smp_core99_kick_cpu) */
+	ppc_md.progress = NULL;
 	return 0;
 }
 
@@ -716,6 +719,32 @@ static int pmac_pci_probe_mode(struct pc
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
 
 define_machine(powermac) {
@@ -754,6 +783,6 @@ define_machine(powermac) {
 	.phys_mem_access_prot	= pci_phys_mem_access_prot,
 #endif
 #if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC64)
-	.cpu_die		= generic_mach_cpu_die,
+	.cpu_die		= pmac_cpu_die,
 #endif
 };
--- linux-2.6-git.orig/arch/powerpc/kernel/smp.c	2006-12-11 23:34:47.693716759 +0100
+++ linux-2.6-git/arch/powerpc/kernel/smp.c	2006-12-11 23:37:55.017716759 +0100
@@ -558,6 +558,9 @@ int __devinit start_secondary(void *unus
 
 	local_irq_enable();
 
+	/* who knows what context the processor might have died in... */
+	task_thread_info(paca[cpu].__current)->preempt_count = 0;
+
 	cpu_idle();
 	return 0;
 }

--
