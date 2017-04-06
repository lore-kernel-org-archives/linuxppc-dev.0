Return-Path: <bp@alien8.de>
Received: from mail.skyhub.de (mail.skyhub.de [IPv6:2a01:4f8:190:11c2::b:1457])
 by lists.ozlabs.org (Postfix) with ESMTP id 3vzH9J1K88zDqGv
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Apr 2017 19:15:00 +1000 (AEST)
From: Borislav Petkov <bp@alien8.de>
To: linux-edac <linux-edac@vger.kernel.org>
Cc: LKML <linux-kernel@vger.kernel.org>, linux-arm-kernel@lists.infradead.org,
 linuxppc-dev@lists.ozlabs.org, Chris Metcalf <cmetcalf@mellanox.com>
Subject: [PATCH 08/11] EDAC: Remove EDAC_MM_EDAC
Date: Thu,  6 Apr 2017 11:06:31 +0200
Message-Id: <20170406090634.30950-9-bp@alien8.de>
In-Reply-To: <20170406090634.30950-1-bp@alien8.de>
References: <20170406090634.30950-1-bp@alien8.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Borislav Petkov <bp@suse.de>

Move all the EDAC core functionality behind CONFIG_EDAC and get rid of
that indirection. Update defconfigs which had it.

While at it, fix dependencies such that EDAC depends on RAS for the
tracepoints.

Signed-off-by: Borislav Petkov <bp@suse.de>
Cc: linux-arm-kernel@lists.infradead.org
Cc: linuxppc-dev@lists.ozlabs.org
Cc: Chris Metcalf <cmetcalf@mellanox.com>
Cc: linux-edac@vger.kernel.org
---
 arch/arm/configs/multi_v7_defconfig             |   1 -
 arch/arm/configs/pxa_defconfig                  |   3 +-
 arch/powerpc/configs/85xx-hw.config             |   3 +-
 arch/powerpc/configs/85xx/ge_imp3a_defconfig    |   1 -
 arch/powerpc/configs/85xx/xes_mpc85xx_defconfig |   1 -
 arch/powerpc/configs/cell_defconfig             |   1 -
 arch/powerpc/configs/pasemi_defconfig           |   1 -
 arch/powerpc/configs/ppc64_defconfig            |   1 -
 arch/powerpc/configs/ppc64e_defconfig           |   1 -
 arch/powerpc/configs/ppc6xx_defconfig           |   3 +-
 arch/tile/configs/tilegx_defconfig              |   1 -
 arch/tile/configs/tilepro_defconfig             |   1 -
 drivers/acpi/Kconfig                            |   1 -
 drivers/edac/Kconfig                            | 101 ++++++++++--------------
 drivers/edac/Makefile                           |   3 +-
 drivers/edac/edac_stub.c                        |   2 +-
 16 files changed, 48 insertions(+), 77 deletions(-)

diff --git a/arch/arm/configs/multi_v7_defconfig b/arch/arm/configs/multi_v7_defconfig
index a94126fb02c2..6aa7be191f1a 100644
--- a/arch/arm/configs/multi_v7_defconfig
+++ b/arch/arm/configs/multi_v7_defconfig
@@ -748,7 +748,6 @@ CONFIG_LEDS_TRIGGER_DEFAULT_ON=y
 CONFIG_LEDS_TRIGGER_TRANSIENT=y
 CONFIG_LEDS_TRIGGER_CAMERA=y
 CONFIG_EDAC=y
-CONFIG_EDAC_MM_EDAC=y
 CONFIG_EDAC_HIGHBANK_MC=y
 CONFIG_EDAC_HIGHBANK_L2=y
 CONFIG_RTC_CLASS=y
diff --git a/arch/arm/configs/pxa_defconfig b/arch/arm/configs/pxa_defconfig
index 2aac99fd1c41..1318f61589dc 100644
--- a/arch/arm/configs/pxa_defconfig
+++ b/arch/arm/configs/pxa_defconfig
@@ -635,8 +635,7 @@ CONFIG_LEDS_TRIGGER_GPIO=m
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
 CONFIG_LEDS_TRIGGER_TRANSIENT=m
 CONFIG_LEDS_TRIGGER_CAMERA=m
