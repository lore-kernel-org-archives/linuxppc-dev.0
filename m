Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3v7dgx4rL9zDq5b
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 19:36:45 +1100 (AEDT)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v0P8aUJh036287
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 03:36:43 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 286m1qa2cv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jan 2017 03:36:43 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 25 Jan 2017 03:36:42 -0500
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Stewart Smith <stewart@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>,
 "Oliver O'Halloran" <oohall@gmail.com>, Rob Herring <robh+dt@kernel.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
 mark.rutland@arm.com, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH v6 3/5] cpuidle:powernv: Add helper function to populate
 powernv idle states.
Date: Wed, 25 Jan 2017 14:06:27 +0530
In-Reply-To: <1485333389-5752-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1485333389-5752-1-git-send-email-ego@linux.vnet.ibm.com>
Message-Id: <1485333389-5752-4-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

In the current code for powernv_add_idle_states, there is a lot of code
duplication while initializing an idle state in powernv_states table.

Add an inline helper function to populate the powernv_states[] table
for a given idle state. Invoke this for populating the "Nap",
"Fastsleep" and the stop states in powernv_add_idle_states.

Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 89 +++++++++++++++++++++++----------------
 include/linux/cpuidle.h           |  1 +
 2 files changed, 54 insertions(+), 36 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 0835a37..6871b7f 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -20,6 +20,10 @@
 #include <asm/opal.h>
 #include <asm/runlatch.h>
 
+/*
+ * Expose only those Hardware idle states via the cpuidle framework
+ * that have latency value below POWERNV_THRESHOLD_LATENCY_NS.
+ */
 #define POWERNV_THRESHOLD_LATENCY_NS 200000
 
 static struct cpuidle_driver powernv_idle_driver = {
@@ -167,6 +171,24 @@ static int powernv_cpuidle_driver_init(void)
 	return 0;
 }
 
