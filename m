Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.174]) by ozlabs.org (Postfix) with ESMTP id F2C65DDE1E
	for <linuxppc-dev@ozlabs.org>; Thu, 30 Aug 2007 09:21:29 +1000 (EST)
Message-Id: <20070829231843.608966668@arndb.de>
References: <20070829231122.406817286@arndb.de>
Date: Thu, 30 Aug 2007 01:11:26 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [patch 4/4] move 83xx into multiplatform
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

MPC83xx based machines don't need their own kernel,
but can run one that is shared with the other 6xx
compatible machines, so we should allow that
in Kconfig.

Cc: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
Index: linux-2.6/arch/powerpc/platforms/83xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/83xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/83xx/Kconfig
@@ -1,10 +1,13 @@
-choice
-	prompt "83xx Board Type"
-	depends on PPC_83xx
-	default MPC834x_MDS
+config PPC_83xx
+	bool "Freescale 83xx based boards"
+	depends on 6xx
+	select FSL_SOC
+	select 83xx
+	select WANT_DEVICE_TREE
 
 config MPC8313_RDB
 	bool "Freescale MPC8313 RDB"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	select CPU_603e
 	help
@@ -12,6 +15,7 @@ config MPC8313_RDB
 
 config MPC832x_MDS
 	bool "Freescale MPC832x MDS"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	select QUICC_ENGINE
 	select CPU_603e
@@ -20,6 +24,7 @@ config MPC832x_MDS
 
 config MPC832x_RDB
 	bool "Freescale MPC832x RDB"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	select QUICC_ENGINE
 	select CPU_603e
@@ -28,6 +33,7 @@ config MPC832x_RDB
 
 config MPC834x_MDS
 	bool "Freescale MPC834x MDS"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	select CPU_603e
 	help
@@ -40,6 +46,7 @@ config MPC834x_MDS
 
 config MPC834x_ITX
 	bool "Freescale MPC834x ITX"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	select CPU_603e
 	help
@@ -50,14 +57,13 @@ config MPC834x_ITX
 
 config MPC836x_MDS
 	bool "Freescale MPC836x MDS"
+	depends on PPC_83xx
 	select DEFAULT_UIMAGE
 	select QUICC_ENGINE
 	select CPU_603e
 	help
 	  This option enables support for the MPC836x MDS Processor Board.
 
-endchoice
-
 config PPC_MPC831x
 	bool
 	select PPC_UDBG_16550
Index: linux-2.6/arch/powerpc/platforms/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/Kconfig
+++ linux-2.6/arch/powerpc/platforms/Kconfig
@@ -17,13 +17,6 @@ config PPC_82xx
 	depends on 6xx
 	select WANT_DEVICE_TREE
 
-config PPC_83xx
-	bool "Freescale 83xx"
-	depends on 6xx
-	select FSL_SOC
-	select 83xx
-	select WANT_DEVICE_TREE
-
 endchoice
 
 config CLASSIC32
Index: linux-2.6/arch/powerpc/configs/mpc8313_rdb_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/mpc8313_rdb_defconfig
+++ linux-2.6/arch/powerpc/configs/mpc8313_rdb_defconfig
@@ -1,9 +1,33 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.22-rc7
-# Sun Jul  1 23:56:55 2007
+# Fri Jul 13 20:00:52 2007
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
+CONFIG_83xx=y
+CONFIG_PPC_FPU=y
+CONFIG_ALTIVEC=y
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_PPC_MM_SLICES is not set
+# CONFIG_SMP is not set
 CONFIG_PPC32=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
@@ -25,28 +49,8 @@ CONFIG_PPC_UDBG_16550=y
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
 CONFIG_DEFAULT_UIMAGE=y
-
-#
-# Processor support
-#
-# CONFIG_CLASSIC32 is not set
-# CONFIG_PPC_82xx is not set
-CONFIG_PPC_83xx=y
-# CONFIG_PPC_85xx is not set
-# CONFIG_PPC_86xx is not set
-# CONFIG_PPC_8xx is not set
-# CONFIG_40x is not set
-# CONFIG_44x is not set
-# CONFIG_E200 is not set
-CONFIG_6xx=y
-CONFIG_83xx=y
-CONFIG_PPC_FPU=y
 # CONFIG_PPC_DCR_NATIVE is not set
 # CONFIG_PPC_DCR_MMIO is not set
