Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 4A1BE2C0365
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 22:02:01 +1100 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 29 Oct 2013 16:31:57 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 5C832394005E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 16:31:32 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9TB1puR37945530
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 16:31:51 +0530
Received: from d28av03.in.ibm.com (localhost [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9TB1qp2027773
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Oct 2013 16:31:53 +0530
Subject: [PATCH V7 3/7] pseries/cpuidle: Make pseries_idle backend driver a
 non-module.
To: benh@kernel.crashing.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Tue, 29 Oct 2013 16:31:36 +0530
Message-ID: <20131029110134.31547.86550.stgit@deepthi.in.ibm.com>
In-Reply-To: <20131029110052.31547.82682.stgit@deepthi.in.ibm.com>
References: <20131029110052.31547.82682.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: daniel.lezcano@linaro.org, preeti@linux.vnet.ibm.com,
 srivatsa.bhat@linux.vnet.ibm.com, scottwood@freescale.com,
 linux-pm@lists.linux-foundation.org
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
---
 drivers/cpuidle/cpuidle-ibm-power.c |   15 +--------------
 1 file changed, 1 insertion(+), 14 deletions(-)

diff --git a/drivers/cpuidle/cpuidle-ibm-power.c b/drivers/cpuidle/cpuidle-ibm-power.c
index faf8cc1..8c9e42c 100644
--- a/drivers/cpuidle/cpuidle-ibm-power.c
+++ b/drivers/cpuidle/cpuidle-ibm-power.c
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
