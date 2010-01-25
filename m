Return-Path: <agust@denx.de>
Received: from mail-out.m-online.net (mail-out.m-online.net [212.18.0.9])
	by ozlabs.org (Postfix) with ESMTP id D63B81007D1
	for <linuxppc-dev@ozlabs.org>; Tue, 26 Jan 2010 02:56:38 +1100 (EST)
Date: Mon, 25 Jan 2010 16:56:24 +0100
From: Anatolij Gustschin <agust@denx.de>
To: Wolfram Sang <w.sang@pengutronix.de>
Subject: Re: [PATCH 06/11] mtd: Add MPC5121 NAND Flash Controller driver
Message-ID: <20100125165624.1e567a95@wker>
In-Reply-To: <20100120104915.GB5041@pengutronix.de>
References: <1263932653-3634-1-git-send-email-agust@denx.de>
	<1263932653-3634-7-git-send-email-agust@denx.de>
	<20100120104915.GB5041@pengutronix.de>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: wd@denx.de, dzu@denx.de, linuxppc-dev@ozlabs.org,
	linux-mtd@lists.infradead.org, Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Wolfram,

Wolfram Sang <w.sang@pengutronix.de> wrote:

> Please include a logfile with changes since the last version. This really
> helps.

Ok.

> > +static int __init mpc5121_nfc_probe(struct of_device *op,
> > +					const struct of_device_id *match)
> 
> [...]
> 
> > +{
> > +	/* Support external chip-select logic on ADS5121 board */
> > +	rootnode = of_find_node_by_path("/");
> > +	if (of_device_is_compatible(rootnode, "fsl,mpc5121ads")) {
> > +		retval = ads5121_chipselect_init(mtd);
> > +		if (retval) {
> > +			dev_err(dev, "Chipselect init error!\n");
> > +			of_node_put(rootnode);
> > +			return retval;
> > +		}
> > +
> > +		chip->select_chip = ads5121_select_chip;
> > +	}
> > +	of_node_put(rootnode);
> 
> If we have to live with the platform-stuff being in the driver, maybe a table
> having the compatible-string and an init-function pointer per entry will make
> it scale better with the number of boards?

Maybe something like in the patch below can be accepted?

diff --git a/drivers/mtd/nand/mpc5121_nfc.c b/drivers/mtd/nand/mpc5121_nfc.c
index 2980eb1..6807e72 100644
--- a/drivers/mtd/nand/mpc5121_nfc.c
+++ b/drivers/mtd/nand/mpc5121_nfc.c
@@ -127,6 +127,10 @@ struct mpc5121_nfc_prv {
 	struct device		*dev;
 };
 
+struct mpc5121_nfc_match_data {
+	int (*init)(struct mtd_info *);
+};
+
 static void mpc5121_nfc_done(struct mtd_info *mtd);
 
 #ifdef CONFIG_MTD_PARTITIONS
@@ -279,6 +283,26 @@ static void mpc5121_nfc_select_chip(struct mtd_info *mtd, int chip)
 	nfc_set(mtd, NFC_CONFIG1, NFC_CE);
 }
 
+/* Control chips select signal on ADS5121 board */
+static void ads5121_select_chip(struct mtd_info *mtd, int chip)
+{
+	struct nand_chip *nand = mtd->priv;
+	struct mpc5121_nfc_prv *prv = nand->priv;
+	u8 v;
+
+	/* CPLD Register 9 controls NAND /CE Lines */
+	v = in_8(prv->csreg + 9);
+	v |= 0x0F;
+
+	if (chip >= 0) {
+		mpc5121_nfc_select_chip(mtd, 0);
+		v &= ~(1 << chip);
+	} else
+		mpc5121_nfc_select_chip(mtd, -1);
+
+	out_8(prv->csreg + 9, v);
+}
+
 /* Init external chip select logic on ADS5121 board */
 static int ads5121_chipselect_init(struct mtd_info *mtd)
 {
@@ -293,33 +317,13 @@ static int ads5121_chipselect_init(struct mtd_info *mtd)
 		if (!prv->csreg)
 			return -ENOMEM;
 
-		/* CPLD Register 9 controls NAND /CE Lines */
-		prv->csreg += 9;
+		chip->select_chip = ads5121_select_chip;
 		return 0;
 	}
 
 	return -EINVAL;
 }
 
-/* Control chips select signal on ADS5121 board */
-static void ads5121_select_chip(struct mtd_info *mtd, int chip)
-{
-	struct nand_chip *nand = mtd->priv;
-	struct mpc5121_nfc_prv *prv = nand->priv;
-	u8 v;
-
-	v = in_8(prv->csreg);
-	v |= 0x0F;
-
-	if (chip >= 0) {
-		mpc5121_nfc_select_chip(mtd, 0);
-		v &= ~(1 << chip);
-	} else
-		mpc5121_nfc_select_chip(mtd, -1);
-
-	out_8(prv->csreg, v);
-}
-
 /* Read NAND Ready/Busy signal */
 static int mpc5121_nfc_dev_ready(struct mtd_info *mtd)
 {
@@ -649,7 +653,7 @@ static void mpc5121_nfc_free(struct device *dev, struct mtd_info *mtd)
 static int __init mpc5121_nfc_probe(struct of_device *op,
 					const struct of_device_id *match)
 {
-	struct device_node *rootnode, *dn = op->node;
+	struct device_node *dn = op->node;
 	struct device *dev = &op->dev;
 	struct mpc5121_nfc_prv *prv;
 	struct resource res;
@@ -663,6 +667,7 @@ static int __init mpc5121_nfc_probe(struct of_device *op,
 	int resettime = 0;
 	int retval = 0;
 	int rev, len;
+	struct mpc5121_nfc_match_data *data = match->data;
 
 	/*
 	 * Check SoC revision. This driver supports only NFC
@@ -738,19 +743,13 @@ static int __init mpc5121_nfc_probe(struct of_device *op,
 	chip->options = NAND_NO_AUTOINCR | NAND_USE_FLASH_BBT;
 	chip->ecc.mode = NAND_ECC_SOFT;
 
-	/* Support external chip-select logic on ADS5121 board */
-	rootnode = of_find_node_by_path("/");
-	if (of_device_is_compatible(rootnode, "fsl,mpc5121ads")) {
-		retval = ads5121_chipselect_init(mtd);
+	if (data && data->init) {
+		retval = data->init(mtd);
 		if (retval) {
 			dev_err(dev, "Chipselect init error!\n");
-			of_node_put(rootnode);
-			return retval;
+			goto error;
 		}
-
-		chip->select_chip = ads5121_select_chip;
 	}
-	of_node_put(rootnode);
 
 	/* Enable NFC clock */
 	prv->clk = clk_get(dev, "nfc_clk");
@@ -884,6 +883,11 @@ static int __exit mpc5121_nfc_remove(struct of_device *op)
 
 static struct of_device_id mpc5121_nfc_match[] = {
 	{ .compatible = "fsl,mpc5121-nfc", },
+	{ .compatible = "fsl,mpc5121ads-nfc",
+	  .data = &(struct mpc5121_nfc_match_data) {
+			.init = ads5121_chipselect_init,
+		},
+	},
 	{},
 };
 
