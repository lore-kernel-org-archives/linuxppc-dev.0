Return-Path: <w.sang@pengutronix.de>
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de
	[IPv6:2001:6f8:1178:4:290:27ff:fe1d:cc33])
	(using TLSv1 with cipher AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 3AFD7B6F88
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Sep 2011 20:49:35 +1000 (EST)
From: Wolfram Sang <w.sang@pengutronix.de>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH V2 1/2] gpio: move mpc8xxx/512x gpio driver to drivers/gpio
Date: Wed, 21 Sep 2011 12:49:20 +0200
Message-Id: <1316602161-12546-1-git-send-email-w.sang@pengutronix.de>
Cc: Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Move the driver to the place where it is expected to be nowadays. Also
rename its CONFIG-name to match the rest and adapt the defconfigs.
Finally, move selection of REQUIRE_GPIOLIB or WANTS_OPTIONAL_GPIOLIB to
the platforms, because this option is per-platform and not per-driver.

Signed-off-by: Wolfram Sang <w.sang@pengutronix.de>
Cc: Anatolij Gustschin <agust@denx.de>
Cc: Grant Likely <grant.likely@secretlab.ca>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

I'd think this should go via ppc, so it is in sync with the defconfig update of
patch 2/2.

Changes since V1: Use -C in format-patch to show the rename.

 arch/powerpc/configs/85xx/p1023rds_defconfig       |    2 +-
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig    |    2 +-
 arch/powerpc/configs/mpc85xx_defconfig             |    2 +-
 arch/powerpc/configs/mpc85xx_smp_defconfig         |    2 +-
 arch/powerpc/configs/ppc6xx_defconfig              |    2 +-
 arch/powerpc/platforms/512x/Kconfig                |    1 +
 arch/powerpc/platforms/83xx/Kconfig                |    9 ++++++---
 arch/powerpc/platforms/85xx/Kconfig                |   12 ++++++++----
 arch/powerpc/platforms/86xx/Kconfig                |    1 +
 arch/powerpc/platforms/Kconfig                     |   10 ----------
 arch/powerpc/sysdev/Makefile                       |    1 -
 drivers/gpio/Kconfig                               |    8 ++++++++
 drivers/gpio/Makefile                              |    1 +
 .../mpc8xxx_gpio.c => drivers/gpio/gpio-mpc8xxx.c  |    0
 14 files changed, 30 insertions(+), 23 deletions(-)
 rename arch/powerpc/sysdev/mpc8xxx_gpio.c => drivers/gpio/gpio-mpc8xxx.c (100%)

diff --git a/arch/powerpc/configs/85xx/p1023rds_defconfig b/arch/powerpc/configs/85xx/p1023rds_defconfig
index 3ff5a81..c091aaf 100644
--- a/arch/powerpc/configs/85xx/p1023rds_defconfig
+++ b/arch/powerpc/configs/85xx/p1023rds_defconfig
@@ -24,7 +24,7 @@ CONFIG_P1023_RDS=y
 CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
 CONFIG_CPM2=y
-CONFIG_MPC8xxx_GPIO=y
+CONFIG_GPIO_MPC8XXX=y
 CONFIG_HIGHMEM=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
index 5ea3124..1cd6fcb 100644
--- a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
+++ b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
@@ -20,7 +20,7 @@ CONFIG_MODULE_FORCE_UNLOAD=y
 CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_XES_MPC85xx=y
-CONFIG_MPC8xxx_GPIO=y
+CONFIG_GPIO_MPC8XXX=y
 CONFIG_HIGHMEM=y
 CONFIG_MATH_EMULATION=y
 CONFIG_SPARSE_IRQ=y
diff --git a/arch/powerpc/configs/mpc85xx_defconfig b/arch/powerpc/configs/mpc85xx_defconfig
index a3467bf..2500912 100644
--- a/arch/powerpc/configs/mpc85xx_defconfig
+++ b/arch/powerpc/configs/mpc85xx_defconfig
@@ -41,7 +41,7 @@ CONFIG_TQM8560=y
 CONFIG_SBC8548=y
 CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
