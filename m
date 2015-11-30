Return-Path: <qiang.zhao@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2on0136.outbound.protection.outlook.com [207.46.100.136])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 6DE611A08AA
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Nov 2015 14:12:41 +1100 (AEDT)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: <lauraa@codeaurora.org>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <akpm@linux-foundation.org>, <olof@lixom.net>, <catalin.marinas@arm.com>,
 <scottwood@freescale.com>, <X.xie@freescale.com>, Zhao Qiang
 <qiang.zhao@freescale.com>
Subject: [PATCH v13 6/6] QE: Move QE from arch/powerpc to drivers/soc
Date: Mon, 30 Nov 2015 10:48:57 +0800
Message-ID: <1448851737-33125-6-git-send-email-qiang.zhao@freescale.com>
In-Reply-To: <1448851737-33125-1-git-send-email-qiang.zhao@freescale.com>
References: <1448851737-33125-1-git-send-email-qiang.zhao@freescale.com>
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

ls1 has qe and ls1 has arm cpu.
move qe from arch/powerpc to drivers/soc/fsl
to adapt to powerpc and arm

Signed-off-by: Zhao Qiang <qiang.zhao@freescale.com>
---
Changes for v2:
	- move code to driver/soc
Changes for v3:
	- change drivers/soc/qe to drivers/soc/fsl-qe
Changes for v4:
	- move drivers/soc/fsl-qe to drivers/soc/fsl/qe
	- move head files for qe from include/linux/fsl to include/soc/fsl
	- move qe_ic.c to drivers/irqchip/
Changes for v5:
	- update MAINTAINERS
Changes for v6:
	- rebase
Changes for v7:
	- move this patch from 2/3 to 3/3
Changes for v8:
	- Nil 
Changes for v9:
	- Nil 
Changes for v10:
	- Nil 
Changes for v11:
	- rebase
Changes for v12:
	- Nil
