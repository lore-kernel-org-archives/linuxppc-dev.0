Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e38.co.us.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 1C6202C07EC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 21:47:20 +1100 (EST)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Fri, 29 Nov 2013 03:47:18 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 9BC3F19D803E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 03:47:09 -0700 (MST)
Received: from d03av06.boulder.ibm.com (d03av06.boulder.ibm.com [9.17.195.245])
 by b03cxnp08026.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAT8jPCZ29163560
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 09:45:25 +0100
Received: from d03av06.boulder.ibm.com (loopback [127.0.0.1])
 by d03av06.boulder.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 rATAoBTa022884
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Nov 2013 03:50:12 -0700
Subject: [PATCH V4 9/9] cpuidle/powernv: Parse device tree to setup idle states
To: fweisbec@gmail.com, paul.gortmaker@windriver.com, paulus@samba.org,
 shangw@linux.vnet.ibm.com, rjw@sisk.pl, galak@kernel.crashing.org,
 benh@kernel.crashing.org, paulmck@linux.vnet.ibm.com, arnd@arndb.de,
 linux-pm@vger.kernel.org, rostedt@goodmis.org, michael@ellerman.id.au,
 john.stultz@linaro.org, tglx@linutronix.de, chenhui.zhao@freescale.com,
 deepthi@linux.vnet.ibm.com, r58472@freescale.com, geoff@infradead.org,
 linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
 schwidefsky@de.ibm.com, svaidy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Fri, 29 Nov 2013 16:13:51 +0530
Message-ID: <20131129104351.651.84944.stgit@preeti.in.ibm.com>
In-Reply-To: <20131129104010.651.23117.stgit@preeti.in.ibm.com>
References: <20131129104010.651.23117.stgit@preeti.in.ibm.com>
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

Signed-off-by: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
---

 drivers/cpuidle/cpuidle-powerpc-book3s.c |   81 ++++++++++++++++++++++++------
 1 file changed, 64 insertions(+), 17 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powerpc-book3s.c b/drivers/cpuidle/cpuidle-powerpc-book3s.c
index 59cd529..b80ee9b 100644
--- a/drivers/cpuidle/cpuidle-powerpc-book3s.c
+++ b/drivers/cpuidle/cpuidle-powerpc-book3s.c
@@ -18,6 +18,7 @@
 #include <linux/ktime.h>
 #include <linux/spinlock.h>
 #include <linux/slab.h>
+#include <linux/of.h>
 
 #include <asm/paca.h>
 #include <asm/reg.h>
@@ -27,6 +28,12 @@
 #include <asm/time.h>
 #include <asm/plpar_wrappers.h>
 
+/* Flags and constants used in PowerNV platform */
+
+#define MAX_POWERNV_IDLE_STATES	8
+#define IDLE_USE_INST_NAP	0x00010000 /* Use nap instruction */
+#define IDLE_USE_INST_SLEEP	0x00020000 /* Use sleep instruction */
+
 struct cpuidle_driver powerpc_book3s_idle_driver = {
 	.name             = "powerpc_book3s_idle",
 	.owner            = THIS_MODULE,
@@ -327,7 +334,7 @@ static struct cpuidle_state shared_states[] = {
 		.enter = &shared_cede_loop },
 };
 
-static struct cpuidle_state powernv_states[] = {
+static struct cpuidle_state powernv_states[MAX_POWERNV_IDLE_STATES] = {
 	{ /* Snooze */
 		.name = "snooze",
 		.desc = "snooze",
@@ -335,20 +342,6 @@ static struct cpuidle_state powernv_states[] = {
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
 
 void update_smt_snooze_delay(int cpu, int residency)
@@ -418,6 +411,60 @@ static struct notifier_block setup_hotplug_notifier = {
 	.notifier_call = powerpc_book3s_cpuidle_add_cpu_notifier,
 };
 
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
  * powerpc_book3s_cpuidle_driver_init()
  */
@@ -448,7 +495,6 @@ static int powerpc_book3s_cpuidle_driver_init(void)
  */
 static int powerpc_book3s_idle_probe(void)
 {
-
 	if (cpuidle_disable != IDLE_NO_OVERRIDE)
 		return -ENODEV;
 
@@ -463,7 +509,8 @@ static int powerpc_book3s_idle_probe(void)
 
 	} else if (firmware_has_feature(FW_FEATURE_OPALv3)) {
 		cpuidle_state_table = powernv_states;
-		max_idle_state = ARRAY_SIZE(powernv_states);
+		/* Device tree can indicate more idle states */
+		max_idle_state = powernv_add_idle_states();
 
 	} else
 		return -ENODEV;
