Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5E13B1A1782
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  1 Oct 2014 23:28:22 +1000 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 16/20] powerpc/powermac: Use pm_power_off rather than
 ppc_md.power_off
Date: Wed,  1 Oct 2014 15:28:02 +0200
Message-Id: <1412170086-57971-17-git-send-email-agraf@suse.de>
In-Reply-To: <1412170086-57971-1-git-send-email-agraf@suse.de>
References: <1412170086-57971-1-git-send-email-agraf@suse.de>
Cc: Arnd Bergmann <arnd@arndb.de>, Geoff Levand <geoff@infradead.org>,
 Alistair Popple <alistair@popple.id.au>, Scott Wood <scottwood@freescale.com>,
 Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

The generic power off callback is pm_power_off. Use that one rather than
the powerpc specific ppc_md.power_off.

Signed-off-by: Alexander Graf <agraf@suse.de>
---
 arch/powerpc/platforms/powermac/setup.c | 147 ++++++++++++++++----------------
 1 file changed, 74 insertions(+), 73 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index 141f8899..d3b0a87 100644
--- a/arch/powerpc/platforms/powermac/setup.c
+++ b/arch/powerpc/platforms/powermac/setup.c
@@ -274,6 +274,78 @@ static void __init l2cr_init(void)
 }
 #endif
 
+#ifdef CONFIG_ADB_CUDA
+static void cuda_restart(void)
+{
+	struct adb_request req;
+
+	cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_RESET_SYSTEM);
+	for (;;)
+		cuda_poll();
+}
+
+static void cuda_shutdown(void)
+{
+	struct adb_request req;
+
+	cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_POWERDOWN);
+	for (;;)
+		cuda_poll();
+}
+
+#else
+#define cuda_restart()
+#define cuda_shutdown()
+#endif
+
+#ifndef CONFIG_ADB_PMU
+#define pmu_restart()
+#define pmu_shutdown()
+#endif
+
+#ifndef CONFIG_PMAC_SMU
+#define smu_restart()
+#define smu_shutdown()
+#endif
+
+static void pmac_restart(char *cmd)
+{
+	switch (sys_ctrler) {
+	case SYS_CTRLER_CUDA:
+		cuda_restart();
+		break;
+	case SYS_CTRLER_PMU:
+		pmu_restart();
+		break;
+	case SYS_CTRLER_SMU:
+		smu_restart();
+		break;
+	default: ;
+	}
+}
+
+static void pmac_power_off(void)
+{
+	switch (sys_ctrler) {
+	case SYS_CTRLER_CUDA:
+		cuda_shutdown();
+		break;
+	case SYS_CTRLER_PMU:
+		pmu_shutdown();
+		break;
+	case SYS_CTRLER_SMU:
+		smu_shutdown();
+		break;
+	default: ;
+	}
+}
+
+static void
+pmac_halt(void)
+{
+	pmac_power_off();
+}
+
 static void __init pmac_setup_arch(void)
 {
 	struct device_node *cpu, *ic;
@@ -341,6 +413,8 @@ static void __init pmac_setup_arch(void)
 		__adb_probe_sync = 1;
 	}
 #endif /* CONFIG_ADB */
+
+	pm_power_off = pmac_power_off;
 }
 
 #ifdef CONFIG_SCSI
@@ -382,78 +456,6 @@ void __init_refok note_bootable_part(dev_t dev, int part, int goodness)
 	current_root_goodness = goodness;
 }
 
-#ifdef CONFIG_ADB_CUDA
-static void cuda_restart(void)
-{
-	struct adb_request req;
-
-	cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_RESET_SYSTEM);
-	for (;;)
-		cuda_poll();
-}
-
-static void cuda_shutdown(void)
-{
-	struct adb_request req;
-
-	cuda_request(&req, NULL, 2, CUDA_PACKET, CUDA_POWERDOWN);
-	for (;;)
-		cuda_poll();
-}
-
-#else
-#define cuda_restart()
-#define cuda_shutdown()
-#endif
-
-#ifndef CONFIG_ADB_PMU
-#define pmu_restart()
-#define pmu_shutdown()
-#endif
-
-#ifndef CONFIG_PMAC_SMU
-#define smu_restart()
-#define smu_shutdown()
-#endif
-
-static void pmac_restart(char *cmd)
-{
-	switch (sys_ctrler) {
-	case SYS_CTRLER_CUDA:
-		cuda_restart();
-		break;
-	case SYS_CTRLER_PMU:
-		pmu_restart();
-		break;
-	case SYS_CTRLER_SMU:
-		smu_restart();
-		break;
-	default: ;
-	}
-}
-
-static void pmac_power_off(void)
-{
-	switch (sys_ctrler) {
-	case SYS_CTRLER_CUDA:
-		cuda_shutdown();
-		break;
-	case SYS_CTRLER_PMU:
-		pmu_shutdown();
-		break;
-	case SYS_CTRLER_SMU:
-		smu_shutdown();
-		break;
-	default: ;
-	}
-}
-
-static void
-pmac_halt(void)
-{
-	pmac_power_off();
-}
-
 /* 
  * Early initialization.
  */
@@ -663,7 +665,6 @@ define_machine(powermac) {
 	.get_irq		= NULL,	/* changed later */
 	.pci_irq_fixup		= pmac_pci_irq_fixup,
 	.restart		= pmac_restart,
-	.power_off		= pmac_power_off,
 	.halt			= pmac_halt,
 	.time_init		= pmac_time_init,
 	.get_boot_time		= pmac_get_boot_time,
-- 
1.8.1.4
