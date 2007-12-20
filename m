Return-Path: <b04825@freescale.com>
Received: from de01egw02.freescale.net (de01egw02.freescale.net
	[192.88.165.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "de01egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 9A4C0DDE30
	for <linuxppc-dev@ozlabs.org>; Thu, 20 Dec 2007 11:11:55 +1100 (EST)
From: Timur Tabi <timur@freescale.com>
To: linuxppc-dev@ozlabs.org, alsa-devel@alsa-project.org
Subject: [PATCH] ASoC drivers for the Freescale MPC8610 SoC
Date: Wed, 19 Dec 2007 18:03:09 -0600
Message-Id: <11981089894052-git-send-email-timur@freescale.com>
Cc: Timur Tabi <timur@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

This patch adds ALSA SoC device drivers for the Freescale MPC8610 SoC
and the MPC8610-HPCD reference board.

Signed-off-by: Timur Tabi <timur@freescale.com>
---

This patch applies on top of
git://git.kernel.org/pub/scm/linux/kernel/git/perex/alsa.git.

 Documentation/powerpc/booting-without-of.txt |   40 ++
 arch/powerpc/boot/dts/mpc8610_hpcd.dts       |  107 ++++
 arch/powerpc/configs/mpc8610_hpcd_defconfig  |  171 ++++++-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c   |   18 +
 sound/soc/Kconfig                            |    1 +
 sound/soc/Makefile                           |    2 +-
 sound/soc/fsl/Kconfig                        |   21 +
 sound/soc/fsl/Makefile                       |    6 +
 sound/soc/fsl/fsl_dma.c                      |  819 ++++++++++++++++++++++++++
 sound/soc/fsl/fsl_dma.h                      |  149 +++++
 sound/soc/fsl/fsl_ssi.c                      |  614 +++++++++++++++++++
 sound/soc/fsl/fsl_ssi.h                      |  224 +++++++
 sound/soc/fsl/mpc8610_hpcd.c                 |  621 +++++++++++++++++++
 13 files changed, 2789 insertions(+), 4 deletions(-)
 create mode 100644 sound/soc/fsl/Kconfig
 create mode 100644 sound/soc/fsl/Makefile
 create mode 100644 sound/soc/fsl/fsl_dma.c
 create mode 100644 sound/soc/fsl/fsl_dma.h
 create mode 100644 sound/soc/fsl/fsl_ssi.c
 create mode 100644 sound/soc/fsl/fsl_ssi.h
 create mode 100644 sound/soc/fsl/mpc8610_hpcd.c

diff --git a/Documentation/powerpc/booting-without-of.txt b/Documentation/powerpc/booting-without-of.txt
index e9a3cb1..826af91 100644
--- a/Documentation/powerpc/booting-without-of.txt
+++ b/Documentation/powerpc/booting-without-of.txt
@@ -53,6 +53,7 @@ Table of Contents
       j) CFI or JEDEC memory-mapped NOR flash
       k) Global Utilities Block
       l) Xilinx IP cores
+      p) Freescale Synchronous Serial Interface
 
   VII - Specifying interrupt information for devices
     1) interrupts property
@@ -2514,6 +2515,45 @@ platforms are moved over to use the flattened-device-tree model.
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
+       - codec		  : child node that defines an audio codec connected
+		 	    to this SSI
+
+       Child 'codec' node required properties:
+       - compatible	  : compatible list, contains the name of the codec
+
+       Child 'codec' node optional properties:
+       - bus-frequency	  : The frequency of the input clock, which typically
+                            comes from an on-board dedicated oscillator.
+
+
    More devices will be defined as this spec matures.
 
 VII - Specifying interrupt information for devices
diff --git a/arch/powerpc/boot/dts/mpc8610_hpcd.dts b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
index 966edf1..4f12ede 100644
--- a/arch/powerpc/boot/dts/mpc8610_hpcd.dts
+++ b/arch/powerpc/boot/dts/mpc8610_hpcd.dts
@@ -103,6 +103,113 @@
 			reg = <e0000 1000>;
 			fsl,has-rstcr;
 		};
