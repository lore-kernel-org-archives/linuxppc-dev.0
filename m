Return-Path: <jchapman@katalix.com>
Received: from ptb-relay02.plus.net (ptb-relay02.plus.net [212.159.14.213])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 1B14867A6D
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 06:52:56 +1100 (EST)
Message-ID: <42373D11.5020808@katalix.com>
Date: Tue, 15 Mar 2005 19:52:49 +0000
From: James Chapman <jchapman@katalix.com>
MIME-Version: 1.0
To: "Mark A. Greer" <mgreer@mvista.com>
Content-Type: multipart/mixed; boundary="------------040803020108050609060607"
Cc: Linuxppc-Embedded <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 2.6.11] ppc32: update Radstone ppc7d platform for enet/i2c
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
--------------040803020108050609060607
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit



--------------040803020108050609060607
Content-Type: text/plain;
 name="ppc7d-platdata.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc7d-platdata.patch"

ppc32: add ethernet and I2C support to Radstone PPC7D platform

Signed-off-by: James Chapman <jchapman@katalix.com>

Change default platform config to add mv643xx_eth and mv64xxx-i2c
config options. Add i2c platform data and update to cope with the
recent platform device name change.

Index: linux-2.6/arch/ppc/platforms/radstone_ppc7d.c
===================================================================
--- linux-2.6.orig/arch/ppc/platforms/radstone_ppc7d.c	2005-03-15 19:29:22.000000000 +0000
+++ linux-2.6/arch/ppc/platforms/radstone_ppc7d.c	2005-03-15 19:35:02.000000000 +0000
@@ -669,6 +669,42 @@
 }
 #endif
 
+#if defined(CONFIG_I2C_MV64XXX)
+static void __init
+ppc7d_fixup_i2c_pdata(struct platform_device *pdev)
+{
+	struct mv64xxx_i2c_pdata *pdata;
+	int i;
+
+	pdata = pdev->dev.platform_data;
+	if (pdata == NULL) {
+		pdata = kmalloc(GFP_KERNEL, sizeof(*pdata));
+		if (pdata == NULL)
+			return;
+
+		memset(pdata, 0, sizeof(*pdata));
+		pdev->dev.platform_data = pdata;
+	}
+
+	/* divisors M=8, N=3 for 100kHz I2C from 133MHz system clock */
+	pdata->freq_m = 8;
+	pdata->freq_n = 3;
+	pdata->timeout = 500;
+	pdata->retries = 3;
+
+	/* Adjust IRQ by mv64360_irq_base */
+	for (i = 0; i < pdev->num_resources; i++) {
+		struct resource *r = &pdev->resource[i];
+
+		if (r->flags & IORESOURCE_IRQ) {
+			r->start += mv64360_irq_base;
+			r->end += mv64360_irq_base;
+			pr_debug("%s, uses IRQ %d\n", pdev->name, (int) r->start);
+		}
+	}
+}
+#endif
+
 static int __init ppc7d_platform_notify(struct device *dev)
 {
 	static struct {
@@ -676,13 +712,16 @@
 		void ((*rtn) (struct platform_device * pdev));
 	} dev_map[] = {
 #if defined(CONFIG_SERIAL_MPSC)
-		{ MPSC_CTLR_NAME "0", ppc7d_fixup_mpsc_pdata },
-		{ MPSC_CTLR_NAME "1", ppc7d_fixup_mpsc_pdata },
+		{ MPSC_CTLR_NAME ".0", ppc7d_fixup_mpsc_pdata },
+		{ MPSC_CTLR_NAME ".1", ppc7d_fixup_mpsc_pdata },
 #endif
 #if defined(CONFIG_MV643XX_ETH)
-		{ MV643XX_ETH_NAME "0", ppc7d_fixup_eth_pdata },
-		{ MV643XX_ETH_NAME "1", ppc7d_fixup_eth_pdata },
-		{ MV643XX_ETH_NAME "2", ppc7d_fixup_eth_pdata },
+		{ MV643XX_ETH_NAME ".0", ppc7d_fixup_eth_pdata },
+		{ MV643XX_ETH_NAME ".1", ppc7d_fixup_eth_pdata },
+		{ MV643XX_ETH_NAME ".2", ppc7d_fixup_eth_pdata },
+#endif
+#if defined(CONFIG_I2C_MV64XXX)
+		{ MV64XXX_I2C_CTLR_NAME ".0", ppc7d_fixup_i2c_pdata },
 #endif
 	};
 	struct platform_device *pdev;
@@ -1363,7 +1402,8 @@
 
 	ppc_md.pcibios_fixup_bus = ppc7d_pci_fixup_bus;
 
-#if defined(CONFIG_SERIAL_MPSC) || defined(CONFIG_MV643XX_ETH)
+#if defined(CONFIG_SERIAL_MPSC) || defined(CONFIG_MV643XX_ETH) || \
+    defined(CONFIG_I2C_MV64XXX)
 	platform_notify = ppc7d_platform_notify;
 #endif
 
@@ -1405,4 +1445,8 @@
 	rev_num = (val8 & PPC7D_CPLD_BOARD_REVISION_NUMBER_MASK) >> 5;
 	if (rev_num <= 1)
 		ppc7d_has_alma = 1;
+
+#ifdef DEBUG
+	console_printk[0] = 8;
+#endif
 }
