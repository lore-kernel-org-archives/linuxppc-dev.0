Return-Path: <grant.likely@secretlab.ca>
Received: from sandbox.secretlab.ca (S01060016b61d1226.cg.shawcable.net
	[68.147.191.145]) by ozlabs.org (Postfix) with ESMTP id 6073767BF7
	for <linuxppc-dev@ozlabs.org>; Thu, 14 Dec 2006 02:36:06 +1100 (EST)
From: Grant Likely <grant.likely@secretlab.ca>
To: linuxppc-dev@ozlabs.org, Sylvain Munaut <tnt@246tNt.com>,
	Paul Mackerras <paulus@samba.org>
Subject: [POWERPC] Change mpc52xx Kconfig entries to match other freescale
	parts
Date: Wed, 13 Dec 2006 08:35:25 -0700
Message-Id: <11660241251891-git-send-email-grant.likely@secretlab.ca>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

All other Freescale parts use Kconfig defines of the form: PPC_8?xx
The MPC52xx is currently in the form: PPC_MPC52xx.  This commit changes
it to PPC_52xx for consistency sake.

Signed-off-by: Grant Likely <grant.likely@secretlab.ca>
---
 Documentation/powerpc/mpc52xx.txt         |    2 +-
 arch/powerpc/Kconfig                      |   16 ++++++++--------
 arch/powerpc/Kconfig.debug                |    2 +-
 arch/powerpc/configs/lite5200_defconfig   |    2 +-
 arch/powerpc/platforms/52xx/mpc52xx_pci.c |    4 ++--
 arch/powerpc/platforms/Makefile           |    2 +-
 arch/ppc/Kconfig                          |    6 +++---
 arch/ppc/Kconfig.debug                    |    2 +-
 arch/ppc/configs/lite5200_defconfig       |    2 +-
 arch/ppc/kernel/setup.c                   |    2 +-
 arch/ppc/syslib/Makefile                  |    4 ++--
 drivers/serial/Kconfig                    |    2 +-
 drivers/usb/Kconfig                       |    2 +-
 drivers/usb/host/Kconfig                  |    6 +++---
 include/asm-ppc/ppc_sys.h                 |    2 +-
 include/asm-ppc/ppcboot.h                 |    4 ++--
 16 files changed, 30 insertions(+), 30 deletions(-)

diff --git a/Documentation/powerpc/mpc52xx.txt b/Documentation/powerpc/mpc52xx.txt
index 10dd4ab..1ba7997 100644
--- a/Documentation/powerpc/mpc52xx.txt
+++ b/Documentation/powerpc/mpc52xx.txt
@@ -29,7 +29,7 @@ To compile/use :
      
 
 Some remarks :
- - The port is named mpc52xxx, and config options are PPC_MPC52xx. The MGT5100
+ - The port is named mpc52xxx, and config options are PPC_52xx. The MGT5100
    is not supported, and I'm not sure anyone is interesting in working on it
    so. I didn't took 5xxx because there's apparently a lot of 5xxx that have
    nothing to do with the MPC5200. I also included the 'MPC' for the same
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index f3a3375..44c826e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -425,18 +425,18 @@ config PPC_CHRP
 	select PPC_NATIVE
 	default y
 
-config PPC_MPC52xx
+config PPC_52xx
 	bool
 	default n
 
-config PPC_MPC5200
+config PPC_5200
 	bool
-	select PPC_MPC52xx
+	select PPC_52xx
 	default n
 
-config PPC_MPC5200_BUGFIX
+config PPC_5200_BUGFIX
 	bool "MPC5200 (L25R) bugfix support"
-	depends on PPC_MPC5200
+	depends on PPC_5200
 	default n
 	help
 	  Enable workarounds for original MPC5200 errata.  This is not required
@@ -449,14 +449,14 @@ config PPC_EFIKA
 	depends on PPC_MULTIPLATFORM && PPC32
 	select PPC_RTAS
 	select RTAS_PROC
-	select PPC_MPC52xx
+	select PPC_52xx
 	select PPC_NATIVE
 	default y
 
 config PPC_LITE5200
 	bool "Freescale Lite5200 Eval Board"
 	depends on PPC_MULTIPLATFORM && PPC32
