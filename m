Return-Path: <andid@gmx.net>
Received: from mncltd.com (p15112080.pureserver.info [217.160.169.153])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 7B6EF67A84
	for <linuxppc-embedded@ozlabs.org>;
	Thu, 17 Feb 2005 12:19:27 +1100 (EST)
Message-ID: <4213F112.2060606@gmx.net>
Date: Thu, 17 Feb 2005 02:19:14 +0100
From: Andre' Draszik <andid@gmx.net>
Mime-Version: 1.0
Content-Type: multipart/mixed; boundary="=_p15112080-1931-1108603161-0001-2"
To: Matt Porter <mporter@kernel.crashing.org>
References: <4206ED97.2060506@gmx.net> <20050216161432.B31885@cox.net>
In-Reply-To: <20050216161432.B31885@cox.net>
Cc: linuxppc-embedded@ozlabs.org
Subject: Re: [PATCH][PPC32] PPC4xx ocp ide rewrite/cleanup
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

This is a MIME-formatted message.  If you see this text it means that your
E-mail software does not support MIME-formatted messages.

--=_p15112080-1931-1108603161-0001-2
Content-Type: text/plain; charset=us-ascii; format=flowed
Content-Transfer-Encoding: 7bit

Hi,

Matt Porter wrote:
> On Mon, Feb 07, 2005 at 05:24:55AM +0100, Andre' Draszik wrote:
> 
>>Hi,
>>
>>this is a rewrite of the ibm4xx ocp ide driver. In its current state it
>>[...]
> 
> I tried applying this to current linuxppc-2.5. All hunks are rejected.
> Can you double check this patch and resend?

my kernel tree is
rsync -avz --delete source.mvista.com::linuxppc-2.5 linuxppc-2.5
and as of 16.02.05 23:44GMT the patch still applies. so did i really
send a wrong patch or has the rsync mirror just not yet been
updated? or is it a whitespace issue?

just checked - it's the last, so here's the patch, rediffed to
2.6.11-rc4, as attachment, not inline this time.

hope it works...
a.

--=_p15112080-1931-1108603161-0001-2
Content-Type: text/x-patch; name="stb04ide.diff"; charset=iso-8859-1
Content-Transfer-Encoding: 8bit
Content-Disposition: inline;
 filename="stb04ide.diff"

diff -urN -X ../patches/linux/dontdiff linuxppc-2.5.orig/drivers/ide/Kconfig linuxppc-2.5/drivers/ide/Kconfig
--- linuxppc-2.5.orig/drivers/ide/Kconfig	2005-02-16 20:15:27.000000000 +0100
+++ linuxppc-2.5/drivers/ide/Kconfig	2005-02-17 01:44:58.437817472 +0100
@@ -930,7 +930,7 @@
 endchoice
 
 config BLK_DEV_IDE_STB04xxx
-	bool "STB04xxx (Redwood-5) IDE support"
+	tristate "STB04xxx (Redwood-5) IDE support"
 	depends on BLK_DEV_IDE && REDWOOD_5
 	help
 	  This option provides support for IDE on IBM STB04xxx Redwood-5
@@ -1016,11 +1016,11 @@
 endif
 
 config BLK_DEV_IDEDMA
-	def_bool BLK_DEV_IDEDMA_PCI || BLK_DEV_IDEDMA_PMAC || BLK_DEV_IDEDMA_ICS
+	def_bool BLK_DEV_IDEDMA_PCI || BLK_DEV_IDEDMA_PMAC || BLK_DEV_IDEDMA_ICS || BLK_DEV_IDE_STB04xxx
 
 config IDEDMA_IVB
 	bool "IGNORE word93 Validation BITS"
-	depends on BLK_DEV_IDEDMA_PCI || BLK_DEV_IDEDMA_PMAC || BLK_DEV_IDEDMA_ICS
+	depends on BLK_DEV_IDEDMA_PCI || BLK_DEV_IDEDMA_PMAC || BLK_DEV_IDEDMA_ICS || BLK_DEV_IDE_STB04xxx
 	---help---
 	  There are unclear terms in ATA-4 and ATA-5 standards how certain
 	  hardware (an 80c ribbon) should be detected. Different interpretations
@@ -1035,7 +1035,7 @@
 	  It is normally safe to answer Y; however, the default is N.
 
 config IDEDMA_AUTO
-	def_bool IDEDMA_PCI_AUTO || IDEDMA_ICS_AUTO
+	def_bool IDEDMA_PCI_AUTO || IDEDMA_ICS_AUTO || BLK_DEV_IDE_STB04xxx
 
 endif
 
diff -urN -X ../patches/linux/dontdiff linuxppc-2.5.orig/drivers/ide/Makefile linuxppc-2.5/drivers/ide/Makefile
--- linuxppc-2.5.orig/drivers/ide/Makefile	2005-02-16 20:15:29.000000000 +0100
+++ linuxppc-2.5/drivers/ide/Makefile	2005-02-17 01:44:58.505807136 +0100
@@ -38,6 +38,11 @@
 # built-in only drivers from ppc/
 ide-core-$(CONFIG_BLK_DEV_MPC8xx_IDE)	+= ppc/mpc8xx.o
 ide-core-$(CONFIG_BLK_DEV_IDE_PMAC)	+= ppc/pmac.o
+ifeq ($(CONFIG_BLK_DEV_IDE_STB04xxx),y)
+ide-core-$(CONFIG_BLK_DEV_IDE_STB04xxx)	+= ppc/ibm_ocp_ide.o
+else
+obj-$(CONFIG_BLK_DEV_IDE_STB04xxx)	+= ppc/ibm_ocp_ide.o
+endif
 
 # built-in only drivers from h8300/
 ide-core-$(CONFIG_H8300)		+= h8300/ide-h8300.o
diff -urN -X ../patches/linux/dontdiff linuxppc-2.5.orig/drivers/ide/ppc/ibm_ocp_ide.c linuxppc-2.5/drivers/ide/ppc/ibm_ocp_ide.c
--- linuxppc-2.5.orig/drivers/ide/ppc/ibm_ocp_ide.c	2005-02-16 20:15:27.000000000 +0100
+++ linuxppc-2.5/drivers/ide/ppc/ibm_ocp_ide.c	2005-02-17 01:44:59.263691920 +0100
@@ -1,14 +1,26 @@
 /*
- *    Copyright 2002 MontaVista Software Inc.
- *      Completed implementation.
- *      Author: Armin Kuster <akuster@mvista.com>
- *      MontaVista Software, Inc.  <source@mvista.com>
+ * IDE driver for IBM On-chip IDE contollers
+ *    Copyright 2001 - 2002 MontaVista Software Inc.
+ *    Dan Malek.
  *
- *    Module name: ibm_ocp_ide.c
+ *    Version 1.2 (01/30/12) Armin
+ *    Converted to ocp
+ *    merger up to new ide-timing.h
  *
- *    Description:
+ *    Version 2.0 (05/02/15) - armin
+ *    converted to new core_ocp and only supports one interface for now.
  *
- *    Based on ocp_stbxxxx.c
+ *    Version 2.1 (05/25/02) - armin
+ *      name change from *_driver to *_dev
+ *    Version 2.2 06/13/02 - Armin
+ *      changed irq_resource array to just irq
+ *
+ *    Version 2.3 (Feb 2005) - andre
+ *      - big rewrite to fix some serious bugs
+ *      - bring up to date with ide in 2.6.11-rc3
+ *      - DMA works correctly now, even with non-hard-disks
+ *        I snagged bits and pieces from a variety of drivers, primarily
+ *        ide-pmac.c and ide-dma.c .....thanks to previous authors!
  */
 
 #include <linux/types.h>
@@ -17,54 +29,47 @@
 #include <linux/hdreg.h>
 #include <linux/delay.h>
 #include <linux/ide.h>
-#include "../ide-timing.h"
+#include <ide-timing.h>
 #include <asm/ocp.h>
 #include <asm/io.h>
 #include <asm/scatterlist.h>
