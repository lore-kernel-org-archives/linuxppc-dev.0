Return-Path: <galak@gate.crashing.org>
Date: Tue, 10 Jan 2006 21:43:56 -0600 (CST)
From: Kumar Gala <galak@gate.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Message-ID: <Pine.LNX.4.44.0601101833150.11172-100000@gate.crashing.org>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org, linuxppc64-dev@ozlabs.org
Subject: [PATCH] powerpc: Updated Kconfig and Makefiles for 83xx support
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Updated Kconfig & Makefiles in prep for adding support for the Freescale
MPC83xx family of processors to arch/powerpc.  Moved around some config
options that are more globally applicable to other PowerPC processors.
Added a temporary config option (83xx) to match existh arch/ppc support
for the MPC83xx line.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>

---
commit 2c80aa14abcccdfdef2998ba78c299c33999c621
tree 980e516b488d408d93402dbdbe3749e48996bb81
parent 6d26108d8631afcb31faa6d63cab7bee8d35871c
author Kumar Gala <galak@kernel.crashing.org> Tue, 10 Jan 2006 21:49:06 -0600
committer Kumar Gala <galak@kernel.crashing.org> Tue, 10 Jan 2006 21:49:06 -0600

 arch/powerpc/Kconfig                       |   83 +++++++++++++++++-----------
 arch/powerpc/platforms/83xx/Kconfig        |   26 +++++++++
 arch/powerpc/platforms/83xx/Makefile       |    4 +
 arch/powerpc/platforms/Makefile            |    1 
 arch/powerpc/platforms/embedded6xx/Kconfig |   18 ------
 arch/powerpc/sysdev/Makefile               |    2 -
 arch/ppc/Kconfig                           |    4 +
 7 files changed, 85 insertions(+), 53 deletions(-)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 935d965..01feed0 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -71,15 +71,39 @@ config ARCH_MAY_HAVE_PC_FDC
 	bool
 	default y
 
+config PPC_OF
+	def_bool y
+
+config PPC_UDBG_16550
+	bool
+	default n
+
+config CRASH_DUMP
+	bool "kernel crash dumps (EXPERIMENTAL)"
+	depends on PPC_MULTIPLATFORM
+	depends on EXPERIMENTAL
+	help
+	  Build a kernel suitable for use as a kdump capture kernel.
+	  The kernel will be linked at a different address than normal, and
+	  so can only be used for Kdump.
+
+	  Don't change this unless you know what you are doing.
+
+config GENERIC_TBSYNC
+	bool
+	default y if PPC32 && SMP
+	default n
+
 menu "Processor support"
 choice
 	prompt "Processor Type"
 	depends on PPC32
 	default 6xx
 
-config 6xx
+config CLASSIC32
 	bool "6xx/7xx/74xx"
 	select PPC_FPU
+	select 6xx
 	help
 	  There are four families of PowerPC chips supported.  The more common
 	  types (601, 603, 604, 740, 750, 7400), the Motorola embedded
@@ -93,12 +117,20 @@ config 6xx
 
 config PPC_52xx
 	bool "Freescale 52xx"
+	select 6xx
+	select PPC_FPU
 	
 config PPC_82xx
 	bool "Freescale 82xx"
+	select 6xx
+	select PPC_FPU
 
 config PPC_83xx
 	bool "Freescale 83xx"
+	select 6xx
+	select FSL_SOC
+	select 83xx
+	select PPC_FPU
 
 config 40x
 	bool "AMCC 40x"
@@ -134,6 +166,13 @@ config POWER4
 	depends on PPC64
 	def_bool y
 
+config 6xx
+	bool
+
+# this is temp to handle compat with arch=ppc
+config 83xx
+	bool
+
 config PPC_FPU
 	bool
 	default y if PPC64
@@ -166,7 +205,7 @@ config PHYS_64BIT
 
 config ALTIVEC
 	bool "AltiVec Support"
