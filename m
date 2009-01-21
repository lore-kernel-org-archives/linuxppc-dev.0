Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id 61683DDE0F
	for <linuxppc-dev@ozlabs.org>; Thu, 22 Jan 2009 10:16:31 +1100 (EST)
Date: Thu, 22 Jan 2009 10:16:28 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Scott Wood <scottwood@freescale.com>
Subject: [PATCH v2] powerpc: more printing warning fixes for the l64 to ll64
	conversion
Message-Id: <20090122101628.d4f1d8b3.sfr@canb.auug.org.au>
In-Reply-To: <20090122091705.2010ed70.sfr@canb.auug.org.au>
References: <20090121111651.7d6e87ec.sfr@canb.auug.org.au>
	<20090121181324.GA32224@ld0162-tx32.am.freescale.net>
	<20090122091705.2010ed70.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Nick Spence <nick.spence@freescale.com>, linuxppc-dev@ozlabs.org,
	Egor Martovetsky <egor@pasemi.com>, Paul Mackerras <paulus@samba.org>,
	Doug Thompson <dougthompson@xmission.com>,
	Olof Johansson <olof@lixom.net>, linux-mtd@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These are all powerpc specific drivers.

res.start in fsl_elbc_nand.c needs to be cast since it may be either 32
or 64 bit.  Thanks to Scott Wood for noticing.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
Acked-by: Arnd Bergmann <arnd@arndb.de> call_edac bits in particular
Acked-by: Olof Johansson <olof@lixom.net> pasemi_nand peices
Acked-by: Scott Wood <scottwood@freescale.com> fsl_elbc fixes
---
 drivers/edac/cell_edac.c         |    8 ++++----
 drivers/mtd/nand/fsl_elbc_nand.c |    8 ++++----
 drivers/mtd/nand/pasemi_nand.c   |    4 ++--
 3 files changed, 10 insertions(+), 10 deletions(-)

The only change here is the cast noted above.  I removed bluesmoke-devel
because they reject my postings.

diff --git a/drivers/edac/cell_edac.c b/drivers/edac/cell_edac.c
index cd2e3b8..24f3ca8 100644
--- a/drivers/edac/cell_edac.c
+++ b/drivers/edac/cell_edac.c
@@ -36,7 +36,7 @@ static void cell_edac_count_ce(struct mem_ctl_info *mci, int chan, u64 ar)
 	struct csrow_info		*csrow = &mci->csrows[0];
 	unsigned long			address, pfn, offset, syndrome;
 
-	dev_dbg(mci->dev, "ECC CE err on node %d, channel %d, ar = 0x%016lx\n",
+	dev_dbg(mci->dev, "ECC CE err on node %d, channel %d, ar = 0x%016llx\n",
 		priv->node, chan, ar);
 
 	/* Address decoding is likely a bit bogus, to dbl check */
@@ -58,7 +58,7 @@ static void cell_edac_count_ue(struct mem_ctl_info *mci, int chan, u64 ar)
 	struct csrow_info		*csrow = &mci->csrows[0];
 	unsigned long			address, pfn, offset;
 
-	dev_dbg(mci->dev, "ECC UE err on node %d, channel %d, ar = 0x%016lx\n",
+	dev_dbg(mci->dev, "ECC UE err on node %d, channel %d, ar = 0x%016llx\n",
 		priv->node, chan, ar);
 
 	/* Address decoding is likely a bit bogus, to dbl check */
@@ -169,7 +169,7 @@ static int __devinit cell_edac_probe(struct platform_device *pdev)
 
 	/* Get channel population */
 	reg = in_be64(&regs->mic_mnt_cfg);
-	dev_dbg(&pdev->dev, "MIC_MNT_CFG = 0x%016lx\n", reg);
+	dev_dbg(&pdev->dev, "MIC_MNT_CFG = 0x%016llx\n", reg);
 	chanmask = 0;
 	if (reg & CBE_MIC_MNT_CFG_CHAN_0_POP)
 		chanmask |= 0x1;
@@ -180,7 +180,7 @@ static int __devinit cell_edac_probe(struct platform_device *pdev)
 			 "Yuck ! No channel populated ? Aborting !\n");
 		return -ENODEV;
 	}
