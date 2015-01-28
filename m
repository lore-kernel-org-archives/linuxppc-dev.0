Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A077B1A06F7
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Jan 2015 13:14:04 +1100 (AEDT)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Tue, 27 Jan 2015 19:14:02 -0700
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 0899A3E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 19:13:59 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0S2CU5C20185100
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 19:12:39 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0S2DP9R016495
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Jan 2015 19:13:26 -0700
Subject: [PATCH V2] cpuidle/powernv: Read target_residency value of idle
 states from DT if available
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Date: Wed, 28 Jan 2015 07:43:06 +0530
Message-ID: <20150128021044.11166.81418.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: rafael.j.wysocki@intel.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
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
values, use default values as a fallback mechanism. While at it, handle some
cleanups.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

Changes from V1: https://lkml.org/lkml/2015/1/19/221
1. Used a better API for reading the DT property values.
2. Code cleanups

 drivers/cpuidle/cpuidle-powernv.c |   57 ++++++++++++++++++++-----------------
 1 file changed, 31 insertions(+), 26 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 223d505..29fdbe7 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -13,6 +13,7 @@
 #include <linux/notifier.h>
 #include <linux/clockchips.h>
 #include <linux/of.h>
+#include <linux/slab.h>
 
 #include <asm/machdep.h>
 #include <asm/firmware.h>
@@ -161,9 +162,9 @@ static int powernv_add_idle_states(void)
 	int nr_idle_states = 1; /* Snooze */
 	int dt_idle_states;
 	const __be32 *idle_state_flags;
-        const __be32 *idle_state_latency;
-        u32 len_flags, flags, latency_ns;
-	int i;
+	u32 len_flags, flags;
+	u32 *latency_ns, *residency_ns;
+	int i, rc;
 
 	/* Currently we have snooze statically defined */
 
@@ -175,53 +176,57 @@ static int powernv_add_idle_states(void)
 
 	idle_state_flags = of_get_property(power_mgt, "ibm,cpu-idle-state-flags", &len_flags);
 	if (!idle_state_flags) {
-		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-flags\n");
+		pr_warn("cpuidle-powernv : missing ibm,cpu-idle-state-flags in DT\n");
 		return nr_idle_states;
 	}
 
-	idle_state_latency = of_get_property(power_mgt,
-			"ibm,cpu-idle-state-latencies-ns", NULL);
-	if (!idle_state_latency) {
-		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-latencies-ns\n");
+	dt_idle_states = len_flags / sizeof(u32);
+
+	latency_ns = kzalloc(sizeof(*latency_ns) * dt_idle_states, GFP_KERNEL);
+	rc = of_property_read_u32_array(power_mgt,
+			"ibm,cpu-idle-state-latencies-ns", latency_ns, dt_idle_states);
+	if (rc) {
+		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-latencies-ns in DT\n");
 		return nr_idle_states;
 	}
 
-	dt_idle_states = len_flags / sizeof(u32);
+	residency_ns = kzalloc(sizeof(*residency_ns) * dt_idle_states, GFP_KERNEL);
+	rc = of_property_read_u32_array(power_mgt,
+			"ibm,cpu-idle-state-residency-ns", residency_ns, dt_idle_states);
 
 	for (i = 0; i < dt_idle_states; i++) {
 
 		flags = be32_to_cpu(idle_state_flags[i]);
-
-		/* Cpuidle accepts exit_latency in us and we estimate
-		 * target residency to be 10x exit_latency
+		/*
+		 * Cpuidle accepts exit_latency and target_residency in us.
+		 * Use default target_residency values if f/w does not expose it.
 		 */
-		latency_ns = be32_to_cpu(idle_state_latency[i]);
 		if (flags & OPAL_PM_NAP_ENABLED) {
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
+		} else if (flags & OPAL_PM_SLEEP_ENABLED ||
 			flags & OPAL_PM_SLEEP_ENABLED_ER1) {
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
 
 	return nr_idle_states;