-CONFIG_MPC8xxx_GPIO=y
+CONFIG_GPIO_MPC8XXX=y
 CONFIG_HIGHMEM=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/powerpc/configs/mpc85xx_smp_defconfig b/arch/powerpc/configs/mpc85xx_smp_defconfig
index 9693f6e..a4ba13b 100644
--- a/arch/powerpc/configs/mpc85xx_smp_defconfig
+++ b/arch/powerpc/configs/mpc85xx_smp_defconfig
@@ -42,7 +42,7 @@ CONFIG_TQM8560=y
 CONFIG_SBC8548=y
 CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
-CONFIG_MPC8xxx_GPIO=y
+CONFIG_GPIO_MPC8XXX=y
 CONFIG_HIGHMEM=y
 CONFIG_NO_HZ=y
 CONFIG_HIGH_RES_TIMERS=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 04360f9..c47f2be 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -70,7 +70,7 @@ CONFIG_TAU_AVERAGE=y
 CONFIG_QUICC_ENGINE=y
 CONFIG_QE_GPIO=y
 CONFIG_PPC_BESTCOMM=y
-CONFIG_MPC8xxx_GPIO=y
+CONFIG_GPIO_MPC8XXX=y
 CONFIG_MCU_MPC8349EMITX=m
 CONFIG_HIGHMEM=y
 CONFIG_NO_HZ=y
diff --git a/arch/powerpc/platforms/512x/Kconfig b/arch/powerpc/platforms/512x/Kconfig
index 27b0651..b3ebce1 100644
--- a/arch/powerpc/platforms/512x/Kconfig
+++ b/arch/powerpc/platforms/512x/Kconfig
@@ -6,6 +6,7 @@ config PPC_MPC512x
 	select PPC_CLOCK
 	select PPC_PCI_CHOICE
 	select FSL_PCI if PCI
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 
 config MPC5121_ADS
 	bool "Freescale MPC5121E ADS"
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 73f4135..670a033 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -114,18 +114,21 @@ config KMETER1
 
 endif
 
-# used for usb
+# used for usb & gpio
 config PPC_MPC831x
 	bool
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 
 # used for math-emu
 config PPC_MPC832x
 	bool
 
-# used for usb
+# used for usb & gpio
 config PPC_MPC834x
 	bool
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 
-# used for usb
+# used for usb & gpio
 config PPC_MPC837x
 	bool
+	select ARCH_WANT_OPTIONAL_GPIOLIB
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 498534c..1b393f4 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -177,7 +177,8 @@ config P2040_RDB
 	select PPC_E500MC
 	select PHYS_64BIT
 	select SWIOTLB
-	select MPC8xxx_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
 	help
@@ -189,7 +190,8 @@ config P3041_DS
 	select PPC_E500MC
 	select PHYS_64BIT
 	select SWIOTLB
-	select MPC8xxx_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
 	help
@@ -201,7 +203,8 @@ config P4080_DS
 	select PPC_E500MC
 	select PHYS_64BIT
 	select SWIOTLB
-	select MPC8xxx_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
 	help
@@ -216,7 +219,8 @@ config P5020_DS
 	select PPC_E500MC
 	select PHYS_64BIT
 	select SWIOTLB
-	select MPC8xxx_GPIO
+	select ARCH_REQUIRE_GPIOLIB
+	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
 	help
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index a0b5638..8d6599d 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -4,6 +4,7 @@ menuconfig PPC_86xx
 	depends on 6xx
 	select FSL_SOC
 	select ALTIVEC
+	select ARCH_WANT_OPTIONAL_GPIOLIB
 	help
 	  The Freescale E600 SoCs have 74xx cores.
 
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index b9ba861..c0cb1ea 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -333,16 +333,6 @@ config OF_RTC
 
 source "arch/powerpc/sysdev/bestcomm/Kconfig"
 
