Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id CCCADDDEBC
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Apr 2007 07:05:05 +1000 (EST)
Date: Mon, 16 Apr 2007 16:01:02 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Please pull from 'kconfig' branch of powerpc for 2.6.22
Message-ID: <Pine.LNX.4.64.0704161559150.10016@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Please pull from 'kconfig' branch of
master.kernel.org:/pub/scm/linux/kernel/git/galak/powerpc.git kconfig

No one seemed to have any issues with these changes.

to receive the following updates:

 arch/powerpc/Kconfig                |   47 +++++--------------------
 arch/powerpc/platforms/82xx/Kconfig |   50 ++++++++------------------
 arch/powerpc/platforms/83xx/Kconfig |    6 ---
 arch/powerpc/platforms/85xx/Kconfig |   29 ++-------------
 arch/powerpc/platforms/86xx/Kconfig |   18 +--------
 arch/powerpc/platforms/8xx/Kconfig  |   67 ++++++++++++++++--------------------
 arch/powerpc/platforms/Kconfig      |   58 ++++++++++++++++++++++++-------
 7 files changed, 109 insertions(+), 166 deletions(-)

Kumar Gala (7):
      [POWERPC] Ensure platform CONFIG options have correct dependencies
      [POWERPC] Convert 86xx platform to unified platform Kconfig
      [POWERPC] Convert 83xx platform to unified platform Kconfig
      [POWERPC] Convert 82xx platform to unified platform Kconfig
      [POWERPC] Convert 8xx platform to unified platform Kconfig
      [POWERPC] Convert 85xx platform to unified platform Kconfig
      [POWERPC] Miscellaneous arch/powerpc Kconfig and platform/Kconfig cleanup

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 740892a..26713da 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -192,7 +192,6 @@ config 44x
 	bool "AMCC 44x"
 	select PPC_DCR_NATIVE

-
 config E200
 	bool "Freescale e200"

@@ -375,14 +374,6 @@ source "init/Kconfig"

 source "arch/powerpc/platforms/Kconfig"

-source arch/powerpc/platforms/embedded6xx/Kconfig
-source arch/powerpc/platforms/4xx/Kconfig
-source arch/powerpc/platforms/82xx/Kconfig
-source arch/powerpc/platforms/83xx/Kconfig
-source arch/powerpc/platforms/85xx/Kconfig
-source arch/powerpc/platforms/86xx/Kconfig
-source arch/powerpc/platforms/8xx/Kconfig
-
 menu "Kernel options"

 config HIGHMEM
@@ -464,15 +455,6 @@ config CRASH_DUMP

 	  Don't change this unless you know what you are doing.

-config EMBEDDEDBOOT
-	bool
-	depends on 8xx || 8260
-	default y
-
-config PC_KEYBOARD
-	bool "PC PS/2 style Keyboard"
-	depends on 4xx || CPM2
-
 config PPCBUG_NVRAM
 	bool "Enable reading PPCBUG NVRAM during boot" if PPLUS || LOPEC
 	default y if PPC_PREP
@@ -486,7 +468,6 @@ config IRQ_ALL_CPUS
 	  CPU.  Generally saying Y is safe, although some problems have been
 	  reported with SMP Power Macintoshes with this option enabled.

-
 config NUMA
 	bool "NUMA support"
 	depends on PPC64
@@ -536,10 +517,10 @@ config PPC_64K_PAGES
 	depends on PPC64
 	help
 	  This option changes the kernel logical page size to 64k. On machines
-          without processor support for 64k pages, the kernel will simulate
-          them by loading each individual 4k page on demand transparently,
-          while on hardware with such support, it will be used to map
-          normal application pages.
+	  without processor support for 64k pages, the kernel will simulate
+	  them by loading each individual 4k page on demand transparently,
+	  while on hardware with such support, it will be used to map
+	  normal application pages.

 config SCHED_SMT
 	bool "SMT (Hyperthreading) scheduler support"
@@ -619,24 +600,17 @@ config GENERIC_ISA_DMA
 	depends on PPC64 || POWER4 || 6xx && !CPM2
 	default y

-config MPIC
-	bool
-	default n
-
-config MPIC_WEIRD
-	bool
-	default n
-
-config PPC_I8259
-	bool
-	default n
-
 config PPC_INDIRECT_PCI
 	bool
 	depends on PCI
 	default y if 40x || 44x
 	default n

+config PPC_INDIRECT_PCI_BE
+	bool
+	depends PPC_INDIRECT_PCI
+	default n
+
 config EISA
 	bool

