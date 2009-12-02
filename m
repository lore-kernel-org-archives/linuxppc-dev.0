Return-Path: <arun@linux.vnet.ibm.com>
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e23smtp07.au.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 3701AB7BF1
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed,  2 Dec 2009 21:01:16 +1100 (EST)
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [202.81.31.246])
	by e23smtp07.au.ibm.com (8.14.3/8.13.1) with ESMTP id nB2A1FEM002969
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Dec 2009 21:01:15 +1100
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
	by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
	nB29vdqe1581236
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Dec 2009 20:57:39 +1100
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
	by d23av04.au.ibm.com (8.14.3/8.13.1/NCO v10.0 AVout) with ESMTP id
	nB2A1EdA017027
	for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Dec 2009 21:01:15 +1100
Date: Wed, 2 Dec 2009 15:31:08 +0530
From: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>,
	Benjamin Herrenschmidt <benh@kernel.crashing.org>,
	Ingo Molnar <mingo@elte.hu>,
	Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
	Dipankar Sarma <dipankar@in.ibm.com>, Balbir Singh <balbir@in.ibm.com>,
	Venkatesh Pallipadi <venkatesh.pallipadi@intel.com>,
	Arun Bharadwaj <arun@linux.vnet.ibm.com>
Subject: [v10 PATCH 6/9]: pSeries/cpuidle: refactor pseries idle loops
Message-ID: <20091202100108.GG27251@linux.vnet.ibm.com>
References: <20091202095427.GA27251@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <20091202095427.GA27251@linux.vnet.ibm.com>
Cc: linux-arch@vger.kernel.org, linux-acpi@vger.kernel.org,
	linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Reply-To: arun@linux.vnet.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* Arun R Bharadwaj <arun@linux.vnet.ibm.com> [2009-12-02 15:24:27]:

This patch removes the routines, pseries_shared_idle_sleep and
pseries_dedicated_idle_sleep, since this is implemented as a part
of arch/powerpc/platform/pseries/processor_idle.c

Also, similar to x86, call cpuidle_idle_call from cpu_idle() idle
loop instead of ppc_md.power_save.


Signed-off-by: Arun R Bharadwaj <arun@linux.vnet.ibm.com>
---
 arch/powerpc/kernel/idle.c             |   58 ++++++++++-----------
 arch/powerpc/platforms/pseries/setup.c |   89 ---------------------------------
 2 files changed, 30 insertions(+), 117 deletions(-)

Index: linux.trees.git/arch/powerpc/platforms/pseries/setup.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/platforms/pseries/setup.c
+++ linux.trees.git/arch/powerpc/platforms/pseries/setup.c
@@ -75,9 +75,6 @@ EXPORT_SYMBOL(CMO_PageSize);
 
 int fwnmi_active;  /* TRUE if an FWNMI handler is present */
 
-static void pseries_shared_idle_sleep(void);
-static void pseries_dedicated_idle_sleep(void);
-
 static struct device_node *pSeries_mpic_node;
 
 static void pSeries_show_cpuinfo(struct seq_file *m)
@@ -297,18 +294,8 @@ static void __init pSeries_setup_arch(vo
 	pSeries_nvram_init();
 
 	/* Choose an idle loop */
-	if (firmware_has_feature(FW_FEATURE_SPLPAR)) {
+	if (firmware_has_feature(FW_FEATURE_SPLPAR))
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
-	}
 
 	if (firmware_has_feature(FW_FEATURE_LPAR))
 		ppc_md.enable_pmcs = pseries_lpar_enable_pmcs;
@@ -496,80 +483,6 @@ static int __init pSeries_probe(void)
 	return 1;
 }
 
-
-DECLARE_PER_CPU(unsigned long, smt_snooze_delay);
-
-static void pseries_dedicated_idle_sleep(void)
-{ 
-	unsigned int cpu = smp_processor_id();
-	unsigned long start_snooze;
-	unsigned long in_purr, out_purr;
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
-	if (__get_cpu_var(smt_snooze_delay)) {
-		start_snooze = get_tb() +
-			__get_cpu_var(smt_snooze_delay) * tb_ticks_per_usec;
-		local_irq_enable();
-		set_thread_flag(TIF_POLLING_NRFLAG);
-
-		while (get_tb() < start_snooze) {
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
Index: linux.trees.git/arch/powerpc/kernel/idle.c
===================================================================
--- linux.trees.git.orig/arch/powerpc/kernel/idle.c
+++ linux.trees.git/arch/powerpc/kernel/idle.c
@@ -25,6 +25,7 @@
 #include <linux/cpu.h>
 #include <linux/sysctl.h>
 #include <linux/tick.h>
+#include <linux/cpuidle.h>
 
 #include <asm/system.h>
 #include <asm/processor.h>
@@ -46,6 +47,14 @@ static int __init powersave_off(char *ar
 }
 __setup("powersave=off", powersave_off);
 
+#ifndef CONFIG_CPU_IDLE
+void cpuidle_idle_call(void)
+{
+	local_irq_enable();
+	cpu_relax();
+}
+#endif
+
 /*
  * The body of the idle task.
  */
@@ -60,35 +69,26 @@ void cpu_idle(void)
 		while (!need_resched() && !cpu_should_die()) {
 			ppc64_runlatch_off();
 
-			if (ppc_md.power_save) {
-				clear_thread_flag(TIF_POLLING_NRFLAG);
-				/*
-				 * smp_mb is so clearing of TIF_POLLING_NRFLAG
-				 * is ordered w.r.t. need_resched() test.
-				 */
-				smp_mb();
-				local_irq_disable();
-
-				/* Don't trace irqs off for idle */
-				stop_critical_timings();
-
-				/* check again after disabling irqs */
-				if (!need_resched() && !cpu_should_die())
-					ppc_md.power_save();
-
-				start_critical_timings();
-
-				local_irq_enable();
-				set_thread_flag(TIF_POLLING_NRFLAG);
-
-			} else {
-				/*
-				 * Go into low thread priority and possibly
-				 * low power mode.
-				 */
-				HMT_low();
-				HMT_very_low();
-			}
+			clear_thread_flag(TIF_POLLING_NRFLAG);
+			/*
+			 * smp_mb is so clearing of TIF_POLLING_NRFLAG
+			 * is ordered w.r.t. need_resched() test.
+			 */
+			smp_mb();
+			local_irq_disable();
+
+			/* Don't trace irqs off for idle */
+			stop_critical_timings();
+
+			/* check again after disabling irqs */
+			if (!need_resched() && !cpu_should_die())
+				cpuidle_idle_call();
+
+			start_critical_timings();
+
+			local_irq_enable();
+			set_thread_flag(TIF_POLLING_NRFLAG);
+
 		}
 
 		HMT_medium();
