Return-Path: <wg@grandegger.com>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 9C410DDEF3
	for <linuxppc-dev@ozlabs.org>; Tue, 17 Mar 2009 20:12:35 +1100 (EST)
From: Wolfgang Grandegegr <wg@grandegger.com>
To: linux-mtd@lists.infradead.org
Subject: [PATCH 3/4] NAND: FSL-UPM: Add wait flags to support board/chip
	specific delays
Date: Tue, 17 Mar 2009 10:12:21 +0100
Message-Id: <1237281143-8768-4-git-send-email-wg@grandegger.com>
In-Reply-To: <1237281143-8768-3-git-send-email-wg@grandegger.com>
References: <1237281143-8768-1-git-send-email-wg@grandegger.com>
	<1237281143-8768-2-git-send-email-wg@grandegger.com>
	<1237281143-8768-3-git-send-email-wg@grandegger.com>
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

From: Wolfgang Grandegger <wg@grandegger.com>

The NAND flash on the TQM8548_BE modules requires a short delay after
running the UPM pattern. The TQM8548_BE requires a further short delay
after writing out a buffer. Normally the R/B pin should be checked, but
it's not connected on the TQM8548_BE. The existing driver uses similar
fixed delay points. To manage these extra delays in a more general way,
I introduced the "wait_flags" field allowing the board-specific driver
to specify various types of extra delay.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/mtd/nand/fsl_upm.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
index f42955c..0ffc872 100644
--- a/drivers/mtd/nand/fsl_upm.c
+++ b/drivers/mtd/nand/fsl_upm.c
@@ -25,6 +25,10 @@
 
 #define FSL_UPM_NAND_MAX_CHIPS 4
 
+#define FSL_UPM_WAIT_RUN_PATTERN  0x1
+#define FSL_UPM_WAIT_WRITE_BYTE   0x2
+#define FSL_UPM_WAIT_WRITE_BUFFER 0x4
+
 struct fsl_upm_nand {
 	struct device *dev;
 	struct mtd_info mtd;
@@ -44,6 +48,7 @@ struct fsl_upm_nand {
 	uint32_t max_chips;
 	uint32_t chip_number;
 	uint32_t chip_offset;
+	uint32_t wait_flags;
 };
 
 #define to_fsl_upm_nand(mtd) container_of(mtd, struct fsl_upm_nand, mtd)
@@ -101,7 +106,8 @@ static void fun_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 	}
 	fsl_upm_run_pattern(&fun->upm, chip->IO_ADDR_R, mar);
 
-	fun_wait_rnb(fun);
+	if (fun->wait_flags & FSL_UPM_WAIT_RUN_PATTERN)
+		fun_wait_rnb(fun);
 }
 
 static void fun_select_chip(struct mtd_info *mtd, int chip_nr)
@@ -143,8 +149,11 @@ static void fun_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 
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
@@ -293,6 +302,13 @@ static int __devinit fun_probe(struct of_device *ofdev,
 	if (prop && size == sizeof(uint32_t))
 		fun->chip_offset = *prop;
 
+	prop = of_get_property(ofdev->node, "wait-flags", &size);
+	if (prop && size == sizeof(uint32_t))
+		fun->wait_flags = *prop;
+	else
+		fun->wait_flags = (FSL_UPM_WAIT_RUN_PATTERN |
+				   FSL_UPM_WAIT_WRITE_BYTE);
+
 	fun->io_base = devm_ioremap_nocache(&ofdev->dev, io_res.start,
 					  io_res.end - io_res.start + 1);
 	if (!fun->io_base) {
-- 
1.6.0.6
