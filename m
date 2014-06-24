Return-Path: <qiang.zhao@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1lp0139.outbound.protection.outlook.com [207.46.163.139])
 (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3CCF1A0195
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 Jun 2014 13:35:21 +1000 (EST)
From: Zhao Qiang <B45475@freescale.com>
To: <linuxppc-dev@lists.ozlabs.org>, <B07421@freescale.com>
Subject: [PATCH] qe: move qe from arch/powerpc to drivers
Date: Tue, 24 Jun 2014 11:31:52 +0800
Message-ID: <1403580712-30153-1-git-send-email-B45475@freescale.com>
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

ls1 has qe and ls1 has arm cpu.
move qe from arch/powerpc to drivers.

Signed-off-by: Zhao Qiang <B45475@freescale.com>
---
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
 arch/powerpc/platforms/Kconfig                     | 11 -------
 arch/powerpc/sysdev/qe_lib/Kconfig                 | 18 -----------
 arch/powerpc/sysdev/qe_lib/Makefile                |  5 ----
 arch/powerpc/sysdev/qe_lib/gpio.c                  |  2 +-
 arch/powerpc/sysdev/qe_lib/usb.c                   |  4 +--
 drivers/Kconfig                                    |  1 +
 drivers/Makefile                                   |  1 +
 drivers/net/ethernet/freescale/fsl_pq_mdio.c       |  2 +-
 drivers/net/ethernet/freescale/ucc_geth.c          |  8 ++---
 drivers/net/ethernet/freescale/ucc_geth.h          |  8 ++---
 drivers/qe/Kconfig                                 | 35 ++++++++++++++++++++++
 .../powerpc/sysdev/qe_lib => drivers/qe}/Makefile  |  2 --
 {arch/powerpc/sysdev/qe_lib => drivers/qe}/qe.c    |  4 +--
 {arch/powerpc/sysdev/qe_lib => drivers/qe}/qe_ic.c |  2 +-
 {arch/powerpc/sysdev/qe_lib => drivers/qe}/qe_ic.h |  2 +-
 {arch/powerpc/sysdev/qe_lib => drivers/qe}/qe_io.c |  2 +-
 {arch/powerpc/sysdev/qe_lib => drivers/qe}/ucc.c   |  6 ++--
 .../sysdev/qe_lib => drivers/qe}/ucc_fast.c        |  8 ++---
 .../sysdev/qe_lib => drivers/qe}/ucc_slow.c        |  8 ++---
 drivers/s390/net/qeth_core_mpc.h                   |  2 +-
 drivers/spi/spi-fsl-cpm.c                          |  2 +-
 drivers/tty/serial/ucc_uart.c                      |  2 +-
 drivers/usb/gadget/fsl_qe_udc.c                    |  2 +-
 drivers/usb/host/fhci-hcd.c                        |  2 +-
 drivers/usb/host/fhci-hub.c                        |  2 +-
 drivers/usb/host/fhci-sched.c                      |  2 +-
 drivers/usb/host/fhci.h                            |  4 +--
 .../include/asm => include/linux}/immap_qe.h       |  0
 {arch/powerpc/include/asm => include/linux}/qe.h   |  2 +-
 .../powerpc/include/asm => include/linux}/qe_ic.h  |  0
 {arch/powerpc/include/asm => include/linux}/ucc.h  |  4 +--
 .../include/asm => include/linux}/ucc_fast.h       |  6 ++--
 .../include/asm => include/linux}/ucc_slow.h       |  6 ++--
 44 files changed, 102 insertions(+), 101 deletions(-)
 create mode 100644 drivers/qe/Kconfig
 copy {arch/powerpc/sysdev/qe_lib => drivers/qe}/Makefile (76%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/qe}/qe.c (99%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/qe}/qe_ic.c (99%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/qe}/qe_ic.h (99%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/qe}/qe_io.c (99%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/qe}/ucc.c (98%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/qe}/ucc_fast.c (99%)
 rename {arch/powerpc/sysdev/qe_lib => drivers/qe}/ucc_slow.c (98%)
 rename {arch/powerpc/include/asm => include/linux}/immap_qe.h (100%)
 rename {arch/powerpc/include/asm => include/linux}/qe.h (99%)
 rename {arch/powerpc/include/asm => include/linux}/qe_ic.h (100%)
 rename {arch/powerpc/include/asm => include/linux}/ucc.h (97%)
 rename {arch/powerpc/include/asm => include/linux}/ucc_fast.h (99%)
 rename {arch/powerpc/include/asm => include/linux}/ucc_slow.h (99%)

