Return-Path: <jdl@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103]) by ozlabs.org (Postfix) with ESMTP id BCE9367C42
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Jun 2006 08:00:09 +1000 (EST)
Received: from az33smr01.freescale.net (az33smr01.freescale.net [10.64.34.199])
	by az33egw02.freescale.net (8.12.11/az33egw02) with ESMTP id
	k58MGs3I029074
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jun 2006 15:16:54 -0700 (MST)
Received: from [10.82.19.2] (cashmere.am.freescale.net [10.82.19.2])
	by az33smr01.freescale.net (8.13.1/8.13.0) with ESMTP id k58M079h019991
	for <linuxppc-dev@ozlabs.org>; Thu, 8 Jun 2006 17:00:07 -0500 (CDT)
Subject: [PATCH 1/10 v2] Add the mpc8641 hpcn Kconfig and Makefiles.
From: Jon Loeliger <jdl@freescale.com>
To: linuxppc-dev@ozlabs.org
Content-Type: text/plain
Message-Id: <1149803767.23938.276.camel@cashmere.sps.mot.com>
Mime-Version: 1.0
Date: Thu, 08 Jun 2006 16:56:07 -0500
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Signed-off-by: Xianghua Xiao <x.xiao@freescale.com>
Signed-off-by: Jon Loeliger <jdl@freescale.com>

---

 arch/powerpc/Kconfig                 |   15 ++++++++++-
 arch/powerpc/platforms/Makefile      |    1 +
 arch/powerpc/platforms/86xx/Kconfig  |   46 ++++++++++++++++++++++++++++++++++
 arch/powerpc/platforms/86xx/Makefile |    7 +++++
 4 files changed, 67 insertions(+), 2 deletions(-)


diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 75ba0ec..2603cd3 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -141,6 +141,15 @@ config PPC_85xx
 	select FSL_SOC
 	select 85xx
 
+config PPC_86xx
+	bool "Freescale 86xx"
+	select 6xx
+	select FSL_SOC
+	select PPC_FPU
+	select ALTIVEC
+	help
+	  The Freescale E600 SoCs have 74xx cores.
+
 config 40x
 	bool "AMCC 40x"
 
@@ -549,6 +558,7 @@ source arch/powerpc/platforms/embedded6x
 source arch/powerpc/platforms/4xx/Kconfig
 source arch/powerpc/platforms/83xx/Kconfig
 source arch/powerpc/platforms/85xx/Kconfig
+source arch/powerpc/platforms/86xx/Kconfig
 source arch/powerpc/platforms/8xx/Kconfig
 source arch/powerpc/platforms/cell/Kconfig
 
@@ -780,6 +790,7 @@ config GENERIC_ISA_DMA
 
 config PPC_I8259
 	bool
+	default y if MPC8641_HPCN
 	default n
 
 config PPC_INDIRECT_PCI
@@ -802,8 +813,8 @@ config MCA
 	bool
 
 config PCI
-	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_MPC52xx || (EMBEDDED && PPC_ISERIES)
-	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx && !PPC_85xx
+	bool "PCI support" if 40x || CPM2 || PPC_83xx || PPC_85xx || PPC_86xx || PPC_MPC52xx || (EMBEDDED && PPC_ISERIES)
+	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx && !PPC_85xx && !PPC_86xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
 	default PCI_QSPAN if !4xx && !CPM2 && 8xx
 	help
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index c4f6b0d..2928636 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -9,6 +9,7 @@ obj-$(CONFIG_PPC_CHRP)		+= chrp/
 obj-$(CONFIG_4xx)		+= 4xx/
 obj-$(CONFIG_PPC_83xx)		+= 83xx/
 obj-$(CONFIG_PPC_85xx)		+= 85xx/
+obj-$(CONFIG_PPC_86xx)		+= 86xx/
 obj-$(CONFIG_PPC_PSERIES)	+= pseries/
 obj-$(CONFIG_PPC_ISERIES)	+= iseries/
 obj-$(CONFIG_PPC_MAPLE)		+= maple/
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
new file mode 100644
index 0000000..e922406
--- /dev/null
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -0,0 +1,46 @@
+menu "Platform Support"
+	depends on PPC_86xx
+
+choice
+	prompt "Machine Type"
+	default MPC8641_HPCN
+
+config MPC8641_HPCN
+	bool "Freescale MPC8641 HPCN"
+	help
+	  This option enables support for the MPC8641 HPCN board.
+
+endchoice
+
+
+config MPC8641
+	bool
+	select PPC_INDIRECT_PCI
+	select PPC_UDBG_16550
+	default y if MPC8641_HPCN
+
+config MPIC
+	bool
+	default y
+
+config PPC_INDIRECT_PCI_BE
+	bool
+	depends on PPC_86xx
+	default y
+
+config PEX
+	bool "PCI Express support"
+	depends on PCI && PPC_86xx
+	default y
+
+config I8259_LEVEL_TRIGGER
+	bool
+	depends on MPC8641_HPCN
+	default y
+
+config PPC_STD_MMU
+	bool
+	depends on PPC_86xx
+	default y
+
+endmenu
diff --git a/arch/powerpc/platforms/86xx/Makefile b/arch/powerpc/platforms/86xx/Makefile
new file mode 100644
index 0000000..1bd1f43
--- /dev/null
+++ b/arch/powerpc/platforms/86xx/Makefile
@@ -0,0 +1,7 @@
+#
+# Makefile for the PowerPC 86xx linux kernel.
+#
+
+obj-$(CONFIG_PPC_86xx)		+= misc.o
+obj-$(CONFIG_MPC8641_HPCN)	+= mpc86xx_hpcn.o mpc8641_hpcn.o
+obj-$(CONFIG_PCI)		+= pci.o pex.o
