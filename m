Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e39.co.us.ibm.com (e39.co.us.ibm.com [32.97.110.160])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 640E31A05E7
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 17:46:01 +1000 (EST)
Received: from /spool/local
 by e39.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 1 Oct 2014 01:45:58 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 4D88C1FF0040
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 01:34:41 -0600 (MDT)
Received: from d03av02.boulder.ibm.com (d03av02.boulder.ibm.com [9.17.195.168])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s917hqSp1311154
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 09:43:52 +0200
Received: from d03av02.boulder.ibm.com (localhost [127.0.0.1])
 by d03av02.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s917jtkv014622
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 1 Oct 2014 01:45:55 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: linux-kernel@vger.kernel.org
Subject: [PATCH v2] cpuidle/powernv: Populate cpuidle state details by
 querying the device-tree
Date: Wed,  1 Oct 2014 13:15:02 +0530
Message-Id: <1412149502-2729-1-git-send-email-shreyas@linux.vnet.ibm.com>
Cc: devicetree@vger.kernel.org, linux-pm@vger.kernel.org,
 "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Grant Likely <grant.likely@linaro.org>, Rob Herring <robh+dt@kernel.org>,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 Preeti U Murthy <preeti@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Preeti U Murthy <preeti@linux.vnet.ibm.com>

We hard code the metrics relevant for cpuidle states in the kernel today.
Instead pick them up from the device tree so that they remain relevant
and updated for the system that the kernel is running on.

Cc: linux-pm@vger.kernel.org
Cc: Rafael J. Wysocki <rjw@rjwysocki.net>
Cc: Rob Herring <robh+dt@kernel.org>
Cc: Grant Likely <grant.likely@linaro.org>
Cc: devicetree@vger.kernel.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>
Signed-off-by: Preeti U. Murthy <preeti@linux.vnet.ibm.com>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
v2:
Rebased on 3.17-rc7
Separated from 'powerpc/powernv: Support for fastsleep and winkle'

v1:
Initial post
https://lkml.org/lkml/2014/8/25/456

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index a64be57..2426a4b 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -163,7 +163,8 @@ static int powernv_add_idle_states(void)
 	int nr_idle_states = 1; /* Snooze */
 	int dt_idle_states;
 	const __be32 *idle_state_flags;
-	u32 len_flags, flags;
+	const __be32 *idle_state_latency;
+	u32 len_flags, flags, latency_ns;
 	int i;
 
 	/* Currently we have snooze statically defined */
@@ -180,18 +181,32 @@ static int powernv_add_idle_states(void)
 		return nr_idle_states;
 	}
 
+	idle_state_latency = of_get_property(power_mgt,
+			"ibm,cpu-idle-state-latencies-ns", NULL);
+	if (!idle_state_latency) {
+		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-latencies-ns\n");
+		return nr_idle_states;
+	}
+
 	dt_idle_states = len_flags / sizeof(u32);
 
 	for (i = 0; i < dt_idle_states; i++) {
 
 		flags = be32_to_cpu(idle_state_flags[i]);
+
+		/* Cpuidle accepts exit_latency in us and we estimate best case
+		 * target residency to be 10x exit_latency
+		 */
+		latency_ns = be32_to_cpu(idle_state_latency[i]);
 		if (flags & IDLE_USE_INST_NAP) {
 			/* Add NAP state */
 			strcpy(powernv_states[nr_idle_states].name, "Nap");
 			strcpy(powernv_states[nr_idle_states].desc, "Nap");
 			powernv_states[nr_idle_states].flags = CPUIDLE_FLAG_TIME_VALID;
-			powernv_states[nr_idle_states].exit_latency = 10;
-			powernv_states[nr_idle_states].target_residency = 100;
+			powernv_states[nr_idle_states].exit_latency =
+					((unsigned int)latency_ns) / 1000;
+			powernv_states[nr_idle_states].target_residency =
+					((unsigned int)latency_ns / 100);
 			powernv_states[nr_idle_states].enter = &nap_loop;
 			nr_idle_states++;
 		}
@@ -202,8 +217,10 @@ static int powernv_add_idle_states(void)
 			strcpy(powernv_states[nr_idle_states].desc, "FastSleep");
 			powernv_states[nr_idle_states].flags =
 				CPUIDLE_FLAG_TIME_VALID | CPUIDLE_FLAG_TIMER_STOP;
-			powernv_states[nr_idle_states].exit_latency = 300;
-			powernv_states[nr_idle_states].target_residency = 1000000;
+			powernv_states[nr_idle_states].exit_latency =
+					((unsigned int)latency_ns) / 1000;
+			powernv_states[nr_idle_states].target_residency =
+					((unsigned int)latency_ns / 100);
 			powernv_states[nr_idle_states].enter = &fastsleep_loop;
 			nr_idle_states++;
 		}