-	depends on 6xx || POWER4
+	depends on CLASSIC32 || POWER4
 	---help---
 	  This option enables kernel support for the Altivec extensions to the
 	  PowerPC processor. The kernel currently supports saving and restoring
@@ -239,7 +278,7 @@ endmenu
 source "init/Kconfig"
 
 menu "Platform support"
-	depends on PPC64 || 6xx
+	depends on PPC64 || CLASSIC32
 
 choice
 	prompt "Machine type"
@@ -330,9 +369,6 @@ config PPC_CELL
 	select MMIO_NVRAM
 	select PPC_UDBG_16550
 
-config PPC_OF
-	def_bool y
-
 config XICS
 	depends on PPC_PSERIES
 	bool
@@ -375,26 +411,11 @@ config MPIC_BROKEN_U3
 	depends on PPC_MAPLE
 	default y
 
-config PPC_UDBG_16550
-	bool
-	default n
-
 config CELL_IIC
 	depends on PPC_CELL
 	bool
 	default y
 
-config CRASH_DUMP
-	bool "kernel crash dumps (EXPERIMENTAL)"
-	depends on PPC_MULTIPLATFORM
-	depends on EXPERIMENTAL
-	help
-	  Build a kernel suitable for use as a kdump capture kernel.
-	  The kernel will be linked at a different address than normal, and
-	  so can only be used for Kdump.
-
-	  Don't change this unless you know what you are doing.
-
 config IBMVIO
 	depends on PPC_PSERIES || PPC_ISERIES
 	bool
@@ -410,11 +431,6 @@ config PPC_MPC106
 	bool
 	default n
 
-config GENERIC_TBSYNC
-	bool
-	default y if PPC32 && SMP
-	default n
-
 source "drivers/cpufreq/Kconfig"
 
 config CPU_FREQ_PMAC
@@ -495,6 +511,7 @@ endmenu
 
 source arch/powerpc/platforms/embedded6xx/Kconfig
 source arch/powerpc/platforms/4xx/Kconfig
+source arch/powerpc/platforms/83xx/Kconfig
 source arch/powerpc/platforms/85xx/Kconfig
 source arch/powerpc/platforms/8xx/Kconfig
 source arch/powerpc/platforms/cell/Kconfig
@@ -718,7 +735,7 @@ config PPC_I8259
 config PPC_INDIRECT_PCI
 	bool
 	depends on PCI
-	default y if 40x || 44x || 85xx || 83xx
+	default y if 40x || 44x || 85xx
 	default n
 
 config EISA
@@ -727,13 +744,16 @@ config EISA
 config SBUS
 	bool
 
+config FSL_SOC
+	bool
+
 # Yes MCA RS/6000s exist but Linux-PPC does not currently support any
 config MCA
 	bool
 
 config PCI
-	bool "PCI support" if 40x || CPM2 || 83xx || 85xx || PPC_MPC52xx || (EMBEDDED && PPC_ISERIES)
-	default y if !40x && !CPM2 && !8xx && !APUS && !83xx && !85xx
+	bool "PCI support" if 40x || CPM2 || PPC_83xx || 85xx || PPC_MPC52xx || (EMBEDDED && PPC_ISERIES)
+	default y if !40x && !CPM2 && !8xx && !APUS && !PPC_83xx && !85xx
 	default PCI_PERMEDIA if !4xx && !CPM2 && !8xx && APUS
 	default PCI_QSPAN if !4xx && !CPM2 && 8xx
 	help
@@ -746,11 +766,6 @@ config PCI_DOMAINS
 	bool
 	default PCI
 