@@ -857,11 +831,10 @@ source "fs/Kconfig"

 source "arch/powerpc/sysdev/qe_lib/Kconfig"

-
 source "lib/Kconfig"

 menu "Instrumentation Support"
-        depends on EXPERIMENTAL
+	depends on EXPERIMENTAL

 source "arch/powerpc/oprofile/Kconfig"

diff --git a/arch/powerpc/platforms/82xx/Kconfig b/arch/powerpc/platforms/82xx/Kconfig
index 4110716..de7fce9 100644
--- a/arch/powerpc/platforms/82xx/Kconfig
+++ b/arch/powerpc/platforms/82xx/Kconfig
@@ -1,56 +1,36 @@
-menu "Platform support"
-       depends on PPC_82xx
-
 choice
-       prompt "Machine Type"
-       default MPC82xx_ADS
+	prompt "Machine Type"
+	depends on PPC_82xx
+	default MPC82xx_ADS

 config MPC82xx_ADS
-       bool "Freescale MPC82xx ADS"
-       select DEFAULT_UIMAGE
-       select PQ2ADS
-       select 8272
-       select 8260
-       select CPM2
-       select FSL_SOC
-       help
-         This option enables support for the MPC8272 ADS board
+	bool "Freescale MPC82xx ADS"
+	select DEFAULT_UIMAGE
+	select PQ2ADS
+	select 8272
+	select 8260
+	select FSL_SOC
+	help
+	This option enables support for the MPC8272 ADS board

 endchoice

 config PQ2ADS
 	bool
-	depends on ADS8272
-	default y
-
-config ADS8272
-	bool
+	default n

 config 8260
-	bool "CPM2 Support" if WILLOW
+	bool
 	depends on 6xx
-	default y if PQ2FADS
+	select CPM2
 	help
-	  The MPC8260 is a typical embedded CPU made by Motorola.  Selecting
+	  The MPC8260 is a typical embedded CPU made by Freescale.  Selecting
 	  this option means that you wish to build a kernel for a machine with
 	  an 8260 class CPU.

 config 8272
 	bool
-	depends on 6xx
-	default y if ADS8272
 	select 8260
 	help
 	  The MPC8272 CPM has a different internal dpram setup than other CPM2
 	  devices
-
-config CPM2
-	bool
-	depends on 8260 || MPC8560 || MPC8555
-	default y
-	help
-	  The CPM2 (Communications Processor Module) is a coprocessor on
-	  embedded CPUs made by Motorola.  Selecting this option means that
-	  you wish to build a kernel for a machine with a CPM2 coprocessor
-	  on it (826x, 827x, 8560).
-endmenu
diff --git a/arch/powerpc/platforms/83xx/Kconfig b/arch/powerpc/platforms/83xx/Kconfig
index 2a23392..19cafdf 100644
--- a/arch/powerpc/platforms/83xx/Kconfig
+++ b/arch/powerpc/platforms/83xx/Kconfig
@@ -1,8 +1,6 @@
-menu "Platform support"
-	depends on PPC_83xx
-
 choice
 	prompt "Machine Type"
+	depends on PPC_83xx
 	default MPC834x_MDS

 config MPC8313_RDB
@@ -77,5 +75,3 @@ config PPC_MPC836x
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
 	default y if MPC836x_MDS
-
-endmenu
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index 124e2c5..c79ae86 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -1,8 +1,6 @@
-menu "Platform support"
-	depends on PPC_85xx
-
 choice
 	prompt "Machine Type"
+	depends on PPC_85xx
 	default MPC8540_ADS

 config MPC8540_ADS
@@ -46,33 +44,14 @@ config MPC8540

 config MPC8560
 	bool
-	select PPC_INDIRECT_PCI
+	select CPM2
 	default y if MPC8560_ADS

 config MPC85xx
 	bool
 	select PPC_UDBG_16550
 	select PPC_INDIRECT_PCI
+	select PPC_INDIRECT_PCI_BE
+	select MPIC
 	default y if MPC8540_ADS || MPC85xx_CDS || MPC8560_ADS \
 		|| MPC85xx_MDS || MPC8544_DS