-CONFIG_EDAC=y
-CONFIG_EDAC_MM_EDAC=m
+CONFIG_EDAC=m
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DEBUG=y
 CONFIG_RTC_DRV_DS1307=m
diff --git a/arch/powerpc/configs/85xx-hw.config b/arch/powerpc/configs/85xx-hw.config
index 528ff0e714e6..c03d0fb16665 100644
--- a/arch/powerpc/configs/85xx-hw.config
+++ b/arch/powerpc/configs/85xx-hw.config
@@ -16,9 +16,8 @@ CONFIG_DAVICOM_PHY=y
 CONFIG_DMADEVICES=y
 CONFIG_E1000E=y
 CONFIG_E1000=y
-CONFIG_EDAC_MM_EDAC=y
-CONFIG_EDAC_MPC85XX=y
 CONFIG_EDAC=y
+CONFIG_EDAC_MPC85XX=y
 CONFIG_EEPROM_AT24=y
 CONFIG_EEPROM_LEGACY=y
 CONFIG_FB_FSL_DIU=y
diff --git a/arch/powerpc/configs/85xx/ge_imp3a_defconfig b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
index c79283be5680..a917f7afb4f9 100644
--- a/arch/powerpc/configs/85xx/ge_imp3a_defconfig
+++ b/arch/powerpc/configs/85xx/ge_imp3a_defconfig
@@ -155,7 +155,6 @@ CONFIG_USB_OHCI_HCD_PPC_OF_BE=y
 CONFIG_USB_OHCI_HCD_PPC_OF_LE=y
 CONFIG_USB_STORAGE=y
 CONFIG_EDAC=y
-CONFIG_EDAC_MM_EDAC=y
 CONFIG_EDAC_MPC85XX=y
 CONFIG_RTC_CLASS=y
 # CONFIG_RTC_INTF_PROC is not set
diff --git a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
index dbd961de251e..72900b84d3e0 100644
--- a/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
+++ b/arch/powerpc/configs/85xx/xes_mpc85xx_defconfig
@@ -116,7 +116,6 @@ CONFIG_LEDS_TRIGGERS=y
 CONFIG_LEDS_TRIGGER_TIMER=y
 CONFIG_LEDS_TRIGGER_HEARTBEAT=y
 CONFIG_EDAC=y
-CONFIG_EDAC_MM_EDAC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_RTC_DRV_CMOS=y
diff --git a/arch/powerpc/configs/cell_defconfig b/arch/powerpc/configs/cell_defconfig
index 2d7fcbe047ac..aa564599e368 100644
--- a/arch/powerpc/configs/cell_defconfig
+++ b/arch/powerpc/configs/cell_defconfig
@@ -179,7 +179,6 @@ CONFIG_INFINIBAND_MTHCA=m
 CONFIG_INFINIBAND_IPOIB=m
 CONFIG_INFINIBAND_IPOIB_DEBUG_DATA=y
 CONFIG_EDAC=y
-CONFIG_EDAC_MM_EDAC=y
 CONFIG_EDAC_CELL=y
 CONFIG_UIO=m
 CONFIG_EXT2_FS=y
diff --git a/arch/powerpc/configs/pasemi_defconfig b/arch/powerpc/configs/pasemi_defconfig
index 5553c5ce4274..fe43ff47bd2f 100644
--- a/arch/powerpc/configs/pasemi_defconfig
+++ b/arch/powerpc/configs/pasemi_defconfig
@@ -142,7 +142,6 @@ CONFIG_USB_UHCI_HCD=y
 CONFIG_USB_SL811_HCD=y
 CONFIG_USB_STORAGE=y
 CONFIG_EDAC=y
-CONFIG_EDAC_MM_EDAC=y
 CONFIG_EDAC_PASEMI=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
diff --git a/arch/powerpc/configs/ppc64_defconfig b/arch/powerpc/configs/ppc64_defconfig
index 4f1288b04303..f2e03f032041 100644
--- a/arch/powerpc/configs/ppc64_defconfig
+++ b/arch/powerpc/configs/ppc64_defconfig
@@ -262,7 +262,6 @@ CONFIG_INFINIBAND_IPOIB_CM=y
 CONFIG_INFINIBAND_SRP=m
 CONFIG_INFINIBAND_ISER=m
 CONFIG_EDAC=y