-CONFIG_PPC_STD_MMU=y
-CONFIG_PPC_STD_MMU_32=y
-# CONFIG_PPC_MM_SLICES is not set
-# CONFIG_SMP is not set
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -135,11 +139,19 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 # Platform support
 #
+CONFIG_PPC_MULTIPLATFORM=y
+# CONFIG_PPC_82xx is not set
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
+CONFIG_PPC_83xx=y
 CONFIG_MPC8313_RDB=y
 # CONFIG_MPC832x_MDS is not set
 # CONFIG_MPC832x_RDB is not set
@@ -147,6 +159,8 @@ CONFIG_MPC8313_RDB=y
 # CONFIG_MPC834x_ITX is not set
 # CONFIG_MPC836x_MDS is not set
 CONFIG_PPC_MPC831x=y
+# CONFIG_PPC_86xx is not set
+# CONFIG_EMBEDDED6xx is not set
 # CONFIG_MPIC is not set
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
@@ -157,6 +171,7 @@ CONFIG_PPC_MPC831x=y
 # CONFIG_PPC_INDIRECT_IO is not set
 # CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
+# CONFIG_TAU is not set
 # CONFIG_CPM2 is not set
 
 #
@@ -174,6 +189,7 @@ CONFIG_PREEMPT_NONE=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+# CONFIG_KEXEC is not set
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
@@ -638,6 +654,7 @@ CONFIG_NETDEV_1000=y
 # CONFIG_BNX2 is not set
 CONFIG_GIANFAR=y
 CONFIG_GFAR_NAPI=y
+# CONFIG_MV643XX_ETH is not set
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
 CONFIG_NETDEV_10000=y
Index: linux-2.6/arch/powerpc/configs/mpc832x_mds_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/mpc832x_mds_defconfig
+++ linux-2.6/arch/powerpc/configs/mpc832x_mds_defconfig
@@ -1,9 +1,33 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.22-rc7
-# Sun Jul  1 23:56:55 2007
+# Fri Jul 13 20:00:53 2007
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
+CONFIG_83xx=y
+CONFIG_PPC_FPU=y
+CONFIG_ALTIVEC=y
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_PPC_MM_SLICES is not set
+# CONFIG_SMP is not set
 CONFIG_PPC32=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
@@ -25,28 +49,8 @@ CONFIG_PPC_UDBG_16550=y
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
 CONFIG_DEFAULT_UIMAGE=y
-
-#
-# Processor support
-#
-# CONFIG_CLASSIC32 is not set
-# CONFIG_PPC_82xx is not set
-CONFIG_PPC_83xx=y
-# CONFIG_PPC_85xx is not set
-# CONFIG_PPC_86xx is not set
-# CONFIG_PPC_8xx is not set
-# CONFIG_40x is not set
-# CONFIG_44x is not set
-# CONFIG_E200 is not set
-CONFIG_6xx=y
-CONFIG_83xx=y
-CONFIG_PPC_FPU=y
 # CONFIG_PPC_DCR_NATIVE is not set
 # CONFIG_PPC_DCR_MMIO is not set
-CONFIG_PPC_STD_MMU=y
-CONFIG_PPC_STD_MMU_32=y
-# CONFIG_PPC_MM_SLICES is not set
-# CONFIG_SMP is not set
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -135,11 +139,19 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 # Platform support
 #
+CONFIG_PPC_MULTIPLATFORM=y
+# CONFIG_PPC_82xx is not set
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
+CONFIG_PPC_83xx=y
 # CONFIG_MPC8313_RDB is not set
 CONFIG_MPC832x_MDS=y
 # CONFIG_MPC832x_RDB is not set
@@ -147,6 +159,8 @@ CONFIG_MPC832x_MDS=y
 # CONFIG_MPC834x_ITX is not set
 # CONFIG_MPC836x_MDS is not set
 CONFIG_PPC_MPC832x=y
