Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id A698B67A91
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 26 Jan 2005 11:48:22 +1100 (EST)
Message-ID: <41F6E8CF.3030105@mvista.com>
Date: Tue, 25 Jan 2005 17:48:15 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------000505080204040107010006"
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH] katana update
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>


This is a multi-part message in MIME format.
--------------000505080204040107010006
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi Andrew,

This patch updates support for the katana 750i, 752i, and 3750.

It:
- supports more bus frequencies
- uses platform_notify hook to update platform_data entries
- does some misc cleanup

Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

--------------000505080204040107010006
Content-Type: text/plain;
 name="katana.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="katana.patch"

diff -Nru a/arch/ppc/configs/katana_defconfig b/arch/ppc/configs/katana_defconfig
--- a/arch/ppc/configs/katana_defconfig	2005-01-25 17:44:58 -07:00
+++ b/arch/ppc/configs/katana_defconfig	2005-01-25 17:44:58 -07:00
@@ -1,11 +1,12 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.10-rc2
-# Fri Nov 19 15:17:10 2004
+# Linux kernel version: 2.6.11-rc2
+# Tue Jan 25 16:31:13 2005
 #
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
 CONFIG_RWSEM_XCHGADD_ALGORITHM=y
+CONFIG_GENERIC_CALIBRATE_DELAY=y
 CONFIG_HAVE_DEC_LOCK=y
 CONFIG_PPC=y
 CONFIG_PPC32=y
@@ -79,8 +80,10 @@
 # CONFIG_APUS is not set
 CONFIG_KATANA=y
 # CONFIG_WILLOW is not set
+# CONFIG_CPCI690 is not set
 # CONFIG_PCORE is not set
 # CONFIG_POWERPMC250 is not set
+# CONFIG_CHESTNUT is not set
 # CONFIG_SPRUCE is not set
 # CONFIG_EV64260 is not set
 # CONFIG_LOPEC is not set
@@ -100,6 +103,7 @@
 # CONFIG_RPX8260 is not set
 # CONFIG_TQM8260 is not set
 # CONFIG_ADS8272 is not set
+# CONFIG_PQ2FADS is not set
 # CONFIG_LITE5200 is not set
 CONFIG_MV64360=y
 CONFIG_MV64X60=y
@@ -127,6 +131,15 @@
 CONFIG_PCI_NAMES=y
 
 #
+# PCCARD (PCMCIA/CardBus) support
+#
+# CONFIG_PCCARD is not set
+
+#
+# PC-card bridges
+#
+
+#
 # Advanced setup
 #
 CONFIG_ADVANCED_OPTIONS=y
@@ -153,6 +166,7 @@
 #
 CONFIG_STANDALONE=y
 CONFIG_PREVENT_FIRMWARE_BUILD=y
+# CONFIG_FW_LOADER is not set
 
 #
 # Memory Technology Devices (MTD)
@@ -176,11 +190,13 @@
 # CONFIG_BLK_CPQ_CISS_DA is not set
 # CONFIG_BLK_DEV_DAC960 is not set
 # CONFIG_BLK_DEV_UMEM is not set
+# CONFIG_BLK_DEV_COW_COMMON is not set
 CONFIG_BLK_DEV_LOOP=y
 # CONFIG_BLK_DEV_CRYPTOLOOP is not set
 # CONFIG_BLK_DEV_NBD is not set
 # CONFIG_BLK_DEV_SX8 is not set
 CONFIG_BLK_DEV_RAM=y
+CONFIG_BLK_DEV_RAM_COUNT=16
 CONFIG_BLK_DEV_RAM_SIZE=4096
 CONFIG_BLK_DEV_INITRD=y
 CONFIG_INITRAMFS_SOURCE=""
@@ -194,6 +210,7 @@
 CONFIG_IOSCHED_AS=y
 CONFIG_IOSCHED_DEADLINE=y
 CONFIG_IOSCHED_CFQ=y
+# CONFIG_ATA_OVER_ETH is not set
 
 #
 # ATA/ATAPI/MFM/RLL support
@@ -449,6 +466,10 @@
 #
 # Non-8250 serial port support
 #
+CONFIG_SERIAL_MPSC=y
+CONFIG_SERIAL_MPSC_CONSOLE=y
+CONFIG_SERIAL_CORE=y
+CONFIG_SERIAL_CORE_CONSOLE=y
 CONFIG_UNIX98_PTYS=y
 CONFIG_LEGACY_PTYS=y
 CONFIG_LEGACY_PTY_COUNT=256
