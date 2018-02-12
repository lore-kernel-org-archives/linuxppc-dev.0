Return-Path: <boris.brezillon@bootlin.com>
Received: from mail.free-electrons.com (mail.free-electrons.com [62.4.15.54])
 by lists.ozlabs.org (Postfix) with ESMTP id 3zgJ781XvNzF0qB
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Feb 2018 08:03:48 +1100 (AEDT)
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
Subject: [PATCH 5/5] mtd: Stop updating erase_info->state and calling
 mtd_erase_callback()
Date: Mon, 12 Feb 2018 22:03:11 +0100
Message-Id: <20180212210311.23244-6-boris.brezillon@bootlin.com>
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

MTD users are no longer checking erase_info->state to determine if the
erase operation failed or succeeded. Moreover, mtd_erase_callback() is
now a NOP.

We can safely get rid of all mtd_erase_callback() calls and all
erase_info->state assignments. While at it, get rid of the
erase_info->state field, all MTD_ERASE_XXX definitions and the
mtd_erase_callback() function.

Signed-off-by: Boris Brezillon <boris.brezillon@bootlin.com>
---
 drivers/mtd/chips/cfi_cmdset_0001.c      | 16 ++--------------
 drivers/mtd/chips/cfi_cmdset_0002.c      | 26 +++-----------------------
 drivers/mtd/chips/cfi_cmdset_0020.c      |  3 ---
 drivers/mtd/chips/map_ram.c              |  2 --
 drivers/mtd/devices/bcm47xxsflash.c      |  9 +--------
 drivers/mtd/devices/block2mtd.c          |  7 +------
 drivers/mtd/devices/docg3.c              | 16 ++--------------
 drivers/mtd/devices/lart.c               |  4 ----
 drivers/mtd/devices/mtd_dataflash.c      |  4 ----
 drivers/mtd/devices/mtdram.c             |  2 --
 drivers/mtd/devices/phram.c              |  2 --
 drivers/mtd/devices/pmc551.c             |  2 --
 drivers/mtd/devices/powernv_flash.c      | 11 ++---------
 drivers/mtd/devices/slram.c              |  2 --
 drivers/mtd/devices/spear_smi.c          |  3 ---
 drivers/mtd/devices/sst25l.c             |  3 ---
 drivers/mtd/devices/st_spi_fsm.c         |  4 ----
 drivers/mtd/lpddr/lpddr2_nvm.c           | 10 ++--------
 drivers/mtd/lpddr/lpddr_cmds.c           |  2 --
 drivers/mtd/mtdconcat.c                  |  1 -
 drivers/mtd/mtdcore.c                    |  6 ++----
 drivers/mtd/mtdpart.c                    |  5 -----
 drivers/mtd/nand/nand_base.c             | 15 +++------------
 drivers/mtd/onenand/onenand_base.c       | 17 -----------------
 drivers/mtd/spi-nor/spi-nor.c            |  3 ---
 drivers/mtd/ubi/gluebi.c                 |  3 ---
 drivers/net/ethernet/sfc/falcon/mtd.c    | 11 +----------
 drivers/net/ethernet/sfc/mtd.c           | 11 +----------
 drivers/staging/goldfish/goldfish_nand.c |  3 ---
 include/linux/mtd/mtd.h                  |  9 ---------
 30 files changed, 20 insertions(+), 192 deletions(-)

