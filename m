Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rbWZj5jH1zDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 18:24:12 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5O8J6mY097993
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 04:24:09 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23ruexac6w-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 24 Jun 2016 04:24:09 -0400
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Fri, 24 Jun 2016 02:24:09 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: rjw@rjwysocki.net
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, anton@samba.org, mpe@ellerman.id.au,
 bsingharora@gmail.com, "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH v2] cpuidle: Fix last_residency division
Date: Fri, 24 Jun 2016 03:23:58 -0500
Message-Id: <1466756638-2362-1-git-send-email-shreyas@linux.vnet.ibm.com>
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

Fix this by replacing right shift by 10 with /1000 while calculating
last_residency.

Reported-by: Anton Blanchard <anton@samba.org>
Bisected-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
Changes in v2
=============
 - Fixing it in the cpuidle core code instead of driver code.

 drivers/cpuidle/cpuidle.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index a4d0059..30d67a8 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -218,10 +218,10 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 		local_irq_enable();
 
 	/*
-	 * local_clock() returns the time in nanosecond, let's shift
-	 * by 10 (divide by 1024) to have microsecond based time.
+	 * local_clock() returns the time in nanosecond, let's
+	 * divide by 1000 to have microsecond based time.
 	 */
-	diff = (time_end - time_start) >> 10;
+	diff = (time_end - time_start) / 1000;
 	if (diff > INT_MAX)
 		diff = INT_MAX;
 
-- 
2.1.4
