Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 418wrM2H1LzF0nB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 15:05:07 +1000 (AEST)
Received: from pps.filterd (m0098404.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w5J542ua106168
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 01:05:05 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jpre7dskf-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Jun 2018 01:05:04 -0400
Received: from localhost
 by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Tue, 19 Jun 2018 06:05:02 +0100
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com,
 npiggin@gmail.com, mpe@ellerman.id.au,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH 3/3] powernv/cpuidle: Use parsed device tree values for
 cpuidle_init
Date: Tue, 19 Jun 2018 10:34:28 +0530
In-Reply-To: <1529384668-27548-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1529384668-27548-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Message-Id: <1529384668-27548-4-git-send-email-akshay.adiga@linux.vnet.ibm.com>
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
---
 arch/powerpc/include/asm/cpuidle.h |  2 ++
 drivers/cpuidle/cpuidle-powernv.c  | 49 +++++++++++++++++++++++---------------
 2 files changed, 32 insertions(+), 19 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index 55ee7e3..1446747 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -93,6 +93,8 @@ struct pnv_idle_states_t {
 	u32 flags;
 };
 
+extern struct pnv_idle_states_t *pnv_idle_states;
+extern int nr_pnv_idle_states;
 extern u32 pnv_fastsleep_workaround_at_entry[];
 extern u32 pnv_fastsleep_workaround_at_exit[];
 
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index d29e4f0..de8ba26 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -285,6 +285,11 @@ static int powernv_add_idle_states(void)
 		goto out;
 	}
 
+	if (nr_pnv_idle_states <= 0) {
+		pr_warn("opal: No idle states found\n");
+		goto out;
+	}
+
 	/* Read values of any property to determine the num of idle states */
 	dt_idle_states = of_property_count_u32_elems(power_mgt, "ibm,cpu-idle-state-flags");
 	if (dt_idle_states < 0) {
@@ -338,7 +343,7 @@ static int powernv_add_idle_states(void)
 	 * If the idle states use stop instruction, probe for psscr values
 	 * and psscr mask which are necessary to specify required stop level.
 	 */
-	has_stop_states = (flags[0] &
+	has_stop_states = (pnv_idle_states[0].flags &
 			   (OPAL_PM_STOP_INST_FAST | OPAL_PM_STOP_INST_DEEP));
 	if (has_stop_states) {
 		count = of_property_count_u64_elems(power_mgt,
@@ -387,51 +392,55 @@ static int powernv_add_idle_states(void)
 						residency_ns, dt_idle_states);
 	}
 
-	for (i = 0; i < dt_idle_states; i++) {
+	for (i = 0; i < nr_pnv_idle_states; i++) {
 		unsigned int exit_latency, target_residency;
 		bool stops_timebase = false;
+		struct pnv_idle_states_t *state = &pnv_idle_states[i];
 
 		/*
 		 * Skip the platform idle state whose flag isn't in
-		 * the supported_cpuidle_states flag mask.
+		 * the supported_pnv_idle_states flag mask.
 		 */
-		if ((flags[i] & supported_flags) != flags[i])
+		if ((state->flags & supported_flags) !=
+				state->flags)
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
+		exit_latency = DIV_ROUND_UP(state->latency_ns, 1000);
 		if (!rc)
-			target_residency = DIV_ROUND_UP(residency_ns[i], 1000);
+			target_residency = DIV_ROUND_UP(state->residency_ns, 1000);
 		else
 			target_residency = 0;
 
 		if (has_stop_states) {
-			int err = validate_psscr_val_mask(&psscr_val[i],
-							  &psscr_mask[i],
-							  flags[i]);
+			int err;
+			err = validate_psscr_val_mask(&state->pm_ctrl_reg_val,
+						      &state->pm_ctrl_reg_mask,
+						      state->flags);
 			if (err) {
-				report_invalid_psscr_val(psscr_val[i], err);
+				report_invalid_psscr_val(state->pm_ctrl_reg_val,
+							 err);
 				continue;
 			}
 		}
 
-		if (flags[i] & OPAL_PM_TIMEBASE_STOP)
+		if (state->flags & OPAL_PM_TIMEBASE_STOP)
 			stops_timebase = true;
 
 		/*
 		 * For nap and fastsleep, use default target_residency
 		 * values if f/w does not expose it.
 		 */
-		if (flags[i] & OPAL_PM_NAP_ENABLED) {
+		if (state->flags & OPAL_PM_NAP_ENABLED) {
 			if (!rc)
 				target_residency = 100;
 			/* Add NAP state */
@@ -439,10 +448,11 @@ static int powernv_add_idle_states(void)
 					  CPUIDLE_FLAG_NONE, nap_loop,
 					  target_residency, exit_latency, 0, 0);
 		} else if (has_stop_states && !stops_timebase) {
-			add_powernv_state(nr_idle_states, names[i],
+			add_powernv_state(nr_idle_states, state->name,
 					  CPUIDLE_FLAG_NONE, stop_loop,
 					  target_residency, exit_latency,
-					  psscr_val[i], psscr_mask[i]);
+					  state->pm_ctrl_reg_val,
+					  state->pm_ctrl_reg_mask);
 		}
 
 		/*
@@ -450,8 +460,8 @@ static int powernv_add_idle_states(void)
 		 * within this config dependency check.
 		 */
 #ifdef CONFIG_TICK_ONESHOT
-		else if (flags[i] & OPAL_PM_SLEEP_ENABLED ||
-			 flags[i] & OPAL_PM_SLEEP_ENABLED_ER1) {
+		else if (state->flags & OPAL_PM_SLEEP_ENABLED ||
+			 state->flags & OPAL_PM_SLEEP_ENABLED_ER1) {
 			if (!rc)
 				target_residency = 300000;
 			/* Add FASTSLEEP state */
@@ -460,10 +470,11 @@ static int powernv_add_idle_states(void)
 					  fastsleep_loop,
 					  target_residency, exit_latency, 0, 0);
 		} else if (has_stop_states && stops_timebase) {
-			add_powernv_state(nr_idle_states, names[i],
+			add_powernv_state(nr_idle_states, state->name,
 					  CPUIDLE_FLAG_TIMER_STOP, stop_loop,
 					  target_residency, exit_latency,
-					  psscr_val[i], psscr_mask[i]);
+					  state->pm_ctrl_reg_val,
+					  state->pm_ctrl_reg_mask);
 		}
 #endif
 		else
-- 
2.5.5