-config MPC83xx_PCI2
-	bool "  Supprt for 2nd PCI host controller"
-	depends on PCI && MPC834x
-	default y if MPC834x_SYS
-
 config PCI_QSPAN
 	bool "QSpan PCI"
 	depends on !4xx && !CPM2 && 8xx
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
new file mode 100644
index 0000000..b20812d
--- /dev/null
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -0,0 +1,26 @@
+menu "Platform support"
+	depends on PPC_83xx
+
+choice
+	prompt "Machine Type"
+	default MPC834x_SYS
+
+config MPC834x_SYS
+	bool "Freescale MPC834x SYS"
+	help
+	  This option enables support for the MPC 834x SYS evaluation board.
+
+	  Be aware that PCI buses can only function when SYS board is plugged
+	  into the PIB (Platform IO Board) board from Freescale which provide
+	  3 PCI slots.  The PIBs PCI initialization is the bootloader's
+	  responsiblilty.
+
+endchoice
+
+config MPC834x
+	bool
+	select PPC_UDBG_16550
+	select PPC_INDIRECT_PCI
+	default y if MPC834x_SYS
+
+endmenu
diff --git a/arch/powerpc/platforms/83xx/Makefile b/arch/powerpc/platforms/83xx/Makefile
new file mode 100644
index 0000000..9d8b28e
--- /dev/null
+++ b/arch/powerpc/platforms/83xx/Makefile
@@ -0,0 +1,4 @@
+#
+# Makefile for the PowerPC 83xx linux kernel.
+#
+obj-$(CONFIG_MPC834x_SYS)	+= mpc834x_sys.o pci.o
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index 8836b3a..04073fd 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -7,6 +7,7 @@ endif
 endif
 obj-$(CONFIG_PPC_CHRP)		+= chrp/
 obj-$(CONFIG_4xx)		+= 4xx/
+obj-$(CONFIG_PPC_83xx)		+= 83xx/
 obj-$(CONFIG_85xx)		+= 85xx/
 obj-$(CONFIG_PPC_PSERIES)	+= pseries/
 obj-$(CONFIG_PPC_ISERIES)	+= iseries/
diff --git a/arch/powerpc/platforms/embedded6xx/Kconfig b/arch/powerpc/platforms/embedded6xx/Kconfig
index 8125009..4fdbc9a 100644
--- a/arch/powerpc/platforms/embedded6xx/Kconfig
+++ b/arch/powerpc/platforms/embedded6xx/Kconfig
@@ -144,16 +144,6 @@ config LITE5200
 	  much but it's only been tested on this board version. I think this
 	  board is also known as IceCube.
 
-config MPC834x_SYS
-	bool "Freescale MPC834x SYS"
-	help
-	  This option enables support for the MPC 834x SYS evaluation board.
-
-	  Be aware that PCI buses can only function when SYS board is plugged
-	  into the PIB (Platform IO Board) board from Freescale which provide
-	  3 PCI slots.  The PIBs PCI initialization is the bootloader's
-	  responsiblilty.
-
 config EV64360
 	bool "Marvell-EV64360BP"
 	help
@@ -192,14 +182,6 @@ config 8272
 	  The MPC8272 CPM has a different internal dpram setup than other CPM2
 	  devices
 
-config 83xx
-	bool
-	default y if MPC834x_SYS
-
-config MPC834x
-	bool
-	default y if MPC834x_SYS
-
 config CPM2
 	bool
 	depends on 8260 || MPC8560 || MPC8555
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 14b9abd..0ae8413 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -6,4 +6,4 @@ obj-$(CONFIG_BOOKE)		+= dcr.o
 obj-$(CONFIG_40x)		+= dcr.o
 obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
-obj-$(CONFIG_83xx)		+= ipic.o
+obj-$(CONFIG_PPC_83xx)		+= ipic.o
diff --git a/arch/ppc/Kconfig b/arch/ppc/Kconfig
index e396f45..d658101 100644
--- a/arch/ppc/Kconfig
+++ b/arch/ppc/Kconfig
@@ -743,6 +743,10 @@ config MPC834x
 	bool
 	default y if MPC834x_SYS
 
+config PPC_83xx
+	bool
+	default y if 83xx
+
 config CPM1
 	bool
 	depends on 8xx
