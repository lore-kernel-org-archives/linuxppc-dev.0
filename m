Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rL6HM1vXXzDqgP
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  2 Jun 2016 22:39:27 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Thu, 2 Jun 2016 08:39:25 -0400
From: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
To: mpe@ellerman.id.au
Cc: paulus@ozlabs.org, mikey@neuling.org, ego@linux.vnet.ibm.com,
 maddy@linux.vnet.ibm.com, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org,
 "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>,
 "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
 Daniel Lezcano <daniel.lezcano@linaro.org>, linux-pm@vger.kernel.org
Subject: [PATCH v5 09/11] cpuidle/powernv: Use CPUIDLE_STATE_MAX instead of
 MAX_POWERNV_IDLE_STATES
Date: Thu,  2 Jun 2016 07:38:59 -0500
Message-Id: <1464871141-11568-10-git-send-email-shreyas@linux.vnet.ibm.com>
In-Reply-To: <1464871141-11568-1-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1464871141-11568-1-git-send-email-shreyas@linux.vnet.ibm.com>
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
