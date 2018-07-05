Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41Lwsl6hb7zF1g3
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Jul 2018 21:40:59 +1000 (AEST)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w65Bd38f013008
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 5 Jul 2018 07:40:57 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2k1gw64b8w-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Jul 2018 07:40:57 -0400
Received: from localhost
 by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Thu, 5 Jul 2018 12:40:55 +0100
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, stewart@linux.vnet.ibm.com, benh@kernel.crashing.org,
 svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, npiggin@gmail.com,
 mpe@ellerman.id.au, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH v4 2/2] powernv/cpuidle: Use parsed device tree values for
 cpuidle_init
Date: Thu,  5 Jul 2018 17:10:22 +0530
In-Reply-To: <20180705114022.19285-1-akshay.adiga@linux.vnet.ibm.com>
References: <20180705114022.19285-1-akshay.adiga@linux.vnet.ibm.com>
Message-Id: <20180705114022.19285-3-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Export pnv_idle_states and nr_pnv_idle_states so that its accessible to
cpuidle driver. Use properties from pnv_idle_states structure for powernv
cpuidle_init.

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cpuidle.h |   2 +
 drivers/cpuidle/cpuidle-powernv.c  | 158 +++++------------------------
 2 files changed, 28 insertions(+), 132 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index 574b0ce1d671..43e5f31fe64d 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -90,6 +90,8 @@ struct pnv_idle_states_t {
 	bool valid;
 };
 
+extern struct pnv_idle_states_t *pnv_idle_states;
+extern int nr_pnv_idle_states;
 extern u32 pnv_fastsleep_workaround_at_entry[];
 extern u32 pnv_fastsleep_workaround_at_exit[];
 
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index d29e4f041efe..84b1ebe212b3 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -242,6 +242,7 @@ static inline void add_powernv_state(int index, const char *name,
 	powernv_states[index].target_residency = target_residency;
 	powernv_states[index].exit_latency = exit_latency;
 	powernv_states[index].enter = idle_fn;
+	/* For power8 and below psscr_* will be 0 */
 	stop_psscr_table[index].val = psscr_val;
 	stop_psscr_table[index].mask = psscr_mask;
 }
