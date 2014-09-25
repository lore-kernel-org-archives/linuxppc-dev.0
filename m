Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0130.outbound.protection.outlook.com [157.56.110.130])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A53F71A0194
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 25 Sep 2014 12:47:47 +1000 (EST)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <linux-kernel@vger.kernel.org>,
 <B07421@freescale.com>
Subject: [PATCH 3/3] rheap: move rheap.c from arch/powerpc/lib/ to lib/
Date: Thu, 25 Sep 2014 10:47:17 +0800
Message-ID: <1411613237-2271-2-git-send-email-B45475@freescale.com>
In-Reply-To: <1411613237-2271-1-git-send-email-B45475@freescale.com>
References: <1411613237-2271-1-git-send-email-B45475@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Zhao Qiang <B45475@freescale.com>, R63061@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

qe need to use the rheap, so move it to public directory.

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
 arch/powerpc/Kconfig                                    | 3 ---
 arch/powerpc/include/asm/fsl_85xx_cache_sram.h          | 2 +-
 arch/powerpc/lib/Makefile                               | 2 --
 arch/powerpc/platforms/44x/Kconfig                      | 2 +-
 arch/powerpc/platforms/85xx/Kconfig                     | 2 +-
 arch/powerpc/platforms/Kconfig                          | 2 +-
 arch/powerpc/platforms/Kconfig.cputype                  | 2 +-
 arch/powerpc/sysdev/cpm1.c                              | 2 +-
 arch/powerpc/sysdev/cpm2.c                              | 2 +-
 arch/powerpc/sysdev/cpm_common.c                        | 2 +-
 arch/powerpc/sysdev/ppc4xx_ocm.c                        | 2 +-
 drivers/dma/bestcomm/Kconfig                            | 2 +-
 drivers/soc/qe/Kconfig                                  | 2 +-
 drivers/soc/qe/qe.c                                     | 2 +-
 drivers/soc/qe/qe_common.c                              | 2 +-
 drivers/video/Kconfig                                   | 2 +-
 include/linux/fsl/bestcomm/sram.h                       | 2 +-
 {arch/powerpc/include/asm => include/linux/fsl}/rheap.h | 0
 lib/Kconfig                                             | 3 +++
 lib/Makefile                                            | 2 ++
 {arch/powerpc/lib => lib}/rheap.c                       | 2 +-
 21 files changed, 21 insertions(+), 21 deletions(-)
 rename {arch/powerpc/include/asm => include/linux/fsl}/rheap.h (100%)
 rename {arch/powerpc/lib => lib}/rheap.c (99%)

diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index d20dc2b..18b658e 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1046,7 +1046,4 @@ config PPC_CLOCK
 	default n
 	select HAVE_CLK
 
-config PPC_LIB_RHEAP
-	bool
-
 source "arch/powerpc/kvm/Kconfig"
diff --git a/arch/powerpc/include/asm/fsl_85xx_cache_sram.h b/arch/powerpc/include/asm/fsl_85xx_cache_sram.h
index 2af2bdc..e57888a 100644
--- a/arch/powerpc/include/asm/fsl_85xx_cache_sram.h
+++ b/arch/powerpc/include/asm/fsl_85xx_cache_sram.h
@@ -26,7 +26,7 @@
 #ifndef __ASM_POWERPC_FSL_85XX_CACHE_SRAM_H__
 #define __ASM_POWERPC_FSL_85XX_CACHE_SRAM_H__
 
