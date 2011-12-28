Return-Path: <mylinux@10.ap.freescale.net>
Received: from ch1outboundpool.messaging.microsoft.com
 (ch1ehsobe004.messaging.microsoft.com [216.32.181.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (verified OK))
 by ozlabs.org (Postfix) with ESMTPS id DA447B6FB4
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Dec 2011 14:42:01 +1100 (EST)
Received: from mail204-ch1 (localhost [127.0.0.1])	by
 mail204-ch1-R.bigfish.com (Postfix) with ESMTP id A5D773401D2	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Dec 2011 03:42:25 +0000 (UTC)
Received: from CH1EHSMHS014.bigfish.com (snatpool1.int.messaging.microsoft.com
 [10.43.68.254])	by mail204-ch1.bigfish.com (Postfix) with ESMTP id
 587424003F
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 28 Dec 2011 03:42:23 +0000 (UTC)
Received: from 10.ap.freescale.net (10.ap.freescale.net [10.192.208.115])	by
 az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id pBS3fmCv001863	for
 <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Dec 2011 21:41:50 -0600 (CST)
From: <b29983@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/2] powerpc/85xx: Adds Support for P2020RDB-PC board
Date: Wed, 28 Dec 2011 11:41:47 +0800
Message-ID: <1325043707-23206-2-git-send-email-b29983@freescale.com>
In-Reply-To: <1325043707-23206-1-git-send-email-b29983@freescale.com>
References: <1325043707-23206-1-git-send-email-b29983@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tang Yuantian <b29983@freescale.com>, r66093@freescale.com,
 Poonam Aggrwal <poonam.aggrwal@freescale.com>,
 Prabhakar Kushwaha <prabhakar@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <B29983@freescale.com>

P2020RDB-PC Board shares the same design(PCB) as P102x RDB style platforms.
The difference between this platform and the already existing P2020RDB
is mainly with respect to DDR. The P2020RDB-PC has a DDR3 memory.
The P2020RDB-PC also has a CPLD device connected to local bus.

The main differences from the P102x RDB-PC is 64-bit DDR and SYSCLK of
100Mhz.

Signed-off-by: Prabhakar Kushwaha <prabhakar@freescale.com>
Signed-off-by: Poonam Aggrwal <poonam.aggrwal@freescale.com>
Signed-off-by: Tang Yuantian <b29983@freescale.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   24 ++++++++++++++++++++++++
 1 files changed, 24 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index c436679..576cef2 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -114,6 +114,7 @@ static void __init mpc85xx_rdb_setup_arch(void)
 machine_device_initcall(p2020_rdb, mpc85xx_common_publish_devices);
 machine_device_initcall(p1020_rdb, mpc85xx_common_publish_devices);
 machine_device_initcall(p1024_rdb, mpc85xx_common_publish_devices);
+machine_device_initcall(p2020_rdb_pc, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -145,6 +146,15 @@ static int __init p1024_rdb_probe(void)
 	return 0;
 }
 
+static int __init p2020_rdb_pc_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	if (of_flat_dt_is_compatible(root, "fsl,P2020RDB-PC"))
+		return 1;
+	return 0;
+}
+
 define_machine(p2020_rdb) {
 	.name			= "P2020 RDB",
 	.probe			= p2020_rdb_probe,
@@ -185,4 +195,18 @@ define_machine(p1024_rdb) {
 	.restart        = fsl_rstcr_restart,
 	.calibrate_decr     = generic_calibrate_decr,
 	.progress       = udbg_progress,
+}
+
+define_machine(p2020_rdb_pc) {
+	.name			= "P2020RDB-PC",
+	.probe			= p2020_rdb_pc_probe,
+	.setup_arch		= mpc85xx_rdb_setup_arch,
+	.init_IRQ		= mpc85xx_rdb_pic_init,
+#ifdef CONFIG_PCI
+	.pcibios_fixup_bus	= fsl_pcibios_fixup_bus,
+#endif
+	.get_irq		= mpic_get_irq,
+	.restart		= fsl_rstcr_restart,
+	.calibrate_decr		= generic_calibrate_decr,
+	.progress		= udbg_progress,
 };
-- 
1.6.4
