Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wk90W1b4hzDqL5
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  9 Jun 2017 01:52:11 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id f27so5594344pfe.0
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 08 Jun 2017 08:52:11 -0700 (PDT)
From: Nicholas Piggin <npiggin@gmail.com>
To: linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>
Subject: [PATCH 12/14] powerpc/64s: cpuidle no memory barrier after break from
 idle
Date: Fri,  9 Jun 2017 01:51:11 +1000
Message-Id: <20170608155113.21300-13-npiggin@gmail.com>
In-Reply-To: <20170608155113.21300-1-npiggin@gmail.com>
References: <20170608155113.21300-1-npiggin@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

A memory barrier is not required after the task wakes up,
only if we clear the polling flag before waking. The case
where we have work to do is the important one, so optimise
for it.

Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
---
 drivers/cpuidle/cpuidle-powernv.c | 11 +++++++++--
 drivers/cpuidle/cpuidle-pseries.c | 11 +++++++++--
 2 files changed, 18 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index f0247652d91f..c53a8bb40471 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -59,14 +59,21 @@ static int snooze_loop(struct cpuidle_device *dev,
 	ppc64_runlatch_off();
 	HMT_very_low();
 	while (!need_resched()) {
-		if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time)
+		if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time) {
+			/*
+			 * Task has not woken up but we are exiting the polling
+			 * loop anyway. Require a barrier after polling is
+			 * cleared to order subsequent test of need_resched().
+			 */
+			clear_thread_flag(TIF_POLLING_NRFLAG);
+			smp_mb();
 			break;
+		}
 	}
 
 	HMT_medium();
 	ppc64_runlatch_on();
 	clear_thread_flag(TIF_POLLING_NRFLAG);
-	smp_mb();
 
 	return index;
 }
diff --git a/drivers/cpuidle/cpuidle-pseries.c b/drivers/cpuidle/cpuidle-pseries.c
index a404f352d284..e9b3853d93ea 100644
--- a/drivers/cpuidle/cpuidle-pseries.c
+++ b/drivers/cpuidle/cpuidle-pseries.c
@@ -71,13 +71,20 @@ static int snooze_loop(struct cpuidle_device *dev,
 	while (!need_resched()) {
 		HMT_low();
 		HMT_very_low();
-		if (snooze_timeout_en && get_tb() > snooze_exit_time)
+		if (likely(snooze_timeout_en) && get_tb() > snooze_exit_time) {
+			/*
+			 * Task has not woken up but we are exiting the polling
+			 * loop anyway. Require a barrier after polling is
+			 * cleared to order subsequent test of need_resched().
+			 */
+			clear_thread_flag(TIF_POLLING_NRFLAG);
+			smp_mb();
 			break;
+		}
 	}
 
 	HMT_medium();
 	clear_thread_flag(TIF_POLLING_NRFLAG);
-	smp_mb();
 
 	idle_loop_epilog(in_purr);
 
-- 
2.11.0
