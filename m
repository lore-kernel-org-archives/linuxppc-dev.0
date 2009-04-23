Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <555d4c966e99cc1420bbca440b38c8f14ae8677e.1240447361.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc/cell: CELL_NATIVE should select PCI
Date: Thu, 23 Apr 2009 10:43:26 +1000 (EST)
Cc: subrata@linux.vnet.ibm.com, Arnd Bergmann <arnd.bergmann@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Because it selects PPC_OF_PLATFORM_PCI which depends on PCI, so
if we don't select PCI we can end up with PCI=n and
PPC_OF_PLATFORM_PCI=y which doesn't build.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/Kconfig |    1 +
 1 files changed, 1 insertions(+), 0 deletions(-)


For the IBM Cell blades I don't see much point building without PCI
because the on board ethernet is on PCI-X IIRC.

I'm not sure about Celleb.

diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index 40e24c3..33f534f 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -14,6 +14,7 @@ config PPC_CELL_NATIVE
 	bool
 	select PPC_CELL_COMMON
 	select PPC_OF_PLATFORM_PCI
+	select PCI
 	select MPIC
 	select IBM_NEW_EMAC_EMAC4
 	select IBM_NEW_EMAC_RGMII
-- 
1.6.2.1
