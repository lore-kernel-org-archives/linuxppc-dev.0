Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1bon0116.outbound.protection.outlook.com [157.56.111.116])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E42AC1A09AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 29 Sep 2015 12:16:04 +1000 (AEST)
From: Zhao Qiang <qiang.zhao@freescale.com>
To: <scottwood@freescale.com>
CC: <linux-kernel@vger.kernel.org>, <linuxppc-dev@lists.ozlabs.org>,
 <lauraa@codeaurora.org>, <X.xie@freescale.com>, <benh@kernel.crashing.org>,
 <leoli@freescale.com>, <paulus@samba.org>, Zhao Qiang
 <qiang.zhao@freescale.com>
Subject: [PATCH v11 6/6] QE: Move QE from arch/powerpc to drivers/soc
Date: Tue, 29 Sep 2015 10:09:21 +0800
Message-ID: <1443492561-11538-6-git-send-email-qiang.zhao@freescale.com>
In-Reply-To: <1443492561-11538-1-git-send-email-qiang.zhao@freescale.com>
References: <1443492561-11538-1-git-send-email-qiang.zhao@freescale.com>
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

 MAINTAINERS                                        |  5 ++--
 arch/powerpc/platforms/83xx/km83xx.c               |  4 +--
 arch/powerpc/platforms/83xx/misc.c                 |  2 +-
 arch/powerpc/platforms/83xx/mpc832x_mds.c          |  4 +--
 arch/powerpc/platforms/83xx/mpc832x_rdb.c          |  4 +--
 arch/powerpc/platforms/83xx/mpc836x_mds.c          |  4 +--
 arch/powerpc/platforms/83xx/mpc836x_rdk.c          |  4 +--
 arch/powerpc/platforms/85xx/common.c               |  2 +-
 arch/powerpc/platforms/85xx/corenet_generic.c      |  2 +-
 arch/powerpc/platforms/85xx/mpc85xx_mds.c          |  4 +--
 arch/powerpc/platforms/85xx/mpc85xx_rdb.c          |  4 +--
 arch/powerpc/platforms/85xx/twr_p102x.c            |  4 +--
 arch/powerpc/platforms/Kconfig                     | 20 -------------
 arch/powerpc/sysdev/cpm_common.c                   |  2 +-
 arch/powerpc/sysdev/qe_lib/Kconfig                 | 22 ++++-----------
 arch/powerpc/sysdev/qe_lib/Makefile                |  6 +---
 arch/powerpc/sysdev/qe_lib/gpio.c                  |  2 +-
 arch/powerpc/sysdev/qe_lib/qe_io.c                 |  2 +-
 arch/powerpc/sysdev/qe_lib/usb.c                   |  4 +--
 drivers/irqchip/Makefile                           |  1 +
 .../sysdev/qe_lib => drivers/irqchip}/qe_ic.c      |  2 +-
 .../sysdev/qe_lib => drivers/irqchip}/qe_ic.h      |  4 +--
 drivers/net/ethernet/freescale/fsl_pq_mdio.c       |  2 +-
 drivers/net/ethernet/freescale/ucc_geth.c          |  8 +++---
 drivers/net/ethernet/freescale/ucc_geth.h          |  8 +++---
 drivers/soc/Kconfig                                |  1 +
 drivers/soc/Makefile                               |  1 +
 drivers/soc/fsl/Makefile                           |  5 ++++
 drivers/soc/fsl/qe/Kconfig                         | 33 ++++++++++++++++++++++
 drivers/soc/fsl/qe/Makefile                        |  9 ++++++
 .../sysdev/qe_lib => drivers/soc/fsl/qe}/qe.c      |  4 +--
 .../qe_lib => drivers/soc/fsl/qe}/qe_common.c      |  2 +-
 .../sysdev/qe_lib => drivers/soc/fsl/qe}/ucc.c     |  6 ++--
 .../qe_lib => drivers/soc/fsl/qe}/ucc_fast.c       |  8 +++---
 .../qe_lib => drivers/soc/fsl/qe}/ucc_slow.c       |  8 +++---
 drivers/spi/spi-fsl-cpm.c                          |  2 +-
 drivers/tty/serial/ucc_uart.c                      |  2 +-
 drivers/usb/gadget/udc/fsl_qe_udc.c                |  2 +-
 drivers/usb/host/fhci-hcd.c                        |  2 +-
 drivers/usb/host/fhci-hub.c                        |  2 +-
 drivers/usb/host/fhci-sched.c                      |  2 +-
 drivers/usb/host/fhci.h                            |  4 +--
 .../include/asm => include/linux/fsl/qe}/qe_ic.h   |  0
 .../include/asm => include/soc/fsl/qe}/immap_qe.h  |  0
 .../include/asm => include/soc/fsl/qe}/qe.h        |  2 +-
 .../include/asm => include/soc/fsl/qe}/ucc.h       |  4 +--
 .../include/asm => include/soc/fsl/qe}/ucc_fast.h  |  6 ++--
 .../include/asm => include/soc/fsl/qe}/ucc_slow.h  |  6 ++--
 48 files changed, 127 insertions(+), 110 deletions(-)
 rename {arch/powerpc/sysdev/qe_lib => drivers/irqchip}/qe_ic.c (99%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/irqchip}/qe_ic.h (97%)
 create mode 100644 drivers/soc/fsl/Makefile
 create mode 100644 drivers/soc/fsl/qe/Kconfig
 create mode 100644 drivers/soc/fsl/qe/Makefile
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/qe.c (99%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/qe_common.c (99%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/ucc.c (98%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/ucc_fast.c (98%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/soc/fsl/qe}/ucc_slow.c (98%)
 rename {arch/powerpc/include/asm => include/linux/fsl/qe}/qe_ic.h (100%)
 rename {arch/powerpc/include/asm => include/soc/fsl/qe}/immap_qe.h (100%)
 rename {arch/powerpc/include/asm => include/soc/fsl/qe}/qe.h (99%)
 rename {arch/powerpc/include/asm => include/soc/fsl/qe}/ucc.h (96%)
 rename {arch/powerpc/include/asm => include/soc/fsl/qe}/ucc_fast.h (98%)
 rename {arch/powerpc/include/asm => include/soc/fsl/qe}/ucc_slow.h (99%)

diff --git a/MAINTAINERS b/MAINTAINERS
index 562ae4e..c688e61 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -4155,8 +4155,9 @@ F:	include/linux/fs_enet_pd.h
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
diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index ae111581..7ecd758 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -37,8 +37,8 @@
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <soc/fsl/qe/qe.h>
+#include <linux/fsl/qe/qe_ic.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index ef9d01a..eacf34b 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -17,7 +17,7 @@
 #include <asm/io.h>
 #include <asm/hw_irq.h>
 #include <asm/ipic.h>
-#include <asm/qe_ic.h>
+#include <linux/fsl/qe/qe_ic.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index aacc43f..20dce79 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -36,8 +36,8 @@
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <soc/fsl/qe/qe.h>
+#include <linux/fsl/qe/qe_ic.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index 0c7a43e..2e6a6a4 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -25,8 +25,8 @@
 #include <asm/time.h>
 #include <asm/ipic.h>
 #include <asm/udbg.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <soc/fsl/qe/qe.h>
+#include <linux/fsl/qe/qe_ic.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index eb24abd..b1b8ab8 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -44,8 +44,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include <sysdev/simple_gpio.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <soc/fsl/qe/qe.h>
+#include <linux/fsl/qe/qe_ic.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
index 823e370..9a5a00d 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -20,8 +20,8 @@
 #include <asm/time.h>
 #include <asm/ipic.h>
 #include <asm/udbg.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <soc/fsl/qe/qe.h>
+#include <linux/fsl/qe/qe_ic.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index 0f91edc..d81ea0c 100644
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
index bd839dc..1ecbf7f 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -27,7 +27,7 @@
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <asm/ehv_pic.h>
-#include <asm/qe_ic.h>
+#include <linux/fsl/qe/qe_ic.h>
 
 #include <linux/of_platform.h>
 #include <sysdev/fsl_soc.h>
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index a392e94..ea4d4f3 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -47,8 +47,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include <sysdev/simple_gpio.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <soc/fsl/qe/qe.h>
+#include <linux/fsl/qe/qe_ic.h>
 #include <asm/mpic.h>
 #include <asm/swiotlb.h>
 #include <asm/fsl_guts.h>
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index e358bed..0c5e313 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -25,8 +25,8 @@
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <soc/fsl/qe/qe.h>
+#include <linux/fsl/qe/qe_ic.h>
 #include <asm/fsl_guts.h>
 
 #include <sysdev/fsl_soc.h>
diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platforms/85xx/twr_p102x.c
index 30e002f..a47654e 100644
--- a/arch/powerpc/platforms/85xx/twr_p102x.c
+++ b/arch/powerpc/platforms/85xx/twr_p102x.c
@@ -21,8 +21,8 @@
 #include <asm/pci-bridge.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <soc/fsl/qe/qe.h>
+#include <linux/fsl/qe/qe_ic.h>
 #include <asm/fsl_guts.h>
 
 #include <sysdev/fsl_soc.h>
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index 01f98a2..c9541a5 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -272,26 +272,6 @@ config TAU_AVERAGE
 
 	  If in doubt, say N here.
 
-config QUICC_ENGINE
-	bool "Freescale QUICC Engine (QE) Support"
-	depends on FSL_SOC && PPC32
-	select PPC_LIB_RHEAP
-	select GENERIC_ALLOCATOR
-	select CRC32
-	help
-	  The QUICC Engine (QE) is a new generation of communications
-	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
-	  Selecting this option means that you wish to build a kernel
-	  for a machine with a QE coprocessor.
-
-config QE_GPIO
-	bool "QE GPIO support"
-	depends on QUICC_ENGINE
-	select ARCH_REQUIRE_GPIOLIB
-	help
-	  Say Y here if you're going to use hardware that connects to the
-	  QE GPIOs.
-
 config CPM2
 	bool "Enable support for the CPM2 (Communications Processor Module)"
 	depends on (FSL_SOC_BOOKE && PPC32) || 8260
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
 
diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/arch/powerpc/sysdev/qe_lib/Kconfig
index 3c25199..2f80075 100644
--- a/arch/powerpc/sysdev/qe_lib/Kconfig
+++ b/arch/powerpc/sysdev/qe_lib/Kconfig
@@ -1,24 +1,14 @@
 #
 # QE Communication options
 #
-
-config UCC_SLOW
-	bool
-	default y if SERIAL_QE
-	help
-	  This option provides qe_lib support to UCC slow
-	  protocols: UART, BISYNC, QMC
-
-config UCC_FAST
-	bool
-	default y if UCC_GETH
+config QE_GPIO
+	bool "QE GPIO support"
+	depends on QUICC_ENGINE
+	select ARCH_REQUIRE_GPIOLIB
 	help
-	  This option provides qe_lib support to UCC fast
-	  protocols: HDLC, Ethernet, ATM, transparent
+	  Say Y here if you're going to use hardware that connects to the
+	  QE GPIOs.
 
-config UCC
-	bool
-	default y if UCC_FAST || UCC_SLOW
 
 config QE_USB
 	bool
diff --git a/arch/powerpc/sysdev/qe_lib/Makefile b/arch/powerpc/sysdev/qe_lib/Makefile
index 9507a27..1b123df 100644
--- a/arch/powerpc/sysdev/qe_lib/Makefile
+++ b/arch/powerpc/sysdev/qe_lib/Makefile
@@ -1,10 +1,6 @@
 #
 # Makefile for the linux ppc-specific parts of QE
 #
-obj-$(CONFIG_QUICC_ENGINE)+= qe.o qe_common.o qe_ic.o qe_io.o
-
-obj-$(CONFIG_UCC)	+= ucc.o
-obj-$(CONFIG_UCC_SLOW)	+= ucc_slow.o
-obj-$(CONFIG_UCC_FAST)	+= ucc_fast.o
+obj-$(CONFIG_QUICC_ENGINE)+= qe_io.o
 obj-$(CONFIG_QE_USB)	+= usb.o
 obj-$(CONFIG_QE_GPIO)	+= gpio.o
diff --git a/arch/powerpc/sysdev/qe_lib/gpio.c b/arch/powerpc/sysdev/qe_lib/gpio.c
index 521e67a..aa5c11ac 100644
--- a/arch/powerpc/sysdev/qe_lib/gpio.c
+++ b/arch/powerpc/sysdev/qe_lib/gpio.c
@@ -21,7 +21,7 @@
 #include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/export.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/qe.h>
 
 struct qe_gpio_chip {
 	struct of_mm_gpio_chip mm_gc;
diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/arch/powerpc/sysdev/qe_lib/qe_io.c
index 7ea0174..7ae59ab 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_io.c
+++ b/arch/powerpc/sysdev/qe_lib/qe_io.c
@@ -21,7 +21,7 @@
 #include <linux/ioport.h>
 
 #include <asm/io.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/qe.h>
 #include <asm/prom.h>
 #include <sysdev/fsl_soc.h>
 
diff --git a/arch/powerpc/sysdev/qe_lib/usb.c b/arch/powerpc/sysdev/qe_lib/usb.c
index 27f23bd..111f7ab 100644
--- a/arch/powerpc/sysdev/qe_lib/usb.c
+++ b/arch/powerpc/sysdev/qe_lib/usb.c
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
diff --git a/drivers/irqchip/Makefile b/drivers/irqchip/Makefile
index dda4927..9ff5932 100644
--- a/drivers/irqchip/Makefile
+++ b/drivers/irqchip/Makefile
@@ -47,3 +47,4 @@ obj-$(CONFIG_KEYSTONE_IRQ)		+= irq-keystone.o
 obj-$(CONFIG_MIPS_GIC)			+= irq-mips-gic.o
 obj-$(CONFIG_ARCH_MEDIATEK)		+= irq-mtk-sysirq.o
 obj-$(CONFIG_ARCH_DIGICOLOR)		+= irq-digicolor.o
+obj-$(CONFIG_QUICC_ENGINE)		+= qe_ic.o
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/drivers/irqchip/qe_ic.c
similarity index 99%
rename from arch/powerpc/sysdev/qe_lib/qe_ic.c
rename to drivers/irqchip/qe_ic.c
index 6512cd8..e31d95b 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/drivers/irqchip/qe_ic.c
@@ -27,7 +27,7 @@
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/prom.h>
-#include <asm/qe_ic.h>
+#include <linux/fsl/qe/qe_ic.h>
 
 #include "qe_ic.h"
 
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.h b/drivers/irqchip/qe_ic.h
similarity index 97%
rename from arch/powerpc/sysdev/qe_lib/qe_ic.h
rename to drivers/irqchip/qe_ic.h
index efef7ab..9f15cc4 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.h
+++ b/drivers/irqchip/qe_ic.h
@@ -1,5 +1,5 @@
 /*
- * arch/powerpc/sysdev/qe_lib/qe_ic.h
+ * drivers/irqchip/qe_ic.h
  *
  * QUICC ENGINE Interrupt Controller Header
  *
@@ -16,7 +16,7 @@
 #ifndef _POWERPC_SYSDEV_QE_IC_H
 #define _POWERPC_SYSDEV_QE_IC_H
 
-#include <asm/qe_ic.h>
+#include <linux/fsl/qe/qe_ic.h>
 
 #define NR_QE_IC_INTS		64
 
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
index 4dd40e0..7d24664 100644
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
index d8bde82..676737a 100644
--- a/drivers/soc/Kconfig
+++ b/drivers/soc/Kconfig
@@ -1,5 +1,6 @@
 menu "SOC (System On Chip) specific Drivers"
 
+source "drivers/soc/fsl/qe/Kconfig"
 source "drivers/soc/mediatek/Kconfig"
 source "drivers/soc/qcom/Kconfig"
 source "drivers/soc/ti/Kconfig"
diff --git a/drivers/soc/Makefile b/drivers/soc/Makefile
index 70042b2..0259e23 100644
--- a/drivers/soc/Makefile
+++ b/drivers/soc/Makefile
@@ -2,6 +2,7 @@
 # Makefile for the Linux Kernel SOC specific device drivers.
 #
 
+obj-y				+= fsl/
 obj-$(CONFIG_ARCH_MEDIATEK)	+= mediatek/
 obj-$(CONFIG_ARCH_QCOM)		+= qcom/
 obj-$(CONFIG_ARCH_TEGRA)	+= tegra/
diff --git a/drivers/soc/fsl/Makefile b/drivers/soc/fsl/Makefile
new file mode 100644
index 0000000..7c7d045
--- /dev/null
+++ b/drivers/soc/fsl/Makefile
@@ -0,0 +1,5 @@
+#
+# Makefile for the Linux Kernel SOC fsl specific device drivers
+#
+
+obj-$(CONFIG_QUICC_ENGINE)		+= qe/
diff --git a/drivers/soc/fsl/qe/Kconfig b/drivers/soc/fsl/qe/Kconfig
new file mode 100644
index 0000000..3012571
--- /dev/null
+++ b/drivers/soc/fsl/qe/Kconfig
@@ -0,0 +1,33 @@
+#
+# QE Communication options
+#
+
+config QUICC_ENGINE
+	bool "Freescale QUICC Engine (QE) Support"
+	depends on FSL_SOC && PPC32
+	select PPC_LIB_RHEAP
+	select GENERIC_ALLOCATOR
+	select CRC32
+	help
+	  The QUICC Engine (QE) is a new generation of communications
+	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
+	  Selecting this option means that you wish to build a kernel
+	  for a machine with a QE coprocessor.
+
+config UCC_SLOW
+	bool
+	default y if SERIAL_QE
+	help
+	  This option provides qe_lib support to UCC slow
+	  protocols: UART, BISYNC, QMC
+
+config UCC_FAST
+	bool
+	default y if UCC_GETH
+	help
+	  This option provides qe_lib support to UCC fast
+	  protocols: HDLC, Ethernet, ATM, transparent
+
+config UCC
+	bool
+	default y if UCC_FAST || UCC_SLOW
diff --git a/drivers/soc/fsl/qe/Makefile b/drivers/soc/fsl/qe/Makefile
new file mode 100644
index 0000000..51c9dce
--- /dev/null
+++ b/drivers/soc/fsl/qe/Makefile
@@ -0,0 +1,9 @@
+#
+#Makefile for the Linux fsl parts of QE
+#
+
+
+obj-$(CONFIG_QUICC_ENGINE)+= qe.o qe_common.o
+obj-$(CONFIG_UCC)	+= ucc.o
+obj-$(CONFIG_UCC_SLOW)	+= ucc_slow.o
+obj-$(CONFIG_UCC_FAST)	+= ucc_fast.o
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/drivers/soc/fsl/qe/qe.c
similarity index 99%
rename from arch/powerpc/sysdev/qe_lib/qe.c
rename to drivers/soc/fsl/qe/qe.c
index 3f9f596..d8fd4cd 100644
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
index 0aa74ca..2541a5f 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_common.c
+++ b/drivers/soc/fsl/qe/qe_common.c
@@ -22,7 +22,7 @@
 #include <linux/slab.h>
 
 #include <linux/io.h>
-#include <asm/qe.h>
+#include <soc/fsl/qe/qe.h>
 
 static struct gen_pool *muram_pool;
 static spinlock_t cpm_muram_lock;
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
diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index 9c46a30..bcb26bb 100644
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
index 7d2532b..0b2cccd 100644
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
index e0822f1..f44659e 100644
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
 
diff --git a/arch/powerpc/include/asm/qe_ic.h b/include/linux/fsl/qe/qe_ic.h
similarity index 100%
rename from arch/powerpc/include/asm/qe_ic.h
rename to include/linux/fsl/qe/qe_ic.h
diff --git a/arch/powerpc/include/asm/immap_qe.h b/include/soc/fsl/qe/immap_qe.h
similarity index 100%
rename from arch/powerpc/include/asm/immap_qe.h
rename to include/soc/fsl/qe/immap_qe.h
diff --git a/arch/powerpc/include/asm/qe.h b/include/soc/fsl/qe/qe.h
similarity index 99%
rename from arch/powerpc/include/asm/qe.h
rename to include/soc/fsl/qe/qe.h
index c2dd8e6..d0694e0 100644
--- a/arch/powerpc/include/asm/qe.h
+++ b/include/soc/fsl/qe/qe.h
@@ -21,7 +21,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <asm/cpm.h>
-#include <asm/immap_qe.h>
+#include <soc/fsl/qe/immap_qe.h>
 #include <linux/of.h>
 #include <linux/of_address.h>
 #include <linux/types.h>
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
