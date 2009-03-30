Return-Path: <wg@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 06A81DDE0E
	for <linuxppc-dev@ozlabs.org>; Mon, 30 Mar 2009 21:05:58 +1100 (EST)
Message-Id: <20090330100555.111388782@denx.de>
Date: Mon, 30 Mar 2009 12:02:43 +0200
From: Wolfgang Grandegger <wg@grandegger.com>
To: linux-mtd@lists.infradead.org,
 linuxppc-dev@ozlabs.org
Subject: [PATCH v4 2/4] NAND: FSL-UPM: Add wait flags to support board/chip
	specific delays
References: <20090330100241.346785618@denx.de>
Cc: devicetree-discuss@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

The NAND flash on the TQM8548_BE modules requires a short delay after
running the UPM pattern. The TQM8548_BE requires a further short delay
after writing out a buffer. Normally the R/B pin should be checked, but
it's not connected on the TQM8548_BE. The existing driver uses similar
fixed delay points. To manage these extra delays in a more general way,
I introduced the "fsl,ump-wait-flags" property allowing the board-
specific driver to specify various types of extra delay.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/mtd/nand/fsl_upm.c |   20 ++++++++++++++++++--
 1 file changed, 18 insertions(+), 2 deletions(-)

Index: linux-2.6/drivers/mtd/nand/fsl_upm.c
===================================================================
--- linux-2.6.orig/drivers/mtd/nand/fsl_upm.c	2009-03-30 12:01:35.634720440 +0200
+++ linux-2.6/drivers/mtd/nand/fsl_upm.c	2009-03-30 12:01:38.918718552 +0200
@@ -23,6 +23,10 @@
 #include <linux/io.h>
 #include <asm/fsl_lbc.h>
 
+#define FSL_UPM_WAIT_RUN_PATTERN  0x1
+#define FSL_UPM_WAIT_WRITE_BYTE   0x2
+#define FSL_UPM_WAIT_WRITE_BUFFER 0x4
+
 struct fsl_upm_nand {
 	struct device *dev;
 	struct mtd_info mtd;
@@ -41,6 +45,7 @@
 	uint32_t mchip_count;
 	uint32_t mchip_number;
 	int chip_delay;
+	uint32_t wait_flags;
 };
 
 #define to_fsl_upm_nand(mtd) container_of(mtd, struct fsl_upm_nand, mtd)
@@ -96,7 +101,8 @@
 		fun->mchip_offsets[fun->mchip_number];
 	fsl_upm_run_pattern(&fun->upm, chip->IO_ADDR_R, mar);
 
-	fun_wait_rnb(fun);
+	if (fun->wait_flags & FSL_UPM_WAIT_RUN_PATTERN)
+		fun_wait_rnb(fun);
 }
 
 static void fun_select_chip(struct mtd_info *mtd, int mchip_nr)
@@ -138,8 +144,11 @@
 
 	for (i = 0; i < len; i++) {
 		out_8(fun->chip.IO_ADDR_W, buf[i]);
-		fun_wait_rnb(fun);
+		if (fun->wait_flags & FSL_UPM_WAIT_WRITE_BYTE)
+			fun_wait_rnb(fun);
 	}
+	if (fun->wait_flags & FSL_UPM_WAIT_WRITE_BUFFER)
+		fun_wait_rnb(fun);
 }
 
 static int __devinit fun_chip_init(struct fsl_upm_nand *fun,
@@ -285,6 +294,13 @@
 	else
 		fun->chip_delay = 50;
 
+	prop = of_get_property(ofdev->node, "fsl,upm-wait-flags", &size);
+	if (prop && size == sizeof(uint32_t))
+		fun->wait_flags = *prop;
+	else
+		fun->wait_flags = FSL_UPM_WAIT_RUN_PATTERN |
+				  FSL_UPM_WAIT_WRITE_BYTE;
+
 	fun->io_base = devm_ioremap_nocache(&ofdev->dev, io_res.start,
 					    io_res.end - io_res.start + 1);
 	if (!fun->io_base) {
