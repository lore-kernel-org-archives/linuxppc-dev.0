Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRSbq281hzDqp8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 18:43:35 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v788dMd1076671
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 8 Aug 2017 04:43:31 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2c799yj5hc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 08 Aug 2017 04:43:31 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 8 Aug 2017 04:43:31 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [v2 PATCH] powerpc/powernv/idle: Disable LOSE_FULL_CONTEXT states
 when stop-api fails
Date: Tue,  8 Aug 2017 14:13:15 +0530
Message-Id: <1502181795-15477-1-git-send-email-ego@linux.vnet.ibm.com>
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
clearing the OPAL_PM_LOSE_FULL_CONTEXT flag from
supported_cpuidle_states. As a result POWER8 will be prevented from
using winkle for CPU-Hotplug, and POWER9 will put the offlined CPUs to
the default stop state when available.

Further, we ensure in the initialization of the cpuidle-powernv driver
to only include those states whose flags are present in
supported_cpuidle_states, thereby skipping OPAL_PM_LOSE_FULL_CONTEXT
states when they have been disabled due to stop-api failure.

Fixes: 1e1601b38e6 ("powerpc/powernv/idle: Restore SPRs for deep idle
states via stop API.")

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
v2 --> v1:
      Do the bare minimum required to exclude the LOSE_FULL_CONTEXT
      states.

 arch/powerpc/platforms/powernv/idle.c | 41 ++++++++++++++++++++++++++++++++---
 drivers/cpuidle/cpuidle-powernv.c     | 10 +++++++++
 2 files changed, 48 insertions(+), 3 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 2abee07..a553aee 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -56,6 +56,7 @@
  */
 static u64 pnv_deepest_stop_psscr_val;
 static u64 pnv_deepest_stop_psscr_mask;
+static u64 pnv_deepest_stop_flag;
 static bool deepest_stop_found;
 
 static int pnv_save_sprs_for_deep_states(void)
@@ -185,8 +186,40 @@ static void pnv_alloc_idle_core_states(void)
 
 	update_subcore_sibling_mask();
 
-	if (supported_cpuidle_states & OPAL_PM_LOSE_FULL_CONTEXT)
-		pnv_save_sprs_for_deep_states();
+	if (supported_cpuidle_states & OPAL_PM_LOSE_FULL_CONTEXT) {
+		int rc = pnv_save_sprs_for_deep_states();
+
+		if (likely(!rc))
+			return;
+
+		/*
+		 * The stop-api is unable to restore hypervisor
+		 * resources on wakeup from platform idle states which
+		 * lose full context. So disable such states.
+		 */
+		supported_cpuidle_states &= ~OPAL_PM_LOSE_FULL_CONTEXT;
+		pr_warn("cpuidle-powernv: Disabling idle states that lose full context\n");
+		pr_warn("cpuidle-powernv: Idle power-savings, CPU-Hotplug affected\n");
+
+		if (cpu_has_feature(CPU_FTR_ARCH_300) &&
+		    (pnv_deepest_stop_flag & OPAL_PM_LOSE_FULL_CONTEXT)) {
+			/*
+			 * Use the default stop state for CPU-Hotplug
+			 * if available.
+			 */
+			if (default_stop_found) {
+				pnv_deepest_stop_psscr_val =
+					pnv_default_stop_val;
+				pnv_deepest_stop_psscr_mask =
+					pnv_default_stop_mask;
+				pr_warn("cpuidle-powernv: Offlined CPUs will stop with psscr = 0x%016llx\n",
+					pnv_deepest_stop_psscr_val);
+			} else { /* Fallback to snooze loop for CPU-Hotplug */
+				deepest_stop_found = false;
+				pr_warn("cpuidle-powernv: Offlined CPUs will busy wait\n");
+			}
+		}
+	}
 }
 
 u32 pnv_get_supported_cpuidle_states(void)
@@ -375,7 +408,8 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
 						pnv_deepest_stop_psscr_val;
 		srr1 = power9_idle_stop(psscr);
 
-	} else if (idle_states & OPAL_PM_WINKLE_ENABLED) {
+	} else if ((idle_states & OPAL_PM_WINKLE_ENABLED) &&
+		   (idle_states & OPAL_PM_LOSE_FULL_CONTEXT)) {
 		srr1 = power7_idle_insn(PNV_THREAD_WINKLE);
 	} else if ((idle_states & OPAL_PM_SLEEP_ENABLED) ||
 		   (idle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
@@ -553,6 +587,7 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 			max_residency_ns = residency_ns[i];
 			pnv_deepest_stop_psscr_val = psscr_val[i];
 			pnv_deepest_stop_psscr_mask = psscr_mask[i];
+			pnv_deepest_stop_flag = flags[i];
 			deepest_stop_found = true;
 		}
 
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 37b0698..42896a6 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -235,6 +235,7 @@ static inline int validate_dt_prop_sizes(const char *prop1, int prop1_len,
 	return -1;
 }
 
+extern u32 pnv_get_supported_cpuidle_states(void);
 static int powernv_add_idle_states(void)
 {
 	struct device_node *power_mgt;
@@ -248,6 +249,8 @@ static int powernv_add_idle_states(void)
 	const char *names[CPUIDLE_STATE_MAX];
 	u32 has_stop_states = 0;
 	int i, rc;
+	u32 supported_flags = pnv_get_supported_cpuidle_states();
+
 
 	/* Currently we have snooze statically defined */
 
@@ -362,6 +365,13 @@ static int powernv_add_idle_states(void)
 	for (i = 0; i < dt_idle_states; i++) {
 		unsigned int exit_latency, target_residency;
 		bool stops_timebase = false;
+
+		/*
+		 * Skip the platform idle state whose flag isn't in
+		 * the supported_cpuidle_states flag mask.
+		 */
+		if ((flags[i] & supported_flags) != flags[i])
+			continue;
 		/*
 		 * If an idle state has exit latency beyond
 		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
-- 
1.9.4
