Return-Path: <B29983@freescale.com>
From: <b29983@freescale.com>
To: <galak@kernel.crashing.org>
Subject: [PATCH 2/2] powerpc/85xx: Add P1024rdb board support
Date: Thu, 24 May 2012 17:08:28 +0800
Message-ID: <1337850508-31827-2-git-send-email-b29983@freescale.com>
In-Reply-To: <1337850508-31827-1-git-send-email-b29983@freescale.com>
References: <1337850508-31827-1-git-send-email-b29983@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Tang Yuantian <Yuantian.Tang@freescale.com>,
 devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Tang Yuantian <Yuantian.Tang@freescale.com>

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
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c |   22 ++++++++++++++++++++++
 1 files changed, 22 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 313fce4..1910fdc 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -169,6 +169,7 @@ machine_device_initcall(p1020_rdb_pc, mpc85xx_common_publish_devices);
 machine_device_initcall(p1020_utm_pc, mpc85xx_common_publish_devices);
 machine_device_initcall(p1021_rdb_pc, mpc85xx_common_publish_devices);
 machine_device_initcall(p1025_rdb, mpc85xx_common_publish_devices);
+machine_device_initcall(p1024_rdb, mpc85xx_common_publish_devices);
 
 /*
  * Called very early, device-tree isn't unflattened
@@ -237,6 +238,13 @@ static int __init p1020_utm_pc_probe(void)
 	return of_flat_dt_is_compatible(root, "fsl,P1020UTM-PC");
 }
 
+static int __init p1024_rdb_probe(void)
+{
+	unsigned long root = of_get_flat_dt_root();
+
+	return of_flat_dt_is_compatible(root, "fsl,P1024RDB");
+}
+
 define_machine(p2020_rdb) {
 	.name			= "P2020 RDB",
 	.probe			= p2020_rdb_probe,
@@ -348,3 +356,17 @@ define_machine(p1020_rdb_pc) {
 	.calibrate_decr		= generic_calibrate_decr,
 	.progress		= udbg_progress,
 };
+
+define_machine(p1024_rdb) {
+	.name			= "P1024 RDB",
+	.probe			= p1024_rdb_probe,
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
