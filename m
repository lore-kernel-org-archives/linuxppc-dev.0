Return-Path: <michael@ozlabs.org>
To: <linuxppc-dev@ozlabs.org>
Message-Id: <e9c405aaec255c2a3d34209fc35ae093fcae8efc.1236228043.git.michael@ellerman.id.au>
From: Michael Ellerman <michael@ellerman.id.au>
Subject: [PATCH] powerpc/cell: Only build Axon MSI driver for IBM Cell Blades
Date: Thu,  5 Mar 2009 15:41:41 +1100 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The hardware is only present on those machines, and the driver
depends on infrastructure which is selected by the Kconfig for
cell blades.

Reported-by: Mikey "Randconfig Monkey" Neuling
Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
---
 arch/powerpc/platforms/cell/Makefile |    2 ++
 1 files changed, 2 insertions(+), 0 deletions(-)

diff --git a/arch/powerpc/platforms/cell/Makefile b/arch/powerpc/platforms/cell/Makefile
index 43eccb2..9330cf8 100644
--- a/arch/powerpc/platforms/cell/Makefile
+++ b/arch/powerpc/platforms/cell/Makefile
@@ -28,7 +28,9 @@ obj-$(CONFIG_SPU_BASE)			+= spu_callbacks.o spu_base.o \
 					   $(spu-manage-y) \
 					   spufs/
 
+ifeq ($(CONFIG_PPC_IBM_CELL_BLADE),y)
 obj-$(CONFIG_PCI_MSI)			+= axon_msi.o
+endif
 
 # qpace setup
 obj-$(CONFIG_PPC_CELL_QPACE)		+= qpace_setup.o
-- 
1.5.6.3