-CONFIG_EDAC_MM_EDAC=y
 CONFIG_EDAC_PASEMI=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
index 11a3473f9e2e..6340e6c53c54 100644
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -173,7 +173,6 @@ CONFIG_INFINIBAND_MTHCA=m
 CONFIG_INFINIBAND_IPOIB=m
 CONFIG_INFINIBAND_ISER=m
 CONFIG_EDAC=y
-CONFIG_EDAC_MM_EDAC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_DS1307=y
 CONFIG_FS_DAX=y
diff --git a/arch/powerpc/configs/ppc6xx_defconfig b/arch/powerpc/configs/ppc6xx_defconfig
index 1d2d69dd6409..18d0d60dadbf 100644
--- a/arch/powerpc/configs/ppc6xx_defconfig
+++ b/arch/powerpc/configs/ppc6xx_defconfig
@@ -988,8 +988,7 @@ CONFIG_LEDS_TRIGGER_BACKLIGHT=m
 CONFIG_LEDS_TRIGGER_DEFAULT_ON=m
 CONFIG_ACCESSIBILITY=y
 CONFIG_A11Y_BRAILLE_CONSOLE=y
-CONFIG_EDAC=y
-CONFIG_EDAC_MM_EDAC=m
+CONFIG_EDAC=m
 CONFIG_RTC_CLASS=y
 # CONFIG_RTC_HCTOSYS is not set
 CONFIG_RTC_DRV_DS1307=m
diff --git a/arch/tile/configs/tilegx_defconfig b/arch/tile/configs/tilegx_defconfig
index fd122ef45b00..0d925fa0f0c1 100644
--- a/arch/tile/configs/tilegx_defconfig
+++ b/arch/tile/configs/tilegx_defconfig
@@ -249,7 +249,6 @@ CONFIG_USB_EHCI_HCD=y
 CONFIG_USB_OHCI_HCD=y
 CONFIG_USB_STORAGE=y
 CONFIG_EDAC=y
-CONFIG_EDAC_MM_EDAC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_TILE=y
 CONFIG_EXT2_FS=y
diff --git a/arch/tile/configs/tilepro_defconfig b/arch/tile/configs/tilepro_defconfig
index eb6a55944191..149d8e8eacb8 100644
--- a/arch/tile/configs/tilepro_defconfig
+++ b/arch/tile/configs/tilepro_defconfig
@@ -358,7 +358,6 @@ CONFIG_WATCHDOG_NOWAYOUT=y
 # CONFIG_VGA_ARB is not set
 # CONFIG_USB_SUPPORT is not set
 CONFIG_EDAC=y
-CONFIG_EDAC_MM_EDAC=y
 CONFIG_RTC_CLASS=y
 CONFIG_RTC_DRV_TILE=y
 CONFIG_EXT2_FS=y
diff --git a/drivers/acpi/Kconfig b/drivers/acpi/Kconfig
index a71874df3410..a20cfcbee694 100644
--- a/drivers/acpi/Kconfig
+++ b/drivers/acpi/Kconfig
@@ -471,7 +471,6 @@ config ACPI_EXTLOG
 	tristate "Extended Error Log support"
 	depends on X86_MCE && X86_LOCAL_APIC && EDAC
 	select UEFI_CPER
-	select RAS
 	default n
 	help
 	  Certain usages such as Predictive Failure Analysis (PFA) require
diff --git a/drivers/edac/Kconfig b/drivers/edac/Kconfig
index 7c68e6f955c7..1ac18c989fb3 100644
--- a/drivers/edac/Kconfig
+++ b/drivers/edac/Kconfig
@@ -10,8 +10,8 @@ config EDAC_SUPPORT
 	bool
 
 menuconfig EDAC
-	bool "EDAC (Error Detection And Correction) reporting"
-	depends on HAS_IOMEM && EDAC_SUPPORT
+	tristate "EDAC (Error Detection And Correction) reporting"
+	depends on HAS_IOMEM && EDAC_SUPPORT && RAS
 	help
 	  EDAC is designed to report errors in the core system.
 	  These are low-level errors that are reported in the CPU or
