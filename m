Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <bcf5077b7f9cca219a8c420858c9696631aab73b.1236310624.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc/cell: Fix Axon MSI driver dependencies
Date: Fri,  6 Mar 2009 14:37:11 +1100 (EST)
Cc: Olof Johannsson <olof@lixom.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The Axon MSI driver depends on more than just PCI_MSI, so add a
Kconfig fragment for it. Fixes randconfig build failures.

Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/Kconfig  |    5 +++++
 arch/powerpc/platforms/cell/Makefile |    2 +-
 2 files changed, 6 insertions(+), 1 deletions(-)

diff --git a/arch/powerpc/platforms/cell/Kconfig b/arch/powerpc/platforms/cell/Kconfig
index 037f59a..17b9b19 100644
--- a/arch/powerpc/platforms/cell/Kconfig
+++ b/arch/powerpc/platforms/cell/Kconfig
@@ -43,6 +43,11 @@ config PPC_CELL_QPACE
 	depends on PPC_MULTIPLATFORM && PPC64
 	select PPC_CELL_COMMON
 
+config AXON_MSI
+	bool
+	depends on PPC_IBM_CELL_BLADE && PCI_MSI
+	default y
+
 menu "Cell Broadband Engine options"
 	depends on PPC_CELL
 
diff --git a/arch/powerpc/platforms/cell/Makefile b/arch/powerpc/platforms/cell/Makefile
index 43eccb2..83fafe9 100644
--- a/arch/powerpc/platforms/cell/Makefile
+++ b/arch/powerpc/platforms/cell/Makefile
@@ -28,7 +28,7 @@ obj-$(CONFIG_SPU_BASE)			+= spu_callbacks.o spu_base.o \
 					   $(spu-manage-y) \
 					   spufs/
 
-obj-$(CONFIG_PCI_MSI)			+= axon_msi.o
+obj-$(CONFIG_AXON_MSI)			+= axon_msi.o
 
 # qpace setup
 obj-$(CONFIG_PPC_CELL_QPACE)		+= qpace_setup.o
-- 
1.6.1.2
