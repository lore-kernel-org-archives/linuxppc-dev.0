Return-Path: <r66093@freescale.com>
Received: from am1outboundpool.messaging.microsoft.com
 (am1ehsobe004.messaging.microsoft.com [213.199.154.207])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 5BF25B6FF9
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 20:18:43 +1100 (EST)
Received: from mail75-am1 (localhost [127.0.0.1])	by mail75-am1-R.bigfish.com
 (Postfix) with ESMTP id 6044A4A04C6	for
 <linuxppc-dev@lists.ozlabs.org>; Wed,
 14 Mar 2012 09:18:33 +0000 (UTC)
Received: from AM1EHSMHS014.bigfish.com (unknown [10.3.201.237])	by
 mail75-am1.bigfish.com (Postfix) with ESMTP id 5782F40091	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 09:18:12 +0000 (UTC)
From: <Chang-Ming.Huang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 1/4] powerpc/85xx: add P1020MBG-PC platform support
Date: Wed, 14 Mar 2012 17:08:27 +0800
Message-ID: <1331716110-25545-1-git-send-email-Chang-Ming.Huang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Jerry Huang <Chang-Ming.Huang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Jerry Huang <Chang-Ming.Huang@freescale.com>

The p1020mbg-pc has the similar feature as the p1020rdb.
Therefore, p1020mbg-pc use the same platform file as the p1/p2 rdb board.
Overview of P1020MBG-PC platform:
        - DDR3 2GB
        - NOR flash 64MB
        - I2C EEPROM 256Kb
        - eTSEC1 (RGMII PHY) connected to VSC7385 L2 switch
        - eTSEC2 (SGMII PHY)
        - eTSEC3 (RGMII PHY)
        - SDHC
        - 2 USB ports
        - 4 TDM ports
        - PCIe (Lane1 to dual SATA controller)

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 6de10bf..5c6334a 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -178,6 +178,7 @@ static int __init mpc85xxrdb_publish_pci_device(void)
 machine_arch_initcall(p2020_rdb, mpc85xxrdb_publish_pci_device);
 machine_arch_initcall(p1020_rdb, mpc85xxrdb_publish_pci_device);
 machine_arch_initcall(p1020_rdb_pc, mpc85xxrdb_publish_pci_device);
+machine_arch_initcall(p1020_mbg_pc, mpc85xxrdb_publish_pci_device);
 machine_arch_initcall(p2020_rdb_pc, mpc85xxrdb_publish_pci_device);
 machine_arch_initcall(p1024_rdb, mpc85xxrdb_publish_pci_device);
 machine_arch_initcall(p1021_rdb_pc, mpc85xxrdb_publish_pci_device);
@@ -199,6 +200,7 @@ static int __init mpc85xxrdb_publish_devices(void)
 machine_device_initcall(p2020_rdb, mpc85xxrdb_publish_devices);
 machine_device_initcall(p1020_rdb, mpc85xxrdb_publish_devices);
 machine_device_initcall(p1020_rdb_pc, mpc85xxrdb_publish_devices);
+machine_device_initcall(p1020_mbg_pc, mpc85xxrdb_publish_devices);
 machine_device_initcall(p2020_rdb_pc, mpc85xxrdb_publish_devices);
 machine_device_initcall(p1024_rdb, mpc85xxrdb_publish_devices);
 machine_device_initcall(p1021_rdb_pc, mpc85xxrdb_publish_devices);
@@ -260,6 +262,13 @@ static int __init p1025_rdb_probe(void)
 	return of_flat_dt_is_compatible(root, "fsl,P1025RDB");
 }
 
+static int __init p1020_mbg_pc_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "fsl,P1020MBG-PC");
+}
+
 define_machine(p2020_rdb) {
 	.name			= "P2020 RDB",
 	.probe			= p2020_rdb_probe,
@@ -357,3 +366,17 @@ define_machine(p1025_rdb) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
+
+define_machine(p1020_mbg_pc) {
+	.name			= "P1020 MBG-PC",
+	.probe			= p1020_mbg_pc_probe,
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
1.7.5.4