diff --git a/drivers/mtd/chips/cfi_cmdset_0001.c b/drivers/mtd/chips/cfi_cmdset_0001.c
index 5e1b68cbcd0a..d4c07b85f18e 100644
--- a/drivers/mtd/chips/cfi_cmdset_0001.c
+++ b/drivers/mtd/chips/cfi_cmdset_0001.c
@@ -1993,20 +1993,8 @@ static int __xipram do_erase_oneblock(struct map_info *map, struct flchip *chip,
 
 static int cfi_intelext_erase_varsize(struct mtd_info *mtd, struct erase_info *instr)
 {
-	unsigned long ofs, len;
-	int ret;
-
-	ofs = instr->addr;
-	len = instr->len;
-
-	ret = cfi_varsize_frob(mtd, do_erase_oneblock, ofs, len, NULL);
-	if (ret)
-		return ret;
-
-	instr->state = MTD_ERASE_DONE;
-	mtd_erase_callback(instr);
-
-	return 0;
+	return cfi_varsize_frob(mtd, do_erase_oneblock, instr->addr,
+				instr->len, NULL);
 }
 
 static void cfi_intelext_sync (struct mtd_info *mtd)
diff --git a/drivers/mtd/chips/cfi_cmdset_0002.c b/drivers/mtd/chips/cfi_cmdset_0002.c
index 56aa6b75213d..668e2cbc155b 100644
--- a/drivers/mtd/chips/cfi_cmdset_0002.c
+++ b/drivers/mtd/chips/cfi_cmdset_0002.c
@@ -2415,20 +2415,8 @@ static int __xipram do_erase_oneblock(struct map_info *map, struct flchip *chip,
 
 static int cfi_amdstd_erase_varsize(struct mtd_info *mtd, struct erase_info *instr)
 {
-	unsigned long ofs, len;
-	int ret;
-
-	ofs = instr->addr;
-	len = instr->len;
-
-	ret = cfi_varsize_frob(mtd, do_erase_oneblock, ofs, len, NULL);
-	if (ret)
-		return ret;
-
-	instr->state = MTD_ERASE_DONE;
-	mtd_erase_callback(instr);
-
-	return 0;
+	return cfi_varsize_frob(mtd, do_erase_oneblock, instr->addr,
+				instr->len, NULL);
 }
 
 
@@ -2436,7 +2424,6 @@ static int cfi_amdstd_erase_chip(struct mtd_info *mtd, struct erase_info *instr)
 {
 	struct map_info *map = mtd->priv;
 	struct cfi_private *cfi = map->fldrv_priv;
-	int ret = 0;
 
 	if (instr->addr != 0)
 		return -EINVAL;
@@ -2444,14 +2431,7 @@ static int cfi_amdstd_erase_chip(struct mtd_info *mtd, struct erase_info *instr)
 	if (instr->len != mtd->size)
 		return -EINVAL;
 
-	ret = do_erase_chip(map, &cfi->chips[0]);
-	if (ret)
-		return ret;
-
-	instr->state = MTD_ERASE_DONE;
-	mtd_erase_callback(instr);
-
-	return 0;
+	return do_erase_chip(map, &cfi->chips[0]);
 }
 
 static int do_atmel_lock(struct map_info *map, struct flchip *chip,
diff --git a/drivers/mtd/chips/cfi_cmdset_0020.c b/drivers/mtd/chips/cfi_cmdset_0020.c
index 7d342965f392..7b7658a05036 100644
--- a/drivers/mtd/chips/cfi_cmdset_0020.c
+++ b/drivers/mtd/chips/cfi_cmdset_0020.c
@@ -965,9 +965,6 @@ static int cfi_staa_erase_varsize(struct mtd_info *mtd,
 		}
 	}
 
-	instr->state = MTD_ERASE_DONE;
-	mtd_erase_callback(instr);
-
 	return 0;
 }
 
diff --git a/drivers/mtd/chips/map_ram.c b/drivers/mtd/chips/map_ram.c
index 1cd0fff0e940..c37fce926864 100644
--- a/drivers/mtd/chips/map_ram.c
+++ b/drivers/mtd/chips/map_ram.c
@@ -131,8 +131,6 @@ static int mapram_erase (struct mtd_info *mtd, struct erase_info *instr)
 	allff = map_word_ff(map);
 	for (i=0; i<instr->len; i += map_bankwidth(map))
 		map_write(map, allff, instr->addr + i);
-	instr->state = MTD_ERASE_DONE;
-	mtd_erase_callback(instr);
 	return 0;
 }
 
