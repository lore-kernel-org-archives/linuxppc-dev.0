Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from e28smtp02.in.ibm.com (e28smtp02.in.ibm.com [122.248.162.2])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6326C1A0551
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 22:32:28 +1000 (AEST)
Received: from /spool/local
 by e28smtp02.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Fri, 29 May 2015 18:02:24 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id A825E394005E
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:02:23 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4TCWMWQ43253932
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:02:23 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4TCWET6025132
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 18:02:14 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: anton@samba.org, rjw@rjwysocki.net, preeti@linux.vnet.ibm.com,
 Daniel Lezcano <daniel.lezcano@linaro.org>,
 linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpuidle: powernv/pseries: Decrease the snooze residency
Date: Fri, 29 May 2015 18:02:08 +0530
Message-Id: <1432902728-31476-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The idle cpus which stay in snooze for a long period can degrade the
perfomance of the sibling cpus. If the cpu stays in snooze for more
than target residency of the next available idle state, then exit from
snooze. This gives a chance to the cpuidle governor to re-evaluate the
last idle state of the cpu to promote it to deeper idle states.

Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 12 ++++++++++++
 drivers/cpuidle/cpuidle-pseries.c | 11 +++++++++++
 2 files changed, 23 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 5937207..1e3ef5e 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -29,18 +29,25 @@ struct cpuidle_driver powernv_idle_driver = {
 
 static int max_idle_state;
 static struct cpuidle_state *cpuidle_state_table;
+static u64 snooze_timeout;
+static bool snooze_timeout_en;
 
 static int snooze_loop(struct cpuidle_device *dev,
 			struct cpuidle_driver *drv,
 			int index)
 {
+	u64 snooze_exit_time;
+
 	local_irq_enable();
 	set_thread_flag(TIF_POLLING_NRFLAG);
 
+	snooze_exit_time = get_tb() + snooze_timeout;
 	ppc64_runlatch_off();
 	while (!need_resched()) {
 		HMT_low();
 		HMT_very_low();
+		if (snooze_timeout_en && get_tb() > snooze_exit_time)
+			break;
 	}
 
 	HMT_medium();
@@ -252,6 +259,11 @@ static int powernv_idle_probe(void)
 		cpuidle_state_table = powernv_states;
 		/* Device tree can indicate more idle states */
 		max_idle_state = powernv_add_idle_states();
+		if (max_idle_state > 1) {
+			snooze_timeout_en = true;
+			snooze_timeout = powernv_states[1].target_residency *
+					 tb_ticks_per_usec;
+		}
  	} else
  		return -ENODEV;
 
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index bb9e2b6..07135e0 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -27,6 +27,8 @@ struct cpuidle_driver pseries_idle_driver = {
 
 static int max_idle_state;
 static struct cpuidle_state *cpuidle_state_table;
+static u64 snooze_timeout;
+static bool snooze_timeout_en;
 
 static inline void idle_loop_prolog(unsigned long *in_purr)
 {
@@ -58,14 +60,18 @@ static int snooze_loop(struct cpuidle_device *dev,
 			int index)
 {
 	unsigned long in_purr;
+	u64 snooze_exit_time;
 
 	idle_loop_prolog(&in_purr);
 	local_irq_enable();
 	set_thread_flag(TIF_POLLING_NRFLAG);
+	snooze_exit_time = get_tb() + snooze_timeout;
 
 	while (!need_resched()) {
 		HMT_low();
 		HMT_very_low();
+		if (snooze_timeout_en && get_tb() > snooze_exit_time)
+			break;
 	}
 
 	HMT_medium();
@@ -244,6 +250,11 @@ static int pseries_idle_probe(void)
 	} else
 		return -ENODEV;
 
+	if (max_idle_state > 1) {
+		snooze_timeout_en = true;
+		snooze_timeout = cpuidle_state_table[1].target_residency *
+				 tb_ticks_per_usec;
+	}
 	return 0;
 }
 
-- 
1.9.3