-
-config PPC_INDIRECT_PCI_BE
-	bool
-	depends on PPC_85xx
-	default y
-
-config MPIC
-	bool
-	default y
-
-config CPM2
-	bool
-	depends on MPC8560
-	default y
-	help
-	  The CPM2 (Communications Processor Module) is a coprocessor on
-	  embedded CPUs made by Motorola.  Selecting this option means that
-	  you wish to build a kernel for a machine with a CPM2 coprocessor
-	  on it.
-
-endmenu
diff --git a/arch/powerpc/platforms/86xx/Kconfig b/arch/powerpc/platforms/86xx/Kconfig
index 0c70944..d1bcff5 100644
--- a/arch/powerpc/platforms/86xx/Kconfig
+++ b/arch/powerpc/platforms/86xx/Kconfig
@@ -1,8 +1,6 @@
-menu "Platform Support"
-	depends on PPC_86xx
-
 choice
 	prompt "Machine Type"
+	depends on PPC_86xx
 	default MPC8641_HPCN

 config MPC8641_HPCN
@@ -14,20 +12,10 @@ config MPC8641_HPCN

 endchoice

-
 config MPC8641
 	bool
 	select PPC_INDIRECT_PCI
+	select PPC_INDIRECT_PCI_BE
 	select PPC_UDBG_16550
+	select MPIC
 	default y if MPC8641_HPCN
-
-config MPIC
-	bool
-	default y
-
-config PPC_INDIRECT_PCI_BE
-	bool
-	depends on PPC_86xx
-	default y
-
-endmenu
diff --git a/arch/powerpc/platforms/8xx/Kconfig b/arch/powerpc/platforms/8xx/Kconfig
index beea683..39bb8c5 100644
--- a/arch/powerpc/platforms/8xx/Kconfig
+++ b/arch/powerpc/platforms/8xx/Kconfig
@@ -1,6 +1,3 @@
-menu "Platform support"
-        depends on PPC_8xx
-
 config FADS
 	bool

@@ -9,6 +6,7 @@ config CPM1

 choice
 	prompt "8xx Machine Type"
+	depends on PPC_8xx
 	depends on 8xx
 	default MPC885ADS

@@ -36,38 +34,36 @@ config MPC885ADS
 endchoice

 menu "Freescale Ethernet driver platform-specific options"
-        depends on (FS_ENET && MPC885ADS)
-
-        config MPC8xx_SECOND_ETH
-        bool "Second Ethernet channel"
-        depends on MPC885ADS
-        default y
-        help
-          This enables support for second Ethernet on MPC885ADS and MPC86xADS boards.
-          The latter will use SCC1, for 885ADS you can select it below.
-
-        choice
-                prompt "Second Ethernet channel"
-                depends on MPC8xx_SECOND_ETH
-                default MPC8xx_SECOND_ETH_FEC2
-
-                config MPC8xx_SECOND_ETH_FEC2
-                bool "FEC2"
-                depends on MPC885ADS
-                help
-                  Enable FEC2 to serve as 2-nd Ethernet channel. Note that SMC2
-                  (often 2-nd UART) will not work if this is enabled.
-
-                config MPC8xx_SECOND_ETH_SCC3
-                bool "SCC3"
-                depends on MPC885ADS
-                help
-                  Enable SCC3 to serve as 2-nd Ethernet channel. Note that SMC1
-                  (often 1-nd UART) will not work if this is enabled.
-
-        endchoice
+	depends on (FS_ENET && MPC885ADS)

-endmenu
+	config MPC8xx_SECOND_ETH
+	bool "Second Ethernet channel"
+	depends on MPC885ADS
+	default y
+	help
+	  This enables support for second Ethernet on MPC885ADS and MPC86xADS boards.
+	  The latter will use SCC1, for 885ADS you can select it below.
+
+	choice
+		prompt "Second Ethernet channel"
+		depends on MPC8xx_SECOND_ETH
+		default MPC8xx_SECOND_ETH_FEC2
+
+		config MPC8xx_SECOND_ETH_FEC2
+		bool "FEC2"
+		depends on MPC885ADS
+		help
+		  Enable FEC2 to serve as 2-nd Ethernet channel. Note that SMC2
+		  (often 2-nd UART) will not work if this is enabled.
+
+		config MPC8xx_SECOND_ETH_SCC3
+		bool "SCC3"
+		depends on MPC885ADS
+		help
+		  Enable SCC3 to serve as 2-nd Ethernet channel. Note that SMC1
+		  (often 1-nd UART) will not work if this is enabled.
+
+	endchoice

 endmenu

@@ -98,7 +94,7 @@ config 8xx_CPU6
 	  require workarounds for Linux (and most other OSes to work).  If you
 	  get a BUG() very early in boot, this might fix the problem.  For
 	  more details read the document entitled "MPC860 Family Device Errata
