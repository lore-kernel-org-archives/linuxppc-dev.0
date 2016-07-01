Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgzFB4Vx6zDqhC
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jul 2016 00:24:30 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u61EIu4I105427
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 1 Jul 2016 10:24:28 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23wag0w1q0-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 01 Jul 2016 10:24:28 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Fri, 1 Jul 2016 10:24:26 -0400
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: rjw@rjwysocki.net
Cc: linux-pm@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 daniel.lezcano@linaro.org, nicolas.pitre@linaro.org, bsingharora@gmail.com,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v5] cpuidle: Fix last_residency division
Date: Fri,  1 Jul 2016 09:24:14 -0500
Message-Id: <1467383054-1959-1-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Snooze is a poll idle state in powernv and pseries platforms. Snooze
has a timeout so that if a cpu stays in snooze for more than target
residency of the next available idle state, then it would exit thereby
giving chance to the cpuidle governor to re-evaluate and
promote the cpu to a deeper idle state. Therefore whenever snooze exits
due to this timeout, its last_residency will be target_residency of next
deeper state.

commit e93e59ce5b85 ("cpuidle: Replace ktime_get() with local_clock()")
changed the math around last_residency calculation. Specifically, while
converting last_residency value from nanoseconds to microseconds it does
right shift by 10. Due to this, in snooze timeout exit scenarios
last_residency calculated is roughly 2.3% less than target_residency of
next available state. This pattern is picked up get_typical_interval()
in the menu governor and therefore expected_interval in menu_select() is
frequently less than the target_residency of any state but snooze.

Due to this we are entering snooze at a higher rate, thereby affecting
the single thread performance.

Fix this by using precise division via ktime_us_delta.

Reported-by: Anton Blanchard <anton@samba.org>
Bisected-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
Changes in v5
=============
 - Replacing approximation division with ktime_us_delta.

Changes in v4
=============
 - Increasing the threshold upto which approximation can be used.
 - Removed explicit cast. Instead added a comment saying why cast
   is safe.

Changes in v3
=============
 - Using approximation suggested by David

Changes in v2
=============
 - Fixing it in the cpuidle core code instead of driver code.

 drivers/cpuidle/cpuidle.c | 12 ++++--------
 1 file changed, 4 insertions(+), 8 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index a4d0059..c73207a 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -173,7 +173,7 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 
 	struct cpuidle_state *target_state = &drv->states[index];
 	bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
-	u64 time_start, time_end;
+	ktime_t time_start, time_end;
 	s64 diff;
 
 	/*
@@ -195,13 +195,13 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	sched_idle_set_state(target_state);
 
 	trace_cpu_idle_rcuidle(index, dev->cpu);
-	time_start = local_clock();
+	time_start = ns_to_ktime(local_clock());
 
 	stop_critical_timings();
 	entered_state = target_state->enter(dev, drv, index);
 	start_critical_timings();
 
-	time_end = local_clock();
+	time_end = ns_to_ktime(local_clock());
 	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, dev->cpu);
 
 	/* The cpu is no longer idle or about to enter idle. */
@@ -217,11 +217,7 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	if (!cpuidle_state_is_coupled(drv, index))
 		local_irq_enable();
 
-	/*
-	 * local_clock() returns the time in nanosecond, let's shift
-	 * by 10 (divide by 1024) to have microsecond based time.
-	 */
-	diff = (time_end - time_start) >> 10;
+	diff = ktime_us_delta(time_end, time_start);
 	if (diff > INT_MAX)
 		diff = INT_MAX;
 
-- 
2.1.4
