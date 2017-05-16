Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wRrk8706wzDqM0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 18:50:08 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v4G8muB1039453
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:50:03 -0400
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2afqcn1bgj-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 May 2017 04:50:03 -0400
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 16 May 2017 02:50:02 -0600
From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>,
 Michael Neuling <mikey@neuling.org>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>,
 Akshay Adiga <akshay.adiga@linux.vnet.ibm.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Subject: [PATCH 6/6] cpuidle-powernv: Allow Deep stop states that don't stop
 time
Date: Tue, 16 May 2017 14:19:48 +0530
In-Reply-To: <cover.1494585671.git.ego@linux.vnet.ibm.com>
References: <cover.1494585671.git.ego@linux.vnet.ibm.com>
In-Reply-To: <cover.1494585671.git.ego@linux.vnet.ibm.com>
References: <cover.1494585671.git.ego@linux.vnet.ibm.com>
Message-Id: <3429547945465851cfcbf81f6e762037c395c8ac.1494585671.git.ego@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>

The current code in the cpuidle-powernv intialization only allows deep
stop states (indicated by OPAL_PM_STOP_INST_DEEP) which lose timebase
(indicated by OPAL_PM_TIMEBASE_STOP). This assumption goes back to
POWER8 time where deep states used to lose the timebase. However, on
POWER9, we do have stop states that are deep (they lose hypervisor
state) but retain the timebase.

Fix the initialization code in the cpuidle-powernv driver to allow
such deep states.

Further, there is a bug in cpuidle-powernv driver with
CONFIG_TICK_ONESHOT=n where we end up incrementing the nr_idle_states
even if a platform idle state which loses time base was not added to
the cpuidle table.

Fix this by ensuring that the nr_idle_states variable gets incremented
only when the platform idle state was added to the cpuidle table.

Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 12409a5..45eaf06 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -354,6 +354,7 @@ static int powernv_add_idle_states(void)
 
 	for (i = 0; i < dt_idle_states; i++) {
 		unsigned int exit_latency, target_residency;
+		bool stops_timebase = false;
 		/*
 		 * If an idle state has exit latency beyond
 		 * POWERNV_THRESHOLD_LATENCY_NS then don't use it
@@ -381,6 +382,9 @@ static int powernv_add_idle_states(void)
 			}
 		}
 
+		if (flags[i] & OPAL_PM_TIMEBASE_STOP)
+			stops_timebase = true;
+
 		/*
 		 * For nap and fastsleep, use default target_residency
 		 * values if f/w does not expose it.
@@ -392,8 +396,7 @@ static int powernv_add_idle_states(void)
 			add_powernv_state(nr_idle_states, "Nap",
 					  CPUIDLE_FLAG_NONE, nap_loop,
 					  target_residency, exit_latency, 0, 0);
-		} else if ((flags[i] & OPAL_PM_STOP_INST_FAST) &&
-				!(flags[i] & OPAL_PM_TIMEBASE_STOP)) {
+		} else if (has_stop_states && !stops_timebase) {
 			add_powernv_state(nr_idle_states, names[i],
 					  CPUIDLE_FLAG_NONE, stop_loop,
 					  target_residency, exit_latency,
@@ -405,8 +408,8 @@ static int powernv_add_idle_states(void)
 		 * within this config dependency check.
 		 */
 #ifdef CONFIG_TICK_ONESHOT
-		if (flags[i] & OPAL_PM_SLEEP_ENABLED ||
-			flags[i] & OPAL_PM_SLEEP_ENABLED_ER1) {
+		else if (flags[i] & OPAL_PM_SLEEP_ENABLED ||
+			 flags[i] & OPAL_PM_SLEEP_ENABLED_ER1) {
 			if (!rc)
 				target_residency = 300000;
 			/* Add FASTSLEEP state */
@@ -414,14 +417,15 @@ static int powernv_add_idle_states(void)
 					  CPUIDLE_FLAG_TIMER_STOP,
 					  fastsleep_loop,
 					  target_residency, exit_latency, 0, 0);
-		} else if ((flags[i] & OPAL_PM_STOP_INST_DEEP) &&
-				(flags[i] & OPAL_PM_TIMEBASE_STOP)) {
+		} else if (has_stop_states && stops_timebase) {
 			add_powernv_state(nr_idle_states, names[i],
 					  CPUIDLE_FLAG_TIMER_STOP, stop_loop,
 					  target_residency, exit_latency,
 					  psscr_val[i], psscr_mask[i]);
 		}
 #endif
+		else
+			continue;
 		nr_idle_states++;
 	}
 out:
-- 
1.8.3.1