@@ -62,20 +62,9 @@ config EDAC_DECODE_MCE
 	  which occur really early upon boot, before the module infrastructure
 	  has been initialized.
 
-config EDAC_MM_EDAC
-	tristate "Main Memory EDAC (Error Detection And Correction) reporting"
-	select RAS
-	help
-	  Some systems are able to detect and correct errors in main
-	  memory.  EDAC can report statistics on memory error
-	  detection and correction (EDAC - or commonly referred to ECC
-	  errors).  EDAC will also try to decode where these errors
-	  occurred so that a particular failing memory module can be
-	  replaced.  If unsure, select 'Y'.
-
 config EDAC_GHES
 	bool "Output ACPI APEI/GHES BIOS detected errors via EDAC"
-	depends on ACPI_APEI_GHES && (EDAC_MM_EDAC=y)
+	depends on ACPI_APEI_GHES && (EDAC=y)
 	default y
 	help
 	  Not all machines support hardware-driven error report. Some of those
@@ -98,7 +87,7 @@ config EDAC_GHES
 
 config EDAC_AMD64
 	tristate "AMD64 (Opteron, Athlon64)"
-	depends on EDAC_MM_EDAC && AMD_NB && EDAC_DECODE_MCE
+	depends on AMD_NB && EDAC_DECODE_MCE
 	help
 	  Support for error detection and correction of DRAM ECC errors on
 	  the AMD64 families (>= K8) of memory controllers.
@@ -124,28 +113,28 @@ config EDAC_AMD64_ERROR_INJECTION
 
 config EDAC_AMD76X
 	tristate "AMD 76x (760, 762, 768)"
-	depends on EDAC_MM_EDAC && PCI && X86_32
+	depends on PCI && X86_32
 	help
 	  Support for error detection and correction on the AMD 76x
 	  series of chipsets used with the Athlon processor.
 
 config EDAC_E7XXX
 	tristate "Intel e7xxx (e7205, e7500, e7501, e7505)"
-	depends on EDAC_MM_EDAC && PCI && X86_32
+	depends on PCI && X86_32
 	help
 	  Support for error detection and correction on the Intel
 	  E7205, E7500, E7501 and E7505 server chipsets.
 
 config EDAC_E752X
 	tristate "Intel e752x (e7520, e7525, e7320) and 3100"
-	depends on EDAC_MM_EDAC && PCI && X86
+	depends on PCI && X86
 	help
 	  Support for error detection and correction on the Intel
 	  E7520, E7525, E7320 server chipsets.
 
 config EDAC_I82443BXGX
 	tristate "Intel 82443BX/GX (440BX/GX)"
-	depends on EDAC_MM_EDAC && PCI && X86_32
+	depends on PCI && X86_32
 	depends on BROKEN
 	help
 	  Support for error detection and correction on the Intel
@@ -153,56 +142,56 @@ config EDAC_I82443BXGX
 
 config EDAC_I82875P
 	tristate "Intel 82875p (D82875P, E7210)"
-	depends on EDAC_MM_EDAC && PCI && X86_32
+	depends on PCI && X86_32
 	help
 	  Support for error detection and correction on the Intel
 	  DP82785P and E7210 server chipsets.
 
 config EDAC_I82975X
 	tristate "Intel 82975x (D82975x)"
-	depends on EDAC_MM_EDAC && PCI && X86
+	depends on PCI && X86
 	help
 	  Support for error detection and correction on the Intel
 	  DP82975x server chipsets.
 
 config EDAC_I3000
 	tristate "Intel 3000/3010"
-	depends on EDAC_MM_EDAC && PCI && X86
+	depends on PCI && X86
 	help
 	  Support for error detection and correction on the Intel
 	  3000 and 3010 server chipsets.
 
 config EDAC_I3200
 	tristate "Intel 3200"
-	depends on EDAC_MM_EDAC && PCI && X86
+	depends on PCI && X86
 	help
 	  Support for error detection and correction on the Intel
 	  3200 and 3210 server chipsets.
 
 config EDAC_IE31200
 	tristate "Intel e312xx"