diff --git a/drivers/mtd/devices/bcm47xxsflash.c b/drivers/mtd/devices/bcm47xxsflash.c
index 6b84947cfbea..9baa81b8780c 100644
--- a/drivers/mtd/devices/bcm47xxsflash.c
+++ b/drivers/mtd/devices/bcm47xxsflash.c
@@ -68,7 +68,6 @@ static int bcm47xxsflash_poll(struct bcm47xxsflash *b47s, int timeout)
 static int bcm47xxsflash_erase(struct mtd_info *mtd, struct erase_info *erase)
 {
 	struct bcm47xxsflash *b47s = mtd->priv;
-	int err;
 
 	switch (b47s->type) {
 	case BCM47XXSFLASH_TYPE_ST:
@@ -89,13 +88,7 @@ static int bcm47xxsflash_erase(struct mtd_info *mtd, struct erase_info *erase)
 		break;
 	}
 
-	err = bcm47xxsflash_poll(b47s, HZ);
-	if (err)
-		erase->state = MTD_ERASE_FAILED;
-	else
-		erase->state = MTD_ERASE_DONE;
-
-	return err;
+	return bcm47xxsflash_poll(b47s, HZ);
 }
 
 static int bcm47xxsflash_read(struct mtd_info *mtd, loff_t from, size_t len,
diff --git a/drivers/mtd/devices/block2mtd.c b/drivers/mtd/devices/block2mtd.c
index 62fd6905c648..0e741017f189 100644
--- a/drivers/mtd/devices/block2mtd.c
+++ b/drivers/mtd/devices/block2mtd.c
@@ -88,17 +88,12 @@ static int block2mtd_erase(struct mtd_info *mtd, struct erase_info *instr)
 	size_t len = instr->len;
 	int err;
 
-	instr->state = MTD_ERASING;
 	mutex_lock(&dev->write_mutex);
 	err = _block2mtd_erase(dev, from, len);
 	mutex_unlock(&dev->write_mutex);
-	if (err) {
+	if (err)
 		pr_err("erase failed err = %d\n", err);
-		instr->state = MTD_ERASE_FAILED;
-	} else
-		instr->state = MTD_ERASE_DONE;
 
-	mtd_erase_callback(instr);
 	return err;
 }
 
diff --git a/drivers/mtd/devices/docg3.c b/drivers/mtd/devices/docg3.c
index a85af236b44d..c594fe5eac08 100644
--- a/drivers/mtd/devices/docg3.c
+++ b/drivers/mtd/devices/docg3.c
@@ -1191,39 +1191,27 @@ static int doc_erase(struct mtd_info *mtd, struct erase_info *info)
 {
 	struct docg3 *docg3 = mtd->priv;
 	uint64_t len;
-	int block0, block1, page, ret, ofs = 0;
+	int block0, block1, page, ret = 0, ofs = 0;
 
 	doc_dbg("doc_erase(from=%lld, len=%lld\n", info->addr, info->len);
 
-	info->state = MTD_ERASE_PENDING;
 	calc_block_sector(info->addr + info->len, &block0, &block1, &page,
 			  &ofs, docg3->reliable);
-	ret = -EINVAL;
 	if (info->addr + info->len > mtd->size || page || ofs)
-		goto reset_err;
+		return -EINVAL;
 
-	ret = 0;
 	calc_block_sector(info->addr, &block0, &block1, &page, &ofs,
 			  docg3->reliable);
 	mutex_lock(&docg3->cascade->lock);
 	doc_set_device_id(docg3, docg3->device_id);
 	doc_set_reliable_mode(docg3);
 	for (len = info->len; !ret && len > 0; len -= mtd->erasesize) {
-		info->state = MTD_ERASING;
 		ret = doc_erase_block(docg3, block0, block1);
 		block0 += 2;
 		block1 += 2;
 	}
 	mutex_unlock(&docg3->cascade->lock);
 
-	if (ret)
-		goto reset_err;
-
-	info->state = MTD_ERASE_DONE;
-	return 0;
-
-reset_err:
-	info->state = MTD_ERASE_FAILED;
 	return ret;
 }
 
diff --git a/drivers/mtd/devices/lart.c b/drivers/mtd/devices/lart.c
index 555b94406e0b..3d6c8ffd351f 100644
--- a/drivers/mtd/devices/lart.c
+++ b/drivers/mtd/devices/lart.c
@@ -415,7 +415,6 @@ static int flash_erase (struct mtd_info *mtd,struct erase_info *instr)
 	 {
 		if (!erase_block (addr))
 		  {
-			 instr->state = MTD_ERASE_FAILED;
 			 return (-EIO);
 		  }
 
@@ -425,9 +424,6 @@ static int flash_erase (struct mtd_info *mtd,struct erase_info *instr)
 		if (addr == mtd->eraseregions[i].offset + (mtd->eraseregions[i].erasesize * mtd->eraseregions[i].numblocks)) i++;
 	 }
 
-   instr->state = MTD_ERASE_DONE;
-   mtd_erase_callback(instr);
-
    return (0);
 }
 
diff --git a/drivers/mtd/devices/mtd_dataflash.c b/drivers/mtd/devices/mtd_dataflash.c
index 5dc8bd042cc5..aaaeaae01e1d 100644
--- a/drivers/mtd/devices/mtd_dataflash.c
+++ b/drivers/mtd/devices/mtd_dataflash.c
@@ -220,10 +220,6 @@ static int dataflash_erase(struct mtd_info *mtd, struct erase_info *instr)
 	}
 	mutex_unlock(&priv->lock);
 