+# CONFIG_PPC_86xx is not set
+# CONFIG_EMBEDDED6xx is not set
 # CONFIG_MPIC is not set
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
@@ -157,6 +171,7 @@ CONFIG_PPC_MPC832x=y
 # CONFIG_PPC_INDIRECT_IO is not set
 # CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
+# CONFIG_TAU is not set
 CONFIG_QUICC_ENGINE=y
 # CONFIG_CPM2 is not set
 
@@ -176,6 +191,7 @@ CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_MATH_EMULATION=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+# CONFIG_KEXEC is not set
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
@@ -535,6 +551,7 @@ CONFIG_UCC_GETH=y
 # CONFIG_UGETH_MAGIC_PACKET is not set
 # CONFIG_UGETH_FILTERING is not set
 # CONFIG_UGETH_TX_ON_DEMAND is not set
+# CONFIG_MV643XX_ETH is not set
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
 CONFIG_NETDEV_10000=y
Index: linux-2.6/arch/powerpc/configs/mpc832x_rdb_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/mpc832x_rdb_defconfig
+++ linux-2.6/arch/powerpc/configs/mpc832x_rdb_defconfig
@@ -1,9 +1,33 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.22-rc7
-# Sun Jul  1 23:56:56 2007
+# Fri Jul 13 20:00:54 2007
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
+CONFIG_83xx=y
+CONFIG_PPC_FPU=y
+CONFIG_ALTIVEC=y
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_PPC_MM_SLICES is not set
+# CONFIG_SMP is not set
 CONFIG_PPC32=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
@@ -25,28 +49,8 @@ CONFIG_PPC_UDBG_16550=y
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
 CONFIG_DEFAULT_UIMAGE=y
-
-#
-# Processor support
-#
-# CONFIG_CLASSIC32 is not set
-# CONFIG_PPC_82xx is not set
-CONFIG_PPC_83xx=y
-# CONFIG_PPC_85xx is not set
-# CONFIG_PPC_86xx is not set
-# CONFIG_PPC_8xx is not set
-# CONFIG_40x is not set
-# CONFIG_44x is not set
-# CONFIG_E200 is not set
-CONFIG_6xx=y
-CONFIG_83xx=y
-CONFIG_PPC_FPU=y
 # CONFIG_PPC_DCR_NATIVE is not set
 # CONFIG_PPC_DCR_MMIO is not set
-CONFIG_PPC_STD_MMU=y
-CONFIG_PPC_STD_MMU_32=y
-# CONFIG_PPC_MM_SLICES is not set
-# CONFIG_SMP is not set
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -135,11 +139,19 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 # Platform support
 #
+CONFIG_PPC_MULTIPLATFORM=y
+# CONFIG_PPC_82xx is not set
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
+CONFIG_PPC_83xx=y
 # CONFIG_MPC8313_RDB is not set
 # CONFIG_MPC832x_MDS is not set
 CONFIG_MPC832x_RDB=y
@@ -147,6 +159,8 @@ CONFIG_MPC832x_RDB=y
 # CONFIG_MPC834x_ITX is not set
 # CONFIG_MPC836x_MDS is not set
 CONFIG_PPC_MPC832x=y
+# CONFIG_PPC_86xx is not set
+# CONFIG_EMBEDDED6xx is not set
 # CONFIG_MPIC is not set
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
@@ -157,6 +171,7 @@ CONFIG_PPC_MPC832x=y
 # CONFIG_PPC_INDIRECT_IO is not set
 # CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
+# CONFIG_TAU is not set
 CONFIG_QUICC_ENGINE=y
 # CONFIG_CPM2 is not set
 
@@ -176,6 +191,7 @@ CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_MATH_EMULATION=y
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+# CONFIG_KEXEC is not set
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
@@ -538,6 +554,7 @@ CONFIG_UGETH_NAPI=y
 # CONFIG_UGETH_MAGIC_PACKET is not set
 # CONFIG_UGETH_FILTERING is not set
 # CONFIG_UGETH_TX_ON_DEMAND is not set
+# CONFIG_MV643XX_ETH is not set
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
 CONFIG_NETDEV_10000=y
