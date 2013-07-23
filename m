Return-Path: <deepthi@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EFCEF2C00FE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 19:03:58 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <deepthi@linux.vnet.ibm.com>;
 Tue, 23 Jul 2013 14:26:50 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 0DA20E0056
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 14:33:53 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r6N94kGq38273136
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 14:34:46 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r6N93mk4018267
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 23 Jul 2013 09:03:49 GMT
Subject: [PATCH 3/3] cpuidle/powernv: Support smt-snooze-delay parameter in
 powernv idle.
To: linuxppc-dev@lists.ozlabs.org
From: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
Date: Tue, 23 Jul 2013 14:32:44 +0530
Message-ID: <20130723090239.7291.59177.stgit@deepthi.in.ibm.com>
In-Reply-To: <20130723090111.7291.99479.stgit@deepthi.in.ibm.com>
References: <20130723090111.7291.99479.stgit@deepthi.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Cc: linux-pm@lists.linux-foundation.org, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

smt-snooze-delay is a tunable that is supported on
powerpc platform to delay the entry to nap state.
This can be set either via sysfs, kernel commandline
or pp64_cpu util.

Signed-off-by: Deepthi Dharwar <deepthi@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/processor.h            |    2 +
 arch/powerpc/platforms/powernv/powernv.h        |    3 ++
 arch/powerpc/platforms/powernv/processor_idle.c |   36 +++++++++++++++++++++++
 3 files changed, 40 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
index 47a35b0..5700c3c 100644
--- a/arch/powerpc/include/asm/processor.h
+++ b/arch/powerpc/include/asm/processor.h
@@ -426,7 +426,7 @@ enum idle_boot_override {IDLE_NO_OVERRIDE = 0, IDLE_POWERSAVE_OFF};
 extern int powersave_nap;	/* set if nap mode can be used in idle loop */
 extern void power7_nap(void);
 
-#ifdef CONFIG_PSERIES_IDLE
+#if defined(CONFIG_PSERIES_IDLE) || defined(CONFIG_POWERNV_IDLE)
 extern void update_smt_snooze_delay(int cpu, int residency);
 #else
 static inline void update_smt_snooze_delay(int cpu, int residency) {}
diff --git a/arch/powerpc/platforms/powernv/powernv.h b/arch/powerpc/platforms/powernv/powernv.h
index a1c6f83..558ee69 100644
--- a/arch/powerpc/platforms/powernv/powernv.h
+++ b/arch/powerpc/platforms/powernv/powernv.h
@@ -15,4 +15,7 @@ static inline void pnv_pci_init(void) { }
 static inline void pnv_pci_shutdown(void) { }
 #endif
 
+/* Idle variable */
+DECLARE_PER_CPU(long, smt_snooze_delay);
+
 #endif /* _POWERNV_H */
diff --git a/arch/powerpc/platforms/powernv/processor_idle.c b/arch/powerpc/platforms/powernv/processor_idle.c
index f43ad91a..505fea4 100644
--- a/arch/powerpc/platforms/powernv/processor_idle.c
+++ b/arch/powerpc/platforms/powernv/processor_idle.c
@@ -13,6 +13,8 @@
 #include <asm/machdep.h>
 #include <asm/runlatch.h>
 
+#include "powernv.h"
+
 struct cpuidle_driver powernv_idle_driver = {
 	.name =		"powernv_idle",
 	.owner =	THIS_MODULE,
@@ -193,6 +195,38 @@ static int powernv_idle_probe(void)
 	return 0;
 }
 
+void update_smt_snooze_delay(int cpu, int residency)
+{
+	struct cpuidle_driver *drv = cpuidle_get_driver();
+	struct cpuidle_device *dev;
+
+	if (!drv)
+		return;
+
+	if (cpu == -1) {
+		if (residency < 0) {
+			/* Disable NAP on all cpus */
+			drv->states[1].disabled = true;
+		} else {
+			drv->states[1].target_residency = residency;
+			drv->states[1].disabled = false;
+		}
+		return;
+	}
+
+	dev = per_cpu(cpuidle_devices, cpu);
+	if (!dev)
+		return;
+
+	if (residency < 0)
+		dev->states_usage[1].disable = 1;
+	else {
+		drv->states[1].target_residency = residency;
+		drv->states[1].disabled = false;
+		dev->states_usage[1].disable = 0;
+	}
+}
+
 static int __init powernv_processor_idle_init(void)
 {
 	int retval;
@@ -208,6 +242,8 @@ static int __init powernv_processor_idle_init(void)
 		return retval;
 	}
 
+	update_smt_snooze_delay(-1, per_cpu(smt_snooze_delay, 0));
+
 	retval = powernv_idle_devices_init();
 	if (retval) {
 		powernv_idle_devices_uninit();