diff --git a/arch/powerpc/platforms/83xx/km83xx.c b/arch/powerpc/platforms/83xx/km83xx.c
index bf4c447..22c0d6d 100644
--- a/arch/powerpc/platforms/83xx/km83xx.c
+++ b/arch/powerpc/platforms/83xx/km83xx.c
@@ -37,8 +37,8 @@
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <linux/qe.h>
+#include <linux/qe_ic.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/misc.c b/arch/powerpc/platforms/83xx/misc.c
index 125336f..cbc82d8 100644
--- a/arch/powerpc/platforms/83xx/misc.c
+++ b/arch/powerpc/platforms/83xx/misc.c
@@ -17,7 +17,7 @@
 #include <asm/io.h>
 #include <asm/hw_irq.h>
 #include <asm/ipic.h>
-#include <asm/qe_ic.h>
+#include <linux/qe_ic.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
diff --git a/arch/powerpc/platforms/83xx/mpc832x_mds.c b/arch/powerpc/platforms/83xx/mpc832x_mds.c
index 8d76220..27dbf52 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_mds.c
@@ -36,8 +36,8 @@
 #include <asm/udbg.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <linux/qe.h>
+#include <linux/qe_ic.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc832x_rdb.c b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
index eff5baa..616959a 100644
--- a/arch/powerpc/platforms/83xx/mpc832x_rdb.c
+++ b/arch/powerpc/platforms/83xx/mpc832x_rdb.c
@@ -25,8 +25,8 @@
 #include <asm/time.h>
 #include <asm/ipic.h>
 #include <asm/udbg.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <linux/qe.h>
+#include <linux/qe_ic.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
diff --git a/arch/powerpc/platforms/83xx/mpc836x_mds.c b/arch/powerpc/platforms/83xx/mpc836x_mds.c
index 1a26d2f..cdc8165 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_mds.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_mds.c
@@ -44,8 +44,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include <sysdev/simple_gpio.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <linux/qe.h>
+#include <linux/qe_ic.h>
 
 #include "mpc83xx.h"
 
diff --git a/arch/powerpc/platforms/83xx/mpc836x_rdk.c b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
index b63b42d..c850c67 100644
--- a/arch/powerpc/platforms/83xx/mpc836x_rdk.c
+++ b/arch/powerpc/platforms/83xx/mpc836x_rdk.c
@@ -20,8 +20,8 @@
 #include <asm/time.h>
 #include <asm/ipic.h>
 #include <asm/udbg.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <linux/qe.h>
+#include <linux/qe_ic.h>
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 
diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
index b564b5e..ec0bde9 100644
--- a/arch/powerpc/platforms/85xx/common.c
+++ b/arch/powerpc/platforms/85xx/common.c
@@ -9,7 +9,7 @@
 #include <linux/of_irq.h>
 #include <linux/of_platform.h>
 
-#include <asm/qe.h>
+#include <linux/qe.h>
 #include <sysdev/cpm2_pic.h>
 
 #include "mpc85xx.h"