Changes for v13:
	- rebase
	- move qe_ic.* back to qe directory and will send another patch
	- to move them.

 MAINTAINERS                                                   |  5 +++--
 arch/powerpc/Kconfig                                          |  2 --
 arch/powerpc/include/asm/cpm.h                                |  2 +-
 arch/powerpc/platforms/83xx/km83xx.c                          |  4 ++--
 arch/powerpc/platforms/83xx/misc.c                            |  2 +-
 arch/powerpc/platforms/83xx/mpc832x_mds.c                     |  4 ++--
 arch/powerpc/platforms/83xx/mpc832x_rdb.c                     |  4 ++--
 arch/powerpc/platforms/83xx/mpc836x_mds.c                     |  4 ++--
 arch/powerpc/platforms/83xx/mpc836x_rdk.c                     |  4 ++--
 arch/powerpc/platforms/85xx/common.c                          |  2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c                 |  2 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c                     |  4 ++--
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c                     |  4 ++--
 arch/powerpc/platforms/85xx/twr_p102x.c                       |  4 ++--
 arch/powerpc/platforms/Kconfig                                | 11 -----------
 arch/powerpc/sysdev/Makefile                                  |  2 --
 arch/powerpc/sysdev/cpm_common.c                              |  2 +-
 drivers/net/ethernet/freescale/fsl_pq_mdio.c                  |  2 +-
 drivers/net/ethernet/freescale/ucc_geth.c                     |  8 ++++----
 drivers/net/ethernet/freescale/ucc_geth.h                     |  8 ++++----
 drivers/soc/Kconfig                                           |  1 +
 drivers/soc/Makefile                                          |  1 +
 drivers/soc/fsl/Makefile                                      |  6 ++++++
 {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/Kconfig    | 11 +++++++++++
 {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/Makefile   |  0
 {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/gpio.c     |  2 +-
 {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/qe.c       |  4 ++--
 .../powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/qe_common.c  |  2 +-
 {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/qe_ic.c    |  5 +++--
 {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/qe_ic.h    |  4 ++--
 {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/qe_io.c    |  2 +-
 {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/ucc.c      |  6 +++---
 {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/ucc_fast.c |  8 ++++----
 {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/ucc_slow.c |  8 ++++----
 {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/usb.c      |  4 ++--
 drivers/spi/spi-fsl-cpm.c                                     |  2 +-
 drivers/tty/serial/ucc_uart.c                                 |  2 +-
 drivers/usb/gadget/udc/fsl_qe_udc.c                           |  2 +-
 drivers/usb/host/fhci-hcd.c                                   |  2 +-
 drivers/usb/host/fhci-hub.c                                   |  2 +-
 drivers/usb/host/fhci-sched.c                                 |  2 +-
 drivers/usb/host/fhci.h                                       |  4 ++--
 {arch/powerpc/include/asm => include/soc/fsl/qe}/immap_qe.h   |  0
 {arch/powerpc/include/asm => include/soc/fsl/qe}/qe.h         |  2 +-
 {arch/powerpc/include/asm => include/soc/fsl/qe}/qe_ic.h      |  0
 {arch/powerpc/include/asm => include/soc/fsl/qe}/ucc.h        |  4 ++--
 {arch/powerpc/include/asm => include/soc/fsl/qe}/ucc_fast.h   |  6 +++---
 {arch/powerpc/include/asm => include/soc/fsl/qe}/ucc_slow.h   |  6 +++---
 48 files changed, 92 insertions(+), 86 deletions(-)
 create mode 100644 drivers/soc/fsl/Makefile
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/Kconfig (54%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/Makefile (100%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/gpio.c (99%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/qe.c (99%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/qe_common.c (99%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/qe_ic.c (99%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/qe_ic.h (97%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/qe_io.c (99%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/ucc.c (98%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/ucc_fast.c (98%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/ucc_slow.c (98%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/usb.c (96%)
 rename {arch/powerpc/include/asm => include/soc/fsl/qe}/immap_qe.h (100%)
 rename {arch/powerpc/include/asm => include/soc/fsl/qe}/qe.h (99%)
 rename {arch/powerpc/include/asm => include/soc/fsl/qe}/qe_ic.h (100%)
 rename {arch/powerpc/include/asm => include/soc/fsl/qe}/ucc.h (96%)
 rename {arch/powerpc/include/asm => include/soc/fsl/qe}/ucc_fast.h (98%)
 rename {arch/powerpc/include/asm => include/soc/fsl/qe}/ucc_slow.h (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 9f6685f..533c94a 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4395,8 +4395,9 @@ F:	include/linux/fs_enet_pd.h
 FREESCALE QUICC ENGINE LIBRARY
 L:	linuxppc-dev@lists.ozlabs.org
 S:	Orphan
-F:	arch/powerpc/sysdev/qe_lib/
-F:	arch/powerpc/include/asm/*qe.h
+F:	drivers/soc/fsl/qe/
+F:	include/soc/fsl/*qe*.h
+F:	include/soc/fsl/*ucc*.h
 
 FREESCALE USB PERIPHERAL DRIVERS
 M:	Li Yang <leoli@freescale.com>
diff --git a/arch/powerpc/Kconfig b/arch/powerpc/Kconfig
index db49e0d..9ff098fc 100644
--- a/arch/powerpc/Kconfig
+++ b/arch/powerpc/Kconfig
@@ -1074,8 +1074,6 @@ source "drivers/Kconfig"
 
 source "fs/Kconfig"
 
-source "arch/powerpc/sysdev/qe_lib/Kconfig"
-
 source "lib/Kconfig"
 
 source "arch/powerpc/Kconfig.debug"
diff --git a/arch/powerpc/include/asm/cpm.h b/arch/powerpc/include/asm/cpm.h
index 0958028..2c5c5b4 100644
--- a/arch/powerpc/include/asm/cpm.h
+++ b/arch/powerpc/include/asm/cpm.h
@@ -5,7 +5,7 @@
 #include <linux/types.h>
 #include <linux/errno.h>
 #include <linux/of.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/qe.h>
 
 /*
  * SPI Parameter RAM common to QE and CPM.
diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index ae111581..4bc6bbb 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -37,8 +37,8 @@
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <soc/fsl/qe/qe.h>
+#include <soc/fsl/qe/qe_ic.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index ef9d01a..7e923ca 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -17,7 +17,7 @@
 #include <asm/io.h>
 #include <asm/hw_irq.h>
 #include <asm/ipic.h>
-#include <asm/qe_ic.h>
+#include <soc/fsl/qe/qe_ic.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index aacc43f..a973b2a 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -36,8 +36,8 @@
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <soc/fsl/qe/qe.h>
+#include <soc/fsl/qe/qe_ic.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index 0c7a43e..ea2b87d 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -25,8 +25,8 @@
 #include <asm/time.h>
 #include <asm/ipic.h>
 #include <asm/udbg.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <soc/fsl/qe/qe.h>
+#include <soc/fsl/qe/qe_ic.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index eb24abd..dd70b85 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -44,8 +44,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include <sysdev/simple_gpio.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <soc/fsl/qe/qe.h>
+#include <soc/fsl/qe/qe_ic.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
index 823e370..4cd7153 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -20,8 +20,8 @@
 #include <asm/time.h>
 #include <asm/ipic.h>
 #include <asm/udbg.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <soc/fsl/qe/qe.h>
+#include <soc/fsl/qe/qe_ic.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index 18bca20..949f22c 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -9,7 +9,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 
-#include <asm/qe.h>
+#include <soc/fsl/qe/qe.h>
 #include <sysdev/cpm2_pic.h>
 
 #include "mpc85xx.h"
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 46d05c9..a2b0bc8 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -27,7 +27,7 @@
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <asm/ehv_pic.h>
-#include <asm/qe_ic.h>
+#include <soc/fsl/qe/qe_ic.h>
 
 #include <linux/of_platform.h>
 #include <sysdev/fsl_soc.h>
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index f0be439..f61cbe2 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -48,8 +48,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include <sysdev/simple_gpio.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <soc/fsl/qe/qe.h>
+#include <soc/fsl/qe/qe_ic.h>
 #include <asm/mpic.h>
 #include <asm/swiotlb.h>
 #include "smp.h"
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index 50dcc00..3f4dad1 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -26,8 +26,8 @@
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <soc/fsl/qe/qe.h>
+#include <soc/fsl/qe/qe_ic.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platforms/85xx/twr_p102x.c
index 892e613..71bc255 100644
--- a/arch/powerpc/platforms/85xx/twr_p102x.c
+++ b/arch/powerpc/platforms/85xx/twr_p102x.c
@@ -22,8 +22,8 @@
 #include <asm/pci-bridge.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <soc/fsl/qe/qe.h>
+#include <soc/fsl/qe/qe_ic.h>
 
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 57069eb..46a3533 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -272,17 +272,6 @@ config TAU_AVERAGE
 
 	  If in doubt, say N here.
 
-config QUICC_ENGINE
-	bool "Freescale QUICC Engine (QE) Support"
-	depends on FSL_SOC && PPC32
-	select GENERIC_ALLOCATOR
-	select CRC32
-	help
-	  The QUICC Engine (QE) is a new generation of communications
-	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
-	  Selecting this option means that you wish to build a kernel
-	  for a machine with a QE coprocessor.
-
 config QE_GPIO
 	bool "QE GPIO support"
 	depends on QUICC_ENGINE
diff --git a/arch/powerpc/sysdev/Makefile b/arch/powerpc/sysdev/Makefile
index f1d4749..bd6bd72 100644
--- a/arch/powerpc/sysdev/Makefile
+++ b/arch/powerpc/sysdev/Makefile
@@ -26,8 +26,6 @@ obj-$(CONFIG_FSL_85XX_CACHE_SRAM)	+= fsl_85xx_l2ctlr.o fsl_85xx_cache_sram.o
 obj-$(CONFIG_SIMPLE_GPIO)	+= simple_gpio.o
 obj-$(CONFIG_FSL_RIO)		+= fsl_rio.o fsl_rmu.o
 obj-$(CONFIG_TSI108_BRIDGE)	+= tsi108_pci.o tsi108_dev.o
-obj-$(CONFIG_QUICC_ENGINE)	+= qe_lib/
-obj-$(CONFIG_CPM)		+= qe_lib/
 mv64x60-$(CONFIG_PCI)		+= mv64x60_pci.o
 obj-$(CONFIG_MV64X60)		+= $(mv64x60-y) mv64x60_pic.o mv64x60_dev.o \
 				   mv64x60_udbg.o
diff --git a/arch/powerpc/sysdev/cpm_common.c b/arch/powerpc/sysdev/cpm_common.c
index 6993aa8..9d32465 100644
--- a/arch/powerpc/sysdev/cpm_common.c
+++ b/arch/powerpc/sysdev/cpm_common.c
@@ -28,7 +28,7 @@
 #include <asm/udbg.h>
 #include <asm/io.h>
 #include <asm/cpm.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/qe.h>
 
 #include <mm/mmu_decl.h>
 
diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index 3c40f6b..21bdf55 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -29,7 +29,7 @@
 
 #include <asm/io.h>
 #if IS_ENABLED(CONFIG_UCC_GETH)
-#include <asm/ucc.h>	/* for ucc_set_qe_mux_mii_mng() */
+#include <soc/fsl/qe/ucc.h>
 #endif
 
 #include "gianfar.h"
diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index 650f788..c30b72e 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.c
+++ b/drivers/net/ethernet/freescale/ucc_geth.c
@@ -40,10 +40,10 @@
 #include <asm/uaccess.h>
 #include <asm/irq.h>
 #include <asm/io.h>
-#include <asm/immap_qe.h>
-#include <asm/qe.h>
-#include <asm/ucc.h>
-#include <asm/ucc_fast.h>
+#include <soc/fsl/qe/immap_qe.h>
+#include <soc/fsl/qe/qe.h>
+#include <soc/fsl/qe/ucc.h>
+#include <soc/fsl/qe/ucc_fast.h>
 #include <asm/machdep.h>
 
 #include "ucc_geth.h"
diff --git a/drivers/net/ethernet/freescale/ucc_geth.h b/drivers/net/ethernet/freescale/ucc_geth.h
index 75f3371..5da19b4 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.h
+++ b/drivers/net/ethernet/freescale/ucc_geth.h
@@ -22,11 +22,11 @@
 #include <linux/list.h>
 #include <linux/if_ether.h>
 
-#include <asm/immap_qe.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/immap_qe.h>
+#include <soc/fsl/qe/qe.h>
 
-#include <asm/ucc.h>
-#include <asm/ucc_fast.h>
+#include <soc/fsl/qe/ucc.h>
+#include <soc/fsl/qe/ucc_fast.h>
 
 #define DRV_DESC "QE UCC Gigabit Ethernet Controller"
 #define DRV_NAME "ucc_geth"
diff --git a/drivers/soc/Kconfig b/drivers/soc/Kconfig
index 96ddecb..ae12c52 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -1,5 +1,6 @@
 menu "SOC (System On Chip) specific Drivers"
 
+source "drivers/soc/fsl/qe/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/sunxi/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 0b12d77..c8b4442 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -3,6 +3,7 @@
 #
 
 obj-$(CONFIG_MACH_DOVE)		+= dove/
+obj-y				+= fsl/
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_SUNXI)	+= sunxi/
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
new file mode 100644
index 0000000..203307f
--- /dev/null
+++ b/drivers/soc/fsl/Makefile
@@ -0,0 +1,6 @@
+#
+# Makefile for the Linux Kernel SOC fsl specific device drivers
+#
+
+obj-$(CONFIG_QUICC_ENGINE)		+= qe/
+obj-$(CONFIG_CPM)			+= qe/
diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/drivers/soc/fsl/qe/Kconfig
similarity index 54%
rename from arch/powerpc/sysdev/qe_lib/Kconfig
rename to drivers/soc/fsl/qe/Kconfig
index 3c25199..20978f2 100644
--- a/arch/powerpc/sysdev/qe_lib/Kconfig
+++ b/drivers/soc/fsl/qe/Kconfig
@@ -2,6 +2,17 @@
 # QE Communication options
 #
 
+config QUICC_ENGINE
+	bool "Freescale QUICC Engine (QE) Support"
+	depends on FSL_SOC && PPC32
+	select GENERIC_ALLOCATOR
+	select CRC32
+	help
+	  The QUICC Engine (QE) is a new generation of communications
+	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
+	  Selecting this option means that you wish to build a kernel
+	  for a machine with a QE coprocessor.
+
 config UCC_SLOW
 	bool
 	default y if SERIAL_QE
diff --git a/arch/powerpc/sysdev/qe_lib/Makefile b/drivers/soc/fsl/qe/Makefile
similarity index 100%
rename from arch/powerpc/sysdev/qe_lib/Makefile
rename to drivers/soc/fsl/qe/Makefile
diff --git a/arch/powerpc/sysdev/qe_lib/gpio.c b/drivers/soc/fsl/qe/gpio.c
similarity index 99%
rename from arch/powerpc/sysdev/qe_lib/gpio.c
rename to drivers/soc/fsl/qe/gpio.c
index 521e67a..aa5c11ac 100644
--- a/arch/powerpc/sysdev/qe_lib/gpio.c
+++ b/drivers/soc/fsl/qe/gpio.c
@@ -21,7 +21,7 @@
 #include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/export.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/qe.h>
 
 struct qe_gpio_chip {
 	struct of_mm_gpio_chip mm_gc;
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/drivers/soc/fsl/qe/qe.c
similarity index 99%
rename from arch/powerpc/sysdev/qe_lib/qe.c
rename to drivers/soc/fsl/qe/qe.c
index 88ae5c7..709fc63 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -31,8 +31,8 @@
 #include <asm/irq.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <asm/immap_qe.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/immap_qe.h>
+#include <soc/fsl/qe/qe.h>
 #include <asm/prom.h>
 #include <asm/rheap.h>
 
diff --git a/arch/powerpc/sysdev/qe_lib/qe_common.c b/drivers/soc/fsl/qe/qe_common.c
similarity index 99%
rename from arch/powerpc/sysdev/qe_lib/qe_common.c
rename to drivers/soc/fsl/qe/qe_common.c
index b90043f..419fa5b 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_common.c
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -26,7 +26,7 @@
 #include <linux/of_address.h>
 #include <linux/slab.h>
 #include <linux/io.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/qe.h>
 
 static struct gen_pool *muram_pool;
 static spinlock_t cpm_muram_lock;
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/drivers/soc/fsl/qe/qe_ic.c
similarity index 99%
rename from arch/powerpc/sysdev/qe_lib/qe_ic.c
rename to drivers/soc/fsl/qe/qe_ic.c
index fbcc1f8..010a2ce 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/drivers/soc/fsl/qe/qe_ic.c
@@ -14,6 +14,8 @@
  * option) any later version.
  */
 
+#include <linux/of_irq.h>
+#include <linux/of_address.h>
 #include <linux/kernel.h>
 #include <linux/init.h>
 #include <linux/errno.h>
@@ -26,8 +28,7 @@
 #include <linux/spinlock.h>
 #include <asm/irq.h>
 #include <asm/io.h>
-#include <asm/prom.h>
-#include <asm/qe_ic.h>
+#include <soc/fsl/qe/qe_ic.h>
 
 #include "qe_ic.h"
 
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.h b/drivers/soc/fsl/qe/qe_ic.h
similarity index 97%
rename from arch/powerpc/sysdev/qe_lib/qe_ic.h
rename to drivers/soc/fsl/qe/qe_ic.h
index efef7ab..926a2ed 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.h
+++ b/drivers/soc/fsl/qe/qe_ic.h
@@ -1,5 +1,5 @@
 /*
- * arch/powerpc/sysdev/qe_lib/qe_ic.h
+ * drivers/soc/fsl/qe/qe_ic.h
  *
  * QUICC ENGINE Interrupt Controller Header
  *
@@ -16,7 +16,7 @@
 #ifndef _POWERPC_SYSDEV_QE_IC_H
 #define _POWERPC_SYSDEV_QE_IC_H
 
-#include <asm/qe_ic.h>
+#include <soc/fsl/qe/qe_ic.h>
 
 #define NR_QE_IC_INTS		64
 
diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/drivers/soc/fsl/qe/qe_io.c
similarity index 99%
rename from arch/powerpc/sysdev/qe_lib/qe_io.c
rename to drivers/soc/fsl/qe/qe_io.c
index 7ea0174..7ae59ab 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_io.c
+++ b/drivers/soc/fsl/qe/qe_io.c
@@ -21,7 +21,7 @@
 #include <linux/ioport.h>
 
 #include <asm/io.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/qe.h>
 #include <asm/prom.h>
 #include <sysdev/fsl_soc.h>
 
diff --git a/arch/powerpc/sysdev/qe_lib/ucc.c b/drivers/soc/fsl/qe/ucc.c
similarity index 98%
rename from arch/powerpc/sysdev/qe_lib/ucc.c
rename to drivers/soc/fsl/qe/ucc.c
index 621575b..b59d335 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc.c
+++ b/drivers/soc/fsl/qe/ucc.c
@@ -21,9 +21,9 @@
 
 #include <asm/irq.h>
 #include <asm/io.h>
-#include <asm/immap_qe.h>
-#include <asm/qe.h>
-#include <asm/ucc.h>
+#include <soc/fsl/qe/immap_qe.h>
+#include <soc/fsl/qe/qe.h>
+#include <soc/fsl/qe/ucc.h>
 
 int ucc_set_qe_mux_mii_mng(unsigned int ucc_num)
 {
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_fast.c b/drivers/soc/fsl/qe/ucc_fast.c
similarity index 98%
rename from arch/powerpc/sysdev/qe_lib/ucc_fast.c
rename to drivers/soc/fsl/qe/ucc_fast.c
index 65aaf15..a768931 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_fast.c
+++ b/drivers/soc/fsl/qe/ucc_fast.c
@@ -21,11 +21,11 @@
 #include <linux/export.h>
 
 #include <asm/io.h>
-#include <asm/immap_qe.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/immap_qe.h>
+#include <soc/fsl/qe/qe.h>
 
-#include <asm/ucc.h>
-#include <asm/ucc_fast.h>
+#include <soc/fsl/qe/ucc.h>
+#include <soc/fsl/qe/ucc_fast.h>
 
 void ucc_fast_dump_regs(struct ucc_fast_private * uccf)
 {
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_slow.c b/drivers/soc/fsl/qe/ucc_slow.c
similarity index 98%
rename from arch/powerpc/sysdev/qe_lib/ucc_slow.c
rename to drivers/soc/fsl/qe/ucc_slow.c
index 5f91628..9334bdb 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_slow.c
+++ b/drivers/soc/fsl/qe/ucc_slow.c
@@ -21,11 +21,11 @@
 #include <linux/export.h>
 
 #include <asm/io.h>
-#include <asm/immap_qe.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/immap_qe.h>
+#include <soc/fsl/qe/qe.h>
 
-#include <asm/ucc.h>
-#include <asm/ucc_slow.h>
+#include <soc/fsl/qe/ucc.h>
+#include <soc/fsl/qe/ucc_slow.h>
 
 u32 ucc_slow_get_qe_cr_subblock(int uccs_num)
 {
diff --git a/arch/powerpc/sysdev/qe_lib/usb.c b/drivers/soc/fsl/qe/usb.c
similarity index 96%
rename from arch/powerpc/sysdev/qe_lib/usb.c
rename to drivers/soc/fsl/qe/usb.c
index 27f23bd..111f7ab 100644
--- a/arch/powerpc/sysdev/qe_lib/usb.c
+++ b/drivers/soc/fsl/qe/usb.c
@@ -17,8 +17,8 @@
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/io.h>
-#include <asm/immap_qe.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/immap_qe.h>
+#include <soc/fsl/qe/qe.h>
 
 int qe_usb_clock_set(enum qe_clock clk, int rate)
 {
diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index 896add8..8f7b26e 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -16,7 +16,7 @@
  * option) any later version.
  */
 #include <asm/cpm.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/qe.h>
 #include <linux/dma-mapping.h>
 #include <linux/fsl_devices.h>
 #include <linux/kernel.h>
diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index 73190f5..1a7dc3c 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -31,7 +31,7 @@
 #include <linux/dma-mapping.h>
 
 #include <linux/fs_uart_pd.h>
-#include <asm/ucc_slow.h>
+#include <soc/fsl/qe/ucc_slow.h>
 
 #include <linux/firmware.h>
 #include <asm/reg.h>
diff --git a/drivers/usb/gadget/udc/fsl_qe_udc.c b/drivers/usb/gadget/udc/fsl_qe_udc.c
index 5fb6f8b..53c0692 100644
--- a/drivers/usb/gadget/udc/fsl_qe_udc.c
+++ b/drivers/usb/gadget/udc/fsl_qe_udc.c
@@ -38,7 +38,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/qe.h>
 #include <asm/cpm.h>
 #include <asm/dma.h>
 #include <asm/reg.h>
diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
index c6cebb9..0960f41 100644
--- a/drivers/usb/host/fhci-hcd.c
+++ b/drivers/usb/host/fhci-hcd.c
@@ -31,7 +31,7 @@
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
 #include <linux/slab.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/qe.h>
 #include <asm/fsl_gtm.h>
 #include "fhci.h"
 
diff --git a/drivers/usb/host/fhci-hub.c b/drivers/usb/host/fhci-hub.c
index 3bacdd7..60d55eb 100644
--- a/drivers/usb/host/fhci-hub.c
+++ b/drivers/usb/host/fhci-hub.c
@@ -24,7 +24,7 @@
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 #include <linux/gpio.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/qe.h>
 #include "fhci.h"
 
 /* virtual root hub specific descriptor */
diff --git a/drivers/usb/host/fhci-sched.c b/drivers/usb/host/fhci-sched.c
index 95ca598..a9609a3 100644
--- a/drivers/usb/host/fhci-sched.c
+++ b/drivers/usb/host/fhci-sched.c
@@ -25,7 +25,7 @@
 #include <linux/io.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/qe.h>
 #include <asm/fsl_gtm.h>
 #include "fhci.h"
 
diff --git a/drivers/usb/host/fhci.h b/drivers/usb/host/fhci.h
index 154e6a0..3fc82c1 100644
--- a/drivers/usb/host/fhci.h
+++ b/drivers/usb/host/fhci.h
@@ -27,8 +27,8 @@
 #include <linux/io.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
-#include <asm/qe.h>
-#include <asm/immap_qe.h>
+#include <soc/fsl/qe/qe.h>
+#include <soc/fsl/qe/immap_qe.h>
 
 #define USB_CLOCK	48000000
 
diff --git a/arch/powerpc/include/asm/immap_qe.h b/include/soc/fsl/qe/immap_qe.h
similarity index 100%
rename from arch/powerpc/include/asm/immap_qe.h
rename to include/soc/fsl/qe/immap_qe.h
diff --git a/arch/powerpc/include/asm/qe.h b/include/soc/fsl/qe/qe.h
similarity index 99%
rename from arch/powerpc/include/asm/qe.h
rename to include/soc/fsl/qe/qe.h
index ceeaf91..c7fa36c 100644
--- a/arch/powerpc/include/asm/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -22,7 +22,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <asm/cpm.h>
-#include <asm/immap_qe.h>
+#include <soc/fsl/qe/immap_qe.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/types.h>
diff --git a/arch/powerpc/include/asm/qe_ic.h b/include/soc/fsl/qe/qe_ic.h
similarity index 100%
rename from arch/powerpc/include/asm/qe_ic.h
rename to include/soc/fsl/qe/qe_ic.h
diff --git a/arch/powerpc/include/asm/ucc.h b/include/soc/fsl/qe/ucc.h
similarity index 96%
rename from arch/powerpc/include/asm/ucc.h
rename to include/soc/fsl/qe/ucc.h
index 6927ac2..894f14c 100644
--- a/arch/powerpc/include/asm/ucc.h
+++ b/include/soc/fsl/qe/ucc.h
@@ -15,8 +15,8 @@
 #ifndef __UCC_H__
 #define __UCC_H__
 
-#include <asm/immap_qe.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/immap_qe.h>
+#include <soc/fsl/qe/qe.h>
 
 #define STATISTICS
 
diff --git a/arch/powerpc/include/asm/ucc_fast.h b/include/soc/fsl/qe/ucc_fast.h
similarity index 98%
rename from arch/powerpc/include/asm/ucc_fast.h
rename to include/soc/fsl/qe/ucc_fast.h
index 72ea9ba..df8ea79 100644
--- a/arch/powerpc/include/asm/ucc_fast.h
+++ b/include/soc/fsl/qe/ucc_fast.h
@@ -16,10 +16,10 @@
 
 #include <linux/kernel.h>
 
-#include <asm/immap_qe.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/immap_qe.h>
+#include <soc/fsl/qe/qe.h>
 
-#include <asm/ucc.h>
+#include <soc/fsl/qe/ucc.h>
 
 /* Receive BD's status */
 #define R_E	0x80000000	/* buffer empty */
diff --git a/arch/powerpc/include/asm/ucc_slow.h b/include/soc/fsl/qe/ucc_slow.h
similarity index 99%
rename from arch/powerpc/include/asm/ucc_slow.h
rename to include/soc/fsl/qe/ucc_slow.h
index 233ef5f..6c0573a 100644
--- a/arch/powerpc/include/asm/ucc_slow.h
+++ b/include/soc/fsl/qe/ucc_slow.h
@@ -17,10 +17,10 @@
 
 #include <linux/kernel.h>
 
-#include <asm/immap_qe.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/immap_qe.h>
+#include <soc/fsl/qe/qe.h>
 
-#include <asm/ucc.h>
+#include <soc/fsl/qe/ucc.h>
 
 /* transmit BD's status */
 #define T_R	0x80000000	/* ready bit */
-- 
2.1.0.27.g96db324
