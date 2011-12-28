Return-Path: <mylinux@10.ap.freescale.net>
Received: from DB3EHSOBE006.bigfish.com (db3ehsobe006.messaging.microsoft.com
 [213.199.154.144])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id DC802B6FE9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Dec 2011 14:42:01 +1100 (EST)
Received: from mail75-db3 (localhost [127.0.0.1])	by mail75-db3-R.bigfish.com
 (Postfix) with ESMTP id 9FCCF40235	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 28 Dec 2011 03:40:29 +0000 (UTC)
Received: from DB3EHSMHS010.bigfish.com (unknown [10.3.81.248])	by
 mail75-db3.bigfish.com (Postfix) with ESMTP id 9138F160019	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Dec 2011 03:40:27 +0000 (UTC)
Received: from 10.ap.freescale.net (10.ap.freescale.net [10.192.208.115])	by
 az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id pBS3flSm001862	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Dec 2011 21:41:49 -0600 (CST)
From: <b29983@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/2] powerpc/85xx: Add P1024rdb board support
Date: Wed, 28 Dec 2011 11:41:46 +0800
Message-ID: <1325043707-23206-1-git-send-email-b29983@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tang Yuantian <B29983@freescale.com>, Jin Qing <b24347@freescale.com>,
 r66093@freescale.com, Tang Yuantian <Yuantian.Tang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <B29983@freescale.com>

The p1024rdb has the similar feature as the p1020rdb. Therefore, p1024rdb use
the same platform file as the p1/p2 rdb board.
Overview of P2020RDB platform
	- DDR3 1G
	- NOR flash 16M
	- 3 Ethernet interfaces
	- NAND Flash 32M
	- SPI EEPROM 16M
	- SD/MMC
	- 2 USB ports
	- 4 TDM ports

Signed-off-by: Jin Qing <b24347@freescale.com>
Signed-off-by: Li Yang <leoli@freescale.com>
Signed-off-by: Tang Yuantian <Yuantian.Tang@freescale.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   26 +++++++++++++++++++++++++-
 1 files changed, 25 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 9feccbb..c436679 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -1,7 +1,7 @@
 /*
  * MPC85xx RDB Board Setup
  *
- * Copyright 2009 Freescale Semiconductor Inc.
+ * Copyright 2009-2011 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under  the terms of  the GNU General  Public License as published by the
@@ -113,6 +113,7 @@ static void __init mpc85xx_rdb_setup_arch(void)
 
 machine_device_initcall(p2020_rdb, mpc85xx_common_publish_devices);
 machine_device_initcall(p1020_rdb, mpc85xx_common_publish_devices);
+machine_device_initcall(p1024_rdb, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -135,6 +136,15 @@ static int __init p1020_rdb_probe(void)
 	return 0;
 }
 
+static int __init p1024_rdb_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "fsl,P1024RDB"))
+		return 1;
+	return 0;
+}
+
 define_machine(p2020_rdb) {
 	.name			= "P2020 RDB",
 	.probe			= p2020_rdb_probe,
@@ -162,3 +172,17 @@ define_machine(p1020_rdb) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
+
+define_machine(p1024_rdb) {
+	.name           = "P1024 RDB",
+	.probe          = p1024_rdb_probe,
+	.setup_arch     = mpc85xx_rdb_setup_arch,
+	.init_IRQ       = mpc85xx_rdb_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus  = fsl_pcibios_fixup_bus,
+#endif
+	.get_irq        = mpic_get_irq,
+	.restart        = fsl_rstcr_restart,
+	.calibrate_decr     = generic_calibrate_decr,
+	.progress       = udbg_progress,
+};
-- 
1.6.4
