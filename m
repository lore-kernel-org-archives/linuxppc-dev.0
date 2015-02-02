Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 178E01A0023
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Feb 2015 16:11:54 +1100 (AEDT)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Sun, 1 Feb 2015 22:11:52 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id D214219D8041
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Feb 2015 22:03:00 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t125BgNE28573754
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 1 Feb 2015 22:11:50 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t125B8c5005883
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 1 Feb 2015 22:11:08 -0700
Subject: [PATCH V3] cpuidle/powernv: Read target_residency value of idle
 states from DT if available
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Date: Mon, 02 Feb 2015 10:40:31 +0530
Message-ID: <20150202050821.24581.56186.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: stewart@linux.vnet.ibm.com, rafael.j.wysocki@intel.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The device tree now exposes the residency values for different idle states. Read
these values instead of calculating residency from the latency values. The values
exposed in the DT are validated for optimal power efficiency. However to maintain
compatibility with the older firmware code which does not expose residency
values, use default values as a fallback mechanism. While at it, use better
APIs to parse the powermgmt device tree node so as to avoid endianness
transformation.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
Changes from V2: https://lkml.org/lkml/2015/1/27/1054
1. Used APIs to eliminate endianness transformation

Changes from V1: https://lkml.org/lkml/2015/1/19/221
1. Used a better API for reading the DT property values.
2. Code cleanups

 arch/powerpc/platforms/powernv/setup.c |   37 ++++++++------
 drivers/cpuidle/cpuidle-powernv.c      |   86 ++++++++++++++++++--------------
 2 files changed, 71 insertions(+), 52 deletions(-)

diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
index b700a32..d6a9329 100644
--- a/arch/powerpc/platforms/powernv/setup.c
+++ b/arch/powerpc/platforms/powernv/setup.c
@@ -28,6 +28,7 @@
 #include <linux/bug.h>
 #include <linux/pci.h>
 #include <linux/cpufreq.h>
+#include <linux/slab.h>
 
 #include <asm/machdep.h>
 #include <asm/firmware.h>
