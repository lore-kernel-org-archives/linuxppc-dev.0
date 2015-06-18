Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DFA371A0ABE
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 21:25:27 +1000 (AEST)
Received: from /spool/local
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 18 Jun 2015 21:25:26 +1000
Received: from d23relay10.au.ibm.com (d23relay10.au.ibm.com [9.190.26.77])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id BF6A92BB0047
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 21:25:23 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t5IBO0bq57999528
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 21:24:09 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t5IBNaoL028539
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 18 Jun 2015 21:23:36 +1000
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: rjw@rjwysocki.net
Cc: preeti@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, daniel.lezcano@linaro.org,
 linuxppc-dev@lists.ozlabs.org,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH v2] cpuidle: powernv/pseries: Auto-promotion of snooze to
 deeper idle state
Date: Thu, 18 Jun 2015 16:53:11 +0530
Message-Id: <1434626591-14509-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
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
Changes from v1:
-Modified commit message

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
