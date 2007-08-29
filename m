Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.188]) by ozlabs.org (Postfix) with ESMTP id D8161DDE11
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 09:21:27 +1000 (EST)
Message-Id: <20070829231843.261962649@arndb.de>
References: <20070829231122.406817286@arndb.de>
Date: Thu, 30 Aug 2007 01:11:24 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [patch 2/4] move embedded6xx into multiplatform
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The various embedded 6xx systems can easily coexist
in one kernel together with the other 6xx based systems,
so there is no strict reason to keep them separate.

This also fixes a problem introduced in one earlier
patch, where the embedded 74xx based systems could
not automatically select altivec any more.

Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

Index: linux-2.6/arch/powerpc/platforms/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/Kconfig
+++ linux-2.6/arch/powerpc/platforms/Kconfig
@@ -12,10 +12,6 @@ config PPC_MULTIPLATFORM
 	  RS/6000 machine, an Apple machine, or a PReP, CHRP,
 	  Maple or Cell-based machine.
 
-config EMBEDDED6xx
-	bool "Embedded 6xx/7xx/7xxx-based board"
-	depends on PPC32 && (BROKEN||BROKEN_ON_SMP)
-
 config PPC_82xx
 	bool "Freescale 82xx"
 	depends on 6xx
Index: linux-2.6/arch/powerpc/platforms/embedded6xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/embedded6xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -1,9 +1,10 @@
-choice
-	prompt "Machine Type"
-	depends on EMBEDDED6xx
+config EMBEDDED6xx
+	bool "Embedded 6xx/7xx/7xxx-based boards"
+	depends on PPC32 && BROKEN_ON_SMP && PPC_MULTIPLATFORM
 
 config LINKSTATION
 	bool "Linkstation / Kurobox(HG) from Buffalo"
+	depends on EMBEDDED6xx
 	select MPIC
 	select FSL_SOC
 	select PPC_UDBG_16550 if SERIAL_8250
@@ -18,6 +19,7 @@ config LINKSTATION
 
 config MPC7448HPC2
 	bool "Freescale MPC7448HPC2(Taiga)"
+	depends on EMBEDDED6xx
 	select TSI108_BRIDGE
 	select DEFAULT_UIMAGE
 	select PPC_UDBG_16550
@@ -28,6 +30,7 @@ config MPC7448HPC2
 
 config PPC_HOLLY
 	bool "PPC750GX/CL with TSI10x bridge (Hickory/Holly)"
+	depends on EMBEDDED6xx
 	select TSI108_BRIDGE
 	select PPC_UDBG_16550
 	select WANT_DEVICE_TREE
@@ -38,13 +41,13 @@ config PPC_HOLLY
 
 config PPC_PRPMC2800
 	bool "Motorola-PrPMC2800"
+	depends on EMBEDDED6xx
 	select MV64X60
 	select NOT_COHERENT_CACHE
 	select WANT_DEVICE_TREE
 	select CPU_7450
 	help
 	  This option enables support for the Motorola PrPMC2800 board
-endchoice
 
 config TSI108_BRIDGE
 	bool
Index: linux-2.6/arch/powerpc/configs/holly_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/holly_defconfig
+++ linux-2.6/arch/powerpc/configs/holly_defconfig
@@ -4,6 +4,30 @@
 # Tue Jun 26 13:22:36 2007
 #
 # CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+CONFIG_6xx=y
+# CONFIG_PPC_85xx is not set
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+# CONFIG_PPC_CPU_SELECTION is not set
+# CONFIG_CPU_601 is not set
+# CONFIG_CPU_603e is not set
+CONFIG_CPU_750=y
+# CONFIG_CPU_7400 is not set
+# CONFIG_CPU_7450 is not set
+CONFIG_PPC_MCPU="-mcpu=750"
+CONFIG_PPC_FPU=y
+CONFIG_ALTIVEC=y
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_PPC_MM_SLICES is not set
+# CONFIG_SMP is not set
+# CONFIG_PPC64 is not set
 CONFIG_PPC32=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
@@ -25,28 +49,8 @@ CONFIG_PPC_UDBG_16550=y
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
 # CONFIG_DEFAULT_UIMAGE is not set
