Return-Path: <B37781@freescale.com>
Received: from AM1EHSOBE006.bigfish.com (am1ehsobe006.messaging.microsoft.com
 [213.199.154.209])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 017F71007D2
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 17 Jan 2012 18:59:23 +1100 (EST)
From: Xu Jiucheng <B37781@freescale.com>
To: <galak@kernel.crashing.org>, <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2 v3] powerpc/85xx: Added P1021RDB-PC Platform support
Date: Tue, 17 Jan 2012 16:01:30 +0800
Message-ID: <1326787291-8922-2-git-send-email-B37781@freescale.com>
In-Reply-To: <1326787291-8922-1-git-send-email-B37781@freescale.com>
References: <1326787291-8922-1-git-send-email-B37781@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Xu Jiucheng <B37781@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Xu Jiucheng <B37781@freescale.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index ccf520e..1273381 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -90,6 +90,7 @@ static void __init mpc85xx_rdb_setup_arch(void)
 
 machine_device_initcall(p2020_rdb, mpc85xx_common_publish_devices);
 machine_device_initcall(p1020_rdb, mpc85xx_common_publish_devices);
+machine_device_initcall(p1021_rdb_pc, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -112,6 +113,15 @@ static int __init p1020_rdb_probe(void)
 	return 0;
 }
 
+static int __init p1021_rdb_pc_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "fsl,P1021RDB-PC"))
+		return 1;
+	return 0;
+}
+
 define_machine(p2020_rdb) {
 	.name			= "P2020 RDB",
 	.probe			= p2020_rdb_probe,
@@ -139,3 +149,17 @@ define_machine(p1020_rdb) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
+
+define_machine(p1021_rdb_pc) {
+	.name			= "P1021 RDB-PC",
+	.probe			= p1021_rdb_pc_probe,
+	.setup_arch		= mpc85xx_rdb_setup_arch,
+	.init_IRQ		= mpc85xx_rdb_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
+};
-- 
1.6.4
