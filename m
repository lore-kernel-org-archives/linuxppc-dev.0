Return-Path: <mgreer@mvista.com>
Received: from av.mvista.com (gateway-1237.mvista.com [12.44.186.158])
	by ozlabs.org (Postfix) with ESMTP id F16D367A75
	for <linuxppc-embedded@ozlabs.org>;
	Wed, 16 Mar 2005 10:05:57 +1100 (EST)
Message-ID: <42376A46.2090605@mvista.com>
Date: Tue, 15 Mar 2005 16:05:42 -0700
From: "Mark A. Greer" <mgreer@mvista.com>
MIME-Version: 1.0
To: akpm <akpm@osdl.org>
Content-Type: multipart/mixed; boundary="------------040801060508020705080604"
Cc: Embedded PPC Linux list <linuxppc-embedded@ozlabs.org>
Subject: [PATCH 2.6.11] ppc32: update Radstone ppc7d platform
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
--------------040801060508020705080604
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

ppc32: Radstone PPC7D platform update

- Recent mv643xx #define name changes broke the PPC7D platform
compile. Fixed by this patch.

- Change default platform config to add mv643xx_eth and mv64xxx-i2c
config options.

- Add i2c platform data and update to cope with recent platform device
name change.

Signed-off-by: James Chapman <jchapman@katalix.com>
Signed-off-by: Mark A. Greer <mgreer@mvista.com>
--

--------------040801060508020705080604
Content-Type: text/plain;
 name="ppc7d-2.patch"
Content-Transfer-Encoding: 7bit
Content-Disposition: inline;
 filename="ppc7d-2.patch"

Index: linux-2.6/arch/ppc/platforms/radstone_ppc7d.c
===================================================================
--- linux-2.6.orig/arch/ppc/platforms/radstone_ppc7d.c	2005-03-15 14:44:43.000000000 +0000
+++ linux-2.6/arch/ppc/platforms/radstone_ppc7d.c	2005-03-15 22:17:56.000000000 +0000
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
@@ -1162,7 +1201,7 @@
 
 	/* Disable ethernet. It might have been setup by the bootrom */
 	for (port = 0; port < 3; port++)