-#include <asm/ppc4xx_dma.h>
-
-#include "ide_modes.h"
+#include <asm/dma-mapping.h>
 
-#define IDE_VER			"2.0"
-ppc_dma_ch_t dma_ch;
+#define OCPVR	"2.3"
 
-/* use DMA channel 2 for IDE DMA operations */
-#define IDE_DMACH	2	/* 2nd DMA channel */
-#define IDE_DMA_INT	6	/* IDE dma channel 2 interrupt */
 
-#define WMODE	0		/* default to DMA line mode */
-#define PIOMODE	0
 
 #define MK_TIMING(AS, DIOP, DIOY, DH) \
-	((FIT((AS),    0, 15) << 27) | \
-	 (FIT((DIOP),  0, 63) << 20) | \
-	 (FIT((DIOY),  0, 63) << 13) | \
-	 (FIT((DH),    0,  7) << 9))
+	((FIT((AS),    0, 0x0f) << 27) | \
+	 (FIT((DIOP),  0, 0x3f) << 20) | \
+	 (FIT((DIOY),  0, 0x3f) << 13) | \
+	 (FIT((DH),    0, 0x07) <<  9))
 
 #define UTIMING_SETHLD	(EZ(20 /*tACK*/, SYS_CLOCK_NS) - 1 /*fixed cycles*/)
 #define UTIMING_ENV	(EZ(20 /*tENV*/, SYS_CLOCK_NS) - 1 /*fixed cycles*/)
 #define UTIMING_SS	(EZ(50 /*tSS */, SYS_CLOCK_NS) - 3 /*fixed cycles*/)
+
 #define MK_UTIMING(CYC, RP) \
