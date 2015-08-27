Return-Path: <shilpa.bhat@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1C03B1A0545
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 27 Aug 2015 19:12:00 +1000 (AEST)
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 62B811401EF
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 19:11:59 +1000 (AEST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <shilpa.bhat@linux.vnet.ibm.com>;
 Thu, 27 Aug 2015 14:41:55 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id D6366E0058
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 14:41:20 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t7R9Brrg64356370
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 14:41:54 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t7R9Br5S023892
 for <linuxppc-dev@ozlabs.org>; Thu, 27 Aug 2015 14:41:53 +0530
From: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
To: rjw@rjwysocki.net
Cc: stewart@linux.vnet.ibm.com, viresh.kumar@linaro.org,
 linuxppc-dev@ozlabs.org, linux-kernel@vger.kernel.org,
 linux-pm@vger.kernel.org, Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
Subject: [PATCH] cpufreq: powernv: Increase the verbosity of OCC console
 messages
Date: Thu, 27 Aug 2015 14:41:44 +0530
Message-Id: <1440666704-10666-1-git-send-email-shilpa.bhat@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Modify the OCC reset/load/active event message to make it clearer for
the user to understand the event and effect of the event.

Suggested-by: Stewart Smith <stewart@linux.vnet.ibm.com>
Signed-off-by: Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>
---
This patch is based on top of linux-next/master

 drivers/cpufreq/powernv-cpufreq.c | 9 +++++----
 1 file changed, 5 insertions(+), 4 deletions(-)

diff --git a/drivers/cpufreq/powernv-cpufreq.c b/drivers/cpufreq/powernv-cpufreq.c
index 546e056..64994e1 100644
--- a/drivers/cpufreq/powernv-cpufreq.c
+++ b/drivers/cpufreq/powernv-cpufreq.c
@@ -465,6 +465,7 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 	switch (omsg.type) {
 	case OCC_RESET:
 		occ_reset = true;
+		pr_info("OCC (On Chip Controller - enforces hard thermal/power limits) Resetting\n");
 		/*
 		 * powernv_cpufreq_throttle_check() is called in
 		 * target() callback which can detect the throttle state
@@ -474,12 +475,12 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 		 */
 		if (!throttled) {
 			throttled = true;
-			pr_crit("CPU Frequency is throttled\n");
+			pr_crit("CPU frequency is throttled for duration\n");
 		}
-		pr_info("OCC: Reset\n");
+
 		break;
 	case OCC_LOAD:
-		pr_info("OCC: Loaded\n");
+		pr_info("OCC Loading, CPU frequency is throttled until OCC is started\n");
 		break;
 	case OCC_THROTTLE:
 		omsg.chip = be64_to_cpu(msg->params[1]);
@@ -488,7 +489,7 @@ static int powernv_cpufreq_occ_msg(struct notifier_block *nb,
 		if (occ_reset) {
 			occ_reset = false;
 			throttled = false;
-			pr_info("OCC: Active\n");
+			pr_info("OCC Active, CPU frequency is no longer throttled\n");
 
 			for (i = 0; i < nr_chips; i++) {
 				chips[i].restore = true;
-- 
1.9.3
