Return-Path: <b.zolnierkie@samsung.com>
Received: from mailout3.samsung.com (mailout3.samsung.com [203.254.224.33])
 (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 07A212C0331
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Dec 2013 05:58:24 +1100 (EST)
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout3.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MY4003IBC8LQJC0@mailout3.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Sat, 21 Dec 2013 03:48:21 +0900 (KST)
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: rjw@rjwysocki.net
Subject: [PATCH v2 7/9] intel_idle: remove superfluous dev->state_count
 initialization
Date: Fri, 20 Dec 2013 19:47:29 +0100
Message-id: <1387565251-7051-8-git-send-email-b.zolnierkie@samsung.com>
In-reply-to: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
References: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
Cc: linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
 b.zolnierkie@samsung.com, daniel.lezcano@linaro.org,
 linux-kernel@vger.kernel.org, kyungmin.park@samsung.com,
 linuxppc-dev@lists.ozlabs.org, lenb@kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

intel_idle driver sets dev->state_count to drv->state_count so
the default dev->state_count initialization in cpuidle_enable_device()
(called from cpuidle_register_device()) can be used instead.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Cc: Len Brown <lenb@kernel.org>
---
 drivers/idle/intel_idle.c | 29 -----------------------------
 1 file changed, 29 deletions(-)

diff --git a/drivers/idle/intel_idle.c b/drivers/idle/intel_idle.c
index 38da3fb..524d07b 100644
--- a/drivers/idle/intel_idle.c
+++ b/drivers/idle/intel_idle.c
@@ -639,39 +639,10 @@ static int __init intel_idle_cpuidle_driver_init(void)
  */
 static int intel_idle_cpu_init(int cpu)
 {
-	int cstate;
 	struct cpuidle_device *dev;
 
 	dev = per_cpu_ptr(intel_idle_cpuidle_devices, cpu);
 
-	dev->state_count = 1;
-
-	for (cstate = 0; cstate < CPUIDLE_STATE_MAX; ++cstate) {
-		int num_substates, mwait_hint, mwait_cstate, mwait_substate;
-
-		if (cpuidle_state_table[cstate].enter == NULL)
-			break;
-
-		if (cstate + 1 > max_cstate) {
-			printk(PREFIX "max_cstate %d reached\n", max_cstate);
-			break;
-		}
-
-		mwait_hint = flg2MWAIT(cpuidle_state_table[cstate].flags);
-		mwait_cstate = MWAIT_HINT2CSTATE(mwait_hint);
-		mwait_substate = MWAIT_HINT2SUBSTATE(mwait_hint);
-
-		/* does the state exist in CPUID.MWAIT? */
-		num_substates = (mwait_substates >> ((mwait_cstate + 1) * 4))
-					& MWAIT_SUBSTATE_MASK;
-
-		/* if sub-state in table is not enumerated by CPUID */
-		if ((mwait_substate + 1) > num_substates)
-			continue;
-
-		dev->state_count += 1;
-	}
-
 	dev->cpu = cpu;
 
 	if (cpuidle_register_device(dev)) {
-- 
1.8.2.3
