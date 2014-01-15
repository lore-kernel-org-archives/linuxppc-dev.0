Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 295D32C0779
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 19:14:10 +1100 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 15 Jan 2014 03:14:08 -0500
Received: from b01cxnp23034.gho.pok.ibm.com (b01cxnp23034.gho.pok.ibm.com
 [9.57.198.29])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 0C94338C8045
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 03:14:05 -0500 (EST)
Received: from d01av05.pok.ibm.com (d01av05.pok.ibm.com [9.56.224.195])
 by b01cxnp23034.gho.pok.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0F8E4a66619632
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 08:14:04 GMT
Received: from d01av05.pok.ibm.com (localhost [127.0.0.1])
 by d01av05.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0F8E20B002964
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Jan 2014 03:14:04 -0500
Subject: [PATCH V5 8/8] cpuidle/powernv: Parse device tree to setup idle states
To: daniel.lezcano@linaro.org, peterz@infradead.org, fweisbec@gmail.com,
 agraf@suse.de, paul.gortmaker@windriver.com, paulus@samba.org,
 mingo@kernel.org, mikey@neuling.org, shangw@linux.vnet.ibm.com,
 rafael.j.wysocki@intel.com, galak@kernel.crashing.org,
 benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, arnd@arndb.de,
 linux-pm@vger.kernel.org, rostedt@goodmis.org, michael@ellerman.id.au,
 john.stultz@linaro.org, anton@samba.org, tglx@linutronix.de,
 chenhui.zhao@freescale.com, deepthi@linux.vnet.ibm.com,
 r58472@freescale.com, geoff@infradead.org,
 linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
 schwidefsky@de.ibm.com, svaidy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Wed, 15 Jan 2014 13:40:30 +0530
Message-ID: <20140115081030.20446.2989.stgit@preeti.in.ibm.com>
In-Reply-To: <20140115080555.20446.27238.stgit@preeti.in.ibm.com>
References: <20140115080555.20446.27238.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

 drivers/cpuidle/cpuidle-powernv.c |   81 +++++++++++++++++++++++++++++--------
 1 file changed, 64 insertions(+), 17 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index e3aa62f..b01987d 100644
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
@@ -84,7 +91,7 @@ static int fastsleep_loop(struct cpuidle_device *dev,
 /*
  * States for dedicated partition case.
  */
-static struct cpuidle_state powernv_states[] = {
+static struct cpuidle_state powernv_states[MAX_POWERNV_IDLE_STATES] = {
 	{ /* Snooze */
 		.name = "snooze",
 		.desc = "snooze",
@@ -92,20 +99,6 @@ static struct cpuidle_state powernv_states[] = {
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
@@ -166,19 +159,73 @@ static int powernv_cpuidle_driver_init(void)
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
+			powernv_states[nr_idle_states].flags = CPUIDLE_FLAG_TIME_VALID;
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
 
