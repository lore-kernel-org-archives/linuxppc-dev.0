Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 54B1B2C06D6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 11:12:59 +1100 (EST)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 17:12:57 -0700
Received: from b03cxnp08027.gho.boulder.ibm.com
 (b03cxnp08027.gho.boulder.ibm.com [9.17.130.19])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id A61BB19D8036
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 17:12:52 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08027.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1Q0CSHY4915546
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 01:12:28 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1Q0CpP4027929
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 17:12:53 -0700
Subject: [PATCH 6/7] cpuidle/powernv: Add "Fast-Sleep" CPU idle state
To: linux-pm@vger.kernel.org, geoff@infradead.org, fweisbec@gmail.com,
 daniel.lezcano@linaro.org, srivatsa.bhat@linux.vnet.ibm.com,
 benh@kernel.crashing.org, tglx@linutronix.de,
 svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Wed, 26 Feb 2014 05:39:06 +0530
Message-ID: <20140226000905.17879.44235.stgit@preeti>
In-Reply-To: <20140226000310.17879.67295.stgit@preeti>
References: <20140226000310.17879.67295.stgit@preeti>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: paulmck@linux.vnet.ibm.com, rafael.j.wysocki@intel.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Fast sleep is one of the deep idle states on Power8 in which local timers of
CPUs stop. On PowerPC we do not have an external clock device which can
handle wakeup of such CPUs. Now that we have the support in the tick broadcast
framework for archs that do not sport such a device and the low level support
for fast sleep, enable it in the cpuidle framework on PowerNV.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

 arch/powerpc/Kconfig              |    2 ++
 arch/powerpc/kernel/time.c        |    4 +++-
 drivers/cpuidle/cpuidle-powernv.c |   34 ++++++++++++++++++++++++++++++++++
 3 files changed, 39 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 957bf34..b841420 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -130,6 +130,8 @@ config PPC
 	select GENERIC_CMOS_UPDATE
 	select GENERIC_TIME_VSYSCALL_OLD
 	select GENERIC_CLOCKEVENTS
+	select GENERIC_CLOCKEVENTS_BROADCAST if SMP
+	select ARCH_HAS_TICK_BROADCAST if GENERIC_CLOCKEVENTS_BROADCAST
 	select GENERIC_STRNCPY_FROM_USER
 	select GENERIC_STRNLEN_USER
 	select HAVE_MOD_ARCH_SPECIFIC
diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
index df2989b..122a580 100644
--- a/arch/powerpc/kernel/time.c
+++ b/arch/powerpc/kernel/time.c
@@ -42,6 +42,7 @@
 #include <linux/timex.h>
 #include <linux/kernel_stat.h>
 #include <linux/time.h>
+#include <linux/clockchips.h>
 #include <linux/init.h>
 #include <linux/profile.h>
 #include <linux/cpu.h>
@@ -106,7 +107,7 @@ struct clock_event_device decrementer_clockevent = {
 	.irq            = 0,
 	.set_next_event = decrementer_set_next_event,
 	.set_mode       = decrementer_set_mode,
-	.features       = CLOCK_EVT_FEAT_ONESHOT,
+	.features       = CLOCK_EVT_FEAT_ONESHOT | CLOCK_EVT_FEAT_C3STOP,
 };
 EXPORT_SYMBOL(decrementer_clockevent);
 
@@ -944,6 +945,7 @@ void __init time_init(void)
 	clocksource_init();
 
 	init_decrementer_clockevent();
+	tick_setup_hrtimer_broadcast();
 }
 
 
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 78fd174..4fb97ce 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -11,6 +11,7 @@
 #include <linux/cpuidle.h>
 #include <linux/cpu.h>
 #include <linux/notifier.h>
+#include <linux/clockchips.h>
 
 #include <asm/machdep.h>
 #include <asm/firmware.h>
@@ -49,6 +50,32 @@ static int nap_loop(struct cpuidle_device *dev,
 	return index;
 }
 
+static int fastsleep_loop(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv,
+				int index)
+{
+	unsigned long old_lpcr = mfspr(SPRN_LPCR);
+	unsigned long new_lpcr;
+
+	if (unlikely(system_state < SYSTEM_RUNNING))
+		return index;
+
+	new_lpcr = old_lpcr;
+	new_lpcr &= ~(LPCR_MER | LPCR_PECE); /* lpcr[mer] must be 0 */
+
+	/* exit powersave upon external interrupt, but not decrementer
+	 * interrupt.
+	 */
+	new_lpcr |= LPCR_PECE0;
+
+	mtspr(SPRN_LPCR, new_lpcr);
+	power7_sleep();
+
+	mtspr(SPRN_LPCR, old_lpcr);
+
+	return index;
+}
+
 /*
  * States for dedicated partition case.
  */
@@ -67,6 +94,13 @@ static struct cpuidle_state powernv_states[] = {
 		.exit_latency = 10,
 		.target_residency = 100,
 		.enter = &nap_loop },
+	 { /* Fastsleep */
+		.name = "fastsleep",
+		.desc = "fastsleep",
+		.flags = CPUIDLE_FLAG_TIME_VALID,
+		.exit_latency = 10,
+		.target_residency = 100,
+		.enter = &fastsleep_loop },
 };
 
 static int powernv_cpuidle_add_cpu_notifier(struct notifier_block *n,
