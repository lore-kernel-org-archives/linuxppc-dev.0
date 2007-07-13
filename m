Return-Path: <arnd@arndb.de>
Received: from moutng.kundenserver.de (moutng.kundenserver.de
	[212.227.126.171]) by ozlabs.org (Postfix) with ESMTP id 2222FDDE10
	for <linuxppc-dev@ozlabs.org>; Sat, 14 Jul 2007 05:43:34 +1000 (EST)
Message-Id: <20070713184824.024296544@arndb.de>
References: <20070713184452.466490031@arndb.de>
Date: Fri, 13 Jul 2007 20:44:55 +0200
From: Arnd Bergmann <arnd@arndb.de>
To: paulus@samba.org
Subject: [PATCH 3/5] move 86xx into multiplatform
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Jon Loeliger <jdl@freescale.com> wrote:
X-Provags-ID: V01U2FsdGVkX18q0hUeUuMqOEeLWhKFlJn74HxEidaqOcemeHV
 ERKD3Oa64b/U3Jbpg7ScqVjTea/vrQYQQ9h6BX663cqWFlw9cZ
 acZ0zSjq49Kqfby7nRUgQ==

> Hmmm... Shouldn't this sort of change come
> with an update to the 8641 defconfig too?
Content-Disposition: inline; filename=86xx-multi.diff

MPC86xx based machines don't need their own kernel,
but can run one that is shared with the other 6xx
compatible machines, so we should allow that
in Kconfig.

Cc: Kumar Gala <galak@kernel.crashing.org>
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---

Kumar, I don't remember if you still had objections
to merging 86xx annd 83xx into multiplatform after
our last discussion.
Please Ack or Nack the two patches.

Index: linux-2.6/arch/powerpc/platforms/86xx/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/86xx/Kconfig
+++ linux-2.6/arch/powerpc/platforms/86xx/Kconfig
@@ -1,18 +1,20 @@
-choice
-	prompt "86xx Board Type"
-	depends on PPC_86xx
-	default MPC8641_HPCN
+config PPC_86xx
+	bool "Freescale 86xx based boards"
+	depends on 6xx
+	select FSL_SOC
+	select ALTIVEC
+	help
+	  The Freescale E600 SoCs have 74xx cores.
 
 config MPC8641_HPCN
 	bool "Freescale MPC8641 HPCN"
+	depends on PPC_86xx
 	select PPC_I8259
 	select DEFAULT_UIMAGE
 	select CPU_7450
 	help
 	  This option enables support for the MPC8641 HPCN board.
 
-endchoice
-
 config MPC8641
 	bool
 	select PPC_INDIRECT_PCI
Index: linux-2.6/arch/powerpc/platforms/Kconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/platforms/Kconfig
+++ linux-2.6/arch/powerpc/platforms/Kconfig
@@ -23,13 +23,6 @@ config PPC_83xx
 	select 83xx
 	select WANT_DEVICE_TREE
 
-config PPC_86xx
-	bool "Freescale 86xx"
-	depends on 6xx
-	select FSL_SOC
-	select ALTIVEC
-	help
-	  The Freescale E600 SoCs have 74xx cores.
 endchoice
 
 config CLASSIC32
Index: linux-2.6/arch/powerpc/configs/mpc8641_hpcn_defconfig
===================================================================
--- linux-2.6.orig/arch/powerpc/configs/mpc8641_hpcn_defconfig
+++ linux-2.6/arch/powerpc/configs/mpc8641_hpcn_defconfig
@@ -1,9 +1,33 @@
 #
 # Automatically generated make config: don't edit
 # Linux kernel version: 2.6.22-rc7
-# Sun Jul  1 23:57:00 2007
+# Fri Jul 13 20:08:07 2007
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
+CONFIG_SMP=y
+CONFIG_NR_CPUS=2
 CONFIG_PPC32=y
 CONFIG_PPC_MERGE=y
 CONFIG_MMU=y
@@ -25,29 +49,8 @@ CONFIG_GENERIC_TBSYNC=y
 CONFIG_AUDIT_ARCH=y
 CONFIG_GENERIC_BUG=y
 CONFIG_DEFAULT_UIMAGE=y
-
-#
-# Processor support
-#
-# CONFIG_CLASSIC32 is not set
-# CONFIG_PPC_82xx is not set
-# CONFIG_PPC_83xx is not set
-# CONFIG_PPC_85xx is not set
-CONFIG_PPC_86xx=y
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
-CONFIG_SMP=y
-CONFIG_NR_CPUS=2
 CONFIG_DEFCONFIG_LIST="/lib/modules/$UNAME_RELEASE/.config"
 
 #
@@ -133,11 +136,20 @@ CONFIG_DEFAULT_IOSCHED="deadline"
 #
 # Platform support
 #
+CONFIG_PPC_MULTIPLATFORM=y
+# CONFIG_PPC_82xx is not set
+# CONFIG_PPC_83xx is not set
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
+CONFIG_PPC_86xx=y
 CONFIG_MPC8641_HPCN=y
 CONFIG_MPC8641=y
 CONFIG_MPIC=y
@@ -150,6 +162,7 @@ CONFIG_PPC_I8259=y
 # CONFIG_PPC_INDIRECT_IO is not set
 # CONFIG_GENERIC_IOMAP is not set
 # CONFIG_CPU_FREQ is not set
+# CONFIG_TAU is not set
 # CONFIG_CPM2 is not set
 
 #
@@ -168,6 +181,7 @@ CONFIG_PREEMPT_BKL=y
 CONFIG_BINFMT_ELF=y
 # CONFIG_BINFMT_MISC is not set
 CONFIG_ARCH_ENABLE_MEMORY_HOTPLUG=y
+# CONFIG_KEXEC is not set
 # CONFIG_IRQ_ALL_CPUS is not set
 CONFIG_ARCH_FLATMEM_ENABLE=y
 CONFIG_ARCH_POPULATES_NODE_MAP=y
@@ -196,7 +210,6 @@ CONFIG_GENERIC_ISA_DMA=y
 CONFIG_PPC_INDIRECT_PCI=y
 CONFIG_PPC_INDIRECT_PCI_BE=y
 CONFIG_FSL_SOC=y
-CONFIG_FSL_PCIE=y
 CONFIG_PCI=y
 CONFIG_PCI_DOMAINS=y
 # CONFIG_PCIEPORTBUS is not set
@@ -469,6 +482,7 @@ CONFIG_NETDEV_1000=y
 # CONFIG_BNX2 is not set
 CONFIG_GIANFAR=y
 # CONFIG_GFAR_NAPI is not set
+# CONFIG_MV643XX_ETH is not set
 # CONFIG_QLA3XXX is not set
 # CONFIG_ATL1 is not set
 CONFIG_NETDEV_10000=y

--
