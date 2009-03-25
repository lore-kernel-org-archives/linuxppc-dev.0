Return-Path: <wg@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id C0CD6DDE06
	for <linuxppc-dev@ozlabs.org>; Wed, 25 Mar 2009 21:08:24 +1100 (EST)
From: Wolfgang Grandegger <wg@grandegger.com>
To: linux-mtd@lists.infradead.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH v3 2/4] NAND: FSL-UPM: Add wait flags to support board/chip
	specific delays
Date: Wed, 25 Mar 2009 11:08:19 +0100
Message-Id: <1237975701-23201-3-git-send-email-wg@grandegger.com>
In-Reply-To: <1237975701-23201-2-git-send-email-wg@grandegger.com>
References: <1237975701-23201-1-git-send-email-wg@grandegger.com>
	<1237975701-23201-2-git-send-email-wg@grandegger.com>
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
I introduced the "wait-flags" property allowing the board-specific driver
to specify various types of extra delay.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 drivers/mtd/nand/fsl_upm.c |   20 ++++++++++++++++++--
 1 files changed, 18 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
index 9b314ce..3ecfc1e 100644
--- a/drivers/mtd/nand/fsl_upm.c
+++ b/drivers/mtd/nand/fsl_upm.c
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
@@ -41,6 +45,7 @@ struct fsl_upm_nand {
 	uint32_t num_chips;
 	uint32_t chip_number;
 	uint32_t chip_offset;
+	uint32_t wait_flags;
 };
 
 #define to_fsl_upm_nand(mtd) container_of(mtd, struct fsl_upm_nand, mtd)
@@ -97,7 +102,8 @@ static void fun_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 		mar |= fun->chip_number * fun->chip_offset;
 	fsl_upm_run_pattern(&fun->upm, chip->IO_ADDR_R, mar);
 
-	fun_wait_rnb(fun);
+	if (fun->wait_flags & FSL_UPM_WAIT_RUN_PATTERN)
+		fun_wait_rnb(fun);
 }
 
 static void fun_select_chip(struct mtd_info *mtd, int chip_nr)
@@ -139,8 +145,11 @@ static void fun_write_buf(struct mtd_info *mtd, const uint8_t *buf, int len)
 
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
@@ -285,6 +294,13 @@ static int __devinit fun_probe(struct of_device *ofdev,
 	if (prop && size == sizeof(uint32_t))
 		fun->chip_offset = *prop;
 
+	prop = of_get_property(ofdev->node, "fsl,upm-wait-flags", &size);
+	if (prop && size == sizeof(uint32_t))
+		fun->wait_flags = *prop;
+	else
+		fun->wait_flags =
+			FSL_UPM_WAIT_RUN_PATTERN | FSL_UPM_WAIT_WRITE_BYTE;
+
 	fun->io_base = devm_ioremap_nocache(&ofdev->dev, io_res.start,
 					  io_res.end - io_res.start + 1);
 	if (!fun->io_base) {
-- 
1.6.0.6