@@ -263,186 +264,80 @@ static inline int validate_dt_prop_sizes(const char *prop1, int prop1_len,
 extern u32 pnv_get_supported_cpuidle_states(void);
 static int powernv_add_idle_states(void)
 {
-	struct device_node *power_mgt;
 	int nr_idle_states = 1; /* Snooze */
-	int dt_idle_states, count;
-	u32 latency_ns[CPUIDLE_STATE_MAX];
-	u32 residency_ns[CPUIDLE_STATE_MAX];
-	u32 flags[CPUIDLE_STATE_MAX];
-	u64 psscr_val[CPUIDLE_STATE_MAX];
-	u64 psscr_mask[CPUIDLE_STATE_MAX];
-	const char *names[CPUIDLE_STATE_MAX];
+	int dt_idle_states;
 	u32 has_stop_states = 0;
-	int i, rc;
+	int i;
 	u32 supported_flags = pnv_get_supported_cpuidle_states();
 
 
 	/* Currently we have snooze statically defined */
-
-	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
-	if (!power_mgt) {
-		pr_warn("opal: PowerMgmt Node not found\n");
-		goto out;
-	}
-
-	/* Read values of any property to determine the num of idle states */
-	dt_idle_states = of_property_count_u32_elems(power_mgt, "ibm,cpu-idle-state-flags");
-	if (dt_idle_states < 0) {
-		pr_warn("cpuidle-powernv: no idle states found in the DT\n");
+	if (nr_pnv_idle_states <= 0) {
+		pr_warn("cpuidle-powernv : Only Snooze is available\n");
 		goto out;
 	}
 
-	count = of_property_count_u32_elems(power_mgt,
-					    "ibm,cpu-idle-state-latencies-ns");
-
-	if (validate_dt_prop_sizes("ibm,cpu-idle-state-flags", dt_idle_states,
-				   "ibm,cpu-idle-state-latencies-ns",
-				   count) != 0)
-		goto out;
-
-	count = of_property_count_strings(power_mgt,
-					  "ibm,cpu-idle-state-names");
-	if (validate_dt_prop_sizes("ibm,cpu-idle-state-flags", dt_idle_states,
-				   "ibm,cpu-idle-state-names",
-				   count) != 0)
-		goto out;
+	/* TODO: Count only states which are eligible for cpuidle */
+	dt_idle_states = nr_pnv_idle_states;
 
 	/*
 	 * Since snooze is used as first idle state, max idle states allowed is
 	 * CPUIDLE_STATE_MAX -1
 	 */
-	if (dt_idle_states > CPUIDLE_STATE_MAX - 1) {
+	if (nr_pnv_idle_states > CPUIDLE_STATE_MAX - 1) {
 		pr_warn("cpuidle-powernv: discovered idle states more than allowed");
 		dt_idle_states = CPUIDLE_STATE_MAX - 1;
 	}
 
-	if (of_property_read_u32_array(power_mgt,
-			"ibm,cpu-idle-state-flags", flags, dt_idle_states)) {
-		pr_warn("cpuidle-powernv : missing ibm,cpu-idle-state-flags in DT\n");
-		goto out;
-	}
-
-	if (of_property_read_u32_array(power_mgt,
-		"ibm,cpu-idle-state-latencies-ns", latency_ns,
-		dt_idle_states)) {
-		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-latencies-ns in DT\n");
-		goto out;
-	}
-	if (of_property_read_string_array(power_mgt,
-		"ibm,cpu-idle-state-names", names, dt_idle_states) < 0) {
-		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-names in DT\n");
-		goto out;
-	}
-
 	/*
 	 * If the idle states use stop instruction, probe for psscr values
 	 * and psscr mask which are necessary to specify required stop level.
 	 */
-	has_stop_states = (flags[0] &
+	has_stop_states = (pnv_idle_states[0].flags &
 			   (OPAL_PM_STOP_INST_FAST | OPAL_PM_STOP_INST_DEEP));
-	if (has_stop_states) {
-		count = of_property_count_u64_elems(power_mgt,
-						    "ibm,cpu-idle-state-psscr");
-		if (validate_dt_prop_sizes("ibm,cpu-idle-state-flags",
-					   dt_idle_states,
-					   "ibm,cpu-idle-state-psscr",
-					   count) != 0)
-			goto out;
-
-		count = of_property_count_u64_elems(power_mgt,
-						    "ibm,cpu-idle-state-psscr-mask");
-		if (validate_dt_prop_sizes("ibm,cpu-idle-state-flags",
-					   dt_idle_states,
-					   "ibm,cpu-idle-state-psscr-mask",
-					   count) != 0)
-			goto out;
-
-		if (of_property_read_u64_array(power_mgt,
-		    "ibm,cpu-idle-state-psscr", psscr_val, dt_idle_states)) {
-			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr in DT\n");
-			goto out;
-		}
-
-		if (of_property_read_u64_array(power_mgt,
-					       "ibm,cpu-idle-state-psscr-mask",
-						psscr_mask, dt_idle_states)) {
-			pr_warn("cpuidle-powernv:Missing ibm,cpu-idle-state-psscr-mask in DT\n");
-			goto out;
-		}
-	}
-
-	count = of_property_count_u32_elems(power_mgt,
-					    "ibm,cpu-idle-state-residency-ns");
-
-	if (count < 0) {
-		rc = count;
-	} else if (validate_dt_prop_sizes("ibm,cpu-idle-state-flags",
-					  dt_idle_states,
-					  "ibm,cpu-idle-state-residency-ns",
-					  count) != 0) {
-		goto out;
-	} else {
-		rc = of_property_read_u32_array(power_mgt,
-						"ibm,cpu-idle-state-residency-ns",
-						residency_ns, dt_idle_states);
-	}
 
 	for (i = 0; i < dt_idle_states; i++) {
 		unsigned int exit_latency, target_residency;
 		bool stops_timebase = false;
+		struct pnv_idle_states_t *state = &pnv_idle_states[i];
 
 		/*
 		 * Skip the platform idle state whose flag isn't in
 		 * the supported_cpuidle_states flag mask.
 		 */
-		if ((flags[i] & supported_flags) != flags[i])
+		if ((state->flags & supported_flags) != state->flags)
 			continue;
 		/*
 		 * If an idle state has exit latency beyond
 		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
 		 * in cpu-idle.
 		 */
-		if (latency_ns[i] > POWERNV_THRESHOLD_LATENCY_NS)
+		if (state->latency_ns > POWERNV_THRESHOLD_LATENCY_NS)
 			continue;
 		/*
 		 * Firmware passes residency and latency values in ns.
 		 * cpuidle expects it in us.
 		 */
-		exit_latency = DIV_ROUND_UP(latency_ns[i], 1000);
-		if (!rc)
-			target_residency = DIV_ROUND_UP(residency_ns[i], 1000);
-		else
-			target_residency = 0;
-
-		if (has_stop_states) {
-			int err = validate_psscr_val_mask(&psscr_val[i],
-							  &psscr_mask[i],
-							  flags[i]);
-			if (err) {
-				report_invalid_psscr_val(psscr_val[i], err);
+		exit_latency = DIV_ROUND_UP(state->latency_ns, 1000);
+		target_residency = DIV_ROUND_UP(state->residency_ns, 1000);
+
+		if (has_stop_states && !(state->valid))
 				continue;
-			}
-		}
 
-		if (flags[i] & OPAL_PM_TIMEBASE_STOP)
+		if (state->flags & OPAL_PM_TIMEBASE_STOP)
 			stops_timebase = true;
 
-		/*
-		 * For nap and fastsleep, use default target_residency
-		 * values if f/w does not expose it.
-		 */
-		if (flags[i] & OPAL_PM_NAP_ENABLED) {
-			if (!rc)
-				target_residency = 100;
+		if (state->flags & OPAL_PM_NAP_ENABLED) {
 			/* Add NAP state */
 			add_powernv_state(nr_idle_states, "Nap",
 					  CPUIDLE_FLAG_NONE, nap_loop,
 					  target_residency, exit_latency, 0, 0);
 		} else if (has_stop_states && !stops_timebase) {
-			add_powernv_state(nr_idle_states, names[i],
+			add_powernv_state(nr_idle_states, state->name,
 					  CPUIDLE_FLAG_NONE, stop_loop,
 					  target_residency, exit_latency,
-					  psscr_val[i], psscr_mask[i]);
+					  state->psscr_val,
+					  state->psscr_mask);
 		}
 
 		/*
@@ -450,20 +345,19 @@ static int powernv_add_idle_states(void)
 		 * within this config dependency check.
 		 */
 #ifdef CONFIG_TICK_ONESHOT
-		else if (flags[i] & OPAL_PM_SLEEP_ENABLED ||
-			 flags[i] & OPAL_PM_SLEEP_ENABLED_ER1) {
-			if (!rc)
-				target_residency = 300000;
+		else if (state->flags & OPAL_PM_SLEEP_ENABLED ||
+			 state->flags & OPAL_PM_SLEEP_ENABLED_ER1) {
 			/* Add FASTSLEEP state */
 			add_powernv_state(nr_idle_states, "FastSleep",
 					  CPUIDLE_FLAG_TIMER_STOP,
 					  fastsleep_loop,
 					  target_residency, exit_latency, 0, 0);
 		} else if (has_stop_states && stops_timebase) {
-			add_powernv_state(nr_idle_states, names[i],
+			add_powernv_state(nr_idle_states, state->name,
 					  CPUIDLE_FLAG_TIMER_STOP, stop_loop,
 					  target_residency, exit_latency,
-					  psscr_val[i], psscr_mask[i]);
+					  state->psscr_val,
+					  state->psscr_mask);
 		}
 #endif
 		else
-- 
2.18.0.rc2.85.g1fb9df7
