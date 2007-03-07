Return-Path: <jdl@freescale.com>
Received: from de01egw01.freescale.net (de01egw01.freescale.net
	[192.88.165.102]) by ozlabs.org (Postfix) with ESMTP id 80541DDF34
	for <linuxppc-dev@ozlabs.org>; Thu,  8 Mar 2007 07:48:49 +1100 (EST)
Received: from de01smr01.freescale.net (de01smr01.freescale.net [10.208.0.31])
	by de01egw01.freescale.net (8.12.11/de01egw01) with ESMTP id
	l27Kmj7q016563
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 13:48:46 -0700 (MST)
Received: from ld0161-tx32 (ld0161-tx32.am.freescale.net [10.82.19.111])
	by de01smr01.freescale.net (8.13.1/8.13.0) with ESMTP id l27KmjIV025244
	for <linuxppc-dev@ozlabs.org>; Wed, 7 Mar 2007 14:48:45 -0600 (CST)
Subject: [PATCH] Move 8641 PCI-Express to arch/powerpc/sysdev/fsl_pcie.c.
From: Jon Loeliger <jdl@freescale.com>
To: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
Content-Type: text/plain
Message-Id: <1173300525.23776.136.camel@ld0161-tx32>
Mime-Version: 1.0
Date: Wed, 07 Mar 2007 14:48:45 -0600
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


This move sets the stage for the use of generic PCI Express
code in 85xx and 86xx parts from FSL.  Subsequent patches
for 8548 and 8544 will be able to use this shared code.

Signed-off-by: Jon Loeliger <jdl@freescale.com>
Acked-by: Andy Fleming <afleming@freescale.com>
---
 arch/powerpc/Kconfig                               |    5 +++++
 arch/powerpc/platforms/86xx/Makefile               |    2 +-
 arch/powerpc/sysdev/Makefile                       |    1 +
 .../86xx/mpc86xx_pcie.c => sysdev/fsl_pcie.c}      |    2 --
 4 files changed, 7 insertions(+), 3 deletions(-)
 rename arch/powerpc/{platforms/86xx/mpc86xx_pcie.c => sysdev/fsl_pcie.c} (100%)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index 6dfbd52..f68de20 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -168,6 +168,7 @@ config PPC_86xx
 	bool "Freescale 86xx"
 	select 6xx
 	select FSL_SOC
+	select FSL_PCIE
 	select PPC_FPU
 	select ALTIVEC
 	help
@@ -1022,6 +1023,10 @@ config SBUS
 config FSL_SOC
 	bool
 
+config FSL_PCIE
+	bool
+	depends on PPC_86xx
+
 # Yes MCA RS/6000s exist but Linux-PPC does not currently support any
 config MCA
 	bool
diff --git a/arch/powerpc/platforms/86xx/Makefile b/arch/powerpc/platforms/86xx/Makefile
index 476a6ee..418fd8f 100644
--- a/arch/powerpc/platforms/86xx/Makefile
+++ b/arch/powerpc/platforms/86xx/Makefile
@@ -4,4 +4,4 @@
 
 obj-$(CONFIG_SMP)		+= mpc86xx_smp.o
 obj-$(CONFIG_MPC8641_HPCN)	+= mpc86xx_hpcn.o
-obj-$(CONFIG_PCI)		+= pci.o mpc86xx_pcie.o
+obj-$(CONFIG_PCI)		+= pci.o
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index 26ca3ff..86fc8c0 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -11,6 +11,7 @@ obj-$(CONFIG_PPC_PMI)		+= pmi.o
 obj-$(CONFIG_U3_DART)		+= dart_iommu.o
 obj-$(CONFIG_MMIO_NVRAM)	+= mmio_nvram.o
 obj-$(CONFIG_FSL_SOC)		+= fsl_soc.o
+obj-$(CONFIG_FSL_PCIE)		+= fsl_pcie.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
 obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
 
diff --git a/arch/powerpc/platforms/86xx/mpc86xx_pcie.c b/arch/powerpc/sysdev/fsl_pcie.c
similarity index 100%
rename from arch/powerpc/platforms/86xx/mpc86xx_pcie.c
rename to arch/powerpc/sysdev/fsl_pcie.c
index a2f4f73..041c07e 100644
--- a/arch/powerpc/platforms/86xx/mpc86xx_pcie.c
+++ b/arch/powerpc/sysdev/fsl_pcie.c
@@ -24,8 +24,6 @@
 #include <asm/pci-bridge.h>
 #include <asm/machdep.h>
 
-#include "mpc86xx.h"
-
 #define PCI_CFG_OUT out_be32
 
 /* ERRATA PCI-Ex 14 PCIE Controller timeout */
-- 
1.5.0.1.213.g509b
