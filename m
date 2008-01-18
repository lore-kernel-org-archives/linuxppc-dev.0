Return-Path: <b04825@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id A126FDDEF7
	for <linuxppc-dev@ozlabs.org>; Sat, 19 Jan 2008 03:18:42 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: galak@kernel.crashing.org, linuxppc-dev@ozlabs.org,
	alsa-devel@alsa-project.org
Subject: [PATCH v4] [POWERPC] Update MPC8610 HPCD to support audio drivers
Date: Fri, 18 Jan 2008 09:24:53 -0600
Message-Id: <12006698934064-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Update the MPC8610 HPCD files to support the audio driver.  Update
booting-without-of.txt with information on the SSI device.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

Rebased for Kumar's repo.

 Documentation/powerpc/booting-without-of.txt |   41 ++++++
 arch/powerpc/boot/dts/mpc8610_hpcd.dts       |  113 +++++++++++++++++-
 arch/powerpc/configs/mpc8610_hpcd_defconfig  |  171 +++++++++++++++++++++++++-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c   |   15 +++
 4 files changed, 336 insertions(+), 4 deletions(-)

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index a13d457..6ac726d 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -56,6 +56,7 @@ Table of Contents
       m) Chipselect/Local Bus
       n) 4xx/Axon EMAC ethernet nodes
       o) Xilinx IP cores
+      p) Freescale Synchronous Serial Interface
 
   VII - Specifying interrupt information for devices
     1) interrupts property
@@ -2575,6 +2576,46 @@ platforms are moved over to use the flattened-device-tree model.
       Requred properties:
        - current-speed : Baud rate of uartlite
 
+    p) Freescale Synchronous Serial Interface
+
+       The SSI is a serial device that communicates with audio codecs.  It can
+       be programmed in AC97, I2S, left-justified, or right-justified modes.
+
+       Required properties:
+       - compatible	  : compatible list, containing "fsl,ssi"
+       - cell-index	  : the SSI, <0> = SSI1, <1> = SSI2, and so on
+       - reg		  : offset and length of the register set for the device
+       - interrupts	  : <a b> where a is the interrupt number and b is a
+                            field that represents an encoding of the sense and
+			    level information for the interrupt.  This should be
+			    encoded based on the information in section 2)
+			    depending on the type of interrupt controller you
+			    have.
+       - interrupt-parent : the phandle for the interrupt controller that
+                            services interrupts for this device.
+       - fsl,mode	  : the operating mode for the SSI interface
+			    "i2s-slave" - I2S mode, SSI is clock slave
+			    "i2s-master" - I2S mode, SSI is clock master
+			    "lj-slave" - left-justified mode, SSI is clock slave
+			    "lj-master" - l.j. mode, SSI is clock master
+			    "rj-slave" - right-justified mode, SSI is clock slave
+			    "rj-master" - r.j., SSI is clock master
+			    "ac97-slave" - AC97 mode, SSI is clock slave
+			    "ac97-master" - AC97 mode, SSI is clock master
+
+       Optional properties:
+       - codec-handle	  : phandle to a 'codec' node that defines an audio
+			    codec connected to this SSI.  This node is typically
+			    a child of an I2C or other control node.
+
+       Child 'codec' node required properties:
+       - compatible	  : compatible list, contains the name of the codec
+
+       Child 'codec' node optional properties:
+       - clock-frequency  : The frequency of the input clock, which typically
+                            comes from an on-board dedicated oscillator.
+
+
    More devices will be defined as this spec matures.
 
 VII - Specifying interrupt information for devices
diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 01040a7..d98715c 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -1,7 +1,7 @@
 /*
  * MPC8610 HPCD Device Tree Source
  *
- * Copyright 2007 Freescale Semiconductor Inc.
+ * Copyright 2007-2008 Freescale Semiconductor Inc.
  *
  * This program is free software; you can redistribute  it and/or modify it
  * under the terms of the GNU General Public License Version 2 as published
@@ -49,6 +49,7 @@
 		#size-cells = <1>;
 		#interrupt-cells = <2>;
 		device_type = "soc";
+		compatible = "fsl,mpc8610-immr", "simple-bus";
 		ranges = <0 e0000000 00100000>;
 		reg = <e0000000 1000>;
 		bus-frequency = <0>;
@@ -62,6 +63,13 @@
 			interrupts = <2b 2>;
 			interrupt-parent = <&mpic>;
 			dfsrr;
+
+                        cs4270:codec@4f {
+				compatible = "cirrus,cs4270";
+                                reg = <4f>;
+				/* MCLK source is a stand-alone oscillator */
+				clock-frequency = <bb8000>;
+                        };
 		};
 
 		i2c@3100 {
@@ -111,6 +119,109 @@
 			reg = <e0000 1000>;
 			fsl,has-rstcr;
 		};