-		mv64x60_write(&bh, MV64340_ETH_RECEIVE_QUEUE_COMMAND_REG(port),
+		mv64x60_write(&bh, MV643XX_ETH_RECEIVE_QUEUE_COMMAND_REG(port),
 			      0x0000ff00);
 
 	/* Clear queue pointers to ensure they are all initialized,
@@ -1172,25 +1211,25 @@
 	 */
 	for (port = 0; port < 3; port++) {
 		mv64x60_write(&bh,
-			      MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_1(port),
+			      MV643XX_ETH_RX_CURRENT_QUEUE_DESC_PTR_1(port),
 			      0x00000000);
 		mv64x60_write(&bh,
-			      MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_2(port),
+			      MV643XX_ETH_RX_CURRENT_QUEUE_DESC_PTR_2(port),
 			      0x00000000);
 		mv64x60_write(&bh,
-			      MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_3(port),
+			      MV643XX_ETH_RX_CURRENT_QUEUE_DESC_PTR_3(port),
 			      0x00000000);
 		mv64x60_write(&bh,
-			      MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_4(port),
+			      MV643XX_ETH_RX_CURRENT_QUEUE_DESC_PTR_4(port),
 			      0x00000000);
 		mv64x60_write(&bh,
-			      MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_5(port),
+			      MV643XX_ETH_RX_CURRENT_QUEUE_DESC_PTR_5(port),
 			      0x00000000);
 		mv64x60_write(&bh,
-			      MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_6(port),
+			      MV643XX_ETH_RX_CURRENT_QUEUE_DESC_PTR_6(port),
 			      0x00000000);
 		mv64x60_write(&bh,
-			      MV64340_ETH_RX_CURRENT_QUEUE_DESC_PTR_7(port),
+			      MV643XX_ETH_RX_CURRENT_QUEUE_DESC_PTR_7(port),
 			      0x00000000);
 	}
 
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
--- linux-2.6.orig/arch/ppc/configs/radstone_ppc7d_defconfig	2005-03-15 14:44:43.000000000 +0000
+++ linux-2.6/arch/ppc/configs/radstone_ppc7d_defconfig	2005-03-15 22:17:56.000000000 +0000
@@ -1,7 +1,7 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.11-rc4
-# Thu Feb 24 21:26:04 2005
+# Linux kernel version: 2.6.11
+# Tue Mar 15 14:31:19 2005
 #
 CONFIG_MMU=y
 CONFIG_GENERIC_HARDIRQS=y
@@ -29,13 +29,13 @@
 # CONFIG_BSD_PROCESS_ACCT is not set
 CONFIG_SYSCTL=y
 # CONFIG_AUDIT is not set
-CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_HOTPLUG is not set
 CONFIG_KOBJECT_UEVENT=y
 # CONFIG_IKCONFIG is not set
 CONFIG_EMBEDDED=y
 CONFIG_KALLSYMS=y
 CONFIG_KALLSYMS_EXTRA_PASS=y
+CONFIG_BASE_FULL=y
 CONFIG_FUTEX=y
 CONFIG_EPOLL=y
 # CONFIG_CC_OPTIMIZE_FOR_SIZE is not set
@@ -45,6 +45,7 @@
 CONFIG_CC_ALIGN_LOOPS=0
 CONFIG_CC_ALIGN_JUMPS=0
 # CONFIG_TINY_SHMEM is not set
+CONFIG_BASE_SMALL=0
 
 #
 # Loadable module support
@@ -71,6 +72,7 @@
 # CONFIG_TAU is not set
 # CONFIG_CPU_FREQ is not set
 CONFIG_PPC_GEN550=y
+# CONFIG_PM is not set
 CONFIG_PPC_STD_MMU=y
 # CONFIG_NOT_COHERENT_CACHE is not set
 
@@ -107,6 +109,7 @@
 # CONFIG_ADS8272 is not set
 # CONFIG_PQ2FADS is not set
 # CONFIG_LITE5200 is not set
+# CONFIG_MPC834x_SYS is not set
 CONFIG_MV64360=y
 CONFIG_MV64X60=y
 
@@ -138,10 +141,6 @@
 # CONFIG_PCCARD is not set
 
 #
-# PC-card bridges
-#
-
-#
 # Advanced setup
 #
 CONFIG_ADVANCED_OPTIONS=y
@@ -171,8 +170,8 @@
 #
 CONFIG_MTD=y
 # CONFIG_MTD_DEBUG is not set
-# CONFIG_MTD_PARTITIONS is not set
 # CONFIG_MTD_CONCAT is not set
+# CONFIG_MTD_PARTITIONS is not set
 
 #
 # User Modules And Translation Layers
@@ -490,7 +489,6 @@
 # CONFIG_DGRS is not set
 # CONFIG_EEPRO100 is not set
 CONFIG_E100=y
-# CONFIG_E100_NAPI is not set
 # CONFIG_FEALNX is not set
 # CONFIG_NATSEMI is not set
 # CONFIG_NE2K_PCI is not set
@@ -516,6 +514,10 @@
 CONFIG_SK98LIN=y
 # CONFIG_VIA_VELOCITY is not set
 CONFIG_TIGON3=y
+CONFIG_MV643XX_ETH=y
+CONFIG_MV643XX_ETH_0=y
+CONFIG_MV643XX_ETH_1=y
+# CONFIG_MV643XX_ETH_2 is not set
 
 #
 # Ethernet (10000 Mbit)
@@ -573,19 +575,6 @@
 # CONFIG_INPUT_EVBUG is not set
 
 #
-# Input I/O drivers
-#
-# CONFIG_GAMEPORT is not set
-CONFIG_SOUND_GAMEPORT=y
-CONFIG_SERIO=y
-CONFIG_SERIO_I8042=y
-CONFIG_SERIO_SERPORT=y
-# CONFIG_SERIO_CT82C710 is not set
-# CONFIG_SERIO_PCIPS2 is not set
-CONFIG_SERIO_LIBPS2=y
-# CONFIG_SERIO_RAW is not set
-
-#
 # Input Device Drivers
 #
 CONFIG_INPUT_KEYBOARD=y
@@ -600,6 +589,18 @@
 # CONFIG_INPUT_MISC is not set
 
 #
+# Hardware I/O ports
+#
+CONFIG_SERIO=y
+CONFIG_SERIO_I8042=y
+CONFIG_SERIO_SERPORT=y
+# CONFIG_SERIO_PCIPS2 is not set
+CONFIG_SERIO_LIBPS2=y
+# CONFIG_SERIO_RAW is not set
+# CONFIG_GAMEPORT is not set
+CONFIG_SOUND_GAMEPORT=y
+
+#
 # Character devices
 #
 CONFIG_VT=y
@@ -641,7 +642,6 @@
 # Watchdog Device Drivers
 #
 # CONFIG_SOFT_WATCHDOG is not set
-CONFIG_MV64X60_WDT=y
 
 #
 # PCI-based Watchdog Cards
@@ -663,9 +663,97 @@
 # CONFIG_RAW_DRIVER is not set
 
 #
+# TPM devices
+#
+# CONFIG_TCG_TPM is not set
+
+#
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
@@ -705,13 +793,9 @@
 #
 # USB support
 #
-# CONFIG_USB is not set
 CONFIG_USB_ARCH_HAS_HCD=y
 CONFIG_USB_ARCH_HAS_OHCI=y
-
-#
-# NOTE: USB_STORAGE enables SCSI, and 'SCSI disk support' may also be needed; see USB_STORAGE Help for more information
-#
+# CONFIG_USB is not set
 
 #
 # USB Gadget Support
@@ -851,7 +935,9 @@
 #
 # Kernel hacking
 #
+# CONFIG_PRINTK_TIME is not set
 # CONFIG_DEBUG_KERNEL is not set
+CONFIG_LOG_BUF_SHIFT=14
 # CONFIG_SERIAL_TEXT_DEBUG is not set
 
 #

--------------040801060508020705080604--
