Return-Path: <B32736@freescale.com>
Received: from TX2EHSOBE003.bigfish.com (tx2ehsobe002.messaging.microsoft.com
 [65.55.88.12]) (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 788C6B6F13
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 Feb 2012 17:51:07 +1100 (EST)
From: Zhicheng Fan <B32736@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <galak@kernel.crashing.org>
Subject: [PATCH 1/2 v5] powerpc/85xx: Add p1020rdb-pc platform support
Date: Fri, 10 Feb 2012 14:48:15 +0800
Message-ID: <1328856496-2873-1-git-send-email-B32736@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhicheng Fan <b32736@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Zhicheng Fan <b32736@freescale.com>

Signed-off-by: Zhicheng Fan <b32736@freescale.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   24 +++++++++++++++++++++++-
 1 files changed, 23 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index ccf520e..d54772e 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -1,7 +1,7 @@
 /*
  * MPC85xx RDB Board Setup
  *
- * Copyright 2009 Freescale Semiconductor Inc.
+ * Copyright 2009,2012 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -90,10 +90,18 @@ static void __init mpc85xx_rdb_setup_arch(void)
 
 machine_device_initcall(p2020_rdb, mpc85xx_common_publish_devices);
 machine_device_initcall(p1020_rdb, mpc85xx_common_publish_devices);
+machine_device_initcall(p1020_rdb_pc, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
  */
+static int __init p1020_rdb_pc_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "fsl,P1020RDB-PC");
+}
+
 static int __init p2020_rdb_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
@@ -139,3 +147,17 @@ define_machine(p1020_rdb) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
+
+define_machine(p1020_rdb_pc) {
+	.name			= "P1020RDB-PC",
+	.probe			= p1020_rdb_pc_probe,
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
