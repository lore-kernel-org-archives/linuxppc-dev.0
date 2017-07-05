Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x2mlf6JbPzDqhp
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jul 2017 02:38:38 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v65GcYOD104120
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jul 2017 12:38:36 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bh39d1jaw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 05 Jul 2017 12:38:35 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 5 Jul 2017 12:38:34 -0400
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>,
 Nicholas Piggin <npiggin@gmail.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rafael@kernel.org>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 1/5] powernv:idle: Move device-tree parsing to one place.
Date: Wed,  5 Jul 2017 22:08:12 +0530
In-Reply-To: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
References: <1499272696-28751-1-git-send-email-ego@linux.vnet.ibm.com>
Message-Id: <1499272696-28751-2-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

The details of the platform idle state are exposed by the firmware to
the kernel via device tree.

In the current code, we parse the device tree twice :

1) During the boot up in arch/powerpc/platforms/powernv/idle.c Here,
the device tree is parsed to obtain the details of the
supported_cpuidle_states which is used to determine the default idle
state (which would be used when cpuidle is absent) and the deepest
idle state (which would be used for cpu-hotplug).

2) During the powernv cpuidle driver initializion
(drivers/cpuidle/cpuidle-powernv.c). Here we parse the device tree to
populate the cpuidle driver's states.

This patch moves all the device tree parsing to the platform idle
code. It defines data-structures for recording the details of the
parsed idle states. Any other kernel subsystem that is interested in
the idle states (eg: cpuidle-powernv driver) can just use the
in-kernel data structure instead of parsing the device tree all over
again.

Further, this helps to check the validity of states in one place and
in case of invalid states (eg : stop states whose psscr values are
errorenous) flag them as invalid, so that the other subsystems can be
prevented from using those.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cpuidle.h    |  32 +--
 arch/powerpc/platforms/powernv/idle.c | 390 ++++++++++++++++++++++++++--------
 drivers/cpuidle/cpuidle-powernv.c     | 233 +++++---------------
 3 files changed, 378 insertions(+), 277 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index 52586f9..88ff2a1 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -73,19 +73,25 @@
 extern u64 pnv_first_deep_stop_state;
 
 unsigned long pnv_cpu_offline(unsigned int cpu);
-int validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags);
-static inline void report_invalid_psscr_val(u64 psscr_val, int err)
-{
-	switch (err) {
-	case ERR_EC_ESL_MISMATCH:
-		pr_warn("Invalid psscr 0x%016llx : ESL,EC bits unequal",
-			psscr_val);
-		break;
-	case ERR_DEEP_STATE_ESL_MISMATCH:
-		pr_warn("Invalid psscr 0x%016llx : ESL cleared for deep stop-state",
-			psscr_val);
-	}
-}
+
+#define PNV_IDLE_NAME_LEN     16
+struct pnv_idle_state {
+	char name[PNV_IDLE_NAME_LEN];
+	u32 flags;
+	u32 latency_ns;
+	u32 residency_ns;
+	u64 ctrl_reg_val;   /* The ctrl_reg on POWER8 would be pmicr. */
+	u64 ctrl_reg_mask;  /* On POWER9 it is psscr */
+	bool valid;
+};
+
+struct pnv_idle_states {
+	unsigned int nr_states;
+	struct pnv_idle_state *states;
+};
+
+struct pnv_idle_states *get_pnv_idle_states(void);
+
 #endif
 
 #endif
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 2abee07..b747bb5 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -58,6 +58,17 @@
 static u64 pnv_deepest_stop_psscr_mask;
 static bool deepest_stop_found;
 