+
+		i2s@16000 {
+			compatible = "fsl,mpc8610-ssi";
+			cell-index = <0>;
+			reg = <16000 100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <3e 2>;
+			fsl,mode = "i2s-slave";
+			codec-handle = <&cs4270>;
+		};
+
+		ssi@16100 {
+			compatible = "fsl,mpc8610-ssi";
+			cell-index = <1>;
+			reg = <16100 100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <3f 2>;
+		};
+
+                dma@21300 {
+                        #address-cells = <1>;
+                        #size-cells = <1>;
+                        compatible = "fsl,mpc8610-dma", "fsl,eloplus-dma";
+                        cell-index = <0>;
+                        reg = <21300 4>; /* DMA general status register */
+                        ranges = <0 21100 200>;
+
+                        dma-channel@0 {
+				compatible = "fsl,mpc8610-dma-channel",
+					"fsl,eloplus-dma-channel";
+				cell-index = <0>;
+				reg = <0 80>;
+				interrupt-parent = <&mpic>;
+				interrupts = <14 2>;
+                        };
+                        dma-channel@1 {
+				compatible = "fsl,mpc8610-dma-channel",
+					"fsl,eloplus-dma-channel";
+				cell-index = <1>;
+				reg = <80 80>;
+				interrupt-parent = <&mpic>;
+				interrupts = <15 2>;
+                        };
+                        dma-channel@2 {
+				compatible = "fsl,mpc8610-dma-channel",
+					"fsl,eloplus-dma-channel";
+				cell-index = <2>;
+				reg = <100 80>;
+				interrupt-parent = <&mpic>;
+				interrupts = <16 2>;
+                        };
+                        dma-channel@3 {
+				compatible = "fsl,mpc8610-dma-channel",
+					"fsl,eloplus-dma-channel";
+				cell-index = <3>;
+				reg = <180 80>;
+				interrupt-parent = <&mpic>;
+				interrupts = <17 2>;
+                        };
+                };
+
+                dma@c300 {
+                        #address-cells = <1>;
+                        #size-cells = <1>;
+                        compatible = "fsl,mpc8610-dma", "fsl,mpc8540-dma";
+                        cell-index = <1>;
+                        reg = <c300 4>; /* DMA general status register */
+                        ranges = <0 c100 200>;
+
+                        dma-channel@0 {
+				compatible = "fsl,mpc8610-dma-channel",
+					"fsl,mpc8540-dma-channel";
+				cell-index = <0>;
+				reg = <0 80>;
+				interrupt-parent = <&mpic>;
+				interrupts = <3c 2>;
+                        };
+                        dma-channel@1 {
+				compatible = "fsl,mpc8610-dma-channel",
+					"fsl,mpc8540-dma-channel";
+				cell-index = <1>;
+				reg = <80 80>;
+				interrupt-parent = <&mpic>;
+				interrupts = <3d 2>;
+                        };
+                        dma-channel@2 {
+				compatible = "fsl,mpc8610-dma-channel",
+					"fsl,mpc8540-dma-channel";
+				cell-index = <2>;
+				reg = <100 80>;
+				interrupt-parent = <&mpic>;
+				interrupts = <3e 2>;
+                        };
+                        dma-channel@3 {
+				compatible = "fsl,mpc8610-dma-channel",
+					"fsl,mpc8540-dma-channel";
+				cell-index = <3>;
+				reg = <180 80>;
+				interrupt-parent = <&mpic>;
+				interrupts = <3f 2>;
+                        };
+                };
+
 	};
 
 	pci0: pci@e0008000 {
diff --git a/arch/powerpc/configs/mpc8610_hpcd_defconfig b/arch/powerpc/configs/mpc8610_hpcd_defconfig
index 9614d24..2500ef4 100644
--- a/arch/powerpc/configs/mpc8610_hpcd_defconfig
+++ b/arch/powerpc/configs/mpc8610_hpcd_defconfig
@@ -696,7 +696,7 @@ CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
-CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_SERIAL_OF_PLATFORM is not set
 CONFIG_UNIX98_PTYS=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_IPMI_HANDLER is not set
@@ -708,7 +708,60 @@ CONFIG_UNIX98_PTYS=y
 # CONFIG_RAW_DRIVER is not set
 # CONFIG_TCG_TPM is not set
 CONFIG_DEVPORT=y
-# CONFIG_I2C is not set
+CONFIG_I2C=y
+CONFIG_I2C_BOARDINFO=y
+# CONFIG_I2C_CHARDEV is not set
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
+# CONFIG_I2C_PIIX4 is not set
+CONFIG_I2C_MPC=y
+# CONFIG_I2C_NFORCE2 is not set
+# CONFIG_I2C_OCORES is not set
+# CONFIG_I2C_PARPORT_LIGHT is not set
+# CONFIG_I2C_PROSAVAGE is not set
+# CONFIG_I2C_SAVAGE4 is not set
+# CONFIG_I2C_SIMTEC is not set
+# CONFIG_I2C_SIS5595 is not set
+# CONFIG_I2C_SIS630 is not set
+# CONFIG_I2C_SIS96X is not set
+# CONFIG_I2C_TAOS_EVM is not set
+# CONFIG_I2C_VIA is not set
+# CONFIG_I2C_VIAPRO is not set
+# CONFIG_I2C_VOODOO3 is not set
+
+#
+# Miscellaneous I2C Chip support
+#
+# CONFIG_SENSORS_DS1337 is not set
+# CONFIG_SENSORS_DS1374 is not set
+# CONFIG_DS1682 is not set
+# CONFIG_SENSORS_EEPROM is not set
+# CONFIG_SENSORS_PCF8574 is not set
+# CONFIG_SENSORS_PCA9539 is not set
+# CONFIG_SENSORS_PCF8591 is not set
+# CONFIG_SENSORS_M41T00 is not set
+# CONFIG_SENSORS_MAX6875 is not set
+# CONFIG_SENSORS_TSL2550 is not set
+# CONFIG_I2C_DEBUG_CORE is not set
+# CONFIG_I2C_DEBUG_ALGO is not set
+# CONFIG_I2C_DEBUG_BUS is not set
+# CONFIG_I2C_DEBUG_CHIP is not set
 
 #
 # SPI support
@@ -763,7 +816,119 @@ CONFIG_DUMMY_CONSOLE=y
 #
 # Sound
 #
-# CONFIG_SOUND is not set
+CONFIG_SOUND=y
+
+#
+# Advanced Linux Sound Architecture
+#
+CONFIG_SND=y
+CONFIG_SND_TIMER=y
+CONFIG_SND_PCM=y
+# CONFIG_SND_SEQUENCER is not set
+CONFIG_SND_OSSEMUL=y
+CONFIG_SND_MIXER_OSS=y
+CONFIG_SND_PCM_OSS=y
+# CONFIG_SND_PCM_OSS_PLUGINS is not set
+# CONFIG_SND_DYNAMIC_MINORS is not set
+# CONFIG_SND_SUPPORT_OLD_API is not set
+CONFIG_SND_VERBOSE_PROCFS=y
+# CONFIG_SND_VERBOSE_PRINTK is not set
+# CONFIG_SND_DEBUG is not set
+
+#
+# Generic devices
+#
+# CONFIG_SND_DUMMY is not set
+# CONFIG_SND_MTPAV is not set
+# CONFIG_SND_SERIAL_U16550 is not set
+# CONFIG_SND_MPU401 is not set
+
+#
+# PCI devices
+#
+# CONFIG_SND_AD1889 is not set
+# CONFIG_SND_ALS300 is not set
+# CONFIG_SND_ALS4000 is not set
+# CONFIG_SND_ALI5451 is not set
+# CONFIG_SND_ATIIXP is not set
+# CONFIG_SND_ATIIXP_MODEM is not set
+# CONFIG_SND_AU8810 is not set
+# CONFIG_SND_AU8820 is not set
+# CONFIG_SND_AU8830 is not set
+# CONFIG_SND_AZT3328 is not set
+# CONFIG_SND_BT87X is not set
+# CONFIG_SND_CA0106 is not set
+# CONFIG_SND_CMIPCI is not set
+# CONFIG_SND_CS4281 is not set
+# CONFIG_SND_CS46XX is not set
+# CONFIG_SND_CS5530 is not set
+# CONFIG_SND_DARLA20 is not set
+# CONFIG_SND_GINA20 is not set
+# CONFIG_SND_LAYLA20 is not set
+# CONFIG_SND_DARLA24 is not set
+# CONFIG_SND_GINA24 is not set
+# CONFIG_SND_LAYLA24 is not set
+# CONFIG_SND_MONA is not set
+# CONFIG_SND_MIA is not set
+# CONFIG_SND_ECHO3G is not set
+# CONFIG_SND_INDIGO is not set
+# CONFIG_SND_INDIGOIO is not set
+# CONFIG_SND_INDIGODJ is not set
+# CONFIG_SND_EMU10K1 is not set
+# CONFIG_SND_EMU10K1X is not set
+# CONFIG_SND_ENS1370 is not set
+# CONFIG_SND_ENS1371 is not set
+# CONFIG_SND_ES1938 is not set
+# CONFIG_SND_ES1968 is not set
+# CONFIG_SND_FM801 is not set
+# CONFIG_SND_HDA_INTEL is not set
+# CONFIG_SND_HDSP is not set
+# CONFIG_SND_HDSPM is not set
+# CONFIG_SND_ICE1712 is not set
+# CONFIG_SND_ICE1724 is not set
+# CONFIG_SND_INTEL8X0 is not set
+# CONFIG_SND_INTEL8X0M is not set
+# CONFIG_SND_KORG1212 is not set
+# CONFIG_SND_MAESTRO3 is not set
+# CONFIG_SND_MIXART is not set
+# CONFIG_SND_NM256 is not set
+# CONFIG_SND_PCXHR is not set
+# CONFIG_SND_RIPTIDE is not set
+# CONFIG_SND_RME32 is not set
+# CONFIG_SND_RME96 is not set
+# CONFIG_SND_RME9652 is not set
+# CONFIG_SND_SONICVIBES is not set
+# CONFIG_SND_TRIDENT is not set
+# CONFIG_SND_VIA82XX is not set
+# CONFIG_SND_VIA82XX_MODEM is not set
+# CONFIG_SND_VX222 is not set
+# CONFIG_SND_YMFPCI is not set
+
+#
+# ALSA PowerMac devices
+#
+
+#
+# ALSA PowerPC devices
+#
+
+#
+# System on Chip audio support
+#
+CONFIG_SND_SOC=y
+
+#
+# SoC Audio support for SuperH
+#
+
+#
+# ALSA SoC audio for Freescale SOCs
+#
+CONFIG_SND_SOC_MPC8610=y
+CONFIG_SND_SOC_MPC8610_HPCD=y
+CONFIG_SND_SOC_CS4270=y
+CONFIG_SND_SOC_CS4270_VD33_ERRATA=y
+
 CONFIG_HID_SUPPORT=y
 CONFIG_HID=y
 # CONFIG_HID_DEBUG is not set
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index c6d2f48..0b07485 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -34,9 +34,24 @@
 
 #include <asm/mpic.h>
 
+#include <linux/of_platform.h>
 #include <sysdev/fsl_pci.h>
 #include <sysdev/fsl_soc.h>
 
+static struct of_device_id __initdata mpc8610_ids[] = {
+	{ .compatible = "fsl,mpc8610-immr", },
+	{}
+};
+
+static int __init mpc8610_declare_of_platform_devices(void)
+{
+	/* Without this call, the SSI device driver won't get probed. */
+	of_platform_bus_probe(NULL, mpc8610_ids, NULL);
+
+	return 0;
+}
+machine_device_initcall(mpc86xx_hpcd, mpc8610_declare_of_platform_devices);
+
 void __init
 mpc86xx_hpcd_init_irq(void)
 {
-- 
1.5.2.4
