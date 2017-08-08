Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3xRPrm4rstzDqp9
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  8 Aug 2017 16:39:36 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: linuxppc-dev@ozlabs.org
Subject: [PATCH 4/9] powerpc/4xx: Create 4xx pseudo-platform in platforms/4xx
Date: Tue,  8 Aug 2017 16:39:20 +1000
Message-Id: <1502174365-8293-4-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1502174365-8293-1-git-send-email-mpe@ellerman.id.au>
References: <1502174365-8293-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

We have a lot of code in sysdev for supporting 4xx, ie. either 40x or
44x. Instead it would be cleaner if it was all in platforms/4xx.

This is slightly odd in that we don't actually define any machines in
the 4xx platform, as is usual for a platform directory. But still it
seems like a better result to have all this related code in a directory
by itself.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/platforms/4xx/Makefile                            |  8 ++++++++
 arch/powerpc/{sysdev/ppc4xx_cpm.c => platforms/4xx/cpm.c}      |  0
 arch/powerpc/{sysdev/ppc4xx_gpio.c => platforms/4xx/gpio.c}    |  0
 .../{sysdev/ppc4xx_hsta_msi.c => platforms/4xx/hsta_msi.c}     |  0
 arch/powerpc/{sysdev/ppc4xx_msi.c => platforms/4xx/msi.c}      |  0
 arch/powerpc/{sysdev/ppc4xx_ocm.c => platforms/4xx/ocm.c}      |  0
 arch/powerpc/{sysdev/ppc4xx_pci.c => platforms/4xx/pci.c}      |  2 +-
 arch/powerpc/{sysdev/ppc4xx_pci.h => platforms/4xx/pci.h}      |  0
 arch/powerpc/{sysdev/ppc4xx_soc.c => platforms/4xx/soc.c}      |  0
 arch/powerpc/{sysdev => platforms/4xx}/uic.c                   |  0
 arch/powerpc/platforms/Makefile                                |  1 +
 arch/powerpc/sysdev/Makefile                                   | 10 ----------
 12 files changed, 10 insertions(+), 11 deletions(-)
 create mode 100644 arch/powerpc/platforms/4xx/Makefile
 rename arch/powerpc/{sysdev/ppc4xx_cpm.c => platforms/4xx/cpm.c} (100%)
 rename arch/powerpc/{sysdev/ppc4xx_gpio.c => platforms/4xx/gpio.c} (100%)
 rename arch/powerpc/{sysdev/ppc4xx_hsta_msi.c => platforms/4xx/hsta_msi.c} (100%)
 rename arch/powerpc/{sysdev/ppc4xx_msi.c => platforms/4xx/msi.c} (100%)
 rename arch/powerpc/{sysdev/ppc4xx_ocm.c => platforms/4xx/ocm.c} (100%)
 rename arch/powerpc/{sysdev/ppc4xx_pci.c => platforms/4xx/pci.c} (99%)
 rename arch/powerpc/{sysdev/ppc4xx_pci.h => platforms/4xx/pci.h} (100%)
 rename arch/powerpc/{sysdev/ppc4xx_soc.c => platforms/4xx/soc.c} (100%)
 rename arch/powerpc/{sysdev => platforms/4xx}/uic.c (100%)

diff --git a/arch/powerpc/platforms/4xx/Makefile b/arch/powerpc/platforms/4xx/Makefile
new file mode 100644
index 000000000000..0d4b65c88d66
--- /dev/null
+++ b/arch/powerpc/platforms/4xx/Makefile
@@ -0,0 +1,8 @@
+obj-y				+= uic.o
+obj-$(CONFIG_PPC4xx_OCM)	+= ocm.o
+obj-$(CONFIG_4xx_SOC)		+= soc.o
+obj-$(CONFIG_PCI)		+= pci.o
+obj-$(CONFIG_PPC4xx_HSTA_MSI)	+= hsta_msi.o
+obj-$(CONFIG_PPC4xx_MSI)	+= msi.o
+obj-$(CONFIG_PPC4xx_CPM)	+= cpm.o
+obj-$(CONFIG_PPC4xx_GPIO)	+= gpio.o
diff --git a/arch/powerpc/sysdev/ppc4xx_cpm.c b/arch/powerpc/platforms/4xx/cpm.c
similarity index 100%
rename from arch/powerpc/sysdev/ppc4xx_cpm.c
rename to arch/powerpc/platforms/4xx/cpm.c
diff --git a/arch/powerpc/sysdev/ppc4xx_gpio.c b/arch/powerpc/platforms/4xx/gpio.c
similarity index 100%
rename from arch/powerpc/sysdev/ppc4xx_gpio.c
rename to arch/powerpc/platforms/4xx/gpio.c
diff --git a/arch/powerpc/sysdev/ppc4xx_hsta_msi.c b/arch/powerpc/platforms/4xx/hsta_msi.c
similarity index 100%
rename from arch/powerpc/sysdev/ppc4xx_hsta_msi.c
rename to arch/powerpc/platforms/4xx/hsta_msi.c
diff --git a/arch/powerpc/sysdev/ppc4xx_msi.c b/arch/powerpc/platforms/4xx/msi.c
similarity index 100%
rename from arch/powerpc/sysdev/ppc4xx_msi.c
rename to arch/powerpc/platforms/4xx/msi.c
diff --git a/arch/powerpc/sysdev/ppc4xx_ocm.c b/arch/powerpc/platforms/4xx/ocm.c
similarity index 100%
rename from arch/powerpc/sysdev/ppc4xx_ocm.c
rename to arch/powerpc/platforms/4xx/ocm.c
diff --git a/arch/powerpc/sysdev/ppc4xx_pci.c b/arch/powerpc/platforms/4xx/pci.c
similarity index 99%
rename from arch/powerpc/sysdev/ppc4xx_pci.c
rename to arch/powerpc/platforms/4xx/pci.c
index 086aca69ecae..6713edc93a55 100644
--- a/arch/powerpc/sysdev/ppc4xx_pci.c
+++ b/arch/powerpc/platforms/4xx/pci.c
@@ -32,7 +32,7 @@
 #include <asm/dcr-regs.h>
 #include <mm/mmu_decl.h>
 
