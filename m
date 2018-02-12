Return-Path: <boris.brezillon@bootlin.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zgJ756pq1zF0rk
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 08:03:39 +1100 (AEDT)
From: Boris Brezillon <boris.brezillon@bootlin.com>
To: David Woodhouse <dwmw2@infradead.org>,
 Brian Norris <computersforpeace@gmail.com>,
 Boris Brezillon <boris.brezillon@bootlin.com>,
 Marek Vasut <marek.vasut@gmail.com>, Richard Weinberger <richard@nod.at>,
 Cyrille Pitchen <cyrille.pitchen@wedev4u.fr>, linux-mtd@lists.infradead.org
Cc: Joern Engel <joern@lazybastard.org>,
 Robert Jarzmik <robert.jarzmik@free.fr>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Kyungmin Park <kyungmin.park@samsung.com>,
 Artem Bityutskiy <dedekind1@gmail.com>,
 Solarflare linux maintainers <linux-net-drivers@solarflare.com>,
 Edward Cree <ecree@solarflare.com>, Bert Kenward <bkenward@solarflare.com>,
 Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
 linuxppc-dev@lists.ozlabs.org, netdev@vger.kernel.org,
 devel@driverdev.osuosl.org, Miquel Raynal <miquel.raynal@bootlin.com>
Subject: [PATCH 4/5] mtd: Unconditionally update ->fail_addr and ->addr in
 part_erase()
Date: Mon, 12 Feb 2018 22:03:10 +0100
Message-Id: <20180212210311.23244-5-boris.brezillon@bootlin.com>
In-Reply-To: <20180212210311.23244-1-boris.brezillon@bootlin.com>
References: <20180212210311.23244-1-boris.brezillon@bootlin.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

->fail_addr and ->addr can be updated no matter the result of
parent->_erase(), we just need to remove the code doing the same thing
in mtd_erase_callback() to avoid adjusting those fields twice.

Note that this can be done because all MTD users have been converted to
not pass an erase_info->callback() and are thus only taking the
->addr_fail and ->addr fields into account after part_erase() has
returned.

While we're at it, get rid of the erase_info->mtd field which was only
needed to let mtd_erase_callback() get the partition device back.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/ftl.c             |  1 -
 drivers/mtd/inftlmount.c      |  3 ---
 drivers/mtd/mtdblock.c        |  1 -
 drivers/mtd/mtdchar.c         |  1 -
 drivers/mtd/mtdconcat.c       |  1 -
 drivers/mtd/mtdoops.c         |  1 -
 drivers/mtd/mtdpart.c         | 16 ++++------------
 drivers/mtd/mtdswap.c         |  2 --
 drivers/mtd/nand/nand_base.c  |  1 -
 drivers/mtd/nand/nand_bbt.c   |  1 -
 drivers/mtd/nftlmount.c       |  1 -
 drivers/mtd/rfd_ftl.c         |  1 -
 drivers/mtd/sm_ftl.c          |  1 -
 drivers/mtd/tests/mtd_test.c  |  1 -
 drivers/mtd/tests/speedtest.c |  1 -
 drivers/mtd/ubi/io.c          |  1 -
 fs/jffs2/erase.c              |  1 -
 include/linux/mtd/mtd.h       |  3 ++-
 18 files changed, 6 insertions(+), 32 deletions(-)

