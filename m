Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id A86F8679FD
	for <linuxppc-dev@ozlabs.org>; Thu, 26 May 2005 13:29:56 +1000 (EST)
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Andrew Morton <akpm@osdl.org>
Content-Type: text/plain
Date: Thu, 26 May 2005 13:29:31 +1000
Message-Id: <1117078171.9076.16.camel@gaston>
Mime-Version: 1.0
Cc: linuxppc-dev list <linuxppc-dev@ozlabs.org>,
	Linus Torvalds <torvalds@osdl.org>
Subject: [PATCH] ppc32: Fix cpufreq vs. sleep issue
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hi !

Recent kernel occasionally trigger a PMU timeout on some mac laptops,
typically on wakeup from sleep. This seem to be caused by either a too
big latency caused by the cpufreq switch on wakeup from sleep or by an
interrupt beeing lost due to the reset of the interrupt controller done
during wakeup.

This patch makes that code more robust by stopping PMU auto poll
activity around cpufreq changes on machines that use the PMU for such
changes (long latency switching involving a CPU hard reset and flush of
all caches) and by removing the reset of the open pic interrupt
controller on wakeup (that can cause the loss of an interrupt and Darwin
doesn't do it, so it must not be necessary).

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Index: linux-work/arch/ppc/platforms/pmac_cpufreq.c
===================================================================
--- linux-work.orig/arch/ppc/platforms/pmac_cpufreq.c	2005-05-18 12:00:28.000000000 +1000
+++ linux-work/arch/ppc/platforms/pmac_cpufreq.c	2005-05-26 10:35:03.000000000 +1000
@@ -271,6 +271,8 @@
 #ifdef DEBUG_FREQ
 	printk(KERN_DEBUG "HID1, before: %x\n", mfspr(SPRN_HID1));
 #endif
+	pmu_suspend();
+
 	/* Disable all interrupt sources on openpic */
  	pic_prio = openpic_get_priority();
 	openpic_set_priority(0xf);
@@ -345,6 +347,8 @@
 	debug_calc_bogomips();
 #endif
 
+	pmu_resume();
+
 	preempt_enable();
 
 	return 0;
Index: linux-work/drivers/macintosh/via-pmu.c
===================================================================
--- linux-work.orig/drivers/macintosh/via-pmu.c	2005-05-18 12:00:28.000000000 +1000
+++ linux-work/drivers/macintosh/via-pmu.c	2005-05-26 10:38:04.000000000 +1000
@@ -2431,7 +2431,7 @@
 
 	/* Re-enable local CPU interrupts */
 	local_irq_enable();
-	mdelay(100);
+	mdelay(10);
 	preempt_enable();
 
 	/* Re-enable clock spreading on some machines */
@@ -2559,7 +2559,9 @@
 		return ret;
 	}
 
-	printk(KERN_DEBUG "HID1, before: %x\n", mfspr(SPRN_HID1));
+	/* Stop environment and ADB interrupts */
+	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, 0);
+	pmu_wait_complete(&req);
 
 	/* Tell PMU what events will wake us up */
 	pmu_request(&req, NULL, 4, PMU_POWER_EVENTS, PMU_PWR_CLR_WAKEUP_EVENTS,
@@ -2621,8 +2623,6 @@
 	pmu_request(&req, NULL, 2, PMU_SET_INTR_MASK, pmu_intr_mask);
 	pmu_wait_complete(&req);
 
-	printk(KERN_DEBUG "HID1, after: %x\n", mfspr(SPRN_HID1));
-
 	pmac_wakeup_devices();
 
 	return 0;
Index: linux-work/arch/ppc/syslib/open_pic.c
===================================================================
--- linux-work.orig/arch/ppc/syslib/open_pic.c	2005-05-18 12:00:28.000000000 +1000
+++ linux-work/arch/ppc/syslib/open_pic.c	2005-05-26 10:42:24.000000000 +1000
@@ -275,7 +275,7 @@
 }
 #endif
 
-#if defined(CONFIG_EPIC_SERIAL_MODE) || defined(CONFIG_PM)
+#if defined(CONFIG_EPIC_SERIAL_MODE)
 static void openpic_reset(void)
 {
 	openpic_setfield(&OpenPIC->Global.Global_Configuration0,
@@ -1007,8 +1007,6 @@
 		return 0;
 	}
 
-	openpic_reset();
-
 	/* OpenPIC sometimes seem to need some time to be fully back up... */
 	do {
 		openpic_set_spurious(OPENPIC_VEC_SPURIOUS);
