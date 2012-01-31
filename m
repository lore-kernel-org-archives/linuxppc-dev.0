Return-Path: <B32736@freescale.com>
Received: from DB3EHSOBE001.bigfish.com (db3ehsobe001.messaging.microsoft.com
 [213.199.154.139])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 9FF6EB6EFE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 31 Jan 2012 20:52:11 +1100 (EST)
From: Zhicheng Fan <B32736@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH 2/2 v2] P1025RDB: Add p1025rdb platform support
Date: Tue, 31 Jan 2012 17:51:21 +0800
Message-ID: <1328003481-31821-2-git-send-email-B32736@freescale.com>
In-Reply-To: <1328003481-31821-1-git-send-email-B32736@freescale.com>
References: <1328003481-31821-1-git-send-email-B32736@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhicheng Fan <b32736@freeescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Zhicheng Fan <b32736@freeescale.com>

Signed-off-by: Zhicheng Fan <b32736@freeescale.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 0d3d7c6..3381a80 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -91,6 +91,7 @@ static void __init mpc85xx_rdb_setup_arch(void)
 machine_device_initcall(p2020_rdb, mpc85xx_common_publish_devices);
 machine_device_initcall(p1020_rdb, mpc85xx_common_publish_devices);
 machine_device_initcall(p1020_rdb_pc, mpc85xx_common_publish_devices);
+machine_device_initcall(p1025_rdb, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -122,6 +123,15 @@ static int __init p1020_rdb_probe(void)
 	return 0;
 }
 
+static int __init p1025_rdb_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "fsl,P1025RDB"))
+		return 1;
+	return 0;
+}
+
 define_machine(p2020_rdb) {
 	.name			= "P2020 RDB",
 	.probe			= p2020_rdb_probe,
@@ -163,3 +173,17 @@ define_machine(p1020_rdb_pc) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
+
+define_machine(p1025_rdb) {
+	.name			= "P1025 RDB",
+	.probe			= p1025_rdb_probe,
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
1.7.0.4
