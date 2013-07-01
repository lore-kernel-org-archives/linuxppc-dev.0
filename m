Return-Path: <B42677@freescale.com>
Received: from co9outboundpool.messaging.microsoft.com
 (co9ehsobe001.messaging.microsoft.com [207.46.163.24])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2CFCF2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  1 Jul 2013 15:01:17 +1000 (EST)
From: Haijun Zhang <Haijun.Zhang@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 1/2] [PATCH] powerpc/85xx: add P1020RDB-PD platform support
Date: Mon, 1 Jul 2013 12:12:22 +0800
Message-ID: <1372651943-12045-1-git-send-email-Haijun.Zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Scott Wood <scottwood@freescale.com>,
 Jerry Huang <Chang-Ming.Huang@freescale.com>, linuxppc-dev@lists.ozlabs.org,
 "Haijun.Zhang" <Haijun.Zhang@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Haijun.Zhang" <Haijun.Zhang@freescale.com>

The p1020rdb-pd has the similar feature as the p1020rdb.
Therefore, p1020rdb-pd use the same platform file as the p1/p2 rdb board.
Overview of P1020RDB-PD platform:
- DDR3 2GB
- NOR flash 64MB
- NAND flash 128MB
- SPI flash 16MB
- I2C EEPROM 256Kb
	- eTSEC1 (RGMII PHY) connected to VSC7385 L2 switch
	- eTSEC2 (SGMII PHY)
- eTSEC3 (RGMII PHY)
	- SDHC
	- 2 USB ports
	- 4 TDM ports
	- PCIe

Signed-off-by: Haijun Zhang <Haijun.Zhang@freescale.com>
Signed-off-by: Jerry Huang <Chang-Ming.Huang@freescale.com>
CC: Scott Wood <scottwood@freescale.com>
---
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c | 22 ++++++++++++++++++++++
 1 file changed, 22 insertions(+)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index ede8771..53b6fb0 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -160,6 +160,7 @@ machine_arch_initcall(p2020_rdb_pc, mpc85xx_common_publish_devices);
 machine_arch_initcall(p1020_mbg_pc, mpc85xx_common_publish_devices);
 machine_arch_initcall(p1020_rdb, mpc85xx_common_publish_devices);
 machine_arch_initcall(p1020_rdb_pc, mpc85xx_common_publish_devices);
+machine_arch_initcall(p1020_rdb_pd, mpc85xx_common_publish_devices);
 machine_arch_initcall(p1020_utm_pc, mpc85xx_common_publish_devices);
 machine_arch_initcall(p1021_rdb_pc, mpc85xx_common_publish_devices);
 machine_arch_initcall(p1025_rdb, mpc85xx_common_publish_devices);
@@ -193,6 +194,13 @@ static int __init p1020_rdb_pc_probe(void)
 	return of_flat_dt_is_compatible(root, "fsl,P1020RDB-PC");
 }
 
+static int __init p1020_rdb_pd_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "fsl,P1020RDB-PD");
+}
+
 static int __init p1021_rdb_pc_probe(void)
 {
 	unsigned long root = of_get_flat_dt_root();
@@ -351,6 +359,20 @@ define_machine(p1020_rdb_pc) {
 	.progress		= udbg_progress,
 };
 
+define_machine(p1020_rdb_pd) {
+	.name			= "P1020RDB-PD",
+	.probe			= p1020_rdb_pd_probe,
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
+
 define_machine(p1024_rdb) {
 	.name			= "P1024 RDB",
 	.probe			= p1024_rdb_probe,
-- 
1.8.0
