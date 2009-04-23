Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <cf386cee8d45e3aac21cfc8af3dc17c5335c516b.1240476177.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc/cell: Select PCI for IBM_CELL_BLADE AND CELLEB
Date: Thu, 23 Apr 2009 18:43:03 +1000 (EST)
Cc: Geert.Uytterhoeven@sonycom.com, randy.dunlap@oracle.com,
	subrata@linux.vnet.ibm.com, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Currently PPC_CELL_NATIVE selects PPC_OF_PLATFORM_PCI, but does not
select PCI. This can lead to a config with the former and the latter
disabled, which does not build.

To fix this PPC_CELL_NATIVE should select PCI. However, that would
force PCI on for QPACE, which also selects PPC_CELL_NATIVE. So
instead move the select of PPC_OF_PLATFORM_PCI and PCI under both
IBM_CELL_BLADE and CELLEB.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/Kconfig |    5 ++++-
 1 files changed, 4 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index 40e24c3..50f17bd 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -13,7 +13,6 @@ config PPC_CELL_COMMON
 config PPC_CELL_NATIVE
 	bool
 	select PPC_CELL_COMMON
-	select PPC_OF_PLATFORM_PCI
 	select MPIC
 	select IBM_NEW_EMAC_EMAC4
 	select IBM_NEW_EMAC_RGMII
@@ -25,6 +24,8 @@ config PPC_IBM_CELL_BLADE
 	bool "IBM Cell Blade"
 	depends on PPC64 && PPC_BOOK3S
 	select PPC_CELL_NATIVE
+	select PPC_OF_PLATFORM_PCI
+	select PCI
 	select MMIO_NVRAM
 	select PPC_UDBG_16550
 	select UDBG_RTAS_CONSOLE
@@ -33,6 +34,8 @@ config PPC_CELLEB
 	bool "Toshiba's Cell Reference Set 'Celleb' Architecture"
 	depends on PPC64 && PPC_BOOK3S
 	select PPC_CELL_NATIVE
+	select PPC_OF_PLATFORM_PCI
+	select PCI
 	select HAS_TXX9_SERIAL
 	select PPC_UDBG_BEAT
 	select USB_OHCI_BIG_ENDIAN_MMIO
-- 
1.6.2.1
