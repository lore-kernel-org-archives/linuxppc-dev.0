Return-Path: <akshay.adiga@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41gySz1dCWzF1Rb
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Aug 2018 14:52:03 +1000 (AEST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w724kxXN099413
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 2 Aug 2018 00:52:00 -0400
Received: from e06smtp03.uk.ibm.com (e06smtp03.uk.ibm.com [195.75.94.99])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2kkrq5d7bk-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 02 Aug 2018 00:52:00 -0400
Received: from localhost
 by e06smtp03.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <akshay.adiga@linux.vnet.ibm.com>;
 Thu, 2 Aug 2018 05:51:57 +0100
From: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Cc: npiggin@gmail.com, mpe@ellerman.id.au, benh@kernel.crashing.org,
 ego@linux.vnet.ibm.com, huntbag@linux.vnet.ibm.com,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
Subject: [RFC PATCH 1/3] cpuidle/powernv: Add support for states with ibm,
 cpuidle-state-v1
Date: Thu,  2 Aug 2018 10:21:30 +0530
In-Reply-To: <20180802045132.12432-1-akshay.adiga@linux.vnet.ibm.com>
References: <20180802045132.12432-1-akshay.adiga@linux.vnet.ibm.com>
Message-Id: <20180802045132.12432-2-akshay.adiga@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This patch adds support for new device-tree format for idle state
description.

Previously if a older kernel runs on a newer firmware, it may enable
all available states irrespective of its capability of handling it.
New device tree format adds a compatible flag, so that only kernel
which has the capability to handle the version of stop state will enable
it.

Older kernel will still see stop0 and stop0_lite in older format and we
will depricate it after some time.

1) Idea is to bump up the version in firmware if we find a bug or
regression in stop states. A fix will be provided in linux which would
now know about the bumped up version of stop states, where as kernel
without fixes would ignore the states.

2) Slowly deprecate cpuidle /cpuhotplug threshold which is hard-coded
into cpuidle-powernv driver. Instead use compatible strings to indicate
if idle state is suitable for cpuidle and hotplug.

