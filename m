Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rgMRh0yzJzDqp3
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  1 Jul 2016 00:31:27 +1000 (AEST)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5UETNTe082548
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 10:31:25 -0400
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23utcaf5pp-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 30 Jun 2016 10:31:25 -0400
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 30 Jun 2016 08:31:19 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: rjw@rjwysocki.net
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, anton@samba.org, mpe@ellerman.id.au,
 bsingharora@gmail.com, David.Laight@ACULAB.COM, arnd@arndb.de,
 nicolas.pitre@linaro.org, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH] cpuidle: Fix last_residency division
Date: Thu, 30 Jun 2016 09:27:24 -0500
Message-Id: <1467296844-2055-1-git-send-email-shreyas@linux.vnet.ibm.com>
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

Fix this by using a better approximation for division by 1000.

Reported-by: Anton Blanchard <anton@samba.org>
Bisected-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Suggested-by David Laight <david.laight@aculab.com>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
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

 drivers/cpuidle/cpuidle.c | 11 +++--------
 drivers/cpuidle/cpuidle.h | 38 ++++++++++++++++++++++++++++++++++++++
 2 files changed, 41 insertions(+), 8 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index a4d0059..f55ad01 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -174,7 +174,6 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 	struct cpuidle_state *target_state = &drv->states[index];
 	bool broadcast = !!(target_state->flags & CPUIDLE_FLAG_TIMER_STOP);
 	u64 time_start, time_end;
-	s64 diff;
 
 	/*
 	 * Tell the time framework to switch to a broadcast timer because our
@@ -218,14 +217,10 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 		local_irq_enable();
 
 	/*
-	 * local_clock() returns the time in nanosecond, let's shift
-	 * by 10 (divide by 1024) to have microsecond based time.
+	 * local_clock() returns the time in nanoseconds, convert it to
+	 * microsecond based time.
 	 */
-	diff = (time_end - time_start) >> 10;
-	if (diff > INT_MAX)
-		diff = INT_MAX;
-
-	dev->last_residency = (int) diff;
+	dev->last_residency = convert_nsec_to_usec(time_end - time_start);
 
 	if (entered_state >= 0) {
 		/* Update cpuidle counters */
diff --git a/drivers/cpuidle/cpuidle.h b/drivers/cpuidle/cpuidle.h
index f87f399..a027b35 100644
--- a/drivers/cpuidle/cpuidle.h
+++ b/drivers/cpuidle/cpuidle.h
@@ -68,4 +68,42 @@ static inline void cpuidle_coupled_unregister_device(struct cpuidle_device *dev)
 }
 #endif
 
+/*
+ * To ensure that there is no overflow while approximation
+ * for dividing val by 1000, we must respect -
+ * val + (val >> 5) <= 0xFFFFFFFF
+ * val + val/32 <= 0xFFFFFFFF
+ * val <= (0xFFFFFFFF * 32) / 33
+ * val <= 0xF83E0F82
+ * Hence the threshold for val below which we can use the
+ * approximation is 0xF83E0F82
+ */
+#define DIV_APPROXIMATION_THRESHOLD 0xF83E0F82UL
+
+/*
+ * Used for calculating last_residency in usec. Optimized for case
+ * where last_residency in nsecs is < DIV_APPROXIMATION_THRESHOLD
+ * Approximated value has less than 1% error.
+ */
+static inline int convert_nsec_to_usec(u64 nsec)
+{
+	if (likely(nsec < DIV_APPROXIMATION_THRESHOLD)) {
+		u32 usec = nsec;
+
+		usec += usec >> 5;
+		usec = usec >> 10;
+
+		/* Can safely cast to int since usec is < INT_MAX */
+		return usec;
+	} else {
+		u64 usec = div_u64(nsec, 1000);
+
+		if (usec > INT_MAX)
+			usec = INT_MAX;
+
+		/* Can safely cast to int since usec is < INT_MAX */
+		return usec;
+	}
+}
+
 #endif /* __DRIVER_CPUIDLE_H */
-- 
2.1.4
