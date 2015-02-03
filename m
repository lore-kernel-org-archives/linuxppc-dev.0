Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 164871A0D6A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  3 Feb 2015 17:32:25 +1100 (AEDT)
Received: from /spool/local
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 2 Feb 2015 23:32:23 -0700
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 935871FF0046
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Feb 2015 23:23:32 -0700 (MST)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t136WZpt40435752
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Feb 2015 23:32:43 -0700
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t136VlnZ019042
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 2 Feb 2015 23:31:47 -0700
Subject: [PATCH] driver/cpuidle-powernv: Avoid endianness conversions while
 parsing DT
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Date: Tue, 03 Feb 2015 12:01:15 +0530
Message-ID: <20150203062810.13207.93694.stgit@preeti.in.ibm.com>
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

We currently read the information about idle states from the DT
so as to populate the cpuidle table. Use those APIs to read from
the DT that can avoid endianness conversions of the property values
in the cpuidle driver.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---
This patch is based ontop of the mainline + V4 of "cpuidle/powernv:
Read target_residency value of idle states from DT if available".

 drivers/cpuidle/cpuidle-powernv.c |   30 ++++++++++++++++--------------
 1 file changed, 16 insertions(+), 14 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 3aa27a0..4f76fc7 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -161,9 +161,7 @@ static int powernv_add_idle_states(void)
 	struct device_node *power_mgt;
 	int nr_idle_states = 1; /* Snooze */
 	int dt_idle_states;
-	const __be32 *idle_state_flags;
-	u32 len_flags, flags;
-	u32 *latency_ns, *residency_ns;
+	u32 *latency_ns, *residency_ns, *flags;
 	int i, rc;
 
 	/* Currently we have snooze statically defined */
@@ -174,15 +172,19 @@ static int powernv_add_idle_states(void)
 		goto out;
 	}
 
-	idle_state_flags = of_get_property(power_mgt,
-				"ibm,cpu-idle-state-flags", &len_flags);
-	if (!idle_state_flags) {
-		pr_warn("cpuidle-powernv : missing
-				ibm,cpu-idle-state-flags in DT\n");
+	/* Read values of any property to determine the num of idle states */
+	dt_idle_states = of_property_count_u32_elems(power_mgt, "ibm,cpu-idle-state-flags");
+	if (dt_idle_states < 0) {
+		pr_warn("cpuidle-powernv: no idle states found in the DT\n");
 		goto out;
 	}
 
-	dt_idle_states = len_flags / sizeof(u32);
+	flags = kzalloc(sizeof(*flags) * dt_idle_states, GFP_KERNEL);
+	if (of_property_read_u32_array(power_mgt,
+			"ibm,cpu-idle-state-flags", flags, dt_idle_states)) {
+		pr_warn("cpuidle-powernv : missing ibm,cpu-idle-state-flags in DT\n");
+		goto out_free_flags;
+ 	}
 
 	latency_ns = kzalloc(sizeof(*latency_ns) * dt_idle_states, GFP_KERNEL);
 	rc = of_property_read_u32_array(power_mgt,
@@ -199,21 +201,19 @@ static int powernv_add_idle_states(void)
 
 	for (i = 0; i < dt_idle_states; i++) {
 
-		flags = be32_to_cpu(idle_state_flags[i]);
-
 		/*
 		 * Cpuidle accepts exit_latency and target_residency in us.
 		 * Use default target_residency values if f/w does not expose it.
 		 */
-		if (flags & OPAL_PM_NAP_ENABLED) {
+		if (flags[i] & OPAL_PM_NAP_ENABLED) {
 			/* Add NAP state */
 			strcpy(powernv_states[nr_idle_states].name, "Nap");
 			strcpy(powernv_states[nr_idle_states].desc, "Nap");
 			powernv_states[nr_idle_states].flags = 0;
 			powernv_states[nr_idle_states].target_residency = 100;
 			powernv_states[nr_idle_states].enter = &nap_loop;
-		} else if (flags & OPAL_PM_SLEEP_ENABLED ||
-			flags & OPAL_PM_SLEEP_ENABLED_ER1) {
+		} else if (flags[i] & OPAL_PM_SLEEP_ENABLED ||
+			flags[i] & OPAL_PM_SLEEP_ENABLED_ER1) {
 			/* Add FASTSLEEP state */
 			strcpy(powernv_states[nr_idle_states].name, "FastSleep");
 			strcpy(powernv_states[nr_idle_states].desc, "FastSleep");
@@ -236,6 +236,8 @@ static int powernv_add_idle_states(void)
 	kfree(residency_ns);
 out_free_latency:
 	kfree(latency_ns);
+out_free_flags:
+	kfree(flags);
 out:
 	return nr_idle_states;
 }