Index: linux-2.6/arch/powerpc/configs/mpc834x_itx_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/mpc834x_itx_defconfig
+++ linux-2.6/arch/powerpc/configs/mpc834x_itx_defconfig
@@ -1,9 +1,33 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.22-rc7
-# Sun Jul  1 23:56:56 2007
+# Fri Jul 13 20:01:04 2007
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
+CONFIG_83xx=y
+CONFIG_PPC_FPU=y
+CONFIG_ALTIVEC=y
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_PPC_MM_SLICES is not set
+# CONFIG_SMP is not set
 CONFIG_PPC32=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
@@ -25,28 +49,8 @@ CONFIG_PPC_UDBG_16550=y
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
 CONFIG_DEFAULT_UIMAGE=y
-
-#
-# Processor support
-#
-# CONFIG_CLASSIC32 is not set
-# CONFIG_PPC_82xx is not set
-CONFIG_PPC_83xx=y
-# CONFIG_PPC_85xx is not set
-# CONFIG_PPC_86xx is not set
-# CONFIG_PPC_8xx is not set
-# CONFIG_40x is not set
-# CONFIG_44x is not set
-# CONFIG_E200 is not set
-CONFIG_6xx=y
-CONFIG_83xx=y
-CONFIG_PPC_FPU=y
 # CONFIG_PPC_DCR_NATIVE is not set
 # CONFIG_PPC_DCR_MMIO is not set
-CONFIG_PPC_STD_MMU=y
-CONFIG_PPC_STD_MMU_32=y
-# CONFIG_PPC_MM_SLICES is not set
-# CONFIG_SMP is not set
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -135,11 +139,19 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 # Platform support
 #
+CONFIG_PPC_MULTIPLATFORM=y
+# CONFIG_PPC_82xx is not set
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
+CONFIG_PPC_83xx=y
 # CONFIG_MPC8313_RDB is not set
 # CONFIG_MPC832x_MDS is not set
 # CONFIG_MPC832x_RDB is not set
@@ -147,6 +159,8 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 CONFIG_MPC834x_ITX=y
 # CONFIG_MPC836x_MDS is not set
 CONFIG_MPC834x=y
+# CONFIG_PPC_86xx is not set
+# CONFIG_EMBEDDED6xx is not set
 # CONFIG_MPIC is not set
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
@@ -157,6 +171,7 @@ CONFIG_MPC834x=y
 # CONFIG_PPC_INDIRECT_IO is not set
 # CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
+# CONFIG_TAU is not set
 # CONFIG_CPM2 is not set
 
 #
@@ -174,6 +189,7 @@ CONFIG_PREEMPT_NONE=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+# CONFIG_KEXEC is not set
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
@@ -663,6 +679,7 @@ CONFIG_NETDEV_1000=y
 # CONFIG_BNX2 is not set
 CONFIG_GIANFAR=y
 CONFIG_GFAR_NAPI=y
+# CONFIG_MV643XX_ETH is not set
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
 CONFIG_NETDEV_10000=y
Index: linux-2.6/arch/powerpc/configs/mpc834x_itxgp_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/mpc834x_itxgp_defconfig
+++ linux-2.6/arch/powerpc/configs/mpc834x_itxgp_defconfig
@@ -1,9 +1,33 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.22-rc7
-# Sun Jul  1 23:56:56 2007
+# Fri Jul 13 20:01:05 2007
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
+CONFIG_83xx=y
+CONFIG_PPC_FPU=y
+CONFIG_ALTIVEC=y
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_PPC_MM_SLICES is not set
+# CONFIG_SMP is not set
 CONFIG_PPC32=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
@@ -25,28 +49,8 @@ CONFIG_PPC_UDBG_16550=y
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
 CONFIG_DEFAULT_UIMAGE=y
-
-#
-# Processor support
-#
-# CONFIG_CLASSIC32 is not set
-# CONFIG_PPC_82xx is not set
-CONFIG_PPC_83xx=y
-# CONFIG_PPC_85xx is not set
-# CONFIG_PPC_86xx is not set
-# CONFIG_PPC_8xx is not set
-# CONFIG_40x is not set
-# CONFIG_44x is not set
-# CONFIG_E200 is not set
-CONFIG_6xx=y
-CONFIG_83xx=y
-CONFIG_PPC_FPU=y
 # CONFIG_PPC_DCR_NATIVE is not set
 # CONFIG_PPC_DCR_MMIO is not set