+/*
+ * Data structure that stores details of
+ * all the platform idle states.
+ */
+struct pnv_idle_states pnv_idle;
+
+struct pnv_idle_states *get_pnv_idle_states(void)
+{
+	return &pnv_idle;
+}
+
 static int pnv_save_sprs_for_deep_states(void)
 {
 	int cpu;
@@ -435,9 +446,11 @@ unsigned long pnv_cpu_offline(unsigned int cpu)
  *	stop instruction
  */
 
-int validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags)
+void validate_psscr_val_mask(int i)
 {
-	int err = 0;
+	u64 *psscr_val = &pnv_idle.states[i].ctrl_reg_val;
+	u64 *psscr_mask = &pnv_idle.states[i].ctrl_reg_mask;
+	u32 flags = pnv_idle.states[i].flags;
 
 	/*
 	 * psscr_mask == 0xf indicates an older firmware.
@@ -447,7 +460,8 @@ int validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags)
 	if (*psscr_mask == 0xf) {
 		*psscr_val = *psscr_val | PSSCR_HV_DEFAULT_VAL;
 		*psscr_mask = PSSCR_HV_DEFAULT_MASK;
-		return err;
+		pnv_idle.states[i].valid = true;
+		return;
 	}
 
 	/*
@@ -458,13 +472,17 @@ int validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags)
 	 * - ESL bit is set for all the deep stop states.
 	 */
 	if (GET_PSSCR_ESL(*psscr_val) != GET_PSSCR_EC(*psscr_val)) {
-		err = ERR_EC_ESL_MISMATCH;
+		pnv_idle.states[i].valid = false;
+		pr_warn("Invalid state:%s:psscr 0x%016llx: ESL,EC bits unequal\n",
+			pnv_idle.states[i].name, *psscr_val);
 	} else if ((flags & OPAL_PM_LOSE_FULL_CONTEXT) &&
 		GET_PSSCR_ESL(*psscr_val) == 0) {
-		err = ERR_DEEP_STATE_ESL_MISMATCH;
+		pnv_idle.states[i].valid = false;
+		pr_warn("Invalid state:%s:psscr 0x%016llx:ESL cleared for deep stop\n",
+			pnv_idle.states[i].name, *psscr_val);
+	} else {
+		pnv_idle.states[i].valid = true;
 	}
-
-	return err;
 }
 
 /*
@@ -472,53 +490,12 @@ int validate_psscr_val_mask(u64 *psscr_val, u64 *psscr_mask, u32 flags)
  *                        deep idle state and deepest idle state on
  *                        ISA 3.0 CPUs.
  *
- * @np: /ibm,opal/power-mgt device node
- * @flags: cpu-idle-state-flags array
- * @dt_idle_states: Number of idle state entries
- * Returns 0 on success
  */
