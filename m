Return-Path: <peter.griffin@linaro.org>
Received: from mail-wm0-f42.google.com (mail-wm0-f42.google.com [74.125.82.42])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPJjt2BCLzDq64
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  8 Jun 2016 03:40:02 +1000 (AEST)
Received: by mail-wm0-f42.google.com with SMTP id k204so79276966wmk.0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 07 Jun 2016 10:40:02 -0700 (PDT)
From: Peter Griffin <peter.griffin@linaro.org>
To: linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
 kernel@stlinux.com, vinod.koul@intel.com, linus.walleij@linaro.org,
 dan.j.williams@intel.com, leoli@freescale.com, zw@zh-kernel.org,
 baohua@kernel.org, maxime.ripard@free-electrons.com, wens@csie.org,
 ldewangan@nvidia.com, jonathanh@nvidia.com, swarren@wwwdotorg.org,
 thierry.reding@gmail.com, gnurou@gmail.com
Cc: peter.griffin@linaro.org, lee.jones@linaro.org, dmaengine@vger.kernel.org,
 linux-tegra@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: [PATCH 8/8] dmaengine: Remove site specific OOM error messages on
 kzalloc
Date: Tue,  7 Jun 2016 18:38:41 +0100
Message-Id: <1465321121-22238-9-git-send-email-peter.griffin@linaro.org>
In-Reply-To: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
References: <1465321121-22238-1-git-send-email-peter.griffin@linaro.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

If kzalloc() fails it will issue it's own error message including
a dump_stack(). So remove the site specific error messages.

Signed-off-by: Peter Griffin <peter.griffin@linaro.org>
---
 drivers/dma/amba-pl08x.c        | 10 +---------
 drivers/dma/bestcomm/bestcomm.c |  2 --
 drivers/dma/edma.c              | 16 ++++------------
 drivers/dma/fsldma.c            |  2 --
 drivers/dma/k3dma.c             | 10 ++++------
 drivers/dma/mmp_tdma.c          |  5 ++---
 drivers/dma/moxart-dma.c        |  4 +---
 drivers/dma/nbpfaxi.c           |  5 ++---
 drivers/dma/pl330.c             |  5 +----
 drivers/dma/ppc4xx/adma.c       |  2 --
 drivers/dma/s3c24xx-dma.c       |  5 +----
 drivers/dma/sh/shdmac.c         |  9 ++-------
 drivers/dma/sh/sudmac.c         |  9 ++-------
 drivers/dma/sirf-dma.c          |  5 ++---
 drivers/dma/ste_dma40.c         |  4 +---
 drivers/dma/tegra20-apb-dma.c   | 11 +++--------
 drivers/dma/timb_dma.c          |  8 ++------
 17 files changed, 28 insertions(+), 84 deletions(-)