-	select PPC_MPC5200
+	select PPC_5200
 	default n
 
 config PPC_PMAC
@@ -982,7 +982,7 @@ config MCA
 
 config PCI
 	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx \
-		|| PPC_MPC52xx || (EMBEDDED && PPC_ISERIES) || MPC7448HPC2 || PPC_PS3
+		|| PPC_52xx || (EMBEDDED && PPC_ISERIES) || MPC7448HPC2 || PPC_PS3
 	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx \
 		&& !PPC_85xx && !PPC_86xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
diff --git a/arch/powerpc/Kconfig.debug b/arch/powerpc/Kconfig.debug
index f0e51ed..2a245eb 100644
--- a/arch/powerpc/Kconfig.debug
+++ b/arch/powerpc/Kconfig.debug
@@ -133,7 +133,7 @@ config BOOTX_TEXT
 config SERIAL_TEXT_DEBUG
 	bool "Support for early boot texts over serial port"
 	depends on 4xx || LOPEC || MV64X60 || PPLUS || PRPMC800 || \
-		PPC_GEN550 || PPC_MPC52xx
+		PPC_GEN550 || PPC_52xx
 
 config PPC_EARLY_DEBUG
 	bool "Early debugging (dangerous)"
diff --git a/arch/powerpc/configs/lite5200_defconfig b/arch/powerpc/configs/lite5200_defconfig
index ee76557..7d9aa6a 100644
--- a/arch/powerpc/configs/lite5200_defconfig
+++ b/arch/powerpc/configs/lite5200_defconfig
@@ -128,7 +128,7 @@ CONFIG_PPC_MULTIPLATFORM=y
 # CONFIG_EMBEDDED6xx is not set
 # CONFIG_APUS is not set
 # CONFIG_PPC_CHRP is not set
-CONFIG_PPC_MPC52xx=y
+CONFIG_PPC_52xx=y
 # CONFIG_PPC_EFIKA is not set
 CONFIG_PPC_LITE5200=y
 # CONFIG_PPC_PMAC is not set
diff --git a/arch/powerpc/platforms/52xx/mpc52xx_pci.c b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
index faf161b..35b6ce4 100644
--- a/arch/powerpc/platforms/52xx/mpc52xx_pci.c
+++ b/arch/powerpc/platforms/52xx/mpc52xx_pci.c
@@ -122,7 +122,7 @@ mpc52xx_pci_read_config(struct pci_bus *
 		(offset & 0xfc));
 	mb();
 
