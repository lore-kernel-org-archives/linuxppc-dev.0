Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 40yRV53JDczF0dY
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  2 Jun 2018 13:27:57 +1000 (AEST)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Cc: Michael Schmitz <schmitzmic@gmail.com>, <linuxppc-dev@lists.ozlabs.org>,
 <linux-m68k@lists.linux-m68k.org>, <linux-kernel@vger.kernel.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Message-Id: <de8edb03dbd2fd25b53d0bdf9c6d65adf9aa0aa3.1527909627.git.fthain@telegraphics.com.au>
In-Reply-To: <73507a3e9444da17c222cf74df41842ce30d15ee.1527909627.git.fthain@telegraphics.com.au>
References: <cover.1527909627.git.fthain@telegraphics.com.au>
 <f32f4e3a0fd736152f768b7a00bfc731daba1629.1527909627.git.fthain@telegraphics.com.au>
 <7ce9a8c3996506ae6f9ab16b3cf73c287e205a89.1527909627.git.fthain@telegraphics.com.au>
 <8597ac466215f573d8bea40e74fdec2bf72fabbb.1527909627.git.fthain@telegraphics.com.au>
 <878b389293851359e53de186bf302ce52d95ad95.1527909627.git.fthain@telegraphics.com.au>
 <adba0545c06cd6c67e26c433990d036b0d7e968c.1527909627.git.fthain@telegraphics.com.au>
 <166b4c3a7347fe27f12bda86d50533cd01ee11b9.1527909627.git.fthain@telegraphics.com.au>
 <73507a3e9444da17c222cf74df41842ce30d15ee.1527909627.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 08/11] macintosh/via-pmu: Replace via-pmu68k driver with
 via-pmu driver
Date: Fri,  1 Jun 2018 23:27:51 -0400 (EDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that the PowerMac via-pmu driver supports m68k PowerBooks,
switch over to that driver and remove the via-pmu68k driver.

Don't call pmu_shutdown() or pmu_restart() on early PowerBooks:
the PMU device found in these PowerBooks isn't supported.

Cc: Geert Uytterhoeven <geert@linux-m68k.org>
Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/configs/mac_defconfig   |   2 +-
 arch/m68k/configs/multi_defconfig |   2 +-
 arch/m68k/mac/config.c            |   2 +-
 arch/m68k/mac/misc.c              |  54 +--
 drivers/macintosh/Kconfig         |  13 +-
 drivers/macintosh/Makefile        |   1 -
 drivers/macintosh/adb.c           |   2 +-
 drivers/macintosh/via-pmu68k.c    | 850 --------------------------------------
 include/uapi/linux/pmu.h          |   2 -
 9 files changed, 15 insertions(+), 913 deletions(-)
 delete mode 100644 drivers/macintosh/via-pmu68k.c

diff --git a/arch/m68k/configs/mac_defconfig b/arch/m68k/configs/mac_defconfig
index efbcaffa30ed..6b2ce72c5c9f 100644
--- a/arch/m68k/configs/mac_defconfig
+++ b/arch/m68k/configs/mac_defconfig
@@ -363,7 +363,7 @@ CONFIG_TCM_PSCSI=m
 CONFIG_ADB=y
 CONFIG_ADB_MACII=y
 CONFIG_ADB_IOP=y
-CONFIG_ADB_PMU68K=y
+CONFIG_ADB_PMU=y
 CONFIG_ADB_CUDA=y
 CONFIG_INPUT_ADBHID=y
 CONFIG_MAC_EMUMOUSEBTN=y
diff --git a/arch/m68k/configs/multi_defconfig b/arch/m68k/configs/multi_defconfig
index e78a205d266a..aa8e78987e83 100644
--- a/arch/m68k/configs/multi_defconfig
+++ b/arch/m68k/configs/multi_defconfig
@@ -396,7 +396,7 @@ CONFIG_TCM_PSCSI=m
 CONFIG_ADB=y
 CONFIG_ADB_MACII=y
 CONFIG_ADB_IOP=y
-CONFIG_ADB_PMU68K=y
+CONFIG_ADB_PMU=y
 CONFIG_ADB_CUDA=y
 CONFIG_INPUT_ADBHID=y
 CONFIG_MAC_EMUMOUSEBTN=y
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 36086cceb537..7b8e706cef9b 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -891,7 +891,7 @@ static void __init mac_identify(void)
 #ifdef CONFIG_ADB_CUDA
 	find_via_cuda();
 #endif
-#ifdef CONFIG_ADB_PMU68K
+#ifdef CONFIG_ADB_PMU
 	find_via_pmu();
 #endif
 }
diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index c68054361615..28090a44fa09 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -85,7 +85,7 @@ static void cuda_write_pram(int offset, __u8 data)
 }
 #endif /* CONFIG_ADB_CUDA */
 
-#ifdef CONFIG_ADB_PMU68K
+#ifdef CONFIG_ADB_PMU
 static long pmu_read_time(void)
 {
 	struct adb_request req;
@@ -136,7 +136,7 @@ static void pmu_write_pram(int offset, __u8 data)
 	while (!req.complete)
 		pmu_poll();
 }
-#endif /* CONFIG_ADB_PMU68K */
+#endif /* CONFIG_ADB_PMU */
 
 /*
  * VIA PRAM/RTC access routines
@@ -367,38 +367,6 @@ static void cuda_shutdown(void)
 }
 #endif /* CONFIG_ADB_CUDA */
 