-#include <asm/rheap.h>
+#include <linux/fsl/rheap.h>
 #include <linux/spinlock.h>
 
 /*
diff --git a/arch/powerpc/lib/Makefile b/arch/powerpc/lib/Makefile
index 4504332..c7b4e2f 100644
--- a/arch/powerpc/lib/Makefile
+++ b/arch/powerpc/lib/Makefile
@@ -26,8 +26,6 @@ obj-$(CONFIG_SMP)	+= locks.o
 obj-$(CONFIG_ALTIVEC)	+= vmx-helper.o
 endif
 
-obj-$(CONFIG_PPC_LIB_RHEAP) += rheap.o
-
 obj-y			+= code-patching.o
 obj-y			+= feature-fixups.o
 obj-$(CONFIG_FTR_FIXUP_SELFTEST) += feature-fixups-test.o
diff --git a/arch/powerpc/platforms/44x/Kconfig b/arch/powerpc/platforms/44x/Kconfig
index d6c7506..0ea1aee 100644
--- a/arch/powerpc/platforms/44x/Kconfig
+++ b/arch/powerpc/platforms/44x/Kconfig
@@ -254,7 +254,7 @@ config PPC4xx_GPIO
 config PPC4xx_OCM
 	bool "PPC4xx On Chip Memory (OCM) support"
 	depends on 4xx
-	select PPC_LIB_RHEAP
+	select LIB_RHEAP
 	help
 	  Enable OCM support for PowerPC 4xx platforms with on chip memory,
 	  OCM provides the fast place for memory access to improve performance.
diff --git a/arch/powerpc/platforms/85xx/Kconfig b/arch/powerpc/platforms/85xx/Kconfig
index ae9fdb51..ab4777a 100644
--- a/arch/powerpc/platforms/85xx/Kconfig
+++ b/arch/powerpc/platforms/85xx/Kconfig
@@ -19,7 +19,7 @@ if PPC32
 
 config FSL_85XX_CACHE_SRAM
 	bool "Freescale l2cache sram support"
-	select PPC_LIB_RHEAP
+	select LIB_RHEAP
 	help
 	  When selected, this option enables cache-sram support
 	  for memory allocation on P1/P2 QorIQ platforms.
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index d09ae32f..9c38a8d 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -282,7 +282,7 @@ config CPM2
 	bool "Enable support for the CPM2 (Communications Processor Module)"
 	depends on (FSL_SOC_BOOKE && PPC32) || 8260
 	select CPM
-	select PPC_LIB_RHEAP
+	select LIB_RHEAP
 	select PPC_PCI_CHOICE
 	select ARCH_REQUIRE_GPIOLIB
 	help
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index c9ef8a5..d68d19e 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -33,7 +33,7 @@ config PPC_8xx
 	bool "Freescale 8xx"
 	select FSL_SOC
 	select 8xx
-	select PPC_LIB_RHEAP
+	select LIB_RHEAP
 
 config 40x
 	bool "AMCC 40x"
diff --git a/arch/powerpc/sysdev/cpm1.c b/arch/powerpc/sysdev/cpm1.c
index 5e6ff38..c6f5762 100644
--- a/arch/powerpc/sysdev/cpm1.c
+++ b/arch/powerpc/sysdev/cpm1.c
@@ -38,7 +38,7 @@
 #include <asm/cpm1.h>
 #include <asm/io.h>
 #include <asm/tlbflush.h>
-#include <asm/rheap.h>
+#include <linux/fsl/rheap.h>
 #include <asm/prom.h>
 #include <asm/cpm.h>
 
diff --git a/arch/powerpc/sysdev/cpm2.c b/arch/powerpc/sysdev/cpm2.c
index 8dc1e24..5a63d35 100644
--- a/arch/powerpc/sysdev/cpm2.c
+++ b/arch/powerpc/sysdev/cpm2.c
@@ -41,7 +41,7 @@
 #include <asm/page.h>
 #include <asm/pgtable.h>
 #include <asm/cpm2.h>
-#include <asm/rheap.h>
+#include <linux/fsl/rheap.h>
 #include <asm/fs_pd.h>
 
 #include <sysdev/fsl_soc.h>
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index 4dd5341..98cac81 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -26,7 +26,7 @@
 
 #include <asm/udbg.h>
 #include <asm/io.h>
-#include <asm/rheap.h>
+#include <linux/fsl/rheap.h>
 #include <asm/cpm.h>
 
 #include <mm/mmu_decl.h>
diff --git a/arch/powerpc/sysdev/ppc4xx_ocm.c b/arch/powerpc/sysdev/ppc4xx_ocm.c
index 1b15f93..c6a1561 100644
--- a/arch/powerpc/sysdev/ppc4xx_ocm.c
+++ b/arch/powerpc/sysdev/ppc4xx_ocm.c
@@ -26,7 +26,7 @@
 #include <linux/kernel.h>
 #include <linux/dma-mapping.h>
 #include <linux/of.h>
-#include <asm/rheap.h>
+#include <linux/fsl/rheap.h>
 #include <asm/ppc4xx_ocm.h>
 #include <linux/slab.h>
 #include <linux/debugfs.h>
diff --git a/drivers/dma/bestcomm/Kconfig b/drivers/dma/bestcomm/Kconfig
index 29e4270..9bb1bf8 100644
--- a/drivers/dma/bestcomm/Kconfig
+++ b/drivers/dma/bestcomm/Kconfig
@@ -6,7 +6,7 @@ config PPC_BESTCOMM
 	tristate "Bestcomm DMA engine support"
 	depends on PPC_MPC52xx
 	default n
-	select PPC_LIB_RHEAP
+	select LIB_RHEAP
 	help
 	  BestComm is the name of the communication coprocessor found
 	  on the Freescale MPC5200 family of processor.  Its usage is
diff --git a/drivers/soc/qe/Kconfig b/drivers/soc/qe/Kconfig
index 5c2b9d8..49118e1 100644
--- a/drivers/soc/qe/Kconfig
+++ b/drivers/soc/qe/Kconfig
@@ -5,7 +5,7 @@
 config QUICC_ENGINE
 	bool "Freescale QUICC Engine (QE) Support"
 	depends on FSL_SOC && (PPC32 || PPC64)
-	select PPC_LIB_RHEAP
+	select LIB_RHEAP
 	select CRC32
 	---help---
 	  The QUICC Engine (QE) is a new generation of communications
diff --git a/drivers/soc/qe/qe.c b/drivers/soc/qe/qe.c
index 55a9c6d..a5e4780 100644
--- a/drivers/soc/qe/qe.c
+++ b/drivers/soc/qe/qe.c
@@ -36,7 +36,7 @@
 #include <linux/fsl/immap_qe.h>
 #include <linux/fsl/qe.h>
 #include <asm/prom.h>
-#include <asm/rheap.h>
+#include <linux/fsl/rheap.h>
 
 static void qe_snums_init(void);
 static int qe_sdma_init(void);
diff --git a/drivers/soc/qe/qe_common.c b/drivers/soc/qe/qe_common.c
index ee02ae8..c047fde 100644
--- a/drivers/soc/qe/qe_common.c
+++ b/drivers/soc/qe/qe_common.c
@@ -26,7 +26,7 @@
 #include <linux/slab.h>
 
 #include <asm/io.h>
-#include <asm/rheap.h>
+#include <linux/fsl/rheap.h>
 #include <linux/fsl/qe.h>
 
 static spinlock_t qe_muram_lock;
diff --git a/drivers/video/Kconfig b/drivers/video/Kconfig
index 2a46153..4ce7204 100644
--- a/drivers/video/Kconfig
+++ b/drivers/video/Kconfig
@@ -1972,7 +1972,7 @@ config FB_FSL_DIU
 	select FB_CFB_FILLRECT
 	select FB_CFB_COPYAREA
 	select FB_CFB_IMAGEBLIT
-	select PPC_LIB_RHEAP
+	select LIB_RHEAP
 	---help---
 	  Framebuffer driver for the Freescale SoC DIU
 
diff --git a/include/linux/fsl/bestcomm/sram.h b/include/linux/fsl/bestcomm/sram.h
index b6d6689..117eaa1 100644
--- a/include/linux/fsl/bestcomm/sram.h
+++ b/include/linux/fsl/bestcomm/sram.h
@@ -12,7 +12,7 @@
 #ifndef __BESTCOMM_SRAM_H__
 #define __BESTCOMM_SRAM_H__
 
-#include <asm/rheap.h>
+#include <linux/fsl/rheap.h>
 #include <asm/mmu.h>
 #include <linux/spinlock.h>
 
diff --git a/arch/powerpc/include/asm/rheap.h b/include/linux/fsl/rheap.h
similarity index 100%
rename from arch/powerpc/include/asm/rheap.h
rename to include/linux/fsl/rheap.h
diff --git a/lib/Kconfig b/lib/Kconfig
index 4490089..4ffcc86 100644
--- a/lib/Kconfig
+++ b/lib/Kconfig
@@ -365,6 +365,9 @@ config CPU_RMAP
 	bool
 	depends on SMP
 
+config LIB_RHEAP
+	bool
+
 config DQL
 	bool
 
diff --git a/lib/Makefile b/lib/Makefile
index 6e23a0f..8523e9d 100644
--- a/lib/Makefile
+++ b/lib/Makefile
@@ -194,3 +194,5 @@ quiet_cmd_build_OID_registry = GEN     $@
 clean-files	+= oid_registry_data.c
 
 obj-$(CONFIG_UCS2_STRING) += ucs2_string.o
+
+obj-$(CONFIG_LIB_RHEAP) += rheap.o
diff --git a/arch/powerpc/lib/rheap.c b/lib/rheap.c
similarity index 99%
rename from arch/powerpc/lib/rheap.c
rename to lib/rheap.c
index a1060a8..af180fd 100644
--- a/arch/powerpc/lib/rheap.c
+++ b/lib/rheap.c
@@ -20,7 +20,7 @@
 #include <linux/err.h>
 #include <linux/slab.h>
 
-#include <asm/rheap.h>
+#include <linux/fsl/rheap.h>
 
 /*
  * Fixup a list_head, needed when copying lists.  If the pointers fall
-- 
2.1.0.27.g96db324