-	depends on EDAC_MM_EDAC && PCI && X86
+	depends on PCI && X86
 	help
 	  Support for error detection and correction on the Intel
 	  E3-1200 based DRAM controllers.
 
 config EDAC_X38
 	tristate "Intel X38"
-	depends on EDAC_MM_EDAC && PCI && X86
+	depends on PCI && X86
 	help
 	  Support for error detection and correction on the Intel
 	  X38 server chipsets.
 
 config EDAC_I5400
 	tristate "Intel 5400 (Seaburg) chipsets"
-	depends on EDAC_MM_EDAC && PCI && X86
+	depends on PCI && X86
 	help
 	  Support for error detection and correction the Intel
 	  i5400 MCH chipset (Seaburg).
 
 config EDAC_I7CORE
 	tristate "Intel i7 Core (Nehalem) processors"
-	depends on EDAC_MM_EDAC && PCI && X86 && X86_MCE_INTEL
+	depends on PCI && X86 && X86_MCE_INTEL
 	help
 	  Support for error detection and correction the Intel
 	  i7 Core (Nehalem) Integrated Memory Controller that exists on
@@ -211,58 +200,56 @@ config EDAC_I7CORE
 
 config EDAC_I82860
 	tristate "Intel 82860"
-	depends on EDAC_MM_EDAC && PCI && X86_32
+	depends on PCI && X86_32
 	help
 	  Support for error detection and correction on the Intel
 	  82860 chipset.
 
 config EDAC_R82600
 	tristate "Radisys 82600 embedded chipset"
-	depends on EDAC_MM_EDAC && PCI && X86_32
+	depends on PCI && X86_32
 	help
 	  Support for error detection and correction on the Radisys
 	  82600 embedded chipset.
 
 config EDAC_I5000
 	tristate "Intel Greencreek/Blackford chipset"
-	depends on EDAC_MM_EDAC && X86 && PCI
+	depends on X86 && PCI
 	help
 	  Support for error detection and correction the Intel
 	  Greekcreek/Blackford chipsets.
 
 config EDAC_I5100
 	tristate "Intel San Clemente MCH"
-	depends on EDAC_MM_EDAC && X86 && PCI
+	depends on X86 && PCI
 	help
 	  Support for error detection and correction the Intel
 	  San Clemente MCH.
 
 config EDAC_I7300
 	tristate "Intel Clarksboro MCH"
-	depends on EDAC_MM_EDAC && X86 && PCI
+	depends on X86 && PCI
 	help
 	  Support for error detection and correction the Intel
 	  Clarksboro MCH (Intel 7300 chipset).
 
 config EDAC_SBRIDGE
 	tristate "Intel Sandy-Bridge/Ivy-Bridge/Haswell Integrated MC"
-	depends on EDAC_MM_EDAC && PCI && X86_64 && X86_MCE_INTEL
-	depends on PCI_MMCONFIG
+	depends on PCI && X86_64 && X86_MCE_INTEL && PCI_MMCONFIG
 	help
 	  Support for error detection and correction the Intel
 	  Sandy Bridge, Ivy Bridge and Haswell Integrated Memory Controllers.
 
 config EDAC_SKX
 	tristate "Intel Skylake server Integrated MC"
-	depends on EDAC_MM_EDAC && PCI && X86_64 && X86_MCE_INTEL
-	depends on PCI_MMCONFIG
+	depends on PCI && X86_64 && X86_MCE_INTEL && PCI_MMCONFIG
 	help
 	  Support for error detection and correction the Intel
 	  Skylake server Integrated Memory Controllers.
 
 config EDAC_PND2
 	tristate "Intel Pondicherry2"
-	depends on EDAC_MM_EDAC && PCI && X86_64 && X86_MCE_INTEL
+	depends on PCI && X86_64 && X86_MCE_INTEL
 	help
 	  Support for error detection and correction on the Intel
 	  Pondicherry2 Integrated Memory Controller. This SoC IP is
