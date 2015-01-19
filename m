Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3AC651A0C34
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 22:33:01 +1100 (AEDT)
Received: from /spool/local
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 19 Jan 2015 04:32:59 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 920461FF0021
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 04:24:09 -0700 (MST)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t0JBWvfh44630198
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 04:32:57 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t0JBWujh010253
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 19 Jan 2015 04:32:57 -0700
Subject: [PATCH] cpuidle/powernv: Read target_residency value of idle states
 from DT if available
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
To: rafael.j.wysocki@intel.com
Date: Mon, 19 Jan 2015 17:02:51 +0530
Message-ID: <20150119113251.23984.16931.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
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
values, use default values as a fallback mechanism. While at it, clump
the common parts of device tree parsing into one chunk.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

 drivers/cpuidle/cpuidle-powernv.c |   39 ++++++++++++++++++++++++-------------
 1 file changed, 25 insertions(+), 14 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 2726663..9e732e1 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -162,7 +162,8 @@ static int powernv_add_idle_states(void)
 	int dt_idle_states;
 	const __be32 *idle_state_flags;
 	const __be32 *idle_state_latency;
-	u32 len_flags, flags, latency_ns;
+	const __be32 *idle_state_residency;
+	u32 len_flags, flags, latency_ns, residency_ns;
 	int i;
 
 	/* Currently we have snooze statically defined */
@@ -186,14 +187,21 @@ static int powernv_add_idle_states(void)
 		return nr_idle_states;
 	}
 
+	idle_state_residency = of_get_property(power_mgt,
+			"ibm,cpu-idle-state-residency-ns", NULL);
+	if (!idle_state_residency) {
+		pr_warn("DT-PowerMgmt: missing ibm,cpu-idle-state-residency-ns\n");
+		pr_warn("Falling back to default values\n");
+	}
+
 	dt_idle_states = len_flags / sizeof(u32);
 
 	for (i = 0; i < dt_idle_states; i++) {
 
 		flags = be32_to_cpu(idle_state_flags[i]);
-
-		/* Cpuidle accepts exit_latency in us and we estimate
-		 * target residency to be 10x exit_latency
+		/*
+		 * Cpuidle accepts exit_latency and target_residency in us.
+		 * Use default target_residency values if f/w does not expose it.
 		 */
 		latency_ns = be32_to_cpu(idle_state_latency[i]);
 		if (flags & OPAL_PM_NAP_ENABLED) {
@@ -201,12 +209,8 @@ static int powernv_add_idle_states(void)
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
 		}
 
 		if (flags & OPAL_PM_SLEEP_ENABLED ||
@@ -215,13 +219,20 @@ static int powernv_add_idle_states(void)
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
+				((unsigned int)latency_ns) / 1000;
+
+		if (idle_state_residency) {
+			residency_ns = be32_to_cpu(idle_state_residency[i]);
+			powernv_states[nr_idle_states].target_residency =
+				((unsigned int)residency_ns) / 1000;
+		}
+
+		nr_idle_states++;
 	}
 
 	return nr_idle_states;