-#if defined(CONFIG_PPC_MPC5200_BUGFIX)
+#if defined(CONFIG_PPC_5200_BUGFIX)
 	if (bus->number != hose->bus_offset) {
 		/* workaround for the bug 435 of the MPC5200 (L25R);
 		 * Don't do 32 bits config access during type-1 cycles */
@@ -179,7 +179,7 @@ mpc52xx_pci_write_config(struct pci_bus 
 		(offset & 0xfc));
 	mb();
 
-#if defined(CONFIG_PPC_MPC5200_BUGFIX)
+#if defined(CONFIG_PPC_5200_BUGFIX)
 	if (bus->number != hose->bus_offset) {
 		/* workaround for the bug 435 of the MPC5200 (L25R);
 		 * Don't do 32 bits config access during type-1 cycles */
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index 44d95ea..edffe8d 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -7,7 +7,7 @@ endif
 endif
 obj-$(CONFIG_PPC_CHRP)		+= chrp/
 obj-$(CONFIG_4xx)		+= 4xx/
-obj-$(CONFIG_PPC_MPC52xx)	+= 52xx/
+obj-$(CONFIG_PPC_52xx)		+= 52xx/
 obj-$(CONFIG_PPC_83xx)		+= 83xx/
 obj-$(CONFIG_PPC_85xx)		+= 85xx/
 obj-$(CONFIG_PPC_86xx)		+= 86xx/
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index 692b5ba..1b5e5f4 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -726,7 +726,7 @@ config PQ2FADS
 
 config LITE5200
 	bool "Freescale LITE5200 / (IceCube)"
-	select PPC_MPC52xx
+	select PPC_52xx
 	help
 	  Support for the LITE5200 dev board for the MPC5200 from Freescale.
 	  This is for the LITE5200 version 2.0 board. Don't know if it changes
@@ -772,7 +772,7 @@ config EMBEDDEDBOOT
 	depends on 8xx || 8260
 	default y
 
-config PPC_MPC52xx
+config PPC_52xx
 	bool
 
 config 8260
@@ -1216,7 +1216,7 @@ config MCA
 	bool
 
 config PCI
-	bool "PCI support" if 40x || CPM2 || 83xx || 85xx || PPC_MPC52xx
+	bool "PCI support" if 40x || CPM2 || 83xx || 85xx || PPC_52xx
 	default y if !40x && !CPM2 && !8xx && !APUS && !83xx && !85xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
 	default PCI_QSPAN if !4xx && !CPM2 && 8xx
diff --git a/arch/ppc/Kconfig.debug b/arch/ppc/Kconfig.debug
index f94b877..e8697ea 100644
--- a/arch/ppc/Kconfig.debug
+++ b/arch/ppc/Kconfig.debug
@@ -56,7 +56,7 @@ config BDI_SWITCH
 config SERIAL_TEXT_DEBUG
 	bool "Support for early boot texts over serial port"
 	depends on 4xx || LOPEC || MV64X60 || PPLUS || PRPMC800 || \
-		PPC_GEN550 || PPC_MPC52xx
+		PPC_GEN550 || PPC_52xx
 
 config PPC_OCP
 	bool
diff --git a/arch/ppc/configs/lite5200_defconfig b/arch/ppc/configs/lite5200_defconfig
index 7e7a943..1659eff 100644
--- a/arch/ppc/configs/lite5200_defconfig
+++ b/arch/ppc/configs/lite5200_defconfig
@@ -88,7 +88,7 @@ # CONFIG_RPX6 is not set
 # CONFIG_TQM8260 is not set
 # CONFIG_ADS8272 is not set
 CONFIG_LITE5200=y
-CONFIG_PPC_MPC52xx=y
+CONFIG_PPC_52xx=y
 # CONFIG_SMP is not set
 # CONFIG_PREEMPT is not set
 # CONFIG_HIGHMEM is not set
diff --git a/arch/ppc/kernel/setup.c b/arch/ppc/kernel/setup.c
index 3c506af..7912874 100644
--- a/arch/ppc/kernel/setup.c
+++ b/arch/ppc/kernel/setup.c
@@ -42,7 +42,7 @@ #include <asm/prom.h>
 
 #define USES_PPC_SYS (defined(CONFIG_85xx) || defined(CONFIG_83xx) || \
 		      defined(CONFIG_MPC10X_BRIDGE) || defined(CONFIG_8260) || \
-		      defined(CONFIG_PPC_MPC52xx))
+		      defined(CONFIG_PPC_52xx))
 
 #if USES_PPC_SYS
 #include <asm/ppc_sys.h>
diff --git a/arch/ppc/syslib/Makefile b/arch/ppc/syslib/Makefile
index dca23f2..0fac5b9 100644
--- a/arch/ppc/syslib/Makefile
+++ b/arch/ppc/syslib/Makefile
@@ -99,9 +99,9 @@ obj-$(CONFIG_PCI)		+= pci_auto.o
 endif
 obj-$(CONFIG_MPC8548_CDS)	+= todc_time.o
 obj-$(CONFIG_MPC8555_CDS)	+= todc_time.o
-obj-$(CONFIG_PPC_MPC52xx)	+= mpc52xx_setup.o mpc52xx_pic.o \
+obj-$(CONFIG_PPC_52xx)		+= mpc52xx_setup.o mpc52xx_pic.o \
 					mpc52xx_sys.o mpc52xx_devices.o ppc_sys.o
-ifeq ($(CONFIG_PPC_MPC52xx),y)
+ifeq ($(CONFIG_PPC_52xx),y)
 obj-$(CONFIG_PCI)		+= mpc52xx_pci.o
 endif
 
diff --git a/drivers/serial/Kconfig b/drivers/serial/Kconfig
index 0b36dd5..2e9150a 100644
--- a/drivers/serial/Kconfig
+++ b/drivers/serial/Kconfig
@@ -840,7 +840,7 @@ config SERIAL_SGI_L1_CONSOLE
 
 config SERIAL_MPC52xx
 	tristate "Freescale MPC52xx family PSC serial support"
