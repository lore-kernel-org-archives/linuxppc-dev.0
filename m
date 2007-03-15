Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E4D43DDDF4
	for <linuxppc-dev@ozlabs.org>; Fri, 16 Mar 2007 10:37:49 +1100 (EST)
Date: Thu, 15 Mar 2007 18:34:25 -0500 (CDT)
From: Kumar Gala <galak@kernel.crashing.org>
To: linuxppc-dev@ozlabs.org
Subject: RFC: arch/powerpc Kconfig cleanup
Message-ID: <Pine.LNX.4.64.0703151816370.3448@localhost.localdomain>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Olof Johansson <olof@lixom.net>, Paul Mackerras <paulus@samba.org>,
	Arnd Bergmann <arnd@arndb.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

arch/powerpc/Kconfig has become something of a mess and platform support
is scattered between it and various arch/powerpc/platforms/*/Kconfig
files.  I've got some ideas on some simple clean up that will introduce a
arch/powerpc/platforms/Kconfig and pull out platform config information
from arch/powerpc/Kconfig.

Beyond general cleanup, there are several config options that should
exist under the "Platform support" menu but end up getting duplicated
across sub-architectures (QE, CPM2, etc.)

By introducing a platforms/Kconfig we will have a place to put those
config options so we don't have to duplicate them.

One think I noticed is that various platforms/*/Kconfig create top level
menu choices for things like:

Cell Broadband Engine options
PS3 Platform Options
PA Semi PWRficient options
iSeries device drivers
Machine Type (for embedded 6xx)

I didn't know if people were ok with having these move under the 'Platform
support' menu or would prefer they stay as top level menu choices.  Here's
a work up of a patch for Cell that moves things around and puts the 'Cell
Broarband Engine options' under 'Platform support'.

- k

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index ecc4302..26b4053 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -475,54 +475,7 @@ config PPC_PASEMI
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
+source arch/powerpc/platforms/cell/Kconfig

 config PPC_NATIVE
 	bool
diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index 06a85b7..ea43542 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -1,3 +1,52 @@
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
+config PPC_CELLEB
+	bool "Toshiba's Cell Reference Set 'Celleb' Architecture"
+	depends on PPC_MULTIPLATFORM && PPC64
+	select PPC_CELL
+	select PPC_OF_PLATFORM_PCI
+	select HAS_TXX9_SERIAL
+	select PPC_UDBG_BEAT
+	select USB_OHCI_BIG_ENDIAN_MMIO
+	select USB_EHCI_BIG_ENDIAN_MMIO
+
 menu "Cell Broadband Engine options"
 	depends on PPC_CELL
