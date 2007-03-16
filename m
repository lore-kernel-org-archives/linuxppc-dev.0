Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 44CC0DDEDA
	for <linuxppc-dev@ozlabs.org>; Sat, 17 Mar 2007 02:26:56 +1100 (EST)
Received: from [72.183.106.80] (helo=[192.168.1.2])
	by nommos.sslcatacombnetworking.com with esmtpsa (TLSv1:AES256-SHA:256)
	(Exim 4.63) (envelope-from <galak@kernel.crashing.org>)
	id 1HSEKS-00084w-JM
	for linuxppc-dev@ozlabs.org; Fri, 16 Mar 2007 10:26:52 -0500
Date: Fri, 16 Mar 2007 10:23:34 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH][POWERPC] [003/006] Split cell platforms into their respective
	Kconfig file
In-Reply-To: <Pine.LNX.4.64.0703161016520.9740@localhost.localdomain>
Message-ID: <Pine.LNX.4.64.0703161022590.9740@localhost.localdomain>
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

Cleaning up arch/powerpc/Kconfig platform support.

Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
---
 arch/powerpc/Kconfig                  |   53 ++-------------------------------
 arch/powerpc/platforms/cell/Kconfig   |   23 ++++++++++++++
 arch/powerpc/platforms/celleb/Kconfig |    9 +++++
 arch/powerpc/platforms/ps3/Kconfig    |   16 ++++++++++
 4 files changed, 51 insertions(+), 50 deletions(-)
 create mode 100644 arch/powerpc/platforms/celleb/Kconfig

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ecc4302..479828d 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -475,54 +475,9 @@ config PPC_PASEMI
 	  This option enables support for PA Semi's PWRficient line
 	  of SoC processors, including PA6T-1682M

-config PPC_CELL
-	bool
-	default n
-
-config PPC_CELL_NATIVE
-	bool
-	select PPC_CELL
-	select PPC_DCR_MMIO
-	select PPC_OF_PLATFORM_PCI
-	select PPC_INDIRECT_IO
-	select PPC_NATIVE
-	select MPIC
-	default n
-
-config PPC_IBM_CELL_BLADE
-	bool "IBM Cell Blade"
-	depends on PPC_MULTIPLATFORM && PPC64
-	select PPC_CELL_NATIVE
-	select PPC_RTAS
-	select MMIO_NVRAM
-	select PPC_UDBG_16550
-	select UDBG_RTAS_CONSOLE
-
-config PPC_PS3
-	bool "Sony PS3 (incomplete)"
-	depends on PPC_MULTIPLATFORM && PPC64
-	select PPC_CELL
-	select USB_ARCH_HAS_OHCI
-	select USB_OHCI_LITTLE_ENDIAN
-	select USB_OHCI_BIG_ENDIAN_MMIO
-	select USB_ARCH_HAS_EHCI
-	select USB_EHCI_BIG_ENDIAN_MMIO
-	help
-	  This option enables support for the Sony PS3 game console
-	  and other platforms using the PS3 hypervisor.
-	  Support for this platform is not yet complete, so
-	  enabling this will not result in a bootable kernel on a
-	  PS3 system.
-
-config PPC_CELLEB
-	bool "Toshiba's Cell Reference Set 'Celleb' Architecture"
-	depends on PPC_MULTIPLATFORM && PPC64
-	select PPC_CELL
-	select PPC_OF_PLATFORM_PCI
-	select HAS_TXX9_SERIAL
-	select PPC_UDBG_BEAT
-	select USB_OHCI_BIG_ENDIAN_MMIO
-	select USB_EHCI_BIG_ENDIAN_MMIO
+source arch/powerpc/platforms/celleb/Kconfig
+source arch/powerpc/platforms/ps3/Kconfig
+source arch/powerpc/platforms/cell/Kconfig

 config PPC_NATIVE
 	bool
@@ -702,8 +657,6 @@ source arch/powerpc/platforms/83xx/Kconfig
 source arch/powerpc/platforms/85xx/Kconfig
 source arch/powerpc/platforms/86xx/Kconfig
 source arch/powerpc/platforms/8xx/Kconfig
-source arch/powerpc/platforms/cell/Kconfig
-source arch/powerpc/platforms/ps3/Kconfig
 source arch/powerpc/platforms/pasemi/Kconfig

 menu "Kernel options"
diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index 06a85b7..53913a2 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -1,3 +1,26 @@
+config PPC_CELL
+	bool
+	default n
+
+config PPC_CELL_NATIVE
+	bool
+	select PPC_CELL
+	select PPC_DCR_MMIO
+	select PPC_OF_PLATFORM_PCI
+	select PPC_INDIRECT_IO
+	select PPC_NATIVE
+	select MPIC
+	default n
+
+config PPC_IBM_CELL_BLADE
+	bool "IBM Cell Blade"
+	depends on PPC_MULTIPLATFORM && PPC64
+	select PPC_CELL_NATIVE
+	select PPC_RTAS
+	select MMIO_NVRAM
+	select PPC_UDBG_16550
+	select UDBG_RTAS_CONSOLE
+
 menu "Cell Broadband Engine options"
 	depends on PPC_CELL

diff --git a/arch/powerpc/platforms/celleb/Kconfig b/arch/powerpc/platforms/celleb/Kconfig
new file mode 100644
index 0000000..2db1e29
--- /dev/null
+++ b/arch/powerpc/platforms/celleb/Kconfig
@@ -0,0 +1,9 @@
+config PPC_CELLEB
+	bool "Toshiba's Cell Reference Set 'Celleb' Architecture"
+	depends on PPC_MULTIPLATFORM && PPC64
+	select PPC_CELL
+	select PPC_OF_PLATFORM_PCI
+	select HAS_TXX9_SERIAL
+	select PPC_UDBG_BEAT
+	select USB_OHCI_BIG_ENDIAN_MMIO
+	select USB_EHCI_BIG_ENDIAN_MMIO
diff --git a/arch/powerpc/platforms/ps3/Kconfig b/arch/powerpc/platforms/ps3/Kconfig
index 1a481a6..40f0008 100644
--- a/arch/powerpc/platforms/ps3/Kconfig
+++ b/arch/powerpc/platforms/ps3/Kconfig
@@ -1,3 +1,19 @@
+config PPC_PS3
+	bool "Sony PS3 (incomplete)"
+	depends on PPC_MULTIPLATFORM && PPC64
+	select PPC_CELL
+	select USB_ARCH_HAS_OHCI
+	select USB_OHCI_LITTLE_ENDIAN
+	select USB_OHCI_BIG_ENDIAN_MMIO
+	select USB_ARCH_HAS_EHCI
+	select USB_EHCI_BIG_ENDIAN_MMIO
+	help
+	  This option enables support for the Sony PS3 game console
+	  and other platforms using the PS3 hypervisor.
+	  Support for this platform is not yet complete, so
+	  enabling this will not result in a bootable kernel on a
+	  PS3 system.
+
 menu "PS3 Platform Options"
 	depends on PPC_PS3

-- 
1.5.0.2
