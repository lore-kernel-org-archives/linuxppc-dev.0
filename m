Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1on0136.outbound.protection.outlook.com [157.56.110.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DE5381A02DF
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 15 Aug 2015 16:42:05 +1000 (AEST)
From: Scott Wood <scottwood@freescale.com>
To: Mike Turquette <mturquette@linaro.org>, Tang Yuantian
 <Yuantian.Tang@freescale.com>
CC: "Rafael J. Wysocki" <rjw@rjwysocki.net>, Liberman Igal-B31950
 <Igal.Liberman@freescale.com>, Bucur Madalin-Cristian-B32716
 <madalin.bucur@freescale.com>, <linux-clk@vger.kernel.org>,
 <linux-pm@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <devicetree@vger.kernel.org>, Scott Wood <scottwood@freescale.com>
Subject: [PATCH v2 2/5] powerpc/fsl: Move fsl_guts.h out of arch/powerpc
Date: Sat, 15 Aug 2015 01:41:19 -0500
Message-ID: <1439620882-20449-3-git-send-email-scottwood@freescale.com>
In-Reply-To: <1439620882-20449-1-git-send-email-scottwood@freescale.com>
References: <1439620882-20449-1-git-send-email-scottwood@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Freescale's Layerscape ARM chips use the same structure.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
v2: non-RFC

 arch/powerpc/platforms/85xx/mpc85xx_mds.c                       | 2 +-
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c                       | 2 +-
 arch/powerpc/platforms/85xx/p1022_ds.c                          | 2 +-
 arch/powerpc/platforms/85xx/p1022_rdk.c                         | 2 +-
 arch/powerpc/platforms/85xx/smp.c                               | 2 +-
 arch/powerpc/platforms/85xx/twr_p102x.c                         | 2 +-
 arch/powerpc/platforms/86xx/mpc8610_hpcd.c                      | 2 +-
 drivers/iommu/fsl_pamu.c                                        | 2 +-
 arch/powerpc/include/asm/fsl_guts.h => include/linux/fsl/guts.h | 6 ++----
 sound/soc/fsl/mpc8610_hpcd.c                                    | 2 +-
 sound/soc/fsl/p1022_ds.c                                        | 2 +-
 sound/soc/fsl/p1022_rdk.c                                       | 2 +-
 12 files changed, 13 insertions(+), 15 deletions(-)
 rename arch/powerpc/include/asm/fsl_guts.h => include/linux/fsl/guts.h (98%)

diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index a392e94..f0be439 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -34,6 +34,7 @@
 #include <linux/of_device.h>
 #include <linux/phy.h>
 #include <linux/memblock.h>
+#include <linux/fsl/guts.h>
 
 #include <linux/atomic.h>
 #include <asm/time.h>
@@ -51,7 +52,6 @@
 #include <asm/qe_ic.h>
 #include <asm/mpic.h>
 #include <asm/swiotlb.h>
-#include <asm/fsl_guts.h>
 #include "smp.h"
 
 #include "mpc85xx.h"
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index e358bed..50dcc00 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -17,6 +17,7 @@
 #include <linux/seq_file.h>
 #include <linux/interrupt.h>
 #include <linux/of_platform.h>
+#include <linux/fsl/guts.h>
 
 #include <asm/time.h>
 #include <asm/machdep.h>
@@ -27,7 +28,6 @@
 #include <asm/mpic.h>
 #include <asm/qe.h>
 #include <asm/qe_ic.h>
-#include <asm/fsl_guts.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
diff --git a/arch/powerpc/platforms/85xx/p1022_ds.c b/arch/powerpc/platforms/85xx/p1022_ds.c
index 6ac986d3..371df82 100644
--- a/arch/powerpc/platforms/85xx/p1022_ds.c
+++ b/arch/powerpc/platforms/85xx/p1022_ds.c
@@ -16,6 +16,7 @@
  * kind, whether express or implied.
  */
 
+#include <linux/fsl/guts.h>
 #include <linux/pci.h>
 #include <linux/of_platform.h>
 #include <asm/div64.h>
@@ -25,7 +26,6 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include <asm/udbg.h>
-#include <asm/fsl_guts.h>
 #include <asm/fsl_lbc.h>
 #include "smp.h"
 
diff --git a/arch/powerpc/platforms/85xx/p1022_rdk.c b/arch/powerpc/platforms/85xx/p1022_rdk.c
index 680232d..5087bec 100644
--- a/arch/powerpc/platforms/85xx/p1022_rdk.c
+++ b/arch/powerpc/platforms/85xx/p1022_rdk.c
@@ -12,6 +12,7 @@
  * kind, whether express or implied.
  */
 
+#include <linux/fsl/guts.h>
 #include <linux/pci.h>
 #include <linux/of_platform.h>
 #include <asm/div64.h>
@@ -21,7 +22,6 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include <asm/udbg.h>
-#include <asm/fsl_guts.h>
 #include "smp.h"
 
 #include "mpc85xx.h"
diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
index b8b8216..6ac7786 100644
--- a/arch/powerpc/platforms/85xx/smp.c
+++ b/arch/powerpc/platforms/85xx/smp.c
@@ -19,6 +19,7 @@
 #include <linux/kexec.h>
 #include <linux/highmem.h>
 #include <linux/cpu.h>
+#include <linux/fsl/guts.h>
 
 #include <asm/machdep.h>
 #include <asm/pgtable.h>
@@ -26,7 +27,6 @@
 #include <asm/mpic.h>
 #include <asm/cacheflush.h>
 #include <asm/dbell.h>
-#include <asm/fsl_guts.h>
 #include <asm/code-patching.h>
 #include <asm/cputhreads.h>
 
diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platforms/85xx/twr_p102x.c
index 30e002f..892e613 100644
--- a/arch/powerpc/platforms/85xx/twr_p102x.c
+++ b/arch/powerpc/platforms/85xx/twr_p102x.c
@@ -15,6 +15,7 @@
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/errno.h>
+#include <linux/fsl/guts.h>
 #include <linux/pci.h>
 #include <linux/of_platform.h>
 
@@ -23,7 +24,6 @@
 #include <asm/mpic.h>
 #include <asm/qe.h>
 #include <asm/qe_ic.h>
-#include <asm/fsl_guts.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
diff --git a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
index 55413a5..437a9c3 100644
--- a/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
+++ b/arch/powerpc/platforms/86xx/mpc8610_hpcd.c
@@ -24,6 +24,7 @@
 #include <linux/delay.h>
 #include <linux/seq_file.h>
 #include <linux/of.h>
+#include <linux/fsl/guts.h>
 
 #include <asm/time.h>
 #include <asm/machdep.h>
@@ -38,7 +39,6 @@
 #include <sysdev/fsl_pci.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/simple_gpio.h>
-#include <asm/fsl_guts.h>
 
 #include "mpc86xx.h"
 
diff --git a/drivers/iommu/fsl_pamu.c b/drivers/iommu/fsl_pamu.c
index abeedc9..24705c2 100644
--- a/drivers/iommu/fsl_pamu.c
+++ b/drivers/iommu/fsl_pamu.c
@@ -20,11 +20,11 @@
 
 #include "fsl_pamu.h"
 
+#include <linux/fsl/guts.h>
 #include <linux/interrupt.h>
 #include <linux/genalloc.h>
 
 #include <asm/mpc85xx.h>
-#include <asm/fsl_guts.h>
 
 /* define indexes for each operation mapping scenario */
 #define OMI_QMAN        0x00
diff --git a/arch/powerpc/include/asm/fsl_guts.h b/include/linux/fsl/guts.h
similarity index 98%
rename from arch/powerpc/include/asm/fsl_guts.h
rename to include/linux/fsl/guts.h
index 43b6bb1..3acf613 100644
--- a/arch/powerpc/include/asm/fsl_guts.h
+++ b/include/linux/fsl/guts.h
@@ -12,9 +12,8 @@
  * option) any later version.
  */
 
