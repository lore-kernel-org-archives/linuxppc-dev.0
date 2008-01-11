Return-Path: <scottwood@freescale.com>
Received: from az33egw02.freescale.net (az33egw02.freescale.net
	[192.88.158.103])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw02.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 78F34DE0D9
	for <linuxppc-dev@ozlabs.org>; Sat, 12 Jan 2008 07:43:58 +1100 (EST)
Date: Fri, 11 Jan 2008 14:43:04 -0600
From: Scott Wood <scottwood@freescale.com>
To: dwmw2@infradead.org
Subject: [PATCH 1/3] nand base: Don't panic if a controller driver does ecc
	its own way.
Message-ID: <20080111204304.GA11215@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Cc: linuxppc-dev@ozlabs.org, linux-mtd@infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some hardware, such as the enhanced local bus controller used on some
mpc83xx chips, does ecc transparently when reading and writing data, rather
than providing a generic calculate/correct mechanism that can be exported to
the nand subsystem.

The subsystem should not BUG() when calculate, correct, or hwctl are
missing, if the methods that call them have been overridden.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/mtd/nand/nand_base.c |    8 ++++++--
 1 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index e29c1da..85a7283 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -2469,8 +2469,12 @@ int nand_scan_tail(struct mtd_info *mtd)
 			chip->ecc.write_oob = nand_write_oob_std;
 
 	case NAND_ECC_HW_SYNDROME:
-		if (!chip->ecc.calculate || !chip->ecc.correct ||
-		    !chip->ecc.hwctl) {
+		if ((!chip->ecc.calculate || !chip->ecc.correct ||
+		     !chip->ecc.hwctl) &&
+		    (!chip->ecc.read_page ||
+		     chip->ecc.read_page == nand_read_page_hwecc) ||
+		     !chip->ecc.write_page ||
+		     chip->ecc.write_page == nand_write_page_hwecc) {
 			printk(KERN_WARNING "No ECC functions supplied, "
 			       "Hardware ECC not possible\n");
 			BUG();
-- 
1.5.3.8
