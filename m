Return-Path: <r66093@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe001.messaging.microsoft.com [216.32.180.11])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 28857B6EEF
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 20:18:28 +1100 (EST)
Received: from mail167-va3 (localhost [127.0.0.1])	by
 mail167-va3-R.bigfish.com (Postfix) with ESMTP id 8F1163C00DC	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 09:18:17 +0000 (UTC)
Received: from VA3EHSMHS024.bigfish.com (unknown [10.7.14.251])	by
 mail167-va3.bigfish.com (Postfix) with ESMTP id 4654020004B	for
 <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Mar 2012 09:18:15 +0000 (UTC)
From: <Chang-Ming.Huang@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 2/4] powerpc/85xx: add P1020UTM-PC platform support
Date: Wed, 14 Mar 2012 17:08:28 +0800
Message-ID: <1331716110-25545-2-git-send-email-Chang-Ming.Huang@freescale.com>
In-Reply-To: <1331716110-25545-1-git-send-email-Chang-Ming.Huang@freescale.com>
References: <1331716110-25545-1-git-send-email-Chang-Ming.Huang@freescale.com>
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

The p1020utm-pc has the similar feature as the p1020rdb.
Therefore, p1020utm-pc use the same platform file as the p1/p2 rdb board.
Overview of P1020UTM-PC platform:
        - DDR3 1GB
        - NOR flash 32MB
        - I2C EEPROM 256Kb
        - eTSEC1 (RGMII PHY Atheros AR8021)
        - eTSEC2 (SGMII PHY Vitesse VSC8221)
        - eTSEC3 (RGMII PHY Atheros AR8021)
        - SDHC
        - 2 USB ports
        - PCIe (Lane1 to dual SATA controller)

Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   23 +++++++++++++++++++++++
 1 files changed, 23 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 5c6334a..e121d80 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -179,6 +179,7 @@ machine_arch_initcall(p2020_rdb, mpc85xxrdb_publish_pci_device);
 machine_arch_initcall(p1020_rdb, mpc85xxrdb_publish_pci_device);
 machine_arch_initcall(p1020_rdb_pc, mpc85xxrdb_publish_pci_device);
 machine_arch_initcall(p1020_mbg_pc, mpc85xxrdb_publish_pci_device);
+machine_arch_initcall(p1020_utm_pc, mpc85xxrdb_publish_pci_device);
 machine_arch_initcall(p2020_rdb_pc, mpc85xxrdb_publish_pci_device);
 machine_arch_initcall(p1024_rdb, mpc85xxrdb_publish_pci_device);
 machine_arch_initcall(p1021_rdb_pc, mpc85xxrdb_publish_pci_device);
@@ -201,6 +202,7 @@ machine_device_initcall(p2020_rdb, mpc85xxrdb_publish_devices);
 machine_device_initcall(p1020_rdb, mpc85xxrdb_publish_devices);
 machine_device_initcall(p1020_rdb_pc, mpc85xxrdb_publish_devices);
 machine_device_initcall(p1020_mbg_pc, mpc85xxrdb_publish_devices);
+machine_device_initcall(p1020_utm_pc, mpc85xxrdb_publish_devices);
 machine_device_initcall(p2020_rdb_pc, mpc85xxrdb_publish_devices);
 machine_device_initcall(p1024_rdb, mpc85xxrdb_publish_devices);
 machine_device_initcall(p1021_rdb_pc, mpc85xxrdb_publish_devices);
@@ -269,6 +271,13 @@ static int __init p1020_mbg_pc_probe(void)
 	return of_flat_dt_is_compatible(root, "fsl,P1020MBG-PC");
 }
 
+static int __init p1020_utm_pc_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "fsl,P1020UTM-PC");
+}
+
 define_machine(p2020_rdb) {
 	.name			= "P2020 RDB",
 	.probe			= p2020_rdb_probe,
@@ -380,3 +389,17 @@ define_machine(p1020_mbg_pc) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
+
+define_machine(p1020_utm_pc) {
+	.name			= "P1020 UTM-PC",
+	.probe			= p1020_utm_pc_probe,
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