-	/* Inform MTD subsystem that erase is complete */
-	instr->state = MTD_ERASE_DONE;
-	mtd_erase_callback(instr);
-
 	return 0;
 }
 
diff --git a/drivers/mtd/devices/mtdram.c b/drivers/mtd/devices/mtdram.c
index 0bf4aeaf0cb8..efef43c6684b 100644
--- a/drivers/mtd/devices/mtdram.c
+++ b/drivers/mtd/devices/mtdram.c
@@ -60,8 +60,6 @@ static int ram_erase(struct mtd_info *mtd, struct erase_info *instr)
 	if (check_offs_len(mtd, instr->addr, instr->len))
 		return -EINVAL;
 	memset((char *)mtd->priv + instr->addr, 0xff, instr->len);
-	instr->state = MTD_ERASE_DONE;
-	mtd_erase_callback(instr);
 	return 0;
 }
 
diff --git a/drivers/mtd/devices/phram.c b/drivers/mtd/devices/phram.c
index 7287696a21f9..a963c88d392d 100644
--- a/drivers/mtd/devices/phram.c
+++ b/drivers/mtd/devices/phram.c
@@ -44,8 +44,6 @@ static int phram_erase(struct mtd_info *mtd, struct erase_info *instr)
 	 * I don't feel at all ashamed. This kind of thing is possible anyway
 	 * with flash, but unlikely.
 	 */
-	instr->state = MTD_ERASE_DONE;
-	mtd_erase_callback(instr);
 	return 0;
 }
 
diff --git a/drivers/mtd/devices/pmc551.c b/drivers/mtd/devices/pmc551.c
index cadea0620cd0..5d842cbca3de 100644
--- a/drivers/mtd/devices/pmc551.c
+++ b/drivers/mtd/devices/pmc551.c
@@ -184,12 +184,10 @@ static int pmc551_erase(struct mtd_info *mtd, struct erase_info *instr)
 	}
 
       out:
-	instr->state = MTD_ERASE_DONE;
 #ifdef CONFIG_MTD_PMC551_DEBUG
 	printk(KERN_DEBUG "pmc551_erase() done\n");
 #endif
 
-	mtd_erase_callback(instr);
 	return 0;
 }
 
diff --git a/drivers/mtd/devices/powernv_flash.c b/drivers/mtd/devices/powernv_flash.c
index 26f9feaa5d17..5f383630c16f 100644
--- a/drivers/mtd/devices/powernv_flash.c
+++ b/drivers/mtd/devices/powernv_flash.c
@@ -175,19 +175,12 @@ static int powernv_flash_erase(struct mtd_info *mtd, struct erase_info *erase)
 {
 	int rc;
 
-	erase->state = MTD_ERASING;
-
 	/* todo: register our own notifier to do a true async implementation */
 	rc =  powernv_flash_async_op(mtd, FLASH_OP_ERASE, erase->addr,
 			erase->len, NULL, NULL);
-
-	if (rc) {
+	if (rc)
 		erase->fail_addr = erase->addr;
-		erase->state = MTD_ERASE_FAILED;
-	} else {
-		erase->state = MTD_ERASE_DONE;
-	}
-	mtd_erase_callback(erase);
+
 	return rc;
 }
 
diff --git a/drivers/mtd/devices/slram.c b/drivers/mtd/devices/slram.c
index 0ec85f316d24..2f05e1801047 100644
--- a/drivers/mtd/devices/slram.c
+++ b/drivers/mtd/devices/slram.c
@@ -88,8 +88,6 @@ static int slram_erase(struct mtd_info *mtd, struct erase_info *instr)
 	 * I don't feel at all ashamed. This kind of thing is possible anyway
 	 * with flash, but unlikely.
 	 */
-	instr->state = MTD_ERASE_DONE;
-	mtd_erase_callback(instr);
 	return(0);
 }
 
diff --git a/drivers/mtd/devices/spear_smi.c b/drivers/mtd/devices/spear_smi.c
index ddf478976013..986f81d2f93e 100644
--- a/drivers/mtd/devices/spear_smi.c
+++ b/drivers/mtd/devices/spear_smi.c
@@ -518,7 +518,6 @@ static int spear_mtd_erase(struct mtd_info *mtd, struct erase_info *e_info)
 		/* preparing the command for flash */
 		ret = spear_smi_erase_sector(dev, bank, command, 4);
 		if (ret) {
-			e_info->state = MTD_ERASE_FAILED;
 			mutex_unlock(&flash->lock);
 			return ret;
 		}
