Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xNybg1RstzDqG5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Aug 2017 17:04:46 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v7473nDs066697
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 4 Aug 2017 03:04:43 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c4ckgch06-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 04 Aug 2017 03:04:43 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 4 Aug 2017 01:04:42 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH] powernv:idle: Disable LOSE_FULL_CONTEXT states when stop-api
 fails.
Date: Fri,  4 Aug 2017 12:34:22 +0530
Message-Id: <1501830262-32399-1-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Currently, we use the opal call opal_slw_set_reg() to inform the
Sleep-Winkle Engine (SLW) to restore the contents of some of the
Hypervisor state on wakeup from deep idle states that lose full
hypervisor context (characterized by the flag
OPAL_PM_LOSE_FULL_CONTEXT).

However, the current code has a bug in that if opal_slw_set_reg()
fails, we don't disable the use of these deep states (winkle on
POWER8, stop4 onwards on POWER9).

This patch fixes this bug by ensuring that if programing the
sleep-winkle engine to restore the hypervisor states in
pnv_save_sprs_for_deep_states() fails, then we exclude such states by
excluding their flags supported_cpuidle_states. Further, we ensure in
the initialization of the cpuidle-powernv driver to only include those
states whose flags are present in supported_cpuidle_states.

Fixes: 1e1601b38e6 ("powerpc/powernv/idle: Restore SPRs for deep idle
states via stop API.")

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 126 +++++++++++++++++++++++++++-------
 drivers/cpuidle/cpuidle-powernv.c     |   9 +++
 2 files changed, 110 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 2abee07..5f4c206 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -184,9 +184,6 @@ static void pnv_alloc_idle_core_states(void)
 	}
 
 	update_subcore_sibling_mask();
-
-	if (supported_cpuidle_states & OPAL_PM_LOSE_FULL_CONTEXT)
-		pnv_save_sprs_for_deep_states();
 }
 
 u32 pnv_get_supported_cpuidle_states(void)
@@ -467,8 +464,39 @@ int validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags)
 	return err;
 }
 