-
-#
-# Processor support
-#
-CONFIG_CLASSIC32=y
-# CONFIG_PPC_82xx is not set
-# CONFIG_PPC_83xx is not set
-# CONFIG_PPC_85xx is not set
-# CONFIG_PPC_86xx is not set
-# CONFIG_PPC_8xx is not set
-# CONFIG_40x is not set
-# CONFIG_44x is not set
-# CONFIG_E200 is not set
-CONFIG_6xx=y
-CONFIG_PPC_FPU=y
 # CONFIG_PPC_DCR_NATIVE is not set
 # CONFIG_PPC_DCR_MMIO is not set
-# CONFIG_ALTIVEC is not set
-CONFIG_PPC_STD_MMU=y
-CONFIG_PPC_STD_MMU_32=y
-# CONFIG_PPC_MM_SLICES is not set
-# CONFIG_SMP is not set
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -136,14 +140,21 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 # Platform support
 #
-# CONFIG_PPC_MULTIPLATFORM is not set
-CONFIG_EMBEDDED6xx=y
-# CONFIG_APUS is not set
+CONFIG_PPC_MULTIPLATFORM=y
+# CONFIG_PPC_82xx is not set
+# CONFIG_PPC_83xx is not set
+# CONFIG_PPC_86xx is not set
+CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
 # CONFIG_PPC_MPC52xx is not set
 # CONFIG_PPC_MPC5200 is not set
+# CONFIG_PPC_EFIKA is not set
+# CONFIG_PPC_LITE5200 is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PQ2ADS is not set
+CONFIG_EMBEDDED6xx=y
 # CONFIG_LINKSTATION is not set
 # CONFIG_MPC7448HPC2 is not set
 CONFIG_PPC_HOLLY=y
@@ -177,6 +188,7 @@ CONFIG_PREEMPT_NONE=y
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+# CONFIG_KEXEC is not set
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
@@ -590,6 +602,7 @@ CONFIG_NETDEV_1000=y
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
 CONFIG_TSI108_ETH=y
+# CONFIG_MV643XX_ETH is not set
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
 CONFIG_NETDEV_10000=y
Index: linux-2.6/arch/powerpc/configs/linkstation_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/linkstation_defconfig
+++ linux-2.6/arch/powerpc/configs/linkstation_defconfig
@@ -1,9 +1,32 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.22-rc6
-# Tue Jun 26 13:25:19 2007
+# Linux kernel version: 2.6.22-rc7
+# Fri Jul 13 20:05:40 2007
 #
 # CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+CONFIG_6xx=y
+# CONFIG_PPC_85xx is not set
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+# CONFIG_PPC_CPU_SELECTION is not set
+# CONFIG_CPU_601 is not set
+CONFIG_CPU_603e=y
+# CONFIG_CPU_750 is not set
+# CONFIG_CPU_7400 is not set
+# CONFIG_CPU_7450 is not set
+CONFIG_PPC_MCPU="-mcpu=603e"
+CONFIG_PPC_FPU=y
+CONFIG_ALTIVEC=y
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_PPC_MM_SLICES is not set
+# CONFIG_SMP is not set
 CONFIG_PPC32=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
@@ -25,28 +48,8 @@ CONFIG_PPC_UDBG_16550=y
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
 CONFIG_DEFAULT_UIMAGE=y
-
-#
-# Processor support
-#
-CONFIG_CLASSIC32=y
-# CONFIG_PPC_82xx is not set
-# CONFIG_PPC_83xx is not set
-# CONFIG_PPC_85xx is not set
-# CONFIG_PPC_86xx is not set
-# CONFIG_PPC_8xx is not set
-# CONFIG_40x is not set
-# CONFIG_44x is not set
-# CONFIG_E200 is not set
-CONFIG_6xx=y
-CONFIG_PPC_FPU=y
 # CONFIG_PPC_DCR_NATIVE is not set
 # CONFIG_PPC_DCR_MMIO is not set
-# CONFIG_ALTIVEC is not set
-CONFIG_PPC_STD_MMU=y
-CONFIG_PPC_STD_MMU_32=y
-# CONFIG_PPC_MM_SLICES is not set
-# CONFIG_SMP is not set
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -138,14 +141,21 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 # Platform support
 #
