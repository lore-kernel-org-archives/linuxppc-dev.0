Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [122.248.162.9])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp09.in.ibm.com", Issuer "GeoTrust SSL CA" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id 2A41810081D
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2011 23:47:18 +1100 (EST)
Received: from /spool/local
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Wed, 30 Nov 2011 18:17:16 +0530
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 pAUCkv2r2617434
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2011 18:16:57 +0530
Received: from d28av05.in.ibm.com (loopback [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 pAUCkuvD000769
 for <linuxppc-dev@ozlabs.org>; Wed, 30 Nov 2011 23:46:57 +1100
Subject: [RFC PATCH v3 3/4] cpuidle: (POWER) Enable cpuidle and directly call
 cpuidle_idle_call() for pSeries
To: benh@kernel.crashing.org, len.brown@intel.com
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Wed, 30 Nov 2011 18:16:55 +0530
Message-ID: <20111130124650.972.31776.stgit@deepthi-ThinkPad-T420>
In-Reply-To: <20111130124608.972.87712.stgit@deepthi-ThinkPad-T420>
References: <20111130124608.972.87712.stgit@deepthi-ThinkPad-T420>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@ozlabs.org, linux-pm@lists.linux-foundation.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch enables cpuidle for pSeries and pSeries_idle is
directly called from the idle loop. As a result of pSeries_idle, cpuidle
driver registered with cpuidle subsystem comes into action. On
failure of loading of the driver or cpuidle framework default idle
is executed as part of the function. This patch
also removes the routines pseries_shared_idle_sleep and
pseries_dedicated_idle_sleep as they are now implemented as part of
pseries_idle cpuidle driver.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Signed-off-by: Trinabh Gupta <g.trinabh@gmail.com>
Signed-off-by: Arun R Bharadwaj <arun.r.bharadwaj@gmail.com>
---
 arch/powerpc/platforms/Kconfig         |    6 ++
 arch/powerpc/platforms/pseries/setup.c |  101 +++++---------------------------
 include/linux/cpuidle.h                |    2 -
 3 files changed, 23 insertions(+), 86 deletions(-)

diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 3fe6d92..31e1ade 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -211,6 +211,12 @@ config PPC_PASEMI_CPUFREQ
 
 endmenu
 
+menu "CPUIdle driver"
+
+source "drivers/cpuidle/Kconfig"
+
+endmenu
+
 config PPC601_SYNC_FIX
 	bool "Workarounds for PPC601 bugs"
 	depends on 6xx && (PPC_PREP || PPC_PMAC)
diff --git a/arch/powerpc/platforms/pseries/setup.c b/arch/powerpc/platforms/pseries/setup.c
index 9c6716a..f19fc52 100644
--- a/arch/powerpc/platforms/pseries/setup.c
+++ b/arch/powerpc/platforms/pseries/setup.c
@@ -39,6 +39,7 @@
 #include <linux/irq.h>
 #include <linux/seq_file.h>
 #include <linux/root_dev.h>
+#include <linux/cpuidle.h>
 
 #include <asm/mmu.h>
 #include <asm/processor.h>
@@ -74,9 +75,6 @@ EXPORT_SYMBOL(CMO_PageSize);
 
 int fwnmi_active;  /* TRUE if an FWNMI handler is present */
 
-static void pseries_shared_idle_sleep(void);
-static void pseries_dedicated_idle_sleep(void);
-
 static struct device_node *pSeries_mpic_node;
 
 static void pSeries_show_cpuinfo(struct seq_file *m)
@@ -352,6 +350,21 @@ static int alloc_dispatch_log_kmem_cache(void)
 }
 early_initcall(alloc_dispatch_log_kmem_cache);
 
+static void pSeries_idle(void)
+{
+	/* This would call on the cpuidle framework, and the back-end pseries
+	 * driver to  go to idle states
+	 */
+	if (cpuidle_idle_call()) {
+		/* On error, execute default handler
+		 * to go into low thread priority and possibly
+		 * low power mode.
+		 */
+		HMT_low();
+		HMT_very_low();
+	}
+}
+
 static void __init pSeries_setup_arch(void)
 {
 	/* Discover PIC type and setup ppc_md accordingly */
@@ -374,18 +387,9 @@ static void __init pSeries_setup_arch(void)
 
 	pSeries_nvram_init();
 
-	/* Choose an idle loop */
 	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
 		vpa_init(boot_cpuid);
-		if (get_lppaca()->shared_proc) {
-			printk(KERN_DEBUG "Using shared processor idle loop\n");
-			ppc_md.power_save = pseries_shared_idle_sleep;
-		} else {
-			printk(KERN_DEBUG "Using dedicated idle loop\n");
-			ppc_md.power_save = pseries_dedicated_idle_sleep;
-		}
-	} else {
-		printk(KERN_DEBUG "Using default idle loop\n");
+		ppc_md.power_save = pSeries_idle;
 	}
 
 	if (firmware_has_feature(FW_FEATURE_LPAR))
@@ -586,77 +590,6 @@ static int __init pSeries_probe(void)
 	return 1;
 }
 