@@ -527,8 +526,6 @@ static int spear_mtd_erase(struct mtd_info *mtd, struct erase_info *e_info)
 	}
 
 	mutex_unlock(&flash->lock);
-	e_info->state = MTD_ERASE_DONE;
-	mtd_erase_callback(e_info);
 
 	return 0;
 }
diff --git a/drivers/mtd/devices/sst25l.c b/drivers/mtd/devices/sst25l.c
index 5b84d71efb36..1897f33fe3e7 100644
--- a/drivers/mtd/devices/sst25l.c
+++ b/drivers/mtd/devices/sst25l.c
@@ -195,7 +195,6 @@ static int sst25l_erase(struct mtd_info *mtd, struct erase_info *instr)
 		err = sst25l_erase_sector(flash, addr);
 		if (err) {
 			mutex_unlock(&flash->lock);
-			instr->state = MTD_ERASE_FAILED;
 			dev_err(&flash->spi->dev, "Erase failed\n");
 			return err;
 		}
@@ -205,8 +204,6 @@ static int sst25l_erase(struct mtd_info *mtd, struct erase_info *instr)
 
 	mutex_unlock(&flash->lock);
 
-	instr->state = MTD_ERASE_DONE;
-	mtd_erase_callback(instr);
 	return 0;
 }
 
diff --git a/drivers/mtd/devices/st_spi_fsm.c b/drivers/mtd/devices/st_spi_fsm.c
index 7bc29d725200..b0a8ad3c2c7b 100644
--- a/drivers/mtd/devices/st_spi_fsm.c
+++ b/drivers/mtd/devices/st_spi_fsm.c
@@ -1825,13 +1825,9 @@ static int stfsm_mtd_erase(struct mtd_info *mtd, struct erase_info *instr)
 
 	mutex_unlock(&fsm->lock);
 
-	instr->state = MTD_ERASE_DONE;
-	mtd_erase_callback(instr);
-
 	return 0;
 
 out1:
-	instr->state = MTD_ERASE_FAILED;
 	mutex_unlock(&fsm->lock);
 
 	return ret;
