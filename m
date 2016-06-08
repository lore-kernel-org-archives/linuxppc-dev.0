Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPvgn47YQzDqR7
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 02:55:17 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58GsUeJ142362
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 12:55:15 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23e9m3wysh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 12:55:15 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 10:55:13 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@au1.ibm.com, paulus@ozlabs.org, mikey@neuling.org,
 ego@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Rob Herring <robh+dt@kernel.org>,
 Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>, linux-pm@vger.kernel.org
Subject: [PATCH v6 10/11] cpuidle/powernv: Add support for POWER ISA v3 idle
 states
Date: Wed,  8 Jun 2016 11:54:30 -0500
In-Reply-To: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
Message-Id: <1465404871-5406-11-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

POWER ISA v3 defines a new idle processor core mechanism. In summary,
 a) new instruction named stop is added.
 b) new per thread SPR named PSSCR is added which controls the behavior
	of stop instruction.

Supported idle states and value to be written to PSSCR register to enter
any idle state is exposed via ibm,cpu-idle-state-names and
ibm,cpu-idle-state-psscr respectively. To enter an idle state,
platform provided power_stop() needs to be invoked with the appropriate
PSSCR value.

This patch adds support for this new mechanism in cpuidle powernv driver.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Lorenzo Pieralisi <Lorenzo.Pieralisi@arm.com>
Cc: linux-pm@vger.kernel.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Cc: Paul Mackerras <paulus@ozlabs.org>
Cc: linuxppc-dev@lists.ozlabs.org
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
Note: Documentation for the device tree bindings is posted here-
http://patchwork.ozlabs.org/patch/629125/

 - No changes in v6

Changes in v5
=============
 - Use generic cpuidle constant CPUIDLE_NAME_LEN
 - Fix return code handling for of_property_read_string_array
 - Use DT flags to determine if are using stop instruction, instead of
   cpu_has_feature
 - Removed uncessary cast with names
 - &stop_loop -> stop_loop
 - Added POWERNV_THRESHOLD_LATENCY_NS to filter out idle states with high latency

 drivers/cpuidle/cpuidle-powernv.c | 71 ++++++++++++++++++++++++++++++++++++++-
 1 file changed, 70 insertions(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 3a763a8..c74a020 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -20,6 +20,8 @@
 #include <asm/opal.h>
 #include <asm/runlatch.h>
 
+#define POWERNV_THRESHOLD_LATENCY_NS 200000
+
 struct cpuidle_driver powernv_idle_driver = {
 	.name             = "powernv_idle",
 	.owner            = THIS_MODULE,
@@ -27,6 +29,9 @@ struct cpuidle_driver powernv_idle_driver = {
 
 static int max_idle_state;
 static struct cpuidle_state *cpuidle_state_table;
+
+static u64 stop_psscr_table[CPUIDLE_STATE_MAX];
+
 static u64 snooze_timeout;
 static bool snooze_timeout_en;
 
@@ -91,6 +96,17 @@ static int fastsleep_loop(struct cpuidle_device *dev,
 	return index;
 }
 #endif
+
+static int stop_loop(struct cpuidle_device *dev,
+		     struct cpuidle_driver *drv,
+		     int index)
+{
+	ppc64_runlatch_off();
+	power_stop(stop_psscr_table[index]);
+	ppc64_runlatch_on();
+	return index;
+}
+
 /*
  * States for dedicated partition case.
  */
@@ -167,6 +183,8 @@ static int powernv_add_idle_states(void)
 	int nr_idle_states = 1; /* Snooze */
 	int dt_idle_states;
 	u32 *latency_ns, *residency_ns, *flags;
+	u64 *psscr_val = NULL;
+	const char *names[CPUIDLE_STATE_MAX];
 	int i, rc;
 
 	/* Currently we have snooze statically defined */
@@ -199,12 +217,41 @@ static int powernv_add_idle_states(void)
 		goto out_free_latency;
 	}
 
+	rc = of_property_read_string_array(power_mgt,
+					   "ibm,cpu-idle-state-names", names,
+					   dt_idle_states);
+	if (rc < 0) {
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-names in DT\n");
+		goto out_free_latency;
+	}
+
+	/*
+	 * If the idle states use stop instruction, probe for psscr values
+	 * which are necessary to specify required stop level.
+	 */
+	if (flags[0] & (OPAL_PM_STOP_INST_FAST | OPAL_PM_STOP_INST_DEEP)) {
+		psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val),
+				    GFP_KERNEL);
+		rc = of_property_read_u64_array(power_mgt,
+						"ibm,cpu-idle-state-psscr",
+						psscr_val, dt_idle_states);
+		if (rc) {
+			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-states-psscr in DT\n");
+			goto out_free_psscr;
+		}
+	}
 	residency_ns = kzalloc(sizeof(*residency_ns) * dt_idle_states, GFP_KERNEL);
 	rc = of_property_read_u32_array(power_mgt,
 		"ibm,cpu-idle-state-residency-ns", residency_ns, dt_idle_states);
 
 	for (i = 0; i < dt_idle_states; i++) {
-
+		/*
+		 * If an idle state has exit latency beyond
+		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
+		 * in cpu-idle.
+		 */
+		if (latency_ns[i] > POWERNV_THRESHOLD_LATENCY_NS)
+			continue;
 		/*
 		 * Cpuidle accepts exit_latency and target_residency in us.
 		 * Use default target_residency values if f/w does not expose it.
@@ -216,6 +263,16 @@ static int powernv_add_idle_states(void)
 			powernv_states[nr_idle_states].flags = 0;
 			powernv_states[nr_idle_states].target_residency = 100;
 			powernv_states[nr_idle_states].enter = &nap_loop;
+		} else if ((flags[i] & OPAL_PM_STOP_INST_FAST) &&
+				!(flags[i] & OPAL_PM_TIMEBASE_STOP)) {
+			strncpy(powernv_states[nr_idle_states].name,
+				names[i], CPUIDLE_NAME_LEN);
+			strncpy(powernv_states[nr_idle_states].desc,
+				names[i], CPUIDLE_NAME_LEN);
+			powernv_states[nr_idle_states].flags = 0;
+
+			powernv_states[nr_idle_states].enter = stop_loop;
+			stop_psscr_table[nr_idle_states] = psscr_val[i];
 		}
 
 		/*
@@ -231,6 +288,16 @@ static int powernv_add_idle_states(void)
 			powernv_states[nr_idle_states].flags = CPUIDLE_FLAG_TIMER_STOP;
 			powernv_states[nr_idle_states].target_residency = 300000;
 			powernv_states[nr_idle_states].enter = &fastsleep_loop;
+		} else if ((flags[i] & OPAL_PM_STOP_INST_DEEP) &&
+				(flags[i] & OPAL_PM_TIMEBASE_STOP)) {
+			strncpy(powernv_states[nr_idle_states].name,
+				names[i], CPUIDLE_NAME_LEN);
+			strncpy(powernv_states[nr_idle_states].desc,
+				names[i], CPUIDLE_NAME_LEN);
+
+			powernv_states[nr_idle_states].flags = CPUIDLE_FLAG_TIMER_STOP;
+			powernv_states[nr_idle_states].enter = stop_loop;
+			stop_psscr_table[nr_idle_states] = psscr_val[i];
 		}
 #endif
 		powernv_states[nr_idle_states].exit_latency =
@@ -245,6 +312,8 @@ static int powernv_add_idle_states(void)
 	}
 
 	kfree(residency_ns);
+out_free_psscr:
+	kfree(psscr_val);
 out_free_latency:
 	kfree(latency_ns);
 out_free_flags:
-- 
2.1.4
