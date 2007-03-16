Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7CE3EDDEDF
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 02:28:24 +1100 (EST)
Received: from [72.183.106.80] (helo=[192.168.1.2])
	by nommos.sslcatacombnetworking.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63) (envelope-from <galak@kernel.crashing.org>)
	id 1HSELt-0000bM-L8
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 10:28:21 -0500
Date: Fri, 16 Mar 2007 10:25:03 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH][POWERPC] [005/006] Split several platforms into their
	respective Kconfig file
In-Reply-To: <Pine.LNX.4.64.0703161016520.9740@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0703161024250.9740@localhost.localdomain>
References: <Pine.LNX.4.64.0703161016520.9740@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Moved pseries, iseries, chrp, prep, maple and pasemi into their respective
arch/powerpc/platform/*/Kconfig files out of arch/powerpc/Kconfig

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig                   |   80 ++-----------------------------
 arch/powerpc/platforms/chrp/Kconfig    |   11 ++++
 arch/powerpc/platforms/iseries/Kconfig |    4 ++
 arch/powerpc/platforms/maple/Kconfig   |   17 +++++++
 arch/powerpc/platforms/pasemi/Kconfig  |   12 +++++
 arch/powerpc/platforms/prep/Kconfig    |    9 ++++
 arch/powerpc/platforms/pseries/Kconfig |   10 ++++
 7 files changed, 69 insertions(+), 74 deletions(-)
 create mode 100644 arch/powerpc/platforms/chrp/Kconfig
 create mode 100644 arch/powerpc/platforms/maple/Kconfig

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 479828d..c5014ba 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -404,77 +404,14 @@ config QUICC_ENGINE
 	  Selecting this option means that you wish to build a kernel
 	  for a machine with a QE coprocessor.

-config PPC_PSERIES
-	depends on PPC_MULTIPLATFORM && PPC64
-	bool "IBM pSeries & new (POWER5-based) iSeries"
-	select MPIC
-	select PPC_I8259
-	select PPC_RTAS
-	select RTAS_ERROR_LOGGING
-	select PPC_UDBG_16550
-	select PPC_NATIVE
-	default y
-
-config PPC_ISERIES
-	bool "IBM Legacy iSeries"
-	depends on PPC_MULTIPLATFORM && PPC64
-	select PPC_INDIRECT_IO
-
-config PPC_CHRP
-	bool "Common Hardware Reference Platform (CHRP) based machines"
-	depends on PPC_MULTIPLATFORM && PPC32
-	select MPIC
-	select PPC_I8259
-	select PPC_INDIRECT_PCI
-	select PPC_RTAS
-	select PPC_MPC106
-	select PPC_UDBG_16550
-	select PPC_NATIVE
-	default y
-
+source "arch/powerpc/platforms/pseries/Kconfig"
+source "arch/powerpc/platforms/iseries/Kconfig"
+source "arch/powerpc/platforms/chrp/Kconfig"
 source "arch/powerpc/platforms/52xx/Kconfig"
 source "arch/powerpc/platforms/powermac/Kconfig"
-
-config PPC_PREP
-	bool "PowerPC Reference Platform (PReP) based machines"
-	depends on PPC_MULTIPLATFORM && PPC32 && BROKEN
-	select MPIC
-	select PPC_I8259
-	select PPC_INDIRECT_PCI
-	select PPC_UDBG_16550
-	select PPC_NATIVE
-	default n
-
-config PPC_MAPLE
-	depends on PPC_MULTIPLATFORM && PPC64
-	bool "Maple 970FX Evaluation Board"
-	select MPIC
-	select U3_DART
-	select MPIC_BROKEN_U3
-	select GENERIC_TBSYNC
-	select PPC_UDBG_16550
-	select PPC_970_NAP
-	select PPC_NATIVE
-	select PPC_RTAS
-	select MMIO_NVRAM
-	select ATA_NONSTANDARD if ATA
-	default n
-	help
-          This option enables support for the Maple 970FX Evaluation Board.
-	  For more information, refer to <http://www.970eval.com>
-
-config PPC_PASEMI
-	depends on PPC_MULTIPLATFORM && PPC64
-	bool "PA Semi SoC-based platforms"
-	default n
-	select MPIC
-	select PPC_UDBG_16550
-	select GENERIC_TBSYNC
-	select PPC_NATIVE
-	help
-	  This option enables support for PA Semi's PWRficient line
-	  of SoC processors, including PA6T-1682M
-
+source "arch/powerpc/platforms/prep/Kconfig"
+source "arch/powerpc/platforms/maple/Kconfig"
+source "arch/powerpc/platforms/pasemi/Kconfig"
 source arch/powerpc/platforms/celleb/Kconfig
 source arch/powerpc/platforms/ps3/Kconfig
 source arch/powerpc/platforms/cell/Kconfig
@@ -657,7 +594,6 @@ source arch/powerpc/platforms/83xx/Kconfig
 source arch/powerpc/platforms/85xx/Kconfig
 source arch/powerpc/platforms/86xx/Kconfig
 source arch/powerpc/platforms/8xx/Kconfig
-source arch/powerpc/platforms/pasemi/Kconfig

 menu "Kernel options"

@@ -762,7 +698,6 @@ config IRQ_ALL_CPUS
 	  CPU.  Generally saying Y is safe, although some problems have been
 	  reported with SMP Power Macintoshes with this option enabled.

-source "arch/powerpc/platforms/pseries/Kconfig"

 config NUMA
 	bool "NUMA support"
@@ -834,8 +769,6 @@ config PROC_DEVICETREE
 	  an image of the device tree that the kernel copies from Open
 	  Firmware or other boot firmware. If unsure, say Y here.

-source "arch/powerpc/platforms/prep/Kconfig"
-
 config CMDLINE_BOOL
 	bool "Default bootloader kernel arguments"

@@ -1132,7 +1065,6 @@ source "fs/Kconfig"

 source "arch/powerpc/sysdev/qe_lib/Kconfig"

-source "arch/powerpc/platforms/iseries/Kconfig"

 source "lib/Kconfig"

diff --git a/arch/powerpc/platforms/chrp/Kconfig b/arch/powerpc/platforms/chrp/Kconfig
new file mode 100644
index 0000000..d2c6905
--- /dev/null
+++ b/arch/powerpc/platforms/chrp/Kconfig
@@ -0,0 +1,11 @@
+config PPC_CHRP
+	bool "Common Hardware Reference Platform (CHRP) based machines"
+	depends on PPC_MULTIPLATFORM && PPC32
+	select MPIC
+	select PPC_I8259
+	select PPC_INDIRECT_PCI
+	select PPC_RTAS
+	select PPC_MPC106
+	select PPC_UDBG_16550
+	select PPC_NATIVE
+	default y
diff --git a/arch/powerpc/platforms/iseries/Kconfig b/arch/powerpc/platforms/iseries/Kconfig
index 54e6b3b..46c3a8e 100644
--- a/arch/powerpc/platforms/iseries/Kconfig
+++ b/arch/powerpc/platforms/iseries/Kconfig
@@ -1,3 +1,7 @@
+config PPC_ISERIES
+	bool "IBM Legacy iSeries"
+	depends on PPC_MULTIPLATFORM && PPC64
+	select PPC_INDIRECT_IO

 menu "iSeries device drivers"
 	depends on PPC_ISERIES
diff --git a/arch/powerpc/platforms/maple/Kconfig b/arch/powerpc/platforms/maple/Kconfig
new file mode 100644
index 0000000..5f364b8
--- /dev/null
+++ b/arch/powerpc/platforms/maple/Kconfig
@@ -0,0 +1,17 @@
+config PPC_MAPLE
+	depends on PPC_MULTIPLATFORM && PPC64
+	bool "Maple 970FX Evaluation Board"
+	select MPIC
+	select U3_DART
+	select MPIC_BROKEN_U3
+	select GENERIC_TBSYNC
+	select PPC_UDBG_16550
+	select PPC_970_NAP
+	select PPC_NATIVE
+	select PPC_RTAS
+	select MMIO_NVRAM
+	select ATA_NONSTANDARD if ATA
+	default n
+	help
+          This option enables support for the Maple 970FX Evaluation Board.
+	  For more information, refer to <http://www.970eval.com>
diff --git a/arch/powerpc/platforms/pasemi/Kconfig b/arch/powerpc/platforms/pasemi/Kconfig
index 68dc529..64e5525 100644
--- a/arch/powerpc/platforms/pasemi/Kconfig
+++ b/arch/powerpc/platforms/pasemi/Kconfig
@@ -1,3 +1,15 @@
+config PPC_PASEMI
+	depends on PPC_MULTIPLATFORM && PPC64
+	bool "PA Semi SoC-based platforms"
+	default n
+	select MPIC
+	select PPC_UDBG_16550
+	select GENERIC_TBSYNC
+	select PPC_NATIVE
+	help
+	  This option enables support for PA Semi's PWRficient line
+	  of SoC processors, including PA6T-1682M
+
 menu "PA Semi PWRficient options"
 	depends on PPC_PASEMI

diff --git a/arch/powerpc/platforms/prep/Kconfig b/arch/powerpc/platforms/prep/Kconfig
index 673ac47..29d4112 100644
--- a/arch/powerpc/platforms/prep/Kconfig
+++ b/arch/powerpc/platforms/prep/Kconfig
@@ -1,3 +1,12 @@
+config PPC_PREP
+	bool "PowerPC Reference Platform (PReP) based machines"
+	depends on PPC_MULTIPLATFORM && PPC32 && BROKEN
+	select MPIC
+	select PPC_I8259
+	select PPC_INDIRECT_PCI
+	select PPC_UDBG_16550
+	select PPC_NATIVE
+	default n

 config PREP_RESIDUAL
 	bool "Support for PReP Residual Data"
diff --git a/arch/powerpc/platforms/pseries/Kconfig b/arch/powerpc/platforms/pseries/Kconfig
index a57032c..16e4e40 100644
--- a/arch/powerpc/platforms/pseries/Kconfig
+++ b/arch/powerpc/platforms/pseries/Kconfig
@@ -1,3 +1,13 @@
+config PPC_PSERIES
+	depends on PPC_MULTIPLATFORM && PPC64
+	bool "IBM pSeries & new (POWER5-based) iSeries"
+	select MPIC
+	select PPC_I8259
+	select PPC_RTAS
+	select RTAS_ERROR_LOGGING
+	select PPC_UDBG_16550
+	select PPC_NATIVE
+	default y

 config PPC_SPLPAR
 	depends on PPC_PSERIES
-- 
1.5.0.2