diff --git a/drivers/mtd/lpddr/lpddr2_nvm.c b/drivers/mtd/lpddr/lpddr2_nvm.c
index 2342277c9bcb..5d73db2a496d 100644
--- a/drivers/mtd/lpddr/lpddr2_nvm.c
+++ b/drivers/mtd/lpddr/lpddr2_nvm.c
@@ -380,14 +380,8 @@ static int lpddr2_nvm_write(struct mtd_info *mtd, loff_t start_add,
  */
 static int lpddr2_nvm_erase(struct mtd_info *mtd, struct erase_info *instr)
 {
-	int ret = lpddr2_nvm_do_block_op(mtd, instr->addr, instr->len,
-		LPDDR2_NVM_ERASE);
-	if (!ret) {
-		instr->state = MTD_ERASE_DONE;
-		mtd_erase_callback(instr);
-	}
-
-	return ret;
+	return lpddr2_nvm_do_block_op(mtd, instr->addr, instr->len,
+				      LPDDR2_NVM_ERASE);
 }
 
 /*
diff --git a/drivers/mtd/lpddr/lpddr_cmds.c b/drivers/mtd/lpddr/lpddr_cmds.c
index 018c75faadb3..5c5ba3c7c79d 100644
--- a/drivers/mtd/lpddr/lpddr_cmds.c
+++ b/drivers/mtd/lpddr/lpddr_cmds.c
@@ -693,8 +693,6 @@ static int lpddr_erase(struct mtd_info *mtd, struct erase_info *instr)
 		ofs += size;
 		len -= size;
 	}
-	instr->state = MTD_ERASE_DONE;
-	mtd_erase_callback(instr);
 
 	return 0;
 }
diff --git a/drivers/mtd/mtdconcat.c b/drivers/mtd/mtdconcat.c
index 93c47e56d9d8..6b86d1a73cf2 100644
--- a/drivers/mtd/mtdconcat.c
+++ b/drivers/mtd/mtdconcat.c
@@ -446,7 +446,6 @@ static int concat_erase(struct mtd_info *mtd, struct erase_info *instr)
 		erase->addr = 0;
 		offset += subdev->size;
 	}
-	instr->state = erase->state;
 	kfree(erase);
 
 	return err;
diff --git a/drivers/mtd/mtdcore.c b/drivers/mtd/mtdcore.c
index f92ad02959eb..f25d65ea7149 100644
--- a/drivers/mtd/mtdcore.c
+++ b/drivers/mtd/mtdcore.c
@@ -961,11 +961,9 @@ int mtd_erase(struct mtd_info *mtd, struct erase_info *instr)
 	if (!(mtd->flags & MTD_WRITEABLE))
 		return -EROFS;
 
-	if (!instr->len) {
-		instr->state = MTD_ERASE_DONE;
-		mtd_erase_callback(instr);
+	if (!instr->len)
 		return 0;
-	}
+
 	ledtrig_mtd_activity();
 	return mtd->_erase(mtd, instr);
 }
diff --git a/drivers/mtd/mtdpart.c b/drivers/mtd/mtdpart.c
index 1c07a6f0dfe5..85fea8ea3423 100644
--- a/drivers/mtd/mtdpart.c
+++ b/drivers/mtd/mtdpart.c
@@ -212,11 +212,6 @@ static int part_erase(struct mtd_info *mtd, struct erase_info *instr)
 	return ret;
 }
 
-void mtd_erase_callback(struct erase_info *instr)
-{
-}
-EXPORT_SYMBOL_GPL(mtd_erase_callback);
-
 static int part_lock(struct mtd_info *mtd, loff_t ofs, uint64_t len)
 {
 	struct mtd_part *part = mtd_to_part(mtd);
diff --git a/drivers/mtd/nand/nand_base.c b/drivers/mtd/nand/nand_base.c
index 16c8bc06975d..13dd67106859 100644
--- a/drivers/mtd/nand/nand_base.c
+++ b/drivers/mtd/nand/nand_base.c
@@ -4604,22 +4604,20 @@ int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
 	if (nand_check_wp(mtd)) {
 		pr_debug("%s: device is write protected!\n",
 				__func__);
-		instr->state = MTD_ERASE_FAILED;
+		ret = -EIO;
 		goto erase_exit;
 	}
 
 	/* Loop through the pages */
 	len = instr->len;
 
-	instr->state = MTD_ERASING;
-
 	while (len) {
 		/* Check if we have a bad block, we do not erase bad blocks! */
 		if (nand_block_checkbad(mtd, ((loff_t) page) <<
 					chip->page_shift, allowbbt)) {
 			pr_warn("%s: attempt to erase a bad block at page 0x%08x\n",
 				    __func__, page);
-			instr->state = MTD_ERASE_FAILED;
+			ret = -EIO;
 			goto erase_exit;
 		}
 
@@ -4637,7 +4635,7 @@ int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
 		if (status) {
 			pr_debug("%s: failed erase, page 0x%08x\n",
 					__func__, page);
-			instr->state = MTD_ERASE_FAILED;
+			ret = -EIO;
 			instr->fail_addr =
 				((loff_t)page << chip->page_shift);
 			goto erase_exit;
@@ -4654,20 +4652,13 @@ int nand_erase_nand(struct mtd_info *mtd, struct erase_info *instr,
 			chip->select_chip(mtd, chipnr);
 		}
 	}
-	instr->state = MTD_ERASE_DONE;
 
 erase_exit:
 
-	ret = instr->state == MTD_ERASE_DONE ? 0 : -EIO;
-
 	/* Deselect and wake up anyone waiting on the device */
 	chip->select_chip(mtd, -1);
 	nand_release_device(mtd);
 
-	/* Do call back function */
-	if (!ret)
-		mtd_erase_callback(instr);
-
 	/* Return more or less happy */
 	return ret;
 }
diff --git a/drivers/mtd/onenand/onenand_base.c b/drivers/mtd/onenand/onenand_base.c
index 979f4031f23c..8d19b78777b5 100644
--- a/drivers/mtd/onenand/onenand_base.c
+++ b/drivers/mtd/onenand/onenand_base.c
@@ -2143,7 +2143,6 @@ static int onenand_multiblock_erase_verify(struct mtd_info *mtd,
 		if (ret) {
 			printk(KERN_ERR "%s: Failed verify, block %d\n",
 			       __func__, onenand_block(this, addr));
-			instr->state = MTD_ERASE_FAILED;
 			instr->fail_addr = addr;
 			return -1;
 		}
@@ -2172,8 +2171,6 @@ static int onenand_multiblock_erase(struct mtd_info *mtd,
 	int ret = 0;
 	int bdry_block = 0;
 
-	instr->state = MTD_ERASING;
-
 	if (ONENAND_IS_DDP(this)) {
 		loff_t bdry_addr = this->chipsize >> 1;
 		if (addr < bdry_addr && (addr + len) > bdry_addr)
@@ -2187,7 +2184,6 @@ static int onenand_multiblock_erase(struct mtd_info *mtd,
 			printk(KERN_WARNING "%s: attempt to erase a bad block "
 			       "at addr 0x%012llx\n",
 			       __func__, (unsigned long long) addr);
-			instr->state = MTD_ERASE_FAILED;
 			return -EIO;
 		}
 		len -= block_size;
@@ -2227,7 +2223,6 @@ static int onenand_multiblock_erase(struct mtd_info *mtd,
 				printk(KERN_ERR "%s: Failed multiblock erase, "
 				       "block %d\n", __func__,
 				       onenand_block(this, addr));
-				instr->state = MTD_ERASE_FAILED;
 				instr->fail_addr = MTD_FAIL_ADDR_UNKNOWN;
 				return -EIO;
 			}
@@ -2247,7 +2242,6 @@ static int onenand_multiblock_erase(struct mtd_info *mtd,
 		if (ret) {
 			printk(KERN_ERR "%s: Failed erase, block %d\n",
 			       __func__, onenand_block(this, addr));
-			instr->state = MTD_ERASE_FAILED;
 			instr->fail_addr = MTD_FAIL_ADDR_UNKNOWN;
 			return -EIO;
 		}
@@ -2259,7 +2253,6 @@ static int onenand_multiblock_erase(struct mtd_info *mtd,
 		/* verify */
 		verify_instr.len = eb_count * block_size;
 		if (onenand_multiblock_erase_verify(mtd, &verify_instr)) {
-			instr->state = verify_instr.state;
 			instr->fail_addr = verify_instr.fail_addr;
 			return -EIO;
 		}
@@ -2294,8 +2287,6 @@ static int onenand_block_by_block_erase(struct mtd_info *mtd,
 		region_end = region->offset + region->erasesize * region->numblocks;
 	}
 
-	instr->state = MTD_ERASING;
-
 	/* Loop through the blocks */
 	while (len) {
 		cond_resched();
@@ -2305,7 +2296,6 @@ static int onenand_block_by_block_erase(struct mtd_info *mtd,
 			printk(KERN_WARNING "%s: attempt to erase a bad block "
 					"at addr 0x%012llx\n",
 					__func__, (unsigned long long) addr);
-			instr->state = MTD_ERASE_FAILED;
 			return -EIO;
 		}
 
@@ -2318,7 +2308,6 @@ static int onenand_block_by_block_erase(struct mtd_info *mtd,
 		if (ret) {
 			printk(KERN_ERR "%s: Failed erase, block %d\n",
 				__func__, onenand_block(this, addr));
-			instr->state = MTD_ERASE_FAILED;
 			instr->fail_addr = addr;
 			return -EIO;
 		}
@@ -2407,12 +2396,6 @@ static int onenand_erase(struct mtd_info *mtd, struct erase_info *instr)
 	/* Deselect and wake up anyone waiting on the device */
 	onenand_release_device(mtd);
 
-	/* Do call back function */
-	if (!ret) {
-		instr->state = MTD_ERASE_DONE;
-		mtd_erase_callback(instr);
-	}
-
 	return ret;
 }
 
diff --git a/drivers/mtd/spi-nor/spi-nor.c b/drivers/mtd/spi-nor/spi-nor.c
index d445a4d3b770..5bfa36e95f35 100644
--- a/drivers/mtd/spi-nor/spi-nor.c
+++ b/drivers/mtd/spi-nor/spi-nor.c
@@ -560,9 +560,6 @@ static int spi_nor_erase(struct mtd_info *mtd, struct erase_info *instr)
 erase_err:
 	spi_nor_unlock_and_unprep(nor, SPI_NOR_OPS_ERASE);
 
-	instr->state = ret ? MTD_ERASE_FAILED : MTD_ERASE_DONE;
-	mtd_erase_callback(instr);
-
 	return ret;
 }
 
diff --git a/drivers/mtd/ubi/gluebi.c b/drivers/mtd/ubi/gluebi.c
index 1cb287ec32ad..6b655a53113b 100644
--- a/drivers/mtd/ubi/gluebi.c
+++ b/drivers/mtd/ubi/gluebi.c
@@ -272,12 +272,9 @@ static int gluebi_erase(struct mtd_info *mtd, struct erase_info *instr)
 	if (err)
 		goto out_err;
 
-	instr->state = MTD_ERASE_DONE;
-	mtd_erase_callback(instr);
 	return 0;
 
 out_err:
-	instr->state = MTD_ERASE_FAILED;
 	instr->fail_addr = (long long)lnum * mtd->erasesize;
 	return err;
 }
diff --git a/drivers/net/ethernet/sfc/falcon/mtd.c b/drivers/net/ethernet/sfc/falcon/mtd.c
index cde593cb1052..2d67e4621a3d 100644
--- a/drivers/net/ethernet/sfc/falcon/mtd.c
+++ b/drivers/net/ethernet/sfc/falcon/mtd.c
@@ -24,17 +24,8 @@
 static int ef4_mtd_erase(struct mtd_info *mtd, struct erase_info *erase)
 {
 	struct ef4_nic *efx = mtd->priv;
-	int rc;
 
-	rc = efx->type->mtd_erase(mtd, erase->addr, erase->len);
-	if (rc == 0) {
-		erase->state = MTD_ERASE_DONE;
-	} else {
-		erase->state = MTD_ERASE_FAILED;
-		erase->fail_addr = MTD_FAIL_ADDR_UNKNOWN;
-	}
-	mtd_erase_callback(erase);
-	return rc;
+	return efx->type->mtd_erase(mtd, erase->addr, erase->len);
 }
 
 static void ef4_mtd_sync(struct mtd_info *mtd)
diff --git a/drivers/net/ethernet/sfc/mtd.c b/drivers/net/ethernet/sfc/mtd.c
index a77a8bd2dd70..4ac30b6e5dab 100644
--- a/drivers/net/ethernet/sfc/mtd.c
+++ b/drivers/net/ethernet/sfc/mtd.c
@@ -24,17 +24,8 @@
 static int efx_mtd_erase(struct mtd_info *mtd, struct erase_info *erase)
 {
 	struct efx_nic *efx = mtd->priv;
-	int rc;
 
-	rc = efx->type->mtd_erase(mtd, erase->addr, erase->len);
-	if (rc == 0) {
-		erase->state = MTD_ERASE_DONE;
-	} else {
-		erase->state = MTD_ERASE_FAILED;
-		erase->fail_addr = MTD_FAIL_ADDR_UNKNOWN;
-	}
-	mtd_erase_callback(erase);
-	return rc;
+	return efx->type->mtd_erase(mtd, erase->addr, erase->len);
 }
 
 static void efx_mtd_sync(struct mtd_info *mtd)
diff --git a/drivers/staging/goldfish/goldfish_nand.c b/drivers/staging/goldfish/goldfish_nand.c
index 52cc1363993e..f5e002ecba75 100644
--- a/drivers/staging/goldfish/goldfish_nand.c
+++ b/drivers/staging/goldfish/goldfish_nand.c
@@ -119,9 +119,6 @@ static int goldfish_nand_erase(struct mtd_info *mtd, struct erase_info *instr)
 		return -EIO;
 	}
 
-	instr->state = MTD_ERASE_DONE;
-	mtd_erase_callback(instr);
-
 	return 0;
 
 invalid_arg:
diff --git a/include/linux/mtd/mtd.h b/include/linux/mtd/mtd.h
index 4cbb7f555244..a86c4fa93115 100644
--- a/include/linux/mtd/mtd.h
+++ b/include/linux/mtd/mtd.h
@@ -30,12 +30,6 @@
 
 #include <asm/div64.h>
 
-#define MTD_ERASE_PENDING	0x01
-#define MTD_ERASING		0x02
-#define MTD_ERASE_SUSPEND	0x04
-#define MTD_ERASE_DONE		0x08
-#define MTD_ERASE_FAILED	0x10
-
 #define MTD_FAIL_ADDR_UNKNOWN -1LL
 
 struct mtd_info;
@@ -49,7 +43,6 @@ struct erase_info {
 	uint64_t addr;
 	uint64_t len;
 	uint64_t fail_addr;
-	u_char state;
 };
 
 struct mtd_erase_region_info {
@@ -589,8 +582,6 @@ extern void register_mtd_user (struct mtd_notifier *new);
 extern int unregister_mtd_user (struct mtd_notifier *old);
 void *mtd_kmalloc_up_to(const struct mtd_info *mtd, size_t *size);
 
-void mtd_erase_callback(struct erase_info *instr);
-
 static inline int mtd_is_bitflip(int err) {
 	return err == -EUCLEAN;
 }
-- 
2.14.1