-# CONFIG_PPC_MULTIPLATFORM is not set
-CONFIG_EMBEDDED6xx=y
-# CONFIG_APUS is not set
+CONFIG_PPC_MULTIPLATFORM=y
+# CONFIG_PPC_82xx is not set
+# CONFIG_PPC_83xx is not set
+# CONFIG_PPC_86xx is not set
+CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
 # CONFIG_PPC_MPC52xx is not set
 # CONFIG_PPC_MPC5200 is not set
+# CONFIG_PPC_EFIKA is not set
+# CONFIG_PPC_LITE5200 is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PQ2ADS is not set
+CONFIG_EMBEDDED6xx=y
 CONFIG_LINKSTATION=y
 # CONFIG_MPC7448HPC2 is not set
 # CONFIG_PPC_HOLLY is not set
@@ -181,6 +191,7 @@ CONFIG_PREEMPT_NONE=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+# CONFIG_KEXEC is not set
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
@@ -774,6 +785,7 @@ CONFIG_R8169=y
 # CONFIG_VIA_VELOCITY is not set
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
+# CONFIG_MV643XX_ETH is not set
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
 CONFIG_NETDEV_10000=y
Index: linux-2.6/arch/powerpc/configs/mpc7448_hpc2_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/mpc7448_hpc2_defconfig
+++ linux-2.6/arch/powerpc/configs/mpc7448_hpc2_defconfig
@@ -1,9 +1,32 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.22-rc7
-# Sun Jul  1 23:56:54 2007
+# Fri Jul 13 20:05:41 2007
 #
 # CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+CONFIG_6xx=y
+# CONFIG_PPC_85xx is not set
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+# CONFIG_PPC_CPU_SELECTION is not set
+# CONFIG_CPU_601 is not set
+# CONFIG_CPU_603e is not set
+# CONFIG_CPU_750 is not set
+# CONFIG_CPU_7400 is not set
+CONFIG_CPU_7450=y
+CONFIG_PPC_MCPU="-mcpu=7450"
+CONFIG_PPC_FPU=y
+CONFIG_ALTIVEC=y
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_PPC_MM_SLICES is not set
+# CONFIG_SMP is not set
 CONFIG_PPC32=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
@@ -25,28 +48,8 @@ CONFIG_PPC_UDBG_16550=y
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
 CONFIG_DEFAULT_UIMAGE=y
-
-#
-# Processor support
-#
-CONFIG_CLASSIC32=y
-# CONFIG_PPC_82xx is not set
-# CONFIG_PPC_83xx is not set
-# CONFIG_PPC_85xx is not set
-# CONFIG_PPC_86xx is not set
-# CONFIG_PPC_8xx is not set
-# CONFIG_40x is not set
-# CONFIG_44x is not set
-# CONFIG_E200 is not set
-CONFIG_6xx=y
-CONFIG_PPC_FPU=y
 # CONFIG_PPC_DCR_NATIVE is not set
 # CONFIG_PPC_DCR_MMIO is not set
-# CONFIG_ALTIVEC is not set
-CONFIG_PPC_STD_MMU=y
-CONFIG_PPC_STD_MMU_32=y
-# CONFIG_PPC_MM_SLICES is not set
-# CONFIG_SMP is not set
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -131,14 +134,21 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 # Platform support
 #
-# CONFIG_PPC_MULTIPLATFORM is not set
-CONFIG_EMBEDDED6xx=y
-# CONFIG_APUS is not set
+CONFIG_PPC_MULTIPLATFORM=y
+# CONFIG_PPC_82xx is not set
+# CONFIG_PPC_83xx is not set
+# CONFIG_PPC_86xx is not set
+CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
 # CONFIG_PPC_MPC52xx is not set
 # CONFIG_PPC_MPC5200 is not set
+# CONFIG_PPC_EFIKA is not set
+# CONFIG_PPC_LITE5200 is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PQ2ADS is not set
+CONFIG_EMBEDDED6xx=y
 # CONFIG_LINKSTATION is not set
 CONFIG_MPC7448HPC2=y
 # CONFIG_PPC_HOLLY is not set