@@ -271,36 +258,35 @@ config EDAC_PND2
 
 config EDAC_MPC85XX
 	tristate "Freescale MPC83xx / MPC85xx"
-	depends on EDAC_MM_EDAC && FSL_SOC
+	depends on FSL_SOC
 	help
 	  Support for error detection and correction on the Freescale
 	  MPC8349, MPC8560, MPC8540, MPC8548, T4240
 
 config EDAC_LAYERSCAPE
 	tristate "Freescale Layerscape DDR"
-	depends on EDAC_MM_EDAC && ARCH_LAYERSCAPE
+	depends on ARCH_LAYERSCAPE
 	help
 	  Support for error detection and correction on Freescale memory
 	  controllers on Layerscape SoCs.
 
 config EDAC_MV64X60
 	tristate "Marvell MV64x60"
-	depends on EDAC_MM_EDAC && MV64X60
+	depends on MV64X60
 	help
 	  Support for error detection and correction on the Marvell
 	  MV64360 and MV64460 chipsets.
 
 config EDAC_PASEMI
 	tristate "PA Semi PWRficient"
-	depends on EDAC_MM_EDAC && PCI
-	depends on PPC_PASEMI
+	depends on PPC_PASEMI && PCI
 	help
 	  Support for error detection and correction on PA Semi
 	  PWRficient.
 
 config EDAC_CELL
 	tristate "Cell Broadband Engine memory controller"
-	depends on EDAC_MM_EDAC && PPC_CELL_COMMON
+	depends on PPC_CELL_COMMON
 	help
 	  Support for error detection and correction on the
 	  Cell Broadband Engine internal memory controller
@@ -308,7 +294,7 @@ config EDAC_CELL
 
 config EDAC_PPC4XX
 	tristate "PPC4xx IBM DDR2 Memory Controller"
-	depends on EDAC_MM_EDAC && 4xx
+	depends on 4xx
 	help
 	  This enables support for EDAC on the ECC memory used
 	  with the IBM DDR2 memory controller found in various
@@ -317,7 +303,7 @@ config EDAC_PPC4XX
 
 config EDAC_AMD8131
 	tristate "AMD8131 HyperTransport PCI-X Tunnel"
-	depends on EDAC_MM_EDAC && PCI && PPC_MAPLE
+	depends on PCI && PPC_MAPLE
 	help
 	  Support for error detection and correction on the
 	  AMD8131 HyperTransport PCI-X Tunnel chip.
@@ -326,7 +312,7 @@ config EDAC_AMD8131
 
 config EDAC_AMD8111
 	tristate "AMD8111 HyperTransport I/O Hub"
-	depends on EDAC_MM_EDAC && PCI && PPC_MAPLE
+	depends on PCI && PPC_MAPLE
 	help
 	  Support for error detection and correction on the
 	  AMD8111 HyperTransport I/O Hub chip.
@@ -335,7 +321,7 @@ config EDAC_AMD8111
 
 config EDAC_CPC925
 	tristate "IBM CPC925 Memory Controller (PPC970FX)"
-	depends on EDAC_MM_EDAC && PPC64
+	depends on PPC64
 	help
 	  Support for error detection and correction on the
 	  IBM CPC925 Bridge and Memory Controller, which is
@@ -344,7 +330,7 @@ config EDAC_CPC925
 
 config EDAC_TILE
 	tristate "Tilera Memory Controller"
-	depends on EDAC_MM_EDAC && TILE
+	depends on TILE
 	default y
 	help
 	  Support for error detection and correction on the
@@ -352,49 +338,48 @@ config EDAC_TILE
 
 config EDAC_HIGHBANK_MC
 	tristate "Highbank Memory Controller"
-	depends on EDAC_MM_EDAC && ARCH_HIGHBANK
+	depends on ARCH_HIGHBANK
 	help
 	  Support for error detection and correction on the
 	  Calxeda Highbank memory controller.
 
 config EDAC_HIGHBANK_L2
 	tristate "Highbank L2 Cache"
-	depends on EDAC_MM_EDAC && ARCH_HIGHBANK
+	depends on ARCH_HIGHBANK
 	help
 	  Support for error detection and correction on the
 	  Calxeda Highbank memory controller.
 
 config EDAC_OCTEON_PC
 	tristate "Cavium Octeon Primary Caches"