+static void __init pnv_power8_idle_init(struct device_node *np, u32 *flags,
+					int dt_idle_states)
+{
+	bool disable_full_context_loss = false;
+	bool sprs_for_lose_full_context_saved = false;
+
+	int rc = 0, i;
+
+	for (i = 0; i < dt_idle_states; i++) {
+		if (flags[i] & OPAL_PM_LOSE_FULL_CONTEXT) {
+			if (sprs_for_lose_full_context_saved)
+				goto add_flags;
+
+			if (disable_full_context_loss)
+				continue;
+
+			rc = pnv_save_sprs_for_deep_states();
+
+			if (unlikely(rc)) {
+				pr_warn("cpuidle-powernv: Disabling full context loss idle states.\n");
+				pr_warn("cpuidle-powernv: Offlined CPUs will be put to shallow idle state.\n");
+				disable_full_context_loss = true;
+				continue;
+			}
+
+			sprs_for_lose_full_context_saved = true;
+		}
+add_flags:
+		supported_cpuidle_states |= flags[i];
+	}
+}
 /*
- * pnv_arch300_idle_init: Initializes the default idle state, first
+ * pnv_power9_idle_init: Initializes the default idle state, first
  *                        deep idle state and deepest idle state on
  *                        ISA 3.0 CPUs.
  *
@@ -485,6 +513,9 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 	u32 *residency_ns = NULL;
 	u64 max_residency_ns = 0;
 	int rc = 0, i;
+	bool save_sprs_for_full_context_loss = false;
+	bool disable_full_context_loss = false;
+	unsigned long invalid_states_mask = 0;
 
 	psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val), GFP_KERNEL);
 	psscr_mask = kcalloc(dt_idle_states, sizeof(*psscr_mask), GFP_KERNEL);
@@ -521,35 +552,83 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 	}
 
 	/*
+	 * States that have OPAL_PM_LOSE_FULL_CONTEXT flag set require
+	 * the assistance of the slw engine to restore certain SPRs on
+	 * wakeup from these states. The function to program the slw
+	 * engine via stop-api expects pnv_deep_stop_psscr_val to be
+	 * set before it is called.
+	 *
+	 * Hence, we first set the pnv_deepest_stop_psscr_{val,mask}
+	 * to the value corresponding to deepest state.
+	 */
+	for (i = 0; i < dt_idle_states; i++) {
+		int err;
+
+		err = validate_psscr_val_mask(&psscr_val[i], &psscr_mask[i],
+					      flags[i]);
+		if (err) {
+			report_invalid_psscr_val(psscr_val[i], err);
+			set_bit(i, &invalid_states_mask);
+			continue;
+		}
+
+		if (flags[i] & OPAL_PM_LOSE_FULL_CONTEXT)
+			save_sprs_for_full_context_loss = true;
+
+		if (max_residency_ns < residency_ns[i]) {
+			max_residency_ns = residency_ns[i];
+			pnv_deepest_stop_psscr_val = psscr_val[i];
+			pnv_deepest_stop_psscr_mask = psscr_mask[i];
+			deepest_stop_found = true;
+		}
+	}
+
+	/*
+	 * Program the SLW via stop-api to restore some of the SPRs
+	 * after wakeup from a LOSE_FULL_CONTEXT idle state.
+	 */
+	if (save_sprs_for_full_context_loss) {
+		int rc;
+
+		rc = pnv_save_sprs_for_deep_states();
+		if (unlikely(rc)) {
+			pr_warn("cpuidle-powernv: Disabling full context loss idle states.\n");
+			pr_warn("cpuidle-powernv: Idle powersavings impacted.\n");
+			disable_full_context_loss = true;
+			max_residency_ns = 0;
+			deepest_stop_found = false;
+		}
+	}
+
+	/*
 	 * Set pnv_first_deep_stop_state, pnv_deepest_stop_psscr_{val,mask},
 	 * and the pnv_default_stop_{val,mask}.
 	 *
 	 * pnv_first_deep_stop_state should be set to the first stop
 	 * level to cause hypervisor state loss.
 	 *
-	 * pnv_deepest_stop_{val,mask} should be set to values corresponding to
-	 * the deepest stop state.
+	 * If the stop-api failed above, then pnv_deepest_stop_{val,mask}
+	 * should be set to values corresponding to the deepest stop
+	 * state that doesn't have OPAL_PM_LOSE_FULL_CONTEXT set.
 	 *
 	 * pnv_default_stop_{val,mask} should be set to values corresponding to
 	 * the shallowest (OPAL_PM_STOP_INST_FAST) loss-less stop state.
 	 */
 	pnv_first_deep_stop_state = MAX_STOP_STATE;
 	for (i = 0; i < dt_idle_states; i++) {
-		int err;
 		u64 psscr_rl = psscr_val[i] & PSSCR_RL_MASK;
 
-		if ((flags[i] & OPAL_PM_LOSE_FULL_CONTEXT) &&
-		     (pnv_first_deep_stop_state > psscr_rl))
-			pnv_first_deep_stop_state = psscr_rl;
-
-		err = validate_psscr_val_mask(&psscr_val[i], &psscr_mask[i],
-					      flags[i]);
-		if (err) {
-			report_invalid_psscr_val(psscr_val[i], err);
+		if (test_bit(i, &invalid_states_mask))
 			continue;
+
+		if (flags[i] & OPAL_PM_LOSE_FULL_CONTEXT) {
+			if (disable_full_context_loss)
+				continue;
+			else if (pnv_first_deep_stop_state > psscr_rl)
+				pnv_first_deep_stop_state = psscr_rl;
 		}
 
-		if (max_residency_ns < residency_ns[i]) {
+		if (unlikely(max_residency_ns < residency_ns[i])) {
 			max_residency_ns = residency_ns[i];
 			pnv_deepest_stop_psscr_val = psscr_val[i];
 			pnv_deepest_stop_psscr_mask = psscr_mask[i];
@@ -562,6 +641,8 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 			pnv_default_stop_mask = psscr_mask[i];
 			default_stop_found = true;
 		}
+
+		supported_cpuidle_states |= flags[i];
 	}
 
 	if (unlikely(!default_stop_found)) {
@@ -597,7 +678,6 @@ static void __init pnv_probe_idle_states(void)
 	struct device_node *np;
 	int dt_idle_states;
 	u32 *flags = NULL;
-	int i;
 
 	np = of_find_node_by_path("/ibm,opal/power-mgt");
 	if (!np) {
@@ -619,14 +699,10 @@ static void __init pnv_probe_idle_states(void)
 		goto out;
 	}
 
-	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
-		if (pnv_power9_idle_init(np, flags, dt_idle_states))
-			goto out;
-	}
-
-	for (i = 0; i < dt_idle_states; i++)
-		supported_cpuidle_states |= flags[i];
-
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		pnv_power9_idle_init(np, flags, dt_idle_states);
+	else
+		pnv_power8_idle_init(np, flags, dt_idle_states);
 out:
 	kfree(flags);
 }
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 37b0698..1a5875e 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -235,6 +235,7 @@ static inline int validate_dt_prop_sizes(const char *prop1, int prop1_len,
 	return -1;
 }
 
+extern u32 pnv_get_supported_cpuidle_states(void);
 static int powernv_add_idle_states(void)
 {
 	struct device_node *power_mgt;
@@ -362,6 +363,14 @@ static int powernv_add_idle_states(void)
 	for (i = 0; i < dt_idle_states; i++) {
 		unsigned int exit_latency, target_residency;
 		bool stops_timebase = false;
+		u32 supported_flags = pnv_get_supported_cpuidle_states();
+
+		/*
+		 * If a certain deep state isn't marked in
+		 * supported_cpuidle_states, we skip it here.
+		 */
+		if ((flags[i] & supported_flags) != flags[i])
+			continue;
 		/*
 		 * If an idle state has exit latency beyond
 		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
-- 
1.8.3.1