+
+		ssi@16000 {
+			compatible = "fsl,ssi";
+			cell-index = <0>;
+			reg = <16000 100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <3e 2>;
+			fsl,mode = "i2s-slave";
+			codec {
+				compatible = "cirrus,cs4270";
+				/* MCLK source is a stand-alone oscillator */
+				bus-frequency = <bb8000>;
+			};
+		};
+
+		ssi@16100 {
+			compatible = "fsl,ssi";
+			cell-index = <1>;
+			reg = <16100 100>;
+			interrupt-parent = <&mpic>;
+			interrupts = <3f 2>;
+		};
+
+                dma@21300 {
+                        #address-cells = <1>;
+                        #size-cells = <1>;
+                        compatible = "fsl,mpc8610-dma", "fsl,mpc8540-dma";
+                        cell-index = <0>;
+                        reg = <21300 4>; /* DMA general status register */
+                        ranges = <0 21100 200>;
+
+                        dma-channel@0 {
+				compatible = "fsl,mpc8610-dma-channel",
+					"fsl,mpc8540-dma-channel";
+				cell-index = <0>;
+				reg = <0 80>;
+				interrupt-parent = <&mpic>;
+				interrupts = <14 2>;
+                        };
+                        dma-channel@1 {
+				compatible = "fsl,mpc8610-dma-channel",
+					"fsl,mpc8540-dma-channel";
+				cell-index = <1>;
+				reg = <80 80>;
+				interrupt-parent = <&mpic>;
+				interrupts = <15 2>;
+                        };
+                        dma-channel@2 {
+				compatible = "fsl,mpc8610-dma-channel",
+					"fsl,mpc8540-dma-channel";
+				cell-index = <2>;
+				reg = <100 80>;
+				interrupt-parent = <&mpic>;
+				interrupts = <16 2>;
+                        };
+                        dma-channel@3 {
+				compatible = "fsl,mpc8610-dma-channel",
+					"fsl,mpc8540-dma-channel";
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
 
 	pci@e0008000 {
diff --git a/arch/powerpc/configs/mpc8610_hpcd_defconfig b/arch/powerpc/configs/mpc8610_hpcd_defconfig
index 0483211..fb68886 100644
--- a/arch/powerpc/configs/mpc8610_hpcd_defconfig
+++ b/arch/powerpc/configs/mpc8610_hpcd_defconfig
@@ -684,7 +684,7 @@ CONFIG_SERIAL_8250_RSA=y
 CONFIG_SERIAL_CORE=y
 CONFIG_SERIAL_CORE_CONSOLE=y
 # CONFIG_SERIAL_JSM is not set
-CONFIG_SERIAL_OF_PLATFORM=y
+# CONFIG_SERIAL_OF_PLATFORM is not set
 CONFIG_UNIX98_PTYS=y
 # CONFIG_LEGACY_PTYS is not set
 # CONFIG_IPMI_HANDLER is not set
@@ -699,7 +699,60 @@ CONFIG_UNIX98_PTYS=y
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
@@ -746,7 +799,119 @@ CONFIG_DUMMY_CONSOLE=y
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
index 6390895..6e1bde3 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -34,9 +34,27 @@
 
 #include <asm/mpic.h>
 
+#include <asm/of_platform.h>
 #include <sysdev/fsl_pci.h>
 #include <sysdev/fsl_soc.h>
 
+static struct of_device_id mpc8610_ids[] = {
+	{ .type = "soc", },
+	{}
+};
+
+static int __init mpc8610_declare_of_platform_devices(void)
+{
+	if (!machine_is(mpc86xx_hpcd))
+		return 0;
+
+	/* Without this call, the SSI device driver won't get probed. */
+	of_platform_bus_probe(NULL, mpc8610_ids, NULL);
+
+	return 0;
+}
+device_initcall(mpc8610_declare_of_platform_devices);
+
 void __init
 mpc86xx_hpcd_init_irq(void)
 {
diff --git a/sound/soc/Kconfig b/sound/soc/Kconfig
index 97b2552..43bbc60 100644
--- a/sound/soc/Kconfig
+++ b/sound/soc/Kconfig
@@ -28,6 +28,7 @@ source "sound/soc/at91/Kconfig"
 source "sound/soc/pxa/Kconfig"
 source "sound/soc/s3c24xx/Kconfig"
 source "sound/soc/sh/Kconfig"
+source "sound/soc/fsl/Kconfig"
 
 # Supported codecs
 source "sound/soc/codecs/Kconfig"
diff --git a/sound/soc/Makefile b/sound/soc/Makefile
index 3041403..4869c9a 100644
--- a/sound/soc/Makefile
+++ b/sound/soc/Makefile
@@ -1,4 +1,4 @@
 snd-soc-core-objs := soc-core.o soc-dapm.o
 
 obj-$(CONFIG_SND_SOC)	+= snd-soc-core.o
-obj-$(CONFIG_SND_SOC)	+= codecs/ at91/ pxa/ s3c24xx/ sh/
+obj-$(CONFIG_SND_SOC)	+= codecs/ at91/ pxa/ s3c24xx/ sh/ fsl/
diff --git a/sound/soc/fsl/Kconfig b/sound/soc/fsl/Kconfig
new file mode 100644
index 0000000..4a5bbd2
--- /dev/null
+++ b/sound/soc/fsl/Kconfig
@@ -0,0 +1,21 @@
+menu "ALSA SoC audio for Freescale SOCs"
+
+config SND_SOC_MPC8610
+	bool "ALSA SoC support for the MPC8610 SOC"
+	depends on SND_SOC #&& MPC8610_HPCD
+	default y #if MPC8610
+	help
+	  Say Y if you want to add support for codecs attached to the SSI
+          device on an MPC8610.
+
+config SND_SOC_MPC8610_HPCD
+	# ALSA SoC support for Freescale MPC8610HPCD
+	bool "ALSA SoC support for the Freescale MPC8610 HPCD board"
+	depends on SND_SOC_MPC8610
+	select SND_SOC_CS4270
+	select SND_SOC_CS4270_VD33_ERRATA
+	default y #if MPC8610_HPCD
+	help
+	  Say Y if you want to enable audio on the Freescale MPC8610 HPCD.
+
+endmenu
diff --git a/sound/soc/fsl/Makefile b/sound/soc/fsl/Makefile
new file mode 100644
index 0000000..62f680a
--- /dev/null
+++ b/sound/soc/fsl/Makefile
@@ -0,0 +1,6 @@
+# MPC8610 HPCD Machine Support
+obj-$(CONFIG_SND_SOC_MPC8610_HPCD) += mpc8610_hpcd.o
+
+# MPC8610 Platform Support
+obj-$(CONFIG_SND_SOC_MPC8610) += fsl_ssi.o fsl_dma.o
+
diff --git a/sound/soc/fsl/fsl_dma.c b/sound/soc/fsl/fsl_dma.c
new file mode 100644
index 0000000..6b86be0
--- /dev/null
+++ b/sound/soc/fsl/fsl_dma.c
@@ -0,0 +1,819 @@
+/*
+ * Freescale DMA ALSA SoC PCM driver
+ *
+ * Author: Timur Tabi <timur@freescale.com>
+ *
+ * Copyright 2007 Freescale Semiconductor, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ *
+ * This driver implements ASoC support for the Elo DMA controller, which is
+ * the DMA controller on Freescale 83xx, 85xx, and 86xx SOCs. In ALSA terms,
+ * the PCM driver is what handles the DMA buffer.
+ */
+
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/platform_device.h>
+#include <linux/dma-mapping.h>
+#include <linux/interrupt.h>
+#include <linux/delay.h>
+
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/soc.h>
+
+#include <asm/io.h>
+
+#include "fsl_dma.h"
+
+/*
+ * The formats that the DMA controller supports, which is anything
+ * that is 8, 16, or 32 bits.
+ */
+#define FSLDMA_PCM_FORMATS (SNDRV_PCM_FMTBIT_S8 	| \
+			    SNDRV_PCM_FMTBIT_U8 	| \
+			    SNDRV_PCM_FMTBIT_S16_LE     | \
+			    SNDRV_PCM_FMTBIT_S16_BE     | \
+			    SNDRV_PCM_FMTBIT_U16_LE     | \
+			    SNDRV_PCM_FMTBIT_U16_BE     | \
+			    SNDRV_PCM_FMTBIT_S24_LE     | \
+			    SNDRV_PCM_FMTBIT_S24_BE     | \
+			    SNDRV_PCM_FMTBIT_U24_LE     | \
+			    SNDRV_PCM_FMTBIT_U24_BE     | \
+			    SNDRV_PCM_FMTBIT_S32_LE     | \
+			    SNDRV_PCM_FMTBIT_S32_BE     | \
+			    SNDRV_PCM_FMTBIT_U32_LE     | \
+			    SNDRV_PCM_FMTBIT_U32_BE)
+
+#define FSLDMA_PCM_RATES (SNDRV_PCM_RATE_5512 | SNDRV_PCM_RATE_8000_192000 | \
+			  SNDRV_PCM_RATE_CONTINUOUS)
+
+/* DMA global data.  This structure is used by fsl_dma_open() to determine
+ * which DMA channels to assign to a substream.  Unfortunately, ASoC V1 does
+ * not allow the machine driver to provide this information to the PCM
+ * driver in advance, and there's no way to differentiate between the two
+ * DMA controllers.  So for now, this driver only supports one SSI device
+ * using two DMA channels.  We cannot support multiple DMA devices.
+ *
+ * ssi_stx_phys: bus address of SSI STX register
+ * ssi_srx_phys: bus address of SSI SRX register
+ * dma_channel: pointer to the DMA channel's registers
+ * irq: IRQ for this DMA channel
+ * assigned: set to 1 if that DMA channel is assigned to a substream
+ */
+static struct {
+	dma_addr_t ssi_stx_phys;
+	dma_addr_t ssi_srx_phys;
+	struct ccsr_dma_channel __iomem *dma_channel[2];
+	unsigned int irq[2];
+	unsigned int assigned[2];
+} dma_global_data;
+
+/*
+ * The number of DMA links to use.  Two is the bare minimum, but if you
+ * have really small links you might need more.
+ */
+#define NUM_DMA_LINKS   2
+
+/* Per-substream DMA data
+ *
+ * Each substream has a 1-to-1 association with a DMA channel.
+ *
+ * The link[] array is first because it needs to be aligned on a 32-byte
+ * boundary, so putting it first will ensure alignment without padding the
+ * structure.
+ *
+ * link[]: array of link descriptors
+ * controller_id: which DMA controller (0, 1, ...)
+ * channel_id: which DMA channel on the controller (0, 1, 2, ...)
+ * dma_channel: pointer to the DMA channel's registers
+ * irq: IRQ for this DMA channel
+ * substream: pointer to the substream object, needed by the ISR
+ * ssi_sxx_phys: bus address of the STX or SRX register to use
+ * ld_buf_phys: physical address of the LD buffer
+ * current_link: index into link[] of the link currently being processed
+ * dma_buf_phys: physical address of the DMA buffer
+ * dma_buf_next: physical address of the next period to process
+ * dma_buf_end: physical address of the byte after the end of the DMA buffer
+ * period_size: the size of a single period
+ */
+struct fsl_dma_private {
+	struct fsl_dma_link_descriptor link[NUM_DMA_LINKS];
+	unsigned int controller_id;
+	unsigned int channel_id;
+	struct ccsr_dma_channel __iomem *dma_channel;
+	unsigned int irq;
+	struct snd_pcm_substream *substream;
+	dma_addr_t ssi_sxx_phys;
+	dma_addr_t ld_buf_phys;
+	unsigned int current_link;
+	dma_addr_t dma_buf_phys;
+	dma_addr_t dma_buf_next;
+	dma_addr_t dma_buf_end;
+	size_t period_size;
+	unsigned int num_periods;
+};
+
+/*
+ * Define the hardware characteristics for the PCM hardware.
+ *
+ * The PCM hardware is the Freescale DMA controller.  This structure defines
+ * the capabilities of that hardware.
+ *
+ * Since the sampling rate and data format are not controlled by the DMA
+ * controller, we specify no limits for those values.  The only exception is
+ * period_bytes_min, which is set to a reasonably low value to prevent the
+ * DMA controller from generating too many interrupts per second.
+ *
+ * Since each link descriptor has a 32-bit byte count field, we set
+ * period_bytes_max to the largest 32-bit number.  We also have no maximum
+ * number of periods.
+ */
+static const struct snd_pcm_hardware fsl_dma_hardware = {
+
+	.info   		= SNDRV_PCM_INFO_INTERLEAVED,
+	.formats		= FSLDMA_PCM_FORMATS,
+	.rates  		= FSLDMA_PCM_RATES,
+	.rate_min       	= 5512,
+	.rate_max       	= 192000,
+	.period_bytes_min       = 512,  	/* A reasonable limit */
+	.period_bytes_max       = (u32) -1,
+	.periods_min    	= NUM_DMA_LINKS,
+	.periods_max    	= (unsigned int) -1,
+	.buffer_bytes_max       = 128 * 1024,   /* A reasonable limit */
+};
+
+/*
+ * Tell ALSA that the DMA transfer has aborted
+ *
+ * This function should be called by the ISR whenever the DMA controller
+ * halts data transfer.
+ */
+static void fsl_dma_abort_stream(struct snd_pcm_substream *substream)
+{
+	unsigned long flags;
+
+	snd_pcm_stream_lock_irqsave(substream, flags);
+
+	if (snd_pcm_running(substream))
+		snd_pcm_stop(substream, SNDRV_PCM_STATE_XRUN);
+
+	snd_pcm_stream_unlock_irqrestore(substream, flags);
+}
+
+/*
+ * Update the link descriptor pointers to point to the next period buffer.
+*/
+static void fsl_dma_update_pointers(struct fsl_dma_private *dma_private)
+{
+	struct fsl_dma_link_descriptor *link =
+		&dma_private->link[dma_private->current_link];
+
+	/* Update our link descriptors to point to the next period */
+	if (dma_private->substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		link->source_addr =
+			cpu_to_be32(dma_private->dma_buf_next);
+	else
+		link->dest_addr =
+			cpu_to_be32(dma_private->dma_buf_next);
+
+	/* Update our variables for next time */
+	dma_private->dma_buf_next += dma_private->period_size;
+
+	if (dma_private->dma_buf_next >= dma_private->dma_buf_end)
+		dma_private->dma_buf_next = dma_private->dma_buf_phys;
+
+	if (++dma_private->current_link >= NUM_DMA_LINKS)
+		dma_private->current_link = 0;
+}
+
+/*
+ * Interrupt handler for the DMA controller
+ */
+static irqreturn_t fsl_dma_isr(int irq, void *dev_id)
+{
+	struct fsl_dma_private *dma_private = dev_id;
+	struct ccsr_dma_channel __iomem *dma_channel = dma_private->dma_channel;
+	irqreturn_t ret = IRQ_NONE;
+	u32 sr, sr2 = 0;
+
+	/* We got an interrupt, so read the status register to see what we
+	   were interrupted for.
+	 */
+	sr = in_be32(&dma_channel->sr);
+
+	if (sr & CCSR_DMA_SR_TE) {
+		dev_err(dma_private->substream->pcm->card->dev,
+			"DMA transmit error (controller=%u channel=%u irq=%u\n",
+			dma_private->controller_id,
+			dma_private->channel_id, irq);
+		fsl_dma_abort_stream(dma_private->substream);
+		sr2 |= CCSR_DMA_SR_TE;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sr & CCSR_DMA_SR_CH)
+		ret = IRQ_HANDLED;
+
+	if (sr & CCSR_DMA_SR_PE) {
+		dev_err(dma_private->substream->pcm->card->dev,
+			"DMA%u programming error (channel=%u irq=%u)\n",
+			dma_private->controller_id,
+			dma_private->channel_id, irq);
+		fsl_dma_abort_stream(dma_private->substream);
+		sr2 |= CCSR_DMA_SR_PE;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sr & CCSR_DMA_SR_EOLNI) {
+		sr2 |= CCSR_DMA_SR_EOLNI;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sr & CCSR_DMA_SR_CB)
+		ret = IRQ_HANDLED;
+
+	if (sr & CCSR_DMA_SR_EOSI) {
+		struct snd_pcm_substream *substream = dma_private->substream;
+
+		/* Tell ALSA we completed a period. */
+		snd_pcm_period_elapsed(substream);
+
+		/*
+		 * Update our link descriptors to point to the next period. We
+		 * only need to do this if the number of periods is not equal to
+		 * the number of links.
+		 */
+		if (dma_private->num_periods != NUM_DMA_LINKS)
+			fsl_dma_update_pointers(dma_private);
+
+		sr2 |= CCSR_DMA_SR_EOSI;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sr & CCSR_DMA_SR_EOLSI) {
+		sr2 |= CCSR_DMA_SR_EOLSI;
+		ret = IRQ_HANDLED;
+	}
+
+	/* Clear the bits that we set */
+	if (sr2)
+		out_be32(&dma_channel->sr, sr2);
+
+	return ret;
+}
+
+/*
+ * Initialize this PCM driver.
+ *
+ * This function is called when the codec driver calls snd_soc_new_pcms(),
+ * once for each .dai_link in the machine driver's snd_soc_machine
+ * structure.
+ */
+static int fsl_dma_new(struct snd_card *card, struct snd_soc_codec_dai *dai,
+	struct snd_pcm *pcm)
+{
+	static u64 fsl_dma_dmamask = 0xffffffff;
+	int ret;
+
+	if (!card->dev->dma_mask)
+		card->dev->dma_mask = &fsl_dma_dmamask;
+
+	if (!card->dev->coherent_dma_mask)
+		card->dev->coherent_dma_mask = fsl_dma_dmamask;
+
+	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->dev,
+		fsl_dma_hardware.buffer_bytes_max,
+		&pcm->streams[0].substream->dma_buffer);
+	if (ret) {
+		dev_err(card->dev,
+			"Can't allocate playback DMA buffer (size=%u)\n",
+			fsl_dma_hardware.buffer_bytes_max);
+		return -ENOMEM;
+	}
+
+	ret = snd_dma_alloc_pages(SNDRV_DMA_TYPE_DEV, pcm->dev,
+		fsl_dma_hardware.buffer_bytes_max,
+		&pcm->streams[1].substream->dma_buffer);
+	if (ret) {
+		snd_dma_free_pages(&pcm->streams[0].substream->dma_buffer);
+		dev_err(card->dev,
+			"Can't allocate capture DMA buffer (size=%u)\n",
+			fsl_dma_hardware.buffer_bytes_max);
+		return -ENOMEM;
+	}
+
+	return 0;
+}
+
+/*
+ * Open a new stream.
+ *
+ * Each stream has its own DMA buffer.
+ */
+static int fsl_dma_open(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct fsl_dma_private *dma_private;
+	dma_addr_t ld_buf_phys;
+	unsigned int channel;
+	int ret = 0;
+
+	/*
+	 * Reject any DMA buffer whose size is not a multiple of the period
+	 * size.  We need to make sure that the DMA buffer can be evenly divided
+	 * into periods.
+	 */
+	ret = snd_pcm_hw_constraint_integer(runtime,
+		SNDRV_PCM_HW_PARAM_PERIODS);
+	if (ret < 0) {
+		dev_err(substream->pcm->card->dev, "invalid buffer size\n");
+		return ret;
+	}
+
+	channel = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
+
+	if (dma_global_data.assigned[channel]) {
+		dev_err(substream->pcm->card->dev,
+			"DMA channel already assigned\n");
+		return -EBUSY;
+	}
+
+	dma_private = dma_alloc_coherent(substream->pcm->dev,
+		sizeof(struct fsl_dma_private), &ld_buf_phys, GFP_KERNEL);
+	if (!dma_private) {
+		dev_err(substream->pcm->card->dev,
+			"can't allocate DMA private data\n");
+		return -ENOMEM;
+	}
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		dma_private->ssi_sxx_phys = dma_global_data.ssi_stx_phys;
+	else
+		dma_private->ssi_sxx_phys = dma_global_data.ssi_srx_phys;
+
+	dma_private->dma_channel = dma_global_data.dma_channel[channel];
+	dma_private->irq = dma_global_data.irq[channel];
+	dma_private->substream = substream;
+	dma_private->ld_buf_phys = ld_buf_phys;
+	dma_private->dma_buf_phys = substream->dma_buffer.addr;
+
+	/* We only support one DMA controller for now */
+	dma_private->controller_id = 0;
+	dma_private->channel_id = channel;
+
+	ret = request_irq(dma_private->irq, fsl_dma_isr, 0, "DMA", dma_private);
+	if (ret) {
+		dev_err(substream->pcm->card->dev,
+			"can't register ISR for IRQ %u (ret=%i)\n",
+			dma_private->irq, ret);
+		dma_free_coherent(substream->pcm->dev,
+			sizeof(struct fsl_dma_private),
+			dma_private, dma_private->ld_buf_phys);
+		return ret;
+	}
+
+	dma_global_data.assigned[channel] = 1;
+
+	snd_pcm_set_runtime_buffer(substream, &substream->dma_buffer);
+	snd_soc_set_runtime_hwparams(substream, &fsl_dma_hardware);
+	runtime->private_data = dma_private;
+
+	return 0;
+}
+
+/*
+ * Allocate the DMA buffer and the DMA link descriptors.
+ *
+ * ALSA divides the DMA buffer into N periods.  We create NUM_DMA_LINKS link
+ * descriptors that ping-pong from one period to the next.  For example, if
+ * there are six periods and two link descriptors, this is how they look
+ * before playback starts:
+ *
+ *      	   The last link descriptor
+ *   ____________  points back to the first
+ *  |   	 |
+ *  V   	 |
+ *  ___    ___   |
+ * |   |->|   |->|
+ * |___|  |___|
+ *   |      |
+ *   |      |
+ *   V      V
+ *  _________________________________________
+ * |      |      |      |      |      |      |  The DMA buffer is
+ * |      |      |      |      |      |      |    divided into 6 parts
+ * |______|______|______|______|______|______|
+ *
+ * and here's how they look after the first period is finished playing:
+ *
+ *   ____________
+ *  |   	 |
+ *  V   	 |
+ *  ___    ___   |
+ * |   |->|   |->|
+ * |___|  |___|
+ *   |      |
+ *   |______________
+ *          |       |
+ *          V       V
+ *  _________________________________________
+ * |      |      |      |      |      |      |
+ * |      |      |      |      |      |      |
+ * |______|______|______|______|______|______|
+ *
+ * The first link descriptor now points to the third period.  The DMA
+ * controller is currently playing the second period.  When it finishes, it
+ * will jump back to the first descriptor and play the third period.
+ *
+ * There are four reasons we do this:
+ *
+ * 1. The only way to get the DMA controller to automatically restart the
+ *    transfer when it gets to the end of the buffer is to use chaining
+ *    mode.  Basic direct mode doesn't offer that feature.
+ * 2. We need to receive an interrupt at the end of every period.  The DMA
+ *    controller can generate an interrupt at the end of every link transfer
+ *    (aka segment).  Making each period into a DMA segment will give us the
+ *    interrupts we need.
+ * 3. By creating only two link descriptors, regardless of the number of
+ *    periods, we do not need to reallocate the link descriptors if the
+ *    number of periods changes.
+ * 4. All of the audio data is still stored in a single, contiguous DMA
+ *    buffer, which is what ALSA expects.  We're just dividing it into
+ *    contiguous parts, and creating a link descriptor for each one.
+ *
+ * Note that due to a quirk of the SSI's STX register, the target address
+ * for the DMA operations depends on the sample size.  So we don't program
+ * the dest_addr (for playback -- source_addr for capture) fields in the
+ * link descriptors here.  We do that in fsl_dma_prepare()
+ */
+static int fsl_dma_hw_params(struct snd_pcm_substream *substream,
+				 struct snd_pcm_hw_params *hw_params)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct fsl_dma_private *dma_private = runtime->private_data;
+	struct ccsr_dma_channel __iomem *dma_channel = dma_private->dma_channel;
+
+	dma_addr_t temp_addr;   /* Pointer to next period */
+	u64 temp_link;  	/* Pointer to next link descriptor */
+	u32 mr; 		/* Temporary variable for MR register */
+
+	unsigned int i;
+
+	/* Get all the parameters we need */
+	size_t buffer_size = params_buffer_bytes(hw_params);
+	size_t period_size = params_period_bytes(hw_params);
+
+	/* Initialize our DMA tracking variables */
+	dma_private->period_size = period_size;
+	dma_private->num_periods = params_periods(hw_params);
+	dma_private->dma_buf_end = dma_private->dma_buf_phys + buffer_size;
+	dma_private->dma_buf_next = dma_private->dma_buf_phys +
+		(NUM_DMA_LINKS * period_size);
+	if (dma_private->dma_buf_next >= dma_private->dma_buf_end)
+		dma_private->dma_buf_next = dma_private->dma_buf_phys;
+
+	/*
+	 * Initialize each link descriptor.
+	 *
+	 * The actual address in STX0 (destination for playback, source for
+	 * capture) is based on the sample size, but we don't know the sample
+	 * size in this function, so we'll have to adjust that later.  See
+	 * comments in fsl_dma_prepare().
+	 *
+	 * The DMA controller does not have a cache, so the CPU does not
+	 * need to tell it to flush its cache.  However, the DMA
+	 * controller does need to tell the CPU to flush its cache.
+	 * That's what the SNOOP bit does.
+	 *
+	 * Also, even though the DMA controller supports 36-bit addressing, for
+	 * simplicity we currently support only 32-bit addresses for the audio
+	 * buffer itself.
+	 */
+	temp_addr = substream->dma_buffer.addr;
+	temp_link = dma_private->ld_buf_phys +
+		sizeof(struct fsl_dma_link_descriptor);
+
+	for (i = 0; i < NUM_DMA_LINKS; i++) {
+		struct fsl_dma_link_descriptor *link = &dma_private->link[i];
+
+		link->count = cpu_to_be32(period_size);
+		link->source_attr = cpu_to_be32(CCSR_DMA_ATR_SNOOP);
+		link->dest_attr = cpu_to_be32(CCSR_DMA_ATR_SNOOP);
+		link->next = cpu_to_be64(temp_link);
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			link->source_addr = cpu_to_be32(temp_addr);
+		else
+			link->dest_addr = cpu_to_be32(temp_addr);
+
+		temp_addr += period_size;
+		temp_link += sizeof(struct fsl_dma_link_descriptor);
+	}
+	/* The last link descriptor points to the first */
+	dma_private->link[i - 1].next = cpu_to_be64(dma_private->ld_buf_phys);
+
+	/* Tell the DMA controller where the first link descriptor is */
+	out_be32(&dma_channel->clndar,
+		CCSR_DMA_CLNDAR_ADDR(dma_private->ld_buf_phys));
+	out_be32(&dma_channel->eclndar,
+		CCSR_DMA_ECLNDAR_ADDR(dma_private->ld_buf_phys));
+
+	/* The manual says the BCR must be clear before enabling EMP */
+	out_be32(&dma_channel->bcr, 0);
+
+	/* Program the mode register for interrupts, external master control,
+	   and source/destination hold.  Also clear the Channel Abort bit.
+	 */
+	mr = in_be32(&dma_channel->mr) &
+		~(CCSR_DMA_MR_CA | CCSR_DMA_MR_DAHE | CCSR_DMA_MR_SAHE);
+
+	/*
+	 * We want External Master Start and External Master Pause enabled,
+	 * because the SSI is controlling the DMA controller.  We want the DMA
+	 * controller to be set up in advance, and then we signal only the SSI
+	 * to start transfering.
+	 *
+	 * We want End-Of-Segment Interrupts enabled, because this will generate
+	 * an interrupt at the end of each segment (each link descriptor
+	 * represents one segment).  Each DMA segment is the same thing as an
+	 * ALSA period, so this is how we get an interrupt at the end of every
+	 * period.
+	 *
+	 * We want Error Interrupt enabled, so that we can get an error if
+	 * the DMA controller is mis-programmed somehow.
+	 */
+	mr |= CCSR_DMA_MR_EOSIE | CCSR_DMA_MR_EIE | CCSR_DMA_MR_EMP_EN |
+		CCSR_DMA_MR_EMS_EN;
+
+	/* For playback, we want the destination address to be held.  For
+	   capture, set the source address to be held. */
+	mr |= (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) ?
+		CCSR_DMA_MR_DAHE : CCSR_DMA_MR_SAHE;
+
+	out_be32(&dma_channel->mr, mr);
+
+	return 0;
+}
+
+/*
+ * Prepare the DMA registers for playback.
+ *
+ * This function is called after the specifics of the audio data are known,
+ * i.e. snd_pcm_runtime is initialized.
+ *
+ * In this function, we finish programming the registers of the DMA
+ * controller that are dependent on the sample size.
+ *
+ * One of the drawbacks with big-endian is that when copying integers of
+ * different sizes to a fixed-sized register, the address to which the
+ * integer must be copied is dependent on the size of the integer.
+ *
+ * For example, if P is the address of a 32-bit register, and X is a 32-bit
+ * integer, then X should be copied to address P.  However, if X is a 16-bit
+ * integer, then it should be copied to P+2.  If X is an 8-bit register,
+ * then it should be copied to P+3.
+ *
+ * So for playback of 8-bit samples, the DMA controller must transfer single
+ * bytes from the DMA buffer to the last byte of the STX0 register, i.e.
+ * offset by 3 bytes. For 16-bit samples, the offset is two bytes.
+ *
+ * For 24-bit samples, the offset is 1 byte.  However, the DMA controller
+ * does not support 3-byte copies (the DAHTS register supports only 1, 2, 4,
+ * and 8 bytes at a time).  So we do not support packed 24-bit samples.
+ * 24-bit data must be padded to 32 bits.
+ */
+static int fsl_dma_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct fsl_dma_private *dma_private = runtime->private_data;
+	struct ccsr_dma_channel __iomem *dma_channel = dma_private->dma_channel;
+	u32 mr;
+	unsigned int i;
+	dma_addr_t ssi_sxx_phys;	/* Bus address of SSI STX register */
+	unsigned int frame_size;	/* Number of bytes per frame */
+
+	ssi_sxx_phys = dma_private->ssi_sxx_phys;
+
+	mr = in_be32(&dma_channel->mr) & ~(CCSR_DMA_MR_BWC_MASK |
+		  CCSR_DMA_MR_SAHTS_MASK | CCSR_DMA_MR_DAHTS_MASK);
+
+	switch (runtime->sample_bits) {
+	case 8:
+		mr |= CCSR_DMA_MR_DAHTS_1 | CCSR_DMA_MR_SAHTS_1;
+		ssi_sxx_phys += 3;
+		break;
+	case 16:
+		mr |= CCSR_DMA_MR_DAHTS_2 | CCSR_DMA_MR_SAHTS_2;
+		ssi_sxx_phys += 2;
+		break;
+	case 32:
+		mr |= CCSR_DMA_MR_DAHTS_4 | CCSR_DMA_MR_SAHTS_4;
+		break;
+	default:
+		dev_err(substream->pcm->card->dev,
+			"unsupported sample size %u\n", runtime->sample_bits);
+		return -EINVAL;
+	}
+
+	frame_size = runtime->frame_bits / 8;
+	/*
+	 * BWC should always be a multiple of the frame size.  BWC determines
+	 * how many bytes are sent/received before the DMA controller checks the
+	 * SSI to see if it needs to stop.  For playback, the transmit FIFO can
+	 * hold three frames, so we want to send two frames at a time. For
+	 * capture, the receive FIFO is triggered when it contains one frame, so
+	 * we want to receive one frame at a time.
+	 */
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		mr |= CCSR_DMA_MR_BWC(2 * frame_size);
+	else
+		mr |= CCSR_DMA_MR_BWC(frame_size);
+
+	out_be32(&dma_channel->mr, mr);
+
+	/*
+	 * Program the address of the DMA transfer to/from the SSI.
+	 */
+	for (i = 0; i < NUM_DMA_LINKS; i++) {
+		struct fsl_dma_link_descriptor *link = &dma_private->link[i];
+
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			link->dest_addr = cpu_to_be32(ssi_sxx_phys);
+		else
+			link->source_addr = cpu_to_be32(ssi_sxx_phys);
+	}
+
+	return 0;
+}
+
+/*
+ * fsl_dma_pointer - 'pointer' PCM operation callback function
+ *
+ * This function is called by ALSA when ALSA wants to know where in the
+ * stream buffer the hardware currently is.
+ *
+ * For playback, the SAR register contains the physical address of the most
+ * recent DMA transfer.  For capture, the value is in the DAR register.
+ *
+ * The base address of the buffer is stored in the source_addr field of the
+ * first link descriptor.
+ */
+static snd_pcm_uframes_t fsl_dma_pointer(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct fsl_dma_private *dma_private = runtime->private_data;
+	struct ccsr_dma_channel __iomem *dma_channel = dma_private->dma_channel;
+	dma_addr_t position;
+	snd_pcm_uframes_t frames;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		position = in_be32(&dma_channel->sar);
+	else
+		position = in_be32(&dma_channel->dar);
+
+	frames = bytes_to_frames(runtime, position - dma_private->dma_buf_phys);
+
+	/*
+	 * If the current address is just past the end of the buffer, wrap it
+	 * around.
+	 */
+	if (frames == runtime->buffer_size)
+		frames = 0;
+
+	return frames;
+}
+
+/*
+ * Release the resources allocated in fsl_dma_hw_params() and
+ * de-program the registers.  This function can be called multiple times.
+ */
+static int fsl_dma_hw_free(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct fsl_dma_private *dma_private = runtime->private_data;
+
+	if (dma_private) {
+		struct ccsr_dma_channel __iomem *dma_channel;
+
+		dma_channel = dma_private->dma_channel;
+
+		dump_dma_regs(__FUNCTION__, __LINE__, dma_channel);
+		dump_lds(dma_private);
+
+		/* Stop the DMA */
+		out_be32(&dma_channel->mr, CCSR_DMA_MR_CA);
+		out_be32(&dma_channel->mr, 0);
+
+		/* Reset all the other registers */
+		out_be32(&dma_channel->sr, -1);
+		out_be32(&dma_channel->clndar, 0);
+		out_be32(&dma_channel->eclndar, 0);
+		out_be32(&dma_channel->satr, 0);
+		out_be32(&dma_channel->sar, 0);
+		out_be32(&dma_channel->datr, 0);
+		out_be32(&dma_channel->dar, 0);
+		out_be32(&dma_channel->bcr, 0);
+		out_be32(&dma_channel->nlndar, 0);
+		out_be32(&dma_channel->enlndar, 0);
+	}
+
+	return 0;
+}
+
+/*
+ * Close the stream.
+ */
+static int fsl_dma_close(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct fsl_dma_private *dma_private = runtime->private_data;
+	int dir = substream->stream == SNDRV_PCM_STREAM_PLAYBACK ? 0 : 1;
+
+	if (dma_private) {
+		if (dma_private->irq)
+			free_irq(dma_private->irq, dma_private);
+
+		if (dma_private->ld_buf_phys) {
+			dma_unmap_single(substream->pcm->dev,
+				dma_private->ld_buf_phys,
+				sizeof(dma_private->link), DMA_TO_DEVICE);
+		}
+
+		/* Deallocate the fsl_dma_private structure */
+		dma_free_coherent(substream->pcm->dev,
+			sizeof(struct fsl_dma_private),
+			dma_private, dma_private->ld_buf_phys);
+		substream->runtime->private_data = NULL;
+	}
+
+	dma_global_data.assigned[dir] = 0;
+
+	return 0;
+}
+
+/*
+ * Remove this PCM driver.
+ */
+static void fsl_dma_free_dma_buffers(struct snd_pcm *pcm)
+{
+	struct snd_pcm_substream *substream;
+	unsigned int i;
+
+	for (i = 0; i < ARRAY_SIZE(pcm->streams); i++) {
+		substream = pcm->streams[i].substream;
+		if (substream) {
+			snd_dma_free_pages(&substream->dma_buffer);
+			substream->dma_buffer.area = NULL;
+			substream->dma_buffer.addr = 0;
+		}
+	}
+}
+
+static struct snd_pcm_ops fsl_dma_ops = {
+	.open   	= fsl_dma_open,
+	.close  	= fsl_dma_close,
+	.ioctl  	= snd_pcm_lib_ioctl,
+	.hw_params      = fsl_dma_hw_params,
+	.hw_free	= fsl_dma_hw_free,
+	.prepare	= fsl_dma_prepare,
+	.pointer	= fsl_dma_pointer,
+};
+
+struct snd_soc_platform fsl_soc_platform = {
+	.name   	= "fsl-dma",
+	.pcm_ops	= &fsl_dma_ops,
+	.pcm_new	= fsl_dma_new,
+	.pcm_free       = fsl_dma_free_dma_buffers,
+};
+EXPORT_SYMBOL_GPL(fsl_soc_platform);
+
+int fsl_dma_configure(struct fsl_dma_info *dma_info)
+{
+	static int initialized;
+
+	/* We only support one DMA controller for now */
+	if (initialized)
+		return 0;
+
+	dma_global_data.ssi_stx_phys = dma_info->ssi_stx_phys;
+	dma_global_data.ssi_srx_phys = dma_info->ssi_srx_phys;
+	dma_global_data.dma_channel[0] = dma_info->dma_channel[0];
+	dma_global_data.dma_channel[1] = dma_info->dma_channel[1];
+	dma_global_data.irq[0] = dma_info->dma_irq[0];
+	dma_global_data.irq[1] = dma_info->dma_irq[1];
+	dma_global_data.assigned[0] = 0;
+	dma_global_data.assigned[1] = 0;
+
+	initialized = 1;
+	return 1;
+}
+EXPORT_SYMBOL_GPL(fsl_dma_configure);
+
+MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
+MODULE_DESCRIPTION("Freescale FSL Elo DMA ASoC PCM module");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/fsl/fsl_dma.h b/sound/soc/fsl/fsl_dma.h
new file mode 100644
index 0000000..430a6ce
--- /dev/null
+++ b/sound/soc/fsl/fsl_dma.h
@@ -0,0 +1,149 @@
+/*
+ * mpc8610-pcm.h - ALSA PCM interface for the Freescale MPC8610 SoC
+ *
+ * This program is free software; you can redistribute it and/or modify
+ * it under the terms of the GNU General Public License version 2 as
+ * published by the Free Software Foundation.
+ */
+
+#ifndef _MPC8610_PCM_H
+#define _MPC8610_PCM_H
+
+struct ccsr_dma {
+	u8 res0[0x100];
+	struct ccsr_dma_channel {
+		__be32 mr;      /* Mode register */
+		__be32 sr;      /* Status register */
+		__be32 eclndar; /* Current link descriptor extended addr reg */
+		__be32 clndar;  /* Current link descriptor address register */
+		__be32 satr;    /* Source attributes register */
+		__be32 sar;     /* Source address register */
+		__be32 datr;    /* Destination attributes register */
+		__be32 dar;     /* Destination address register */
+		__be32 bcr;     /* Byte count register */
+		__be32 enlndar; /* Next link descriptor extended address reg */
+		__be32 nlndar;  /* Next link descriptor address register */
+		u8 res1[4];
+		__be32 eclsdar; /* Current list descriptor extended addr reg */
+		__be32 clsdar;  /* Current list descriptor address register */
+		__be32 enlsdar; /* Next list descriptor extended address reg */
+		__be32 nlsdar;  /* Next list descriptor address register */
+		__be32 ssr;     /* Source stride register */
+		__be32 dsr;     /* Destination stride register */
+		u8 res2[0x38];
+	} channel[4];
+	__be32 dgsr;
+};
+
+#define CCSR_DMA_MR_BWC_DISABLED	0x0F000000
+#define CCSR_DMA_MR_BWC_SHIFT   	24
+#define CCSR_DMA_MR_BWC_MASK    	0x0F000000
+#define CCSR_DMA_MR_BWC(x) \
+	((ilog2(x) << CCSR_DMA_MR_BWC_SHIFT) & CCSR_DMA_MR_BWC_MASK)
+#define CCSR_DMA_MR_EMP_EN      	0x00200000
+#define CCSR_DMA_MR_EMS_EN      	0x00040000
+#define CCSR_DMA_MR_DAHTS_MASK  	0x00030000
+#define CCSR_DMA_MR_DAHTS_1     	0x00000000
+#define CCSR_DMA_MR_DAHTS_2     	0x00010000
+#define CCSR_DMA_MR_DAHTS_4     	0x00020000
+#define CCSR_DMA_MR_DAHTS_8     	0x00030000
+#define CCSR_DMA_MR_SAHTS_MASK  	0x0000C000
+#define CCSR_DMA_MR_SAHTS_1     	0x00000000
+#define CCSR_DMA_MR_SAHTS_2     	0x00004000
+#define CCSR_DMA_MR_SAHTS_4     	0x00008000
+#define CCSR_DMA_MR_SAHTS_8     	0x0000C000
+#define CCSR_DMA_MR_DAHE		0x00002000
+#define CCSR_DMA_MR_SAHE		0x00001000
+#define CCSR_DMA_MR_SRW 		0x00000400
+#define CCSR_DMA_MR_EOSIE       	0x00000200
+#define CCSR_DMA_MR_EOLNIE      	0x00000100
+#define CCSR_DMA_MR_EOLSIE      	0x00000080
+#define CCSR_DMA_MR_EIE 		0x00000040
+#define CCSR_DMA_MR_XFE 		0x00000020
+#define CCSR_DMA_MR_CDSM_SWSM   	0x00000010
+#define CCSR_DMA_MR_CA  		0x00000008
+#define CCSR_DMA_MR_CTM 		0x00000004
+#define CCSR_DMA_MR_CC  		0x00000002
+#define CCSR_DMA_MR_CS  		0x00000001
+
+#define CCSR_DMA_SR_TE  		0x00000080
+#define CCSR_DMA_SR_CH  		0x00000020
+#define CCSR_DMA_SR_PE  		0x00000010
+#define CCSR_DMA_SR_EOLNI       	0x00000008
+#define CCSR_DMA_SR_CB  		0x00000004
+#define CCSR_DMA_SR_EOSI		0x00000002
+#define CCSR_DMA_SR_EOLSI       	0x00000001
+
+/* ECLNDAR takes bits 32-36 of the CLNDAR register */
+static inline u32 CCSR_DMA_ECLNDAR_ADDR(u64 x)
+{
+	return (x >> 32) & 0xf;
+}
+
+#define CCSR_DMA_CLNDAR_ADDR(x) ((x) & 0xFFFFFFFE)
+#define CCSR_DMA_CLNDAR_EOSIE   	0x00000008
+
+/* SATR and DATR, combined */
+#define CCSR_DMA_ATR_PBATMU     	0x20000000
+#define CCSR_DMA_ATR_TFLOWLVL_0 	0x00000000
+#define CCSR_DMA_ATR_TFLOWLVL_1 	0x06000000
+#define CCSR_DMA_ATR_TFLOWLVL_2 	0x08000000
+#define CCSR_DMA_ATR_TFLOWLVL_3 	0x0C000000
+#define CCSR_DMA_ATR_PCIORDER   	0x02000000
+#define CCSR_DMA_ATR_SME		0x01000000
+#define CCSR_DMA_ATR_NOSNOOP    	0x00040000
+#define CCSR_DMA_ATR_SNOOP      	0x00050000
+#define CCSR_DMA_ATR_ESAD_MASK  	0x0000000F
+
+/**
+ *  List Descriptor for extended chaining mode DMA operations.
+ *
+ *  The CLSDAR register points to the first (in a linked-list) List
+ *  Descriptor.  Each object must be aligned on a 32-byte boundary. Each
+ *  list descriptor points to a linked-list of link Descriptors.
+ */
+struct fsl_dma_list_descriptor {
+	__be64 next;    	/* Address of next list descriptor */
+	__be64 first_link;      /* Address of first link descriptor */
+	__be32 source;  	/* Source stride */
+	__be32 dest;    	/* Destination stride */
+	u8 res[8];      	/* Reserved */
+} __attribute__ ((aligned(32), packed));
+
+/**
+ *  Link Descriptor for basic and extended chaining mode DMA operations.
+ *
+ *  A Link Descriptor points to a single DMA buffer.  Each link descriptor
+ *  must be aligned on a 32-byte boundary.
+ */
+struct fsl_dma_link_descriptor {
+	__be32 source_attr;     /* Programmed into SATR register */
+	__be32 source_addr;     /* Programmed into SAR register */
+	__be32 dest_attr;       /* Programmed into DATR register */
+	__be32 dest_addr;       /* Programmed into DAR register */
+	__be64 next;    /* Address of next link descriptor */
+	__be32 count;   /* Byte count */
+	u8 res[4];      /* Reserved */
+} __attribute__ ((aligned(32), packed));
+
+/* DMA information needed to create a snd_soc_cpu_dai object
+ *
+ * ssi_stx_phys: bus address of SSI STX register to use
+ * ssi_srx_phys: bus address of SSI SRX register to use
+ * dma[0]: points to the DMA channel to use for playback
+ * dma[1]: points to the DMA channel to use for capture
+ * dma_irq[0]: IRQ of the DMA channel to use for playback
+ * dma_irq[1]: IRQ of the DMA channel to use for capture
+ */
+struct fsl_dma_info {
+	dma_addr_t ssi_stx_phys;
+	dma_addr_t ssi_srx_phys;
+	struct ccsr_dma_channel __iomem *dma_channel[2];
+	unsigned int dma_irq[2];
+};
+
+extern struct snd_soc_platform fsl_soc_platform;
+
+int fsl_dma_configure(struct fsl_dma_info *dma_info);
+
+#endif
diff --git a/sound/soc/fsl/fsl_ssi.c b/sound/soc/fsl/fsl_ssi.c
new file mode 100644
index 0000000..a219e58
--- /dev/null
+++ b/sound/soc/fsl/fsl_ssi.c
@@ -0,0 +1,614 @@
+/*
+ * Freescale SSI ALSA SoC Digital Audio Interface (DAI) driver
+ *
+ * Author: Timur Tabi <timur@freescale.com>
+ *
+ * Copyright 2007 Freescale Semiconductor, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/init.h>
+#include <linux/module.h>
+#include <linux/interrupt.h>
+#include <linux/device.h>
+#include <linux/delay.h>
+
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/pcm_params.h>
+#include <sound/initval.h>
+#include <sound/soc.h>
+
+#include <asm/immap_86xx.h>
+
+#include "fsl_ssi.h"
+
+/*
+ * The sample rates supported by the I2S
+ *
+ * This driver currently only supports the SSI running in I2S slave mode,
+ * which means the codec determines the sample rate.  Therefore, we tell
+ * ALSA that we support all rates and let the codec driver decide what rates
+ * are really supported.
+ */
+#define FSLSSI_I2S_RATES (SNDRV_PCM_RATE_5512 | SNDRV_PCM_RATE_8000_192000 | \
+			  SNDRV_PCM_RATE_CONTINUOUS)
+
+/*
+ * The audio formats supported by the SSI
+ *
+ * This driver currently only supports the SSI running in I2S slave mode.
+ *
+ * The SSI has a limitation in that the samples must be in the same byte
+ * order as the host CPU.  This is because when multiple bytes are written
+ * to the STX register, the bytes and bits must be written in the same
+ * order.  The STX is a shift register, so all the bits need to be aligned
+ * (bit-endianness must match byte-endianness).  Processors typically write
+ * the bits within a byte in the same order that the bytes of a word are
+ * written in.  So if the host CPU is big-endian, then only big-endian
+ * samples will be written to STX properly.
+ */
+#ifdef __BIG_ENDIAN
+#define FSLSSI_I2S_FORMATS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_BE | \
+	 SNDRV_PCM_FMTBIT_S18_3BE | SNDRV_PCM_FMTBIT_S20_3BE | \
+	 SNDRV_PCM_FMTBIT_S24_3BE | SNDRV_PCM_FMTBIT_S24_BE)
+#else
+#define FSLSSI_I2S_FORMATS (SNDRV_PCM_FMTBIT_S8 | SNDRV_PCM_FMTBIT_S16_LE | \
+	 SNDRV_PCM_FMTBIT_S18_3LE | SNDRV_PCM_FMTBIT_S20_3LE | \
+	 SNDRV_PCM_FMTBIT_S24_3LE | SNDRV_PCM_FMTBIT_S24_LE)
+#endif
+
+/* SSI information.
+ *
+ * name: short name for this device ("SSI0", "SSI1", etc)
+ * ssi: pointer to the SSI's registers
+ * ssi_phys: physical address of the SSI registers
+ * irq: IRQ of this SSI
+ * dev: struct device pointer
+ * playback: the number of playback streams opened
+ * capture: the number of capture streams opened
+ */
+struct fsl_ssi_private {
+	char name[8];
+	struct ccsr_ssi __iomem *ssi;
+	dma_addr_t ssi_phys;
+	unsigned int irq;
+	struct device *dev;
+	unsigned int playback;
+	unsigned int capture;
+	struct snd_soc_cpu_dai cpu_dai;
+	struct device_attribute dev_attr;
+
+	struct {
+		unsigned int rfrc;
+		unsigned int tfrc;
+		unsigned int cmdau;
+		unsigned int cmddu;
+		unsigned int rxt;
+		unsigned int rdr1;
+		unsigned int rdr0;
+		unsigned int tde1;
+		unsigned int tde0;
+		unsigned int roe1;
+		unsigned int roe0;
+		unsigned int tue1;
+		unsigned int tue0;
+		unsigned int tfs;
+		unsigned int rfs;
+		unsigned int tls;
+		unsigned int rls;
+		unsigned int rff1;
+		unsigned int rff0;
+		unsigned int tfe1;
+		unsigned int tfe0;
+	} stats;
+};
+
+/*
+ * SSI interrupt handler.
+ *
+ * Do we even want an SSI interrupt handler?  Maybe for error handling, but
+ * buffer processing is handled via DMA interrupts.
+ */
+static irqreturn_t fsl_ssi_isr(int irq, void *dev_id)
+{
+	struct fsl_ssi_private *ssi_private = dev_id;
+	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	irqreturn_t ret = IRQ_NONE;
+	__be32 sisr;
+	__be32 sisr2 = 0;
+
+	/* We got an interrupt, so read the status register to see what we
+	   were interrupted for.  We mask it with the Interrupt Enable register
+	   so that we only check for events that we're interested in.
+	 */
+	sisr = in_be32(&ssi->sisr) & in_be32(&ssi->sier);
+
+	if (sisr & CCSR_SSI_SISR_RFRC) {
+		ssi_private->stats.rfrc++;
+		sisr2 |= CCSR_SSI_SISR_RFRC;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sisr & CCSR_SSI_SISR_TFRC) {
+		ssi_private->stats.tfrc++;
+		sisr2 |= CCSR_SSI_SISR_TFRC;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sisr & CCSR_SSI_SISR_CMDAU) {
+		ssi_private->stats.cmdau++;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sisr & CCSR_SSI_SISR_CMDDU) {
+		ssi_private->stats.cmddu++;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sisr & CCSR_SSI_SISR_RXT) {
+		ssi_private->stats.rxt++;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sisr & CCSR_SSI_SISR_RDR1) {
+		ssi_private->stats.rdr1++;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sisr & CCSR_SSI_SISR_RDR0) {
+		ssi_private->stats.rdr0++;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sisr & CCSR_SSI_SISR_TDE1) {
+		ssi_private->stats.tde1++;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sisr & CCSR_SSI_SISR_TDE0) {
+		ssi_private->stats.tde0++;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sisr & CCSR_SSI_SISR_ROE1) {
+		ssi_private->stats.roe1++;
+		sisr2 |= CCSR_SSI_SISR_ROE1;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sisr & CCSR_SSI_SISR_ROE0) {
+		ssi_private->stats.roe0++;
+		sisr2 |= CCSR_SSI_SISR_ROE0;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sisr & CCSR_SSI_SISR_TUE1) {
+		ssi_private->stats.tue1++;
+		sisr2 |= CCSR_SSI_SISR_TUE1;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sisr & CCSR_SSI_SISR_TUE0) {
+		ssi_private->stats.tue0++;
+		sisr2 |= CCSR_SSI_SISR_TUE0;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sisr & CCSR_SSI_SISR_TFS) {
+		ssi_private->stats.tfs++;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sisr & CCSR_SSI_SISR_RFS) {
+		ssi_private->stats.rfs++;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sisr & CCSR_SSI_SISR_TLS) {
+		ssi_private->stats.tls++;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sisr & CCSR_SSI_SISR_RLS) {
+		ssi_private->stats.rls++;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sisr & CCSR_SSI_SISR_RFF1) {
+		ssi_private->stats.rff1++;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sisr & CCSR_SSI_SISR_RFF0) {
+		ssi_private->stats.rff0++;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sisr & CCSR_SSI_SISR_TFE1) {
+		ssi_private->stats.tfe1++;
+		ret = IRQ_HANDLED;
+	}
+
+	if (sisr & CCSR_SSI_SISR_TFE0) {
+		ssi_private->stats.tfe0++;
+		ret = IRQ_HANDLED;
+	}
+
+	/* Clear the bits that we set */
+	if (sisr2)
+		out_be32(&ssi->sisr, sisr2);
+
+	return ret;
+}
+
+/*
+ * Startup
+ *
+ * This is the first function called when a stream is opened.
+ *
+ * If this is the first stream open, then grab the IRQ and program most of
+ * the SSI registers.
+ */
+static int fsl_ssi_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct fsl_ssi_private *ssi_private = rtd->dai->cpu_dai->private_data;
+
+	/*
+	 * If this is the first stream opened, then request the IRQ
+	 * and initialize the SSI registers.
+	 */
+	if (!ssi_private->playback && !ssi_private->capture) {
+		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+		int ret;
+
+		ret = request_irq(ssi_private->irq, fsl_ssi_isr, 0,
+				  ssi_private->name, ssi_private);
+		if (ret < 0) {
+			dev_err(substream->pcm->card->dev,
+				"could not claim irq %u\n", ssi_private->irq);
+			return ret;
+		}
+
+		/*
+		 * Section 16.5 of the MPC8610 reference manual says that the
+		 * SSI needs to be disabled before updating the registers we set
+		 * here.
+		 */
+		clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
+
+		/*
+		 * Program the SSI into I2S Slave Non-Network Synchronous mode.
+		 * Also enable the transmit and receive FIFO.
+		 *
+		 * FIXME: Little-endian samples require a different shift dir
+		 */
+		clrsetbits_be32(&ssi->scr, CCSR_SSI_SCR_I2S_MODE_MASK,
+			CCSR_SSI_SCR_TFR_CLK_DIS |
+			CCSR_SSI_SCR_I2S_MODE_SLAVE | CCSR_SSI_SCR_SYN);
+
+		out_be32(&ssi->stcr,
+			 CCSR_SSI_STCR_TXBIT0 | CCSR_SSI_STCR_TFEN0 |
+			 CCSR_SSI_STCR_TFSI | CCSR_SSI_STCR_TEFS |
+			 CCSR_SSI_STCR_TSCKP);
+
+		out_be32(&ssi->srcr,
+			 CCSR_SSI_SRCR_RXBIT0 | CCSR_SSI_SRCR_RFEN0 |
+			 CCSR_SSI_SRCR_RFSI | CCSR_SSI_SRCR_REFS |
+			 CCSR_SSI_SRCR_RSCKP);
+
+		/*
+		 * The DC and PM bits are only used if the SSI is the clock
+		 * master.
+		 */
+
+		/* 4. Enable the interrupts and DMA requests */
+		out_be32(&ssi->sier,
+			 CCSR_SSI_SIER_TFRC_EN | CCSR_SSI_SIER_TDMAE |
+			 CCSR_SSI_SIER_TIE | CCSR_SSI_SIER_TUE0_EN |
+			 CCSR_SSI_SIER_TUE1_EN | CCSR_SSI_SIER_RFRC_EN |
+			 CCSR_SSI_SIER_RDMAE | CCSR_SSI_SIER_RIE |
+			 CCSR_SSI_SIER_ROE0_EN | CCSR_SSI_SIER_ROE1_EN);
+
+		/*
+		 * Set the watermark for transmit FIFI 0 and receive FIFO 0. We
+		 * don't use FIFO 1.  Since the SSI only supports stereo, the
+		 * watermark should never be an odd number.
+		 */
+		out_be32(&ssi->sfcsr,
+			 CCSR_SSI_SFCSR_TFWM0(6) | CCSR_SSI_SFCSR_RFWM0(2));
+
+		/*
+		 * We keep the SSI disabled because if we enable it, then the
+		 * DMA controller will start.  It's not supposed to start until
+		 * the SCR.TE (or SCR.RE) bit is set, but it does anyway.  The
+		 * DMA controller will transfer one "BWC" of data (i.e. the
+		 * amount of data that the MR.BWC bits are set to).  The reason
+		 * this is bad is because at this point, the PCM driver has not
+		 * finished initializing the DMA controller.
+		 */
+	}
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ssi_private->playback++;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		ssi_private->capture++;
+
+	return 0;
+}
+
+/*
+ * Prepare the SSI.
+ *
+ * Most of the SSI registers have been programmed in the startup function,
+ * but the word length must be programmed here.  Unfortunately, programming
+ * the SxCCR.WL bits requires the SSI to be temporarily disabled.  This can
+ * cause a problem with supporting simultaneous playback and capture.  If
+ * the SSI is already playing a stream, then that stream may be temporarily
+ * stopped when you start capture.
+ *
+ * Note: The SxCCR.DC and SxCCR.PM bits are only used if the SSI is the
+ * clock master.
+ */
+static int fsl_ssi_prepare(struct snd_pcm_substream *substream)
+{
+	struct snd_pcm_runtime *runtime = substream->runtime;
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct fsl_ssi_private *ssi_private = rtd->dai->cpu_dai->private_data;
+
+	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+	u32 wl;
+
+	wl = CCSR_SSI_SxCCR_WL(snd_pcm_format_width(runtime->format));
+
+	clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		clrsetbits_be32(&ssi->stccr, CCSR_SSI_SxCCR_WL_MASK, wl);
+	else
+		clrsetbits_be32(&ssi->srccr, CCSR_SSI_SxCCR_WL_MASK, wl);
+
+	setbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
+
+	return 0;
+}
+
+/*
+ * Start and stop the DMA transfer.
+ *
+ * This function is called by ALSA to start, stop, pause, and resume the DMA
+ * transfer of data.
+ *
+ * The SSI has put the DMA in external master start and pause mode, which
+ * means the SSI completely controls the flow of data.
+ */
+static int fsl_ssi_trigger(struct snd_pcm_substream *substream, int cmd)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct fsl_ssi_private *ssi_private = rtd->dai->cpu_dai->private_data;
+	struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+
+	switch (cmd) {
+	case SNDRV_PCM_TRIGGER_START:
+	case SNDRV_PCM_TRIGGER_RESUME:
+	case SNDRV_PCM_TRIGGER_PAUSE_RELEASE:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK) {
+			setbits32(&ssi->scr, CCSR_SSI_SCR_TE);
+		} else {
+			setbits32(&ssi->scr, CCSR_SSI_SCR_RE);
+
+			/*
+			 * I have no idea why we need a delay here. Without it,
+			 * the DMA won't start (or the SSI won't tell the DMA to
+			 * start).
+			 */
+			msleep(1);
+		}
+		break;
+
+	case SNDRV_PCM_TRIGGER_STOP:
+	case SNDRV_PCM_TRIGGER_SUSPEND:
+	case SNDRV_PCM_TRIGGER_PAUSE_PUSH:
+		if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+			clrbits32(&ssi->scr, CCSR_SSI_SCR_TE);
+		else
+			clrbits32(&ssi->scr, CCSR_SSI_SCR_RE);
+		break;
+
+	default:
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+/*
+ * Shutdown.  Clear DMA parameters and shutdown the SSI if there
+ * are no other substreams open.
+ */
+static void fsl_ssi_shutdown(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct fsl_ssi_private *ssi_private = rtd->dai->cpu_dai->private_data;
+
+	if (substream->stream == SNDRV_PCM_STREAM_PLAYBACK)
+		ssi_private->playback--;
+
+	if (substream->stream == SNDRV_PCM_STREAM_CAPTURE)
+		ssi_private->capture--;
+
+	/*
+	 * If this is the last active substream, disable the SSI and release
+	 * the IRQ.
+	 */
+	if (!ssi_private->playback && !ssi_private->capture) {
+		struct ccsr_ssi __iomem *ssi = ssi_private->ssi;
+
+		clrbits32(&ssi->scr, CCSR_SSI_SCR_SSIEN);
+
+		free_irq(ssi_private->irq, ssi_private);
+	}
+}
+
+/* Set the clock frequency and direction
+ *
+ * This function is called by the machine driver to tell us what the clock
+ * frequency and direction are.
+ *
+ * Currently, we only support operating as a clock slave (SND_SOC_CLOCK_IN),
+ * and we don't care about the frequency.  Return an error if the direction
+ * is not SND_SOC_CLOCK_IN.
+ */
+static int fsl_ssi_set_sysclk(struct snd_soc_cpu_dai *cpu_dai,
+			      int clk_id, unsigned int freq, int dir)
+{
+
+	return (dir == SND_SOC_CLOCK_IN) ? 0 : -EINVAL;
+}
+
+/* Set the serial format.
+ *
+ * This function is called by the machine driver to tell us what serial
+ * format to use.
+ *
+ * Currently, we only support I2S mode.  Return an error if the format is
+ * not SND_SOC_DAIFMT_I2S.
+ */
+static int fsl_ssi_set_fmt(struct snd_soc_cpu_dai *cpu_dai, unsigned int format)
+{
+	return (format == SND_SOC_DAIFMT_I2S) ? 0 : -EINVAL;
+}
+
+/*
+ * Template CPU DAI for the SSI
+ */
+static struct snd_soc_cpu_dai fsl_ssi_dai_template = {
+	.playback = {
+		/* The SSI does not support monaural audio. */
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = FSLSSI_I2S_RATES,
+		.formats = FSLSSI_I2S_FORMATS,
+	},
+	.capture = {
+		.channels_min = 2,
+		.channels_max = 2,
+		.rates = FSLSSI_I2S_RATES,
+		.formats = FSLSSI_I2S_FORMATS,
+	},
+	.ops = {
+		.startup = fsl_ssi_startup,
+		.prepare = fsl_ssi_prepare,
+		.shutdown = fsl_ssi_shutdown,
+		.trigger = fsl_ssi_trigger,
+	},
+	.dai_ops = {
+		.set_sysclk = fsl_ssi_set_sysclk,
+		.set_fmt = fsl_ssi_set_fmt,
+	},
+};
+
+static ssize_t fsl_sysfs_ssi_show(struct device *dev,
+				  struct device_attribute *attr, char *buf)
+{
+	struct fsl_ssi_private *ssi_private =
+	container_of(attr, struct fsl_ssi_private, dev_attr);
+	ssize_t length;
+
+	length = sprintf(buf, "rfrc=%u", ssi_private->stats.rfrc);
+	length += sprintf(buf + length, "\ttfrc=%u", ssi_private->stats.tfrc);
+	length += sprintf(buf + length, "\tcmdau=%u", ssi_private->stats.cmdau);
+	length += sprintf(buf + length, "\tcmddu=%u", ssi_private->stats.cmddu);
+	length += sprintf(buf + length, "\trxt=%u", ssi_private->stats.rxt);
+	length += sprintf(buf + length, "\trdr1=%u", ssi_private->stats.rdr1);
+	length += sprintf(buf + length, "\trdr0=%u", ssi_private->stats.rdr0);
+	length += sprintf(buf + length, "\ttde1=%u", ssi_private->stats.tde1);
+	length += sprintf(buf + length, "\ttde0=%u", ssi_private->stats.tde0);
+	length += sprintf(buf + length, "\troe1=%u", ssi_private->stats.roe1);
+	length += sprintf(buf + length, "\troe0=%u", ssi_private->stats.roe0);
+	length += sprintf(buf + length, "\ttue1=%u", ssi_private->stats.tue1);
+	length += sprintf(buf + length, "\ttue0=%u", ssi_private->stats.tue0);
+	length += sprintf(buf + length, "\ttfs=%u", ssi_private->stats.tfs);
+	length += sprintf(buf + length, "\trfs=%u", ssi_private->stats.rfs);
+	length += sprintf(buf + length, "\ttls=%u", ssi_private->stats.tls);
+	length += sprintf(buf + length, "\trls=%u", ssi_private->stats.rls);
+	length += sprintf(buf + length, "\trff1=%u", ssi_private->stats.rff1);
+	length += sprintf(buf + length, "\trff0=%u", ssi_private->stats.rff0);
+	length += sprintf(buf + length, "\ttfe1=%u", ssi_private->stats.tfe1);
+	length += sprintf(buf + length, "\ttfe0=%u\n", ssi_private->stats.tfe0);
+
+	return length;
+}
+
+/* Create a snd_soc_cpu_dai structure
+ *
+ * This function is called by the machine driver to create a snd_soc_cpu_dai
+ * structure.  A private data structure, with SSI hardware information, is
+ * appended to it.
+ */
+struct snd_soc_cpu_dai *fsl_ssi_create_dai(struct fsl_ssi_info *ssi_info)
+{
+	struct snd_soc_cpu_dai *fsl_ssi_dai;
+	struct fsl_ssi_private *ssi_private;
+	int ret = 0;
+	struct device_attribute *dev_attr;
+
+	ssi_private = kzalloc(sizeof(struct fsl_ssi_private), GFP_KERNEL);
+	if (!ssi_private) {
+		dev_err(ssi_info->dev, "could not allocate DAI object\n");
+		return NULL;
+	}
+	memcpy(&ssi_private->cpu_dai, &fsl_ssi_dai_template,
+	       sizeof(struct snd_soc_cpu_dai));
+
+	fsl_ssi_dai = &ssi_private->cpu_dai;
+	dev_attr = &ssi_private->dev_attr;
+
+	sprintf(ssi_private->name, "ssi%u", (u8) ssi_info->id);
+	ssi_private->ssi = ssi_info->ssi;
+	ssi_private->ssi_phys = ssi_info->ssi_phys;
+	ssi_private->irq = ssi_info->irq;
+	ssi_private->dev = ssi_info->dev;
+
+	ssi_private->dev->driver_data = fsl_ssi_dai;
+
+	/* Initialize the the device_attribute structure */
+	dev_attr->attr.name = "ssi-stats";
+	dev_attr->attr.mode = S_IRUGO;
+	dev_attr->show = fsl_sysfs_ssi_show;
+
+	ret = device_create_file(ssi_private->dev, dev_attr);
+	if (ret) {
+		dev_err(ssi_info->dev, "could not create sysfs %s file\n",
+			ssi_private->dev_attr.attr.name);
+		kfree(fsl_ssi_dai);
+		return NULL;
+	}
+
+	fsl_ssi_dai->private_data = ssi_private;
+	fsl_ssi_dai->name = ssi_private->name;
+	fsl_ssi_dai->id = ssi_info->id;
+
+	return fsl_ssi_dai;
+}
+EXPORT_SYMBOL_GPL(fsl_ssi_create_dai);
+
+void fsl_ssi_destroy_dai(struct snd_soc_cpu_dai *fsl_ssi_dai)
+{
+	struct fsl_ssi_private *ssi_private =
+	container_of(fsl_ssi_dai, struct fsl_ssi_private, cpu_dai);
+
+	device_remove_file(ssi_private->dev, &ssi_private->dev_attr);
+
+	kfree(ssi_private);
+}
+EXPORT_SYMBOL_GPL(fsl_ssi_destroy_dai);
+
+MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
+MODULE_DESCRIPTION("Freescale Synchronous Serial Interface (SSI) ASoC Driver");
+MODULE_LICENSE("GPL");
diff --git a/sound/soc/fsl/fsl_ssi.h b/sound/soc/fsl/fsl_ssi.h
new file mode 100644
index 0000000..f6e33af
--- /dev/null
+++ b/sound/soc/fsl/fsl_ssi.h
@@ -0,0 +1,224 @@
+/*
+ * fsl_ssi.h - ALSA SSI interface for the Freescale MPC8610 SoC
+ *
+ * Author: Timur Tabi <timur@freescale.com>
+ *
+ * Copyright 2007 Freescale Semiconductor, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#ifndef _MPC8610_I2S_H
+#define _MPC8610_I2S_H
+
+/* SSI Register Map */
+struct ccsr_ssi {
+	__be32 stx0;	/* 0x.0000 - SSI Transmit Data Register 0 */
+	__be32 stx1;	/* 0x.0004 - SSI Transmit Data Register 1 */
+	__be32 srx0;	/* 0x.0008 - SSI Receive Data Register 0 */
+	__be32 srx1;	/* 0x.000C - SSI Receive Data Register 1 */
+	__be32 scr;	/* 0x.0010 - SSI Control Register */
+	__be32 sisr;	/* 0x.0014 - SSI Interrupt Status Register Mixed */
+	__be32 sier;	/* 0x.0018 - SSI Interrupt Enable Register */
+	__be32 stcr;	/* 0x.001C - SSI Transmit Configuration Register */
+	__be32 srcr;	/* 0x.0020 - SSI Receive Configuration Register */
+	__be32 stccr;	/* 0x.0024 - SSI Transmit Clock Control Register */
+	__be32 srccr;	/* 0x.0028 - SSI Receive Clock Control Register */
+	__be32 sfcsr;	/* 0x.002C - SSI FIFO Control/Status Register */
+	__be32 str;	/* 0x.0030 - SSI Test Register */
+	__be32 sor;	/* 0x.0034 - SSI Option Register */
+	__be32 sacnt;	/* 0x.0038 - SSI AC97 Control Register */
+	__be32 sacadd;	/* 0x.003C - SSI AC97 Command Address Register */
+	__be32 sacdat;	/* 0x.0040 - SSI AC97 Command Data Register */
+	__be32 satag;	/* 0x.0044 - SSI AC97 Tag Register */
+	__be32 stmsk;	/* 0x.0048 - SSI Transmit Time Slot Mask Register */
+	__be32 srmsk;	/* 0x.004C - SSI Receive Time Slot Mask Register */
+	__be32 saccst;	/* 0x.0050 - SSI AC97 Channel Status Register */
+	__be32 saccen;	/* 0x.0054 - SSI AC97 Channel Enable Register */
+	__be32 saccdis; /* 0x.0058 - SSI AC97 Channel Disable Register */
+};
+
+#define CCSR_SSI_SCR_RFR_CLK_DIS	0x00000800
+#define CCSR_SSI_SCR_TFR_CLK_DIS	0x00000400
+#define CCSR_SSI_SCR_TCH_EN		0x00000100
+#define CCSR_SSI_SCR_SYS_CLK_EN		0x00000080
+#define CCSR_SSI_SCR_I2S_MODE_MASK	0x00000060
+#define CCSR_SSI_SCR_I2S_MODE_NORMAL	0x00000000
+#define CCSR_SSI_SCR_I2S_MODE_MASTER	0x00000020
+#define CCSR_SSI_SCR_I2S_MODE_SLAVE	0x00000040
+#define CCSR_SSI_SCR_SYN		0x00000010
+#define CCSR_SSI_SCR_NET		0x00000008
+#define CCSR_SSI_SCR_RE			0x00000004
+#define CCSR_SSI_SCR_TE			0x00000002
+#define CCSR_SSI_SCR_SSIEN		0x00000001
+
+#define CCSR_SSI_SISR_RFRC		0x01000000
+#define CCSR_SSI_SISR_TFRC		0x00800000
+#define CCSR_SSI_SISR_CMDAU		0x00040000
+#define CCSR_SSI_SISR_CMDDU		0x00020000
+#define CCSR_SSI_SISR_RXT		0x00010000
+#define CCSR_SSI_SISR_RDR1		0x00008000
+#define CCSR_SSI_SISR_RDR0		0x00004000
+#define CCSR_SSI_SISR_TDE1		0x00002000
+#define CCSR_SSI_SISR_TDE0		0x00001000
+#define CCSR_SSI_SISR_ROE1		0x00000800
+#define CCSR_SSI_SISR_ROE0		0x00000400
+#define CCSR_SSI_SISR_TUE1		0x00000200
+#define CCSR_SSI_SISR_TUE0		0x00000100
+#define CCSR_SSI_SISR_TFS		0x00000080
+#define CCSR_SSI_SISR_RFS		0x00000040
+#define CCSR_SSI_SISR_TLS		0x00000020
+#define CCSR_SSI_SISR_RLS		0x00000010
+#define CCSR_SSI_SISR_RFF1		0x00000008
+#define CCSR_SSI_SISR_RFF0		0x00000004
+#define CCSR_SSI_SISR_TFE1		0x00000002
+#define CCSR_SSI_SISR_TFE0		0x00000001
+
+#define CCSR_SSI_SIER_RFRC_EN		0x01000000
+#define CCSR_SSI_SIER_TFRC_EN		0x00800000
+#define CCSR_SSI_SIER_RDMAE		0x00400000
+#define CCSR_SSI_SIER_RIE		0x00200000
+#define CCSR_SSI_SIER_TDMAE		0x00100000
+#define CCSR_SSI_SIER_TIE		0x00080000
+#define CCSR_SSI_SIER_CMDAU_EN		0x00040000
+#define CCSR_SSI_SIER_CMDDU_EN		0x00020000
+#define CCSR_SSI_SIER_RXT_EN		0x00010000
+#define CCSR_SSI_SIER_RDR1_EN		0x00008000
+#define CCSR_SSI_SIER_RDR0_EN		0x00004000
+#define CCSR_SSI_SIER_TDE1_EN		0x00002000
+#define CCSR_SSI_SIER_TDE0_EN		0x00001000
+#define CCSR_SSI_SIER_ROE1_EN		0x00000800
+#define CCSR_SSI_SIER_ROE0_EN		0x00000400
+#define CCSR_SSI_SIER_TUE1_EN		0x00000200
+#define CCSR_SSI_SIER_TUE0_EN		0x00000100
+#define CCSR_SSI_SIER_TFS_EN		0x00000080
+#define CCSR_SSI_SIER_RFS_EN		0x00000040
+#define CCSR_SSI_SIER_TLS_EN		0x00000020
+#define CCSR_SSI_SIER_RLS_EN		0x00000010
+#define CCSR_SSI_SIER_RFF1_EN		0x00000008
+#define CCSR_SSI_SIER_RFF0_EN		0x00000004
+#define CCSR_SSI_SIER_TFE1_EN		0x00000002
+#define CCSR_SSI_SIER_TFE0_EN		0x00000001
+
+#define CCSR_SSI_STCR_TXBIT0		0x00000200
+#define CCSR_SSI_STCR_TFEN1		0x00000100
+#define CCSR_SSI_STCR_TFEN0		0x00000080
+#define CCSR_SSI_STCR_TFDIR		0x00000040
+#define CCSR_SSI_STCR_TXDIR		0x00000020
+#define CCSR_SSI_STCR_TSHFD		0x00000010
+#define CCSR_SSI_STCR_TSCKP		0x00000008
+#define CCSR_SSI_STCR_TFSI		0x00000004
+#define CCSR_SSI_STCR_TFSL		0x00000002
+#define CCSR_SSI_STCR_TEFS		0x00000001
+
+#define CCSR_SSI_SRCR_RXEXT		0x00000400
+#define CCSR_SSI_SRCR_RXBIT0		0x00000200
+#define CCSR_SSI_SRCR_RFEN1		0x00000100
+#define CCSR_SSI_SRCR_RFEN0		0x00000080
+#define CCSR_SSI_SRCR_RFDIR		0x00000040
+#define CCSR_SSI_SRCR_RXDIR		0x00000020
+#define CCSR_SSI_SRCR_RSHFD		0x00000010
+#define CCSR_SSI_SRCR_RSCKP		0x00000008
+#define CCSR_SSI_SRCR_RFSI		0x00000004
+#define CCSR_SSI_SRCR_RFSL		0x00000002
+#define CCSR_SSI_SRCR_REFS		0x00000001
+
+/* STCCR and SRCCR */
+#define CCSR_SSI_SxCCR_DIV2		0x00040000
+#define CCSR_SSI_SxCCR_PSR		0x00020000
+#define CCSR_SSI_SxCCR_WL_SHIFT		13
+#define CCSR_SSI_SxCCR_WL_MASK		0x0001E000
+#define CCSR_SSI_SxCCR_WL(x) \
+	(((((x) / 2) - 1) << CCSR_SSI_SxCCR_WL_SHIFT) & CCSR_SSI_SxCCR_WL_MASK)
+#define CCSR_SSI_SxCCR_DC_SHIFT		8
+#define CCSR_SSI_SxCCR_DC_MASK		0x00001F00
+#define CCSR_SSI_SxCCR_DC(x) \
+	((((x) - 1) << CCSR_SSI_SxCCR_DC_SHIFT) & CCSR_SSI_SxCCR_DC_MASK)
+#define CCSR_SSI_SxCCR_PM_SHIFT		0
+#define CCSR_SSI_SxCCR_PM_MASK		0x000000FF
+#define CCSR_SSI_SxCCR_PM(x) \
+	((((x) - 1) << CCSR_SSI_SxCCR_PM_SHIFT) & CCSR_SSI_SxCCR_PM_MASK)
+
+/*
+ * The xFCNT bits are read-only, and the xFWM bits are read/write.  Use the
+ * CCSR_SSI_SFCSR_xFCNTy() macros to read the FIFO counters, and use the
+ * CCSR_SSI_SFCSR_xFWMy() macros to set the watermarks.
+ */
+#define CCSR_SSI_SFCSR_RFCNT1_SHIFT	28
+#define CCSR_SSI_SFCSR_RFCNT1_MASK	0xF0000000
+#define CCSR_SSI_SFCSR_RFCNT1(x) \
+	(((x) & CCSR_SSI_SFCSR_RFCNT1_MASK) >> CCSR_SSI_SFCSR_RFCNT1_SHIFT)
+#define CCSR_SSI_SFCSR_TFCNT1_SHIFT	24
+#define CCSR_SSI_SFCSR_TFCNT1_MASK	0x0F000000
+#define CCSR_SSI_SFCSR_TFCNT1(x) \
+	(((x) & CCSR_SSI_SFCSR_TFCNT1_MASK) >> CCSR_SSI_SFCSR_TFCNT1_SHIFT)
+#define CCSR_SSI_SFCSR_RFWM1_SHIFT	20
+#define CCSR_SSI_SFCSR_RFWM1_MASK	0x00F00000
+#define CCSR_SSI_SFCSR_RFWM1(x)	\
+	(((x) << CCSR_SSI_SFCSR_RFWM1_SHIFT) & CCSR_SSI_SFCSR_RFWM1_MASK)
+#define CCSR_SSI_SFCSR_TFWM1_SHIFT	16
+#define CCSR_SSI_SFCSR_TFWM1_MASK	0x000F0000
+#define CCSR_SSI_SFCSR_TFWM1(x)	\
+	(((x) << CCSR_SSI_SFCSR_TFWM1_SHIFT) & CCSR_SSI_SFCSR_TFWM1_MASK)
+#define CCSR_SSI_SFCSR_RFCNT0_SHIFT	12
+#define CCSR_SSI_SFCSR_RFCNT0_MASK	0x0000F000
+#define CCSR_SSI_SFCSR_RFCNT0(x) \
+	(((x) & CCSR_SSI_SFCSR_RFCNT0_MASK) >> CCSR_SSI_SFCSR_RFCNT0_SHIFT)
+#define CCSR_SSI_SFCSR_TFCNT0_SHIFT	8
+#define CCSR_SSI_SFCSR_TFCNT0_MASK	0x00000F00
+#define CCSR_SSI_SFCSR_TFCNT0(x) \
+	(((x) & CCSR_SSI_SFCSR_TFCNT0_MASK) >> CCSR_SSI_SFCSR_TFCNT0_SHIFT)
+#define CCSR_SSI_SFCSR_RFWM0_SHIFT	4
+#define CCSR_SSI_SFCSR_RFWM0_MASK	0x000000F0
+#define CCSR_SSI_SFCSR_RFWM0(x)	\
+	(((x) << CCSR_SSI_SFCSR_RFWM0_SHIFT) & CCSR_SSI_SFCSR_RFWM0_MASK)
+#define CCSR_SSI_SFCSR_TFWM0_SHIFT	0
+#define CCSR_SSI_SFCSR_TFWM0_MASK	0x0000000F
+#define CCSR_SSI_SFCSR_TFWM0(x)	\
+	(((x) << CCSR_SSI_SFCSR_TFWM0_SHIFT) & CCSR_SSI_SFCSR_TFWM0_MASK)
+
+#define CCSR_SSI_STR_TEST		0x00008000
+#define CCSR_SSI_STR_RCK2TCK		0x00004000
+#define CCSR_SSI_STR_RFS2TFS		0x00002000
+#define CCSR_SSI_STR_RXSTATE(x) (((x) >> 8) & 0x1F)
+#define CCSR_SSI_STR_TXD2RXD		0x00000080
+#define CCSR_SSI_STR_TCK2RCK		0x00000040
+#define CCSR_SSI_STR_TFS2RFS		0x00000020
+#define CCSR_SSI_STR_TXSTATE(x) ((x) & 0x1F)
+
+#define CCSR_SSI_SOR_CLKOFF		0x00000040
+#define CCSR_SSI_SOR_RX_CLR		0x00000020
+#define CCSR_SSI_SOR_TX_CLR		0x00000010
+#define CCSR_SSI_SOR_INIT		0x00000008
+#define CCSR_SSI_SOR_WAIT_SHIFT		1
+#define CCSR_SSI_SOR_WAIT_MASK		0x00000006
+#define CCSR_SSI_SOR_WAIT(x) (((x) & 3) << CCSR_SSI_SOR_WAIT_SHIFT)
+#define CCSR_SSI_SOR_SYNRST 		0x00000001
+
+/* Instantiation data for an SSI interface
+ *
+ * This structure contains all the information that the the SSI driver needs
+ * to instantiate an SSI interface with ALSA.  The machine driver should
+ * create this structure, fill it in, call fsl_ssi_create_dai(), and then
+ * delete the structure.
+ *
+ * id: which SSI this is (0, 1, etc. )
+ * ssi: pointer to the SSI's registers
+ * ssi_phys: physical address of the SSI registers
+ * irq: IRQ of this SSI
+ * dev: struct device, used to create the sysfs statistics file
+*/
+struct fsl_ssi_info {
+	unsigned int id;
+	struct ccsr_ssi __iomem *ssi;
+	dma_addr_t ssi_phys;
+	unsigned int irq;
+	struct device *dev;
+};
+
+struct snd_soc_cpu_dai *fsl_ssi_create_dai(struct fsl_ssi_info *ssi_info);
+void fsl_ssi_destroy_dai(struct snd_soc_cpu_dai *fsl_ssi_dai);
+
+#endif
+
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
new file mode 100644
index 0000000..5421a5c
--- /dev/null
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -0,0 +1,621 @@
+/**
+ * Freescale MPC8610HPCD ALSA SoC Fabric driver
+ *
+ * Author: Timur Tabi <timur@freescale.com>
+ *
+ * Copyright 2007 Freescale Semiconductor, Inc.  This file is licensed under
+ * the terms of the GNU General Public License version 2.  This program
+ * is licensed "as is" without any warranty of any kind, whether express
+ * or implied.
+ */
+
+#include <linux/module.h>
+#include <linux/moduleparam.h>
+#include <linux/version.h>
+#include <linux/kernel.h>
+#include <linux/interrupt.h>
+#include <linux/platform_device.h>
+#include <asm/of_device.h>
+#include <asm/of_platform.h>
+#include <sound/driver.h>
+#include <sound/core.h>
+#include <sound/pcm.h>
+#include <sound/soc.h>
+#include <sound/initval.h>
+#include <asm/immap_86xx.h>
+
+#include "../codecs/cs4270.h"
+#include "fsl_dma.h"
+#include "fsl_ssi.h"
+
+/*
+ * Fabric-specific ASoC device data
+ *
+ * This structure contains data for a single sound platform device on an
+ * MPC8610 HPCD.  Some of the data is taken from the device tree.
+ */
+struct mpc8610hpcd_data {
+	struct snd_soc_device sound_devdata;
+	struct snd_soc_dai_link dai;
+	struct snd_soc_machine machine;
+	unsigned int dai_format;
+	unsigned int codec_clk_direction;
+	unsigned int cpu_clk_direction;
+	unsigned int clk_frequency;
+	struct ccsr_guts __iomem *guts;
+	struct ccsr_ssi __iomem *ssi;
+	unsigned int ssi_id;    	/* 0 = SSI1, 1 = SSI2, etc */
+	unsigned int ssi_irq;
+	unsigned int dma_id;    	/* 0 = DMA1, 1 = DMA2, etc */
+	unsigned int dma_irq[2];
+	struct ccsr_dma_channel __iomem *dma[2];
+	unsigned int dma_channel_id[2]; /* 0 = ch 0, 1 = ch 1, etc*/
+};
+
+/*
+ * Initalize the board
+ *
+ * This function is called when platform_device_add() is called.  It is used
+ * to initialize the board-specific hardware.
+ *
+ * Here we program the DMACR and PMUXCR registers.
+ */
+int mpc8610_hpcd_machine_probe(struct platform_device *sound_device)
+{
+	struct mpc8610hpcd_data *machine_data = sound_device->dev.platform_data;
+
+	/* Program the signal routing between the SSI and the DMA */
+	guts_set_dmacr(machine_data->guts, machine_data->dma_id + 1,
+		machine_data->dma_channel_id[0], CCSR_GUTS_DMACR_DEV_SSI);
+	guts_set_dmacr(machine_data->guts, machine_data->dma_id + 1,
+		machine_data->dma_channel_id[1], CCSR_GUTS_DMACR_DEV_SSI);
+
+	guts_set_pmuxcr_dma(machine_data->guts, machine_data->dma_id,
+		machine_data->dma_channel_id[0], 0);
+	guts_set_pmuxcr_dma(machine_data->guts, machine_data->dma_id,
+		machine_data->dma_channel_id[1], 0);
+
+	guts_set_pmuxcr_dma(machine_data->guts, 1, 0, 0);
+	guts_set_pmuxcr_dma(machine_data->guts, 1, 3, 0);
+	guts_set_pmuxcr_dma(machine_data->guts, 0, 3, 0);
+
+	switch (machine_data->ssi_id) {
+	case 0:
+		clrsetbits_be32(&machine_data->guts->pmuxcr,
+			CCSR_GUTS_PMUXCR_SSI1_MASK, CCSR_GUTS_PMUXCR_SSI1_SSI);
+		break;
+	case 1:
+		clrsetbits_be32(&machine_data->guts->pmuxcr,
+			CCSR_GUTS_PMUXCR_SSI2_MASK, CCSR_GUTS_PMUXCR_SSI2_SSI);
+		break;
+	}
+
+	return 0;
+}
+
+/*
+ * Program the board based on various hardware parameters
+ */
+static int mpc8610hpcd_startup(struct snd_pcm_substream *substream)
+{
+	struct snd_soc_pcm_runtime *rtd = substream->private_data;
+	struct snd_soc_codec_dai *codec_dai = rtd->dai->codec_dai;
+	struct snd_soc_cpu_dai *cpu_dai = rtd->dai->cpu_dai;
+	struct mpc8610hpcd_data *machine_data = rtd->socdev->dev->platform_data;
+	int ret = 0;
+
+	/* Tell the CPU driver what the serial protocol is. */
+	if (cpu_dai->dai_ops.set_fmt) {
+		ret = cpu_dai->dai_ops.set_fmt(cpu_dai,
+			machine_data->dai_format);
+		if (ret < 0) {
+			dev_err(substream->pcm->card->dev,
+				"could not set CPU driver audio format\n");
+			return ret;
+		}
+	}
+
+	/* Tell the codec driver what the serial protocol is. */
+	if (codec_dai->dai_ops.set_fmt) {
+		ret = codec_dai->dai_ops.set_fmt(codec_dai,
+			machine_data->dai_format);
+		if (ret < 0) {
+			dev_err(substream->pcm->card->dev,
+				"could not set codec driver audio format\n");
+			return ret;
+		}
+	}
+
+	/*
+	 * Tell the CPU driver what the clock frequency is, and whether it's a
+	 * slave or master.
+	 */
+	if (cpu_dai->dai_ops.set_sysclk) {
+		ret = cpu_dai->dai_ops.set_sysclk(cpu_dai, 0,
+			machine_data->clk_frequency,
+			machine_data->cpu_clk_direction);
+		if (ret < 0) {
+			dev_err(substream->pcm->card->dev,
+				"could not set CPU driver clock parameters\n");
+			return ret;
+		}
+	}
+
+	/*
+	 * Tell the codec driver what the MCLK frequency is, and whether it's
+	 * a slave or master.
+	 */
+	if (codec_dai->dai_ops.set_sysclk) {
+		ret = codec_dai->dai_ops.set_sysclk(codec_dai, 0,
+			machine_data->clk_frequency,
+			machine_data->codec_clk_direction);
+		if (ret < 0) {
+			dev_err(substream->pcm->card->dev,
+				"could not set codec driver clock params\n");
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+/*
+ * Remove the sound device
+ *
+ * This function is called to remove the sound device for one SSI.  We
+ * de-program the DMACR and PMUXCR register.
+ */
+int mpc8610_hpcd_machine_remove(struct platform_device *sound_device)
+{
+	struct mpc8610hpcd_data *machine_data = sound_device->dev.platform_data;
+
+	/* Restore the signal routing */
+
+	guts_set_dmacr(machine_data->guts, machine_data->dma_id + 1,
+		machine_data->dma_channel_id[0], 0);
+	guts_set_dmacr(machine_data->guts, machine_data->dma_id + 1,
+		machine_data->dma_channel_id[1], 0);
+
+	switch (machine_data->ssi_id) {
+	case 0:
+		clrsetbits_be32(&machine_data->guts->pmuxcr,
+			CCSR_GUTS_PMUXCR_SSI1_MASK, CCSR_GUTS_PMUXCR_SSI1_LA);
+		break;
+	case 1:
+		clrsetbits_be32(&machine_data->guts->pmuxcr,
+			CCSR_GUTS_PMUXCR_SSI2_MASK, CCSR_GUTS_PMUXCR_SSI1_LA);
+		break;
+	}
+
+	return 0;
+}
+
+/*
+ * ASoC fabric driver operations
+ */
+static struct snd_soc_ops mpc8610hpcd_ops = {
+	.startup = mpc8610hpcd_startup,
+};
+
+/*
+ * ASoC machine
+ */
+static struct snd_soc_machine mpc8610_hpcd_machine = {
+	.probe = mpc8610_hpcd_machine_probe,
+	.remove = mpc8610_hpcd_machine_remove,
+	.name = "MPC8610 HPCD",
+	.num_links = 1,
+};
+
+/*
+ * Probe function for the fabric driver driver.
+ *
+ * This function gets called when an SSI node is found in the device tree.
+ *
+ * Although this is a fabric driver, the SSI node is the "master" node with
+ * respect to audio hardware connections.  Therefore, we create a new ASoC
+ * device for each new SSI node that has a codec attached.
+ *
+ * FIXME: Currently, we only support one DMA controller, so if there are
+ * multiple SSI nodes with codecs, only the first will be supported.
+ *
+ * FIXME: Even if we did support multiple DMA controllers, we have no
+ * mechanism for assigning DMA controllers and channels to the individual
+ * SSI devices.  We also probably aren't compatible with the generic Elo DMA
+ * device driver.
+ */
+static int mpc8610_hpcd_probe(struct of_device *ofdev,
+	const struct of_device_id *match)
+{
+	struct device_node *np = ofdev->node;
+	struct device_node *codec_np = NULL;
+	struct device_node *guts_np = NULL;
+	struct device_node *dma_np = NULL;
+	struct device_node *dma_channel_np = NULL;
+	const char *sprop;
+	const u32 *iprop;
+	struct resource res;
+	struct platform_device *sound_device = NULL;
+	struct mpc8610hpcd_data *machine_data;
+	struct fsl_ssi_info ssi_info;
+	struct fsl_dma_info dma_info;
+	int ret = -ENODEV;
+
+	machine_data = kzalloc(sizeof(struct mpc8610hpcd_data), GFP_KERNEL);
+	if (!machine_data)
+		return -ENOMEM;
+
+	memset(&ssi_info, 0, sizeof(ssi_info));
+	memset(&dma_info, 0, sizeof(dma_info));
+
+	ssi_info.dev = &ofdev->dev;
+
+	/*
+	 * We are only interested in SSIs with a codec child node in them, so
+	 * let's make sure this SSI has one.
+	 */
+	while ((codec_np = of_get_next_child(np, codec_np)) != NULL) {
+		if (strcmp(codec_np->name, "codec") == 0) {
+			/* Most drivers forget the final of_node_put() call */
+			of_node_put(codec_np);
+			break;
+		}
+	}
+
+	if (!codec_np)
+		goto error;
+
+	/* The MPC8610 HPCD only knows about the CS4270 codec, so reject
+	   anything else. */
+	if (!of_device_is_compatible(codec_np, "cirrus,cs4270"))
+		goto error;
+
+	/* Get the device ID */
+	iprop = of_get_property(np, "cell-index", NULL);
+	if (!iprop) {
+		dev_err(&ofdev->dev, "cell-index property not found\n");
+		ret = -EINVAL;
+		goto error;
+	}
+	machine_data->ssi_id = *iprop;
+	ssi_info.id = *iprop;
+
+	/* Get the serial format and clock direction. */
+	sprop = of_get_property(np, "fsl,mode", NULL);
+	if (!sprop) {
+		dev_err(&ofdev->dev, "fsl,mode property not found\n");
+		ret = -EINVAL;
+		goto error;
+	}
+
+	if (strcasecmp(sprop, "i2s-slave") == 0) {
+		machine_data->dai_format = SND_SOC_DAIFMT_I2S;
+		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
+		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
+
+		/* In i2s-slave mode, the codec has its own clock source, so
+		   we need to get the frequency from the device tree and pass
+		   it to the codec driver. */
+		iprop = of_get_property(codec_np, "bus-frequency", NULL);
+		if (!iprop || !*iprop) {
+			dev_err(&ofdev->dev, "codec bus-frequency property "
+				"is missing or invalid\n");
+			ret = -EINVAL;
+			goto error;
+		}
+		machine_data->clk_frequency = *iprop;
+	} else if (strcasecmp(sprop, "i2s-master") == 0) {
+		machine_data->dai_format = SND_SOC_DAIFMT_I2S;
+		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
+		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
+	} else if (strcasecmp(sprop, "lj-slave") == 0) {
+		machine_data->dai_format = SND_SOC_DAIFMT_LEFT_J;
+		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
+		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
+	} else if (strcasecmp(sprop, "lj-master") == 0) {
+		machine_data->dai_format = SND_SOC_DAIFMT_LEFT_J;
+		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
+		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
+	} else if (strcasecmp(sprop, "rj-master") == 0) {
+		machine_data->dai_format = SND_SOC_DAIFMT_RIGHT_J;
+		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
+		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
+	} else if (strcasecmp(sprop, "rj-master") == 0) {
+		machine_data->dai_format = SND_SOC_DAIFMT_RIGHT_J;
+		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
+		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
+	} else if (strcasecmp(sprop, "ac97-slave") == 0) {
+		machine_data->dai_format = SND_SOC_DAIFMT_AC97;
+		machine_data->codec_clk_direction = SND_SOC_CLOCK_OUT;
+		machine_data->cpu_clk_direction = SND_SOC_CLOCK_IN;
+	} else if (strcasecmp(sprop, "ac97-master") == 0) {
+		machine_data->dai_format = SND_SOC_DAIFMT_AC97;
+		machine_data->codec_clk_direction = SND_SOC_CLOCK_IN;
+		machine_data->cpu_clk_direction = SND_SOC_CLOCK_OUT;
+	} else {
+		dev_err(&ofdev->dev,
+			"unrecognized fsl,mode property \"%s\"\n", sprop);
+		ret = -EINVAL;
+		goto error;
+	}
+
+	if (!machine_data->clk_frequency) {
+		dev_err(&ofdev->dev, "unknown clock frequency\n");
+		ret = -EINVAL;
+		goto error;
+	}
+
+	/* Read the SSI information from the device tree */
+	ret = of_address_to_resource(np, 0, &res);
+	if (ret) {
+		dev_err(&ofdev->dev, "could not obtain SSI address\n");
+		goto error;
+	}
+	if (!res.start) {
+		dev_err(&ofdev->dev, "invalid SSI address\n");
+		goto error;
+	}
+	ssi_info.ssi_phys = res.start;
+
+	machine_data->ssi = ioremap(ssi_info.ssi_phys, sizeof(struct ccsr_ssi));
+	if (!machine_data->ssi) {
+		dev_err(&ofdev->dev, "could not map SSI address %x\n",
+			ssi_info.ssi_phys);
+		ret = -EINVAL;
+		goto error;
+	}
+	ssi_info.ssi = machine_data->ssi;
+
+
+	/* Get the IRQ of the SSI */
+	machine_data->ssi_irq = irq_of_parse_and_map(np, 0);
+	if (!machine_data->ssi_irq) {
+		dev_err(&ofdev->dev, "could not get SSI IRQ\n");
+		ret = -EINVAL;
+		goto error;
+	}
+	ssi_info.irq = machine_data->ssi_irq;
+
+
+	/* Map the global utilities registers. */
+	guts_np = of_find_compatible_node(NULL, NULL, "fsl,mpc8610-guts");
+	if (!guts_np) {
+		dev_err(&ofdev->dev, "could not obtain address of GUTS\n");
+		ret = -EINVAL;
+		goto error;
+	}
+	machine_data->guts = of_iomap(guts_np, 0);
+	of_node_put(guts_np);
+	if (!machine_data->guts) {
+		dev_err(&ofdev->dev, "could not map GUTS\n");
+		ret = -EINVAL;
+		goto error;
+	}
+
+	/* Find the DMA channels to use.  For now, we always use the first DMA
+	   controller. */
+	for_each_compatible_node(dma_np, NULL, "fsl,mpc8610-dma") {
+		iprop = of_get_property(dma_np, "cell-index", NULL);
+		if (iprop && (*iprop == 0)) {
+			of_node_put(dma_np);
+			break;
+		}
+	}
+	if (!dma_np) {
+		dev_err(&ofdev->dev, "could not find DMA node\n");
+		ret = -EINVAL;
+		goto error;
+	}
+	machine_data->dma_id = *iprop;
+
+	/*
+	 * Find the DMA channels to use.  For now, we always use DMA channel 0
+	 * for playback, and DMA channel 1 for capture.
+	 */
+	while ((dma_channel_np = of_get_next_child(dma_np, dma_channel_np))) {
+		iprop = of_get_property(dma_channel_np, "cell-index", NULL);
+		/* Is it DMA channel 0? */
+		if (iprop && (*iprop == 0)) {
+			/* dma_channel[0] and dma_irq[0] are for playback */
+			dma_info.dma_channel[0] = of_iomap(dma_channel_np, 0);
+			dma_info.dma_irq[0] =
+				irq_of_parse_and_map(dma_channel_np, 0);
+			machine_data->dma_channel_id[0] = *iprop;
+			continue;
+		}
+		if (iprop && (*iprop == 1)) {
+			/* dma_channel[1] and dma_irq[1] are for capture */
+			dma_info.dma_channel[1] = of_iomap(dma_channel_np, 0);
+			dma_info.dma_irq[1] =
+				irq_of_parse_and_map(dma_channel_np, 0);
+			machine_data->dma_channel_id[1] = *iprop;
+			continue;
+		}
+	}
+	if (!dma_info.dma_channel[0] || !dma_info.dma_channel[1] ||
+	    !dma_info.dma_irq[0] || !dma_info.dma_irq[1]) {
+		dev_err(&ofdev->dev, "could not find DMA channels\n");
+		ret = -EINVAL;
+		goto error;
+	}
+
+	dma_info.ssi_stx_phys = ssi_info.ssi_phys +
+		offsetof(struct ccsr_ssi, stx0);
+	dma_info.ssi_srx_phys = ssi_info.ssi_phys +
+		offsetof(struct ccsr_ssi, srx0);
+
+	/* We have the DMA information, so tell the DMA driver what it is */
+	if (!fsl_dma_configure(&dma_info)) {
+		dev_err(&ofdev->dev, "could not instantiate DMA device\n");
+		ret = -EBUSY;
+		goto error;
+	}
+
+	/*
+	 * Initialize our DAI data structure.  We should probably get this
+	 * information from the device tree.
+	 */
+	machine_data->dai.name = "CS4270";
+	machine_data->dai.stream_name = "CS4270";
+
+	machine_data->dai.cpu_dai = fsl_ssi_create_dai(&ssi_info);
+	machine_data->dai.codec_dai = &cs4270_dai; /* The codec_dai we want */
+	machine_data->dai.ops = &mpc8610hpcd_ops;
+
+	mpc8610_hpcd_machine.dai_link = &machine_data->dai;
+
+	/* Allocate a new audio platform device structure */
+	sound_device = platform_device_alloc("soc-audio", -1);
+	if (!sound_device) {
+		dev_err(&ofdev->dev, "platform device allocation failed\n");
+		ret = -ENOMEM;
+		goto error;
+	}
+
+	machine_data->sound_devdata.machine = &mpc8610_hpcd_machine;
+	machine_data->sound_devdata.codec_dev = &soc_codec_device_cs4270;
+	machine_data->sound_devdata.platform = &fsl_soc_platform;
+
+	sound_device->dev.platform_data = machine_data;
+
+
+	/* Set the platform device and ASoC device to point to each other */
+	platform_set_drvdata(sound_device, &machine_data->sound_devdata);
+
+	machine_data->sound_devdata.dev = &sound_device->dev;
+
+
+	/* Tell ASoC to probe us.  This will call mpc8610_hpcd_machine.probe(),
+	   if it exists. */
+	ret = platform_device_add(sound_device);
+
+	if (ret) {
+		dev_err(&ofdev->dev, "platform device add failed\n");
+		goto error;
+	}
+
+	dev_set_drvdata(&ofdev->dev, sound_device);
+
+	return 0;
+
+error:
+	if (sound_device)
+		platform_device_unregister(sound_device);
+
+	if (machine_data->dai.cpu_dai)
+		fsl_ssi_destroy_dai(machine_data->dai.cpu_dai);
+
+	if (ssi_info.ssi)
+		iounmap(ssi_info.ssi);
+
+	if (ssi_info.irq)
+		irq_dispose_mapping(ssi_info.irq);
+
+	if (dma_info.dma_channel[0])
+		iounmap(dma_info.dma_channel[0]);
+
+	if (dma_info.dma_channel[1])
+		iounmap(dma_info.dma_channel[1]);
+
+	if (dma_info.dma_irq[0])
+		irq_dispose_mapping(dma_info.dma_irq[0]);
+
+	if (dma_info.dma_irq[1])
+		irq_dispose_mapping(dma_info.dma_irq[1]);
+
+	if (machine_data->guts)
+		iounmap(machine_data->guts);
+
+	kfree(machine_data);
+
+	return ret;
+}
+
+static int mpc8610_hpcd_remove(struct of_device *ofdev)
+{
+	struct platform_device *sound_device = dev_get_drvdata(&ofdev->dev);
+	struct mpc8610hpcd_data *machine_data = sound_device->dev.platform_data;
+
+	platform_device_unregister(sound_device);
+
+	if (machine_data->dai.cpu_dai)
+		fsl_ssi_destroy_dai(machine_data->dai.cpu_dai);
+
+	if (machine_data->ssi)
+		iounmap(machine_data->ssi);
+
+	if (machine_data->dma[0])
+		iounmap(machine_data->dma[0]);
+
+	if (machine_data->dma[1])
+		iounmap(machine_data->dma[1]);
+
+	if (machine_data->dma_irq[0])
+		irq_dispose_mapping(machine_data->dma_irq[0]);
+
+	if (machine_data->dma_irq[1])
+		irq_dispose_mapping(machine_data->dma_irq[1]);
+
+	if (machine_data->guts)
+		iounmap(machine_data->guts);
+
+	kfree(machine_data);
+	sound_device->dev.platform_data = NULL;
+
+	dev_set_drvdata(&ofdev->dev, NULL);
+
+	return 0;
+}
+
+static struct of_device_id mpc8610_hpcd_match[] = {
+	{
+		.compatible = "fsl,ssi",
+	},
+	{}
+};
+MODULE_DEVICE_TABLE(of, mpc8610_hpcd_match);
+
+static struct of_platform_driver mpc8610_hpcd_of_driver = {
+	.owner  	= THIS_MODULE,
+	.name   	= "mpc8610_hpcd",
+	.match_table    = mpc8610_hpcd_match,
+	.probe  	= mpc8610_hpcd_probe,
+	.remove 	= mpc8610_hpcd_remove,
+};
+
+/**
+ * Fabric driver initialization.
+ *
+ * This function is called when this module is loaded.
+ */
+static int __init mpc8610hpcd_init(void)
+{
+	int ret;
+
+	printk(KERN_INFO "Freescale MPC8610 HPCD ALSA SoC fabric driver\n");
+
+	ret = of_register_platform_driver(&mpc8610_hpcd_of_driver);
+
+	if (ret)
+		printk(KERN_ERR
+			"mpc8610-hpcd: failed to register platform driver\n");
+
+	return ret;
+}
+
+/**
+ * Fabric driver exit
+ *
+ * This function is called when this driver is unloaded.
+ */
+static void __exit mpc8610hpcd_exit(void)
+{
+	of_unregister_platform_driver(&mpc8610_hpcd_of_driver);
+}
+
+module_init(mpc8610hpcd_init);
+module_exit(mpc8610hpcd_exit);
+
+MODULE_AUTHOR("Timur Tabi <timur@freescale.com>");
+MODULE_DESCRIPTION("Freescale MPC8610 HPCD ALSA SoC fabric driver");
+MODULE_LICENSE("GPL");
-- 
1.5.2.4