New idle state device tree format :
       power-mgt {
            ...
         ibm,enabled-stop-levels = <0xec000000>;
         ibm,cpu-idle-state-psscr-mask = <0x0 0x3003ff 0x0 0x3003ff>;
         ibm,cpu-idle-state-latencies-ns = <0x3e8 0x7d0>;
         ibm,cpu-idle-state-psscr = <0x0 0x330 0x0 0x300330>;
         ibm,cpu-idle-state-flags = <0x100000 0x101000>;
         ibm,cpu-idle-state-residency-ns = <0x2710 0x4e20>;
         ibm,idle-states {
                     stop4 {
                         flags = <0x207000>;
                         compatible = "ibm,state-v1",
                                      "cpuidle",
                                      "opal-supported";
                         psscr-mask = <0x0 0x3003ff>;
                         handle = <0x102>;
                         latency-ns = <0x186a0>;
                         residency-ns = <0x989680>;
                         psscr = <0x0 0x300374>;
                  };
                    ...
                    stop11 {
                     ...
                         compatible = "ibm,state-v1",
                                      "cpuoffline",
                                      "opal-supported";
                         ...
                  };
             };

compatible strings :
"cpuidle" : indicates it should be used by cpuidle-driver
"cpuoffline" : indicates it should be used by hotplug driver
"ibm,state-v1" : kernel checks if it knows about this version
"opal-supported" : indicates kernel can fall back to use opal
		   for stop-transitions

Signed-off-by: Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/cpuidle.h    |  11 ++
 arch/powerpc/platforms/powernv/idle.c | 139 +++++++++++++++++++++++++-
 drivers/cpuidle/cpuidle-powernv.c     |  50 +++++----
 3 files changed, 175 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/cpuidle.h b/arch/powerpc/include/asm/cpuidle.h
index 43e5f31fe64d..b965066560cc 100644
--- a/arch/powerpc/include/asm/cpuidle.h
+++ b/arch/powerpc/include/asm/cpuidle.h
@@ -79,17 +79,28 @@ struct stop_sprs {
 	u64 mmcra;
 };
 
+enum idle_state_type_t {
+	CPUIDLE_TYPE,
+	CPUOFFLINE_TYPE
+};
+
+
+#define POWERNV_THRESHOLD_LATENCY_NS 200000
+#define PNV_VER_NAME_LEN    32
 #define PNV_IDLE_NAME_LEN    16
 struct pnv_idle_states_t {
 	char name[PNV_IDLE_NAME_LEN];
+	char version[PNV_VER_NAME_LEN];
 	u32 latency_ns;
 	u32 residency_ns;
 	u64 psscr_val;
 	u64 psscr_mask;
 	u32 flags;
+	enum idle_state_type_t type;
 	bool valid;
 };
 
+
 extern struct pnv_idle_states_t *pnv_idle_states;
 extern int nr_pnv_idle_states;
 extern u32 pnv_fastsleep_workaround_at_entry[];
diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
index 7cf71b3e03a1..93accece92e3 100644
--- a/arch/powerpc/platforms/powernv/idle.c
+++ b/arch/powerpc/platforms/powernv/idle.c
@@ -47,6 +47,19 @@ static u64 pnv_default_stop_val;
 static u64 pnv_default_stop_mask;
 static bool default_stop_found;
 
+static int parse_dt_v1(struct device_node *np);
+struct stop_version_t {
+	const char name[PNV_VER_NAME_LEN];
+	int (*parser_fn)(struct device_node *np);
+};
+struct stop_version_t known_versions[] = {
+			{
+				.name =  "ibm,state-v1",
+				.parser_fn = parse_dt_v1,
+			}
+};
+const int nr_known_versions = 1;
+
 /*
  * First deep stop state. Used to figure out when to save/restore
  * hypervisor context.
@@ -659,8 +672,14 @@ static int __init pnv_power9_idle_init(void)
 			state->valid = false;
 			report_invalid_psscr_val(state->psscr_val, err);
 			continue;
+		} else {
+			state->valid = true;
 		}
 
+		/*
+		 * We pick state with highest residency. We dont care if
+		 * its a cpuidle state or a cpuoffline state.
+		 */
 		if (max_residency_ns < state->residency_ns) {
 			max_residency_ns = state->residency_ns;
 			pnv_deepest_stop_psscr_val = state->psscr_val;
@@ -720,6 +739,73 @@ static void __init pnv_probe_idle_states(void)
 		supported_cpuidle_states |= pnv_idle_states[i].flags;
 }
 
+static int parse_dt_v1(struct device_node *dt_node)
+{
+	const char *temp_str;
+	int rc;
+	int i = nr_pnv_idle_states;
+
+	if (!dt_node) {
+		pr_err("Invalid device_node\n");
+		return -EINVAL;
+	}
+
+	rc = of_property_read_string(dt_node, "name", &temp_str);
+	if (rc) {
+		pr_err("error reading names rc= %d\n", rc);
+		return -EINVAL;
+	} else {
+		strncpy(pnv_idle_states[i].name, temp_str,
+						PNV_IDLE_NAME_LEN);
+	}
+	rc = of_property_read_u32(dt_node, "residency-ns",
+				  &pnv_idle_states[i].residency_ns);
+	if (rc) {
+		pr_err("error reading residency rc= %d\n", rc);
+		return -EINVAL;
+	}
+	rc = of_property_read_u32(dt_node, "latency-ns",
+				  &pnv_idle_states[i].latency_ns);
+	if (rc) {
+		pr_err("error reading latency rc= %d\n", rc);
+		return -EINVAL;
+	}
+	rc = of_property_read_u32(dt_node, "flags",
+				  &pnv_idle_states[i].flags);
+	if (rc) {
+		pr_err("error reading flags rc= %d\n", rc);
+		return -EINVAL;
+	}
+
+	/* We are not expecting power8 device-tree in this format */
+	rc = of_property_read_u64(dt_node, "psscr-mask",
+				  &pnv_idle_states[i].psscr_mask);
+	if (rc) {
+		pr_err("error reading psscr-mask rc= %d\n", rc);
+		return -EINVAL;
+	}
+	rc = of_property_read_u64(dt_node, "psscr",
+				  &pnv_idle_states[i].psscr_val);
+	if (rc) {
+		pr_err("error reading psscr rc= %d\n", rc);
+		return -EINVAL;
+	}
+
+	/*
+	 * TODO : save the version strings in data structure
+	 */
+	if (of_device_is_compatible(dt_node, "cpuidle"))
+		pnv_idle_states[i].type = CPUIDLE_TYPE;
+	else if (of_device_is_compatible(dt_node, "cpuoffline"))
+		pnv_idle_states[i].type = CPUOFFLINE_TYPE;
+	else {
+		pr_err("Invalid type skipping %s\n",
+					pnv_idle_states[i].name);
+		return -EINVAL;
+	}
+	return 0;
+
+}
 /*
  * This function parses device-tree and populates all the information
  * into pnv_idle_states structure. It also sets up nr_pnv_idle_states
@@ -728,8 +814,9 @@ static void __init pnv_probe_idle_states(void)
 
 static int pnv_parse_cpuidle_dt(void)
 {
-	struct device_node *np;
+	struct device_node *np, *np1, *dt_node;
 	int nr_idle_states, i;
+	int additional_states = 0;
 	int rc = 0;
 	u32 *temp_u32;
 	u64 *temp_u64;
@@ -742,9 +829,14 @@ static int pnv_parse_cpuidle_dt(void)
 	}
 	nr_idle_states = of_property_count_u32_elems(np,
 						"ibm,cpu-idle-state-flags");
-
-	pnv_idle_states = kcalloc(nr_idle_states, sizeof(*pnv_idle_states),
-				  GFP_KERNEL);
+	np1 = of_find_node_by_path("/ibm,opal/power-mgt/ibm,idle-states");
+	if (np1) {
+		for_each_child_of_node(np1, dt_node)
+			additional_states++;
+	}
+	pr_info("states in new format : %d\n", additional_states);
+	pnv_idle_states = kcalloc(nr_idle_states + additional_states,
+				  sizeof(*pnv_idle_states), GFP_KERNEL);
 	temp_u32 = kcalloc(nr_idle_states, sizeof(u32),  GFP_KERNEL);
 	temp_u64 = kcalloc(nr_idle_states, sizeof(u64),  GFP_KERNEL);
 	temp_string = kcalloc(nr_idle_states, sizeof(char *),  GFP_KERNEL);
@@ -823,8 +915,45 @@ static int pnv_parse_cpuidle_dt(void)
 	for (i = 0; i < nr_idle_states; i++)
 		strncpy(pnv_idle_states[i].name, temp_string[i],
 			PNV_IDLE_NAME_LEN);
+
+	/* Mark states as CPUIDLE_TYPE /CPUOFFLINE for older version*/
+	for (i = 0; i < nr_idle_states; i++) {
+		if (pnv_idle_states[i].latency_ns > POWERNV_THRESHOLD_LATENCY_NS)
+			pnv_idle_states[i].type  = CPUOFFLINE_TYPE;
+		else
+			pnv_idle_states[i].type  = CPUIDLE_TYPE;
+	}
+
+	/* Setting up global count of parsed state */
 	nr_pnv_idle_states = nr_idle_states;
-	rc = 0;
+
+	/* Parsing node-based idle states device-tree format */
+	if (!np1) {
+		pr_info("dt does not contain ibm,idle_states");
+		goto out;
+	}
+	/* Parse each child node with appropriate parser_fn */
+	for_each_child_of_node(np1, dt_node) {
+		bool found_known_version = false;
+		/* we don't have state falling back to opal*/
+		for (i = 0; i < nr_known_versions ; i++) {
+			if (of_device_is_compatible(dt_node, known_versions[i].name)) {
+				rc = known_versions[i].parser_fn(dt_node);
+				if (rc) {
+					pr_err("%s could not parse\n",known_versions[i].name);
+					continue;
+				}
+				found_known_version = true;
+			}
+		}
+		
+		if (!found_known_version) {
+				pr_info("Unsupported state, skipping all further state\n");
+				goto out;
+		}
+		nr_pnv_idle_states++;
+	}
+
 out:
 	kfree(temp_u32);
 	kfree(temp_u64);
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 47ac37d6c443..f5579f0369d1 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -26,7 +26,6 @@
  * Expose only those Hardware idle states via the cpuidle framework
  * that have latency value below POWERNV_THRESHOLD_LATENCY_NS.
  */
-#define POWERNV_THRESHOLD_LATENCY_NS 200000
 
 static struct cpuidle_driver powernv_idle_driver = {
 	.name             = "powernv_idle",
@@ -266,7 +265,7 @@ extern u32 pnv_get_supported_cpuidle_states(void);
 static int powernv_add_idle_states(void)
 {
 	int nr_idle_states = 1; /* Snooze */
-	int dt_idle_states;
+	int dt_idle_states = 0;
 	u32 has_stop_states = 0;
 	int i;
 	u32 supported_flags = pnv_get_supported_cpuidle_states();
@@ -277,16 +276,19 @@ static int powernv_add_idle_states(void)
 		pr_warn("cpuidle-powernv : Only Snooze is available\n");
 		goto out;
 	}
-
-	/* TODO: Count only states which are eligible for cpuidle */
-	dt_idle_states = nr_pnv_idle_states;
-
+	/* Count only cpuidle states*/
+	for (i = 0; i < nr_pnv_idle_states; i++) {
+		if (pnv_idle_states[i].type == CPUIDLE_TYPE)
+			dt_idle_states++;
+	}
+	pr_info("idle states in dt = %d , states with idle flag = %d",
+					nr_pnv_idle_states, dt_idle_states);
 	/*
 	 * Since snooze is used as first idle state, max idle states allowed is
 	 * CPUIDLE_STATE_MAX -1
 	 */
-	if (nr_pnv_idle_states > CPUIDLE_STATE_MAX - 1) {
-		pr_warn("cpuidle-powernv: discovered idle states more than allowed");
+	if (dt_idle_states > CPUIDLE_STATE_MAX - 1) {
+		pr_warn("cpuidle-powernv: discovered idle states > allowed");
 		dt_idle_states = CPUIDLE_STATE_MAX - 1;
 	}
 
@@ -297,24 +299,28 @@ static int powernv_add_idle_states(void)
 	has_stop_states = (pnv_idle_states[0].flags &
 			   (OPAL_PM_STOP_INST_FAST | OPAL_PM_STOP_INST_DEEP));
 
-	for (i = 0; i < dt_idle_states; i++) {
+	for (i = 0; i < nr_pnv_idle_states; i++) {
 		unsigned int exit_latency, target_residency;
 		bool stops_timebase = false;
 		struct pnv_idle_states_t *state = &pnv_idle_states[i];
-
 		/*
-		 * Skip the platform idle state whose flag isn't in
-		 * the supported_cpuidle_states flag mask.
+		 * For older version of device-tree the state will be
+		 * set as CPUIDLE_TYPE if the latency exceeds
+		 * POWERNV_THRESHOLD_LATENCY_NS
 		 */
-		if ((state->flags & supported_flags) != state->flags)
+		if (state->type != CPUIDLE_TYPE) {
+			pr_info("State %d is not idletype, it of %d type\n", i,
+								state->type);
 			continue;
+		}
 		/*
-		 * If an idle state has exit latency beyond
-		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
-		 * in cpu-idle.
+		 * Skip the platform idle state whose flag isn't in
+		 * the supported_cpuidle_states flag mask.
 		 */
-		if (state->latency_ns > POWERNV_THRESHOLD_LATENCY_NS)
+		if ((state->flags & supported_flags) != state->flags) {
+			pr_warn("State %d is not have supported flag\n", i);
 			continue;
+		}
 		/*
 		 * Firmware passes residency and latency values in ns.
 		 * cpuidle expects it in us.
@@ -322,8 +328,10 @@ static int powernv_add_idle_states(void)
 		exit_latency = DIV_ROUND_UP(state->latency_ns, 1000);
 		target_residency = DIV_ROUND_UP(state->residency_ns, 1000);
 
-		if (has_stop_states && !(state->valid))
-				continue;
+		if (has_stop_states && !(state->valid)) {
+			pr_warn("State %d is invalid\n", i);
+			continue;
+		}
 
 		if (state->flags & OPAL_PM_TIMEBASE_STOP)
 			stops_timebase = true;
@@ -365,8 +373,10 @@ static int powernv_add_idle_states(void)
 					  state->psscr_mask);
 		}
 #endif
-		else
+		else {
+			pr_warn("cpuidle-powernv : could not add state\n");
 			continue;
+		}
 		nr_idle_states++;
 	}
 out:
-- 
2.18.0.rc2.85.g1fb9df7
