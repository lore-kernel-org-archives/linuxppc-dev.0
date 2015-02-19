Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 89C701A086D
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 Feb 2015 16:26:48 +1100 (AEDT)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Wed, 18 Feb 2015 22:26:46 -0700
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 10A713E4003E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 22:26:35 -0700 (MST)
Received: from d03av03.boulder.ibm.com (d03av03.boulder.ibm.com [9.17.195.169])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t1J5QbrU28836028
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 22:26:46 -0700
Received: from d03av03.boulder.ibm.com (localhost [127.0.0.1])
 by d03av03.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t1J5QBXn004186
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 Feb 2015 22:26:11 -0700
Subject: [RESEND PATCH] driver/cpuidle-powernv: Avoid endianness conversions
 while parsing DT
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: rjw@rjwysocki.net
Date: Wed, 18 Feb 2015 23:24:53 -0600
Message-ID: <20150219052419.11015.43106.stgit@perfhull-ltc.austin.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
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
Acked-by: Michael Ellerman <mpe@ellerman.id.au>
---
Based on top of linux-pm/linux-next

 drivers/cpuidle/cpuidle-powernv.c |   29 ++++++++++++++++-------------
 1 file changed, 16 insertions(+), 13 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 30d4229..5937207 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -159,9 +159,7 @@ static int powernv_add_idle_states(void)
 	struct device_node *power_mgt;
 	int nr_idle_states = 1; /* Snooze */
 	int dt_idle_states;
-	const __be32 *idle_state_flags;
-	u32 len_flags, flags;
-	u32 *latency_ns, *residency_ns;
+	u32 *latency_ns, *residency_ns, *flags;
 	int i, rc;
 
 	/* Currently we have snooze statically defined */
@@ -172,14 +170,19 @@ static int powernv_add_idle_states(void)
 		goto out;
 	}
 
-	idle_state_flags = of_get_property(power_mgt,
-				"ibm,cpu-idle-state-flags", &len_flags);
-	if (!idle_state_flags) {
-		pr_warn("cpuidle-powernv: missing ibm,cpu-idle-state-flags in DT\n");
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
+	}
 
 	latency_ns = kzalloc(sizeof(*latency_ns) * dt_idle_states, GFP_KERNEL);
 	rc = of_property_read_u32_array(power_mgt,
@@ -195,21 +198,19 @@ static int powernv_add_idle_states(void)
 
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
@@ -232,6 +233,8 @@ static int powernv_add_idle_states(void)
 	kfree(residency_ns);
 out_free_latency:
 	kfree(latency_ns);
+out_free_flags:
+	kfree(flags);
 out:
 	return nr_idle_states;
 }