-	depends on EDAC_MM_EDAC && CPU_CAVIUM_OCTEON
+	depends on CPU_CAVIUM_OCTEON
 	help
 	  Support for error detection and correction on the primary caches of
 	  the cnMIPS cores of Cavium Octeon family SOCs.
 
 config EDAC_OCTEON_L2C
 	tristate "Cavium Octeon Secondary Caches (L2C)"
-	depends on EDAC_MM_EDAC && CAVIUM_OCTEON_SOC
+	depends on CAVIUM_OCTEON_SOC
 	help
 	  Support for error detection and correction on the
 	  Cavium Octeon family of SOCs.
 
 config EDAC_OCTEON_LMC
 	tristate "Cavium Octeon DRAM Memory Controller (LMC)"
-	depends on EDAC_MM_EDAC && CAVIUM_OCTEON_SOC
+	depends on CAVIUM_OCTEON_SOC
 	help
 	  Support for error detection and correction on the
 	  Cavium Octeon family of SOCs.
 
 config EDAC_OCTEON_PCI
 	tristate "Cavium Octeon PCI Controller"
-	depends on EDAC_MM_EDAC && PCI && CAVIUM_OCTEON_SOC
+	depends on PCI && CAVIUM_OCTEON_SOC
 	help
 	  Support for error detection and correction on the
 	  Cavium Octeon family of SOCs.
 
 config EDAC_THUNDERX
 	tristate "Cavium ThunderX EDAC"
-	depends on EDAC_MM_EDAC
 	depends on ARM64
 	depends on PCI
 	help
@@ -405,7 +390,7 @@ config EDAC_THUNDERX
 
 config EDAC_ALTERA
 	bool "Altera SOCFPGA ECC"
-	depends on EDAC_MM_EDAC=y && ARCH_SOCFPGA
+	depends on EDAC=y && ARCH_SOCFPGA
 	help
 	  Support for error detection and correction on the
 	  Altera SOCs. This must be selected for SDRAM ECC.
@@ -471,14 +456,14 @@ config EDAC_ALTERA_SDMMC
 
 config EDAC_SYNOPSYS
 	tristate "Synopsys DDR Memory Controller"
-	depends on EDAC_MM_EDAC && ARCH_ZYNQ
+	depends on ARCH_ZYNQ
 	help
 	  Support for error detection and correction on the Synopsys DDR
 	  memory controller.
 
 config EDAC_XGENE
 	tristate "APM X-Gene SoC"
-	depends on EDAC_MM_EDAC && (ARM64 || COMPILE_TEST)
+	depends on (ARM64 || COMPILE_TEST)
 	help
 	  Support for error detection and correction on the
 	  APM X-Gene family of SOCs.
diff --git a/drivers/edac/Makefile b/drivers/edac/Makefile
index 76517ebc0a7f..a8fb734cb28d 100644
--- a/drivers/edac/Makefile
+++ b/drivers/edac/Makefile
@@ -6,8 +6,7 @@
 # GNU General Public License.
 #
 
-obj-$(CONFIG_EDAC)			:= edac_stub.o
-obj-$(CONFIG_EDAC_MM_EDAC)		+= edac_core.o
+obj-$(CONFIG_EDAC)			:= edac_stub.o edac_core.o
 
 edac_core-y	:= edac_mc.o edac_device.o edac_mc_sysfs.o
 edac_core-y	+= edac_module.o edac_device_sysfs.o wq.o
diff --git a/drivers/edac/edac_stub.c b/drivers/edac/edac_stub.c
index aa31cbd17cd2..6aacc569401e 100644
--- a/drivers/edac/edac_stub.c
+++ b/drivers/edac/edac_stub.c
@@ -20,7 +20,7 @@
 int edac_report_status = EDAC_REPORTING_ENABLED;
 EXPORT_SYMBOL_GPL(edac_report_status);
 
-static int __init edac_report_setup(char *str)
+static int __init __maybe_unused edac_report_setup(char *str)
 {
 	if (!str)
 		return -EINVAL;
-- 
2.11.0