@@ -409,37 +410,40 @@ static int __init pnv_init_idle_states(void)
 {
 	struct device_node *power_mgt;
 	int dt_idle_states;
-	const __be32 *idle_state_flags;
-	u32 len_flags, flags;
+	u32 *flags;
 	int i;
 
 	supported_cpuidle_states = 0;
 
 	if (cpuidle_disable != IDLE_NO_OVERRIDE)
-		return 0;
+		goto out;
 
 	if (!firmware_has_feature(FW_FEATURE_OPALv3))
-		return 0;
+		goto out;
 
 	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
 	if (!power_mgt) {
 		pr_warn("opal: PowerMgmt Node not found\n");
-		return 0;
+		goto out;
 	}
 
-	idle_state_flags = of_get_property(power_mgt,
-			"ibm,cpu-idle-state-flags", &len_flags);
-	if (!idle_state_flags) {
-		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-flags\n");
-		return 0;
+	dt_idle_states = of_property_count_u32_elems(power_mgt,
+			"ibm,cpu-idle-state-flags");
+	if (dt_idle_states < 0) {
+		pr_warn("cpuidle-powernv: no idle states found in the DT\n");
+		goto out;
 	}
 
-	dt_idle_states = len_flags / sizeof(u32);
-
-	for (i = 0; i < dt_idle_states; i++) {
-		flags = be32_to_cpu(idle_state_flags[i]);
-		supported_cpuidle_states |= flags;
+	flags = kzalloc(sizeof(*flags) * dt_idle_states, GFP_KERNEL);
+	if (of_property_read_u32_array(power_mgt,
+			"ibm,cpu-idle-state-flags", flags, dt_idle_states)) {
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-flags in DT\n");
+		goto out_free;
 	}
+
+	for (i = 0; i < dt_idle_states; i++)
+		supported_cpuidle_states |= flags[i];
+
 	if (!(supported_cpuidle_states & OPAL_PM_SLEEP_ENABLED_ER1)) {
 		patch_instruction(
 			(unsigned int *)pnv_fastsleep_workaround_at_entry,
@@ -449,6 +453,9 @@ static int __init pnv_init_idle_states(void)
 			PPC_INST_NOP);
 	}
 	pnv_alloc_idle_core_states();
+out_free:
+	kfree(flags);
+out:
 	return 0;
 }
 
diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 223d505..2ef4b70 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -13,6 +13,7 @@
 #include <linux/notifier.h>
 #include <linux/clockchips.h>
 #include <linux/of.h>
+#include <linux/slab.h>
 
 #include <asm/machdep.h>
 #include <asm/firmware.h>
@@ -160,70 +161,81 @@ static int powernv_add_idle_states(void)
 	struct device_node *power_mgt;
 	int nr_idle_states = 1; /* Snooze */
 	int dt_idle_states;
-	const __be32 *idle_state_flags;
-        const __be32 *idle_state_latency;
-        u32 len_flags, flags, latency_ns;
-	int i;
+	u32 *latency_ns, *residency_ns, *flags;
+	int i, rc;
 
 	/* Currently we have snooze statically defined */
-
 	power_mgt = of_find_node_by_path("/ibm,opal/power-mgt");
 	if (!power_mgt) {
 		pr_warn("opal: PowerMgmt Node not found\n");
-		return nr_idle_states;
+		goto out;
 	}
 
-	idle_state_flags = of_get_property(power_mgt, "ibm,cpu-idle-state-flags", &len_flags);
-	if (!idle_state_flags) {
-		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-flags\n");
-		return nr_idle_states;
+	/* Read values of any property to determine the num of idle states */
+	dt_idle_states = of_property_count_u32_elems(power_mgt,
+						"ibm,cpu-idle-state-flags");
+	if (dt_idle_states < 0) {
+		pr_warn("cpuidle-powernv : no idle states found in the DT\n");
+		goto out;
 	}
 
-	idle_state_latency = of_get_property(power_mgt,
-			"ibm,cpu-idle-state-latencies-ns", NULL);
-	if (!idle_state_latency) {
-		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-latencies-ns\n");
-		return nr_idle_states;
+	flags = kzalloc(sizeof(*flags) * dt_idle_states, GFP_KERNEL);
+	if (of_property_read_u32_array(power_mgt,
+			"ibm,cpu-idle-state-flags", flags, dt_idle_states)) {
+		pr_warn("cpuidle-powernv : missing ibm,cpu-idle-state-flags in DT\n");
+		goto out_free_flags;
 	}
 
-	dt_idle_states = len_flags / sizeof(u32);
-
-	for (i = 0; i < dt_idle_states; i++) {
+	latency_ns = kzalloc(sizeof(*latency_ns) * dt_idle_states, GFP_KERNEL);
+	if (of_property_read_u32_array(power_mgt,
+		"ibm,cpu-idle-state-latencies-ns", latency_ns, dt_idle_states)) {
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-latencies-ns in DT\n");
+		goto out_free_latency;
+	}
 
-		flags = be32_to_cpu(idle_state_flags[i]);
+	residency_ns = kzalloc(sizeof(*residency_ns) * dt_idle_states, GFP_KERNEL);
+	rc = of_property_read_u32_array(power_mgt,
+		"ibm,cpu-idle-state-residency-ns", residency_ns, dt_idle_states);
 
-		/* Cpuidle accepts exit_latency in us and we estimate
-		 * target residency to be 10x exit_latency
+	for (i = 0; i < dt_idle_states; i++) {
+		/*
+		 * Cpuidle accepts exit_latency and target_residency in us.
+		 * Use default target_residency values if f/w does not expose it.
 		 */
-		latency_ns = be32_to_cpu(idle_state_latency[i]);
-		if (flags & OPAL_PM_NAP_ENABLED) {
+		if (flags[i] & OPAL_PM_NAP_ENABLED) {
 			/* Add NAP state */
 			strcpy(powernv_states[nr_idle_states].name, "Nap");
 			strcpy(powernv_states[nr_idle_states].desc, "Nap");
 			powernv_states[nr_idle_states].flags = 0;
-			powernv_states[nr_idle_states].exit_latency =
-					((unsigned int)latency_ns) / 1000;
-			powernv_states[nr_idle_states].target_residency =
-					((unsigned int)latency_ns / 100);
+			powernv_states[nr_idle_states].target_residency = 100;
 			powernv_states[nr_idle_states].enter = &nap_loop;
-			nr_idle_states++;
-		}
-
-		if (flags & OPAL_PM_SLEEP_ENABLED ||
-			flags & OPAL_PM_SLEEP_ENABLED_ER1) {
+		} else if (flags[i] & OPAL_PM_SLEEP_ENABLED ||
+			flags[i] & OPAL_PM_SLEEP_ENABLED_ER1) {
 			/* Add FASTSLEEP state */
 			strcpy(powernv_states[nr_idle_states].name, "FastSleep");
 			strcpy(powernv_states[nr_idle_states].desc, "FastSleep");
 			powernv_states[nr_idle_states].flags = CPUIDLE_FLAG_TIMER_STOP;
-			powernv_states[nr_idle_states].exit_latency =
-					((unsigned int)latency_ns) / 1000;
-			powernv_states[nr_idle_states].target_residency =
-					((unsigned int)latency_ns / 100);
+			powernv_states[nr_idle_states].target_residency = 300000;
 			powernv_states[nr_idle_states].enter = &fastsleep_loop;
-			nr_idle_states++;
 		}
+
+		powernv_states[nr_idle_states].exit_latency =
+				((unsigned int)latency_ns[i]) / 1000;
+
+		if (!rc) {
+			powernv_states[nr_idle_states].target_residency =
+				((unsigned int)residency_ns[i]) / 1000;
+		}
+
+		nr_idle_states++;
 	}
 
+	kfree(residency_ns);
+out_free_latency:
+	kfree(latency_ns);
+out_free_flags:
+	kfree(flags);
+out:
 	return nr_idle_states;
 }
 
