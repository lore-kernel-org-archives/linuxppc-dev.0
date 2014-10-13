Return-Path: <agraf@suse.de>
Received: from mx2.suse.de (cantor2.suse.de [195.135.220.15])
 (using TLSv1 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 1422A1A06EC
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Oct 2014 01:01:40 +1100 (EST)
From: Alexander Graf <agraf@suse.de>
To: linuxppc-dev@lists.ozlabs.org
Subject: [PATCH v2 16/20] powerpc/powermac: Use pm_power_off rather than
 ppc_md.power_off
Date: Mon, 13 Oct 2014 16:01:24 +0200
Message-Id: <1413208888-49211-17-git-send-email-agraf@suse.de>
In-Reply-To: <1413208888-49211-1-git-send-email-agraf@suse.de>
References: <1413208888-49211-1-git-send-email-agraf@suse.de>
Cc: arnd@arndb.de, geoff@infradead.org, alistair@popple.id.au,
 scottwood@freescale.com, agust@denx.de, linux@roeck-us.net
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

v1 -> v2:

  - write pm_power_off in probe function
---
 arch/powerpc/platforms/powermac/setup.c | 147 ++++++++++++++++----------------
 1 file changed, 74 insertions(+), 73 deletions(-)

diff --git a/arch/powerpc/platforms/powermac/setup.c b/arch/powerpc/platforms/powermac/setup.c
index b127a29..1b03bc1 100644
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
@@ -382,78 +454,6 @@ void __init_refok note_bootable_part(dev_t dev, int part, int goodness)
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
@@ -632,6 +632,8 @@ static int __init pmac_probe(void)
 	smu_cmdbuf_abs = memblock_alloc_base(4096, 4096, 0x80000000UL);
 #endif /* CONFIG_PMAC_SMU */
 
+	pm_power_off = pmac_power_off;
+
 	return 1;
 }
 
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