diff --git a/drivers/mtd/ftl.c b/drivers/mtd/ftl.c
index fcf9907e7987..0a6adfaec7b5 100644
--- a/drivers/mtd/ftl.c
+++ b/drivers/mtd/ftl.c
@@ -342,7 +342,6 @@ static int erase_xfer(partition_t *part,
     if (!erase)
             return -ENOMEM;
 
-    erase->mtd = part->mbd.mtd;
     erase->addr = xfer->Offset;
     erase->len = 1 << part->header.EraseUnitSize;
 
diff --git a/drivers/mtd/inftlmount.c b/drivers/mtd/inftlmount.c
index 0f47be4834d8..aab4f68bd36f 100644
--- a/drivers/mtd/inftlmount.c
+++ b/drivers/mtd/inftlmount.c
@@ -208,8 +208,6 @@ static int find_boot_record(struct INFTLrecord *inftl)
 			if (ip->Reserved0 != ip->firstUnit) {
 				struct erase_info *instr = &inftl->instr;
 
-				instr->mtd = inftl->mbd.mtd;
-
 				/*
 				 * 	Most likely this is using the
 				 * 	undocumented qiuck mount feature.
@@ -385,7 +383,6 @@ int INFTL_formatblock(struct INFTLrecord *inftl, int block)
 	   _first_? */
 
 	/* Use async erase interface, test return code */
-	instr->mtd = inftl->mbd.mtd;
 	instr->addr = block * inftl->EraseSize;
 	instr->len = inftl->mbd.mtd->erasesize;
 	/* Erase one physical eraseblock at a time, even though the NAND api
diff --git a/drivers/mtd/mtdblock.c b/drivers/mtd/mtdblock.c
index 7b2b7f651181..a5b1933c0490 100644
--- a/drivers/mtd/mtdblock.c
+++ b/drivers/mtd/mtdblock.c
@@ -65,7 +65,6 @@ static int erase_write (struct mtd_info *mtd, unsigned long pos,
 	/*
 	 * First, let's erase the flash block.
 	 */
-	erase.mtd = mtd;
 	erase.addr = pos;
 	erase.len = len;
 
diff --git a/drivers/mtd/mtdchar.c b/drivers/mtd/mtdchar.c
index 2beb22dd6bbb..c06b33f80e75 100644
--- a/drivers/mtd/mtdchar.c
+++ b/drivers/mtd/mtdchar.c
@@ -726,7 +726,6 @@ static int mtdchar_ioctl(struct file *file, u_int cmd, u_long arg)
 				erase->addr = einfo32.start;
 				erase->len = einfo32.length;
 			}
-			erase->mtd = mtd;
 
 			ret = mtd_erase(mtd, erase);
 			kfree(erase);
diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index caa09bf6e572..93c47e56d9d8 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -427,7 +427,6 @@ static int concat_erase(struct mtd_info *mtd, struct erase_info *instr)
 			erase->len = length;
 
 		length -= erase->len;
-		erase->mtd = subdev;
 		if ((err = mtd_erase(subdev, erase))) {
 			/* sanity check: should never happen since
 			 * block alignment has been checked above */
diff --git a/drivers/mtd/mtdoops.c b/drivers/mtd/mtdoops.c
index 028ded59297b..9f25111fd559 100644
--- a/drivers/mtd/mtdoops.c
+++ b/drivers/mtd/mtdoops.c
@@ -94,7 +94,6 @@ static int mtdoops_erase_block(struct mtdoops_context *cxt, int offset)
 	int ret;
 	int page;
 
-	erase.mtd = mtd;
 	erase.addr = offset;
 	erase.len = mtd->erasesize;
 
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index ae1206633d9d..1c07a6f0dfe5 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -205,23 +205,15 @@ static int part_erase(struct mtd_info *mtd, struct erase_info *instr)
 
 	instr->addr += part->offset;
 	ret = part->parent->_erase(part->parent, instr);
-	if (ret) {
-		if (instr->fail_addr != MTD_FAIL_ADDR_UNKNOWN)
-			instr->fail_addr -= part->offset;
-		instr->addr -= part->offset;
-	}
+	if (instr->fail_addr != MTD_FAIL_ADDR_UNKNOWN)
+		instr->fail_addr -= part->offset;
+	instr->addr -= part->offset;
+
 	return ret;
 }
 
 void mtd_erase_callback(struct erase_info *instr)
 {
-	if (instr->mtd->_erase == part_erase) {
-		struct mtd_part *part = mtd_to_part(instr->mtd);
-
-		if (instr->fail_addr != MTD_FAIL_ADDR_UNKNOWN)
-			instr->fail_addr -= part->offset;
-		instr->addr -= part->offset;
-	}
 }
 EXPORT_SYMBOL_GPL(mtd_erase_callback);
 
diff --git a/drivers/mtd/mtdswap.c b/drivers/mtd/mtdswap.c
index d390324d102e..7161f8a17f62 100644
--- a/drivers/mtd/mtdswap.c
+++ b/drivers/mtd/mtdswap.c
@@ -549,8 +549,6 @@ static int mtdswap_erase_block(struct mtdswap_dev *d, struct swap_eb *eb)
 
 retry:
 	memset(&erase, 0, sizeof(struct erase_info));
-
-	erase.mtd	= mtd;
 	erase.addr	= mtdswap_eb_offset(d, eb);
 	erase.len	= mtd->erasesize;
 
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index e70ca16a5118..16c8bc06975d 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -527,7 +527,6 @@ static int nand_block_markbad_lowlevel(struct mtd_info *mtd, loff_t ofs)
 
 		/* Attempt erase before marking OOB */
 		memset(&einfo, 0, sizeof(einfo));
-		einfo.mtd = mtd;
 		einfo.addr = ofs;
 		einfo.len = 1ULL << chip->phys_erase_shift;
 		nand_erase_nand(mtd, &einfo, 0);
diff --git a/drivers/mtd/nand/nand_bbt.c b/drivers/mtd/nand/nand_bbt.c
index 36092850be2c..d9f4ceff2568 100644
--- a/drivers/mtd/nand/nand_bbt.c
+++ b/drivers/mtd/nand/nand_bbt.c
@@ -852,7 +852,6 @@ static int write_bbt(struct mtd_info *mtd, uint8_t *buf,
 		}
 
 		memset(&einfo, 0, sizeof(einfo));
-		einfo.mtd = mtd;
 		einfo.addr = to;
 		einfo.len = 1 << this->bbt_erase_shift;
 		res = nand_erase_nand(mtd, &einfo, 1);
diff --git a/drivers/mtd/nftlmount.c b/drivers/mtd/nftlmount.c
index 07e122449759..d8f6dba01c87 100644
--- a/drivers/mtd/nftlmount.c
+++ b/drivers/mtd/nftlmount.c
@@ -328,7 +328,6 @@ int NFTL_formatblock(struct NFTLrecord *nftl, int block)
 	memset(instr, 0, sizeof(struct erase_info));
 
 	/* XXX: use async erase interface, XXX: test return code */
-	instr->mtd = nftl->mbd.mtd;
 	instr->addr = block * nftl->EraseSize;
 	instr->len = nftl->EraseSize;
 	if (mtd_erase(mtd, instr)) {
diff --git a/drivers/mtd/rfd_ftl.c b/drivers/mtd/rfd_ftl.c
index 4e0b55cd08e2..df27f24ce0fa 100644
--- a/drivers/mtd/rfd_ftl.c
+++ b/drivers/mtd/rfd_ftl.c
@@ -275,7 +275,6 @@ static int erase_block(struct partition *part, int block)
 	if (!erase)
 		return -ENOMEM;
 
-	erase->mtd = part->mbd.mtd;
 	erase->addr = part->blocks[block].offset;
 	erase->len = part->block_size;
 
diff --git a/drivers/mtd/sm_ftl.c b/drivers/mtd/sm_ftl.c
index c11156f9d96f..72740ede9f05 100644
--- a/drivers/mtd/sm_ftl.c
+++ b/drivers/mtd/sm_ftl.c
@@ -460,7 +460,6 @@ static int sm_erase_block(struct sm_ftl *ftl, int zone_num, uint16_t block,
 	struct mtd_info *mtd = ftl->trans->mtd;
 	struct erase_info erase;
 
-	erase.mtd = mtd;
 	erase.addr = sm_mkoffset(ftl, zone_num, block, 0);
 	erase.len = ftl->block_size;
 
diff --git a/drivers/mtd/tests/mtd_test.c b/drivers/mtd/tests/mtd_test.c
index 0ac625e8f798..c84250beffdc 100644
--- a/drivers/mtd/tests/mtd_test.c
+++ b/drivers/mtd/tests/mtd_test.c
@@ -14,7 +14,6 @@ int mtdtest_erase_eraseblock(struct mtd_info *mtd, unsigned int ebnum)
 	loff_t addr = (loff_t)ebnum * mtd->erasesize;
 
 	memset(&ei, 0, sizeof(struct erase_info));
-	ei.mtd  = mtd;
 	ei.addr = addr;
 	ei.len  = mtd->erasesize;
 
diff --git a/drivers/mtd/tests/speedtest.c b/drivers/mtd/tests/speedtest.c
index f8e5dc11f943..20edb3b49c77 100644
--- a/drivers/mtd/tests/speedtest.c
+++ b/drivers/mtd/tests/speedtest.c
@@ -59,7 +59,6 @@ static int multiblock_erase(int ebnum, int blocks)
 	loff_t addr = (loff_t)ebnum * mtd->erasesize;
 
 	memset(&ei, 0, sizeof(struct erase_info));
-	ei.mtd  = mtd;
 	ei.addr = addr;
 	ei.len  = mtd->erasesize * blocks;
 
diff --git a/drivers/mtd/ubi/io.c b/drivers/mtd/ubi/io.c
index 8843d26837b2..0e3a76a9e2f8 100644
--- a/drivers/mtd/ubi/io.c
+++ b/drivers/mtd/ubi/io.c
@@ -333,7 +333,6 @@ static int do_sync_erase(struct ubi_device *ubi, int pnum)
 retry:
 	memset(&ei, 0, sizeof(struct erase_info));
 
-	ei.mtd      = ubi->mtd;
 	ei.addr     = (loff_t)pnum * ubi->peb_size;
 	ei.len      = ubi->peb_size;
 
diff --git a/fs/jffs2/erase.c b/fs/jffs2/erase.c
index 09bb6c00b869..83b8f06b4a64 100644
--- a/fs/jffs2/erase.c
+++ b/fs/jffs2/erase.c
@@ -59,7 +59,6 @@ static void jffs2_erase_block(struct jffs2_sb_info *c,
 
 	memset(instr, 0, sizeof(*instr));
 
-	instr->mtd = c->mtd;
 	instr->addr = jeb->offset;
 	instr->len = c->sector_size;
 
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 5018437d7999..4cbb7f555244 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -38,13 +38,14 @@
 
 #define MTD_FAIL_ADDR_UNKNOWN -1LL
 
+struct mtd_info;
+
 /*
  * If the erase fails, fail_addr might indicate exactly which block failed. If
  * fail_addr = MTD_FAIL_ADDR_UNKNOWN, the failure was not at the device level
  * or was not specific to any particular block.
  */
 struct erase_info {
-	struct mtd_info *mtd;
 	uint64_t addr;
 	uint64_t len;
 	uint64_t fail_addr;
-- 
2.14.1
