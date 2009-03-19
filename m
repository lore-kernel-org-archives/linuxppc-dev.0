Return-Path: <wg@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.10])
	by ozlabs.org (Postfix) with ESMTP id 22486DDF9A
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Mar 2009 02:24:34 +1100 (EST)
From: Wolfgang Grandegger <wg@grandegger.com>
To: linux-mtd@lists.infradead.org,
	linuxppc-dev@ozlabs.org
Subject: [PATCH v2 2/5] NAND: FSL-UPM: add support for selecting chips via MAR
Date: Thu, 19 Mar 2009 16:16:05 +0100
Message-Id: <1237475768-11481-3-git-send-email-wg@grandegger.com>
In-Reply-To: <1237475768-11481-2-git-send-email-wg@grandegger.com>
References: <1237475768-11481-1-git-send-email-wg@grandegger.com>
	<1237475768-11481-2-git-send-email-wg@grandegger.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

For the NAND chips on the TQM8548 modules, a special chip-select logic is
used. It uses dedicated address lines to be set via UPM machine address
register (mar). This patch also adds that support to the FSL-UPM driver.

Signed-off-by: Wolfgang Grandegger <wg@grandegger.com>
---
 arch/powerpc/sysdev/fsl_lbc.c |    2 +-
 drivers/mtd/nand/fsl_upm.c    |   13 ++++++++++++-
 2 files changed, 13 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/sysdev/fsl_lbc.c b/arch/powerpc/sysdev/fsl_lbc.c
index 0494ee5..dceb8d1 100644
--- a/arch/powerpc/sysdev/fsl_lbc.c
+++ b/arch/powerpc/sysdev/fsl_lbc.c
@@ -150,7 +150,7 @@ int fsl_upm_run_pattern(struct fsl_upm *upm, void __iomem *io_base, u32 mar)
 
 	spin_lock_irqsave(&fsl_lbc_lock, flags);
 
-	out_be32(&fsl_lbc_regs->mar, mar << (32 - upm->width));
+	out_be32(&fsl_lbc_regs->mar, mar);
 
 	switch (upm->width) {
 	case 8:
diff --git a/drivers/mtd/nand/fsl_upm.c b/drivers/mtd/nand/fsl_upm.c
index 4b2c19f..d637da7 100644
--- a/drivers/mtd/nand/fsl_upm.c
+++ b/drivers/mtd/nand/fsl_upm.c
@@ -35,6 +35,7 @@ struct fsl_upm_nand {
 	struct fsl_upm upm;
 	uint8_t upm_addr_offset;
 	uint8_t upm_cmd_offset;
+	uint32_t upm_mar_chip_offset;
 	void __iomem *io_base;
 	int rnb_gpio[NAND_MAX_CHIPS];
 	int chip_delay;
@@ -72,7 +73,9 @@ static void fun_wait_rnb(struct fsl_upm_nand *fun)
 
 static void fun_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 {
+	struct nand_chip *chip = mtd->priv;
 	struct fsl_upm_nand *fun = to_fsl_upm_nand(mtd);
+	u32 mar;
 
 	if (!(ctrl & fun->last_ctrl)) {
 		fsl_upm_end_pattern(&fun->upm);
@@ -90,7 +93,11 @@ static void fun_cmd_ctrl(struct mtd_info *mtd, int cmd, unsigned int ctrl)
 			fsl_upm_start_pattern(&fun->upm, fun->upm_cmd_offset);
 	}
 
-	fsl_upm_run_pattern(&fun->upm, fun->io_base, cmd);
+	mar = cmd << (32 - fun->upm.width);
+	if (fun->upm_mar_chip_offset && fun->chip_number > 0) {
+		mar |= fun->chip_number * fun->upm_mar_chip_offset;
+	}
+	fsl_upm_run_pattern(&fun->upm, chip->IO_ADDR_R, mar);
 
 	fun_wait_rnb(fun);
 }
@@ -242,6 +249,10 @@ static int __devinit fun_probe(struct of_device *ofdev,
 	}
 	fun->upm_cmd_offset = *prop;
 
+	prop = of_get_property(ofdev->node, "fsl,upm-mar-chip-offset", &size);
+	if (prop && size == sizeof(uint32_t))
+		fun->upm_mar_chip_offset = *prop;
+
 	prop = of_get_property(ofdev->node, "num-chips", &size);
 	if (prop && size == sizeof(uint32_t)) {
 		fun->num_chips = *prop;
-- 
1.6.0.6
