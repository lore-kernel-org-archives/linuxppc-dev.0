Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rZZby5HW6zDqRd
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Jun 2016 05:37:02 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u5MJY6n1078717
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 15:37:00 -0400
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 by mx0b-001b2d01.pphosted.com with ESMTP id 23q6r4vs7c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Jun 2016 15:37:00 -0400
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 22 Jun 2016 13:36:59 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: rjw@rjwysocki.net
Cc: daniel.lezcano@linaro.org, linux-pm@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, anton@samba.org, mpe@ellerman.id.au,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH] cpuidle/powernv: Fix snooze timeout
Date: Wed, 22 Jun 2016 14:36:43 -0500
Message-Id: <1466624203-1847-1-git-send-email-shreyas@linux.vnet.ibm.com>
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
Since the math around last_residency is not meant to be precise, fix this
issue setting snooze timeout to 105% of target_residency of next
available idle state.

This also adds comment around why snooze timeout is necessary.

Reported-by: Anton Blanchard <anton@samba.org>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 14 ++++++++++++++
 drivers/cpuidle/cpuidle-pseries.c | 13 +++++++++++++
 2 files changed, 27 insertions(+)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index e12dc30..5835491 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -268,10 +268,24 @@ static int powernv_idle_probe(void)
 		cpuidle_state_table = powernv_states;
 		/* Device tree can indicate more idle states */
 		max_idle_state = powernv_add_idle_states();
+
+		/*
+		 * Staying in snooze for a long period can degrade the
+		 * perfomance of the sibling cpus. Set timeout for snooze such
+		 * that if the cpu stays in snooze longer than target residency
+		 * of the next available idle state then exit from snooze. This
+		 * gives a chance to the cpuidle governor to re-evaluate and
+		 * promote it to deeper idle states.
+		 */
 		if (max_idle_state > 1) {
 			snooze_timeout_en = true;
 			snooze_timeout = powernv_states[1].target_residency *
 					 tb_ticks_per_usec;
+			/*
+			 * Give a 5% margin since target residency related math
+			 * is not precise in cpuidle core.
+			 */
+			snooze_timeout += snooze_timeout / 20;
 		}
  	} else
  		return -ENODEV;
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index 07135e0..22de841 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -250,10 +250,23 @@ static int pseries_idle_probe(void)
 	} else
 		return -ENODEV;
 
+	/*
+	 * Staying in snooze for a long period can degrade the
+	 * perfomance of the sibling cpus. Set timeout for snooze such
+	 * that if the cpu stays in snooze longer than target residency
+	 * of the next available idle state then exit from snooze. This
+	 * gives a chance to the cpuidle governor to re-evaluate and
+	 * promote it to deeper idle states.
+	 */
 	if (max_idle_state > 1) {
 		snooze_timeout_en = true;
 		snooze_timeout = cpuidle_state_table[1].target_residency *
 				 tb_ticks_per_usec;
+		/*
+		 * Give a 5% margin since target residency related math
+		 * is not precise in cpuidle core.
+		 */
+		snooze_timeout += snooze_timeout / 20;
 	}
 	return 0;
 }
-- 
2.1.4