-#ifdef CONFIG_ADB_PMU68K
-
-void pmu_restart(void)
-{
-	struct adb_request req;
-	if (pmu_request(&req, NULL,
-			2, PMU_SET_INTR_MASK, PMU_INT_ADB|PMU_INT_TICK) < 0)
-		return;
-	while (!req.complete)
-		pmu_poll();
-	if (pmu_request(&req, NULL, 1, PMU_RESET) < 0)
-		return;
-	while (!req.complete)
-		pmu_poll();
-}
-
-void pmu_shutdown(void)
-{
-	struct adb_request req;
-	if (pmu_request(&req, NULL,
-			2, PMU_SET_INTR_MASK, PMU_INT_ADB|PMU_INT_TICK) < 0)
-		return;
-	while (!req.complete)
-		pmu_poll();
-	if (pmu_request(&req, NULL, 5, PMU_SHUTDOWN, 'M', 'A', 'T', 'T') < 0)
-		return;
-	while (!req.complete)
-		pmu_poll();
-}
-
-#endif
-
 /*
  *-------------------------------------------------------------------
  * Below this point are the generic routines; they'll dispatch to the
@@ -423,7 +391,7 @@ void mac_pram_read(int offset, __u8 *buffer, int len)
 		func = cuda_read_pram;
 		break;
 #endif
-#ifdef CONFIG_ADB_PMU68K
+#ifdef CONFIG_ADB_PMU
 	case MAC_ADB_PB2:
 		func = pmu_read_pram;
 		break;
@@ -453,7 +421,7 @@ void mac_pram_write(int offset, __u8 *buffer, int len)
 		func = cuda_write_pram;
 		break;
 #endif
-#ifdef CONFIG_ADB_PMU68K
+#ifdef CONFIG_ADB_PMU
 	case MAC_ADB_PB2:
 		func = pmu_write_pram;
 		break;
@@ -477,9 +445,8 @@ void mac_poweroff(void)
 	           macintosh_config->adb_type == MAC_ADB_CUDA) {
 		cuda_shutdown();
 #endif
-#ifdef CONFIG_ADB_PMU68K
-	} else if (macintosh_config->adb_type == MAC_ADB_PB1
-		|| macintosh_config->adb_type == MAC_ADB_PB2) {
+#ifdef CONFIG_ADB_PMU
+	} else if (macintosh_config->adb_type == MAC_ADB_PB2) {
 		pmu_shutdown();
 #endif
 	}
@@ -519,9 +486,8 @@ void mac_reset(void)
 	           macintosh_config->adb_type == MAC_ADB_CUDA) {
 		cuda_restart();
 #endif
-#ifdef CONFIG_ADB_PMU68K
-	} else if (macintosh_config->adb_type == MAC_ADB_PB1
-		|| macintosh_config->adb_type == MAC_ADB_PB2) {
+#ifdef CONFIG_ADB_PMU
+	} else if (macintosh_config->adb_type == MAC_ADB_PB2) {
 		pmu_restart();
 #endif
 	} else if (CPU_IS_030) {
@@ -672,7 +638,7 @@ int mac_hwclk(int op, struct rtc_time *t)
 			now = cuda_read_time();
 			break;
 #endif
-#ifdef CONFIG_ADB_PMU68K
+#ifdef CONFIG_ADB_PMU
 		case MAC_ADB_PB2:
 			now = pmu_read_time();
 			break;
@@ -708,7 +674,7 @@ int mac_hwclk(int op, struct rtc_time *t)
 			cuda_write_time(now);
 			break;
 #endif
-#ifdef CONFIG_ADB_PMU68K
+#ifdef CONFIG_ADB_PMU
 		case MAC_ADB_PB2:
 			pmu_write_time(now);
 			break;
diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 26abae4c899d..47c350cdfb12 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -39,17 +39,6 @@ config ADB_IOP
 	  <http://www.angelfire.com/ca2/dev68k/iopdesc.html> to enable direct
 	  support for it, say 'Y' here.
 
-config ADB_PMU68K
-	bool "Include PMU (Powerbook) ADB driver"
-	depends on ADB && MAC
-	help
-	  Say Y here if want your kernel to support the m68k based Powerbooks.
-	  This includes the PowerBook 140, PowerBook 145, PowerBook 150,
-	  PowerBook 160, PowerBook 165, PowerBook 165c, PowerBook 170,
-	  PowerBook 180, PowerBook, 180c, PowerBook 190cs, PowerBook 520,
-	  PowerBook Duo 210, PowerBook Duo 230, PowerBook Duo 250,
-	  PowerBook Duo 270c, PowerBook Duo 280 and PowerBook Duo 280c.
-
 # we want to change this to something like CONFIG_SYSCTRL_CUDA/PMU
 config ADB_CUDA
 	bool "Support for Cuda/Egret based Macs and PowerMacs"
@@ -66,7 +55,7 @@ config ADB_CUDA
 
 config ADB_PMU
 	bool "Support for PMU based PowerMacs and PowerBooks"
-	depends on PPC_PMAC
+	depends on PPC_PMAC || MAC
 	help
 	  On PowerBooks, iBooks, and recent iMacs and Power Macintoshes, the
 	  PMU is an embedded microprocessor whose primary function is to
diff --git a/drivers/macintosh/Makefile b/drivers/macintosh/Makefile
index ee803638e595..49819b1b6f20 100644
--- a/drivers/macintosh/Makefile
+++ b/drivers/macintosh/Makefile
@@ -22,7 +22,6 @@ obj-$(CONFIG_PMAC_SMU)		+= smu.o
 obj-$(CONFIG_ADB)		+= adb.o
 obj-$(CONFIG_ADB_MACII)		+= via-macii.o
 obj-$(CONFIG_ADB_IOP)		+= adb-iop.o
-obj-$(CONFIG_ADB_PMU68K)	+= via-pmu68k.o
 obj-$(CONFIG_ADB_MACIO)		+= macio-adb.o
 
 obj-$(CONFIG_THERM_WINDTUNNEL)	+= therm_windtunnel.o
diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index 4c8097e0e6fe..76e98f0f7a3e 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -65,7 +65,7 @@ static struct adb_driver *adb_driver_list[] = {
 #ifdef CONFIG_ADB_IOP
 	&adb_iop_driver,
 #endif
-#if defined(CONFIG_ADB_PMU) || defined(CONFIG_ADB_PMU68K)
+#ifdef CONFIG_ADB_PMU
 	&via_pmu_driver,
 #endif
 #ifdef CONFIG_ADB_MACIO
diff --git a/drivers/macintosh/via-pmu68k.c b/drivers/macintosh/via-pmu68k.c
deleted file mode 100644
index d545ed45e482..000000000000
--- a/drivers/macintosh/via-pmu68k.c
+++ /dev/null
@@ -1,850 +0,0 @@
-// SPDX-License-Identifier: GPL-2.0
-/*
- * Device driver for the PMU on 68K-based Apple PowerBooks
- *
- * The VIA (versatile interface adapter) interfaces to the PMU,
- * a 6805 microprocessor core whose primary function is to control
- * battery charging and system power on the PowerBooks.
- * The PMU also controls the ADB (Apple Desktop Bus) which connects
- * to the keyboard and mouse, as well as the non-volatile RAM
- * and the RTC (real time clock) chip.
- *
- * Adapted for 68K PMU by Joshua M. Thompson
- *
- * Based largely on the PowerMac PMU code by Paul Mackerras and
- * Fabio Riccardi.
- *
- * Also based on the PMU driver from MkLinux by Apple Computer, Inc.
- * and the Open Software Foundation, Inc.
- */
-
-#include <stdarg.h>
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/delay.h>
-#include <linux/miscdevice.h>
-#include <linux/blkdev.h>
-#include <linux/pci.h>
-#include <linux/init.h>
-#include <linux/interrupt.h>
-
-#include <linux/adb.h>
-#include <linux/pmu.h>
-#include <linux/cuda.h>
-
-#include <asm/macintosh.h>
-#include <asm/macints.h>
-#include <asm/mac_via.h>
-
-#include <asm/pgtable.h>
-#include <asm/irq.h>
-#include <linux/uaccess.h>
-
-/* Misc minor number allocated for /dev/pmu */
-#define PMU_MINOR	154
-
-/* VIA registers - spaced 0x200 bytes apart */
-#define RS		0x200		/* skip between registers */
-#define B		0		/* B-side data */
-#define A		RS		/* A-side data */
-#define DIRB		(2*RS)		/* B-side direction (1=output) */
-#define DIRA		(3*RS)		/* A-side direction (1=output) */
-#define T1CL		(4*RS)		/* Timer 1 ctr/latch (low 8 bits) */
-#define T1CH		(5*RS)		/* Timer 1 counter (high 8 bits) */
-#define T1LL		(6*RS)		/* Timer 1 latch (low 8 bits) */
-#define T1LH		(7*RS)		/* Timer 1 latch (high 8 bits) */
-#define T2CL		(8*RS)		/* Timer 2 ctr/latch (low 8 bits) */
-#define T2CH		(9*RS)		/* Timer 2 counter (high 8 bits) */
-#define SR		(10*RS)		/* Shift register */
-#define ACR		(11*RS)		/* Auxiliary control register */
-#define PCR		(12*RS)		/* Peripheral control register */
-#define IFR		(13*RS)		/* Interrupt flag register */
-#define IER		(14*RS)		/* Interrupt enable register */
-#define ANH		(15*RS)		/* A-side data, no handshake */
-
-/* Bits in B data register: both active low */
-#define TACK		0x02		/* Transfer acknowledge (input) */
-#define TREQ		0x04		/* Transfer request (output) */
-
-/* Bits in ACR */
-#define SR_CTRL		0x1c		/* Shift register control bits */
-#define SR_EXT		0x0c		/* Shift on external clock */
-#define SR_OUT		0x10		/* Shift out if 1 */
-
-/* Bits in IFR and IER */
-#define SR_INT		0x04		/* Shift register full/empty */
-#define CB1_INT		0x10		/* transition on CB1 input */
-
-static enum pmu_state {
-	idle,
-	sending,
-	intack,
-	reading,
-	reading_intr,
-} pmu_state;
-
-static struct adb_request *current_req;
-static struct adb_request *last_req;
-static struct adb_request *req_awaiting_reply;
-static unsigned char interrupt_data[32];
-static unsigned char *reply_ptr;
-static int data_index;
-static int data_len;
-static int adb_int_pending;
-static int pmu_adb_flags;
-static int adb_dev_map;
-static struct adb_request bright_req_1, bright_req_2, bright_req_3;
-static int pmu_kind = PMU_UNKNOWN;
-static int pmu_fully_inited;
-
-int asleep;
-
-static int pmu_probe(void);
-static int pmu_init(void);
-static void pmu_start(void);
-static irqreturn_t pmu_interrupt(int irq, void *arg);
-static int pmu_send_request(struct adb_request *req, int sync);
-static int pmu_autopoll(int devs);
-void pmu_poll(void);
-static int pmu_reset_bus(void);
-
-static int init_pmu(void);
-static void pmu_start(void);
-static void send_byte(int x);
-static void recv_byte(void);
-static void pmu_done(struct adb_request *req);
-static void pmu_handle_data(unsigned char *data, int len);
-static void set_volume(int level);
-static void pmu_enable_backlight(int on);
-static void pmu_set_brightness(int level);
-
-struct adb_driver via_pmu_driver = {
-	.name         = "68K PMU",
-	.probe        = pmu_probe,
-	.init         = pmu_init,
-	.send_request = pmu_send_request,
-	.autopoll     = pmu_autopoll,
-	.poll         = pmu_poll,
-	.reset_bus    = pmu_reset_bus,
-};
-
-/*
- * This table indicates for each PMU opcode:
- * - the number of data bytes to be sent with the command, or -1
- *   if a length byte should be sent,
- * - the number of response bytes which the PMU will return, or
- *   -1 if it will send a length byte.
- */
-static s8 pmu_data_len[256][2] = {
-/*	   0	   1	   2	   3	   4	   5	   6	   7  */
-/*00*/	{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},
-/*08*/	{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},
-/*10*/	{ 1, 0},{ 1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},
-/*18*/	{ 0, 1},{ 0, 1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{ 0, 0},
-/*20*/	{-1, 0},{ 0, 0},{ 2, 0},{ 1, 0},{ 1, 0},{-1, 0},{-1, 0},{-1, 0},
-/*28*/	{ 0,-1},{ 0,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{ 0,-1},
-/*30*/	{ 4, 0},{20, 0},{-1, 0},{ 3, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},
-/*38*/	{ 0, 4},{ 0,20},{ 2,-1},{ 2, 1},{ 3,-1},{-1,-1},{-1,-1},{ 4, 0},
-/*40*/	{ 1, 0},{ 1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},
-/*48*/	{ 0, 1},{ 0, 1},{-1,-1},{ 1, 0},{ 1, 0},{-1,-1},{-1,-1},{-1,-1},
-/*50*/	{ 1, 0},{ 0, 0},{ 2, 0},{ 2, 0},{-1, 0},{ 1, 0},{ 3, 0},{ 1, 0},
-/*58*/	{ 0, 1},{ 1, 0},{ 0, 2},{ 0, 2},{ 0,-1},{-1,-1},{-1,-1},{-1,-1},
-/*60*/	{ 2, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},
-/*68*/	{ 0, 3},{ 0, 3},{ 0, 2},{ 0, 8},{ 0,-1},{ 0,-1},{-1,-1},{-1,-1},
-/*70*/	{ 1, 0},{ 1, 0},{ 1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},
-/*78*/	{ 0,-1},{ 0,-1},{-1,-1},{-1,-1},{-1,-1},{ 5, 1},{ 4, 1},{ 4, 1},
-/*80*/	{ 4, 0},{-1, 0},{ 0, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},
-/*88*/	{ 0, 5},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},
-/*90*/	{ 1, 0},{ 2, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},
-/*98*/	{ 0, 1},{ 0, 1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},
-/*a0*/	{ 2, 0},{ 2, 0},{ 2, 0},{ 4, 0},{-1, 0},{ 0, 0},{-1, 0},{-1, 0},
-/*a8*/	{ 1, 1},{ 1, 0},{ 3, 0},{ 2, 0},{-1,-1},{-1,-1},{-1,-1},{-1,-1},
-/*b0*/	{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},
-/*b8*/	{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},
-/*c0*/	{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},
-/*c8*/	{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},
-/*d0*/	{ 0, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},
-/*d8*/	{ 1, 1},{ 1, 1},{-1,-1},{-1,-1},{ 0, 1},{ 0,-1},{-1,-1},{-1,-1},
-/*e0*/	{-1, 0},{ 4, 0},{ 0, 1},{-1, 0},{-1, 0},{ 4, 0},{-1, 0},{-1, 0},
-/*e8*/	{ 3,-1},{-1,-1},{ 0, 1},{-1,-1},{ 0,-1},{-1,-1},{-1,-1},{ 0, 0},
-/*f0*/	{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},{-1, 0},
-/*f8*/	{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},{-1,-1},
-};
-
-int __init find_via_pmu(void)
-{
-	switch (macintosh_config->adb_type) {
-	case MAC_ADB_PB1:
-		pmu_kind = PMU_68K_V1;
-		break;
-	case MAC_ADB_PB2:
-		pmu_kind = PMU_68K_V2;
-		break;
-	default:
-		pmu_kind = PMU_UNKNOWN;
-		return -ENODEV;
-	}
-
-	pmu_state = idle;
-
-	if (!init_pmu())
-		goto fail_init;
-
-	pr_info("adb: PMU 68K driver v0.5 for Unified ADB\n");
-
-	return 1;
-
-fail_init:
-	pmu_kind = PMU_UNKNOWN;
-	return 0;
-}
-
-static int pmu_probe(void)
-{
-	if (pmu_kind == PMU_UNKNOWN)
-		return -ENODEV;
-	return 0;
-}
-
-static int pmu_init(void)
-{
-	if (pmu_kind == PMU_UNKNOWN)
-		return -ENODEV;
-	return 0;
-}
-
-static int __init via_pmu_start(void)
-{
-	if (pmu_kind == PMU_UNKNOWN)
-		return -ENODEV;
-
-	if (request_irq(IRQ_MAC_ADB_SR, pmu_interrupt, 0, "PMU_SR",
-			pmu_interrupt)) {
-		pr_err("%s: can't get SR irq\n", __func__);
-		return -ENODEV;
-	}
-	if (request_irq(IRQ_MAC_ADB_CL, pmu_interrupt, 0, "PMU_CL",
-			pmu_interrupt)) {
-		pr_err("%s: can't get CL irq\n", __func__);
-		free_irq(IRQ_MAC_ADB_SR, pmu_interrupt);
-		return -ENODEV;
-	}
-
-	pmu_fully_inited = 1;
-
-	/* Enable backlight */
-	pmu_enable_backlight(1);
-
-	return 0;
-}
-
-arch_initcall(via_pmu_start);
-
-static int __init init_pmu(void)
-{
-	int timeout;
-	volatile struct adb_request req;
-
-	via2[B] |= TREQ;				/* negate TREQ */
-	via2[DIRB] = (via2[DIRB] | TREQ) & ~TACK;	/* TACK in, TREQ out */
-
-	pmu_request((struct adb_request *) &req, NULL, 2, PMU_SET_INTR_MASK, PMU_INT_ADB);
-	timeout =  100000;
-	while (!req.complete) {
-		if (--timeout < 0) {
-			printk(KERN_ERR "pmu_init: no response from PMU\n");
-			return -EAGAIN;
-		}
-		udelay(10);
-		pmu_poll();
-	}
-
-	/* ack all pending interrupts */
-	timeout = 100000;
-	interrupt_data[0] = 1;
-	while (interrupt_data[0] || pmu_state != idle) {
-		if (--timeout < 0) {
-			printk(KERN_ERR "pmu_init: timed out acking intrs\n");
-			return -EAGAIN;
-		}
-		if (pmu_state == idle) {
-			adb_int_pending = 1;
-			pmu_interrupt(0, NULL);
-		}
-		pmu_poll();
-		udelay(10);
-	}
-
-	pmu_request((struct adb_request *) &req, NULL, 2, PMU_SET_INTR_MASK,
-			PMU_INT_ADB_AUTO|PMU_INT_SNDBRT|PMU_INT_ADB);
-	timeout =  100000;
-	while (!req.complete) {
-		if (--timeout < 0) {
-			printk(KERN_ERR "pmu_init: no response from PMU\n");
-			return -EAGAIN;
-		}
-		udelay(10);
-		pmu_poll();
-	}
-
-	bright_req_1.complete = 1;
-	bright_req_2.complete = 1;
-	bright_req_3.complete = 1;
-
-	return 1;
-}
-
-int
-pmu_get_model(void)
-{
-	return pmu_kind;
-}
-
-/* Send an ADB command */
-static int 
-pmu_send_request(struct adb_request *req, int sync)
-{
-    int i, ret;
-
-    if (!pmu_fully_inited)
-    {
- 	req->complete = 1;
-   	return -ENXIO;
-   }
-
-    ret = -EINVAL;
-	
-    switch (req->data[0]) {
-    case PMU_PACKET:
-		for (i = 0; i < req->nbytes - 1; ++i)
-			req->data[i] = req->data[i+1];
-		--req->nbytes;
-		if (pmu_data_len[req->data[0]][1] != 0) {
-			req->reply[0] = ADB_RET_OK;
-			req->reply_len = 1;
-		} else
-			req->reply_len = 0;
-		ret = pmu_queue_request(req);
-		break;
-    case CUDA_PACKET:
-		switch (req->data[1]) {
-		case CUDA_GET_TIME:
-			if (req->nbytes != 2)
-				break;
-			req->data[0] = PMU_READ_RTC;
-			req->nbytes = 1;
-			req->reply_len = 3;
-			req->reply[0] = CUDA_PACKET;
-			req->reply[1] = 0;
-			req->reply[2] = CUDA_GET_TIME;
-			ret = pmu_queue_request(req);
-			break;
-		case CUDA_SET_TIME:
-			if (req->nbytes != 6)
-				break;
-			req->data[0] = PMU_SET_RTC;
-			req->nbytes = 5;
-			for (i = 1; i <= 4; ++i)
-				req->data[i] = req->data[i+1];
-			req->reply_len = 3;
-			req->reply[0] = CUDA_PACKET;
-			req->reply[1] = 0;
-			req->reply[2] = CUDA_SET_TIME;
-			ret = pmu_queue_request(req);
-			break;
-		case CUDA_GET_PRAM:
-			if (req->nbytes != 4)
-				break;
-			req->data[0] = PMU_READ_NVRAM;
-			req->data[1] = req->data[2];
-			req->data[2] = req->data[3];
-			req->nbytes = 3;
-			req->reply_len = 3;
-			req->reply[0] = CUDA_PACKET;
-			req->reply[1] = 0;
-			req->reply[2] = CUDA_GET_PRAM;
-			ret = pmu_queue_request(req);
-			break;
-		case CUDA_SET_PRAM:
-			if (req->nbytes != 5)
-				break;
-			req->data[0] = PMU_WRITE_NVRAM;
-			req->data[1] = req->data[2];
-			req->data[2] = req->data[3];
-			req->data[3] = req->data[4];
-			req->nbytes = 4;
-			req->reply_len = 3;
-			req->reply[0] = CUDA_PACKET;
-			req->reply[1] = 0;
-			req->reply[2] = CUDA_SET_PRAM;
-			ret = pmu_queue_request(req);
-			break;
-		}
-		break;
-    case ADB_PACKET:
-		for (i = req->nbytes - 1; i > 1; --i)
-			req->data[i+2] = req->data[i];
-		req->data[3] = req->nbytes - 2;
-		req->data[2] = pmu_adb_flags;
-		/*req->data[1] = req->data[1];*/
-		req->data[0] = PMU_ADB_CMD;
-		req->nbytes += 2;
-		req->reply_expected = 1;
-		req->reply_len = 0;
-		ret = pmu_queue_request(req);
-		break;
-    }
-    if (ret)
-    {
-    	req->complete = 1;
-    	return ret;
-    }
-    	
-    if (sync) {
-	while (!req->complete)
-		pmu_poll();
-    }
-
-    return 0;
-}
-
-/* Enable/disable autopolling */
-static int 
-pmu_autopoll(int devs)
-{
-	struct adb_request req;
-
-	if (!pmu_fully_inited) return -ENXIO;
-
-	if (devs) {
-		adb_dev_map = devs;
-		pmu_request(&req, NULL, 5, PMU_ADB_CMD, 0, 0x86,
-			    adb_dev_map >> 8, adb_dev_map);
-		pmu_adb_flags = 2;
-	} else {
-		pmu_request(&req, NULL, 1, PMU_ADB_POLL_OFF);
-		pmu_adb_flags = 0;
-	}
-	while (!req.complete)
-		pmu_poll();
-	return 0;
-}
-
-/* Reset the ADB bus */
-static int 
-pmu_reset_bus(void)
-{
-	struct adb_request req;
-	long timeout;
-	int save_autopoll = adb_dev_map;
-
-	if (!pmu_fully_inited) return -ENXIO;
-
-	/* anyone got a better idea?? */
-	pmu_autopoll(0);
-
-	req.nbytes = 5;
-	req.done = NULL;
-	req.data[0] = PMU_ADB_CMD;
-	req.data[1] = 0;
-	req.data[2] = 3; /* ADB_BUSRESET ??? */
-	req.data[3] = 0;
-	req.data[4] = 0;
-	req.reply_len = 0;
-	req.reply_expected = 1;
-	if (pmu_queue_request(&req) != 0)
-	{
-		printk(KERN_ERR "pmu_adb_reset_bus: pmu_queue_request failed\n");
-		return -EIO;
-	}
-	while (!req.complete)
-		pmu_poll();
-	timeout = 100000;
-	while (!req.complete) {
-		if (--timeout < 0) {
-			printk(KERN_ERR "pmu_adb_reset_bus (reset): no response from PMU\n");
-			return -EIO;
-		}
-		udelay(10);
-		pmu_poll();
-	}
-
-	if (save_autopoll != 0)
-		pmu_autopoll(save_autopoll);
-		
-	return 0;
-}
-
-/* Construct and send a pmu request */
-int 
-pmu_request(struct adb_request *req, void (*done)(struct adb_request *),
-	    int nbytes, ...)
-{
-	va_list list;
-	int i;
-
-	if (nbytes < 0 || nbytes > 32) {
-		printk(KERN_ERR "pmu_request: bad nbytes (%d)\n", nbytes);
-		req->complete = 1;
-		return -EINVAL;
-	}
-	req->nbytes = nbytes;
-	req->done = done;
-	va_start(list, nbytes);
-	for (i = 0; i < nbytes; ++i)
-		req->data[i] = va_arg(list, int);
-	va_end(list);
-	if (pmu_data_len[req->data[0]][1] != 0) {
-		req->reply[0] = ADB_RET_OK;
-		req->reply_len = 1;
-	} else
-		req->reply_len = 0;
-	req->reply_expected = 0;
-	return pmu_queue_request(req);
-}
-
-int
-pmu_queue_request(struct adb_request *req)
-{
-	unsigned long flags;
-	int nsend;
-
-	if (req->nbytes <= 0) {
-		req->complete = 1;
-		return 0;
-	}
-	nsend = pmu_data_len[req->data[0]][0];
-	if (nsend >= 0 && req->nbytes != nsend + 1) {
-		req->complete = 1;
-		return -EINVAL;
-	}
-
-	req->next = NULL;
-	req->sent = 0;
-	req->complete = 0;
-	local_irq_save(flags);
-
-	if (current_req != 0) {
-		last_req->next = req;
-		last_req = req;
-	} else {
-		current_req = req;
-		last_req = req;
-		if (pmu_state == idle)
-			pmu_start();
-	}
-
-	local_irq_restore(flags);
-	return 0;
-}
-
-static void 
-send_byte(int x)
-{
-	via1[ACR] |= SR_CTRL;
-	via1[SR] = x;
-	via2[B] &= ~TREQ;		/* assert TREQ */
-}
-
-static void 
-recv_byte(void)
-{
-	char c;
-
-	via1[ACR] = (via1[ACR] | SR_EXT) & ~SR_OUT;
-	c = via1[SR];		/* resets SR */
-	via2[B] &= ~TREQ;
-}
-
-static void 
-pmu_start(void)
-{
-	unsigned long flags;
-	struct adb_request *req;
-
-	/* assert pmu_state == idle */
-	/* get the packet to send */
-	local_irq_save(flags);
-	req = current_req;
-	if (req == 0 || pmu_state != idle
-	    || (req->reply_expected && req_awaiting_reply))
-		goto out;
-
-	pmu_state = sending;
-	data_index = 1;
-	data_len = pmu_data_len[req->data[0]][0];
-
-	/* set the shift register to shift out and send a byte */
-	send_byte(req->data[0]);
-
-out:
-	local_irq_restore(flags);
-}
-
-void 
-pmu_poll(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	if (via1[IFR] & SR_INT) {
-		via1[IFR] = SR_INT;
-		pmu_interrupt(IRQ_MAC_ADB_SR, NULL);
-	}
-	if (via1[IFR] & CB1_INT) {
-		via1[IFR] = CB1_INT;
-		pmu_interrupt(IRQ_MAC_ADB_CL, NULL);
-	}
-	local_irq_restore(flags);
-}
-
-static irqreturn_t
-pmu_interrupt(int irq, void *dev_id)
-{
-	struct adb_request *req;
-	int timeout, bite = 0;	/* to prevent compiler warning */
-
-#if 0
-	printk("pmu_interrupt: irq %d state %d acr %02X, b %02X data_index %d/%d adb_int_pending %d\n",
-		irq, pmu_state, (uint) via1[ACR], (uint) via2[B], data_index, data_len, adb_int_pending);
-#endif
-
-	if (irq == IRQ_MAC_ADB_CL) {		/* CB1 interrupt */
-		adb_int_pending = 1;
-	} else if (irq == IRQ_MAC_ADB_SR) {	/* SR interrupt  */
-		if (via2[B] & TACK) {
-			printk(KERN_DEBUG "PMU: SR_INT but ack still high! (%x)\n", via2[B]);
-		}
-
-		/* if reading grab the byte */
-		if ((via1[ACR] & SR_OUT) == 0) bite = via1[SR];
-
-		/* reset TREQ and wait for TACK to go high */
-		via2[B] |= TREQ;
-		timeout = 3200;
-		while (!(via2[B] & TACK)) {
-			if (--timeout < 0) {
-				printk(KERN_ERR "PMU not responding (!ack)\n");
-				goto finish;
-			}
-			udelay(10);
-		}
-
-		switch (pmu_state) {
-		case sending:
-			req = current_req;
-			if (data_len < 0) {
-				data_len = req->nbytes - 1;
-				send_byte(data_len);
-				break;
-			}
-			if (data_index <= data_len) {
-				send_byte(req->data[data_index++]);
-				break;
-			}
-			req->sent = 1;
-			data_len = pmu_data_len[req->data[0]][1];
-			if (data_len == 0) {
-				pmu_state = idle;
-				current_req = req->next;
-				if (req->reply_expected)
-					req_awaiting_reply = req;
-				else
-					pmu_done(req);
-			} else {
-				pmu_state = reading;
-				data_index = 0;
-				reply_ptr = req->reply + req->reply_len;
-				recv_byte();
-			}
-			break;
-
-		case intack:
-			data_index = 0;
-			data_len = -1;
-			pmu_state = reading_intr;
-			reply_ptr = interrupt_data;
-			recv_byte();
-			break;
-
-		case reading:
-		case reading_intr:
-			if (data_len == -1) {
-				data_len = bite;
-				if (bite > 32)
-					printk(KERN_ERR "PMU: bad reply len %d\n",
-					       bite);
-			} else {
-				reply_ptr[data_index++] = bite;
-			}
-			if (data_index < data_len) {
-				recv_byte();
-				break;
-			}
-
-			if (pmu_state == reading_intr) {
-				pmu_handle_data(interrupt_data, data_index);
-			} else {
-				req = current_req;
-				current_req = req->next;
-				req->reply_len += data_index;
-				pmu_done(req);
-			}
-			pmu_state = idle;
-
-			break;
-
-		default:
-			printk(KERN_ERR "pmu_interrupt: unknown state %d?\n",
-			       pmu_state);
-		}
-	}
-finish:
-	if (pmu_state == idle) {
-		if (adb_int_pending) {
-			pmu_state = intack;
-			send_byte(PMU_INT_ACK);
-			adb_int_pending = 0;
-		} else if (current_req) {
-			pmu_start();
-		}
-	}
-
-#if 0
-	printk("pmu_interrupt: exit state %d acr %02X, b %02X data_index %d/%d adb_int_pending %d\n",
-		pmu_state, (uint) via1[ACR], (uint) via2[B], data_index, data_len, adb_int_pending);
-#endif
-	return IRQ_HANDLED;
-}
-
-static void 
-pmu_done(struct adb_request *req)
-{
-	req->complete = 1;
-	if (req->done)
-		(*req->done)(req);
-}
-
-/* Interrupt data could be the result data from an ADB cmd */
-static void 
-pmu_handle_data(unsigned char *data, int len)
-{
-	static int show_pmu_ints = 1;
-
-	asleep = 0;
-	if (len < 1) {
-		adb_int_pending = 0;
-		return;
-	}
-	if (data[0] & PMU_INT_ADB) {
-		if ((data[0] & PMU_INT_ADB_AUTO) == 0) {
-			struct adb_request *req = req_awaiting_reply;
-			if (req == 0) {
-				printk(KERN_ERR "PMU: extra ADB reply\n");
-				return;
-			}
-			req_awaiting_reply = NULL;
-			if (len <= 2)
-				req->reply_len = 0;
-			else {
-				memcpy(req->reply, data + 1, len - 1);
-				req->reply_len = len - 1;
-			}
-			pmu_done(req);
-		} else {
-			adb_input(data+1, len-1, 1);
-		}
-	} else {
-		if (data[0] == 0x08 && len == 3) {
-			/* sound/brightness buttons pressed */
-			pmu_set_brightness(data[1] >> 3);
-			set_volume(data[2]);
-		} else if (show_pmu_ints
-			   && !(data[0] == PMU_INT_TICK && len == 1)) {
-			int i;
-			printk(KERN_DEBUG "pmu intr");
-			for (i = 0; i < len; ++i)
-				printk(" %.2x", data[i]);
-			printk("\n");
-		}
-	}
-}
-
-static int backlight_level = -1;
-static int backlight_enabled = 0;
-
-#define LEVEL_TO_BRIGHT(lev)	((lev) < 1? 0x7f: 0x4a - ((lev) << 1))
-
-static void 
-pmu_enable_backlight(int on)
-{
-	struct adb_request req;
-
-	if (on) {
-	    /* first call: get current backlight value */
-	    if (backlight_level < 0) {
-		switch(pmu_kind) {
-		    case PMU_68K_V1:
-		    case PMU_68K_V2:
-			pmu_request(&req, NULL, 3, PMU_READ_NVRAM, 0x14, 0xe);
-			while (!req.complete)
-				pmu_poll();
-			printk(KERN_DEBUG "pmu: nvram returned bright: %d\n", (int)req.reply[1]);
-			backlight_level = req.reply[1];
-			break;
-		    default:
-		        backlight_enabled = 0;
-		        return;
-		}
-	    }
-	    pmu_request(&req, NULL, 2, PMU_BACKLIGHT_BRIGHT,
-	    	LEVEL_TO_BRIGHT(backlight_level));
-	    while (!req.complete)
-		pmu_poll();
-	}
-	pmu_request(&req, NULL, 2, PMU_POWER_CTRL,
-	    PMU_POW_BACKLIGHT | (on ? PMU_POW_ON : PMU_POW_OFF));
-	while (!req.complete)
-		pmu_poll();
-	backlight_enabled = on;
-}
-
-static void 
-pmu_set_brightness(int level)
-{
-	int bright;
-
-	backlight_level = level;
-	bright = LEVEL_TO_BRIGHT(level);
-	if (!backlight_enabled)
-		return;
-	if (bright_req_1.complete)
-		pmu_request(&bright_req_1, NULL, 2, PMU_BACKLIGHT_BRIGHT,
-		    bright);
-	if (bright_req_2.complete)
-		pmu_request(&bright_req_2, NULL, 2, PMU_POWER_CTRL,
-		    PMU_POW_BACKLIGHT | (bright < 0x7f ? PMU_POW_ON : PMU_POW_OFF));
-}
-
-void 
-pmu_enable_irled(int on)
-{
-	struct adb_request req;
-
-	pmu_request(&req, NULL, 2, PMU_POWER_CTRL, PMU_POW_IRLED |
-	    (on ? PMU_POW_ON : PMU_POW_OFF));
-	while (!req.complete)
-		pmu_poll();
-}
-
-static void 
-set_volume(int level)
-{
-}
-
-int
-pmu_present(void)
-{
-	return (pmu_kind != PMU_UNKNOWN);
-}
diff --git a/include/uapi/linux/pmu.h b/include/uapi/linux/pmu.h
index 89cb1acea93a..a2d3c289ed81 100644
--- a/include/uapi/linux/pmu.h
+++ b/include/uapi/linux/pmu.h
@@ -93,8 +93,6 @@ enum {
 	PMU_HEATHROW_BASED,	/* PowerBook G3 series */
 	PMU_PADDINGTON_BASED,	/* 1999 PowerBook G3 */
 	PMU_KEYLARGO_BASED,	/* Core99 motherboard (PMU99) */
-	PMU_68K_V1,		/* 68K PMU, version 1 */
-	PMU_68K_V2, 		/* 68K PMU, version 2 */
 };
 
 /* PMU PMU_POWER_EVENTS commands */
-- 
2.16.1