Index: linux-2.6/arch/ppc/configs/radstone_ppc7d_defconfig
===================================================================
--- linux-2.6.orig/arch/ppc/configs/radstone_ppc7d_defconfig	2005-03-15 19:29:22.000000000 +0000
+++ linux-2.6/arch/ppc/configs/radstone_ppc7d_defconfig	2005-03-15 19:30:50.000000000 +0000
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.11
-# Tue Mar 15 11:11:47 2005
+# Tue Mar 15 14:31:19 2005
 #
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
@@ -514,7 +514,10 @@
 CONFIG_SK98LIN=y
 # CONFIG_VIA_VELOCITY is not set
 CONFIG_TIGON3=y
-# CONFIG_MV643XX_ETH is not set
+CONFIG_MV643XX_ETH=y
+CONFIG_MV643XX_ETH_0=y
+CONFIG_MV643XX_ETH_1=y
+# CONFIG_MV643XX_ETH_2 is not set
 
 #
 # Ethernet (10000 Mbit)
@@ -667,7 +670,90 @@
 #
 # I2C support
 #
-# CONFIG_I2C is not set
+CONFIG_I2C=y
+CONFIG_I2C_CHARDEV=y
+
+#
+# I2C Algorithms
+#
+# CONFIG_I2C_ALGOBIT is not set
+# CONFIG_I2C_ALGOPCF is not set
+# CONFIG_I2C_ALGOPCA is not set
+
+#
+# I2C Hardware Bus support
+#
+# CONFIG_I2C_ALI1535 is not set
+# CONFIG_I2C_ALI1563 is not set
+# CONFIG_I2C_ALI15X3 is not set
+# CONFIG_I2C_AMD756 is not set
+# CONFIG_I2C_AMD8111 is not set
+# CONFIG_I2C_I801 is not set
+# CONFIG_I2C_I810 is not set
+# CONFIG_I2C_ISA is not set
+# CONFIG_I2C_MPC is not set
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PIIX4 is not set
+# CONFIG_I2C_PROSAVAGE is not set
+# CONFIG_I2C_SAVAGE4 is not set
+# CONFIG_SCx200_ACB is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_STUB is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+# CONFIG_I2C_VOODOO3 is not set
+# CONFIG_I2C_PCA_ISA is not set
+CONFIG_I2C_MV64XXX=y
+
+#
+# Hardware Sensors Chip support
+#
+CONFIG_I2C_SENSOR=y
+# CONFIG_SENSORS_ADM1021 is not set
+# CONFIG_SENSORS_ADM1025 is not set
+# CONFIG_SENSORS_ADM1026 is not set
+# CONFIG_SENSORS_ADM1031 is not set
+# CONFIG_SENSORS_ASB100 is not set
+# CONFIG_SENSORS_DS1621 is not set
+# CONFIG_SENSORS_FSCHER is not set
+# CONFIG_SENSORS_FSCPOS is not set
+# CONFIG_SENSORS_GL518SM is not set
+# CONFIG_SENSORS_GL520SM is not set
+# CONFIG_SENSORS_IT87 is not set
+# CONFIG_SENSORS_LM63 is not set
+# CONFIG_SENSORS_LM75 is not set
+# CONFIG_SENSORS_LM77 is not set
+# CONFIG_SENSORS_LM78 is not set
+# CONFIG_SENSORS_LM80 is not set
+# CONFIG_SENSORS_LM83 is not set
+# CONFIG_SENSORS_LM85 is not set
+# CONFIG_SENSORS_LM87 is not set
+CONFIG_SENSORS_LM90=y
+# CONFIG_SENSORS_MAX1619 is not set
+# CONFIG_SENSORS_PC87360 is not set
+# CONFIG_SENSORS_SMSC47B397 is not set
+# CONFIG_SENSORS_SIS5595 is not set
+# CONFIG_SENSORS_SMSC47M1 is not set
+# CONFIG_SENSORS_VIA686A is not set
+# CONFIG_SENSORS_W83781D is not set
+# CONFIG_SENSORS_W83L785TS is not set
+# CONFIG_SENSORS_W83627HF is not set
+
+#
+# Other I2C Chip support
+#
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_RTC8564 is not set
+# CONFIG_SENSORS_M41T00 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
 
 #
 # Dallas's 1-wire bus

--------------040803020108050609060607--