-#ifndef __ASM_POWERPC_FSL_GUTS_H__
-#define __ASM_POWERPC_FSL_GUTS_H__
-#ifdef __KERNEL__
+#ifndef __FSL_GUTS_H__
+#define __FSL_GUTS_H__
 
 /**
  * Global Utility Registers.
@@ -189,4 +188,3 @@ static inline void guts_set_pmuxcr_dma(struct ccsr_guts __iomem *guts,
 #endif
 
 #endif
-#endif
diff --git a/sound/soc/fsl/mpc8610_hpcd.c b/sound/soc/fsl/mpc8610_hpcd.c
index 9621b91..6f236f1 100644
--- a/sound/soc/fsl/mpc8610_hpcd.c
+++ b/sound/soc/fsl/mpc8610_hpcd.c
@@ -12,11 +12,11 @@
 
 #include <linux/module.h>
 #include <linux/interrupt.h>
+#include <linux/fsl/guts.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
 #include <sound/soc.h>
-#include <asm/fsl_guts.h>
 
 #include "fsl_dma.h"
 #include "fsl_ssi.h"
diff --git a/sound/soc/fsl/p1022_ds.c b/sound/soc/fsl/p1022_ds.c
index 71c1a7d..747aab0 100644
--- a/sound/soc/fsl/p1022_ds.c
+++ b/sound/soc/fsl/p1022_ds.c
@@ -11,12 +11,12 @@
  */
 
 #include <linux/module.h>
+#include <linux/fsl/guts.h>
 #include <linux/interrupt.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
 #include <sound/soc.h>
-#include <asm/fsl_guts.h>
 
 #include "fsl_dma.h"
 #include "fsl_ssi.h"
diff --git a/sound/soc/fsl/p1022_rdk.c b/sound/soc/fsl/p1022_rdk.c
index ee29048..1dd49e5 100644
--- a/sound/soc/fsl/p1022_rdk.c
+++ b/sound/soc/fsl/p1022_rdk.c
@@ -18,12 +18,12 @@
  */
 
 #include <linux/module.h>
+#include <linux/fsl/guts.h>
 #include <linux/interrupt.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
 #include <linux/slab.h>
 #include <sound/soc.h>
-#include <asm/fsl_guts.h>
 
 #include "fsl_dma.h"
 #include "fsl_ssi.h"
-- 
2.1.4
