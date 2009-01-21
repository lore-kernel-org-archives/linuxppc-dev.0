Return-Path: <sfr@canb.auug.org.au>
Received: from smtps.tip.net.au (chilli.pcug.org.au [203.10.76.44])
	by ozlabs.org (Postfix) with ESMTP id A7114DDED1
	for <linuxppc-dev@ozlabs.org>; Wed, 21 Jan 2009 11:16:57 +1100 (EST)
Date: Wed, 21 Jan 2009 11:16:51 +1100
From: Stephen Rothwell <sfr@canb.auug.org.au>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: more printing warning fixes for the l64 to ll64
	conversion
Message-Id: <20090121111651.7d6e87ec.sfr@canb.auug.org.au>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: Nick Spence <nick.spence@freescale.com>, Olof, Johansson <olof@lixom.net>,
	Doug, linuxppc-dev@ozlabs.org, Egor Martovetsky <egor@pasemi.com>,
	Paul Mackerras <paulus@samba.org>, Thompson <dougthompson@xmission.com>,
	Scott Wood <scottwood@freescale.com>, linux-mtd@lists.infradead.org,
	David Woodhouse <dwmw2@infradead.org>,
	bluesmoke-devel@lists.sourceforge.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

These are all powerpc specific drivers.

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 drivers/edac/cell_edac.c         |    8 ++++----
 drivers/mtd/nand/fsl_elbc_nand.c |    6 +++---
 drivers/mtd/nand/pasemi_nand.c   |    4 ++--
 3 files changed, 9 insertions(+), 9 deletions(-)

If noone minds (seeing as how simple this patch is) we could just merge
it via the powerpc tree.

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
index 65929db..0f22e1a 100644
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
@@ -932,7 +932,7 @@ static int __devinit fsl_elbc_chip_probe(struct fsl_elbc_ctrl *ctrl,
 #endif
 		add_mtd_device(&priv->mtd);
 
-	printk(KERN_INFO "eLBC NAND device at 0x%zx, bank %d\n",
+	printk(KERN_INFO "eLBC NAND device at 0x%llx, bank %d\n",
 	       res.start, priv->bank);
 	return 0;
 
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