-	  Reference" on Motorola's website.  This option also incurs a
+	  Reference" on Freescale's website.  This option also incurs a
 	  performance hit.

 	  If in doubt, say N here.
@@ -135,4 +131,3 @@ config UCODE_PATCH
 	depends on !NO_UCODE_PATCH

 endmenu
-
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 161ab79..86be82a 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -1,8 +1,8 @@
 menu "Platform support"
-	depends on PPC64 || CLASSIC32

 choice
 	prompt "Machine type"
+	depends on PPC64 || CLASSIC32
 	default PPC_MULTIPLATFORM

 config PPC_MULTIPLATFORM
@@ -25,14 +25,6 @@ config APUS
 	  <http://linux-apus.sourceforge.net/>.
 endchoice

-config QUICC_ENGINE
-	bool
-	help
-	  The QUICC Engine (QE) is a new generation of communications
-	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
-	  Selecting this option means that you wish to build a kernel
-	  for a machine with a QE coprocessor.
-
 source "arch/powerpc/platforms/pseries/Kconfig"
 source "arch/powerpc/platforms/iseries/Kconfig"
 source "arch/powerpc/platforms/chrp/Kconfig"
@@ -41,9 +33,16 @@ source "arch/powerpc/platforms/powermac/Kconfig"
 source "arch/powerpc/platforms/prep/Kconfig"
 source "arch/powerpc/platforms/maple/Kconfig"
 source "arch/powerpc/platforms/pasemi/Kconfig"
-source arch/powerpc/platforms/celleb/Kconfig
-source arch/powerpc/platforms/ps3/Kconfig
-source arch/powerpc/platforms/cell/Kconfig
+source "arch/powerpc/platforms/celleb/Kconfig"
+source "arch/powerpc/platforms/ps3/Kconfig"
+source "arch/powerpc/platforms/cell/Kconfig"
+source "arch/powerpc/platforms/8xx/Kconfig"
+source "arch/powerpc/platforms/82xx/Kconfig"
+source "arch/powerpc/platforms/83xx/Kconfig"
+source "arch/powerpc/platforms/85xx/Kconfig"
+source "arch/powerpc/platforms/86xx/Kconfig"
+source "arch/powerpc/platforms/embedded6xx/Kconfig"
+#source "arch/powerpc/platforms/4xx/Kconfig

 config PPC_NATIVE
 	bool
@@ -68,6 +67,18 @@ config XICS
 	bool
 	default y

+config MPIC
+	bool
+	default n
+
+config MPIC_WEIRD
+	bool
+	default n
+
+config PPC_I8259
+	bool
+	default n
+
 config U3_DART
 	bool
 	depends on PPC_MULTIPLATFORM && PPC64
@@ -137,6 +148,9 @@ config GENERIC_IOMAP
 	bool
 	default n

+menu "CPU Frequency support"
+	depends on PPC64 || CLASSIC32
+
 source "drivers/cpufreq/Kconfig"

 config CPU_FREQ_PMAC
@@ -155,6 +169,7 @@ config CPU_FREQ_PMAC64
 	help
 	  This adds support for frequency switching on Apple iMac G5,
 	  and some of the more recent desktop G5 machines as well.
+endmenu

 config PPC601_SYNC_FIX
 	bool "Workarounds for PPC601 bugs"
@@ -172,7 +187,7 @@ config PPC601_SYNC_FIX

 config TAU
 	bool "On-chip CPU temperature sensor support"
-	depends on 6xx
+	depends on CLASSIC32
 	help
 	  G3 and G4 processors have an on-chip temperature sensor called the
 	  'Thermal Assist Unit (TAU)', which, in theory, can measure the on-die
@@ -214,4 +229,21 @@ config TAU_AVERAGE

 	  If in doubt, say N here.

+config QUICC_ENGINE
+	bool
+	help
+	  The QUICC Engine (QE) is a new generation of communications
+	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
+	  Selecting this option means that you wish to build a kernel
+	  for a machine with a QE coprocessor.
+
+config CPM2
+	bool
+	default n
+	help
+	  The CPM2 (Communications Processor Module) is a coprocessor on
+	  embedded CPUs made by Freescale.  Selecting this option means that
+	  you wish to build a kernel for a machine with a CPM2 coprocessor
+	  on it (826x, 827x, 8560).
+
 endmenu
