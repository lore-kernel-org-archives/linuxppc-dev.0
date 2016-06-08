Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPvgl053SzDqJV
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 02:55:14 +1000 (AEST)
Received: from pps.filterd (m0048827.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u58GsVp1013006
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 8 Jun 2016 12:55:13 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23e9mdwp72-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 08 Jun 2016 12:55:12 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 10:55:11 -0600
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: benh@au1.ibm.com, paulus@ozlabs.org, mikey@neuling.org,
 ego@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v6 09/11] cpuidle/powernv: Use CPUIDLE_STATE_MAX instead of
 MAX_POWERNV_IDLE_STATES
Date: Wed,  8 Jun 2016 11:54:29 -0500
In-Reply-To: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1465404871-5406-1-git-send-email-shreyas@linux.vnet.ibm.com>
Message-Id: <1465404871-5406-10-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Use cpuidle's CPUIDLE_STATE_MAX macro instead of powernv specific
MAX_POWERNV_IDLE_STATES.

Cc: Rafael J. Wysocki <rafael.j.wysocki@intel.com>
Cc: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: linux-pm@vger.kernel.org
Suggested-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
---
 - No changes after v5

Changes in v5
=============
 - New in v5

 drivers/cpuidle/cpuidle-powernv.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index e12dc30..3a763a8 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -20,8 +20,6 @@
 #include <asm/opal.h>
 #include <asm/runlatch.h>
 
-#define MAX_POWERNV_IDLE_STATES	8
-
 struct cpuidle_driver powernv_idle_driver = {
 	.name             = "powernv_idle",
 	.owner            = THIS_MODULE,
@@ -96,7 +94,7 @@ static int fastsleep_loop(struct cpuidle_device *dev,
 /*
  * States for dedicated partition case.
  */
-static struct cpuidle_state powernv_states[MAX_POWERNV_IDLE_STATES] = {
+static struct cpuidle_state powernv_states[CPUIDLE_STATE_MAX] = {
 	{ /* Snooze */
 		.name = "snooze",
 		.desc = "snooze",
-- 
2.1.4
