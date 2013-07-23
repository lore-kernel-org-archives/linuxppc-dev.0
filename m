Return-Path: <B40534@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe003.messaging.microsoft.com [216.32.180.186])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D3A232C0096
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 20:19:40 +1000 (EST)
From: Dongsheng Wang <dongsheng.wang@freescale.com>
To: <daniel.lezcano@linaro.org>
Subject: [PATCH 1/2] cpuidle: fix cpu idle driver as a module can not remove
Date: Tue, 23 Jul 2013 17:28:00 +0800
Message-ID: <1374571681-31911-1-git-send-email-dongsheng.wang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: rjw@sisk.pl, linuxppc-dev@lists.ozlabs.org,
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

The module can not be removed when execute "rmmod". rmmod not use
"--force".

Log:
root:~# rmmod cpuidle-e500
incs[9], decs[1]
rmmod: can't unload 'cpuidle_e500': Resource temporarily unavailable

Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
---
Branch: pm-cpuidle

 drivers/cpuidle/cpuidle.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index fdc432f..534320a 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -386,6 +386,9 @@ static int __cpuidle_register_device(struct cpuidle_device *dev)
 		goto err_coupled;
 
 	dev->registered = 1;
+
+	module_put(drv->owner);
+
 	return 0;
 
 err_coupled:
@@ -432,8 +435,6 @@ EXPORT_SYMBOL_GPL(cpuidle_register_device);
  */
 void cpuidle_unregister_device(struct cpuidle_device *dev)
 {
-	struct cpuidle_driver *drv = cpuidle_get_cpu_driver(dev);
-
 	if (dev->registered == 0)
 		return;
 
@@ -448,8 +449,6 @@ void cpuidle_unregister_device(struct cpuidle_device *dev)
 	cpuidle_coupled_unregister_device(dev);
 
 	cpuidle_resume_and_unlock();
-
-	module_put(drv->owner);
 }
 
 EXPORT_SYMBOL_GPL(cpuidle_unregister_device);
-- 
1.8.0
