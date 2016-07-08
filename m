Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rm4Bw05JQzDr6h
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Jul 2016 16:21:43 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u686A2Ec079035
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 8 Jul 2016 02:21:42 -0400
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2415xkrtf6-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 08 Jul 2016 02:21:42 -0400
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Fri, 8 Jul 2016 00:21:41 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@au1.ibm.com, paulus@ozlabs.org, mikey@neuling.org,
 ego@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, maddy@linux.vnet.ibm.com,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v8 09/11] cpuidle/powernv: cleanup cpuidle-powernv.c
Date: Fri,  8 Jul 2016 11:50:51 +0530
In-Reply-To: <1467958853-35841-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1467958853-35841-1-git-send-email-shreyas@linux.vnet.ibm.com>
Message-Id: <1467958853-35841-10-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

 - Use stack instead of kzalloc'ed memory for variables while probing
   device tree for idle states.
 - Set cap for number of idle states that can be added to
   cpuidle_state_table
 - Minor change in way we check of_property_read_u32_array for error
   for sake of consistency
 - Drop unnecessary "&" while assigning function pointer

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
Changes in v8
=============
 - &snooze_loop -> snooze_loop

Changes in v7
=============
 - New in v7. This was mainly to make the existing code
   consistent with the review comments for new code

 drivers/cpuidle/cpuidle-powernv.c | 38 ++++++++++++++++++++------------------
 1 file changed, 20 insertions(+), 18 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 3a763a8..600bbe1 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -100,7 +100,7 @@ static struct cpuidle_state powernv_states[CPUIDLE_STATE_MAX] = {
 		.desc = "snooze",
 		.exit_latency = 0,
 		.target_residency = 0,
-		.enter = &snooze_loop },
+		.enter = snooze_loop },
 };
 
 static int powernv_cpuidle_add_cpu_notifier(struct notifier_block *n,
@@ -166,7 +166,9 @@ static int powernv_add_idle_states(void)
 	struct device_node *power_mgt;
 	int nr_idle_states = 1; /* Snooze */
 	int dt_idle_states;
-	u32 *latency_ns, *residency_ns, *flags;
+	u32 latency_ns[CPUIDLE_STATE_MAX];
+	u32 residency_ns[CPUIDLE_STATE_MAX];
+	u32 flags[CPUIDLE_STATE_MAX];
 	int i, rc;
 
 	/* Currently we have snooze statically defined */
@@ -184,22 +186,28 @@ static int powernv_add_idle_states(void)
 		goto out;
 	}
 
-	flags = kzalloc(sizeof(*flags) * dt_idle_states, GFP_KERNEL);
+	/*
+	 * Since snooze is used as first idle state, max idle states allowed is
+	 * CPUIDLE_STATE_MAX -1
+	 */
+	if (dt_idle_states > CPUIDLE_STATE_MAX - 1) {
+		pr_warn("cpuidle-powernv: discovered idle states more than allowed");
+		dt_idle_states = CPUIDLE_STATE_MAX - 1;
+	}
+
 	if (of_property_read_u32_array(power_mgt,
 			"ibm,cpu-idle-state-flags", flags, dt_idle_states)) {
 		pr_warn("cpuidle-powernv : missing ibm,cpu-idle-state-flags in DT\n");
-		goto out_free_flags;
+		goto out;
 	}
 
-	latency_ns = kzalloc(sizeof(*latency_ns) * dt_idle_states, GFP_KERNEL);
-	rc = of_property_read_u32_array(power_mgt,
-		"ibm,cpu-idle-state-latencies-ns", latency_ns, dt_idle_states);
-	if (rc) {
+	if (of_property_read_u32_array(power_mgt,
+		"ibm,cpu-idle-state-latencies-ns", latency_ns,
+		dt_idle_states)) {
 		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-latencies-ns in DT\n");
-		goto out_free_latency;
+		goto out;
 	}
 
-	residency_ns = kzalloc(sizeof(*residency_ns) * dt_idle_states, GFP_KERNEL);
 	rc = of_property_read_u32_array(power_mgt,
 		"ibm,cpu-idle-state-residency-ns", residency_ns, dt_idle_states);
 
@@ -215,7 +223,7 @@ static int powernv_add_idle_states(void)
 			strcpy(powernv_states[nr_idle_states].desc, "Nap");
 			powernv_states[nr_idle_states].flags = 0;
 			powernv_states[nr_idle_states].target_residency = 100;
-			powernv_states[nr_idle_states].enter = &nap_loop;
+			powernv_states[nr_idle_states].enter = nap_loop;
 		}
 
 		/*
@@ -230,7 +238,7 @@ static int powernv_add_idle_states(void)
 			strcpy(powernv_states[nr_idle_states].desc, "FastSleep");
 			powernv_states[nr_idle_states].flags = CPUIDLE_FLAG_TIMER_STOP;
 			powernv_states[nr_idle_states].target_residency = 300000;
-			powernv_states[nr_idle_states].enter = &fastsleep_loop;
+			powernv_states[nr_idle_states].enter = fastsleep_loop;
 		}
 #endif
 		powernv_states[nr_idle_states].exit_latency =
@@ -243,12 +251,6 @@ static int powernv_add_idle_states(void)
 
 		nr_idle_states++;
 	}
-
-	kfree(residency_ns);
-out_free_latency:
-	kfree(latency_ns);
-out_free_flags:
-	kfree(flags);
 out:
 	return nr_idle_states;
 }
-- 
2.4.11
