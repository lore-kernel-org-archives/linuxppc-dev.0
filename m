Return-Path: <johannes@sipsolutions.net>
Received: from sipsolutions.net (crystal.sipsolutions.net [195.210.38.204])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E56C567A76
	for <linuxppc-dev@ozlabs.org>; Sat, 24 Jun 2006 00:13:58 +1000 (EST)
Subject: [RFC] cpu hotplug in powermac g5
From: Johannes Berg <johannes@sipsolutions.net>
To: linuxppc-dev@ozlabs.org
In-Reply-To: <1150845770.16662.7.camel@johannes>
References: <1150845770.16662.7.camel@johannes>
Content-Type: text/plain
Date: Fri, 23 Jun 2006 12:03:09 +0200
Message-Id: <1151056989.7608.11.camel@localhost>
Mime-Version: 1.0
Cc: Michael Buesch <mbuesch@freenet.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Never mind the previous patch :) This one works much better.

Note that for software suspend, the generic cpu hotplug are not usable
because they don't re-sync timebase etc. Hence, I here only use the
generic die routines but the loop in which offline processors are is
custom, and we use the regular CPU bring-up sequence instead of just
exiting the loop.

---
This patch makes CPU hotplug work on my pm11,2. It works by reusing the
normal smp_core99_kick_cpu routine for wakeup, and introducing a new
routine that offline CPUs idle in, which is modeled after the idle loop
but has no way out (except for taking the soft reset exception triggered
by kick_cpu). This is required because the generic cpu hotplug code
doesn't completely re-initialise the CPU when bringing it online again,
which is required for software suspend.

Signed-off-by: Johannes Berg <johannes@sipsolutions.net>

--- linux-2.6-git.orig/arch/powerpc/platforms/powermac/smp.c	2006-06-23 11:32:49.254352863 +0200
+++ linux-2.6-git/arch/powerpc/platforms/powermac/smp.c	2006-06-23 11:37:23.311886323 +0200
@@ -895,7 +895,7 @@
 	cpu_dead[cpu] = 0;
 }
 
-#endif
+#endif /* CONFIG_HOTPLUG_CPU && CONFIG_PP32 */
 
 /* Core99 Macs (dual G4s and G5s) */
 struct smp_ops_t core99_smp_ops = {
@@ -905,8 +905,16 @@
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
--- linux-2.6-git.orig/arch/powerpc/platforms/powermac/setup.c	2006-06-23 11:32:49.309352368 +0200
+++ linux-2.6-git/arch/powerpc/platforms/powermac/setup.c	2006-06-23 11:38:31.484272766 +0200
@@ -492,6 +492,9 @@
 #ifdef CONFIG_SOFTWARE_SUSPEND
 	pm_set_ops(&pmac_pm_ops);
 #endif /* CONFIG_SOFTWARE_SUSPEND */
+	/* this is udbg (which is __init) and we can later use it during
+	 * cpu hotplug (in smp_core99_kick_cpu) */
+	ppc_md.progress = NULL;
 	return 0;
 }
 
@@ -728,6 +731,32 @@
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
+	local_irq_disable();
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
@@ -766,6 +795,6 @@
 	.phys_mem_access_prot	= pci_phys_mem_access_prot,
 #endif
 #if defined(CONFIG_HOTPLUG_CPU) && defined(CONFIG_PPC64)
-	.cpu_die		= generic_mach_cpu_die,
+	.cpu_die		= pmac_cpu_die,
 #endif
 };
