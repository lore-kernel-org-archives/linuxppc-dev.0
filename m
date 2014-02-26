Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 8A0672C0710
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Feb 2014 11:13:11 +1100 (EST)
Received: from /spool/local
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 25 Feb 2014 17:13:09 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 350C91FF003D
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 17:13:06 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s1PMAP867668050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 23:10:25 +0100
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s1Q0D4T1028690
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 25 Feb 2014 17:13:06 -0700
Subject: [PATCH 7/7] cpuidle/powernv: Parse device tree to setup idle states
To: linux-pm@vger.kernel.org, geoff@infradead.org, fweisbec@gmail.com,
 daniel.lezcano@linaro.org, srivatsa.bhat@linux.vnet.ibm.com,
 benh@kernel.crashing.org, tglx@linutronix.de,
 svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org, mingo@kernel.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Wed, 26 Feb 2014 05:39:20 +0530
Message-ID: <20140226000919.17879.87737.stgit@preeti>
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

Add deep idle states such as nap and fast sleep to the cpuidle state table
only if they are discovered from the device tree during cpuidle initialization.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

 drivers/cpuidle/cpuidle-powernv.c |   82 +++++++++++++++++++++++++++++--------
 1 file changed, 65 insertions(+), 17 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 4fb97ce..fdae1c4 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -12,10 +12,17 @@
 #include <linux/cpu.h>
 #include <linux/notifier.h>
 #include <linux/clockchips.h>
+#include <linux/of.h>
 
 #include <asm/machdep.h>
 #include <asm/firmware.h>
 
+/* Flags and constants used in PowerNV platform */
+
+#define MAX_POWERNV_IDLE_STATES	8
+#define IDLE_USE_INST_NAP	0x00010000 /* Use nap instruction */
+#define IDLE_USE_INST_SLEEP	0x00020000 /* Use sleep instruction */
+
 struct cpuidle_driver powernv_idle_driver = {
 	.name             = "powernv_idle",
 	.owner            = THIS_MODULE,
@@ -79,7 +86,7 @@ static int fastsleep_loop(struct cpuidle_device *dev,
 /*
  * States for dedicated partition case.
  */
-static struct cpuidle_state powernv_states[] = {
+static struct cpuidle_state powernv_states[MAX_POWERNV_IDLE_STATES] = {
 	{ /* Snooze */
 		.name = "snooze",
 		.desc = "snooze",
@@ -87,20 +94,6 @@ static struct cpuidle_state powernv_states[] = {
 		.exit_latency = 0,
 		.target_residency = 0,
 		.enter = &snooze_loop },
-	{ /* NAP */
-		.name = "NAP",
-		.desc = "NAP",
-		.flags = CPUIDLE_FLAG_TIME_VALID,
-		.exit_latency = 10,
-		.target_residency = 100,
-		.enter = &nap_loop },
-	 { /* Fastsleep */
-		.name = "fastsleep",
-		.desc = "fastsleep",
-		.flags = CPUIDLE_FLAG_TIME_VALID,
-		.exit_latency = 10,
-		.target_residency = 100,
-		.enter = &fastsleep_loop },
 };
 
 static int powernv_cpuidle_add_cpu_notifier(struct notifier_block *n,
@@ -161,19 +154,74 @@ static int powernv_cpuidle_driver_init(void)
 	return 0;
 }
 
+static int powernv_add_idle_states(void)
+{
+	struct device_node *power_mgt;
+	struct property *prop;
+	int nr_idle_states = 1; /* Snooze */
+	int dt_idle_states;
+	u32 *flags;
+	int i;
+
+	/* Currently we have snooze statically defined */
+
+	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
+	if (!power_mgt) {
+		pr_warn("opal: PowerMgmt Node not found\n");
+		return nr_idle_states;
+	}
+
+	prop = of_find_property(power_mgt, "ibm,cpu-idle-state-flags", NULL);
+	if (!prop) {
+		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-flags\n");
+		return nr_idle_states;
+	}
+
+	dt_idle_states = prop->length / sizeof(u32);
+	flags = (u32 *) prop->value;
+
+	for (i = 0; i < dt_idle_states; i++) {
+
+		if (flags[i] & IDLE_USE_INST_NAP) {
+			/* Add NAP state */
+			strcpy(powernv_states[nr_idle_states].name, "Nap");
+			strcpy(powernv_states[nr_idle_states].desc, "Nap");
+			powernv_states[nr_idle_states].flags = CPUIDLE_FLAG_TIME_VALID;
+			powernv_states[nr_idle_states].exit_latency = 10;
+			powernv_states[nr_idle_states].target_residency = 100;
+			powernv_states[nr_idle_states].enter = &nap_loop;
+			nr_idle_states++;
+		}
+
+		if (flags[i] & IDLE_USE_INST_SLEEP) {
+			/* Add FASTSLEEP state */
+			strcpy(powernv_states[nr_idle_states].name, "FastSleep");
+			strcpy(powernv_states[nr_idle_states].desc, "FastSleep");
+			powernv_states[nr_idle_states].flags =
+				CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TIMER_STOP;
+			powernv_states[nr_idle_states].exit_latency = 300;
+			powernv_states[nr_idle_states].target_residency = 1000000;
+			powernv_states[nr_idle_states].enter = &fastsleep_loop;
+			nr_idle_states++;
+		}
+	}
+
+	return nr_idle_states;
+}
+
 /*
  * powernv_idle_probe()
  * Choose state table for shared versus dedicated partition
  */
 static int powernv_idle_probe(void)
 {
-
 	if (cpuidle_disable != IDLE_NO_OVERRIDE)
 		return -ENODEV;
 
 	if (firmware_has_feature(FW_FEATURE_OPALv3)) {
 		cpuidle_state_table = powernv_states;
-		max_idle_state = ARRAY_SIZE(powernv_states);
+		/* Device tree can indicate more idle states */
+		max_idle_state = powernv_add_idle_states();
  	} else
  		return -ENODEV;
 