-static void pseries_dedicated_idle_sleep(void)
-{ 
-	unsigned int cpu = smp_processor_id();
-	unsigned long start_snooze;
-	unsigned long in_purr, out_purr;
-	long snooze = __get_cpu_var(smt_snooze_delay);
-
-	/*
-	 * Indicate to the HV that we are idle. Now would be
-	 * a good time to find other work to dispatch.
-	 */
-	get_lppaca()->idle = 1;
-	get_lppaca()->donate_dedicated_cpu = 1;
-	in_purr = mfspr(SPRN_PURR);
-
-	/*
-	 * We come in with interrupts disabled, and need_resched()
-	 * has been checked recently.  If we should poll for a little
-	 * while, do so.
-	 */
-	if (snooze) {
-		start_snooze = get_tb() + snooze * tb_ticks_per_usec;
-		local_irq_enable();
-		set_thread_flag(TIF_POLLING_NRFLAG);
-
-		while ((snooze < 0) || (get_tb() < start_snooze)) {
-			if (need_resched() || cpu_is_offline(cpu))
-				goto out;
-			ppc64_runlatch_off();
-			HMT_low();
-			HMT_very_low();
-		}
-
-		HMT_medium();
-		clear_thread_flag(TIF_POLLING_NRFLAG);
-		smp_mb();
-		local_irq_disable();
-		if (need_resched() || cpu_is_offline(cpu))
-			goto out;
-	}
-
-	cede_processor();
-
-out:
-	HMT_medium();
-	out_purr = mfspr(SPRN_PURR);
-	get_lppaca()->wait_state_cycles += out_purr - in_purr;
-	get_lppaca()->donate_dedicated_cpu = 0;
-	get_lppaca()->idle = 0;
-}
-
-static void pseries_shared_idle_sleep(void)
-{
-	/*
-	 * Indicate to the HV that we are idle. Now would be
-	 * a good time to find other work to dispatch.
-	 */
-	get_lppaca()->idle = 1;
-
-	/*
-	 * Yield the processor to the hypervisor.  We return if
-	 * an external interrupt occurs (which are driven prior
-	 * to returning here) or if a prod occurs from another
-	 * processor. When returning here, external interrupts
-	 * are enabled.
-	 */
-	cede_processor();
-
-	get_lppaca()->idle = 0;
-}
-
 static int pSeries_pci_probe_mode(struct pci_bus *bus)
 {
 	if (firmware_has_feature(FW_FEATURE_LPAR))
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 7408af8..23f81de 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -130,7 +130,6 @@ struct cpuidle_driver {
 #ifdef CONFIG_CPU_IDLE
 extern void disable_cpuidle(void);
 extern int cpuidle_idle_call(void);
-
 extern int cpuidle_register_driver(struct cpuidle_driver *drv);
 struct cpuidle_driver *cpuidle_get_driver(void);
 extern void cpuidle_unregister_driver(struct cpuidle_driver *drv);
@@ -145,7 +144,6 @@ extern void cpuidle_disable_device(struct cpuidle_device *dev);
 #else
 static inline void disable_cpuidle(void) { }
 static inline int cpuidle_idle_call(void) { return -ENODEV; }
-
 static inline int cpuidle_register_driver(struct cpuidle_driver *drv)
 {return -ENODEV; }
 static inline struct cpuidle_driver *cpuidle_get_driver(void) {return NULL; }
