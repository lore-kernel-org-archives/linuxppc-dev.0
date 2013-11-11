Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp09.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id ACC542C03FD
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 16:35:52 +1100 (EST)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Mon, 11 Nov 2013 15:35:50 +1000
Received: from d23relay05.au.ibm.com (d23relay05.au.ibm.com [9.190.235.152])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D8A9F3578053
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 16:35:47 +1100 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay05.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 rAB5I2cb57540854
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 16:18:02 +1100
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 rAB5ZjKT008608
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Nov 2013 16:35:46 +1100
Subject: [PATCH v8 3/7] pseries/cpuidle: Make pseries_idle backend driver a
 non-module.
To: benh@kernel.crashing.org, linux-pm@lists.linux-foundation.org,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Mon, 11 Nov 2013 11:05:30 +0530
Message-ID: <20131111053528.14797.88417.stgit@deepthi.in.ibm.com>
In-Reply-To: <20131111053450.14797.75544.stgit@deepthi.in.ibm.com>
References: <20131111053450.14797.75544.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: b.zolnierkie@samsung.com, daniel.lezcano@linaro.org,
 dongsheng.wang@freescale.com, preeti@linux.vnet.ibm.com,
 srivatsa.bhat@linux.vnet.ibm.com, scottwood@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently pseries_idle cpuidle backend driver cannot be
built as a module due to dependencies. Therefore the driver has
to be built in. The dependency is around update_snooze_delay() defined
in cpuidle driver and called from kernel/sysfs.c.
This patch is removes all the module related code.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Acked-by: Daniel Lezcano <daniel.lezcano@linaro.org>
---
 drivers/cpuidle/cpuidle-powerpc-book3s.c |   15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-powerpc-book3s.c b/drivers/cpuidle/cpuidle-powerpc-book3s.c
index 51f6cda..82c9e15 100644
--- a/drivers/cpuidle/cpuidle-powerpc-book3s.c
+++ b/drivers/cpuidle/cpuidle-powerpc-book3s.c
@@ -292,17 +292,4 @@ static int __init pseries_processor_idle_init(void)
 	return 0;
 }
 
-static void __exit pseries_processor_idle_exit(void)
-{
-
-	unregister_cpu_notifier(&setup_hotplug_notifier);
-	cpuidle_unregister(&pseries_idle_driver);
-	return;
-}
-
-module_init(pseries_processor_idle_init);
-module_exit(pseries_processor_idle_exit);
-
-MODULE_AUTHOR("Deepthi Dharwar <deepthi@linux.vnet.ibm.com>");
-MODULE_DESCRIPTION("Cpuidle driver for POWER");
-MODULE_LICENSE("GPL");
+device_initcall(pseries_processor_idle_init);
