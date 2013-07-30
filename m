Return-Path: <B40534@freescale.com>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe003.messaging.microsoft.com [216.32.181.183])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9A9612C00A7
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 Jul 2013 17:47:52 +1000 (EST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <rjw@sisk.pl>, <daniel.lezcano@linaro.org>
Subject: [PATCH] cpuidle: fix unremovable issue for module driver
Date: Tue, 30 Jul 2013 14:55:19 +0800
Message-ID: <1375167319-12821-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linuxppc-dev@lists.ozlabs.org,
 Wang Dongsheng <dongsheng.wang@freescale.com>, linux-pm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Wang Dongsheng <dongsheng.wang@freescale.com>

After __cpuidle_register_device, the cpu incs are added up, but decs
are not, thus the module refcount is not match. So the module "exit"
function can not be executed when we do remove operation. Move
module_put into __cpuidle_register_device to fix it.

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index d75040d..e964ada 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -351,11 +351,8 @@ EXPORT_SYMBOL_GPL(cpuidle_disable_device);
 
 static void __cpuidle_unregister_device(struct cpuidle_device *dev)
 {
-	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
-
 	list_del(&dev->device_list);
 	per_cpu(cpuidle_devices, dev->cpu) = NULL;
-	module_put(drv->owner);
 }
 
 static int __cpuidle_device_init(struct cpuidle_device *dev)
@@ -384,6 +381,8 @@ static int __cpuidle_register_device(struct cpuidle_device *dev)
 	per_cpu(cpuidle_devices, dev->cpu) = dev;
 	list_add(&dev->device_list, &cpuidle_detected_devices);
 
+	module_put(drv->owner);
+
 	ret = cpuidle_coupled_register_device(dev);
 	if (ret) {
 		__cpuidle_unregister_device(dev);
-- 
1.8.0