-config MPC8xxx_GPIO
-	bool "MPC512x/MPC8xxx GPIO support"
-	depends on PPC_MPC512x || PPC_MPC831x || PPC_MPC834x || PPC_MPC837x || \
-		   FSL_SOC_BOOKE || PPC_86xx
-	select GENERIC_GPIO
-	select ARCH_REQUIRE_GPIOLIB
-	help
-	  Say Y here if you're going to use hardware that connects to the
-	  MPC512x/831x/834x/837x/8572/8610 GPIOs.
-
 config SIMPLE_GPIO
 	bool "Support for simple, memory-mapped GPIO controllers"
 	depends on PPC
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index cf736ca..84e1325 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -18,7 +18,6 @@ obj-$(CONFIG_FSL_PCI)		+= fsl_pci.o $(fsl-msi-obj-y)
 obj-$(CONFIG_FSL_PMC)		+= fsl_pmc.o
 obj-$(CONFIG_FSL_LBC)		+= fsl_lbc.o
 obj-$(CONFIG_FSL_GTM)		+= fsl_gtm.o
-obj-$(CONFIG_MPC8xxx_GPIO)	+= mpc8xxx_gpio.o
 obj-$(CONFIG_FSL_85XX_CACHE_SRAM)	+= fsl_85xx_l2ctlr.o fsl_85xx_cache_sram.o
 obj-$(CONFIG_SIMPLE_GPIO)	+= simple_gpio.o
 obj-$(CONFIG_FSL_RIO)		+= fsl_rio.o
diff --git a/drivers/gpio/Kconfig b/drivers/gpio/Kconfig
index d539efd..4744cf2 100644
--- a/drivers/gpio/Kconfig
+++ b/drivers/gpio/Kconfig
@@ -103,6 +103,14 @@ config GPIO_MPC5200
 	def_bool y
 	depends on PPC_MPC52xx
 
+config GPIO_MPC8XXX
+	bool "MPC512x/MPC8xxx GPIO support"
+	depends on PPC_MPC512x || PPC_MPC831x || PPC_MPC834x || PPC_MPC837x || \
+		   FSL_SOC_BOOKE || PPC_86xx
+	help
+	  Say Y here if you're going to use hardware that connects to the
+	  MPC512x/831x/834x/837x/8572/8610 GPIOs.
+
 config GPIO_MSM_V1
 	tristate "Qualcomm MSM GPIO v1"
 	depends on GPIOLIB && ARCH_MSM
diff --git a/drivers/gpio/Makefile b/drivers/gpio/Makefile
index 9588948..828bba9 100644
--- a/drivers/gpio/Makefile
+++ b/drivers/gpio/Makefile
@@ -27,6 +27,7 @@ obj-$(CONFIG_GPIO_MC33880)	+= gpio-mc33880.o
 obj-$(CONFIG_GPIO_MCP23S08)	+= gpio-mcp23s08.o
 obj-$(CONFIG_GPIO_ML_IOH)	+= gpio-ml-ioh.o
 obj-$(CONFIG_GPIO_MPC5200)	+= gpio-mpc5200.o
+obj-$(CONFIG_GPIO_MPC8XXX)	+= gpio-mpc8xxx.o
 obj-$(CONFIG_GPIO_MSM_V1)	+= gpio-msm-v1.o
 obj-$(CONFIG_GPIO_MSM_V2)	+= gpio-msm-v2.o
 obj-$(CONFIG_GPIO_MXC)		+= gpio-mxc.o
diff --git a/arch/powerpc/sysdev/mpc8xxx_gpio.c b/drivers/gpio/gpio-mpc8xxx.c
similarity index 100%
rename from arch/powerpc/sysdev/mpc8xxx_gpio.c
rename to drivers/gpio/gpio-mpc8xxx.c
-- 
1.7.5.4