-static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
-					int dt_idle_states)
+static void __init pnv_power9_idle_init(void)
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
+	int dt_idle_states = pnv_idle.nr_states;
 
 	/*
 	 * Set pnv_first_deep_stop_state, pnv_deepest_stop_psscr_{val,mask},
@@ -535,31 +512,34 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 	 */
 	pnv_first_deep_stop_state = MAX_STOP_STATE;
 	for (i = 0; i < dt_idle_states; i++) {
-		int err;
-		u64 psscr_rl = psscr_val[i] & PSSCR_RL_MASK;
-
-		if ((flags[i] & OPAL_PM_LOSE_FULL_CONTEXT) &&
-		     (pnv_first_deep_stop_state > psscr_rl))
-			pnv_first_deep_stop_state = psscr_rl;
+		u64 psscr_rl, residency_ns, psscr_val, psscr_mask;
+		u32 flags;
 
-		err = validate_psscr_val_mask(&psscr_val[i], &psscr_mask[i],
-					      flags[i]);
-		if (err) {
-			report_invalid_psscr_val(psscr_val[i], err);
+		if (!pnv_idle.states[i].valid)
 			continue;
+
+		psscr_val = pnv_idle.states[i].ctrl_reg_val;
+		psscr_mask = pnv_idle.states[i].ctrl_reg_mask;
+		psscr_rl = psscr_val & PSSCR_RL_MASK;
+		flags = pnv_idle.states[i].flags;
+		residency_ns = pnv_idle.states[i].residency_ns;
+
+		if ((flags & OPAL_PM_LOSE_FULL_CONTEXT) &&
+		    (pnv_first_deep_stop_state > psscr_rl)) {
+			pnv_first_deep_stop_state = psscr_rl;
 		}
 
-		if (max_residency_ns < residency_ns[i]) {
-			max_residency_ns = residency_ns[i];
-			pnv_deepest_stop_psscr_val = psscr_val[i];
-			pnv_deepest_stop_psscr_mask = psscr_mask[i];
+		if (max_residency_ns < residency_ns) {
+			max_residency_ns = residency_ns;
+			pnv_deepest_stop_psscr_val = psscr_val;
+			pnv_deepest_stop_psscr_mask = psscr_mask;
 			deepest_stop_found = true;
 		}
 
 		if (!default_stop_found &&
-		    (flags[i] & OPAL_PM_STOP_INST_FAST)) {
-			pnv_default_stop_val = psscr_val[i];
-			pnv_default_stop_mask = psscr_mask[i];
+		    (flags & OPAL_PM_STOP_INST_FAST)) {
+			pnv_default_stop_val = psscr_val;
+			pnv_default_stop_mask = psscr_mask;
 			default_stop_found = true;
 		}
 	}
@@ -582,10 +562,251 @@ static int __init pnv_power9_idle_init(struct device_node *np, u32 *flags,
 
 	pr_info("cpuidle-powernv: Requested Level (RL) value of first deep stop = 0x%llx\n",
 		pnv_first_deep_stop_state);
+}
+
+/*
+ * Returns 0 if prop1_len == prop2_len. Else returns -1
+ */
+static inline int validate_dt_prop_sizes(const char *prop1, int prop1_len,
+					 const char *prop2, int prop2_len)
+{
+	if (prop1_len == prop2_len)
+		return 0;
+
+	pr_warn("cpuidle-powernv: array sizes don't match for %s and %s\n",
+		prop1, prop2);
+	return -1;
+}
+
+/**
+ * get_idle_prop_u32_array: Returns an array of u32 elements
+ *			    parsed from the device tree corresponding
+ *			    to the property provided in variable propname.
+ *
+ * @np: Pointer to device tree node "/ibm,opal/power-mgt"
+ * @nr_states: Expected number of elements.
+ * @propname : Name of the property whose values is an array of
+ *             u32 elements
+ *
+ * Returns a pointer to a u32 array of size nr_states on success.
+ * Returns NULL on failure.
+ */
+static inline u32 *get_idle_prop_u32_array(struct device_node *np,
+					   int nr_states,
+					   const char *propname)
+{
+	u32 *ret_array;
+	int rc, count;
+
+	count = of_property_count_u32_elems(np, propname);
+	rc = validate_dt_prop_sizes("ibm,cpu-idle-state-flags", nr_states,
+				    propname, count);
+	if (rc)
+		return NULL;
+
+	ret_array = kcalloc(nr_states, sizeof(*ret_array), GFP_KERNEL);
+	if (!ret_array)
+		return NULL;
+
+	rc = of_property_read_u32_array(np, propname, ret_array, nr_states);
+	if (!rc)
+		return ret_array;
+
+	kfree(ret_array);
+	return NULL;
+}
+
+/**
+ * get_idle_prop_u64_array: Returns an array of u64 elements
+ *			    parsed from the device tree corresponding
+ *			    to the property provided in variable propname.
+ *
+ * @np: Pointer to device tree node "/ibm,opal/power-mgt"
+ * @nr_states: Expected number of elements.
+ * @propname : Name of the property whose value is an array of
+ *             u64 elements
+ *
+ * Returns a pointer to a u64 array of size nr_states on success.
+ * Returns NULL on failure.
+ */
+static inline u64 *get_idle_prop_u64_array(struct device_node *np,
+					   int nr_states,
+					   const char *propname)
+{
+	u64 *ret_array;
+	int rc, count;
+
+	count = of_property_count_u64_elems(np, propname);
+	rc = validate_dt_prop_sizes("ibm,cpu-idle-state-flags", nr_states,
+				    propname, count);
+	if (rc)
+		return NULL;
+
+	ret_array = kcalloc(nr_states, sizeof(*ret_array), GFP_KERNEL);
+	if (!ret_array)
+		return NULL;
+
+	rc = of_property_read_u64_array(np, propname, ret_array, nr_states);
+	if (!rc)
+		return ret_array;
+
+	kfree(ret_array);
+	return NULL;
+}
+
+/**
+ * get_idle_prop_strings_array: Returns an array of string pointers
+ *			    parsed from the device tree corresponding
+ *			    to the property provided in variable propname.
+ *
+ * @np: Pointer to device tree node "/ibm,opal/power-mgt"
+ * @nr_states: Expected number of elements.
+ *
+ * @propname : Name of the property whose values is an array of string
+ *             pointers.
+ *
+ * Returns a pointer to an array of string pointers ofsize nr_states on success.
+ * Returns NULL on failure.
+ */
+static inline const char **get_idle_prop_strings_array(struct device_node *np,
+						       int nr_states,
+						       const char *propname)
+{
+	const char **ret_array;
+	int rc, count;
+
+	count = of_property_count_strings(np, propname);
+	rc = validate_dt_prop_sizes("ibm,cpu-idle-state-flags", nr_states,
+				    propname, count);
+	if (rc)
+		return NULL;
+
+	ret_array = kcalloc(nr_states, sizeof(*ret_array), GFP_KERNEL);
+	if (!ret_array)
+		return NULL;
+
+	rc = of_property_read_string_array(np, propname, ret_array, nr_states);
+	if (rc >= 0)
+		return ret_array;
+
+	kfree(ret_array);
+	return NULL;
+}
+
+static int __init pnv_idle_parse(struct  device_node *np, int dt_idle_states)
+{
+	int count;
+	u32 *latency_ns = NULL, *residency_ns = NULL, *flags = NULL;
+	u64 *psscr_vals = NULL, *psscr_masks = NULL;
+	const char **names = NULL;
+	u32 has_stop_states = 0;
+	int i, rc = -1;
+	bool residency_present = true;
+
+	pnv_idle.nr_states = 0;
+
+	flags = get_idle_prop_u32_array(np, dt_idle_states,
+					"ibm,cpu-idle-state-flags");
+	if (!flags)
+		goto out_err;
+
+	latency_ns = get_idle_prop_u32_array(np, dt_idle_states,
+					     "ibm,cpu-idle-state-latencies-ns");
+	if (!latency_ns)
+		goto out_err;
+
+	names = get_idle_prop_strings_array(np, dt_idle_states,
+					    "ibm,cpu-idle-state-names");
+	if (!names)
+		goto out_err;
+
+	/*
+	 * If the idle states use stop instruction, probe for psscr
+	 * values and psscr mask which are necessary to specify
+	 * required stop level.
+	 */
+	has_stop_states = (flags[0] &
+			   (OPAL_PM_STOP_INST_FAST | OPAL_PM_STOP_INST_DEEP));
+	if (has_stop_states) {
+		psscr_vals = get_idle_prop_u64_array(np, dt_idle_states,
+						     "ibm,cpu-idle-state-psscr");
+		if (!psscr_vals)
+			goto out_err;
+
+		psscr_masks = get_idle_prop_u64_array(np, dt_idle_states,
+						      "ibm,cpu-idle-state-psscr-mask");
+		if (!psscr_masks)
+			goto out_err;
+	}
+
+	count = of_property_count_u32_elems(np,
+					    "ibm,cpu-idle-state-residency-ns");
+	/*
+	 * On POWER8, on some of the older firmware, the residency
+	 * array can be absent. In this case we hardcode the values
+	 * for the nap and fastsleep states in the kernel.
+	 *
+	 * On POWER9, the cpu-idle-state-residency-ns is expected to be
+	 * provided by the firmware.
+	 */
+	if (count < 0) {
+		if (has_stop_states) {
+			pr_warn("cpuidle-powernv:Missing ibm,cpu-idle-state-residency in DT\n");
+			goto out_err;
+		} else {
+			residency_present = false;
+		}
+	} else {
+		residency_ns = get_idle_prop_u32_array(np, dt_idle_states,
+						       "ibm,cpu-idle-state-residency-ns");
+		if (!residency_ns)
+			goto out_err;
+	}
+
+	pnv_idle.states = kcalloc(dt_idle_states, sizeof(struct pnv_idle_state),
+				  GFP_KERNEL);
+	if (!pnv_idle.states)
+		goto out_err;
+
+	for (i = 0; i < dt_idle_states; i++) {
+		struct pnv_idle_state *state = &pnv_idle.states[i];
+
+		strlcpy(state->name, names[i], PNV_IDLE_NAME_LEN);
+		state->flags = flags[i];
+		state->latency_ns = latency_ns[i];
+
+		if (has_stop_states) {
+			state->residency_ns = residency_ns[i];
+			state->ctrl_reg_val = psscr_vals[i];
+			state->ctrl_reg_mask = psscr_masks[i];
+			validate_psscr_val_mask(i);
+		} else {
+			if (residency_present)
+				state->residency_ns = residency_ns[i];
+			else if (flags[i] & OPAL_PM_NAP_ENABLED)
+				state->residency_ns = 100000;
+			else if (flags[i] & OPAL_PM_SLEEP_ENABLED ||
+				 flags[i] & OPAL_PM_SLEEP_ENABLED_ER1)
+				state->residency_ns = 300000000;
+
+			state->valid = true;
+		}
+	}
+
+	pnv_idle.nr_states = dt_idle_states;
+	rc = 0;
+	goto out;
+
+out_err:
+	kfree(pnv_idle.states);
 out:
-	kfree(psscr_val);
-	kfree(psscr_mask);
+	kfree(names);
+	kfree(flags);
 	kfree(residency_ns);
+	kfree(latency_ns);
+	kfree(psscr_vals);
+	kfree(psscr_masks);
+
 	return rc;
 }
 
@@ -596,40 +817,33 @@ static void __init pnv_probe_idle_states(void)
 {
 	struct device_node *np;
 	int dt_idle_states;
-	u32 *flags = NULL;
 	int i;
 
 	np = of_find_node_by_path("/ibm,opal/power-mgt");
 	if (!np) {
 		pr_warn("opal: PowerMgmt Node not found\n");
-		goto out;
+		return;
 	}
 	dt_idle_states = of_property_count_u32_elems(np,
 			"ibm,cpu-idle-state-flags");
 	if (dt_idle_states < 0) {
 		pr_warn("cpuidle-powernv: no idle states found in the DT\n");
-		goto out;
+		return;
 	}
 
-	flags = kcalloc(dt_idle_states, sizeof(*flags),  GFP_KERNEL);
+	if (pnv_idle_parse(np, dt_idle_states))
+		return;
 
-	if (of_property_read_u32_array(np,
-			"ibm,cpu-idle-state-flags", flags, dt_idle_states)) {
-		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-flags in DT\n");
-		goto out;
-	}
+	if (cpu_has_feature(CPU_FTR_ARCH_300))
+		pnv_power9_idle_init();
 
-	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
-		if (pnv_power9_idle_init(np, flags, dt_idle_states))
-			goto out;
+	for (i = 0; i < dt_idle_states; i++) {
+		if (!pnv_idle.states[i].valid)
+			continue;
+		supported_cpuidle_states |= pnv_idle.states[i].flags;
 	}
-
-	for (i = 0; i < dt_idle_states; i++)
-		supported_cpuidle_states |= flags[i];
-
-out:
-	kfree(flags);
 }
+
 static int __init pnv_init_idle_states(void)
 {
 
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 37b0698..6e5ce79 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -221,218 +221,99 @@ static inline void add_powernv_state(int index, const char *name,
 	stop_psscr_table[index].mask = psscr_mask;
 }
 
-/*
- * Returns 0 if prop1_len == prop2_len. Else returns -1
- */
-static inline int validate_dt_prop_sizes(const char *prop1, int prop1_len,
-					 const char *prop2, int prop2_len)
-{
-	if (prop1_len == prop2_len)
-		return 0;
-
-	pr_warn("cpuidle-powernv: array sizes don't match for %s and %s\n",
-		prop1, prop2);
-	return -1;
-}
-
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
-
-	/* Currently we have snooze statically defined */
+	int i;
+	struct pnv_idle_states *pnv_idle;
 
-	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
-	if (!power_mgt) {
-		pr_warn("opal: PowerMgmt Node not found\n");
-		goto out;
-	}
+	pnv_idle = get_pnv_idle_states();
+	dt_idle_states = pnv_idle->nr_states;
 
-	/* Read values of any property to determine the num of idle states */
-	dt_idle_states = of_property_count_u32_elems(power_mgt, "ibm,cpu-idle-state-flags");
-	if (dt_idle_states < 0) {
-		pr_warn("cpuidle-powernv: no idle states found in the DT\n");
+	/* Currently we have snooze statically defined */
+	if (!dt_idle_states) {
+		pr_warn("cpuidle-powernv: Only snooze state available\n");
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
-
 	/*
-	 * Since snooze is used as first idle state, max idle states allowed is
-	 * CPUIDLE_STATE_MAX -1
+	 * Since snooze is used as first idle state, max idle states
+	 * allowed is CPUIDLE_STATE_MAX -1
 	 */
 	if (dt_idle_states > CPUIDLE_STATE_MAX - 1) {
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
-	 * If the idle states use stop instruction, probe for psscr values
-	 * and psscr mask which are necessary to specify required stop level.
+	 * If the idle states use stop instruction, we will need psscr
+	 * values and psscr mask to specify required stop level.
 	 */
-	has_stop_states = (flags[0] &
+	has_stop_states = (pnv_idle->states[0].flags &
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
 
-		if (of_property_read_u64_array(power_mgt,
-					       "ibm,cpu-idle-state-psscr-mask",
-						psscr_mask, dt_idle_states)) {
-			pr_warn("cpuidle-powernv:Missing ibm,cpu-idle-state-psscr-mask in DT\n");
-			goto out;
-		}
-	}
+	for (i = 0; i < dt_idle_states; i++) {
+		unsigned int exit_latency, target_residency;
+		u64 latency_ns, psscr_val = 0, psscr_mask = 0;
+		u32 flags, cpu_idle_flags = CPUIDLE_FLAG_NONE;
+		const char *name;
+		int (*idle_fn)(struct cpuidle_device *,
+			       struct cpuidle_driver *, int);
 
-	count = of_property_count_u32_elems(power_mgt,
-					    "ibm,cpu-idle-state-residency-ns");
+		if (!pnv_idle->states[i].valid)
+			continue;
 
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
+		latency_ns = pnv_idle->states[i].latency_ns;
 
-	for (i = 0; i < dt_idle_states; i++) {
-		unsigned int exit_latency, target_residency;
-		bool stops_timebase = false;
 		/*
 		 * If an idle state has exit latency beyond
 		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
 		 * in cpu-idle.
 		 */
-		if (latency_ns[i] > POWERNV_THRESHOLD_LATENCY_NS)
+		if (latency_ns > POWERNV_THRESHOLD_LATENCY_NS)
 			continue;
-		/*
-		 * Firmware passes residency and latency values in ns.
-		 * cpuidle expects it in us.
-		 */
-		exit_latency = latency_ns[i] / 1000;
-		if (!rc)
-			target_residency = residency_ns[i] / 1000;
-		else
-			target_residency = 0;
-
-		if (has_stop_states) {
-			int err = validate_psscr_val_mask(&psscr_val[i],
-							  &psscr_mask[i],
-							  flags[i]);
-			if (err) {
-				report_invalid_psscr_val(psscr_val[i], err);
+
+		flags = pnv_idle->states[i].flags;
+
+		if (flags & OPAL_PM_TIMEBASE_STOP) {
+			/*
+			 * All cpuidle states with CPU_IDLE_TIMER_STOP set
+			 * depend on CONFIG_TICK_ONE_SHOT
+			 */
+			if (!IS_ENABLED(CONFIG_TICK_ONESHOT))
 				continue;
-			}
+			cpu_idle_flags = CPUIDLE_FLAG_TIMER_STOP;
 		}
 
-		if (flags[i] & OPAL_PM_TIMEBASE_STOP)
-			stops_timebase = true;
-
-		/*
-		 * For nap and fastsleep, use default target_residency
-		 * values if f/w does not expose it.
-		 */
-		if (flags[i] & OPAL_PM_NAP_ENABLED) {
-			if (!rc)
-				target_residency = 100;
-			/* Add NAP state */
-			add_powernv_state(nr_idle_states, "Nap",
-					  CPUIDLE_FLAG_NONE, nap_loop,
-					  target_residency, exit_latency, 0, 0);
-		} else if (has_stop_states && !stops_timebase) {
-			add_powernv_state(nr_idle_states, names[i],
-					  CPUIDLE_FLAG_NONE, stop_loop,
-					  target_residency, exit_latency,
-					  psscr_val[i], psscr_mask[i]);
+		if (flags & OPAL_PM_NAP_ENABLED) {
+			name = "Nap";
+			idle_fn = nap_loop;
+		} else if (flags & OPAL_PM_SLEEP_ENABLED ||
+			   flags & OPAL_PM_SLEEP_ENABLED_ER1) {
+			name = "FastSleep";
+			idle_fn = fastsleep_loop;
+		} else if (has_stop_states) {
+			name = pnv_idle->states[i].name;
+			idle_fn = stop_loop;
+			psscr_val = pnv_idle->states[i].ctrl_reg_val;
+			psscr_mask = pnv_idle->states[i].ctrl_reg_mask;
+		} else {
+			continue;
 		}
 
 		/*
-		 * All cpuidle states with CPUIDLE_FLAG_TIMER_STOP set must come
-		 * within this config dependency check.
+		 * Firmware passes residency and latency values in ns.
+		 * cpuidle expects it in us.
 		 */
-#ifdef CONFIG_TICK_ONESHOT
-		else if (flags[i] & OPAL_PM_SLEEP_ENABLED ||
-			 flags[i] & OPAL_PM_SLEEP_ENABLED_ER1) {
-			if (!rc)
-				target_residency = 300000;
-			/* Add FASTSLEEP state */
-			add_powernv_state(nr_idle_states, "FastSleep",
-					  CPUIDLE_FLAG_TIMER_STOP,
-					  fastsleep_loop,
-					  target_residency, exit_latency, 0, 0);
-		} else if (has_stop_states && stops_timebase) {
-			add_powernv_state(nr_idle_states, names[i],
-					  CPUIDLE_FLAG_TIMER_STOP, stop_loop,
-					  target_residency, exit_latency,
-					  psscr_val[i], psscr_mask[i]);
-		}
-#endif
-		else
-			continue;
+		target_residency =
+			pnv_idle->states[i].residency_ns / 1000;
+		exit_latency = latency_ns / 1000;
+
+		add_powernv_state(nr_idle_states, name, cpu_idle_flags,
+				  idle_fn, target_residency, exit_latency,
+				  psscr_val, psscr_mask);
 		nr_idle_states++;
 	}
 out:
-- 
1.9.4
