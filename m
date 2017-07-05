Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2mln6Z22zDr1w
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 02:38:45 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v65GccIE044300
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 12:38:43 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bgvqjuyxn-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 12:38:43 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 5 Jul 2017 10:38:41 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 5/5] powernv:idle: Disable LOSE_FULL_CONTEXT states when
 stop-api fails.
Date: Wed,  5 Jul 2017 22:08:16 +0530
In-Reply-To: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
Message-Id: <1499272696-28751-6-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

Currently, we use the opal call opal_slw_set_reg() to inform the that
the Sleep-Winkle Engine (SLW) to restore the contents of some of the
Hypervisor state on wakeup from deep idle states that lose full
hypervisor context (characterized by the flag
OPAL_PM_LOSE_FULL_CONTEXT).

However, the current code has a bug in that if opal_slw_set_reg()
fails, we don't disable the use of these deep states (winkle on
POWER8, stop4 onwards on POWER9).

This patch fixes this bug by ensuring that if the the sleep winkle
engine is unable to restore the hypervisor states in
pnv_save_sprs_for_deep_states(), then we mark as invalid the states
which lose full context.

As a side-effect, since supported_cpuidle_states in
pnv_probe_idle_states() consists of flags of only the valid states,
this patch will ensure that no other subsystem in the kernel can use
the states which lose full context on stop-api failures.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/powernv/idle.c | 98 +++++++++++++++++++++++++++++++----
 1 file changed, 87 insertions(+), 11 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 254a0db8..8d07ce6 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -217,9 +217,6 @@ static void pnv_alloc_idle_core_states(void)
 	}
 
 	update_subcore_sibling_mask();
-
-	if (supported_cpuidle_states & OPAL_PM_LOSE_FULL_CONTEXT)
-		pnv_save_sprs_for_deep_states();
 }
 
 u32 pnv_get_supported_cpuidle_states(void)
@@ -518,6 +515,57 @@ static void __init pnv_power9_idle_init(void)
 	u64 max_residency_ns = 0;
 	int i;
 	int dt_idle_states = pnv_idle.nr_states;