@@ -510,6 +531,7 @@
 #
 # CONFIG_VGA_CONSOLE is not set
 CONFIG_DUMMY_CONSOLE=y
+# CONFIG_BACKLIGHT_LCD_SUPPORT is not set
 
 #
 # Sound
@@ -524,11 +546,25 @@
 CONFIG_USB_ARCH_HAS_OHCI=y
 
 #
+# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
+#
+
+#
 # USB Gadget Support
 #
 # CONFIG_USB_GADGET is not set
 
 #
+# MMC/SD Card support
+#
+# CONFIG_MMC is not set
+
+#
+# InfiniBand support
+#
+# CONFIG_INFINIBAND is not set
+
+#
 # File systems
 #
 CONFIG_EXT2_FS=y
@@ -649,3 +685,7 @@
 # Cryptographic options
 #
 # CONFIG_CRYPTO is not set
+
+#
+# Hardware crypto devices
+#
diff -Nru a/arch/ppc/platforms/katana.c b/arch/ppc/platforms/katana.c
--- a/arch/ppc/platforms/katana.c	2005-01-25 17:44:58 -07:00
+++ b/arch/ppc/platforms/katana.c	2005-01-25 17:44:58 -07:00
@@ -8,9 +8,9 @@
  * Based on code done by Rabeeh Khoury - rabeeh@galileo.co.il
  * Based on code done by - Mark A. Greer <mgreer@mvista.com>
  *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
  * option) any later version.
  */
 /*
@@ -194,6 +194,14 @@
 	bd_cfg_0 = in_8((volatile char *)(cpld_base + KATANA_CPLD_BD_CFG_0));
 
 	switch (bd_cfg_0 & KATANA_CPLD_BD_CFG_0_SYSCLK_MASK) {
+	case KATANA_CPLD_BD_CFG_0_SYSCLK_200:
+		return 200000000;
+		break;
+
+	case KATANA_CPLD_BD_CFG_0_SYSCLK_166:
+		return 166666666;
+		break;
+
 	case KATANA_CPLD_BD_CFG_0_SYSCLK_133:
 		return 133333333;
 		break;
@@ -234,7 +242,7 @@
 	/* Config GPP intr ctlr to respond to level trigger */
 	mv64x60_set_bits(&bh, MV64x60_COMM_ARBITER_CNTL, (1<<10));
 
-	/* XXXX Erranum FEr PCI-#8 */
+	/* Erranum FEr PCI-#8 */
 	mv64x60_clr_bits(&bh, MV64x60_PCI0_CMD, (1<<5) | (1<<9));
 	mv64x60_clr_bits(&bh, MV64x60_PCI1_CMD, (1<<5) | (1<<9));
 
@@ -392,7 +400,7 @@
 
 	/* Lookup PCI host bridges */
 	if (mv64x60_init(&bh, &si))
-		printk("Bridge initialization failed.\n");
+		printk(KERN_WARNING "Bridge initialization failed.\n");
 
 	pci_dram_offset = 0; /* sys mem at same addr on PCI & cpu bus */
 	ppc_md.pci_swizzle = common_swizzle;
@@ -433,7 +441,7 @@
 	 * avoid dirty data in cache
 	 */
 	if (PVR_REV(mfspr(PVR)) == 0x0200) {
-		printk("DD2.0 detected. Setting L2 cache"
+		printk(KERN_INFO "DD2.0 detected. Setting L2 cache"
 			"to Writethrough mode\n");
 		_set_L2CR(L2CR_L2E | L2CR_L2PE | L2CR_L2WT);
 	}
@@ -447,83 +455,96 @@
 	katana_setup_peripherals();
 	katana_enable_ipmi();
 
-	printk("Artesyn Communication Products, LLC - Katana(TM)\n");
+	printk(KERN_INFO "Artesyn Communication Products, LLC - Katana(TM)\n");
 	if (ppc_md.progress)
 		ppc_md.progress("katana_setup_arch: exit", 0);
 	return;
 }
 
