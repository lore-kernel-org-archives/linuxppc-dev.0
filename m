Return-Path: <preeti@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 656342C0081
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 17:08:47 +1100 (EST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <preeti@linux.vnet.ibm.com>;
 Mon, 13 Jan 2014 23:08:44 -0700
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 0C46419D8046
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jan 2014 23:08:32 -0700 (MST)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp08025.gho.boulder.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 s0E68fe99372084
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Jan 2014 07:08:41 +0100
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s0E68eal024655
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Jan 2014 23:08:40 -0700
Subject: [PATCH] cpuidle/menu: Fail cpuidle_idle_call() if no idle state is
 acceptable
To: deepthi@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, benh@kernel.crashing.org,
 daniel.lezcano@linaro.org, rjw@rjwysocki.net,
 linux-kernel@vger.kernel.org, srivatsa.bhat@linux.vnet.ibm.com,
 svaidy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 tuukka.tikkanen@linaro.org
From: Preeti U Murthy <preeti@linux.vnet.ibm.com>
Date: Tue, 14 Jan 2014 11:35:16 +0530
Message-ID: <20140114060516.6109.14901.stgit@preeti.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On PowerPC, in a particular test scenario, all the cpu idle states were disabled.
Inspite of this it was observed that the idle state count of the shallowest
idle state, snooze, was increasing.

This is because the governor returns the idle state index as 0 even in
scenarios when no idle state can be chosen. These scenarios could be when the
latency requirement is 0 or as mentioned above when the user wants to disable
certain cpu idle states at runtime. In the latter case, its possible that no
cpu idle state is valid because the suitable states were disabled
and the rest did not match the menu governor criteria to be chosen as the
next idle state.

This patch adds the code to indicate that a valid cpu idle state could not be
chosen by the menu governor and reports back to arch so that it can take some
default action.

Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
---

 drivers/cpuidle/cpuidle.c        |    6 +++++-
 drivers/cpuidle/governors/menu.c |    7 ++++---
 2 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index a55e68f..5bf06bb 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -131,8 +131,9 @@ int cpuidle_idle_call(void)
 
 	/* ask the governor for the next state */
 	next_state = cpuidle_curr_governor->select(drv, dev);
+
+	dev->last_residency = 0;
 	if (need_resched()) {
-		dev->last_residency = 0;
 		/* give the governor an opportunity to reflect on the outcome */
 		if (cpuidle_curr_governor->reflect)
 			cpuidle_curr_governor->reflect(dev, next_state);
@@ -140,6 +141,9 @@ int cpuidle_idle_call(void)
 		return 0;
 	}
 
+	if (next_state < 0)
+		return -EINVAL;
+
 	trace_cpu_idle_rcuidle(next_state, dev->cpu);
 
 	broadcast = !!(drv->states[next_state].flags & CPUIDLE_FLAG_TIMER_STOP);
diff --git a/drivers/cpuidle/governors/menu.c b/drivers/cpuidle/governors/menu.c
index cf7f2f0..6921543 100644
--- a/drivers/cpuidle/governors/menu.c
+++ b/drivers/cpuidle/governors/menu.c
@@ -283,6 +283,7 @@ again:
  * menu_select - selects the next idle state to enter
  * @drv: cpuidle driver containing state data
  * @dev: the CPU
+ * Returns -1 when no idle state is suitable
  */
 static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 {
@@ -292,17 +293,17 @@ static int menu_select(struct cpuidle_driver *drv, struct cpuidle_device *dev)
 	int multiplier;
 	struct timespec t;
 
-	if (data->needs_update) {
+	if (data->last_state_idx >= 0 && data->needs_update) {
 		menu_update(drv, dev);
 		data->needs_update = 0;
 	}
 
-	data->last_state_idx = 0;
+	data->last_state_idx = -1;
 	data->exit_us = 0;
 
 	/* Special case when user has set very strict latency requirement */
 	if (unlikely(latency_req == 0))
-		return 0;
+		return data->last_state_idx;
 
 	/* determine the expected residency time, round up */
 	t = ktime_to_timespec(tick_nohz_get_sleep_length());