+	bool save_sprs_for_deep_stop = false;
+	bool disable_lose_full_context = false;
+	u64 psscr_rl, residency_ns, psscr_val, psscr_mask;
+	u32 flags;
+
+	/*
+	 * pnv_deepest_stop_{val,mask} should be set to values
+	 * corresponding to the deepest stop state.
+	 */
+	for (i = 0; i < dt_idle_states; i++) {
+		psscr_val = pnv_idle.states[i].ctrl_reg_val;
+		psscr_mask = pnv_idle.states[i].ctrl_reg_mask;
+		psscr_rl = psscr_val & PSSCR_RL_MASK;
+		flags = pnv_idle.states[i].flags;
+		residency_ns = pnv_idle.states[i].residency_ns;
+
+		if (flags & OPAL_PM_LOSE_FULL_CONTEXT)
+			save_sprs_for_deep_stop = true;
+
+		if (max_residency_ns < residency_ns) {
+			max_residency_ns = residency_ns;
+			pnv_deepest_stop_psscr_val = psscr_val;
+			pnv_deepest_stop_psscr_mask = psscr_mask;
+			deepest_stop_found = true;
+		}
+	}
+
+	/*
+	 * pnv_save_sprs_for_deep_states() expects
+	 * pnv_deepest_stop_psscr_val to be initialized.
+	 */
+	if (save_sprs_for_deep_stop) {
+		int rc;
+
+		rc = pnv_save_sprs_for_deep_states();
+
+		/*
+		 * If the Sleep-Winkle Engine is unable to restore the
+		 * critical SPRs on wakeup from some of the deep stop
+		 * states that lose full context, then we mark such
+		 * deep states as invalid and recompute the
+		 * pnv_deepest_stop_psscr_val/mask from among the
+		 * valid states.
+		 */
+		if (unlikely(rc)) {
+			pr_warn("cpuidle-powernv:Disabling full-context loss states.SLW unable to restore SPRs\n");
+			disable_lose_full_context = true;
+			max_residency_ns = 0;
+			deepest_stop_found = false;
+		}
+	}
 
 	/*
 	 * Set pnv_first_deep_stop_state, pnv_deepest_stop_psscr_{val,mask},
@@ -526,16 +574,20 @@ static void __init pnv_power9_idle_init(void)
 	 * pnv_first_deep_stop_state should be set to the first stop
 	 * level to cause hypervisor state loss.
 	 *
-	 * pnv_deepest_stop_{val,mask} should be set to values corresponding to
-	 * the deepest stop state.
 	 *
 	 * pnv_default_stop_{val,mask} should be set to values corresponding to
 	 * the shallowest (OPAL_PM_STOP_INST_FAST) loss-less stop state.
 	 */
 	pnv_first_deep_stop_state = MAX_STOP_STATE;
 	for (i = 0; i < dt_idle_states; i++) {
-		u64 psscr_rl, residency_ns, psscr_val, psscr_mask;
-		u32 flags;
+		flags = pnv_idle.states[i].flags;
+
+		if ((flags & OPAL_PM_LOSE_FULL_CONTEXT) &&
+			disable_lose_full_context) {
+			pnv_idle.states[i].valid = false;
+			pr_warn("cpuidle-powernv: Disabling full-context loss state :%s\n",
+				pnv_idle.states[i].name);
+		}
 
 		if (!pnv_idle.states[i].valid)
 			continue;
@@ -543,15 +595,14 @@ static void __init pnv_power9_idle_init(void)
 		psscr_val = pnv_idle.states[i].ctrl_reg_val;
 		psscr_mask = pnv_idle.states[i].ctrl_reg_mask;
 		psscr_rl = psscr_val & PSSCR_RL_MASK;
-		flags = pnv_idle.states[i].flags;
+
 		residency_ns = pnv_idle.states[i].residency_ns;
 
 		if ((flags & OPAL_PM_LOSE_FULL_CONTEXT) &&
-		    (pnv_first_deep_stop_state > psscr_rl)) {
+		    (pnv_first_deep_stop_state > psscr_rl))
 			pnv_first_deep_stop_state = psscr_rl;
-		}
 
-		if (max_residency_ns < residency_ns) {
+		if (unlikely(max_residency_ns < residency_ns)) {
 			max_residency_ns = residency_ns;
 			pnv_deepest_stop_psscr_val = psscr_val;
 			pnv_deepest_stop_psscr_mask = psscr_mask;
@@ -593,6 +644,8 @@ static void __init pnv_power8_idle_init(void)
 	bool has_nap = false;
 	bool has_sleep_er1 = false;
 	int dt_idle_states = pnv_idle.nr_states;
+	bool disable_full_context_loss = false;
+	bool sprs_for_deep_state_saved = false;
 
 	for (i = 0; i < dt_idle_states; i++) {
 		struct pnv_idle_state *state = &pnv_idle.states[i];
@@ -601,6 +654,29 @@ static void __init pnv_power8_idle_init(void)
 			has_nap = true;
 		if (state->flags & OPAL_PM_SLEEP_ENABLED_ER1)
 			has_sleep_er1 = true;
+		if (state->flags & OPAL_PM_LOSE_FULL_CONTEXT) {
+			int rc;
+
+			if (sprs_for_deep_state_saved)
+				continue;
+			if (disable_full_context_loss) {
+				state->valid = false;
+				pr_warn("cpuidle-powernv: Disabling full-context loss state :%s\n",
+					pnv_idle.states[i].name);
+				continue;
+			}
+
+			rc = pnv_save_sprs_for_deep_states();
+			if (likely(!rc)) {
+				sprs_for_deep_state_saved = true;
+			} else {
+				pr_warn("cpuidle-powernv:Disabling full-context loss states.SLW unable to restore SPRs.\n");
+				disable_full_context_loss = true;
+				state->valid = false;
+				pr_warn("cpuidle-powernv:Disabling full-context loss state:%s\n",
+					pnv_idle.states[i].name);
+			}
+		}
 	}
 
 	if (!has_sleep_er1) {
-- 
1.9.4