diff --git a/drivers/dma/amba-pl08x.c b/drivers/dma/amba-pl08x.c
index 81db1c4..939a7c3 100644
--- a/drivers/dma/amba-pl08x.c
+++ b/drivers/dma/amba-pl08x.c
@@ -1443,8 +1443,6 @@ static struct dma_async_tx_descriptor *pl08x_prep_dma_memcpy(
 	dsg = kzalloc(sizeof(struct pl08x_sg), GFP_NOWAIT);
 	if (!dsg) {
 		pl08x_free_txd(pl08x, txd);
-		dev_err(&pl08x->adev->dev, "%s no memory for pl080 sg\n",
-				__func__);
 		return NULL;
 	}
 	list_add_tail(&dsg->node, &txd->dsg_list);
@@ -1901,11 +1899,8 @@ static int pl08x_dma_init_virtual_channels(struct pl08x_driver_data *pl08x,
 	 */
 	for (i = 0; i < channels; i++) {
 		chan = kzalloc(sizeof(*chan), GFP_KERNEL);
-		if (!chan) {
-			dev_err(&pl08x->adev->dev,
-				"%s no memory for channel\n", __func__);
+		if (!chan)
 			return -ENOMEM;
-		}
 
 		chan->host = pl08x;
 		chan->state = PL08X_CHAN_IDLE;
@@ -2360,9 +2355,6 @@ static int pl08x_probe(struct amba_device *adev, const struct amba_id *id)
 	pl08x->phy_chans = kzalloc((vd->channels * sizeof(*pl08x->phy_chans)),
 			GFP_KERNEL);
 	if (!pl08x->phy_chans) {
-		dev_err(&adev->dev, "%s failed to allocate "
-			"physical channel holders\n",
-			__func__);
 		ret = -ENOMEM;
 		goto out_no_phychans;
 	}
diff --git a/drivers/dma/bestcomm/bestcomm.c b/drivers/dma/bestcomm/bestcomm.c
index 180fedb..7ce8437 100644
--- a/drivers/dma/bestcomm/bestcomm.c
+++ b/drivers/dma/bestcomm/bestcomm.c
@@ -397,8 +397,6 @@ static int mpc52xx_bcom_probe(struct platform_device *op)
 	/* Get a clean struct */
 	bcom_eng = kzalloc(sizeof(struct bcom_engine), GFP_KERNEL);
 	if (!bcom_eng) {
-		printk(KERN_ERR DRIVER_NAME ": "
-			"Can't allocate state structure\n");
 		rv = -ENOMEM;
 		goto error_sramclean;
 	}
diff --git a/drivers/dma/edma.c b/drivers/dma/edma.c
index 8181ed1..3c84cd8 100644
--- a/drivers/dma/edma.c
+++ b/drivers/dma/edma.c
@@ -1069,10 +1069,8 @@ static struct dma_async_tx_descriptor *edma_prep_slave_sg(
 
 	edesc = kzalloc(sizeof(*edesc) + sg_len * sizeof(edesc->pset[0]),
 			GFP_ATOMIC);
-	if (!edesc) {
-		dev_err(dev, "%s: Failed to allocate a descriptor\n", __func__);
+	if (!edesc)
 		return NULL;
-	}
 
 	edesc->pset_nr = sg_len;
 	edesc->residue = 0;
@@ -1173,10 +1171,8 @@ static struct dma_async_tx_descriptor *edma_prep_dma_memcpy(
 
 	edesc = kzalloc(sizeof(*edesc) + nslots * sizeof(edesc->pset[0]),
 			GFP_ATOMIC);
-	if (!edesc) {
-		dev_dbg(dev, "Failed to allocate a descriptor\n");
+	if (!edesc)
 		return NULL;
-	}
 
 	edesc->pset_nr = nslots;
 	edesc->residue = edesc->residue_stat = len;
@@ -1298,10 +1294,8 @@ static struct dma_async_tx_descriptor *edma_prep_dma_cyclic(
 
 	edesc = kzalloc(sizeof(*edesc) + nslots * sizeof(edesc->pset[0]),
 			GFP_ATOMIC);
-	if (!edesc) {
-		dev_err(dev, "%s: Failed to allocate a descriptor\n", __func__);
+	if (!edesc)
 		return NULL;
-	}
 
 	edesc->cyclic = 1;
 	edesc->pset_nr = nslots;
@@ -2207,10 +2201,8 @@ static int edma_probe(struct platform_device *pdev)
 		return ret;
 
 	ecc = devm_kzalloc(dev, sizeof(*ecc), GFP_KERNEL);
-	if (!ecc) {
-		dev_err(dev, "Can't allocate controller\n");
+	if (!ecc)
 		return -ENOMEM;
-	}
 
 	ecc->dev = dev;
 	ecc->id = pdev->id;
diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index a8828ed..911b717 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1234,7 +1234,6 @@ static int fsl_dma_chan_probe(struct fsldma_device *fdev,
 	/* alloc channel */
 	chan = kzalloc(sizeof(*chan), GFP_KERNEL);
 	if (!chan) {
-		dev_err(fdev->dev, "no free memory for DMA channels!\n");
 		err = -ENOMEM;
 		goto out_return;
 	}
@@ -1340,7 +1339,6 @@ static int fsldma_of_probe(struct platform_device *op)
 
 	fdev = kzalloc(sizeof(*fdev), GFP_KERNEL);
 	if (!fdev) {
-		dev_err(&op->dev, "No enough memory for 'priv'\n");
 		err = -ENOMEM;
 		goto out_return;
 	}
diff --git a/drivers/dma/k3dma.c b/drivers/dma/k3dma.c
index 1ba2fd7..35961af 100644
--- a/drivers/dma/k3dma.c
+++ b/drivers/dma/k3dma.c
@@ -425,10 +425,9 @@ static struct dma_async_tx_descriptor *k3_dma_prep_memcpy(
 
 	num = DIV_ROUND_UP(len, DMA_MAX_SIZE);
 	ds = kzalloc(sizeof(*ds) + num * sizeof(ds->desc_hw[0]), GFP_ATOMIC);
-	if (!ds) {
-		dev_dbg(chan->device->dev, "vchan %p: kzalloc fail\n", &c->vc);
+	if (!ds)
 		return NULL;
-	}
+
 	ds->desc_hw_lli = __virt_to_phys((unsigned long)&ds->desc_hw[0]);
 	ds->size = len;
 	ds->desc_num = num;
@@ -481,10 +480,9 @@ static struct dma_async_tx_descriptor *k3_dma_prep_slave_sg(
 	}
 
 	ds = kzalloc(sizeof(*ds) + num * sizeof(ds->desc_hw[0]), GFP_ATOMIC);
-	if (!ds) {
-		dev_dbg(chan->device->dev, "vchan %p: kzalloc fail\n", &c->vc);
+	if (!ds)
 		return NULL;
-	}
+
 	ds->desc_hw_lli = __virt_to_phys((unsigned long)&ds->desc_hw[0]);
 	ds->desc_num = num;
 	num = 0;
diff --git a/drivers/dma/mmp_tdma.c b/drivers/dma/mmp_tdma.c
index 3df0422..ba7f412 100644
--- a/drivers/dma/mmp_tdma.c
+++ b/drivers/dma/mmp_tdma.c
@@ -551,10 +551,9 @@ static int mmp_tdma_chan_init(struct mmp_tdma_device *tdev,
 
 	/* alloc channel */
 	tdmac = devm_kzalloc(tdev->dev, sizeof(*tdmac), GFP_KERNEL);
-	if (!tdmac) {
-		dev_err(tdev->dev, "no free memory for DMA channels!\n");
+	if (!tdmac)
 		return -ENOMEM;
-	}
+
 	if (irq)
 		tdmac->irq = irq;
 	tdmac->dev	   = tdev->dev;
diff --git a/drivers/dma/moxart-dma.c b/drivers/dma/moxart-dma.c
index 631c443..b3a1d9a 100644
--- a/drivers/dma/moxart-dma.c
+++ b/drivers/dma/moxart-dma.c
@@ -574,10 +574,8 @@ static int moxart_probe(struct platform_device *pdev)
 	struct moxart_dmadev *mdc;
 
 	mdc = devm_kzalloc(dev, sizeof(*mdc), GFP_KERNEL);
-	if (!mdc) {
-		dev_err(dev, "can't allocate DMA container\n");
+	if (!mdc)
 		return -ENOMEM;
-	}
 
 	irq = irq_of_parse_and_map(node, 0);
 	if (irq == NO_IRQ) {
diff --git a/drivers/dma/nbpfaxi.c b/drivers/dma/nbpfaxi.c
index 2b5a198..9f0e98b 100644
--- a/drivers/dma/nbpfaxi.c
+++ b/drivers/dma/nbpfaxi.c
@@ -1300,10 +1300,9 @@ static int nbpf_probe(struct platform_device *pdev)
 
 	nbpf = devm_kzalloc(dev, sizeof(*nbpf) + num_channels *
 			    sizeof(nbpf->chan[0]), GFP_KERNEL);
-	if (!nbpf) {
-		dev_err(dev, "Memory allocation failed\n");
+	if (!nbpf)
 		return -ENOMEM;
-	}
+
 	dma_dev = &nbpf->dma_dev;
 	dma_dev->dev = dev;
 
diff --git a/drivers/dma/pl330.c b/drivers/dma/pl330.c
index 372b435..c8767d3 100644
--- a/drivers/dma/pl330.c
+++ b/drivers/dma/pl330.c
@@ -2828,10 +2828,8 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 
 	/* Allocate a new DMAC and its Channels */
 	pl330 = devm_kzalloc(&adev->dev, sizeof(*pl330), GFP_KERNEL);
-	if (!pl330) {
-		dev_err(&adev->dev, "unable to allocate mem\n");
+	if (!pl330)
 		return -ENOMEM;
-	}
 
 	pd = &pl330->ddma;
 	pd->dev = &adev->dev;
@@ -2890,7 +2888,6 @@ pl330_probe(struct amba_device *adev, const struct amba_id *id)
 	pl330->peripherals = kzalloc(num_chan * sizeof(*pch), GFP_KERNEL);
 	if (!pl330->peripherals) {
 		ret = -ENOMEM;
-		dev_err(&adev->dev, "unable to allocate pl330->peripherals\n");
 		goto probe_err2;
 	}
 
diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 9217f89..da3688b 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -4084,7 +4084,6 @@ static int ppc440spe_adma_probe(struct platform_device *ofdev)
 	/* create a device */
 	adev = kzalloc(sizeof(*adev), GFP_KERNEL);
 	if (!adev) {
-		dev_err(&ofdev->dev, "failed to allocate device\n");
 		initcode = PPC_ADMA_INIT_ALLOC;
 		ret = -ENOMEM;
 		goto err_adev_alloc;
@@ -4145,7 +4144,6 @@ static int ppc440spe_adma_probe(struct platform_device *ofdev)
 	/* create a channel */
 	chan = kzalloc(sizeof(*chan), GFP_KERNEL);
 	if (!chan) {
-		dev_err(&ofdev->dev, "can't allocate channel structure\n");
 		initcode = PPC_ADMA_INIT_CHANNEL;
 		ret = -ENOMEM;
 		goto err_chan_alloc;
diff --git a/drivers/dma/s3c24xx-dma.c b/drivers/dma/s3c24xx-dma.c
index f7d2c7a..0d2d187 100644
--- a/drivers/dma/s3c24xx-dma.c
+++ b/drivers/dma/s3c24xx-dma.c
@@ -1101,11 +1101,8 @@ static int s3c24xx_dma_init_virtual_channels(struct s3c24xx_dma_engine *s3cdma,
 	 */
 	for (i = 0; i < channels; i++) {
 		chan = devm_kzalloc(dmadev->dev, sizeof(*chan), GFP_KERNEL);
-		if (!chan) {
-			dev_err(dmadev->dev,
-				"%s no memory for channel\n", __func__);
+		if (!chan)
 			return -ENOMEM;
-		}
 
 		chan->id = i;
 		chan->host = s3cdma;
diff --git a/drivers/dma/sh/shdmac.c b/drivers/dma/sh/shdmac.c
index 80d8640..c94ffab 100644
--- a/drivers/dma/sh/shdmac.c
+++ b/drivers/dma/sh/shdmac.c
@@ -532,11 +532,8 @@ static int sh_dmae_chan_probe(struct sh_dmae_device *shdev, int id,
 
 	sh_chan = devm_kzalloc(sdev->dma_dev.dev, sizeof(struct sh_dmae_chan),
 			       GFP_KERNEL);
-	if (!sh_chan) {
-		dev_err(sdev->dma_dev.dev,
-			"No free memory for allocating dma channels!\n");
+	if (!sh_chan)
 		return -ENOMEM;
-	}
 
 	schan = &sh_chan->shdma_chan;
 	schan->max_xfer_len = SH_DMA_TCR_MAX + 1;
@@ -732,10 +729,8 @@ static int sh_dmae_probe(struct platform_device *pdev)
 
 	shdev = devm_kzalloc(&pdev->dev, sizeof(struct sh_dmae_device),
 			     GFP_KERNEL);
-	if (!shdev) {
-		dev_err(&pdev->dev, "Not enough memory\n");
+	if (!shdev)
 		return -ENOMEM;
-	}
 
 	dma_dev = &shdev->shdma_dev.dma_dev;
 
diff --git a/drivers/dma/sh/sudmac.c b/drivers/dma/sh/sudmac.c
index 6da2eaa..69b9564 100644
--- a/drivers/dma/sh/sudmac.c
+++ b/drivers/dma/sh/sudmac.c
@@ -245,11 +245,8 @@ static int sudmac_chan_probe(struct sudmac_device *su_dev, int id, int irq,
 	int err;
 
 	sc = devm_kzalloc(&pdev->dev, sizeof(struct sudmac_chan), GFP_KERNEL);
-	if (!sc) {
-		dev_err(sdev->dma_dev.dev,
-			"No free memory for allocating dma channels!\n");
+	if (!sc)
 		return -ENOMEM;
-	}
 
 	schan = &sc->shdma_chan;
 	schan->max_xfer_len = 64 * 1024 * 1024 - 1;
@@ -349,10 +346,8 @@ static int sudmac_probe(struct platform_device *pdev)
 	err = -ENOMEM;
 	su_dev = devm_kzalloc(&pdev->dev, sizeof(struct sudmac_device),
 			      GFP_KERNEL);
-	if (!su_dev) {
-		dev_err(&pdev->dev, "Not enough memory\n");
+	if (!su_dev)
 		return err;
-	}
 
 	dma_dev = &su_dev->shdma_dev.dma_dev;
 
diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index e48350e..8ea51c7 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -854,10 +854,9 @@ static int sirfsoc_dma_probe(struct platform_device *op)
 	int ret, i;
 
 	sdma = devm_kzalloc(dev, sizeof(*sdma), GFP_KERNEL);
-	if (!sdma) {
-		dev_err(dev, "Memory exhausted!\n");
+	if (!sdma)
 		return -ENOMEM;
-	}
+
 	data = (struct sirfsoc_dmadata *)
 		(of_match_device(op->dev.driver->of_match_table,
 				 &op->dev)->data);
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 378cc47..8b18e44 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -3237,10 +3237,8 @@ static struct d40_base * __init d40_hw_detect_init(struct platform_device *pdev)
 		       (num_phy_chans + num_log_chans + num_memcpy_chans) *
 		       sizeof(struct d40_chan), GFP_KERNEL);
 
-	if (base == NULL) {
-		d40_err(&pdev->dev, "Out of memory\n");
+	if (base == NULL)
 		goto failure;
-	}
 
 	base->rev = rev;
 	base->clk = clk;
diff --git a/drivers/dma/tegra20-apb-dma.c b/drivers/dma/tegra20-apb-dma.c
index 7f4af8c..032884f 100644
--- a/drivers/dma/tegra20-apb-dma.c
+++ b/drivers/dma/tegra20-apb-dma.c
@@ -300,10 +300,8 @@ static struct tegra_dma_desc *tegra_dma_desc_get(
 
 	/* Allocate DMA desc */
 	dma_desc = kzalloc(sizeof(*dma_desc), GFP_NOWAIT);
-	if (!dma_desc) {
-		dev_err(tdc2dev(tdc), "dma_desc alloc failed\n");
+	if (!dma_desc)
 		return NULL;
-	}
 
 	dma_async_tx_descriptor_init(&dma_desc->txd, &tdc->dma_chan);
 	dma_desc->txd.tx_submit = tegra_dma_tx_submit;
@@ -340,8 +338,7 @@ static struct tegra_dma_sg_req *tegra_dma_sg_req_get(
 	spin_unlock_irqrestore(&tdc->lock, flags);
 
 	sg_req = kzalloc(sizeof(struct tegra_dma_sg_req), GFP_NOWAIT);
-	if (!sg_req)
-		dev_err(tdc2dev(tdc), "sg_req alloc failed\n");
+
 	return sg_req;
 }
 
@@ -1319,10 +1316,8 @@ static int tegra_dma_probe(struct platform_device *pdev)
 
 	tdma = devm_kzalloc(&pdev->dev, sizeof(*tdma) + cdata->nr_channels *
 			sizeof(struct tegra_dma_channel), GFP_KERNEL);
-	if (!tdma) {
-		dev_err(&pdev->dev, "Error: memory allocation failed\n");
+	if (!tdma)
 		return -ENOMEM;
-	}
 
 	tdma->dev = &pdev->dev;
 	tdma->chip_data = cdata;
diff --git a/drivers/dma/timb_dma.c b/drivers/dma/timb_dma.c
index 559cd40..e82745a 100644
--- a/drivers/dma/timb_dma.c
+++ b/drivers/dma/timb_dma.c
@@ -337,18 +337,14 @@ static struct timb_dma_desc *td_alloc_init_desc(struct timb_dma_chan *td_chan)
 	int err;
 
 	td_desc = kzalloc(sizeof(struct timb_dma_desc), GFP_KERNEL);
-	if (!td_desc) {
-		dev_err(chan2dev(chan), "Failed to alloc descriptor\n");
+	if (!td_desc)
 		goto out;
-	}
 
 	td_desc->desc_list_len = td_chan->desc_elems * TIMB_DMA_DESC_SIZE;
 
 	td_desc->desc_list = kzalloc(td_desc->desc_list_len, GFP_KERNEL);
-	if (!td_desc->desc_list) {
-		dev_err(chan2dev(chan), "Failed to alloc descriptor\n");
+	if (!td_desc->desc_list)
 		goto err;
-	}
 
 	dma_async_tx_descriptor_init(&td_desc->txd, chan);
 	td_desc->txd.tx_submit = td_tx_submit;
-- 
1.9.1