-CONFIG_PPC_STD_MMU=y
-CONFIG_PPC_STD_MMU_32=y
-# CONFIG_PPC_MM_SLICES is not set
-# CONFIG_SMP is not set
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -135,11 +139,19 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 # Platform support
 #
+CONFIG_PPC_MULTIPLATFORM=y
+# CONFIG_PPC_82xx is not set
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
+CONFIG_PPC_83xx=y
 # CONFIG_MPC8313_RDB is not set
 # CONFIG_MPC832x_MDS is not set
 # CONFIG_MPC832x_RDB is not set
@@ -147,6 +159,8 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 CONFIG_MPC834x_ITX=y
 # CONFIG_MPC836x_MDS is not set
 CONFIG_MPC834x=y
+# CONFIG_PPC_86xx is not set
+# CONFIG_EMBEDDED6xx is not set
 # CONFIG_MPIC is not set
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
@@ -157,6 +171,7 @@ CONFIG_MPC834x=y
 # CONFIG_PPC_INDIRECT_IO is not set
 # CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
+# CONFIG_TAU is not set
 # CONFIG_CPM2 is not set
 
 #
@@ -174,6 +189,7 @@ CONFIG_PREEMPT_NONE=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+# CONFIG_KEXEC is not set
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
@@ -594,6 +610,7 @@ CONFIG_NETDEV_1000=y
 # CONFIG_BNX2 is not set
 CONFIG_GIANFAR=y
 CONFIG_GFAR_NAPI=y
+# CONFIG_MV643XX_ETH is not set
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
 CONFIG_NETDEV_10000=y
Index: linux-2.6/arch/powerpc/configs/mpc834x_mds_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/mpc834x_mds_defconfig
+++ linux-2.6/arch/powerpc/configs/mpc834x_mds_defconfig
@@ -1,9 +1,33 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.22-rc7
-# Sun Jul  1 23:56:57 2007
+# Fri Jul 13 20:01:05 2007
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
+CONFIG_83xx=y
+CONFIG_PPC_FPU=y
+CONFIG_ALTIVEC=y
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_PPC_MM_SLICES is not set
+# CONFIG_SMP is not set
 CONFIG_PPC32=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
@@ -25,28 +49,8 @@ CONFIG_PPC_UDBG_16550=y
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
 CONFIG_DEFAULT_UIMAGE=y
-
-#
-# Processor support
-#
-# CONFIG_CLASSIC32 is not set
-# CONFIG_PPC_82xx is not set
-CONFIG_PPC_83xx=y
-# CONFIG_PPC_85xx is not set
-# CONFIG_PPC_86xx is not set
-# CONFIG_PPC_8xx is not set
-# CONFIG_40x is not set
-# CONFIG_44x is not set
-# CONFIG_E200 is not set
-CONFIG_6xx=y
-CONFIG_83xx=y
-CONFIG_PPC_FPU=y
 # CONFIG_PPC_DCR_NATIVE is not set
 # CONFIG_PPC_DCR_MMIO is not set
-CONFIG_PPC_STD_MMU=y
-CONFIG_PPC_STD_MMU_32=y
-# CONFIG_PPC_MM_SLICES is not set
-# CONFIG_SMP is not set
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -135,11 +139,19 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 # Platform support
 #
+CONFIG_PPC_MULTIPLATFORM=y
+# CONFIG_PPC_82xx is not set
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
+CONFIG_PPC_83xx=y
 # CONFIG_MPC8313_RDB is not set
 # CONFIG_MPC832x_MDS is not set
 # CONFIG_MPC832x_RDB is not set
@@ -147,6 +159,8 @@ CONFIG_MPC834x_MDS=y
 # CONFIG_MPC834x_ITX is not set
 # CONFIG_MPC836x_MDS is not set
 CONFIG_MPC834x=y
+# CONFIG_PPC_86xx is not set
+# CONFIG_EMBEDDED6xx is not set
 # CONFIG_MPIC is not set
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
@@ -157,6 +171,7 @@ CONFIG_MPC834x=y
 # CONFIG_PPC_INDIRECT_IO is not set
 # CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