-	((FIT(UTIMING_SETHLD, 0, 15) << 27) | \
-	 (FIT(UTIMING_ENV,    0, 15) << 22) | \
-	 (FIT((CYC),          0, 15) << 17) | \
-	 (FIT((RP),           0, 63) << 10) | \
-	 (FIT(UTIMING_SS,     0, 15) << 5)  | \
+	((FIT(UTIMING_SETHLD, 0, 0x0f) << 27) | \
+	 (FIT(UTIMING_ENV,    0, 0x0f) << 22) | \
+	 (FIT((CYC),          0, 0x0f) << 17) | \
+	 (FIT((RP),           0, 0x3f) << 10) | \
+	 (FIT(UTIMING_SS,     0, 0x0f) <<  5) | \
 	 1 /* Turn on Ultra DMA */)
 
 /* Define the period of the STB clock used to generate the
  * IDE bus timing.  The clock is actually 63 MHz, but it
- * get rounded in a favorable direction.
+ * gets rounded in a favorable direction.
  */
 #define IDE_SYS_FREQ	63	/* MHz */
-#define SYS_CLOCK_NS	(1000 / IDE_SYS_FREQ)
+#define SYS_CLOCK_NS	(1000 / IDE_SYS_FREQ)   /* 1takt == SYS_CLOCK_NS nanosekunden */
 
 struct whold_timing {
 	short mode;
 	short whold;
 };
 
-static struct whold_timing whold_timing[] = {
+static const struct whold_timing whold_timing[] = {
 
 	{XFER_UDMA_5, 0},
 	{XFER_UDMA_4, 0},
@@ -101,10 +106,10 @@
  * but rather "fast" and "slow" timing.  We have to determeine
  * which is the "fast" device based upon their capability.
  */
-static int pio_mode[2];
+static int pio_mode[2] = { -1, -1 };
+
 
-/* Structure of the memory mapped IDE control.
-*/
+/* structure of the memory mapped IDE control */
 typedef struct ide_regs {
 	unsigned int si_stat;	/* IDE status */
 	unsigned int si_intenable;	/* IDE interrupt enable */
@@ -114,8 +119,8 @@
 	unsigned int si_c0fpt;	/* Chan 0 Fast PIO transfer timing */
 	unsigned int si_c0timo;	/* Chan 0 timeout */
 	unsigned int pad1[2];
-	unsigned int si_c0d0u;	/* Chan 0 UDMA transfer timing */
-#define si_c0d0m si_c0d0u	/* Chan 0 Multiword DMA timing */
+	unsigned int si_c0d0u;	/* Chan 0 dev 0 UDMA timing */
+#define si_c0d0m si_c0d0u	/* Chan 0 dev 0 Multiword DMA timing */
 	unsigned int pad2;
 	unsigned int si_c0d1u;	/* Chan 0 dev 1 UDMA timing */
 #define si_c0d1m si_c0d1u	/* Chan 0 dev 1 Multiword DMA timing */
@@ -148,84 +153,74 @@
 	unsigned int prd_physptr;
 	unsigned int prd_count;	/* Count only in lower 16 bits */
 } prd_entry_t;
-#define PRD_EOT		(uint)0x80000000	/* Set in prd_count */
+#define PRD_EOT		0x80000000lu	/* Set in prd_count */
 
 /* The number of PRDs required in a single transfer from the upper IDE
- * functions.  I believe the maximum number is 128, but most seem to
- * code to 256.  It's probably best to keep this under one page......
+ * functions. The maximum number is 128 (ide.h), but most seem to code to
+ * 256 (because of having two IDE channels). must be less than one page.
  */
-#define NUM_PRD	256
+#define NUM_PRD 256
 
-static volatile ide_t *idp;
-/* Virtual and physical address of the PRD page.
-*/
-static prd_entry_t *prd_table;
-static dma_addr_t prd_phys;
-
-/* Function Prototypes */
-static void ocp_ide_tune_drive(ide_drive_t *, byte);
-static int ocp_ide_dma_off(ide_drive_t * drive);
 
-/* The STB04 has a fixed number of cycles that get added in
- * regardless.  Adjust an ide_timing struct to accommodate that.
- */
-static void
-ocp_ide_adjust_timing(struct ide_timing *t)
-{
-	t->setup -= 2;
-	t->act8b -= 1;
-	t->rec8b -= 1;
-	t->active -= 1;
-	t->recover -= 1;
-}
 
-/* this iis barrowed from ide_timing_find_mode so we can find the proper 
- * whold parameter 
+/* this is borrowed from ide_timing_find_mode so we can find the proper
+ * whold parameter
  */
-
 static short
 whold_timing_find_mode(short speed)
 {
-	struct whold_timing *t;
+	const struct whold_timing *t;
+
+	for (t = whold_timing; likely (t->mode >= 0); t++)
+		if (t->mode == speed)
+			return t->whold;
 
-	for (t = whold_timing; t->mode != speed; t++)
-		if (t->mode < 0)
-			return 0;
-	return t->whold;
+	return 0;
+}
+
+/* The STB04 has a fixed number of cycles that get added in
+ * regardless.  Adjust an ide_timing struct to accommodate that.
+ */
+static void
+stb04xxx_ide_adjust_timing(struct ide_timing * const t)
+{
+	t->setup   -= 2;
+	t->act8b   -= 1;
+	t->rec8b   -= 1;
+	t->active  -= 1;
+	t->recover -= 1;
 }
 
 static int
-ocp_ide_set_drive(ide_drive_t * drive, unsigned char speed)
+stb04xxx_ide_tune_chipset (ide_drive_t * const drive,
+			   u8           speed)
 {
-	ide_drive_t *peer;
-	struct ide_timing d, p, merge, *fast;
-	int fast_device;
-	unsigned int ctl;
-	volatile unsigned int *dtiming;
+	volatile ide_t __iomem * const ide_regs  = HWIF (drive)->hwif_data;
+	ide_drive_t       *peer        = HWIF (drive)->drives + (~drive->dn & 1);
+	struct ide_timing  t, p, merge, *fast;
+	int                fast_device;
+	unsigned int       ctl;
 
 	if (speed != XFER_PIO_SLOW && speed != drive->current_speed)
 		if (ide_config_drive_speed(drive, speed))
-			printk(KERN_WARNING
-			       "ide%d: Drive %d didn't accept speed setting. Oh, well.\n",
-			       drive->dn >> 1, drive->dn & 1);
-
-	ide_timing_compute(drive, speed, &d, SYS_CLOCK_NS, SYS_CLOCK_NS);
-	ocp_ide_adjust_timing(&d);
+			printk (KERN_WARNING
+				"ide%d: Drive %d didn't accept speed setting. "
+				"Oh, well.\n",
+				drive->dn >> 1, drive->dn & 1);
 
-	/* This should be set somewhere else, but it isn't.....
-	 */
-	drive->dn = ((drive->select.all & 0x10) != 0);
-	peer = HWIF(drive)->drives + (~drive->dn & 1);
+	ide_timing_compute(drive, speed, &t, SYS_CLOCK_NS, SYS_CLOCK_NS);
+	stb04xxx_ide_adjust_timing(&t);
 
+	/* peer is the other, i.e. not current, drive */
 	if (peer->present) {
 		ide_timing_compute(peer, peer->current_speed, &p,
 				   SYS_CLOCK_NS, SYS_CLOCK_NS);
-		ocp_ide_adjust_timing(&p);
-		ide_timing_merge(&p, &d, &merge,
+		stb04xxx_ide_adjust_timing(&p);
+		ide_timing_merge(&p, &t, &merge,
 				 IDE_TIMING_8BIT | IDE_TIMING_SETUP);
-	} else {
-		merge = d;
 	}
+	else
+		merge = t;
 
 	if (!drive->init_speed)
 		drive->init_speed = speed;
@@ -235,58 +230,59 @@
 	 * interface timing.  It would sure be nice if they would
 	 * have just had the timing registers for each device......
 	 */
-	if (drive->dn & 1)
-		pio_mode[1] = (int) speed;
-	else
-		pio_mode[0] = (int) speed;
-
-	if (pio_mode[0] > pio_mode[1])
-		fast_device = 0;
-	else
-		fast_device = 1;
+	/* change pio_mode of current drive */
+	pio_mode[(drive->dn & 1)] = (int) speed;
 
 	/* Now determine which of the drives
 	 * the first call we only know one device, and on subsequent
 	 * calls the user may manually change drive parameters.
 	 * Make timing[0] the fast device and timing[1] the slow.
 	 */
+
+	/* compare pio_mode of both drives, one of them is
+	   faster than the other */
+	if (pio_mode[0] >= pio_mode[1])
+		fast_device = 0;
+	else
+		fast_device = 1;
+
 	if (fast_device == (drive->dn & 1))
-		fast = &d;
+		/* if fast drive == current drive */
+		fast = &t;
 	else
+		/* if fast drive == peer (other) drive */
 		fast = &p;
 
 	/* Now we know which device is the fast one and which is
 	 * the slow one.  The merged timing goes into the "regular"
 	 * timing registers and represents the slower of both times.
 	 */
-
-	idp->si_c0rt = MK_TIMING(merge.setup, merge.act8b,
-				 merge.rec8b,
-				 whold_timing_find_mode(merge.mode));
-
-	idp->si_c0fpt = MK_TIMING(fast->setup, fast->act8b,
-				  fast->rec8b,
-				  whold_timing_find_mode(fast->mode));
-
-	/* Tell the interface which drive is the fast one.
-	 */
-	ctl = idp->si_c0c;	/* Chan 0 Control */
-	ctl &= ~0x10000000;
+	ide_regs->si_c0rt = MK_TIMING(merge.setup, merge.act8b,
+				      merge.rec8b,
+				      whold_timing_find_mode(merge.mode));
+
+	ide_regs->si_c0fpt = MK_TIMING(fast->setup, fast->act8b,
+				       fast->rec8b,
+				       whold_timing_find_mode(fast->mode));
+
+	/* tell the interface which drive is the fast one. 	 */
+	ctl = ide_regs->si_c0c; /* Chan 0 Control */
+	ctl &= ~0x10000000ul;
 	ctl |= fast_device << 28;
-	idp->si_c0c = ctl;
+	ide_regs->si_c0c = ctl;
 
-	/* Set up DMA timing.
-	 */
+	/* Set up DMA timing. */
 	if ((speed & XFER_MODE) != XFER_PIO) {
 		/* NOTE: si_c0d0m and si_c0d0u are two different names
 		 * for the same register.  Whether it is used for
 		 * Multi-word DMA timings or Ultra DMA timings is
 		 * determined by the LSB written into it.  This is also
 		 * true for si_c0d1m and si_c0d1u.  */
+		volatile unsigned int __iomem *dtiming;
 		if (drive->dn & 1)
-			dtiming = &(idp->si_c0d1m);
+			dtiming = &(ide_regs->si_c0d1u);
 		else
-			dtiming = &(idp->si_c0d0m);
+			dtiming = &(ide_regs->si_c0d0u);
 
 		if ((speed & XFER_MODE) == XFER_UDMA) {
 			static const int tRP[] = {
@@ -295,18 +291,18 @@
 				EZ(100, SYS_CLOCK_NS) - 2 /*fixed cycles */ ,
 				EZ(100, SYS_CLOCK_NS) - 2 /*fixed cycles */ ,
 				EZ(100, SYS_CLOCK_NS) - 2 /*fixed cycles */ ,
-				EZ(85, SYS_CLOCK_NS) - 2	/*fixed cycles */
+				EZ( 85, SYS_CLOCK_NS) - 2 /*fixed cycles */
 			};
 			static const int NUMtRP =
 			    (sizeof (tRP) / sizeof (tRP[0]));
 			*dtiming =
-			    MK_UTIMING(d.udma,
+			    MK_UTIMING(t.udma,
 				       tRP[FIT(speed & 0xf, 0, NUMtRP - 1)]);
 		} else {
-			/* Multi-word DMA.  Note that d.recover/2 is an
+			/* Multi-word DMA.  Note that t.recover/2 is an
 			 * approximation of MAX(tH, MAX(tJ, tN)) */
-			*dtiming = MK_TIMING(d.setup, d.active,
-					     d.recover, d.recover / 2);
+			*dtiming = MK_TIMING(t.setup, t.active,
+					     t.recover, t.recover / 2);
 		}
 		drive->using_dma = 1;
 	}
@@ -314,590 +310,547 @@
 	return 0;
 }
 
+/**
+ *	stb04xxx_ide_tune_drive - tune a drive attached to a stb04
+ *	@drive: drive to tune
+ *	@pio: desired PIO mode (255 for "best possible")
+ *
+ *	Set the interface PIO mode.
+ */
 static void
-ocp_ide_tune_drive(ide_drive_t * drive, byte pio)
+stb04xxx_ide_tune_drive (ide_drive_t * const drive,
+			 u8           pio)
 {
-	pio = ide_get_best_pio_mode(drive, pio, 5, NULL);
+	pio = ide_get_best_pio_mode (drive, pio, 4, NULL);
+	stb04xxx_ide_tune_chipset(drive, XFER_PIO_0 + pio);
 }
 
-/*
- * Fill in the next PRD entry.
- */
-
-static int ocp_ide_build_prd_entry(prd_entry_t **table, unsigned int paddr, 
-				   unsigned int size, int *count)
+static int
+stb04xxx_ide_dma_host_off (ide_drive_t * const drive)
 {
+	return 0;
+}
+static int stb04xxx_ide_dma_host_on (ide_drive_t * const drive) __attribute__((alias("stb04xxx_ide_dma_host_off")));
 
-	/*
-	 * Note that one PRD entry can transfer
-	 * at most 65535 bytes.
-	 */
-
-	while (size) {
-		unsigned int tc = (size < 0xfe00) ? size : 0xfe00;
+static int
+stb04xxx_ide_dma_off_quietly (ide_drive_t * const drive)
+{
+	drive->using_dma = 0;
+	return stb04xxx_ide_dma_host_off (drive);
+}
 
-		if (++(*count) >= NUM_PRD) {
-		  printk(KERN_WARNING "DMA table too small\n");
-			return 0;	/* revert to PIO for this request */
-		}
-		(*table)->prd_physptr = (paddr & 0xfffffffe);
+#if 0
+static int
+config_drive_for_dma (ide_drive_t * const drive)
+{
+	struct hd_driveid * const id   = drive->id;
+	ide_hwif_t        * const hwif = HWIF (drive);
 
-		if ((*table)->prd_physptr & 0xF) {
-			printk(KERN_WARNING "DMA buffer not 16 byte aligned.\n");
-			return 0;	/* revert to PIO for this request */
-		}
-		
-		(*table)->prd_count = (tc & 0xfffe);
-		paddr += tc;
-		size -= tc;
-		++(*table);
+	if ((id->capability & 1) && hwif->autodma) {
+		/* Consult the list of known "bad" drives */
+		if (0)
+			return stb04xxx_ide_dma_off_quietly (drive);
+
+		/* enable DMA on any drive that has
+		   UltraDMA (mode 0/1/2/3/4/5) enabled */
+                if ((id->field_valid & 4) && ((id->dma_ultra >> 8) & 0x3f))
+			return stb04xxx_ide_dma_on (drive);
+
+		/* enable DMA on any drive that has mode2 DMA
+		   (multi) enabled */
+		if (id->field_valid & 2)
+                        if ((id->dma_mword & 0x404) == 0x404)
+				return stb04xxx_ide_dma_on (drive);
+
+		/* Consult the list of known "good" drives */
+		if (1)
+			return stb04xxx_ide_dma_on (drive);
 	}
-
-	return 1;
+	return stb04xxx_ide_dma_off_quietly (drive);
 }
+#endif
 
-
+/**
+ *	stb04xxx_ide_dma_check - set up for DMA if possible
+ *	@drive: IDE drive to set up
+ *
+ *	Set up the drive for the highest supported speed considering the
+ *	driver, controller and cable
+ */
 static int
-ocp_ide_build_dmatable(ide_drive_t * drive, int wr)
+stb04xxx_ide_dma_check (ide_drive_t * const drive)
 {
-	prd_entry_t *table;
-	int count = 0;
-	struct request *rq = HWGROUP(drive)->rq;
-	unsigned long size, vaddr, paddr;
-	unsigned long prd_size, prd_paddr = 0;
-	struct bio_vec *bvec, *bvprv;
-	struct bio *bio;
-	int i;
+#if 0
+	return config_drive_for_dma (drive);
+#else
+	/* Allow UDMA_66 only if an 80 conductor cable is connected. */
+	u16 w80 = HWIF (drive)->udma_four;
 
-	table = prd_table;
+	/* Section 1.6.2.6 "IDE Controller, ATA/ATAPI-5" in the STB04xxx
+	 * Datasheet says the following modes are supported:
+	 *   PIO modes 0 to 4
+	 *   Multiword DMA modes 0 to 2
+	 *   UltraDMA modes 0 to 4
+	 */
+	int modes = XFER_PIO | XFER_EPIO | XFER_MWDMA | XFER_UDMA
+		    | (w80 ? XFER_UDMA_66 : 0);
+	int mode;
+
+	/* XFER_EPIO includes both PIO modes 4 and 5.  Mode 5 is not
+	 * valid for the STB04, so mask it out of consideration just
+	 * in case some drive sets it...
+	 */
+	drive->id->eide_pio_modes &= ~4;
 
-	bvprv = NULL;
-	rq_for_each_bio(bio, rq) {
-		bio_for_each_segment(bvec, bio, i) {
-			paddr = bvec_to_phys(bvec);
-			vaddr = (unsigned long) __va(paddr);
-			size = bvec->bv_len;
-			if (wr)
-				consistent_sync((void *)vaddr, 
-						size, PCI_DMA_TODEVICE);
-			else
-				consistent_sync((void *)vaddr,
-						size, PCI_DMA_FROMDEVICE);
-
-			if (!BIOVEC_PHYS_MERGEABLE(bvprv, bvec)) {
-				if (ocp_ide_build_prd_entry(&table, 
-							    prd_paddr,
-							    prd_size,
-							    &count) == 0)
-					return 0; /* use PIO */
-				prd_paddr = 0;
-			}
-
-			if (prd_paddr == 0) {
-				prd_paddr = paddr;
-				prd_size = size;
-			} else {
-			  prd_size += size;
-			}
-
-			bvprv = bvec;
-		} /* segments in bio */
-	} /* bios in rq */
-
-	if (prd_paddr) {
-		if (ocp_ide_build_prd_entry(&table, 
-					    prd_paddr,
-					    prd_size,
-					    &count) == 0)
-			return 0; /* use PIO */
-	}
+	mode = ide_find_best_mode (drive, modes);
 
-	/* Add the EOT to the last table entry.
-	 */
-	if (count) {
-		table--;
-		table->prd_count |= PRD_EOT;
-	} else {
-		printk(KERN_DEBUG "%s: empty DMA table?\n", drive->name);
-	}
+	drive->using_dma = 0;
+	stb04xxx_ide_tune_chipset (drive, mode);
+	if (HWIF (drive)->autodma
+	    && (((mode & XFER_MODE) == XFER_PIO)
+		|| ((mode & XFER_MODE) == XFER_EPIO)))
+		drive->using_dma = 0;
 
-	return 1;
+	return 0;
+#endif
 }
 
-/*
- * ocp_ide_dma_intr() is the handler for disk read/write DMA interrupts
- * This is taken directly from ide-dma.c, which we can't use because
- * it requires PCI support.
- */
-ide_startstop_t
-ocp_ide_dma_intr(ide_drive_t * drive)
+static int
+stb04xxx_ide_dma_on (ide_drive_t * const drive)
 {
-	int i;
-	byte stat, dma_stat;
-
-	dma_stat = HWIF(drive)->ide_dma_end(drive);
-	stat = HWIF(drive)->INB(IDE_STATUS_REG);	/* get drive status */
-	if (OK_STAT(stat, DRIVE_READY, drive->bad_wstat | DRQ_STAT)) {
-		if (!dma_stat) {
-			struct request *rq = HWGROUP(drive)->rq;
-			rq = HWGROUP(drive)->rq;
-			for (i = rq->nr_sectors; i > 0;) {
-				i -= rq->current_nr_sectors;
-				ide_end_request(drive, 1, 
-						rq->current_nr_sectors );
-			}
-			return ide_stopped;
-		}
-		printk("%s: dma_intr: bad DMA status (dma_stat=%x)\n",
-		       drive->name, dma_stat);
-	}
-	return ide_error(drive, "dma_intr", stat);
+	drive->using_dma = 1;
+	return stb04xxx_ide_dma_host_on (drive);
 }
 
-/* ....and another one....
-*/
-int
-report_drive_dmaing(ide_drive_t * drive)
-{
-	struct hd_driveid *id = drive->id;
 
-	if ((id->field_valid & 4) && (eighty_ninty_three(drive)) &&
-	    (id->dma_ultra & (id->dma_ultra >> 11) & 7)) {
-		if ((id->dma_ultra >> 13) & 1) {
-			printk(", UDMA(100)");	/* UDMA BIOS-enabled! */
-		} else if ((id->dma_ultra >> 12) & 1) {
-			printk(", UDMA(66)");	/* UDMA BIOS-enabled! */
-		} else {
-			printk(", UDMA(44)");	/* UDMA BIOS-enabled! */
-		}
-	} else if ((id->field_valid & 4) &&
-		   (id->dma_ultra & (id->dma_ultra >> 8) & 7)) {
-		if ((id->dma_ultra >> 10) & 1) {
-			printk(", UDMA(33)");	/* UDMA BIOS-enabled! */
-		} else if ((id->dma_ultra >> 9) & 1) {
-			printk(", UDMA(25)");	/* UDMA BIOS-enabled! */
-		} else {
-			printk(", UDMA(16)");	/* UDMA BIOS-enabled! */
-		}
-	} else if (id->field_valid & 4) {
-		printk(", (U)DMA");	/* Can be BIOS-enabled! */
-	} else {
-		printk(", DMA");
-	}
-	return 1;
-}
 
+/* fill in the next PRD entry
+   note that one PRD entry can transfer at most 65536 bytes */
 static int
-ocp_ide_check_dma(ide_drive_t * drive)
+build_prd_entry (prd_entry_t **table,
+		 u32           paddr,
+		 u32           size,
+		 int          *count)
 {
-	struct hd_driveid *id = drive->id;
-	int enable = 1;
-	int speed;
+	while (size) {
+		u16 tc = size & 0xffff;
 
-	drive->using_dma = 0;
+		if (unlikely (*count >= NUM_PRD)) {
+//			printk (KERN_WARNING "%s: DMA table too small\n",
+//					     __FUNCTION__);
+			return 0;	/* revert to PIO for this request */
+		}
 
-	if (drive->media == ide_floppy)
-		enable = 0;
+		/* data must be 16 byte aligned */
+		if (unlikely (paddr & 0xf)) {
+//			printk (KERN_WARNING
+//				"%s: DMA buffer not 16 byte aligned.\n",
+//				__FUNCTION__);
+			return 0;	/* revert to PIO for this request */
+		}
 
-	/* Check timing here, we may be able to include XFER_UDMA_66
-	 * and XFER_UDMA_100.  This basically tells the 'best_mode'
-	 * function to also consider UDMA3 to UDMA5 device timing.
-	 */
-	if (enable) {
-		/* Section 1.6.2.6 "IDE Controller, ATA/ATAPI-5" in the STB04xxx
-		 * Datasheet says the following modes are supported:
-		 *   PIO modes 0 to 4
-		 *   Multiword DMA modes 0 to 2
-		 *   UltraDMA modes 0 to 4
-		 */
-		int map = XFER_PIO | XFER_EPIO | XFER_MWDMA | XFER_UDMA;
-		/* XFER_EPIO includes both PIO modes 4 and 5.  Mode 5 is not
-		 * valid for the STB04, so mask it out of consideration just
-		 * in case some drive sets it...
-		 */
-		id->eide_pio_modes &= ~4;
-
-		/* Allow UDMA_66 only if an 80 conductor cable is connected. */
-		if (eighty_ninty_three(drive))
-			map |= XFER_UDMA_66;
-
-		speed = ide_find_best_mode(drive, map);
-		ocp_ide_set_drive(drive, speed);
-
-		if (HWIF(drive)->autodma &&
-		    (((speed & XFER_MODE) == XFER_PIO) ||
-		     ((speed & XFER_MODE) == XFER_EPIO))) {
-			drive->using_dma = 0;
+		/* transfer count must be a multiple of 16 */
+		if (unlikely (tc & 0x0f)) {
+//			printk (KERN_WARNING
+//				"%s: invalid DMA transfer count.\n",
+//				__FUNCTION__);
+			return 0;	/* revert to PIO for this request */
 		}
+		
+		(*table)->prd_physptr = paddr;
+		(*table)->prd_count   = tc;
+
+		paddr += (tc ? : 65536);
+		size  -= (tc ? : 65536);
+
+		++(*table);
+		++(*count);
 	}
 
-	return 0;
+	return 1;
 }
 
-static int ocp_ide_dma_off_quietly(ide_drive_t * drive)
+static int
+stb04xxx_ide_build_sglist (ide_drive_t        * const drive,
+			   ide_hwif_t         * const hwif,
+			   struct request     * const rq,
+			   struct scatterlist *sg)
 {
-	drive->using_dma = 0;
-	return 0;
-}
+	if ((rq->flags & REQ_DRIVE_TASKFILE) && rq->nr_sectors > 256)
+		BUG();
 
-static int ocp_ide_dma_off(ide_drive_t * drive)
-{
-	printk(KERN_INFO "%s: DMA disabled\n", drive->name);
-	return ocp_ide_dma_off_quietly(drive);
-}
+	ide_map_sg(drive, rq);
 
-static int ocp_ide_dma_on(ide_drive_t * drive)
-{
-	return ocp_ide_check_dma(drive);
+	hwif->sg_dma_direction = (rq_data_dir (rq) == READ) ? DMA_FROM_DEVICE : DMA_TO_DEVICE;
+	
+	return dma_map_sg(/* hwif->pci_dev */ NULL, sg, hwif->sg_nents,
+			  hwif->sg_dma_direction);
 }
 
-static int ocp_ide_dma_check(ide_drive_t * drive)
+static int
+stb04xxx_ide_build_dmatable (ide_drive_t    * const drive,
+			     ide_hwif_t     * const hwif,
+			     struct request * const rq)
 {
-	return ocp_ide_dma_on(drive);
-}
+	prd_entry_t  *table = (prd_entry_t *) hwif->dmatable_cpu;
+	unsigned int  count = 0;
+	int i;
+	struct scatterlist *sg = hwif->sg_table;
 
-static int __ocp_ide_dma_begin(ide_drive_t * drive, int writing)
-{
-	idp->si_c0tb = (unsigned int) prd_phys;
-	idp->si_c0s0 = 0xdc800000;	/* Clear all status */
-	idp->si_c0ie = 0x90000000;	/* Enable all intr */
-	idp->si_c0dcm = 0;
-	idp->si_c0dcm =
-		(writing ? 0x09000000 : 0x01000000);
-	return 0;
+	hwif->sg_nents = i = stb04xxx_ide_build_sglist (drive, hwif, rq, sg);
+
+	if (unlikely (!i))
+		goto use_pio_instead;
+	
+	++i;
+	while (--i) {
+		if (unlikely (!build_prd_entry (&table,
+						sg_dma_address (sg),
+						sg_dma_len (sg),
+						&count)))
+			goto use_pio_instead;
+
+		++sg;
+	}
+
+	if (likely (count)) {
+		--table;
+		table->prd_count |= PRD_EOT;
+		return count;
+	}
+
+	printk (KERN_ERR "%s: empty DMA table?\n", drive->name);
+
+use_pio_instead:
+	dma_unmap_sg (NULL,
+		      hwif->sg_table, hwif->sg_nents, hwif->sg_dma_direction);
+	
+	return 0; /* revert to PIO for this request */
 }
+	
 
-static int ocp_ide_dma_begin(ide_drive_t * drive)
+static void
+stb04xxx_ide_destroy_dmatable (ide_drive_t * const drive)
 {
-	idp->si_c0tb = (unsigned int) prd_phys;
-	idp->si_c0s0 = 0xdc800000;	/* Clear all status */
-	idp->si_c0ie = 0x90000000;	/* Enable all intr */
-	idp->si_c0dcm = 0;
-	idp->si_c0dcm =	0x01000000;
-	return 0;
+	ide_hwif_t *hwif = drive->hwif;
+	int nents = hwif->sg_nents;
+	
+	if (nents) {
+		dma_unmap_sg (NULL, hwif->sg_table, nents,
+			      hwif->sg_dma_direction);
+		hwif->sg_nents = 0;
+	}
 }
 
-static int ocp_ide_dma_io(ide_drive_t * drive, int writing)
+
+static int
+stb04xxx_dma_setup (ide_drive_t * const drive)
 {
-	if (!ocp_ide_build_dmatable(drive, writing))
+	ide_hwif_t             * const hwif = HWIF (drive);
+	volatile ide_t __iomem * const ide_regs = (ide_t *) hwif->hwif_data;
+	struct request         * const rq = HWGROUP (drive)->rq;
+
+	/* PRD table */
+	if (unlikely (!stb04xxx_ide_build_dmatable (drive, hwif, rq))) {
+		/* try PIO instead of DMA */
+		ide_map_sg (drive, rq);
 		return 1;
+	}
+
+	ide_regs->si_c0tb = hwif->dmatable_dma; /* address of sg list */
+	ide_regs->si_c0s0 = 0xdc800000ul;       /* clear all status */
+	ide_regs->si_c0ie = 0x90000000ul;       /* enable all intr */
+	/* specify r/w */
+	ide_regs->si_c0dcm = (rq_data_dir (rq) == READ) ? 0x00000000ul : 0x08000000ul;
 
 	drive->waiting_for_dma = 1;
-	if (drive->media != ide_disk)
-		return 0;
-	ide_set_handler(drive, &ocp_ide_dma_intr, WAIT_CMD, NULL);
-	HWIF(drive)->OUTB(writing ? WIN_WRITEDMA : WIN_READDMA,
-		 IDE_COMMAND_REG);
-	return __ocp_ide_dma_begin(drive, writing);
+	return 0;
 }
 
-static int ocp_ide_dma_read(ide_drive_t * drive)
+static void
+stb04xxx_dma_exec_cmd (ide_drive_t * const drive,
+		       u8           command)
 {
-	return ocp_ide_dma_io(drive, 0);
+	ide_execute_command (drive, command, &ide_dma_intr, 2*WAIT_CMD, NULL);
 }
 
-static int ocp_ide_dma_write(ide_drive_t * drive)
+static void
+stb04xxx_dma_start (ide_drive_t * const drive)
 {
-	return ocp_ide_dma_io(drive, 1);
+	volatile ide_t __iomem * const ide_regs  = (ide_t *) HWIF (drive)->hwif_data;
+
+	/* start DMA */
+	mb ();
+	ide_regs->si_c0dcm |= 0x01000000ul; /* kick it */
 }
 
-static int ocp_ide_dma_end(ide_drive_t * drive)
+static int
+stb04xxx_ide_dma_end (ide_drive_t * const drive)
 {
-	unsigned int dstat;
+	volatile ide_t __iomem * const ide_regs = (ide_t *) HWIF (drive)->hwif_data;
+	unsigned int    dstat;
 
 	drive->waiting_for_dma = 0;
-	dstat = idp->si_c0s1;
-	idp->si_c0s0 = 0xdc800000;	/* Clear all status */
+	/* stop DMA */
+	ide_regs->si_c0dcm &= ~0x01000000ul;
+	/* get DMA status */
+	dstat = ide_regs->si_c0s1;
+	/* clear all status bits */
+	ide_regs->si_c0s0 = 0xdc800000ul;
+	wmb ();
+	stb04xxx_ide_destroy_dmatable (drive);
 	/* verify good dma status */
-	return (dstat & 0x80000000);
-}
-
-static int ocp_ide_dma_test_irq(ide_drive_t * drive)
-{
-	return idp->si_c0s0 & 0x10000000 ? 1 : 0;
+	return (dstat & 0x10000000ul) ? 0 : 1; /* return true if DMA still active */
 }
 
-static int ocp_ide_dma_verbose(ide_drive_t * drive)
-{
-	return report_drive_dmaing(drive);
-}
-
-static unsigned int
-ocp_ide_spinup(int index)
+static int
+stb04xxx_ide_dma_test_irq (ide_drive_t * const drive)
 {
-	int i, ret;
-	ide_ioreg_t *io_ports;
+	/* return 1 if dma irq issued, 0 otherwise */
+	volatile ide_t __iomem * const ide = (ide_t *) HWIF (drive)->hwif_data;
 
-	ret = 1;
-	printk("OCP ide: waiting for drive spinup");
-	printk("ioports for drive %d @ %p\n",index,ide_hwifs[index].io_ports);
-	io_ports = ide_hwifs[index].io_ports;
-	printk(".");
-	
-	/* wait until drive is not busy (it may be spinning up) */
-	for (i = 0; i < 30; i++) {
-		unsigned char stat;
-		stat = inb_p(io_ports[7]);
-		/* wait for !busy & ready */
-		if ((stat & 0x80) == 0) {
-			break;
-		}
-		udelay(1000 * 1000);	/* 1 second */
+	if (ide->si_c0s0 & 0x10000000ul)
+		return 1;
+	if (!drive->waiting_for_dma) {
+		printk(KERN_WARNING "%s: (%s) called while not waiting\n",
+				    drive->name, __FUNCTION__);	
 	}
 
-	printk(".");
+	return 0;
+}
 
-	/* select slave */
-	outb_p(0xa0 | 0x10, io_ports[6]);
 
-	for (i = 0; i < 30; i++) {
-		unsigned char stat;
-		stat = inb_p(io_ports[7]);
-		/* wait for !busy & ready */
-		if ((stat & 0x80) == 0) {
-			break;
-		}
-		udelay(1000 * 1000);	/* 1 second */
-	}
-	if( i < 30){
-		outb_p(0xa0, io_ports[6]);
-		printk("Drive spun up \n");
-	} else {
-		printk("Drive spin up Failed !\n");
-		ret = 0;
-	}
-	return (ret);
+static int
+stb04xxx_ide_dma_lostirq (ide_drive_t * const drive)
+{
+	printk ("%s: DMA interrupt recovery neccessary\n", drive->name);
+	return 1;
 }
 
-int
-ocp_ide_default_irq(ide_ioreg_t base)
+static int
+stb04xxx_ide_dma_timeout (ide_drive_t * const drive)
 {
-	return IDE0_IRQ;
+	printk (KERN_ERR "%s: timeout waiting for DMA\n", drive->name);
+	if (stb04xxx_ide_dma_test_irq (drive))
+		return 0;
+	return stb04xxx_ide_dma_end (drive);
 }
 
-/*
- * setup_ocp_ide()
- * Completes the setup of a on-chip ide controller card, once found.
- */
-int __init setup_ocp_ide (struct ocp_device *pdev)
+static void
+stb04xxx_ide_setup_dma (ide_hwif_t * const hwif)
 {
-	ide_hwif_t	*hwif;
-	unsigned int uicdcr;
-	
-	hwif = &ide_hwifs[pdev->num];
-	hwif->index = pdev->num;
-#ifdef WMODE
-   /*Word Mode psc(11-12)=00,pwc(13-18)=000110, phc(19-21)=010, 22=1, 30=1  ----  0xCB02*/
-
-    dma_ch.mode	=TM_S_MM;	  /* xfer from peripheral to mem */
-    dma_ch.pwidth = PW_16;
-    dma_ch.pwc = 6;                     /* set the max wait cycles  */
-#else
-/*Line Mode psc(11-12)=00,pwc(13-18)=000001, phc(19-21)=010, 22=1, 30=1  ----  0x2B02*/
+	hwif->autodma = 1;
+	hwif->drives[0].autotune = hwif->drives[1].autotune = IDE_TUNE_AUTO;
+	hwif->drives[0].autodma  = hwif->drives[1].autodma  = hwif->autodma;
+
+	hwif->atapi_dma  = 1;
+	hwif->ultra_mask = hwif->udma_four ? 0x1f : 0x07;
+	hwif->mwdma_mask = 0x07;
+	hwif->swdma_mask = 0x00;
+
+	/* set everything to something != NULL */
+	hwif->ide_dma_host_off = &stb04xxx_ide_dma_host_off;
+	hwif->ide_dma_host_on  = &stb04xxx_ide_dma_host_on;
+
+	hwif->ide_dma_check = &stb04xxx_ide_dma_check;
+	hwif->ide_dma_off_quietly = &stb04xxx_ide_dma_off_quietly;
+	hwif->ide_dma_on          = &stb04xxx_ide_dma_on;
+
+	hwif->dma_setup    = &stb04xxx_dma_setup;
+	hwif->dma_exec_cmd = &stb04xxx_dma_exec_cmd;
+	hwif->dma_start    = &stb04xxx_dma_start;
+	hwif->ide_dma_end  = &stb04xxx_ide_dma_end;
 
-    dma_ch.mode	=DMA_MODE_MM_DEVATSRC;	  /* xfer from peripheral to mem */
-    dma_ch.pwidth = PW_64;		/* Line mode on stbs */
-    dma_ch.pwc = 1;                     /* set the max wait cycles  */
-#endif
+	hwif->ide_dma_test_irq = &stb04xxx_ide_dma_test_irq;
 
-    dma_ch.td	= DMA_TD;
-    dma_ch.buffer_enable = 0;
-    dma_ch.tce_enable = 0;
-    dma_ch.etd_output = 0;
-    dma_ch.pce = 0;
-    dma_ch.pl = EXTERNAL_PERIPHERAL;    /* no op */
-    dma_ch.dai = 1;
-    dma_ch.sai = 0;
-    dma_ch.psc = 0;                      /* set the max setup cycles */
-    dma_ch.phc = 2;                      /* set the max hold cycles  */
-    dma_ch.cp = PRIORITY_LOW;
-    dma_ch.int_enable = 0;
-    dma_ch.ch_enable = 0;		/* No chaining */
-    dma_ch.tcd_disable = 1;		/* No chaining */
-
-    if (hw_init_dma_channel(IDE_DMACH, &dma_ch) != DMA_STATUS_GOOD)
-        return -EBUSY;
-
-    /* init CIC select2 reg to connect external DMA port 3 to internal
-     * DMA channel 2
-     */
-    map_dma_port(IDE_DMACH,EXT_DMA_3,DMA_CHAN_2); 
-
-    /* Enable the interface.
-     */
-    idp->si_control = 0x80000000;
-    idp->si_c0s0 = 0xdc800000;	/* Clear all status */
-    idp->si_intenable = 0x80000000;
-
-    /* Per the STB04 data sheet:
-     *  1)  tTO = ((8*RDYT) + 1) * SYS_CLK
-     * and:
-     *  2)  tTO >= 1250 + (2 * SYS_CLK) - t2
-     * Solving the first equation for RDYT:
-     *             (tTO/SYS_CLK) - 1
-     *  3)  RDYT = -----------------
-     *                     8
-     * Substituting equation 2) for tTO in equation 3:
-     *             ((1250 + (2 * SYS_CLK) - t2)/SYS_CLK) - 1
-     *  3)  RDYT = -----------------------------------------
-     *                                8
-     * It's just the timeout so having it too long isn't too
-     * significant, so we'll just assume t2 is zero.  All this math
-     * is handled by the compiler and RDYT ends up being 11 assuming
-     * that SYS_CLOCK_NS is 15.
-     */
-    idp->si_c0timo = (EZ(EZ(1250 + 2 * SYS_CLOCK_NS, SYS_CLOCK_NS) - 1, 8)) << 23;	/* Chan 0 timeout */
-
-    /* Stuff some slow default PIO timing.
-     */
-    idp->si_c0rt = MK_TIMING(6, 19, 15, 2);
-    idp->si_c0fpt = MK_TIMING(6, 19, 15, 2);
-    
-    /* We should probably have UIC functions to set external
-     * interrupt level/edge.
-     */
-    uicdcr = mfdcr(DCRN_UIC_PR(UIC0));
-    uicdcr &= ~(0x80000000 >> IDE0_IRQ);
-    mtdcr(DCRN_UIC_PR(UIC0), uicdcr);
-    mtdcr(DCRN_UIC_TR(UIC0), 0x80000000 >> IDE0_IRQ);
-
-    /* Grab a page for the PRD Table.
-     */
-    prd_table = (prd_entry_t *) consistent_alloc(GFP_KERNEL,
-						 NUM_PRD *
-						 sizeof
-						 (prd_entry_t),
-						 &prd_phys);
-
-
-    if(!ocp_ide_spinup(hwif->index))
-	    return 0;
-    
-    return 1;
+	hwif->ide_dma_lostirq = &stb04xxx_ide_dma_lostirq;
+	hwif->ide_dma_timeout = &stb04xxx_ide_dma_timeout;
 }
 
-
-static int __devinit ocp_ide_probe(struct ocp_device *pdev)
+static int __init
+stb04xxx_ide_probe (struct ocp_device * const ocp)
 {
-	int i;
-	unsigned int index;
-	hw_regs_t * hw;
-	unsigned char *ip;
-
-	printk("IBM STB04xxx IDE driver version %s\n", IDE_VER);
-
-	hw = kmalloc(sizeof(*hw), GFP_KERNEL);
-	if (!hw)
-		return 0;
-	memset(hw, 0, sizeof(*hw));
-
-	if (!request_region(pdev->paddr, IDE0_SIZE, "IDE")) {
-		printk(KERN_WARNING "ocp_ide: failed request_region\n");
-		return -1;
-	}
-
-	if ((idp = (ide_t *) ioremap(pdev->paddr,
-				     IDE0_SIZE)) == NULL) {
-		printk(KERN_WARNING "ocp_ide: failed ioremap\n");
-		return -1;
+	int                     err;
+	unsigned int            uicdcr;
+	volatile ide_t __iomem *ide_regs;
+	unsigned long           flags;
+	ide_hwif_t             * const hwif = &ide_hwifs[0];
+	unsigned char          * ip;
+	int                     i;
+
+	printk ("IBM STB04xxx OCP IDE driver version %s\n", OCPVR);
+
+	if (!request_region (ocp->def->paddr, sizeof (ide_t), "ide"))
+		return -ENOMEM;
+
+	ocp_force_power_on (ocp);
+
+	ide_regs = ioremap (ocp->def->paddr, sizeof (ide_t));
+	if (unlikely (!ide_regs)) {
+		err = -ENOMEM;
+		goto error1;
 	}
 
-	pdev->dev.driver_data = (void *) idp;
 
-	pdev->ocpdev  = (void *) hw;
-	index = pdev->num;
-	ip = (unsigned char *) (&(idp->si_c0d));	/* Chan 0 data */
+	/* Enable the interface. */
+	ide_regs->si_control = 0x80000000ul;
+	ide_regs->si_c0s0 = 0xdc800000ul;       /* Clear all status */
+	ide_regs->si_intenable = 0x80000000ul;
+	/* Per the STB04 data sheet:
+	 *  1)  tTO = ((8*RDYT) + 1) * SYS_CLK
+	 * and:
+	 *  2)  tTO >= 1250 + (2 * SYS_CLK) - t2
+	 * Solving the first equation for RDYT:
+	 *             (tTO/SYS_CLK) - 1
+	 *  3)  RDYT = -----------------
+	 *                     8
+	 * Substituting equation 2) for tTO in equation 3:
+	 *             ((1250 + (2 * SYS_CLK) - t2)/SYS_CLK) - 1
+	 *  3)  RDYT = -----------------------------------------
+	 *                                8
+	 * It's just the timeout so having it too long isn't too
+	 * significant, so we'll just assume t2 is zero.  All this math
+	 * is handled by the compiler and RDYT ends up being 11 assuming
+	 * that SYS_CLOCK_NS is 15.
+	 */
+	ide_regs->si_c0timo = (EZ(EZ(1250 + 2 * SYS_CLOCK_NS, SYS_CLOCK_NS) - 1, 8)) << 23;	/* Chan 0 timeout */
 
-	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++) {
-		hw->io_ports[i] = (unsigned long) (ip++);
+	/* stuff some slow default PIO timing */
+	ide_regs->si_c0rt = MK_TIMING(6, 19, 15, 2);
+	ide_regs->si_c0fpt = MK_TIMING(6, 19, 15, 2);
+
+	/* enable 32bit access on both devices */
+	ide_regs->si_c0c |= 0x00008040ul;
+
+	/* we should probably have UIC functions to set external
+	   interrupt level/edge */
+	local_irq_save (flags);
+	uicdcr = mfdcr (DCRN_UIC_PR (UIC0));
+	uicdcr &= ~(0x80000000ul >> IDE0_IRQ);
+	mtdcr (DCRN_UIC_PR(UIC0), uicdcr);
+	mtdcr (DCRN_UIC_TR(UIC0),
+	       mfdcr (DCRN_UIC_TR (UIC0)) | (0x80000000ul >> IDE0_IRQ));
+	local_irq_restore (flags);
+
+
+	/* initialize */
+	hwif->gendev.parent = &ocp->dev;
+	ocp_set_drvdata (ocp, hwif);
+
+	/* setup MMIO ops */
+	default_hwif_mmiops (hwif);
+
+	/* tell common code _not_ to mess with resources */
+	hwif->mmio = 2;
+	ide_set_hwifdata (hwif, (void *) ide_regs);
+
+	ip = (unsigned char *) (&(ide_regs->si_c0d));    /* Chan 0 data */
+	for (i = IDE_DATA_OFFSET; i <= IDE_STATUS_OFFSET; i++)
+		hwif->hw.io_ports[i] = (int) (ip++);
+	hwif->hw.io_ports[IDE_CONTROL_OFFSET] = (int) (&(ide_regs->si_c0adc));
+	memcpy (hwif->io_ports, hwif->hw.io_ports, sizeof (hwif->hw.io_ports));
+	hwif->chipset = ide_generic;
+	hwif->irq     = ocp->def->irq;
+	hwif->noprobe = 0;
+	hwif->hold    = 1;
+	/* Figure out if an 80 conductor cable is connected */
+	hwif->udma_four = (ide_regs->si_c0s1 & 0x20000000ul) != 0;
+	hwif->tuneproc  = &stb04xxx_ide_tune_drive;
+	hwif->speedproc = &stb04xxx_ide_tune_chipset;
+	hwif->drives[0].io_32bit = hwif->drives[1].io_32bit = 1;
+	hwif->drives[0].unmask   = hwif->drives[1].unmask   = 1;
+	pio_mode[0] = pio_mode[1] = -1;
+	stb04xxx_ide_setup_dma (hwif);
+	
+	/* grab a page for the PRD table. this is save with respect to not
+	   crossing a 64k border because returned memory is page aligned
+	   and NUM_PRD*sizeof(prd_entry_t) end up being 2048 bytes, i.e.
+	   less than one page. */
+	hwif->dmatable_cpu = dma_alloc_coherent (NULL,
+						 NUM_PRD * sizeof (prd_entry_t),
+						 &hwif->dmatable_dma,
+						 GFP_KERNEL | GFP_DMA);
+	if (unlikely (!hwif->dmatable_cpu)) {
+		err = -ENOMEM;
+		goto error2;
 	}
+	hwif->sg_max_nents = NUM_PRD;
 
-	hw->io_ports[IDE_CONTROL_OFFSET] = (unsigned long) (&(idp->si_c0adc));
-	hw->irq = pdev->irq;
-
-	/* use DMA channel 2 for IDE DMA operations */
-	hw->dma = IDE_DMACH;
+	probe_hwif_init (hwif);
 
-	ide_hwifs[index].tuneproc = &ocp_ide_tune_drive;
-	ide_hwifs[index].drives[0].autotune = 1;
-	ide_hwifs[index].autodma = 1;
-	ide_hwifs[index].ide_dma_off = &ocp_ide_dma_off;
-	ide_hwifs[index].ide_dma_off_quietly = &ocp_ide_dma_off_quietly;
-	ide_hwifs[index].ide_dma_host_off = &ocp_ide_dma_off_quietly;
-	ide_hwifs[index].ide_dma_on = &ocp_ide_dma_on;
-	ide_hwifs[index].ide_dma_host_on = &ocp_ide_dma_on;
-	ide_hwifs[index].ide_dma_check = &ocp_ide_dma_check;
-	ide_hwifs[index].ide_dma_read = &ocp_ide_dma_read;
-	ide_hwifs[index].ide_dma_write = &ocp_ide_dma_write;
-	ide_hwifs[index].ide_dma_begin = &ocp_ide_dma_begin;
-	ide_hwifs[index].ide_dma_end = &ocp_ide_dma_end;
-	ide_hwifs[index].ide_dma_test_irq = &ocp_ide_dma_test_irq;
-	ide_hwifs[index].ide_dma_verbose = &ocp_ide_dma_verbose;
-	ide_hwifs[index].speedproc = &ocp_ide_set_drive;
-	ide_hwifs[index].noprobe = 0;
+	create_proc_ide_interfaces ();
 
-	memcpy(ide_hwifs[index].io_ports, hw->io_ports, sizeof (hw->io_ports));
-	ide_hwifs[index].irq = pdev->irq;
+	return 0;
 
-	ocp_force_power_on(pdev);
-	return 1;
+error2:
+	ide_set_hwifdata (hwif, NULL);
+	hwif->noprobe = 1;
+	hwif->chipset = ide_unknown;
+	ocp_set_drvdata (ocp, NULL);
+	iounmap (ide_regs);
+error1:
+	ocp_force_power_off (ocp);
+	release_region (ocp->def->paddr, sizeof (ide_t));
+	return err;
 }
 
-static void __devexit ocp_ide_remove_one (struct ocp_device *pdev)
+static void
+stb04xxx_ide_remove (struct ocp_device * const ocp)
 {
-	ocp_force_power_off(pdev);
+	ide_hwif_t             * const hwif = ocp_get_drvdata (ocp);
+	volatile ide_t __iomem * const ide_regs = ide_get_hwifdata (hwif);
+
+	/* ide_unregister () can't ever handle these correctly for us */
+	dma_free_coherent (NULL, NUM_PRD * sizeof (prd_entry_t),
+			   hwif->dmatable_cpu, hwif->dmatable_dma);
+	hwif->dmatable_cpu = NULL;
+	hwif->dmatable_dma = 0;
+
+	ide_unregister (hwif->index);
+	iounmap (ide_regs);
+	release_region (ocp->def->paddr, sizeof (ide_t));
+	
+	ocp_force_power_off (ocp);
 }
 
-static struct ocp_device_id ocp_ide_id_tbl[] __devinitdata = {
-	{OCP_VENDOR_IBM,OCP_FUNC_IDE},
-	{0,}
+
+static struct ocp_device_id stb04xxx_ide_ids[] __devinitdata =
+{
+        { .vendor = OCP_VENDOR_IBM, .function = OCP_FUNC_IDE},
+        { .vendor = OCP_VENDOR_INVALID }
 };
 
-MODULE_DEVICE_TABLE(ocp,ocp_ide_id_tbl );
+MODULE_DEVICE_TABLE (ocp, stb04xxx_ide_ids);
 
-static struct ocp_driver ocp_ide_driver = {
-	.name		= "ocp_ide",
-	.id_table	= ocp_ide_id_tbl,
-	.probe		= ocp_ide_probe,
-	.remove		= __devexit_p(ocp_ide_remove_one),
+static struct ocp_driver stb04xxx_ide_driver = {
+	.name     = "ide",
+	.id_table = stb04xxx_ide_ids,
+	.probe    = stb04xxx_ide_probe,
+	.remove   = __devexit_p (stb04xxx_ide_remove),
 #if defined(CONFIG_PM)
-	.suspend	= ocp_generic_suspend,
-	.resume		= ocp_generic_resume,
-#endif /* CONFIG_PM */
+	.suspend  = NULL,
+	.resume   = NULL,
+#endif
 };
 
 
-void __init std_ide_cntl_scan(void)
-{
-	struct ocp_device *dev;
-	int i, max;
-	printk("OCP ide ver:%s\n", IDE_VER);
-
-	ocp_module_init(&ocp_ide_driver);
-	max = ocp_get_num(OCP_FUNC_IDE);
-	for(i = 0; i < max; i++){
-		dev = ocp_get_dev(OCP_FUNC_IDE,i);
-		if(!dev)	
-		  setup_ocp_ide(dev);
-	}
-}
-#if 0
-#if defined (CONFIG_MODULE)
+
 static int __init
-ocp_ide_init(void)
+stb04xxx_ide_init (void)
 {
-	printk("OCP ide ver:%s\n", IDE_VER);
-	return ocp_module_init(&ocp_ide_driver);
+	return ocp_register_driver (&stb04xxx_ide_driver);
 }
 
-void __exit
-ocp_ide_fini(void)
+static void __exit
+stb04xxx_ide_exit (void)
 {
-	ocp_unregister_driver(&ocp_ide_driver);
+	ocp_unregister_driver (&stb04xxx_ide_driver);
 }
 
-module_init(ocp_ide_init);
-module_exit(ocp_ide_fini);
-#endif
-#endif
+/* needs to be called after ide has been initialized */
+late_initcall (stb04xxx_ide_init);
+module_exit (stb04xxx_ide_exit);
 
+MODULE_LICENSE ("GPL");
+MODULE_AUTHOR ("André Draszik <andid@gmx.net>");
+MODULE_DESCRIPTION ("driver for IBM OCP IDE on STB04xxx");

--=_p15112080-1931-1108603161-0001-2--
