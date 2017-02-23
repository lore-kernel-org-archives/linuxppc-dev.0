Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vTfbK5qsJzDq8M
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Feb 2017 03:20:13 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1NGJTHI079778
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 11:20:11 -0500
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28syh4jxa4-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2017 11:20:11 -0500
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 23 Feb 2017 09:20:10 -0700
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Balbir Singh <bsingharora@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH] powernv-cpuidle: Validate DT property arrays are of same size
Date: Thu, 23 Feb 2017 21:49:44 +0530
Message-Id: <1487866784-13410-1-git-send-email-ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

The various properties associated with powernv idle states such as
names, flags, residency-ns, latencies-ns, psscr, psscr-mask are exposed
in the device-tree as property arrays such the pointwise entries in each
of these arrays correspond to the properties of the same idle state.

This patch validates that the lengths of the property arrays are the
same. If there is a mismatch, the patch will ensure that we bail out and
not expose the platform idle states via cpuidle.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 56 ++++++++++++++++++++++++++++++++++++---
 1 file changed, 53 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 3705930..c30b9fd 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -197,11 +197,25 @@ static inline void add_powernv_state(int index, const char *name,
 	stop_psscr_table[index].mask = psscr_mask;
 }
 
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
 static int powernv_add_idle_states(void)
 {
 	struct device_node *power_mgt;
 	int nr_idle_states = 1; /* Snooze */
-	int dt_idle_states;
+	int dt_idle_states, count;
 	u32 latency_ns[CPUIDLE_STATE_MAX];
 	u32 residency_ns[CPUIDLE_STATE_MAX];
 	u32 flags[CPUIDLE_STATE_MAX];
@@ -226,6 +240,19 @@ static int powernv_add_idle_states(void)
 		goto out;
 	}
 
+	count = of_property_count_u32_elems(power_mgt,
+					    "ibm,cpu-idle-state-latencies-ns");
+
+	if (validate_dt_prop_sizes("flags", dt_idle_states,
+				   "latencies-ns", count) != 0)
+		goto out;
+
+	count = of_property_count_strings(power_mgt,
+					  "ibm,cpu-idle-state-names");
+	if (validate_dt_prop_sizes("flags", dt_idle_states,
+				   "names", count) != 0)
+		goto out;
+
 	/*
 	 * Since snooze is used as first idle state, max idle states allowed is
 	 * CPUIDLE_STATE_MAX -1
@@ -260,6 +287,18 @@ static int powernv_add_idle_states(void)
 	has_stop_states = (flags[0] &
 			   (OPAL_PM_STOP_INST_FAST | OPAL_PM_STOP_INST_DEEP));
 	if (has_stop_states) {
+		count = of_property_count_u64_elems(power_mgt,
+						    "ibm,cpu-idle-state-psscr");
+		if (validate_dt_prop_sizes("flags", dt_idle_states,
+					   "psscr", count) != 0)
+			goto out;
+
+		count = of_property_count_u64_elems(power_mgt,
+						    "ibm,cpu-idle-state-psscr-mask");
+		if (validate_dt_prop_sizes("flags", dt_idle_states,
+					   "psscr-mask", count) != 0)
+			goto out;
+
 		if (of_property_read_u64_array(power_mgt,
 		    "ibm,cpu-idle-state-psscr", psscr_val, dt_idle_states)) {
 			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-psscr in DT\n");
@@ -274,8 +313,19 @@ static int powernv_add_idle_states(void)
 		}
 	}
 
-	rc = of_property_read_u32_array(power_mgt,
-		"ibm,cpu-idle-state-residency-ns", residency_ns, dt_idle_states);
+	count = of_property_count_u32_elems(power_mgt,
+					    "ibm,cpu-idle-state-residency-ns");
+
+	if (count < 0) {
+		rc = count;
+	} else if (validate_dt_prop_sizes("flags", dt_idle_states,
+					  "psscr-mask", count) != 0) {
+		goto out;
+	} else {
+		rc = of_property_read_u32_array(power_mgt,
+						"ibm,cpu-idle-state-residency-ns",
+						residency_ns, dt_idle_states);
+	}
 
 	for (i = 0; i < dt_idle_states; i++) {
 		unsigned int exit_latency, target_residency;
-- 
1.9.4