-/* Platform device data fixup routine. */
-static int __init
-katana_fixup_pd(void)
-{
-	struct list_head	*entry;
-	struct platform_device	*pd;
-	struct device		*dev;
+/* Platform device data fixup routines. */
 #if defined(CONFIG_SERIAL_MPSC)
-	struct mpsc_pd_dd	*dd;
+static void __init
+katana_fixup_mpsc_pdata(struct platform_device *pdev)
+{
+	struct mpsc_pdata *pdata;
+
+	pdata = (struct mpsc_pdata *)pdev->dev.platform_data;
+
+	pdata->max_idle = 40;
+	pdata->default_baud = KATANA_DEFAULT_BAUD;
+	pdata->brg_clk_src = KATANA_MPSC_CLK_SRC;
+	pdata->brg_clk_freq = KATANA_MPSC_CLK_FREQ;
+
+	return;
+}
 #endif
+
 #if defined(CONFIG_MV643XX_ETH)
-	struct mv64xxx_eth_pd_dd *eth_dd;
+static void __init
+katana_fixup_eth_pdata(struct platform_device *pdev)
+{
+	struct mv64xxx_eth_platform_data *eth_pd;
 	static u16 phy_addr[] = {
 		KATANA_ETH0_PHY_ADDR,
 		KATANA_ETH1_PHY_ADDR,
 		KATANA_ETH2_PHY_ADDR,
 	};
-	struct resource	*rx_r;
-	struct resource	*tx_r;
-	int		rx_size = KATANA_ETH_RX_QUEUE_SIZE * ETH_DESC_SIZE;
-	int		tx_size = KATANA_ETH_TX_QUEUE_SIZE * ETH_DESC_SIZE;
-#endif
+	int	rx_size = KATANA_ETH_RX_QUEUE_SIZE * MV64340_ETH_DESC_SIZE;
+	int	tx_size = KATANA_ETH_TX_QUEUE_SIZE * MV64340_ETH_DESC_SIZE;
 
-	list_for_each(entry, &platform_bus_type.devices.list) {
-		dev = container_of(entry, struct device, bus_list);
-		pd = container_of(dev, struct platform_device, dev);
+	eth_pd = pdev->dev.platform_data;
+	eth_pd->force_phy_addr = 1;
+	eth_pd->phy_addr = phy_addr[pdev->id];
+	eth_pd->tx_queue_size = KATANA_ETH_TX_QUEUE_SIZE;
+	eth_pd->rx_queue_size = KATANA_ETH_RX_QUEUE_SIZE;
+	eth_pd->tx_sram_addr = mv643xx_sram_alloc(tx_size);
 
-#if defined(CONFIG_SERIAL_MPSC)
-		if (!strncmp(pd->name, MPSC_CTLR_NAME, BUS_ID_SIZE)) {
-			dd = (struct mpsc_pd_dd *)dev_get_drvdata(&pd->dev);
+	if (eth_pd->tx_sram_addr)
+		eth_pd->tx_sram_size = tx_size;
+	else
+		printk(KERN_ERR "mv643xx_sram_alloc failed\n");
 
-			dd->max_idle = 40;	/* XXXX what should be? */
-			dd->default_baud = KATANA_DEFAULT_BAUD;
-			dd->brg_clk_src = KATANA_MPSC_CLK_SRC;
-			dd->brg_clk_freq = KATANA_MPSC_CLK_FREQ;
-		}
+	eth_pd->rx_sram_addr = mv643xx_sram_alloc(rx_size);
+	if (eth_pd->rx_sram_addr)
+		eth_pd->rx_sram_size = rx_size;
+	else
+		printk(KERN_ERR "mv643xx_sram_alloc failed\n");
+}
+#endif
+
+static int __init
+katana_platform_notify(struct device *dev)
+{
+	static struct {
+		char	*bus_id;
+		void	((*rtn)(struct platform_device *pdev));
+	} dev_map[] = {
+#if defined(CONFIG_SERIAL_MPSC)
+		{ MPSC_CTLR_NAME "0", katana_fixup_mpsc_pdata },
+		{ MPSC_CTLR_NAME "1", katana_fixup_mpsc_pdata },
 #endif
 #if defined(CONFIG_MV643XX_ETH)
-		if (!strncmp(pd->name, MV64XXX_ETH_NAME, BUS_ID_SIZE)) {
-			eth_dd = (struct mv64xxx_eth_pd_dd *)
-						dev_get_drvdata(&pd->dev);
-			eth_dd->phy_addr = phy_addr[pd->id];
-			eth_dd->port_config = KATANA_ETH_PORT_CONFIG_VALUE;
-			eth_dd->port_config_extend =
-					KATANA_ETH_PORT_CONFIG_EXTEND_VALUE;
-			eth_dd->port_sdma_config =
-					KATANA_ETH_PORT_SDMA_CONFIG_VALUE;
-			eth_dd->port_serial_control =
-					KATANA_ETH_PORT_SERIAL_CONTROL_VALUE;
-			eth_dd->tx_queue_size = KATANA_ETH_TX_QUEUE_SIZE;
-			eth_dd->rx_queue_size = KATANA_ETH_RX_QUEUE_SIZE;
-
-			rx_r = &pd->resource[5];
-			rx_r->start = KATANA_INTERNAL_SRAM_BASE +
-						(rx_size + tx_size) * pd->id;
-			rx_r->end = rx_r->start + rx_size - 1;
-			rx_r->flags = IORESOURCE_MEM;
-
-			tx_r = &pd->resource[6];
-			tx_r->start = rx_r->start + rx_size;
-			tx_r->end = tx_r->start + tx_size - 1;
-			tx_r->flags = IORESOURCE_MEM;
-		}
+		{ MV64XXX_ETH_NAME "0", katana_fixup_eth_pdata },
+		{ MV64XXX_ETH_NAME "1", katana_fixup_eth_pdata },
+		{ MV64XXX_ETH_NAME "2", katana_fixup_eth_pdata },
 #endif
-	}
+	};
+	struct platform_device	*pdev;
+	int	i;
+
+	if (dev && dev->bus_id)
+		for (i=0; i<ARRAY_SIZE(dev_map); i++)
+			if (!strncmp(dev->bus_id, dev_map[i].bus_id,
+				BUS_ID_SIZE)) {
+
+				pdev = container_of(dev,
+					struct platform_device, dev);
+				dev_map[i].rtn(pdev);
+			}
 
 	return 0;
 }
 
-subsys_initcall(katana_fixup_pd);
-
 static void
 katana_restart(char *cmd)
 {
@@ -595,7 +616,7 @@
 
 	freq = katana_bus_freq() / 4;
 
-	printk("time_init: decrementer frequency = %lu.%.6lu MHz\n",
+	printk(KERN_INFO "time_init: decrementer frequency = %lu.%.6lu MHz\n",
 	       freq / 1000000, freq % 1000000);
 
 	tb_ticks_per_jiffy = freq / HZ;
@@ -654,7 +675,10 @@
 	mv64x60_progress_init(KATANA_BRIDGE_REG_BASE);
 #endif
 
-	katana_set_bat(); /* Need for katana_find_end_of_memory and progress */
+#if defined(CONFIG_SERIAL_MPSC) || defined(CONFIG_MV643XX_ETH)
+	platform_notify = katana_platform_notify;
+#endif
 
+	katana_set_bat(); /* Need for katana_find_end_of_memory and progress */
 	return;
 }
diff -Nru a/arch/ppc/platforms/katana.h b/arch/ppc/platforms/katana.h
--- a/arch/ppc/platforms/katana.h	2005-01-25 17:44:58 -07:00
+++ b/arch/ppc/platforms/katana.h	2005-01-25 17:44:58 -07:00
@@ -8,9 +8,9 @@
  * Based on code done by Rabeeh Khoury - rabeeh@galileo.co.il
  * Based on code done by Mark A. Greer <mgreer@mvista.com>
  *
- * This program is free software; you can redistribute  it and/or modify it
- * under  the terms of  the GNU General  Public License as published by the
- * Free Software Foundation;  either version 2 of the  License, or (at your
+ * This program is free software; you can redistribute it and/or modify it
+ * under the terms of the GNU General Public License as published by the
+ * Free Software Foundation; either version 2 of the License, or (at your
  * option) any later version.
  */
 
@@ -107,6 +107,8 @@
 #define KATANA_CPLD_RST_CMD_HR			0x01
 
 #define KATANA_CPLD_BD_CFG_0_SYSCLK_MASK	0xc0
+#define KATANA_CPLD_BD_CFG_0_SYSCLK_200		0x00
+#define KATANA_CPLD_BD_CFG_0_SYSCLK_166		0x80
 #define KATANA_CPLD_BD_CFG_0_SYSCLK_133		0xc0
 #define KATANA_CPLD_BD_CFG_0_SYSCLK_100		0x40
 
@@ -170,8 +172,8 @@
 #define KATANA_PRODUCT_ID_750i			0x02
 #define KATANA_PRODUCT_ID_752i			0x04
 
-#define KATANA_ETH_TX_QUEUE_SIZE		1050
-#define KATANA_ETH_RX_QUEUE_SIZE		450
+#define KATANA_ETH_TX_QUEUE_SIZE		800
+#define KATANA_ETH_RX_QUEUE_SIZE		400
 
 #define	KATANA_ETH_PORT_CONFIG_VALUE			\
 	ETH_UNICAST_NORMAL_MODE			|	\

--------------000505080204040107010006--
