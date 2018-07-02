Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41K8dJ6bR8zF1LR
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Jul 2018 00:24:03 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w62ENT11060716
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Jul 2018 10:24:00 -0400
Received: from e06smtp01.uk.ibm.com (e06smtp01.uk.ibm.com [195.75.94.97])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2jyk6eq1te-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 02 Jul 2018 10:24:00 -0400
Received: from localhost
 by e06smtp01.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Mon, 2 Jul 2018 15:23:58 +0100
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-pm@vger.kernel.org
Cc: rjw@rjwysocki.net, stewart@linux.vnet.ibm.com, benh@kernel.crashing.org,
 svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, npiggin@gmail.com,
 mpe@ellerman.id.au, Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [PATCH v2 1/2] powernv/cpuidle: Parse dt idle properties into global
 structure
Date: Mon,  2 Jul 2018 19:53:20 +0530
In-Reply-To: <1530541401-19726-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
References: <1530541401-19726-1-git-send-email-akshay.adiga@linux.vnet.ibm.com>
Message-Id: <1530541401-19726-2-git-send-email-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Device-tree parsing happens twice, once while deciding idle state to be
used for hotplug and once during cpuidle init. Hence, parsing the device
tree and caching it will reduce code duplication. Parsing code has been
moved to pnv_parse_cpuidle_dt() from pnv_probe_idle_states(). In addition
to the properties in the device tree the number of available states is
also required.

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cpuidle.h    |  11 ++
 arch/powerpc/platforms/powernv/idle.c | 216 ++++++++++++++++----------
 drivers/cpuidle/cpuidle-powernv.c     |  11 +-
 3 files changed, 151 insertions(+), 87 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index e210a83eb196..574b0ce1d671 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -79,6 +79,17 @@ struct stop_sprs {
 	u64 mmcra;
 };
 
+#define PNV_IDLE_NAME_LEN    16
+struct pnv_idle_states_t {
+	char name[PNV_IDLE_NAME_LEN];
+	u32 latency_ns;
+	u32 residency_ns;
+	u64 psscr_val;
+	u64 psscr_mask;
+	u32 flags;
+	bool valid;
+};
+
 extern u32 pnv_fastsleep_workaround_at_entry[];
 extern u32 pnv_fastsleep_workaround_at_exit[];
 
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 1c5d0675b43c..7cf71b3e03a1 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -36,6 +36,8 @@
 #define P9_STOP_SPR_PSSCR      855
 
 static u32 supported_cpuidle_states;
+struct pnv_idle_states_t *pnv_idle_states;
+int nr_pnv_idle_states;
 
 /*
  * The default stop state that will be used by ppc_md.power_save
@@ -622,48 +624,10 @@ int validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags)
  * @dt_idle_states: Number of idle state entries
  * Returns 0 on success
  */
-static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
-					int dt_idle_states)
+static int __init pnv_power9_idle_init(void)
 {
-	u64 *psscr_val = NULL;
-	u64 *psscr_mask = NULL;
-	u32 *residency_ns = NULL;
 	u64 max_residency_ns = 0;
-	int rc = 0, i;
-
-	psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val), GFP_KERNEL);
-	psscr_mask = kcalloc(dt_idle_states, sizeof(*psscr_mask), GFP_KERNEL);
-	residency_ns = kcalloc(dt_idle_states, sizeof(*residency_ns),
-			       GFP_KERNEL);
-
-	if (!psscr_val || !psscr_mask || !residency_ns) {
-		rc = -1;
-		goto out;
-	}
-
-	if (of_property_read_u64_array(np,
-		"ibm,cpu-idle-state-psscr",
-		psscr_val, dt_idle_states)) {
-		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr in DT\n");
-		rc = -1;
-		goto out;
-	}
-
-	if (of_property_read_u64_array(np,
-				       "ibm,cpu-idle-state-psscr-mask",
-				       psscr_mask, dt_idle_states)) {
-		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr-mask in DT\n");
-		rc = -1;
-		goto out;
-	}
-
-	if (of_property_read_u32_array(np,
-				       "ibm,cpu-idle-state-residency-ns",
-					residency_ns, dt_idle_states)) {
-		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-residency-ns in DT\n");
-		rc = -1;
-		goto out;
-	}
+	int i;
 
 	/*
 	 * Set pnv_first_deep_stop_state, pnv_deepest_stop_psscr_{val,mask},
@@ -679,33 +643,36 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 	 * the shallowest (OPAL_PM_STOP_INST_FAST) loss-less stop state.
 	 */
 	pnv_first_deep_stop_state = MAX_STOP_STATE;
