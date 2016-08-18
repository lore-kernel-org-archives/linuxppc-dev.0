Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sFghL2QgwzDr7Z
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 19 Aug 2016 08:27:30 +1000 (AEST)
Received: from pps.filterd (m0098413.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u7IMNmTP088146
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 18:27:27 -0400
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24vrm59kcx-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Aug 2016 18:27:27 -0400
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 18 Aug 2016 16:27:26 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: "Rafael J. Wysocki" <rjw@rjwysocki.net>,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 Michael Ellerman <mpe@ellerman.id.au>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Michael Neuling <michael.neuling@au1.ibm.com>,
 Paul Mackerras <paulus@samba.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Cc: Anton Blanchard <anton@samba.org>, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [RFC/PATCH 2/2] powernv:cpuidle: Enable winkle idle state in CPU-Idle.
Date: Fri, 19 Aug 2016 03:56:55 +0530
In-Reply-To: <cover.1471557381.git.ego@linux.vnet.ibm.com>
References: <cover.1471557381.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1471557381.git.ego@linux.vnet.ibm.com>
References: <cover.1471557381.git.ego@linux.vnet.ibm.com>
Message-Id: <82851f91268d8c3aae38079b57f4e46c3a1b1f5e.1471557381.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

cpu-idle on powernv currently has support for only snooze, nap and
fastsleep states. Winkle idle state was excluded due to its large
exit-latency.

This patch adds winkle as a cpu-idle state for experimental
purposes. This state is disabled at start by default. However, should an
adventurous user want to enable it on a particular CPU(s), they can do
so by echo'ing a zero into the per-cpu sysfs cpuidle control file named
"disable" corresponding to this state.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 44 ++++++++++++++++++++++++++++++++-------
 1 file changed, 36 insertions(+), 8 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index f7ca891..0437d8a 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -20,7 +20,6 @@
 #include <asm/opal.h>
 #include <asm/runlatch.h>
 
-#define POWERNV_THRESHOLD_LATENCY_NS 200000
 
 struct cpuidle_driver powernv_idle_driver = {
 	.name             = "powernv_idle",
@@ -95,6 +94,30 @@ static int fastsleep_loop(struct cpuidle_device *dev,
 
 	return index;
 }
+
+static int winkle_loop(struct cpuidle_device *dev,
+				struct cpuidle_driver *drv,
+				int index)
+{
+	unsigned long old_lpcr = mfspr(SPRN_LPCR);
+	unsigned long new_lpcr;
+
+	if (unlikely(system_state < SYSTEM_RUNNING))
+		return index;
+
+	new_lpcr = old_lpcr;
+	/* Do not exit powersave upon decrementer as we've setup the timer
+	 * offload.
+	 */
+	new_lpcr &= ~LPCR_PECE1;
+
+	mtspr(SPRN_LPCR, new_lpcr);
+	power7_winkle();
+
+	mtspr(SPRN_LPCR, old_lpcr);
+
+	return index;
+}
 #endif
 
 static int stop_loop(struct cpuidle_device *dev,
@@ -246,13 +269,6 @@ static int powernv_add_idle_states(void)
 		"ibm,cpu-idle-state-residency-ns", residency_ns, dt_idle_states);
 
 	for (i = 0; i < dt_idle_states; i++) {
-		/*
-		 * If an idle state has exit latency beyond
-		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
-		 * in cpu-idle.
-		 */
-		if (latency_ns[i] > POWERNV_THRESHOLD_LATENCY_NS)
-			continue;
 
 		/*
 		 * Cpuidle accepts exit_latency and target_residency in us.
@@ -301,6 +317,18 @@ static int powernv_add_idle_states(void)
 			powernv_states[nr_idle_states].enter = stop_loop;
 			stop_psscr_table[nr_idle_states] = psscr_val[i];
 		}
+
+		if (flags[i] & OPAL_PM_WINKLE_ENABLED) {
+			int state_idx = nr_idle_states;
+
+			strcpy(powernv_states[state_idx].name, "Winkle");
+			strcpy(powernv_states[state_idx].desc, "Winkle");
+			powernv_states[state_idx].flags =
+						CPUIDLE_FLAG_TIMER_STOP;
+			powernv_states[state_idx].target_residency = 500000;
+			powernv_states[state_idx].enter = winkle_loop;
+			powernv_states[state_idx].disable_use_at_start = true;
+		}
 #endif
 		powernv_states[nr_idle_states].exit_latency =
 				((unsigned int)latency_ns[i]) / 1000;
-- 
1.9.4