@@ -172,6 +182,7 @@ CONFIG_PREEMPT_NONE=y
 CONFIG_BINFMT_ELF=y
 CONFIG_BINFMT_MISC=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+# CONFIG_KEXEC is not set
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
@@ -600,6 +611,7 @@ CONFIG_NETDEV_1000=y
 # CONFIG_TIGON3 is not set
 # CONFIG_BNX2 is not set
 CONFIG_TSI108_ETH=y
+# CONFIG_MV643XX_ETH is not set
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
 CONFIG_NETDEV_10000=y
Index: linux-2.6/arch/powerpc/configs/prpmc2800_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/prpmc2800_defconfig
+++ linux-2.6/arch/powerpc/configs/prpmc2800_defconfig
@@ -1,9 +1,34 @@
 #
 # Automatically generated make config: don't edit
-# Linux kernel version: 2.6.22-rc6
-# Tue Jun 26 14:15:11 2007
+# Linux kernel version: 2.6.22-rc7
+# Fri Jul 13 20:05:42 2007
 #
 # CONFIG_PPC64 is not set
+
+#
+# Processor support
+#
+CONFIG_6xx=y
+# CONFIG_PPC_85xx is not set
+# CONFIG_PPC_8xx is not set
+# CONFIG_40x is not set
+# CONFIG_44x is not set
+# CONFIG_E200 is not set
+# CONFIG_PPC_CPU_SELECTION is not set
+# CONFIG_CPU_601 is not set
+# CONFIG_CPU_603e is not set
+# CONFIG_CPU_750 is not set
+# CONFIG_CPU_7400 is not set
+CONFIG_CPU_7450=y
+CONFIG_PPC_MCPU="-mcpu=7450"
+CONFIG_PPC_FPU=y
+CONFIG_ALTIVEC=y
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_PPC_MM_SLICES is not set
+# CONFIG_SMP is not set
+CONFIG_NOT_COHERENT_CACHE=y
+CONFIG_CONFIG_CHECK_CACHE_COHERENCY=y
 CONFIG_PPC32=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
@@ -25,30 +50,8 @@ CONFIG_PPC_OF=y
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
 # CONFIG_DEFAULT_UIMAGE is not set
-
-#
-# Processor support
-#
-CONFIG_CLASSIC32=y
-# CONFIG_PPC_82xx is not set
-# CONFIG_PPC_83xx is not set
-# CONFIG_PPC_85xx is not set
-# CONFIG_PPC_86xx is not set
-# CONFIG_PPC_8xx is not set
-# CONFIG_40x is not set
-# CONFIG_44x is not set
-# CONFIG_E200 is not set
-CONFIG_6xx=y
-CONFIG_PPC_FPU=y
 # CONFIG_PPC_DCR_NATIVE is not set
 # CONFIG_PPC_DCR_MMIO is not set
-CONFIG_ALTIVEC=y
-CONFIG_PPC_STD_MMU=y
-CONFIG_PPC_STD_MMU_32=y
-# CONFIG_PPC_MM_SLICES is not set
-# CONFIG_SMP is not set
-CONFIG_NOT_COHERENT_CACHE=y
-CONFIG_CHECK_CACHE_COHERENCY=y
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -133,14 +136,21 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 # Platform support
 #
-# CONFIG_PPC_MULTIPLATFORM is not set
-CONFIG_EMBEDDED6xx=y
-# CONFIG_APUS is not set
+CONFIG_PPC_MULTIPLATFORM=y
+# CONFIG_PPC_82xx is not set
+# CONFIG_PPC_83xx is not set
+# CONFIG_PPC_86xx is not set
+CONFIG_CLASSIC32=y
+# CONFIG_PPC_CHRP is not set
 # CONFIG_PPC_MPC52xx is not set
 # CONFIG_PPC_MPC5200 is not set
+# CONFIG_PPC_EFIKA is not set
+# CONFIG_PPC_LITE5200 is not set
+# CONFIG_PPC_PMAC is not set
 # CONFIG_PPC_CELL is not set
 # CONFIG_PPC_CELL_NATIVE is not set
 # CONFIG_PQ2ADS is not set
+CONFIG_EMBEDDED6xx=y
 # CONFIG_LINKSTATION is not set
 # CONFIG_MPC7448HPC2 is not set
 # CONFIG_PPC_HOLLY is not set

-- 