-	for (i = 0; i < dt_idle_states; i++) {
+	for (i = 0; i < nr_pnv_idle_states; i++) {
 		int err;
-		u64 psscr_rl = psscr_val[i] & PSSCR_RL_MASK;
+		struct pnv_idle_states_t *state = &pnv_idle_states[i];
+		u64 psscr_rl = state->psscr_val & PSSCR_RL_MASK;
 
-		if ((flags[i] & OPAL_PM_LOSE_FULL_CONTEXT) &&
-		     (pnv_first_deep_stop_state > psscr_rl))
+		if ((state->flags & OPAL_PM_LOSE_FULL_CONTEXT) &&
+		    pnv_first_deep_stop_state > psscr_rl)
 			pnv_first_deep_stop_state = psscr_rl;
 
-		err = validate_psscr_val_mask(&psscr_val[i], &psscr_mask[i],
-					      flags[i]);
+		err = validate_psscr_val_mask(&state->psscr_val,
+					      &state->psscr_mask,
+					      state->flags);
 		if (err) {
-			report_invalid_psscr_val(psscr_val[i], err);
+			state->valid = false;
+			report_invalid_psscr_val(state->psscr_val, err);
 			continue;
 		}
 
-		if (max_residency_ns < residency_ns[i]) {
-			max_residency_ns = residency_ns[i];
-			pnv_deepest_stop_psscr_val = psscr_val[i];
-			pnv_deepest_stop_psscr_mask = psscr_mask[i];
-			pnv_deepest_stop_flag = flags[i];
+		if (max_residency_ns < state->residency_ns) {
+			max_residency_ns = state->residency_ns;
+			pnv_deepest_stop_psscr_val = state->psscr_val;
+			pnv_deepest_stop_psscr_mask = state->psscr_mask;
+			pnv_deepest_stop_flag = state->flags;
 			deepest_stop_found = true;
 		}
 
 		if (!default_stop_found &&
-		    (flags[i] & OPAL_PM_STOP_INST_FAST)) {
-			pnv_default_stop_val = psscr_val[i];
-			pnv_default_stop_mask = psscr_mask[i];
+		    (state->flags & OPAL_PM_STOP_INST_FAST)) {
+			pnv_default_stop_val = state->psscr_val;
+			pnv_default_stop_mask = state->psscr_mask;
 			default_stop_found = true;
 		}
 	}
@@ -728,11 +695,8 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 
 	pr_info("cpuidle-powernv: Requested Level (RL) value of first deep stop = 0x%llx\n",
 		pnv_first_deep_stop_state);
-out:
-	kfree(psscr_val);
-	kfree(psscr_mask);
-	kfree(residency_ns);
-	return rc;
+
+	return 0;
 }
 
 /*
@@ -740,50 +704,146 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
  */
 static void __init pnv_probe_idle_states(void)
 {
-	struct device_node *np;
-	int dt_idle_states;
-	u32 *flags = NULL;
 	int i;
 
+	if (nr_pnv_idle_states < 0) {
+		pr_warn("cpuidle-powernv: no idle states found in the DT\n");
+		return;
+	}
+
+	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
+		if (pnv_power9_idle_init())
+			return;
+	}
+
+	for (i = 0; i < nr_pnv_idle_states; i++)
+		supported_cpuidle_states |= pnv_idle_states[i].flags;
+}
+
+/*
+ * This function parses device-tree and populates all the information
+ * into pnv_idle_states structure. It also sets up nr_pnv_idle_states
+ * which is the number of cpuidle states discovered through device-tree.
+ */
+
+static int pnv_parse_cpuidle_dt(void)
+{
+	struct device_node *np;
+	int nr_idle_states, i;
+	int rc = 0;
+	u32 *temp_u32;
+	u64 *temp_u64;
+	const char **temp_string;
+
 	np = of_find_node_by_path("/ibm,opal/power-mgt");
 	if (!np) {
 		pr_warn("opal: PowerMgmt Node not found\n");
-		goto out;
+		return -ENODEV;
 	}
-	dt_idle_states = of_property_count_u32_elems(np,
-			"ibm,cpu-idle-state-flags");
-	if (dt_idle_states < 0) {
-		pr_warn("cpuidle-powernv: no idle states found in the DT\n");
+	nr_idle_states = of_property_count_u32_elems(np,
+						"ibm,cpu-idle-state-flags");
+
+	pnv_idle_states = kcalloc(nr_idle_states, sizeof(*pnv_idle_states),
+				  GFP_KERNEL);
+	temp_u32 = kcalloc(nr_idle_states, sizeof(u32),  GFP_KERNEL);
+	temp_u64 = kcalloc(nr_idle_states, sizeof(u64),  GFP_KERNEL);
+	temp_string = kcalloc(nr_idle_states, sizeof(char *),  GFP_KERNEL);
+
+	if (!(pnv_idle_states && temp_u32 && temp_u64 && temp_string)) {
+		pr_err("Could not allocate memory for dt parsing\n");
+		rc = -ENOMEM;
 		goto out;
 	}
 
-	flags = kcalloc(dt_idle_states, sizeof(*flags),  GFP_KERNEL);
-
-	if (of_property_read_u32_array(np,
-			"ibm,cpu-idle-state-flags", flags, dt_idle_states)) {
+	/* Read flags */
+	if (of_property_read_u32_array(np, "ibm,cpu-idle-state-flags",
+				       temp_u32, nr_idle_states)) {
 		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-flags in DT\n");
+		rc = -EINVAL;
 		goto out;
 	}
+	for (i = 0; i < nr_idle_states; i++)
+		pnv_idle_states[i].flags = temp_u32[i];
+
+	/* Read latencies */
+	if (of_property_read_u32_array(np, "ibm,cpu-idle-state-latencies-ns",
+				       temp_u32, nr_idle_states)) {
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-latencies-ns in DT\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	for (i = 0; i < nr_idle_states; i++)
+		pnv_idle_states[i].latency_ns = temp_u32[i];
+
+	/* Read residencies */
+	if (of_property_read_u32_array(np, "ibm,cpu-idle-state-residency-ns",
+				       temp_u32, nr_idle_states)) {
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-latencies-ns in DT\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	for (i = 0; i < nr_idle_states; i++)
+		pnv_idle_states[i].residency_ns = temp_u32[i];
 
+	/* For power9 */
 	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
-		if (pnv_power9_idle_init(np, flags, dt_idle_states))
+		/* Read pm_crtl_val */
+		if (of_property_read_u64_array(np, "ibm,cpu-idle-state-psscr",
+					       temp_u64, nr_idle_states)) {
+			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr in DT\n");
+			rc = -EINVAL;
+			goto out;
+		}
+		for (i = 0; i < nr_idle_states; i++)
+			pnv_idle_states[i].psscr_val = temp_u64[i];
+
+		/* Read pm_crtl_mask */
+		if (of_property_read_u64_array(np, "ibm,cpu-idle-state-psscr-mask",
+					       temp_u64, nr_idle_states)) {
+			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr-mask in DT\n");
+			rc = -EINVAL;
 			goto out;
+		}
+		for (i = 0; i < nr_idle_states; i++)
+			pnv_idle_states[i].psscr_mask = temp_u64[i];
 	}
 
-	for (i = 0; i < dt_idle_states; i++)
-		supported_cpuidle_states |= flags[i];
+	/*
+	 * power8 specific properties ibm,cpu-idle-state-pmicr-mask and
+	 * ibm,cpu-idle-state-pmicr-val were never used and there is no
+	 * plan to use it in near future. Hence, not parsing these properties
+	 */
 
+	if (of_property_read_string_array(np, "ibm,cpu-idle-state-names",
+					  temp_string, nr_idle_states) < 0) {
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-names in DT\n");
+		rc = -EINVAL;
+		goto out;
+	}
+	for (i = 0; i < nr_idle_states; i++)
+		strncpy(pnv_idle_states[i].name, temp_string[i],
+			PNV_IDLE_NAME_LEN);
+	nr_pnv_idle_states = nr_idle_states;
+	rc = 0;
 out:
-	kfree(flags);
+	kfree(temp_u32);
+	kfree(temp_u64);
+	kfree(temp_string);
+	return rc;
 }
+
 static int __init pnv_init_idle_states(void)
 {
-
+	int rc = 0;
 	supported_cpuidle_states = 0;
 
+	/* In case we error out nr_pnv_idle_states will be zero */
+	nr_pnv_idle_states = 0;
 	if (cpuidle_disable != IDLE_NO_OVERRIDE)
 		goto out;
-
+	rc = pnv_parse_cpuidle_dt();
+	if (rc)
+		return rc;
 	pnv_probe_idle_states();
 
 	if (!(supported_cpuidle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index d29e4f041efe..7ab613d4dca1 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -414,15 +414,8 @@ static int powernv_add_idle_states(void)
 		else
 			target_residency = 0;
 
-		if (has_stop_states) {
-			int err = validate_psscr_val_mask(&psscr_val[i],
-							  &psscr_mask[i],
-							  flags[i]);
-			if (err) {
-				report_invalid_psscr_val(psscr_val[i], err);
-				continue;
-			}
-		}
+		if (has_stop_states && !(state->valid))
+			continue;
 
 		if (flags[i] & OPAL_PM_TIMEBASE_STOP)
 			stops_timebase = true;
-- 
2.18.0.rc2.85.g1fb9df7
