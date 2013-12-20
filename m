Return-Path: <b.zolnierkie@samsung.com>
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
 (using TLSv1 with cipher RC4-MD5 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5CB162C033A
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 21 Dec 2013 05:58:05 +1100 (EST)
Received: from epcpsbgm2.samsung.com (epcpsbgm2 [203.254.230.27])
 by mailout2.samsung.com
 (Oracle Communications Messaging Server 7u4-24.01(7.0.4.24.0) 64bit (built Nov
 17 2011)) with ESMTP id <0MY4004U3C820O00@mailout2.samsung.com> for
 linuxppc-dev@lists.ozlabs.org; Sat, 21 Dec 2013 03:48:02 +0900 (KST)
From: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
To: rjw@rjwysocki.net
Subject: [PATCH v2 2/9] POWERPC: pseries: cpuidle: remove superfluous
 dev->state_count initialization
Date: Fri, 20 Dec 2013 19:47:24 +0100
Message-id: <1387565251-7051-3-git-send-email-b.zolnierkie@samsung.com>
In-reply-to: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
References: <1387565251-7051-1-git-send-email-b.zolnierkie@samsung.com>
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>,
 linux-samsung-soc@vger.kernel.org, linux-pm@vger.kernel.org,
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

pseries cpuidle driver sets dev->state_count to drv->state_count so
the default dev->state_count initialization in cpuidle_enable_device()
(called from cpuidle_register_device()) can be used instead.

Signed-off-by: Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>
Signed-off-by: Kyungmin Park <kyungmin.park@samsung.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
Cc: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 arch/powerpc/platforms/pseries/processor_idle.c | 2 --
 1 file changed, 2 deletions(-)

diff --git a/arch/powerpc/platforms/pseries/processor_idle.c b/arch/powerpc/platforms/pseries/processor_idle.c
index a166e38..8aa8c40 100644
--- a/arch/powerpc/platforms/pseries/processor_idle.c
+++ b/arch/powerpc/platforms/pseries/processor_idle.c
@@ -271,7 +271,6 @@ static void pseries_idle_devices_uninit(void)
 static int pseries_idle_devices_init(void)
 {
 	int i;
-	struct cpuidle_driver *drv = &pseries_idle_driver;
 	struct cpuidle_device *dev;
 
 	pseries_cpuidle_devices = alloc_percpu(struct cpuidle_device);
@@ -280,7 +279,6 @@ static int pseries_idle_devices_init(void)
 
 	for_each_possible_cpu(i) {
 		dev = per_cpu_ptr(pseries_cpuidle_devices, i);
-		dev->state_count = drv->state_count;
 		dev->cpu = i;
 		if (cpuidle_register_device(dev)) {
 			printk(KERN_DEBUG \
-- 
1.8.2.3