diff --git a/arch/powerpc/platforms/85xx/corenet_generic.c b/arch/powerpc/platforms/85xx/corenet_generic.c
index 5db1e11..2a9ff3e 100644
--- a/arch/powerpc/platforms/85xx/corenet_generic.c
+++ b/arch/powerpc/platforms/85xx/corenet_generic.c
@@ -26,7 +26,7 @@
 #include <asm/udbg.h>
 #include <asm/mpic.h>
 #include <asm/ehv_pic.h>
-#include <asm/qe_ic.h>
+#include <linux/qe_ic.h>
 
 #include <linux/of_platform.h>
 #include <sysdev/fsl_soc.h>
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_mds.c b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
index a392e94..016c936 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_mds.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_mds.c
@@ -47,8 +47,8 @@
 #include <sysdev/fsl_soc.h>
 #include <sysdev/fsl_pci.h>
 #include <sysdev/simple_gpio.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <linux/qe.h>
+#include <linux/qe_ic.h>
 #include <asm/mpic.h>
 #include <asm/swiotlb.h>
 #include <asm/fsl_guts.h>
diff --git a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
index e358bed..6d1ca89 100644
--- a/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
+++ b/arch/powerpc/platforms/85xx/mpc85xx_rdb.c
@@ -25,8 +25,8 @@
 #include <asm/prom.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <linux/qe.h>
+#include <linux/qe_ic.h>
 #include <asm/fsl_guts.h>
 
 #include <sysdev/fsl_soc.h>
diff --git a/arch/powerpc/platforms/85xx/twr_p102x.c b/arch/powerpc/platforms/85xx/twr_p102x.c
index 1eadb6d..d73a8d0 100644
--- a/arch/powerpc/platforms/85xx/twr_p102x.c
+++ b/arch/powerpc/platforms/85xx/twr_p102x.c
@@ -21,8 +21,8 @@
 #include <asm/pci-bridge.h>
 #include <asm/udbg.h>
 #include <asm/mpic.h>
-#include <asm/qe.h>
-#include <asm/qe_ic.h>
+#include <linux/qe.h>
+#include <linux/qe_ic.h>
 #include <asm/fsl_guts.h>
 
 #include <sysdev/fsl_soc.h>
diff --git a/arch/powerpc/platforms/Kconfig b/arch/powerpc/platforms/Kconfig
index bf9c6d4..b30657a 100644
--- a/arch/powerpc/platforms/Kconfig
+++ b/arch/powerpc/platforms/Kconfig
@@ -278,17 +278,6 @@ config TAU_AVERAGE
 
 	  If in doubt, say N here.
 
-config QUICC_ENGINE
-	bool "Freescale QUICC Engine (QE) Support"
-	depends on FSL_SOC && PPC32
-	select PPC_LIB_RHEAP
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
diff --git a/arch/powerpc/sysdev/qe_lib/Kconfig b/arch/powerpc/sysdev/qe_lib/Kconfig
index 3c25199..e77b5cc 100644
--- a/arch/powerpc/sysdev/qe_lib/Kconfig
+++ b/arch/powerpc/sysdev/qe_lib/Kconfig
@@ -2,24 +2,6 @@
 # QE Communication options
 #
 
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
-	help
-	  This option provides qe_lib support to UCC fast
-	  protocols: HDLC, Ethernet, ATM, transparent
-
-config UCC
-	bool
-	default y if UCC_FAST || UCC_SLOW
-
 config QE_USB
 	bool
 	default y if USB_FSL_QE
diff --git a/arch/powerpc/sysdev/qe_lib/Makefile b/arch/powerpc/sysdev/qe_lib/Makefile
index f1855c1..ed3316e 100644
--- a/arch/powerpc/sysdev/qe_lib/Makefile
+++ b/arch/powerpc/sysdev/qe_lib/Makefile
@@ -1,10 +1,5 @@
 #
 # Makefile for the linux ppc-specific parts of QE
 #
