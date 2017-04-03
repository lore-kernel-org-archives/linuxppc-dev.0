Return-Path: <anton@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vxm923n0CzDqHg
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  4 Apr 2017 07:54:30 +1000 (AEST)
From: Anton Blanchard <anton@ozlabs.org>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 svaidy@linux.vnet.ibm.com, ego@linux.vnet.ibm.com, rjw@rjwysocki.net,
 daniel.lezcano@linaro.org, npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org,
	linux-pm@vger.kernel.org
Subject: [PATCH 2/3] cpuidle: powernv: Don't continually set thread priority
 in snooze_loop()
Date: Tue,  4 Apr 2017 07:54:13 +1000
Message-Id: <20170403215414.16951-2-anton@ozlabs.org>
In-Reply-To: <20170403215414.16951-1-anton@ozlabs.org>
References: <20170403215414.16951-1-anton@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Anton Blanchard <anton@samba.org>

The powerpc64 kernel exception handlers have preserved thread priorities
for a long time now, so there is no need to continually set it.

Just set it once on entry and once exit.

Signed-off-by: Anton Blanchard <anton@samba.org>
---
 drivers/cpuidle/cpuidle-powernv.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/cpuidle/cpuidle-powernv.c b/drivers/cpuidle/cpuidle-powernv.c
index 9d9f164894eb..8c991c254b95 100644
--- a/drivers/cpuidle/cpuidle-powernv.c
+++ b/drivers/cpuidle/cpuidle-powernv.c
@@ -56,8 +56,8 @@ static int snooze_loop(struct cpuidle_device *dev,
 
 	snooze_exit_time = get_tb() + snooze_timeout;
 	ppc64_runlatch_off();
+	HMT_very_low();
 	while (!need_resched()) {
-		HMT_very_low();
 		if (snooze_timeout_en && get_tb() > snooze_exit_time)
 			break;
 	}
-- 
2.11.0