+# CONFIG_TAU is not set
 # CONFIG_CPM2 is not set
 
 #
@@ -174,6 +189,7 @@ CONFIG_PREEMPT_NONE=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+# CONFIG_KEXEC is not set
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
@@ -477,6 +493,7 @@ CONFIG_NETDEV_1000=y
 # CONFIG_BNX2 is not set
 CONFIG_GIANFAR=y
 # CONFIG_GFAR_NAPI is not set
+# CONFIG_MV643XX_ETH is not set
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
 CONFIG_NETDEV_10000=y
Index: linux-2.6/arch/powerpc/configs/mpc836x_mds_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/mpc836x_mds_defconfig
+++ linux-2.6/arch/powerpc/configs/mpc836x_mds_defconfig
@@ -1,9 +1,33 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.22-rc7
-# Sun Jul  1 23:56:57 2007
+# Fri Jul 13 20:01:07 2007
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
+CONFIG_83xx=y
+CONFIG_PPC_FPU=y
+CONFIG_ALTIVEC=y
+CONFIG_PPC_STD_MMU=y
+CONFIG_PPC_STD_MMU_32=y
+# CONFIG_PPC_MM_SLICES is not set
+# CONFIG_SMP is not set
 CONFIG_PPC32=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
@@ -25,28 +49,8 @@ CONFIG_PPC_UDBG_16550=y
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
 CONFIG_DEFAULT_UIMAGE=y
-
-#
-# Processor support
-#
-# CONFIG_CLASSIC32 is not set
-# CONFIG_PPC_82xx is not set
-CONFIG_PPC_83xx=y
-# CONFIG_PPC_85xx is not set
-# CONFIG_PPC_86xx is not set
-# CONFIG_PPC_8xx is not set
-# CONFIG_40x is not set
-# CONFIG_44x is not set
-# CONFIG_E200 is not set
-CONFIG_6xx=y
-CONFIG_83xx=y
-CONFIG_PPC_FPU=y
 # CONFIG_PPC_DCR_NATIVE is not set
 # CONFIG_PPC_DCR_MMIO is not set
-CONFIG_PPC_STD_MMU=y
-CONFIG_PPC_STD_MMU_32=y
-# CONFIG_PPC_MM_SLICES is not set
-# CONFIG_SMP is not set
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -135,11 +139,19 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 #
 # Platform support
 #
+CONFIG_PPC_MULTIPLATFORM=y
+# CONFIG_PPC_82xx is not set
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
+CONFIG_PPC_83xx=y
 # CONFIG_MPC8313_RDB is not set
 # CONFIG_MPC832x_MDS is not set
 # CONFIG_MPC832x_RDB is not set
@@ -147,6 +159,8 @@ CONFIG_DEFAULT_IOSCHED="anticipatory"
 # CONFIG_MPC834x_ITX is not set
 CONFIG_MPC836x_MDS=y
 CONFIG_PPC_MPC836x=y
+# CONFIG_PPC_86xx is not set
+# CONFIG_EMBEDDED6xx is not set
 # CONFIG_MPIC is not set
 # CONFIG_MPIC_WEIRD is not set
 # CONFIG_PPC_I8259 is not set
@@ -157,6 +171,7 @@ CONFIG_PPC_MPC836x=y
 # CONFIG_PPC_INDIRECT_IO is not set
 # CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
+# CONFIG_TAU is not set
 CONFIG_QUICC_ENGINE=y
 # CONFIG_CPM2 is not set
 
@@ -175,6 +190,7 @@ CONFIG_PREEMPT_NONE=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+# CONFIG_KEXEC is not set
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_POPULATES_NODE_MAP=y
 CONFIG_SELECT_MEMORY_MODEL=y
@@ -534,6 +550,7 @@ CONFIG_UCC_GETH=y
 # CONFIG_UGETH_MAGIC_PACKET is not set
 # CONFIG_UGETH_FILTERING is not set
 # CONFIG_UGETH_TX_ON_DEMAND is not set
+# CONFIG_MV643XX_ETH is not set
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
 CONFIG_NETDEV_10000=y

-- 
