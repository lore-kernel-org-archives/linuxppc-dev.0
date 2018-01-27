Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zTXlL5vy6zDqry
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 28 Jan 2018 10:57:50 +1100 (AEDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Geert Uytterhoeven <geert@linux-m68k.org>, linux-m68k@lists.linux-m68k.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH] macintosh/via-pmu68k: Initialize PMU driver with setup_arch
 and arch_initcall
Message-Id: <20180127235140.EA71C296D4@kvm5.telegraphics.com.au>
Date: Sat, 27 Jan 2018 18:51:40 -0500 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The PMU watchdog will power down the system if the kernel is slow
to start up, e.g. due to unpacking a large initrd. The powerpc
version of this driver (via-pmu.c) has a solution for the same
problem. It uses this call sequence:

setup_arch
	find_via_pmu
		init_pmu
...
arch_initcall
	via_pmu_start

Bring via-pmu68k.c into line with via-pmu.c to fix this issue.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/mac/config.c         |  4 ++
 drivers/macintosh/via-pmu68k.c | 89 +++++++++++++++++++++++++++++-------------
 2 files changed, 65 insertions(+), 28 deletions(-)

diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 95d548d8cc8a..17d9380aa7e6 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -26,6 +26,7 @@
 #include <linux/platform_device.h>
 #include <linux/adb.h>
 #include <linux/cuda.h>
+#include <linux/pmu.h>
 #include <linux/rtc.h>
 
 #include <asm/setup.h>
@@ -906,6 +907,9 @@ static void __init mac_identify(void)
 #ifdef CONFIG_ADB_CUDA
 	find_via_cuda();
 #endif
+#ifdef CONFIG_ADB_PMU68K
+	find_via_pmu();
+#endif
 }
 
 static void __init mac_report_hardware(void)
diff --git a/drivers/macintosh/via-pmu68k.c b/drivers/macintosh/via-pmu68k.c
index 25465fb91ec9..7d9c4baf8c11 100644
--- a/drivers/macintosh/via-pmu68k.c
+++ b/drivers/macintosh/via-pmu68k.c
@@ -109,6 +109,7 @@ static int pmu_autopoll(int devs);
 void pmu_poll(void);
 static int pmu_reset_bus(void);
 
+static int init_pmu(void);
 static void pmu_start(void);
 static void send_byte(int x);
 static void recv_byte(void);
@@ -171,23 +172,76 @@ static s8 pmu_data_len[256][2] = {
 /*f8*/	{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},
 };
 
-int pmu_probe(void)
+int __init find_via_pmu(void)
 {
-	if (macintosh_config->adb_type == MAC_ADB_PB1) {
+	switch (macintosh_config->adb_type) {
+	case MAC_ADB_PB1:
 		pmu_kind = PMU_68K_V1;
-	} else if (macintosh_config->adb_type == MAC_ADB_PB2) {
+		break;
+	case MAC_ADB_PB2:
 		pmu_kind = PMU_68K_V2;
-	} else {
+		break;
+	default:
+		pmu_kind = PMU_UNKNOWN;
 		return -ENODEV;
 	}
 
 	pmu_state = idle;
 
+	if (!init_pmu())
+		goto fail_init;
+
+	pr_info("adb: PMU 68K driver v0.5 for Unified ADB\n");
+
+	return 1;
+
+fail_init:
+	pmu_kind = PMU_UNKNOWN;
 	return 0;
 }
 
-static int 
-pmu_init(void)
+static int pmu_probe(void)
+{
+	if (pmu_kind == PMU_UNKNOWN)
+		return -ENODEV;
+	return 0;
+}
+
+static int pmu_init(void)
+{
+	if (pmu_kind == PMU_UNKNOWN)
+		return -ENODEV;
+	return 0;
+}
+
+static int __init via_pmu_start(void)
+{
+	if (pmu_kind == PMU_UNKNOWN)
+		return -ENODEV;
+
+	if (request_irq(IRQ_MAC_ADB_SR, pmu_interrupt, 0, "PMU_SR",
+			pmu_interrupt)) {
+		pr_err("%s: can't get SR irq\n", __func__);
+		return -ENODEV;
+	}
+	if (request_irq(IRQ_MAC_ADB_CL, pmu_interrupt, 0, "PMU_CL",
+			pmu_interrupt)) {
+		pr_err("%s: can't get CL irq\n", __func__);
+		free_irq(IRQ_MAC_ADB_SR, pmu_interrupt);
+		return -ENODEV;
+	}
+
+	pmu_fully_inited = 1;
+
+	/* Enable backlight */
+	pmu_enable_backlight(1);
+
+	return 0;
+}
+
+arch_initcall(via_pmu_start);
+
+static int __init init_pmu(void)
 {
 	int timeout;
 	volatile struct adb_request req;
@@ -238,28 +292,7 @@ pmu_init(void)
 	bright_req_2.complete = 1;
 	bright_req_3.complete = 1;
 
-	if (request_irq(IRQ_MAC_ADB_SR, pmu_interrupt, 0, "pmu-shift",
-			pmu_interrupt)) {
-		printk(KERN_ERR "pmu_init: can't get irq %d\n",
-			IRQ_MAC_ADB_SR);
-		return -EAGAIN;
-	}
-	if (request_irq(IRQ_MAC_ADB_CL, pmu_interrupt, 0, "pmu-clock",
-			pmu_interrupt)) {
-		printk(KERN_ERR "pmu_init: can't get irq %d\n",
-			IRQ_MAC_ADB_CL);
-		free_irq(IRQ_MAC_ADB_SR, pmu_interrupt);
-		return -EAGAIN;
-	}
-
-	pmu_fully_inited = 1;
-	
-	/* Enable backlight */
-	pmu_enable_backlight(1);
-
-	printk("adb: PMU 68K driver v0.5 for Unified ADB.\n");
-
-	return 0;
+	return 1;
 }
 
 int
-- 
2.13.6