-	dev_dbg(&pdev->dev, "Initial FIR = 0x%016lx\n",
+	dev_dbg(&pdev->dev, "Initial FIR = 0x%016llx\n",
 		in_be64(&regs->mic_fir));
 
 	/* Allocate & init EDAC MC data structure */
diff --git a/drivers/mtd/nand/fsl_elbc_nand.c b/drivers/mtd/nand/fsl_elbc_nand.c
index 65929db..1f6eb25 100644
--- a/drivers/mtd/nand/fsl_elbc_nand.c
+++ b/drivers/mtd/nand/fsl_elbc_nand.c
@@ -676,7 +676,7 @@ static int fsl_elbc_chip_init_tail(struct mtd_info *mtd)
 
 	dev_dbg(ctrl->dev, "fsl_elbc_init: nand->numchips = %d\n",
 	        chip->numchips);
-	dev_dbg(ctrl->dev, "fsl_elbc_init: nand->chipsize = %ld\n",
+	dev_dbg(ctrl->dev, "fsl_elbc_init: nand->chipsize = %lld\n",
 	        chip->chipsize);
 	dev_dbg(ctrl->dev, "fsl_elbc_init: nand->pagemask = %8x\n",
 	        chip->pagemask);
@@ -703,7 +703,7 @@ static int fsl_elbc_chip_init_tail(struct mtd_info *mtd)
 	dev_dbg(ctrl->dev, "fsl_elbc_init: nand->ecc.layout = %p\n",
 	        chip->ecc.layout);
 	dev_dbg(ctrl->dev, "fsl_elbc_init: mtd->flags = %08x\n", mtd->flags);
-	dev_dbg(ctrl->dev, "fsl_elbc_init: mtd->size = %d\n", mtd->size);
+	dev_dbg(ctrl->dev, "fsl_elbc_init: mtd->size = %lld\n", mtd->size);
 	dev_dbg(ctrl->dev, "fsl_elbc_init: mtd->erasesize = %d\n",
 	        mtd->erasesize);
 	dev_dbg(ctrl->dev, "fsl_elbc_init: mtd->writesize = %d\n",
@@ -932,8 +932,8 @@ static int __devinit fsl_elbc_chip_probe(struct fsl_elbc_ctrl *ctrl,
 #endif
 		add_mtd_device(&priv->mtd);
 
-	printk(KERN_INFO "eLBC NAND device at 0x%zx, bank %d\n",
-	       res.start, priv->bank);
+	printk(KERN_INFO "eLBC NAND device at 0x%llx, bank %d\n",
+	       (unsigned long long)res.start, priv->bank);
 	return 0;
 
 err:
diff --git a/drivers/mtd/nand/pasemi_nand.c b/drivers/mtd/nand/pasemi_nand.c
index 9bd6c9a..a8b9376 100644
--- a/drivers/mtd/nand/pasemi_nand.c
+++ b/drivers/mtd/nand/pasemi_nand.c
@@ -107,7 +107,7 @@ static int __devinit pasemi_nand_probe(struct of_device *ofdev,
 	if (pasemi_nand_mtd)
 		return -ENODEV;
 
-	pr_debug("pasemi_nand at %lx-%lx\n", res.start, res.end);
+	pr_debug("pasemi_nand at %llx-%llx\n", res.start, res.end);
 
 	/* Allocate memory for MTD device structure and private data */
 	pasemi_nand_mtd = kzalloc(sizeof(struct mtd_info) +
@@ -170,7 +170,7 @@ static int __devinit pasemi_nand_probe(struct of_device *ofdev,
 		goto out_lpc;
 	}
 
-	printk(KERN_INFO "PA Semi NAND flash at %08lx, control at I/O %x\n",
+	printk(KERN_INFO "PA Semi NAND flash at %08llx, control at I/O %x\n",
 	       res.start, lpcctl);
 
 	return 0;
-- 
1.6.0.5

-- 
Cheers,
Stephen Rothwell                    sfr@canb.auug.org.au
http://www.canb.auug.org.au/~sfr/
