Return-Path: <scottwood@freescale.com>
Received: from az33egw01.freescale.net (az33egw01.freescale.net
	[192.88.158.102])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "az33egw01.freescale.net",
	Issuer "Thawte Premium Server CA" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id B3E18DE070
	for <linuxppc-dev@ozlabs.org>; Fri, 14 Dec 2007 04:23:55 +1100 (EST)
Date: Thu, 13 Dec 2007 11:15:51 -0600
From: Scott Wood <scottwood@freescale.com>
To: dwmw2@infradead.org
Subject: [PATCH 2/4] nand base: Give drivers a chance to do late
	initialization.
Message-ID: <20071213171551.GA4459@loki.buserror.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20071213171528.GA4440@loki.buserror.net>
Cc: linuxppc-dev@ozlabs.org, linux-mtd@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Some nand controllers, such as the Freescale enhanced local bus controller,
need to do late initialization based on details of the chip that has been
probed, such as chip size, large/small pages, etc.  A late_init() callback
method is added to allow this.

Signed-off-by: Scott Wood <scottwood@freescale.com>
---
 drivers/mtd/nand/nand_base.c |   12 ++++++++++++
 include/linux/mtd/nand.h     |    2 ++
 2 files changed, 14 insertions(+), 0 deletions(-)

diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 85a7283..119a6f7 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -2593,6 +2593,18 @@ int nand_scan_tail(struct mtd_info *mtd)
 	/* propagate ecc.layout to mtd_info */
 	mtd->ecclayout = chip->ecc.layout;
 
+	/* Give the driver a chance to do any remaining setup
+	 * based on the chip details.
+	 */
+	if (chip->late_init) {
+		int ret = chip->late_init(mtd);
+
+		if (ret) {
+			kfree(chip->buffers);
+			return ret;
+		}
+	}
+
 	/* Check, if we should skip the bad block table scan */
 	if (chip->options & NAND_SKIP_BBTSCAN)
 		return 0;
diff --git a/include/linux/mtd/nand.h b/include/linux/mtd/nand.h
index c42bc7f..27bc879 100644
--- a/include/linux/mtd/nand.h
+++ b/include/linux/mtd/nand.h
@@ -360,6 +360,7 @@ struct nand_buffers {
  * @errstat:		[OPTIONAL] hardware specific function to perform additional error status checks
  *			(determine if errors are correctable)
  * @write_page:		[REPLACEABLE] High-level page write function
+ * @late_init:		[OPTIONAL] initialization callback after identification
  */
 
 struct nand_chip {
@@ -384,6 +385,7 @@ struct nand_chip {
 	int		(*errstat)(struct mtd_info *mtd, struct nand_chip *this, int state, int status, int page);
 	int		(*write_page)(struct mtd_info *mtd, struct nand_chip *chip,
 				      const uint8_t *buf, int page, int cached, int raw);
+	int		(*late_init)(struct mtd_info *mtd);
 
 	int		chip_delay;
 	unsigned int	options;
-- 
1.5.3.7
