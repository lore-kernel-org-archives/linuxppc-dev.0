Return-Path: <huntbag@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40znr51Nz0zF0pD
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  4 Jun 2018 18:18:12 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w548E7MY036657
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 4 Jun 2018 04:18:10 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2jd06bc2ef-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 04 Jun 2018 04:18:09 -0400
Received: from localhost
 by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <huntbag@linux.vnet.ibm.com>;
 Mon, 4 Jun 2018 09:18:08 +0100
From: Abhishek Goel <huntbag@linux.vnet.ibm.com>
To: rjw@rjwysocki.net, daniel.lezcano@linaro.org, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Cc: stewart@linux.vnet.ibm.com, Abhishek Goel <huntbag@linux.vnet.ibm.com>
Subject: [PATCH v2] cpuidle/powernv : Add Description for cpuidle state
Date: Mon,  4 Jun 2018 13:47:58 +0530
Message-Id: <20180604081758.104201-1-huntbag@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

    Names of cpuidle states were being used for description of states
    in POWER as no descriptions were added in device tree. This patch
    reads description for idle states which have been added in device
    tree.
    The description for idle states in case of POWER can be printed
    using "cpupower monitor -l" or "cpupower idle-info".

Signed-off-by: Abhishek Goel <huntbag@linux.vnet.ibm.com>
---

The skiboot patch which adds description for idle states in device tree
can be found here: https://patchwork.ozlabs.org/patch/924879/

 drivers/cpuidle/cpuidle-powernv.c | 19 +++++++++++++++----
 include/linux/cpuidle.h           |  2 +-
 2 files changed, 16 insertions(+), 5 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 1a8234e706bc..08d8b0953a14 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -133,7 +133,7 @@ static int stop_loop(struct cpuidle_device *dev,
 static struct cpuidle_state powernv_states[CPUIDLE_STATE_MAX] = {
 	{ /* Snooze */
 		.name = "snooze",
-		.desc = "snooze",
+		.desc = "idle polling state",
 		.exit_latency = 0,
 		.target_residency = 0,
 		.enter = snooze_loop },
@@ -206,6 +206,7 @@ static int powernv_cpuidle_driver_init(void)
 }
 
 static inline void add_powernv_state(int index, const char *name,
+				     const char *desc,
 				     unsigned int flags,
 				     int (*idle_fn)(struct cpuidle_device *,
 						    struct cpuidle_driver *,
@@ -215,7 +216,7 @@ static inline void add_powernv_state(int index, const char *name,
 				     u64 psscr_val, u64 psscr_mask)
 {
 	strlcpy(powernv_states[index].name, name, CPUIDLE_NAME_LEN);
-	strlcpy(powernv_states[index].desc, name, CPUIDLE_NAME_LEN);
+	strlcpy(powernv_states[index].desc, desc, CPUIDLE_DESC_LEN);
 	powernv_states[index].flags = flags;
 	powernv_states[index].target_residency = target_residency;
 	powernv_states[index].exit_latency = exit_latency;
@@ -250,6 +251,7 @@ static int powernv_add_idle_states(void)
 	u64 psscr_val[CPUIDLE_STATE_MAX];
 	u64 psscr_mask[CPUIDLE_STATE_MAX];
 	const char *names[CPUIDLE_STATE_MAX];
+	const char *descs[CPUIDLE_STATE_MAX];
 	u32 has_stop_states = 0;
 	int i, rc;
 	u32 supported_flags = pnv_get_supported_cpuidle_states();
@@ -311,6 +313,13 @@ static int powernv_add_idle_states(void)
 		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-names in DT\n");
 		goto out;
 	}
+	if (of_property_read_string_array(power_mgt,
+		"ibm,cpu-idle-state-descs", descs, dt_idle_states) < 0) {
+		of_property_read_string_array(power_mgt,
+				"ibm,cpu-idle-state-names", descs, dt_idle_states);
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-descs in DT\n"
+			"Name will be used for description\n");
+	}
 
 	/*
 	 * If the idle states use stop instruction, probe for psscr values
@@ -414,10 +423,11 @@ static int powernv_add_idle_states(void)
 				target_residency = 100;
 			/* Add NAP state */
 			add_powernv_state(nr_idle_states, "Nap",
+					  "stop processor execution",
 					  CPUIDLE_FLAG_NONE, nap_loop,
 					  target_residency, exit_latency, 0, 0);
 		} else if (has_stop_states && !stops_timebase) {
-			add_powernv_state(nr_idle_states, names[i],
+			add_powernv_state(nr_idle_states, names[i], descs[i],
 					  CPUIDLE_FLAG_NONE, stop_loop,
 					  target_residency, exit_latency,
 					  psscr_val[i], psscr_mask[i]);
@@ -434,11 +444,12 @@ static int powernv_add_idle_states(void)
 				target_residency = 300000;
 			/* Add FASTSLEEP state */
 			add_powernv_state(nr_idle_states, "FastSleep",
+					  "Core and L2 clock gating",
 					  CPUIDLE_FLAG_TIMER_STOP,
 					  fastsleep_loop,
 					  target_residency, exit_latency, 0, 0);
 		} else if (has_stop_states && stops_timebase) {
-			add_powernv_state(nr_idle_states, names[i],
+			add_powernv_state(nr_idle_states, names[i], descs[i],
 					  CPUIDLE_FLAG_TIMER_STOP, stop_loop,
 					  target_residency, exit_latency,
 					  psscr_val[i], psscr_mask[i]);
diff --git a/include/linux/cpuidle.h b/include/linux/cpuidle.h
index 1eefabf1621f..5094755cb132 100644
--- a/include/linux/cpuidle.h
+++ b/include/linux/cpuidle.h
@@ -17,7 +17,7 @@
 
 #define CPUIDLE_STATE_MAX	10
 #define CPUIDLE_NAME_LEN	16
-#define CPUIDLE_DESC_LEN	32
+#define CPUIDLE_DESC_LEN	60
 
 struct module;
 
-- 
2.14.1