-obj-$(CONFIG_QUICC_ENGINE)+= qe.o qe_ic.o qe_io.o
-
-obj-$(CONFIG_UCC)	+= ucc.o
-obj-$(CONFIG_UCC_SLOW)	+= ucc_slow.o
-obj-$(CONFIG_UCC_FAST)	+= ucc_fast.o
 obj-$(CONFIG_QE_USB)	+= usb.o
 obj-$(CONFIG_QE_GPIO)	+= gpio.o
diff --git a/arch/powerpc/sysdev/qe_lib/gpio.c b/arch/powerpc/sysdev/qe_lib/gpio.c
index 521e67a..764bd93 100644
--- a/arch/powerpc/sysdev/qe_lib/gpio.c
+++ b/arch/powerpc/sysdev/qe_lib/gpio.c
@@ -21,7 +21,7 @@
 #include <linux/gpio.h>
 #include <linux/slab.h>
 #include <linux/export.h>
-#include <asm/qe.h>
+#include <linux/qe.h>
 
 struct qe_gpio_chip {
 	struct of_mm_gpio_chip mm_gc;
diff --git a/arch/powerpc/sysdev/qe_lib/usb.c b/arch/powerpc/sysdev/qe_lib/usb.c
index 27f23bd..d246a39 100644
--- a/arch/powerpc/sysdev/qe_lib/usb.c
+++ b/arch/powerpc/sysdev/qe_lib/usb.c
@@ -17,8 +17,8 @@
 #include <linux/errno.h>
 #include <linux/export.h>
 #include <linux/io.h>
-#include <asm/immap_qe.h>
-#include <asm/qe.h>
+#include <linux/immap_qe.h>
+#include <linux/qe.h>
 
 int qe_usb_clock_set(enum qe_clock clk, int rate)
 {
diff --git a/drivers/Kconfig b/drivers/Kconfig
index 0a0a90f..719d2d2 100644
--- a/drivers/Kconfig
+++ b/drivers/Kconfig
@@ -174,4 +174,5 @@ source "drivers/powercap/Kconfig"
 
 source "drivers/mcb/Kconfig"
 
+source "drivers/qe/Kconfig"
 endmenu
diff --git a/drivers/Makefile b/drivers/Makefile
index d05d81b..75b0081 100644
--- a/drivers/Makefile
+++ b/drivers/Makefile
@@ -93,6 +93,7 @@ obj-$(CONFIG_SERIO)		+= input/serio/
 obj-$(CONFIG_GAMEPORT)		+= input/gameport/
 obj-$(CONFIG_INPUT)		+= input/
 obj-$(CONFIG_I2O)		+= message/
+obj-$(CONFIG_QUICC_ENGINE)	+= qe/
 obj-$(CONFIG_RTC_LIB)		+= rtc/
 obj-y				+= i2c/ media/
 obj-$(CONFIG_PPS)		+= pps/
diff --git a/drivers/net/ethernet/freescale/fsl_pq_mdio.c b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
index 583e71a..d0222a6 100644
--- a/drivers/net/ethernet/freescale/fsl_pq_mdio.c
+++ b/drivers/net/ethernet/freescale/fsl_pq_mdio.c
@@ -28,7 +28,7 @@
 #include <linux/of_device.h>
 
 #include <asm/io.h>
-#include <asm/ucc.h>	/* for ucc_set_qe_mux_mii_mng() */
+#include <linux/ucc.h>	/* for ucc_set_qe_mux_mii_mng() */
 
 #include "gianfar.h"
 
diff --git a/drivers/net/ethernet/freescale/ucc_geth.c b/drivers/net/ethernet/freescale/ucc_geth.c
index c8299c3..ee2f1ff 100644
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
+#include <linux/immap_qe.h>
+#include <linux/qe.h>
+#include <linux/ucc.h>
+#include <linux/ucc_fast.h>
 #include <asm/machdep.h>
 
 #include "ucc_geth.h"
diff --git a/drivers/net/ethernet/freescale/ucc_geth.h b/drivers/net/ethernet/freescale/ucc_geth.h
index 75f3371..15b64c0 100644
--- a/drivers/net/ethernet/freescale/ucc_geth.h
+++ b/drivers/net/ethernet/freescale/ucc_geth.h
@@ -22,11 +22,11 @@
 #include <linux/list.h>
 #include <linux/if_ether.h>
 
-#include <asm/immap_qe.h>
-#include <asm/qe.h>
+#include <linux/immap_qe.h>
+#include <linux/qe.h>
 
-#include <asm/ucc.h>
-#include <asm/ucc_fast.h>
+#include <linux/ucc.h>
+#include <linux/ucc_fast.h>
 
 #define DRV_DESC "QE UCC Gigabit Ethernet Controller"
 #define DRV_NAME "ucc_geth"
diff --git a/drivers/qe/Kconfig b/drivers/qe/Kconfig
new file mode 100644
index 0000000..dc16e9a
--- /dev/null
+++ b/drivers/qe/Kconfig
@@ -0,0 +1,35 @@
+#
+# QE Communication options
+#
+menuconfig QUICC_ENGINE
+	bool "Freescale QUICC Engine (QE) Support"
+	depends on FSL_SOC && PPC32
+	select PPC_LIB_RHEAP
+	select CRC32
+	help
+	  The QUICC Engine (QE) is a new generation of communications
+	  coprocessors on Freescale embedded CPUs (akin to CPM in older chips).
+	  Selecting this option means that you wish to build a kernel
+	  for a machine with a QE coprocessor.
+
+if QUICC_ENGINE
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
+
+endif
diff --git a/arch/powerpc/sysdev/qe_lib/Makefile b/drivers/qe/Makefile
similarity index 76%
copy from arch/powerpc/sysdev/qe_lib/Makefile
copy to drivers/qe/Makefile
index f1855c1..874fe1a 100644
--- a/arch/powerpc/sysdev/qe_lib/Makefile
+++ b/drivers/qe/Makefile
@@ -6,5 +6,3 @@ obj-$(CONFIG_QUICC_ENGINE)+= qe.o qe_ic.o qe_io.o
 obj-$(CONFIG_UCC)	+= ucc.o
 obj-$(CONFIG_UCC_SLOW)	+= ucc_slow.o
 obj-$(CONFIG_UCC_FAST)	+= ucc_fast.o
-obj-$(CONFIG_QE_USB)	+= usb.o
-obj-$(CONFIG_QE_GPIO)	+= gpio.o
diff --git a/arch/powerpc/sysdev/qe_lib/qe.c b/drivers/qe/qe.c
similarity index 99%
rename from arch/powerpc/sysdev/qe_lib/qe.c
rename to drivers/qe/qe.c
index 238a07b..4f443f6 100644
--- a/arch/powerpc/sysdev/qe_lib/qe.c
+++ b/drivers/qe/qe.c
@@ -32,8 +32,8 @@
 #include <asm/irq.h>
 #include <asm/page.h>
 #include <asm/pgtable.h>
-#include <asm/immap_qe.h>
-#include <asm/qe.h>
+#include <linux/immap_qe.h>
+#include <linux/qe.h>
 #include <asm/prom.h>
 #include <asm/rheap.h>
 
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.c b/drivers/qe/qe_ic.c
similarity index 99%
rename from arch/powerpc/sysdev/qe_lib/qe_ic.c
rename to drivers/qe/qe_ic.c
index b2b87c3..f7e3d55 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.c
+++ b/drivers/qe/qe_ic.c
@@ -28,7 +28,7 @@
 #include <asm/irq.h>
 #include <asm/io.h>
 #include <asm/prom.h>
-#include <asm/qe_ic.h>
+#include <linux/qe_ic.h>
 
 #include "qe_ic.h"
 
diff --git a/arch/powerpc/sysdev/qe_lib/qe_ic.h b/drivers/qe/qe_ic.h
similarity index 99%
rename from arch/powerpc/sysdev/qe_lib/qe_ic.h
rename to drivers/qe/qe_ic.h
index efef7ab..d98a864 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_ic.h
+++ b/drivers/qe/qe_ic.h
@@ -16,7 +16,7 @@
 #ifndef _POWERPC_SYSDEV_QE_IC_H
 #define _POWERPC_SYSDEV_QE_IC_H
 
-#include <asm/qe_ic.h>
+#include <linux/qe_ic.h>
 
 #define NR_QE_IC_INTS		64
 
diff --git a/arch/powerpc/sysdev/qe_lib/qe_io.c b/drivers/qe/qe_io.c
similarity index 99%
rename from arch/powerpc/sysdev/qe_lib/qe_io.c
rename to drivers/qe/qe_io.c
index d099941..6d1edc4 100644
--- a/arch/powerpc/sysdev/qe_lib/qe_io.c
+++ b/drivers/qe/qe_io.c
@@ -21,7 +21,7 @@
 #include <linux/ioport.h>
 
 #include <asm/io.h>
-#include <asm/qe.h>
+#include <linux/qe.h>
 #include <asm/prom.h>
 #include <sysdev/fsl_soc.h>
 
diff --git a/arch/powerpc/sysdev/qe_lib/ucc.c b/drivers/qe/ucc.c
similarity index 98%
rename from arch/powerpc/sysdev/qe_lib/ucc.c
rename to drivers/qe/ucc.c
index 621575b..274f7b3 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc.c
+++ b/drivers/qe/ucc.c
@@ -21,9 +21,9 @@
 
 #include <asm/irq.h>
 #include <asm/io.h>
-#include <asm/immap_qe.h>
-#include <asm/qe.h>
-#include <asm/ucc.h>
+#include <linux/immap_qe.h>
+#include <linux/qe.h>
+#include <linux/ucc.h>
 
 int ucc_set_qe_mux_mii_mng(unsigned int ucc_num)
 {
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_fast.c b/drivers/qe/ucc_fast.c
similarity index 99%
rename from arch/powerpc/sysdev/qe_lib/ucc_fast.c
rename to drivers/qe/ucc_fast.c
index 65aaf15..d2c054a 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_fast.c
+++ b/drivers/qe/ucc_fast.c
@@ -21,11 +21,11 @@
 #include <linux/export.h>
 
 #include <asm/io.h>
-#include <asm/immap_qe.h>
-#include <asm/qe.h>
+#include <linux/immap_qe.h>
+#include <linux/qe.h>
 
-#include <asm/ucc.h>
-#include <asm/ucc_fast.h>
+#include <linux/ucc.h>
+#include <linux/ucc_fast.h>
 
 void ucc_fast_dump_regs(struct ucc_fast_private * uccf)
 {
diff --git a/arch/powerpc/sysdev/qe_lib/ucc_slow.c b/drivers/qe/ucc_slow.c
similarity index 98%
rename from arch/powerpc/sysdev/qe_lib/ucc_slow.c
rename to drivers/qe/ucc_slow.c
index befaf11..25d909b 100644
--- a/arch/powerpc/sysdev/qe_lib/ucc_slow.c
+++ b/drivers/qe/ucc_slow.c
@@ -21,11 +21,11 @@
 #include <linux/export.h>
 
 #include <asm/io.h>
-#include <asm/immap_qe.h>
-#include <asm/qe.h>
+#include <linux/immap_qe.h>
+#include <linux/qe.h>
 
-#include <asm/ucc.h>
-#include <asm/ucc_slow.h>
+#include <linux/ucc.h>
+#include <linux/ucc_slow.h>
 
 u32 ucc_slow_get_qe_cr_subblock(int uccs_num)
 {
diff --git a/drivers/s390/net/qeth_core_mpc.h b/drivers/s390/net/qeth_core_mpc.h
index cf6a90e..27664c9 100644
--- a/drivers/s390/net/qeth_core_mpc.h
+++ b/drivers/s390/net/qeth_core_mpc.h
@@ -8,7 +8,7 @@
 #ifndef __QETH_CORE_MPC_H__
 #define __QETH_CORE_MPC_H__
 
-#include <asm/qeth.h>
+#include <linux/qeth.h>
 
 #define IPA_PDU_HEADER_SIZE	0x40
 #define QETH_IPA_PDU_LEN_TOTAL(buffer) (buffer + 0x0e)
diff --git a/drivers/spi/spi-fsl-cpm.c b/drivers/spi/spi-fsl-cpm.c
index 54b0637..37114fc 100644
--- a/drivers/spi/spi-fsl-cpm.c
+++ b/drivers/spi/spi-fsl-cpm.c
@@ -22,7 +22,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/of_address.h>
 #include <asm/cpm.h>
-#include <asm/qe.h>
+#include <linux/qe.h>
 
 #include "spi-fsl-lib.h"
 #include "spi-fsl-cpm.h"
diff --git a/drivers/tty/serial/ucc_uart.c b/drivers/tty/serial/ucc_uart.c
index d569ca5..862c0ec 100644
--- a/drivers/tty/serial/ucc_uart.c
+++ b/drivers/tty/serial/ucc_uart.c
@@ -31,7 +31,7 @@
 #include <linux/dma-mapping.h>
 
 #include <linux/fs_uart_pd.h>
-#include <asm/ucc_slow.h>
+#include <linux/ucc_slow.h>
 
 #include <linux/firmware.h>
 #include <asm/reg.h>
diff --git a/drivers/usb/gadget/fsl_qe_udc.c b/drivers/usb/gadget/fsl_qe_udc.c
index ad54833..126b9d1 100644
--- a/drivers/usb/gadget/fsl_qe_udc.c
+++ b/drivers/usb/gadget/fsl_qe_udc.c
@@ -38,7 +38,7 @@
 #include <linux/usb/ch9.h>
 #include <linux/usb/gadget.h>
 #include <linux/usb/otg.h>
-#include <asm/qe.h>
+#include <linux/qe.h>
 #include <asm/cpm.h>
 #include <asm/dma.h>
 #include <asm/reg.h>
diff --git a/drivers/usb/host/fhci-hcd.c b/drivers/usb/host/fhci-hcd.c
index 1cf68ea..66b8cb0 100644
--- a/drivers/usb/host/fhci-hcd.c
+++ b/drivers/usb/host/fhci-hcd.c
@@ -31,7 +31,7 @@
 #include <linux/of_platform.h>
 #include <linux/of_gpio.h>
 #include <linux/slab.h>
-#include <asm/qe.h>
+#include <linux/qe.h>
 #include <asm/fsl_gtm.h>
 #include "fhci.h"
 
diff --git a/drivers/usb/host/fhci-hub.c b/drivers/usb/host/fhci-hub.c
index 6af2512..ee8ddfa 100644
--- a/drivers/usb/host/fhci-hub.c
+++ b/drivers/usb/host/fhci-hub.c
@@ -24,7 +24,7 @@
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
 #include <linux/gpio.h>
-#include <asm/qe.h>
+#include <linux/qe.h>
 #include "fhci.h"
 
 /* virtual root hub specific descriptor */
diff --git a/drivers/usb/host/fhci-sched.c b/drivers/usb/host/fhci-sched.c
index 95ca598..04b0706 100644
--- a/drivers/usb/host/fhci-sched.c
+++ b/drivers/usb/host/fhci-sched.c
@@ -25,7 +25,7 @@
 #include <linux/io.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
-#include <asm/qe.h>
+#include <linux/qe.h>
 #include <asm/fsl_gtm.h>
 #include "fhci.h"
 
diff --git a/drivers/usb/host/fhci.h b/drivers/usb/host/fhci.h
index 154e6a0..13489c2 100644
--- a/drivers/usb/host/fhci.h
+++ b/drivers/usb/host/fhci.h
@@ -27,8 +27,8 @@
 #include <linux/io.h>
 #include <linux/usb.h>
 #include <linux/usb/hcd.h>
-#include <asm/qe.h>
-#include <asm/immap_qe.h>
+#include <linux/qe.h>
+#include <linux/immap_qe.h>
 
 #define USB_CLOCK	48000000
 
diff --git a/arch/powerpc/include/asm/immap_qe.h b/include/linux/immap_qe.h
similarity index 100%
rename from arch/powerpc/include/asm/immap_qe.h
rename to include/linux/immap_qe.h
diff --git a/arch/powerpc/include/asm/qe.h b/include/linux/qe.h
similarity index 99%
rename from arch/powerpc/include/asm/qe.h
rename to include/linux/qe.h
index 32b9bfa..668ef6d 100644
--- a/arch/powerpc/include/asm/qe.h
+++ b/include/linux/qe.h
@@ -20,7 +20,7 @@
 #include <linux/errno.h>
 #include <linux/err.h>
 #include <asm/cpm.h>
-#include <asm/immap_qe.h>
+#include <linux/immap_qe.h>
 
 #define QE_NUM_OF_SNUM	256	/* There are 256 serial number in QE */
 #define QE_NUM_OF_BRGS	16
diff --git a/arch/powerpc/include/asm/qe_ic.h b/include/linux/qe_ic.h
similarity index 100%
rename from arch/powerpc/include/asm/qe_ic.h
rename to include/linux/qe_ic.h
diff --git a/arch/powerpc/include/asm/ucc.h b/include/linux/ucc.h
similarity index 97%
rename from arch/powerpc/include/asm/ucc.h
rename to include/linux/ucc.h
index 6927ac2..6d8d309 100644
--- a/arch/powerpc/include/asm/ucc.h
+++ b/include/linux/ucc.h
@@ -15,8 +15,8 @@
 #ifndef __UCC_H__
 #define __UCC_H__
 
-#include <asm/immap_qe.h>
-#include <asm/qe.h>
+#include <linux/immap_qe.h>
+#include <linux/qe.h>
 
 #define STATISTICS
 
diff --git a/arch/powerpc/include/asm/ucc_fast.h b/include/linux/ucc_fast.h
similarity index 99%
rename from arch/powerpc/include/asm/ucc_fast.h
rename to include/linux/ucc_fast.h
index 72ea9ba..4abc034 100644
--- a/arch/powerpc/include/asm/ucc_fast.h
+++ b/include/linux/ucc_fast.h
@@ -16,10 +16,10 @@
 
 #include <linux/kernel.h>
 
-#include <asm/immap_qe.h>
-#include <asm/qe.h>
+#include <linux/immap_qe.h>
+#include <linux/qe.h>
 
-#include <asm/ucc.h>
+#include <linux/ucc.h>
 
 /* Receive BD's status */
 #define R_E	0x80000000	/* buffer empty */
diff --git a/arch/powerpc/include/asm/ucc_slow.h b/include/linux/ucc_slow.h
similarity index 99%
rename from arch/powerpc/include/asm/ucc_slow.h
rename to include/linux/ucc_slow.h
index c44131e..f1e0061 100644
--- a/arch/powerpc/include/asm/ucc_slow.h
+++ b/include/linux/ucc_slow.h
@@ -17,10 +17,10 @@
 
 #include <linux/kernel.h>
 
-#include <asm/immap_qe.h>
-#include <asm/qe.h>
+#include <linux/immap_qe.h>
+#include <linux/qe.h>
 
-#include <asm/ucc.h>
+#include <linux/ucc.h>
 
 /* transmit BD's status */
 #define T_R	0x80000000	/* ready bit */
-- 
1.8.5