-#include "ppc4xx_pci.h"
+#include "pci.h"
 
 static int dma_offset_set;
 
diff --git a/arch/powerpc/sysdev/ppc4xx_pci.h b/arch/powerpc/platforms/4xx/pci.h
similarity index 100%
rename from arch/powerpc/sysdev/ppc4xx_pci.h
rename to arch/powerpc/platforms/4xx/pci.h
diff --git a/arch/powerpc/sysdev/ppc4xx_soc.c b/arch/powerpc/platforms/4xx/soc.c
similarity index 100%
rename from arch/powerpc/sysdev/ppc4xx_soc.c
rename to arch/powerpc/platforms/4xx/soc.c
diff --git a/arch/powerpc/sysdev/uic.c b/arch/powerpc/platforms/4xx/uic.c
similarity index 100%
rename from arch/powerpc/sysdev/uic.c
rename to arch/powerpc/platforms/4xx/uic.c
diff --git a/arch/powerpc/platforms/Makefile b/arch/powerpc/platforms/Makefile
index 469ef170d218..d7a55ecfaee5 100644
--- a/arch/powerpc/platforms/Makefile
+++ b/arch/powerpc/platforms/Makefile
@@ -5,6 +5,7 @@ obj-$(CONFIG_FSL_ULI1575)	+= fsl_uli1575.o
 
 obj-$(CONFIG_PPC_PMAC)		+= powermac/
 obj-$(CONFIG_PPC_CHRP)		+= chrp/
+obj-$(CONFIG_4xx)		+= 4xx/
 obj-$(CONFIG_40x)		+= 40x/
 obj-$(CONFIG_44x)		+= 44x/
 obj-$(CONFIG_PPC_MPC512x)	+= 512x/
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index c0ae11d4f62f..9e70421ad323 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -36,19 +36,9 @@ obj-$(CONFIG_AXON_RAM)		+= axonram.o
 obj-$(CONFIG_PPC_INDIRECT_PCI)	+= indirect_pci.o
 obj-$(CONFIG_PPC_I8259)		+= i8259.o
 obj-$(CONFIG_IPIC)		+= ipic.o
-obj-$(CONFIG_4xx)		+= uic.o
-obj-$(CONFIG_PPC4xx_OCM)	+= ppc4xx_ocm.o
-obj-$(CONFIG_4xx_SOC)		+= ppc4xx_soc.o
 obj-$(CONFIG_XILINX_VIRTEX)	+= xilinx_intc.o
 obj-$(CONFIG_XILINX_PCI)	+= xilinx_pci.o
 obj-$(CONFIG_OF_RTC)		+= of_rtc.o
-ifeq ($(CONFIG_PCI),y)
-obj-$(CONFIG_4xx)		+= ppc4xx_pci.o
-endif
-obj-$(CONFIG_PPC4xx_HSTA_MSI)	+= ppc4xx_hsta_msi.o
-obj-$(CONFIG_PPC4xx_MSI)	+= ppc4xx_msi.o
-obj-$(CONFIG_PPC4xx_CPM)	+= ppc4xx_cpm.o
-obj-$(CONFIG_PPC4xx_GPIO)	+= ppc4xx_gpio.o
 
 obj-$(CONFIG_CPM)		+= cpm_common.o
 obj-$(CONFIG_CPM2)		+= cpm2.o cpm2_pic.o
-- 
2.7.4