-	depends on PPC_MPC52xx
+	depends on PPC_52xx
 	select SERIAL_CORE
 	help
 	  This drivers support the MPC52xx PSC serial ports. If you would
diff --git a/drivers/usb/Kconfig b/drivers/usb/Kconfig
index 9980a4d..fab22b8 100644
--- a/drivers/usb/Kconfig
+++ b/drivers/usb/Kconfig
@@ -28,7 +28,7 @@ config USB_ARCH_HAS_OHCI
 	default y if ARCH_PNX4008
 	# PPC:
 	default y if STB03xxx
-	default y if PPC_MPC52xx
+	default y if PPC_52xx
 	# MIPS:
 	default y if SOC_AU1X00
 	# more:
diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index cc60759..917b691 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -99,7 +99,7 @@ config USB_OHCI_HCD
 
 config USB_OHCI_HCD_PPC_SOC
 	bool "OHCI support for on-chip PPC USB controller"
-	depends on USB_OHCI_HCD && (STB03xxx || PPC_MPC52xx)
+	depends on USB_OHCI_HCD && (STB03xxx || PPC_52xx)
 	default y
 	select USB_OHCI_BIG_ENDIAN
 	---help---
@@ -108,7 +108,7 @@ config USB_OHCI_HCD_PPC_SOC
 
 config USB_OHCI_HCD_PCI
 	bool "OHCI support for PCI-bus USB controllers"
-	depends on USB_OHCI_HCD && PCI && (STB03xxx || PPC_MPC52xx)
+	depends on USB_OHCI_HCD && PCI && (STB03xxx || PPC_52xx)
 	default y
 	select USB_OHCI_LITTLE_ENDIAN
 	---help---
@@ -123,7 +123,7 @@ config USB_OHCI_BIG_ENDIAN
 config USB_OHCI_LITTLE_ENDIAN
 	bool
 	depends on USB_OHCI_HCD
-	default n if STB03xxx || PPC_MPC52xx
+	default n if STB03xxx || PPC_52xx
 	default y
 
 config USB_UHCI_HCD
diff --git a/include/asm-ppc/ppc_sys.h b/include/asm-ppc/ppc_sys.h
index 40f197a..9778cd9 100644
--- a/include/asm-ppc/ppc_sys.h
+++ b/include/asm-ppc/ppc_sys.h
@@ -29,7 +29,7 @@ #elif defined(CONFIG_85xx)
 #include <asm/mpc85xx.h>
 #elif defined(CONFIG_8xx)
 #include <asm/mpc8xx.h>
-#elif defined(CONFIG_PPC_MPC52xx)
+#elif defined(CONFIG_PPC_52xx)
 #include <asm/mpc52xx.h>
 #elif defined(CONFIG_MPC10X_BRIDGE)
 #include <asm/mpc10x.h>
diff --git a/include/asm-ppc/ppcboot.h b/include/asm-ppc/ppcboot.h
index 6b7b63f..7d2ed2b 100644
--- a/include/asm-ppc/ppcboot.h
+++ b/include/asm-ppc/ppcboot.h
@@ -42,7 +42,7 @@ #if defined(CONFIG_8xx) || defined(CONFI
 	defined(CONFIG_83xx)
 	unsigned long	bi_immr_base;	/* base of IMMR register */
 #endif
-#if defined(CONFIG_PPC_MPC52xx)
+#if defined(CONFIG_PPC_52xx)
 	unsigned long   bi_mbar_base;   /* base of internal registers */
 #endif
 	unsigned long	bi_bootflags;	/* boot / reboot flag (for LynxOS) */
@@ -57,7 +57,7 @@ #if defined(CONFIG_CPM2)
 	unsigned long	bi_sccfreq;	/* SCC_CLK Freq, in MHz */
 	unsigned long	bi_vco;		/* VCO Out from PLL, in MHz */
 #endif
-#if defined(CONFIG_PPC_MPC52xx)
+#if defined(CONFIG_PPC_52xx)
 	unsigned long   bi_ipbfreq;     /* IPB Bus Freq, in MHz */
 	unsigned long   bi_pcifreq;     /* PCI Bus Freq, in MHz */
 #endif
-- 
1.4.3.rc2.g0503
