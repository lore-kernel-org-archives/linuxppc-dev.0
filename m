Return-Path: <fthain@telegraphics.com.au>
Received: from kvm5.telegraphics.com.au (kvm5.telegraphics.com.au
 [98.124.60.144])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tTn8G0QMmzDvyD
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 17:15:25 +1100 (AEDT)
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Geert Uytterhoeven <geert@linux-m68k.org>
Cc: linux-m68k@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Message-Id: <8199620b3b2ef7e208d65624895f85385996babc.1480572271.git.fthain@telegraphics.com.au>
In-Reply-To: <cover.1480572271.git.fthain@telegraphics.com.au>
References: <cover.1480572271.git.fthain@telegraphics.com.au>
From: Finn Thain <fthain@telegraphics.com.au>
Subject: [PATCH 10/10] m68k/mac: Replace via-maciisi driver with via-cuda
 driver
Date: Thu,  1 Dec 2016 01:09:34 -0500 (EST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Change the device probe test in the via-cuda.c driver so it will load on
Egret-based machines too. Remove the now redundant via-maciisi.c driver.

Tested-by: Stan Johnson <userm57@yahoo.com>
Signed-off-by: Finn Thain <fthain@telegraphics.com.au>
---
 arch/m68k/include/asm/macintosh.h |   2 +-
 arch/m68k/mac/config.c            |  18 +-
 arch/m68k/mac/misc.c              |  72 +---
 drivers/macintosh/Kconfig         |  24 +-
 drivers/macintosh/Makefile        |   1 -
 drivers/macintosh/adb.c           |   4 -
 drivers/macintosh/via-cuda.c      |   8 +-
 drivers/macintosh/via-maciisi.c   | 677 --------------------------------------
 8 files changed, 30 insertions(+), 776 deletions(-)
 delete mode 100644 drivers/macintosh/via-maciisi.c

diff --git a/arch/m68k/include/asm/macintosh.h b/arch/m68k/include/asm/macintosh.h
index 42235e7..5b81ab1 100644
--- a/arch/m68k/include/asm/macintosh.h
+++ b/arch/m68k/include/asm/macintosh.h
@@ -38,7 +38,7 @@ struct mac_model
 
 #define MAC_ADB_NONE		0
 #define MAC_ADB_II		1
-#define MAC_ADB_IISI		2
+#define MAC_ADB_EGRET		2
 #define MAC_ADB_CUDA		3
 #define MAC_ADB_PB1		4
 #define MAC_ADB_PB2		5
diff --git a/arch/m68k/mac/config.c b/arch/m68k/mac/config.c
index 689b47d..91b58d0 100644
--- a/arch/m68k/mac/config.c
+++ b/arch/m68k/mac/config.c
@@ -285,7 +285,7 @@ static struct mac_model mac_data_table[] = {
 	}, {
 		.ident		= MAC_MODEL_IISI,
 		.name		= "IIsi",
-		.adb_type	= MAC_ADB_IISI,
+		.adb_type	= MAC_ADB_EGRET,
 		.via_type	= MAC_VIA_IICI,
 		.scsi_type	= MAC_SCSI_OLD,
 		.scc_type	= MAC_SCC_II,
@@ -294,7 +294,7 @@ static struct mac_model mac_data_table[] = {
 	}, {
 		.ident		= MAC_MODEL_IIVI,
 		.name		= "IIvi",
-		.adb_type	= MAC_ADB_IISI,
+		.adb_type	= MAC_ADB_EGRET,
 		.via_type	= MAC_VIA_IICI,
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
@@ -303,7 +303,7 @@ static struct mac_model mac_data_table[] = {
 	}, {
 		.ident		= MAC_MODEL_IIVX,
 		.name		= "IIvx",
-		.adb_type	= MAC_ADB_IISI,
+		.adb_type	= MAC_ADB_EGRET,
 		.via_type	= MAC_VIA_IICI,
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
@@ -318,7 +318,7 @@ static struct mac_model mac_data_table[] = {
 	{
 		.ident		= MAC_MODEL_CLII,
 		.name		= "Classic II",
-		.adb_type	= MAC_ADB_IISI,
+		.adb_type	= MAC_ADB_EGRET,
 		.via_type	= MAC_VIA_IICI,
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
@@ -351,7 +351,7 @@ static struct mac_model mac_data_table[] = {
 	{
 		.ident		= MAC_MODEL_LC,
 		.name		= "LC",
-		.adb_type	= MAC_ADB_IISI,
+		.adb_type	= MAC_ADB_EGRET,
 		.via_type	= MAC_VIA_IICI,
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
@@ -360,7 +360,7 @@ static struct mac_model mac_data_table[] = {
 	}, {
 		.ident		= MAC_MODEL_LCII,
 		.name		= "LC II",
-		.adb_type	= MAC_ADB_IISI,
+		.adb_type	= MAC_ADB_EGRET,
 		.via_type	= MAC_VIA_IICI,
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
@@ -369,7 +369,7 @@ static struct mac_model mac_data_table[] = {
 	}, {
 		.ident		= MAC_MODEL_LCIII,
 		.name		= "LC III",
-		.adb_type	= MAC_ADB_IISI,
+		.adb_type	= MAC_ADB_EGRET,
 		.via_type	= MAC_VIA_IICI,
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
@@ -497,7 +497,7 @@ static struct mac_model mac_data_table[] = {
 	{
 		.ident		= MAC_MODEL_P460,
 		.name		= "Performa 460",
-		.adb_type	= MAC_ADB_IISI,
+		.adb_type	= MAC_ADB_EGRET,
 		.via_type	= MAC_VIA_IICI,
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
@@ -574,7 +574,7 @@ static struct mac_model mac_data_table[] = {
 	}, {
 		.ident		= MAC_MODEL_P600,
 		.name		= "Performa 600",
-		.adb_type	= MAC_ADB_IISI,
+		.adb_type	= MAC_ADB_EGRET,
 		.via_type	= MAC_VIA_IICI,
 		.scsi_type	= MAC_SCSI_LC,
 		.scc_type	= MAC_SCC_II,
diff --git a/arch/m68k/mac/misc.c b/arch/m68k/mac/misc.c
index 707b61a..c79570a 100644
--- a/arch/m68k/mac/misc.c
+++ b/arch/m68k/mac/misc.c
@@ -143,54 +143,6 @@ static void pmu_write_pram(int offset, __u8 data)
 #define pmu_write_pram NULL
 #endif
 
-#if 0 /* def CONFIG_ADB_MACIISI */
-extern int maciisi_request(struct adb_request *req,
-			void (*done)(struct adb_request *), int nbytes, ...);
-
-static long maciisi_read_time(void)
-{
-	struct adb_request req;
-	long time;
-
-	if (maciisi_request(&req, NULL, 2, CUDA_PACKET, CUDA_GET_TIME))
-		return 0;
-
-	time = (req.reply[3] << 24) | (req.reply[4] << 16)
-		| (req.reply[5] << 8) | req.reply[6];
-	return time - RTC_OFFSET;
-}
-
-static void maciisi_write_time(long data)
-{
-	struct adb_request req;
-	data += RTC_OFFSET;
-	maciisi_request(&req, NULL, 6, CUDA_PACKET, CUDA_SET_TIME,
-			(data >> 24) & 0xFF, (data >> 16) & 0xFF,
-			(data >> 8) & 0xFF, data & 0xFF);
-}
-
-static __u8 maciisi_read_pram(int offset)
-{
-	struct adb_request req;
-	if (maciisi_request(&req, NULL, 4, CUDA_PACKET, CUDA_GET_PRAM,
-			(offset >> 8) & 0xFF, offset & 0xFF))
-		return 0;
-	return req.reply[3];
-}
-
-static void maciisi_write_pram(int offset, __u8 data)
-{
-	struct adb_request req;
-	maciisi_request(&req, NULL, 5, CUDA_PACKET, CUDA_SET_PRAM,
-			(offset >> 8) & 0xFF, offset & 0xFF, data);
-}
-#else
-#define maciisi_read_time() 0
-#define maciisi_write_time(n)
-#define maciisi_read_pram NULL
-#define maciisi_write_pram NULL
-#endif
-
 /*
  * VIA PRAM/RTC access routines
  *
@@ -459,11 +411,10 @@ void mac_pram_read(int offset, __u8 *buffer, int len)
 	int i;
 
 	switch(macintosh_config->adb_type) {
-	case MAC_ADB_IISI:
-		func = maciisi_read_pram; break;
 	case MAC_ADB_PB1:
 	case MAC_ADB_PB2:
 		func = pmu_read_pram; break;
+	case MAC_ADB_EGRET:
 	case MAC_ADB_CUDA:
 		func = cuda_read_pram; break;
 	default:
@@ -482,11 +433,10 @@ void mac_pram_write(int offset, __u8 *buffer, int len)
 	int i;
 
 	switch(macintosh_config->adb_type) {
-	case MAC_ADB_IISI:
-		func = maciisi_write_pram; break;
 	case MAC_ADB_PB1:
 	case MAC_ADB_PB2:
 		func = pmu_write_pram; break;
+	case MAC_ADB_EGRET:
 	case MAC_ADB_CUDA:
 		func = cuda_write_pram; break;
 	default:
@@ -501,17 +451,13 @@ void mac_pram_write(int offset, __u8 *buffer, int len)
 
 void mac_poweroff(void)
 {
-	/*
-	 * MAC_ADB_IISI may need to be moved up here if it doesn't actually
-	 * work using the ADB packet method.  --David Kilzer
-	 */
-
 	if (oss_present) {
 		oss_shutdown();
 	} else if (macintosh_config->adb_type == MAC_ADB_II) {
 		via_shutdown();
 #ifdef CONFIG_ADB_CUDA
-	} else if (macintosh_config->adb_type == MAC_ADB_CUDA) {
+	} else if (macintosh_config->adb_type == MAC_ADB_EGRET ||
+	           macintosh_config->adb_type == MAC_ADB_CUDA) {
 		cuda_shutdown();
 #endif
 #ifdef CONFIG_ADB_PMU68K
@@ -551,7 +497,8 @@ void mac_reset(void)
 			local_irq_restore(flags);
 		}
 #ifdef CONFIG_ADB_CUDA
-	} else if (macintosh_config->adb_type == MAC_ADB_CUDA) {
+	} else if (macintosh_config->adb_type == MAC_ADB_EGRET ||
+	           macintosh_config->adb_type == MAC_ADB_CUDA) {
 		cuda_restart();
 #endif
 #ifdef CONFIG_ADB_PMU68K
@@ -700,13 +647,11 @@ int mac_hwclk(int op, struct rtc_time *t)
 		case MAC_ADB_IOP:
 			now = via_read_time();
 			break;
-		case MAC_ADB_IISI:
-			now = maciisi_read_time();
-			break;
 		case MAC_ADB_PB1:
 		case MAC_ADB_PB2:
 			now = pmu_read_time();
 			break;
+		case MAC_ADB_EGRET:
 		case MAC_ADB_CUDA:
 			now = cuda_read_time();
 			break;
@@ -738,6 +683,7 @@ int mac_hwclk(int op, struct rtc_time *t)
 		case MAC_ADB_IOP:
 			via_write_time(now);
 			break;
+		case MAC_ADB_EGRET:
 		case MAC_ADB_CUDA:
 			cuda_write_time(now);
 			break;
@@ -745,8 +691,6 @@ int mac_hwclk(int op, struct rtc_time *t)
 		case MAC_ADB_PB2:
 			pmu_write_time(now);
 			break;
-		case MAC_ADB_IISI:
-			maciisi_write_time(now);
 		}
 	}
 	return 0;
diff --git a/drivers/macintosh/Kconfig b/drivers/macintosh/Kconfig
index 5844b80..b2f3588 100644
--- a/drivers/macintosh/Kconfig
+++ b/drivers/macintosh/Kconfig
@@ -30,14 +30,6 @@ config ADB_MACII
 	  Quadra 610, Quadra 650, Quadra 700, Quadra 800, Centris 610 and
 	  Centris 650.
 
-config ADB_MACIISI
-	bool "Include Mac IIsi ADB driver"
-	depends on ADB && MAC && BROKEN
-	help
-	  Say Y here if want your kernel to support Macintosh systems that use
-	  the Mac IIsi style ADB.  This includes the IIsi, IIvi, IIvx, Classic
-	  II, LC, LC II, LC III, Performa 460, and the Performa 600.
-
 config ADB_IOP
 	bool "Include IOP (IIfx/Quadra 9x0) ADB driver"
 	depends on ADB && MAC
@@ -60,17 +52,15 @@ config ADB_PMU68K
 
 # we want to change this to something like CONFIG_SYSCTRL_CUDA/PMU
 config ADB_CUDA
-	bool "Support for CUDA based Macs and PowerMacs"
+	bool "Support for Cuda/Egret based Macs and PowerMacs"
 	depends on (ADB || PPC_PMAC) && !PPC_PMAC64
 	help
-	  This provides support for CUDA based Macintosh and Power Macintosh
-	  systems.  This includes many m68k based Macs (Color Classic, Mac TV,
-	  Performa 475, Performa 520, Performa 550, Performa 575,
-	  Performa 588, Quadra 605, Quadra 630, Quadra/Centris 660AV, and
-	  Quadra 840AV), most OldWorld PowerMacs, the first generation iMacs,
-	  the Blue&White G3 and the "Yikes" G4 (PCI Graphics).  All later
-	  models should use CONFIG_ADB_PMU instead.  It is safe to say Y here
-	  even if your machine doesn't have a CUDA.
+	  This provides support for Cuda/Egret based Macintosh and
+	  Power Macintosh systems. This includes most m68k based Macs,
+	  most Old World PowerMacs, the first generation iMacs, the
+	  Blue & White G3 and the "Yikes" G4 (PCI Graphics). All later
+	  models should use CONFIG_ADB_PMU instead. It is safe to say Y
+	  here even if your machine doesn't have a Cuda or Egret device.
 
 	  If unsure say Y.
 
diff --git a/drivers/macintosh/Makefile b/drivers/macintosh/Makefile
index 383ba92..516eb65b 100644
--- a/drivers/macintosh/Makefile
+++ b/drivers/macintosh/Makefile
@@ -20,7 +20,6 @@ obj-$(CONFIG_PMAC_SMU)		+= smu.o
 
 obj-$(CONFIG_ADB)		+= adb.o
 obj-$(CONFIG_ADB_MACII)		+= via-macii.o
-obj-$(CONFIG_ADB_MACIISI)	+= via-maciisi.o
 obj-$(CONFIG_ADB_IOP)		+= adb-iop.o
 obj-$(CONFIG_ADB_PMU68K)	+= via-pmu68k.o
 obj-$(CONFIG_ADB_MACIO)		+= macio-adb.o
diff --git a/drivers/macintosh/adb.c b/drivers/macintosh/adb.c
index 226179b..152414e 100644
--- a/drivers/macintosh/adb.c
+++ b/drivers/macintosh/adb.c
@@ -48,7 +48,6 @@
 EXPORT_SYMBOL(adb_client_list);
 
 extern struct adb_driver via_macii_driver;
-extern struct adb_driver via_maciisi_driver;
 extern struct adb_driver via_cuda_driver;
 extern struct adb_driver adb_iop_driver;
 extern struct adb_driver via_pmu_driver;
@@ -59,9 +58,6 @@ static struct adb_driver *adb_driver_list[] = {
 #ifdef CONFIG_ADB_MACII
 	&via_macii_driver,
 #endif
-#ifdef CONFIG_ADB_MACIISI
-	&via_maciisi_driver,
-#endif
 #ifdef CONFIG_ADB_CUDA
 	&via_cuda_driver,
 #endif
diff --git a/drivers/macintosh/via-cuda.c b/drivers/macintosh/via-cuda.c
index 3254070..20c81e7 100644
--- a/drivers/macintosh/via-cuda.c
+++ b/drivers/macintosh/via-cuda.c
@@ -205,12 +205,13 @@ int __init find_via_cuda(void)
     struct adb_request req;
     int err;
 
-    if (macintosh_config->adb_type != MAC_ADB_CUDA)
+    if (macintosh_config->adb_type != MAC_ADB_CUDA &&
+        macintosh_config->adb_type != MAC_ADB_EGRET)
 	return 0;
 
     via = via1;
     cuda_state = idle;
-    mcu_is_egret = false;
+    mcu_is_egret = macintosh_config->adb_type == MAC_ADB_EGRET;
 
     err = cuda_init_via();
     if (err) {
@@ -323,7 +324,8 @@ cuda_probe(void)
     if (sys_ctrler != SYS_CTRLER_CUDA)
 	return -ENODEV;
 #else
-    if (macintosh_config->adb_type != MAC_ADB_CUDA)
+    if (macintosh_config->adb_type != MAC_ADB_CUDA &&
+        macintosh_config->adb_type != MAC_ADB_EGRET)
 	return -ENODEV;
 #endif
     if (via == NULL)
diff --git a/drivers/macintosh/via-maciisi.c b/drivers/macintosh/via-maciisi.c
deleted file mode 100644
index 34d02a9..0000000
--- a/drivers/macintosh/via-maciisi.c
+++ /dev/null
@@ -1,677 +0,0 @@
-/*
- * Device driver for the IIsi-style ADB on some Mac LC and II-class machines
- *
- * Based on via-cuda.c and via-macii.c, as well as the original
- * adb-bus.c, which in turn is somewhat influenced by (but uses no
- * code from) the NetBSD HWDIRECT ADB code.  Original IIsi driver work
- * was done by Robert Thompson and integrated into the old style
- * driver by Michael Schmitz.
- *
- * Original sources (c) Alan Cox, Paul Mackerras, and others.
- *
- * Rewritten for Unified ADB by David Huggins-Daines <dhd@debian.org>
- * 
- * 7/13/2000- extensive changes by Andrew McPherson <andrew@macduff.dhs.org>
- * Works about 30% of the time now.
- */
-
-#include <linux/types.h>
-#include <linux/errno.h>
-#include <linux/kernel.h>
-#include <linux/adb.h>
-#include <linux/cuda.h>
-#include <linux/delay.h>
-#include <linux/interrupt.h>
-#include <asm/macintosh.h>
-#include <asm/macints.h>
-#include <asm/mac_via.h>
-
-static volatile unsigned char *via;
-
-/* VIA registers - spaced 0x200 bytes apart - only the ones we actually use */
-#define RS		0x200		/* skip between registers */
-#define B		0		/* B-side data */
-#define A		RS		/* A-side data */
-#define DIRB		(2*RS)		/* B-side direction (1=output) */
-#define DIRA		(3*RS)		/* A-side direction (1=output) */
-#define SR		(10*RS)		/* Shift register */
-#define ACR		(11*RS)		/* Auxiliary control register */
-#define IFR		(13*RS)		/* Interrupt flag register */
-#define IER		(14*RS)		/* Interrupt enable register */
-
-/* Bits in B data register: all active low */
-#define TREQ		0x08		/* Transfer request (input) */
-#define TACK		0x10		/* Transfer acknowledge (output) */
-#define TIP		0x20		/* Transfer in progress (output) */
-#define ST_MASK		0x30		/* mask for selecting ADB state bits */
-
-/* Bits in ACR */
-#define SR_CTRL		0x1c		/* Shift register control bits */
-#define SR_EXT		0x0c		/* Shift on external clock */
-#define SR_OUT		0x10		/* Shift out if 1 */
-
-/* Bits in IFR and IER */
-#define IER_SET		0x80		/* set bits in IER */
-#define IER_CLR		0		/* clear bits in IER */
-#define SR_INT		0x04		/* Shift register full/empty */
-#define SR_DATA		0x08		/* Shift register data */
-#define SR_CLOCK	0x10		/* Shift register clock */
-
-#define ADB_DELAY 150
-
-#undef DEBUG_MACIISI_ADB
-
-static struct adb_request* current_req;
-static struct adb_request* last_req;
-static unsigned char maciisi_rbuf[16];
-static unsigned char *reply_ptr;
-static int data_index;
-static int reading_reply;
-static int reply_len;
-static int tmp;
-static int need_sync;
-
-static enum maciisi_state {
-    idle,
-    sending,
-    reading,
-} maciisi_state;
-
-static int maciisi_probe(void);
-static int maciisi_init(void);
-static int maciisi_send_request(struct adb_request* req, int sync);
-static void maciisi_sync(struct adb_request *req);
-static int maciisi_write(struct adb_request* req);
-static irqreturn_t maciisi_interrupt(int irq, void* arg);
-static void maciisi_input(unsigned char *buf, int nb);
-static int maciisi_init_via(void);
-static void maciisi_poll(void);
-static int maciisi_start(void);
-
-struct adb_driver via_maciisi_driver = {
-	"Mac IIsi",
-	maciisi_probe,
-	maciisi_init,
-	maciisi_send_request,
-	NULL, /* maciisi_adb_autopoll, */
-	maciisi_poll,
-	NULL /* maciisi_reset_adb_bus */
-};
-
-static int
-maciisi_probe(void)
-{
-	if (macintosh_config->adb_type != MAC_ADB_IISI)
-		return -ENODEV;
-
-	via = via1;
-	return 0;
-}
-
-static int
-maciisi_init(void)
-{
-	int err;
-
-	if (via == NULL)
-		return -ENODEV;
-
-	if ((err = maciisi_init_via())) {
-		printk(KERN_ERR "maciisi_init: maciisi_init_via() failed, code %d\n", err);
-		via = NULL;
-		return err;
-	}
-
-	if (request_irq(IRQ_MAC_ADB, maciisi_interrupt, 0, "ADB",
-			maciisi_interrupt)) {
-		printk(KERN_ERR "maciisi_init: can't get irq %d\n", IRQ_MAC_ADB);
-		return -EAGAIN;
-	}
-
-	printk("adb: Mac IIsi driver v0.2 for Unified ADB.\n");
-	return 0;
-}
-
-/* Flush data from the ADB controller */
-static void
-maciisi_stfu(void)
-{
-	int status = via[B] & (TIP|TREQ);
-
-	if (status & TREQ) {
-#ifdef DEBUG_MACIISI_ADB
-		printk (KERN_DEBUG "maciisi_stfu called with TREQ high!\n");
-#endif
-		return;
-	}
-	
-	udelay(ADB_DELAY);
-	via[ACR] &= ~SR_OUT;
-	via[IER] = IER_CLR | SR_INT;
-
-	udelay(ADB_DELAY);
-
-	status = via[B] & (TIP|TREQ);
-
-	if (!(status & TREQ))
-	{
-		via[B] |= TIP;
-
-		while(1)
-		{
-			int poll_timeout = ADB_DELAY * 5;
-			/* Poll for SR interrupt */
-			while (!(via[IFR] & SR_INT) && poll_timeout-- > 0)
-				status = via[B] & (TIP|TREQ);
-
-			tmp = via[SR]; /* Clear shift register */
-#ifdef DEBUG_MACIISI_ADB
-			printk(KERN_DEBUG "maciisi_stfu: status %x timeout %d data %x\n",
-			       status, poll_timeout, tmp);
-#endif	
-			if(via[B] & TREQ)
-				break;
-	
-			/* ACK on-off */
-			via[B] |= TACK;
-			udelay(ADB_DELAY);
-			via[B] &= ~TACK;
-		}
-
-		/* end frame */
-		via[B] &= ~TIP;
-		udelay(ADB_DELAY);
-	}
-
-	via[IER] = IER_SET | SR_INT;	
-}
-
-/* All specifically VIA-related initialization goes here */
-static int
-maciisi_init_via(void)
-{
-	int	i;
-	
-	/* Set the lines up. We want TREQ as input TACK|TIP as output */
-	via[DIRB] = (via[DIRB] | TACK | TIP) & ~TREQ;
-	/* Shift register on input */
-	via[ACR]  = (via[ACR] & ~SR_CTRL) | SR_EXT;
-#ifdef DEBUG_MACIISI_ADB
-	printk(KERN_DEBUG "maciisi_init_via: initial status %x\n", via[B] & (TIP|TREQ));
-#endif
-	/* Wipe any pending data and int */
-	tmp = via[SR];
-	/* Enable keyboard interrupts */
-	via[IER] = IER_SET | SR_INT;
-	/* Set initial state: idle */
-	via[B] &= ~(TACK|TIP);
-	/* Clear interrupt bit */
-	via[IFR] = SR_INT;
-
-	for(i = 0; i < 60; i++) {
-		udelay(ADB_DELAY);
-		maciisi_stfu();
-		udelay(ADB_DELAY);
-		if(via[B] & TREQ)
-			break;
-	}
-	if (i == 60)
-		printk(KERN_ERR "maciisi_init_via: bus jam?\n");
-
-	maciisi_state = idle;
-	need_sync = 0;
-
-	return 0;
-}
-
-/* Send a request, possibly waiting for a reply */
-static int
-maciisi_send_request(struct adb_request* req, int sync)
-{
-	int i;
-
-#ifdef DEBUG_MACIISI_ADB
-	static int dump_packet = 0;
-#endif
-
-	if (via == NULL) {
-		req->complete = 1;
-		return -ENXIO;
-	}
-
-#ifdef DEBUG_MACIISI_ADB
-	if (dump_packet) {
-		printk(KERN_DEBUG "maciisi_send_request:");
-		for (i = 0; i < req->nbytes; i++) {
-			printk(" %.2x", req->data[i]);
-		}
-		printk(" sync %d\n", sync);
-	}
-#endif
-
-	req->reply_expected = 1;
-	
-	i = maciisi_write(req);
-	if (i)
-	{
-		/* Normally, if a packet requires syncing, that happens at the end of
-		 * maciisi_send_request. But if the transfer fails, it will be restarted
-		 * by maciisi_interrupt(). We use need_sync to tell maciisi_interrupt
-		 * when to sync a packet that it sends out.
-		 * 
-		 * Suggestions on a better way to do this are welcome.
-		 */
-		if(i == -EBUSY && sync)
-			need_sync = 1;
-		else
-			need_sync = 0;
-		return i;
-	}
-	if(sync)
-		maciisi_sync(req);
-	
-	return 0;
-}
-
-/* Poll the ADB chip until the request completes */
-static void maciisi_sync(struct adb_request *req)
-{
-	int count = 0; 
-
-#ifdef DEBUG_MACIISI_ADB
-	printk(KERN_DEBUG "maciisi_sync called\n");
-#endif
-
-	/* If for some reason the ADB chip shuts up on us, we want to avoid an endless loop. */
-	while (!req->complete && count++ < 50) {
-		maciisi_poll();
-	}
-	/* This could be BAD... when the ADB controller doesn't respond
-	 * for this long, it's probably not coming back :-( */
-	if (count > 50) /* Hopefully shouldn't happen */
-		printk(KERN_ERR "maciisi_send_request: poll timed out!\n");
-}
-
-int
-maciisi_request(struct adb_request *req, void (*done)(struct adb_request *),
-	    int nbytes, ...)
-{
-	va_list list;
-	int i;
-
-	req->nbytes = nbytes;
-	req->done = done;
-	req->reply_expected = 0;
-	va_start(list, nbytes);
-	for (i = 0; i < nbytes; i++)
-		req->data[i++] = va_arg(list, int);
-	va_end(list);
-
-	return maciisi_send_request(req, 1);
-}
-
-/* Enqueue a request, and run the queue if possible */
-static int
-maciisi_write(struct adb_request* req)
-{
-	unsigned long flags;
-	int i;
-
-	/* We will accept CUDA packets - the VIA sends them to us, so
-           it figures that we should be able to send them to it */
-	if (req->nbytes < 2 || req->data[0] > CUDA_PACKET) {
-		printk(KERN_ERR "maciisi_write: packet too small or not an ADB or CUDA packet\n");
-		req->complete = 1;
-		return -EINVAL;
-	}
-	req->next = NULL;
-	req->sent = 0;
-	req->complete = 0;
-	req->reply_len = 0;
-	
-	local_irq_save(flags);
-
-	if (current_req) {
-		last_req->next = req;
-		last_req = req;
-	} else {
-		current_req = req;
-		last_req = req;
-	}
-	if (maciisi_state == idle)
-	{
-		i = maciisi_start();
-		if(i != 0)
-		{
-			local_irq_restore(flags);
-			return i;
-		}
-	}
-	else
-	{
-#ifdef DEBUG_MACIISI_ADB
-		printk(KERN_DEBUG "maciisi_write: would start, but state is %d\n", maciisi_state);
-#endif
-		local_irq_restore(flags);
-		return -EBUSY;
-	}
-
-	local_irq_restore(flags);
-
-	return 0;
-}
-
-static int
-maciisi_start(void)
-{
-	struct adb_request* req;
-	int status;
-
-#ifdef DEBUG_MACIISI_ADB
-	status = via[B] & (TIP | TREQ);
-
-	printk(KERN_DEBUG "maciisi_start called, state=%d, status=%x, ifr=%x\n", maciisi_state, status, via[IFR]);
-#endif
-
-	if (maciisi_state != idle) {
-		/* shouldn't happen */
-		printk(KERN_ERR "maciisi_start: maciisi_start called when driver busy!\n");
-		return -EBUSY;
-	}
-
-	req = current_req;
-	if (req == NULL)
-		return -EINVAL;
-
-	status = via[B] & (TIP|TREQ);
-	if (!(status & TREQ)) {
-#ifdef DEBUG_MACIISI_ADB
-		printk(KERN_DEBUG "maciisi_start: bus busy - aborting\n");
-#endif
-		return -EBUSY;
-	}
-
-	/* Okay, send */
-#ifdef DEBUG_MACIISI_ADB
-	printk(KERN_DEBUG "maciisi_start: sending\n");
-#endif
-	/* Set state to active */
-	via[B] |= TIP;
-	/* ACK off */
-	via[B] &= ~TACK;
-	/* Delay */
-	udelay(ADB_DELAY);
-	/* Shift out and send */
-	via[ACR] |= SR_OUT;
-	via[SR] = req->data[0];
-	data_index = 1;
-	/* ACK on */
-	via[B] |= TACK;
-	maciisi_state = sending;
-
-	return 0;
-}
-
-void
-maciisi_poll(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	if (via[IFR] & SR_INT) {
-		maciisi_interrupt(0, NULL);
-	}
-	else /* avoid calling this function too quickly in a loop */
-		udelay(ADB_DELAY);
-
-	local_irq_restore(flags);
-}
-
-/* Shift register interrupt - this is *supposed* to mean that the
-   register is either full or empty. In practice, I have no idea what
-   it means :( */
-static irqreturn_t
-maciisi_interrupt(int irq, void* arg)
-{
-	int status;
-	struct adb_request *req;
-#ifdef DEBUG_MACIISI_ADB
-	static int dump_reply = 0;
-#endif
-	int i;
-	unsigned long flags;
-
-	local_irq_save(flags);
-
-	status = via[B] & (TIP|TREQ);
-#ifdef DEBUG_MACIISI_ADB
-	printk(KERN_DEBUG "state %d status %x ifr %x\n", maciisi_state, status, via[IFR]);
-#endif
-
-	if (!(via[IFR] & SR_INT)) {
-		/* Shouldn't happen, we hope */
-		printk(KERN_ERR "maciisi_interrupt: called without interrupt flag set\n");
-		local_irq_restore(flags);
-		return IRQ_NONE;
-	}
-
-	/* Clear the interrupt */
-	/* via[IFR] = SR_INT; */
-
- switch_start:
-	switch (maciisi_state) {
-	case idle:
-		if (status & TIP)
-			printk(KERN_ERR "maciisi_interrupt: state is idle but TIP asserted!\n");
-
-		if(!reading_reply)
-			udelay(ADB_DELAY);
-		/* Shift in */
-		via[ACR] &= ~SR_OUT;
- 		/* Signal start of frame */
-		via[B] |= TIP;
-		/* Clear the interrupt (throw this value on the floor, it's useless) */
-		tmp = via[SR];
-		/* ACK adb chip, high-low */
-		via[B] |= TACK;
-		udelay(ADB_DELAY);
-		via[B] &= ~TACK;
-		reply_len = 0;
-		maciisi_state = reading;
-		if (reading_reply) {
-			reply_ptr = current_req->reply;
-		} else {
-			reply_ptr = maciisi_rbuf;
-		}
-		break;
-
-	case sending:
-		/* via[SR]; */
-		/* Set ACK off */
-		via[B] &= ~TACK;
-		req = current_req;
-
-		if (!(status & TREQ)) {
-			/* collision */
-			printk(KERN_ERR "maciisi_interrupt: send collision\n");
-			/* Set idle and input */
-			via[ACR] &= ~SR_OUT;
-			tmp = via[SR];
-			via[B] &= ~TIP;
-			/* Must re-send */
-			reading_reply = 0;
-			reply_len = 0;
-			maciisi_state = idle;
-			udelay(ADB_DELAY);
-			/* process this now, because the IFR has been cleared */
-			goto switch_start;
-		}
-
-		udelay(ADB_DELAY);
-
-		if (data_index >= req->nbytes) {
-			/* Sent the whole packet, put the bus back in idle state */
-			/* Shift in, we are about to read a reply (hopefully) */
-			via[ACR] &= ~SR_OUT;
-			tmp = via[SR];
-			/* End of frame */
-			via[B] &= ~TIP;
-			req->sent = 1;
-			maciisi_state = idle;
-			if (req->reply_expected) {
-				/* Note: only set this once we've
-                                   successfully sent the packet */
-				reading_reply = 1;
-			} else {
-				current_req = req->next;
-				if (req->done)
-					(*req->done)(req);
-				/* Do any queued requests now */
-				i = maciisi_start();
-				if(i == 0 && need_sync) {
-					/* Packet needs to be synced */
-					maciisi_sync(current_req);
-				}
-				if(i != -EBUSY)
-					need_sync = 0;
-			}
-		} else {
-			/* Sending more stuff */
-			/* Shift out */
-			via[ACR] |= SR_OUT;
-			/* Write */
-			via[SR] = req->data[data_index++];
-			/* Signal 'byte ready' */
-			via[B] |= TACK;
-		}
-		break;
-
-	case reading:
-		/* Shift in */
-		/* via[ACR] &= ~SR_OUT; */ /* Not in 2.2 */
-		if (reply_len++ > 16) {
-			printk(KERN_ERR "maciisi_interrupt: reply too long, aborting read\n");
-			via[B] |= TACK;
-			udelay(ADB_DELAY);
-			via[B] &= ~(TACK|TIP);
-			maciisi_state = idle;
-			i = maciisi_start();
-			if(i == 0 && need_sync) {
-				/* Packet needs to be synced */
-				maciisi_sync(current_req);
-			}
-			if(i != -EBUSY)
-				need_sync = 0;
-			break;
-		}
-		/* Read data */
-		*reply_ptr++ = via[SR];
-		status = via[B] & (TIP|TREQ);
-		/* ACK on/off */
-		via[B] |= TACK;
-		udelay(ADB_DELAY);
-		via[B] &= ~TACK;	
-		if (!(status & TREQ))
-			break; /* more stuff to deal with */
-		
-		/* end of frame */
-		via[B] &= ~TIP;
-		tmp = via[SR]; /* That's what happens in 2.2 */
-		udelay(ADB_DELAY); /* Give controller time to recover */
-
-		/* end of packet, deal with it */
-		if (reading_reply) {
-			req = current_req;
-			req->reply_len = reply_ptr - req->reply;
-			if (req->data[0] == ADB_PACKET) {
-				/* Have to adjust the reply from ADB commands */
-				if (req->reply_len <= 2 || (req->reply[1] & 2) != 0) {
-					/* the 0x2 bit indicates no response */
-					req->reply_len = 0;
-				} else {
-					/* leave just the command and result bytes in the reply */
-					req->reply_len -= 2;
-					memmove(req->reply, req->reply + 2, req->reply_len);
-				}
-			}
-#ifdef DEBUG_MACIISI_ADB
-			if (dump_reply) {
-				int i;
-				printk(KERN_DEBUG "maciisi_interrupt: reply is ");
-				for (i = 0; i < req->reply_len; ++i)
-					printk(" %.2x", req->reply[i]);
-				printk("\n");
-			}
-#endif
-			req->complete = 1;
-			current_req = req->next;
-			if (req->done)
-				(*req->done)(req);
-			/* Obviously, we got it */
-			reading_reply = 0;
-		} else {
-			maciisi_input(maciisi_rbuf, reply_ptr - maciisi_rbuf);
-		}
-		maciisi_state = idle;
-		status = via[B] & (TIP|TREQ);
-		if (!(status & TREQ)) {
-			/* Timeout?! More likely, another packet coming in already */
-#ifdef DEBUG_MACIISI_ADB
-			printk(KERN_DEBUG "extra data after packet: status %x ifr %x\n",
-			       status, via[IFR]);
-#endif
-#if 0
-			udelay(ADB_DELAY);
-			via[B] |= TIP;
-
-			maciisi_state = reading;
-			reading_reply = 0;
-			reply_ptr = maciisi_rbuf;
-#else
-			/* Process the packet now */
-			reading_reply = 0;
-			goto switch_start;
-#endif
-			/* We used to do this... but the controller might actually have data for us */
-			/* maciisi_stfu(); */
-		}
-		else {
-			/* Do any queued requests now if possible */
-			i = maciisi_start();
-			if(i == 0 && need_sync) {
-				/* Packet needs to be synced */
-				maciisi_sync(current_req);
-			}
-			if(i != -EBUSY)
-				need_sync = 0;
-		}
-		break;
-
-	default:
-		printk("maciisi_interrupt: unknown maciisi_state %d?\n", maciisi_state);
-	}
-	local_irq_restore(flags);
-	return IRQ_HANDLED;
-}
-
-static void
-maciisi_input(unsigned char *buf, int nb)
-{
-#ifdef DEBUG_MACIISI_ADB
-    int i;
-#endif
-
-    switch (buf[0]) {
-    case ADB_PACKET:
-	    adb_input(buf+2, nb-2, buf[1] & 0x40);
-	    break;
-    default:
-#ifdef DEBUG_MACIISI_ADB
-	    printk(KERN_DEBUG "data from IIsi ADB (%d bytes):", nb);
-	    for (i = 0; i < nb; ++i)
-		    printk(" %.2x", buf[i]);
-	    printk("\n");
-#endif
-	    break;
-    }
-}
-- 
2.7.3