+static inline void add_powernv_state(int index, const char *name,
+				     unsigned int flags,
+				     int (*idle_fn)(struct cpuidle_device *,
+						    struct cpuidle_driver *,
+						    int),
+				     unsigned int target_residency,
+				     unsigned int exit_latency,
+				     u64 psscr_val)
+{
+	strlcpy(powernv_states[index].name, name, CPUIDLE_NAME_LEN);
+	strlcpy(powernv_states[index].desc, name, CPUIDLE_NAME_LEN);
+	powernv_states[index].flags = flags;
+	powernv_states[index].target_residency = target_residency;
+	powernv_states[index].exit_latency = exit_latency;
+	powernv_states[index].enter = idle_fn;
+	stop_psscr_table[index] = psscr_val;
+}
+
 static int powernv_add_idle_states(void)
 {
 	struct device_node *power_mgt;
@@ -236,6 +258,7 @@ static int powernv_add_idle_states(void)
 		"ibm,cpu-idle-state-residency-ns", residency_ns, dt_idle_states);
 
 	for (i = 0; i < dt_idle_states; i++) {
+		unsigned int exit_latency, target_residency;
 		/*
 		 * If an idle state has exit latency beyond
 		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
@@ -243,28 +266,33 @@ static int powernv_add_idle_states(void)
 		 */
 		if (latency_ns[i] > POWERNV_THRESHOLD_LATENCY_NS)
 			continue;
+		/*
+		 * Firmware passes residency and latency values in ns.
+		 * cpuidle expects it in us.
+		 */
+		exit_latency = latency_ns[i] / 1000;
+		if (!rc)
+			target_residency = residency_ns[i] / 1000;
+		else
+			target_residency = 0;
 
 		/*
-		 * Cpuidle accepts exit_latency and target_residency in us.
-		 * Use default target_residency values if f/w does not expose it.
+		 * For nap and fastsleep, use default target_residency
+		 * values if f/w does not expose it.
 		 */
 		if (flags[i] & OPAL_PM_NAP_ENABLED) {
+			if (!rc)
+				target_residency = 100;
 			/* Add NAP state */
-			strcpy(powernv_states[nr_idle_states].name, "Nap");
-			strcpy(powernv_states[nr_idle_states].desc, "Nap");
-			powernv_states[nr_idle_states].flags = 0;
-			powernv_states[nr_idle_states].target_residency = 100;
-			powernv_states[nr_idle_states].enter = nap_loop;
+			add_powernv_state(nr_idle_states, "Nap",
+					  CPUIDLE_FLAG_NONE, nap_loop,
+					  target_residency, exit_latency, 0);
 		} else if ((flags[i] & OPAL_PM_STOP_INST_FAST) &&
 				!(flags[i] & OPAL_PM_TIMEBASE_STOP)) {
-			strncpy(powernv_states[nr_idle_states].name,
-				names[i], CPUIDLE_NAME_LEN);
-			strncpy(powernv_states[nr_idle_states].desc,
-				names[i], CPUIDLE_NAME_LEN);
-			powernv_states[nr_idle_states].flags = 0;
-
-			powernv_states[nr_idle_states].enter = stop_loop;
-			stop_psscr_table[nr_idle_states] = psscr_val[i];
+			add_powernv_state(nr_idle_states, names[i],
+					  CPUIDLE_FLAG_NONE, stop_loop,
+					  target_residency, exit_latency,
+					  psscr_val[i]);
 		}
 
 		/*
@@ -274,32 +302,21 @@ static int powernv_add_idle_states(void)
 #ifdef CONFIG_TICK_ONESHOT
 		if (flags[i] & OPAL_PM_SLEEP_ENABLED ||
 			flags[i] & OPAL_PM_SLEEP_ENABLED_ER1) {
+			if (!rc)
+				target_residency = 300000;
 			/* Add FASTSLEEP state */
-			strcpy(powernv_states[nr_idle_states].name, "FastSleep");
-			strcpy(powernv_states[nr_idle_states].desc, "FastSleep");
-			powernv_states[nr_idle_states].flags = CPUIDLE_FLAG_TIMER_STOP;
-			powernv_states[nr_idle_states].target_residency = 300000;
-			powernv_states[nr_idle_states].enter = fastsleep_loop;
+			add_powernv_state(nr_idle_states, "FastSleep",
+					  CPUIDLE_FLAG_TIMER_STOP,
+					  fastsleep_loop,
+					  target_residency, exit_latency, 0);
 		} else if ((flags[i] & OPAL_PM_STOP_INST_DEEP) &&
 				(flags[i] & OPAL_PM_TIMEBASE_STOP)) {
-			strncpy(powernv_states[nr_idle_states].name,
-				names[i], CPUIDLE_NAME_LEN);
-			strncpy(powernv_states[nr_idle_states].desc,
-				names[i], CPUIDLE_NAME_LEN);
-
-			powernv_states[nr_idle_states].flags = CPUIDLE_FLAG_TIMER_STOP;
-			powernv_states[nr_idle_states].enter = stop_loop;
-			stop_psscr_table[nr_idle_states] = psscr_val[i];
+			add_powernv_state(nr_idle_states, names[i],
+					  CPUIDLE_FLAG_TIMER_STOP, stop_loop,
+					  target_residency, exit_latency,
+					  psscr_val[i]);
 		}
 #endif
-		powernv_states[nr_idle_states].exit_latency =
-				((unsigned int)latency_ns[i]) / 1000;
-
-		if (!rc) {
-			powernv_states[nr_idle_states].target_residency =
-				((unsigned int)residency_ns[i]) / 1000;
-		}
-
 		nr_idle_states++;
 	}
 out:
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index da346f2..fc1e5d7 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -62,6 +62,7 @@ struct cpuidle_state {
 };
 
 /* Idle State Flags */
+#define CPUIDLE_FLAG_NONE       (0x00)
 #define CPUIDLE_FLAG_COUPLED	(0x02) /* state applies to multiple cpus */
 #define CPUIDLE_FLAG_TIMER_STOP (0x04)  /* timer is stopped on this state */
 
-- 
1.9.4
