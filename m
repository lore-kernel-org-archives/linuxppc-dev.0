Return-Path: <haokexin@gmail.com>
Received: from mail-pa0-x22d.google.com (mail-pa0-x22d.google.com
 [IPv6:2607:f8b0:400e:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 478D12C0266
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Sep 2013 13:06:11 +1000 (EST)
Received: by mail-pa0-f45.google.com with SMTP id rd3so3092385pab.18
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Sep 2013 20:06:08 -0700 (PDT)
From: Kevin Hao <haokexin@gmail.com>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v3 3/3] powerpc/85xx: use one kernel option for all the
 CoreNet_Generic boards
Date: Tue, 24 Sep 2013 11:03:17 +0800
Message-Id: <1379991797-29222-4-git-send-email-haokexin@gmail.com>
In-Reply-To: <1379991797-29222-1-git-send-email-haokexin@gmail.com>
References: <1379991797-29222-1-git-send-email-haokexin@gmail.com>
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently all these boards use the same machine struct and also select
the same kernel options, so it seems a bit of redundant to keep one
separate kernel option for each board. Also update the defconfigs
according to this change.

Signed-off-by: Kevin Hao <haokexin@gmail.com>
---
A new patch in v3.

 arch/powerpc/configs/corenet32_smp_defconfig |  6 +-
 arch/powerpc/configs/corenet64_smp_defconfig |  5 +-
 arch/powerpc/configs/ppc64e_defconfig        |  2 +-
 arch/powerpc/platforms/85xx/Kconfig          | 97 +++-------------------------
 4 files changed, 12 insertions(+), 98 deletions(-)

diff --git a/arch/powerpc/configs/corenet32_smp_defconfig b/arch/powerpc/configs/corenet32_smp_defconfig
index 3dfab4c..1d9cb29 100644
--- a/arch/powerpc/configs/corenet32_smp_defconfig
+++ b/arch/powerpc/configs/corenet32_smp_defconfig
@@ -23,11 +23,7 @@ CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAC_PARTITION=y
-CONFIG_P2041_RDB=y
-CONFIG_P3041_DS=y
-CONFIG_P4080_DS=y
-CONFIG_P5020_DS=y
-CONFIG_P5040_DS=y
+CONFIG_CORENET_GENERIC=y
 CONFIG_HIGHMEM=y
 # CONFIG_CORE_DUMP_DEFAULT_ELF_HEADERS is not set
 CONFIG_BINFMT_MISC=m
diff --git a/arch/powerpc/configs/corenet64_smp_defconfig b/arch/powerpc/configs/corenet64_smp_defconfig
index fa94fb3..63508dd 100644
--- a/arch/powerpc/configs/corenet64_smp_defconfig
+++ b/arch/powerpc/configs/corenet64_smp_defconfig
@@ -21,10 +21,7 @@ CONFIG_MODVERSIONS=y
 # CONFIG_BLK_DEV_BSG is not set
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAC_PARTITION=y
-CONFIG_B4_QDS=y
-CONFIG_P5020_DS=y
-CONFIG_P5040_DS=y
-CONFIG_T4240_QDS=y
+CONFIG_CORENET_GENERIC=y
 # CONFIG_PPC_OF_BOOT_TRAMPOLINE is not set
 CONFIG_BINFMT_MISC=m
 CONFIG_MATH_EMULATION=y
diff --git a/arch/powerpc/configs/ppc64e_defconfig b/arch/powerpc/configs/ppc64e_defconfig
index 0085dc4..0a6be6d 100644
--- a/arch/powerpc/configs/ppc64e_defconfig
+++ b/arch/powerpc/configs/ppc64e_defconfig
@@ -23,7 +23,7 @@ CONFIG_MODULE_SRCVERSION_ALL=y
 CONFIG_PARTITION_ADVANCED=y
 CONFIG_MAC_PARTITION=y
 CONFIG_EFI_PARTITION=y
-CONFIG_P5020_DS=y
+CONFIG_CORENET_GENERIC=y
 CONFIG_CPU_FREQ=y
 CONFIG_CPU_FREQ_GOV_POWERSAVE=y
 CONFIG_CPU_FREQ_GOV_USERSPACE=y
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 3bee943..04456fb 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -218,36 +218,8 @@ config GE_IMP3A
 	  This board is a 3U CompactPCI Single Board Computer with a Freescale
 	  P2020 processor.
 
-config P2041_RDB
-	bool "Freescale P2041 RDB"
-	select DEFAULT_UIMAGE
-	select PPC_E500MC
-	select PHYS_64BIT
-	select SWIOTLB
-	select ARCH_REQUIRE_GPIOLIB
-	select GPIO_MPC8XXX
-	select HAS_RAPIDIO
-	select PPC_EPAPR_HV_PIC
-	select CORENET_GENERIC
-	help
-	  This option enables support for the P2041 RDB board
-
-config P3041_DS
-	bool "Freescale P3041 DS"
-	select DEFAULT_UIMAGE
-	select PPC_E500MC
-	select PHYS_64BIT
-	select SWIOTLB
-	select ARCH_REQUIRE_GPIOLIB
-	select GPIO_MPC8XXX
-	select HAS_RAPIDIO
-	select PPC_EPAPR_HV_PIC
-	select CORENET_GENERIC
-	help
-	  This option enables support for the P3041 DS board
-
-config P4080_DS
-	bool "Freescale P4080 DS"
+config CORENET_GENERIC
+	bool "Freescale CoreNet Generic"
 	select DEFAULT_UIMAGE
 	select PPC_E500MC
 	select PHYS_64BIT
@@ -256,50 +228,20 @@ config P4080_DS
 	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
-	select CORENET_GENERIC
 	help
-	  This option enables support for the P4080 DS board
+	  This option enables support for the P2041 RDB, P3041 DS, P4080 DS, P5020 DS
+	  and P5040 DS boards
 
 config SGY_CTS1000
 	tristate "Servergy CTS-1000 support"
 	select GPIOLIB
 	select OF_GPIO
-	depends on P4080_DS
+	depends on CORENET_GENERIC
 	help
 	  Enable this to support functionality in Servergy's CTS-1000 systems.
 
 endif # PPC32
 
-config P5020_DS
-	bool "Freescale P5020 DS"
-	select DEFAULT_UIMAGE
-	select E500
-	select PPC_E500MC
-	select PHYS_64BIT
-	select SWIOTLB
-	select ARCH_REQUIRE_GPIOLIB
-	select GPIO_MPC8XXX
-	select HAS_RAPIDIO
-	select PPC_EPAPR_HV_PIC
-	select CORENET_GENERIC
-	help
-	  This option enables support for the P5020 DS board
-
-config P5040_DS
-	bool "Freescale P5040 DS"
-	select DEFAULT_UIMAGE
-	select E500
-	select PPC_E500MC
-	select PHYS_64BIT
-	select SWIOTLB
-	select ARCH_REQUIRE_GPIOLIB
-	select GPIO_MPC8XXX
-	select HAS_RAPIDIO
-	select PPC_EPAPR_HV_PIC
-	select CORENET_GENERIC
-	help
-	  This option enables support for the P5040 DS board
-
 config PPC_QEMU_E500
 	bool "QEMU generic e500 platform"
 	select DEFAULT_UIMAGE
@@ -317,8 +259,8 @@ config PPC_QEMU_E500
 
 if PPC64
 
-config T4240_QDS
-	bool "Freescale T4240 QDS"
+config CORENET_GENERIC
+	bool "Freescale CoreNet Generic"
 	select DEFAULT_UIMAGE
 	select E500
 	select PPC_E500MC
@@ -328,33 +270,12 @@ config T4240_QDS
 	select GPIO_MPC8XXX
 	select HAS_RAPIDIO
 	select PPC_EPAPR_HV_PIC
-	select CORENET_GENERIC
 	help
-	  This option enables support for the T4240 QDS board
-
-config B4_QDS
-	bool "Freescale B4 QDS"
-	select DEFAULT_UIMAGE
-	select E500
-	select PPC_E500MC
-	select PHYS_64BIT
-	select SWIOTLB
-	select GPIOLIB
-	select ARCH_REQUIRE_GPIOLIB
-	select HAS_RAPIDIO
-	select PPC_EPAPR_HV_PIC
-	select CORENET_GENERIC
-	help
-	  This option enables support for the B4 QDS board
-	  The B4 application development system B4 QDS is a complete
-	  debugging environment intended for engineers developing
-	  applications for the B4.
+	  This option enables support for the P5020 DS, P5040 DS, T4240 QDS
+	  and B4 QDS boards
 
 endif
 endif # FSL_SOC_BOOKE
 
 config TQM85xx
 	bool
-
-config CORENET_GENERIC
-	bool
-- 
1.8.3.1
