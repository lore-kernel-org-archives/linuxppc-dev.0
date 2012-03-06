Return-Path: <rmk+linuxppc-dev=lists.ozlabs.org@arm.linux.org.uk>
Received: from caramon.arm.linux.org.uk (caramon.arm.linux.org.uk
 [IPv6:2002:4e20:1eda::1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 2229AB6F9D
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  7 Mar 2012 09:36:49 +1100 (EST)
In-Reply-To: <20120306223321.GD15201@n2100.arm.linux.org.uk>
References: <20120306223321.GD15201@n2100.arm.linux.org.uk>
From: Russell King - ARM Linux <linux@arm.linux.org.uk>
To: Dan Williams <dan.j.williams@intel.com>,Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH 9/9] dmaengine: ensure all DMA engine drivers initialize
 their cookies
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Message-Id: <E1S52zb-0002NE-La@rmk-PC.arm.linux.org.uk>
Sender: Russell King <rmk@arm.linux.org.uk>
Date: Tue, 06 Mar 2012 22:36:27 +0000
Cc: linuxppc-dev@lists.ozlabs.org, Stephen Warren <swarren@nvidia.com>,
 linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Ensure all DMA engine drivers initialize their cookies in the same way,
so that they all behave in a similar fashion.  This means their first
issued cookie will be 2 rather than 1, and will increment to INT_MAX
before returning 1 and starting over.

In connection with this, Dan Williams said:
> Russell King wrote:
> > Secondly, some DMA engine drivers initialize the dma_chan cookie to 0,
> > others to 1.  Is there a reason for this, or are these all buggy?
>
> I know that ioat and iop-adma expect 0 to mean "I have cleaned up this
> descriptor and it is idle", and would break if zero was an in-flight
> cookie value.  The reserved usage of zero is an driver internal
> concern, but I have no problem formalizing it as a reserved value.

Signed-off-by: Russell King <rmk+kernel@arm.linux.org.uk>
---
 drivers/dma/fsldma.c      |    1 +
 drivers/dma/imx-dma.c     |    1 +
 drivers/dma/imx-sdma.c    |    1 +
 drivers/dma/ioat/dma.c    |    1 +
 drivers/dma/iop-adma.c    |    1 +
 drivers/dma/mv_xor.c      |    1 +
 drivers/dma/mxs-dma.c     |    1 +
 drivers/dma/ppc4xx/adma.c |    1 +
 drivers/dma/shdma.c       |    1 +
 9 files changed, 9 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 2f6c806..7d7384b 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -1292,6 +1292,7 @@ static int __devinit fsl_dma_chan_probe(struct fsldma_device *fdev,
 	chan->idle = true;
 
 	chan->common.device = &fdev->common;
+	dma_cookie_init(&chan->common);
 
 	/* find the IRQ line, if it exists in the device tree */
 	chan->irq = irq_of_parse_and_map(node, 0);
diff --git a/drivers/dma/imx-dma.c b/drivers/dma/imx-dma.c
index ba317e6..4e14f51 100644
--- a/drivers/dma/imx-dma.c
+++ b/drivers/dma/imx-dma.c
@@ -348,6 +348,7 @@ static int __init imxdma_probe(struct platform_device *pdev)
 		spin_lock_init(&imxdmac->lock);
 
 		imxdmac->chan.device = &imxdma->dma_device;
+		dma_cookie_init(&imxdmac->chan);
 		imxdmac->channel = i;
 
 		/* Add the channel to the DMAC list */
diff --git a/drivers/dma/imx-sdma.c b/drivers/dma/imx-sdma.c
index 4406be2..0be36a4 100644
--- a/drivers/dma/imx-sdma.c
+++ b/drivers/dma/imx-sdma.c
@@ -1356,6 +1356,7 @@ static int __init sdma_probe(struct platform_device *pdev)
 		spin_lock_init(&sdmac->lock);
 
 		sdmac->chan.device = &sdma->dma_device;
+		dma_cookie_init(&sdmac->chan);
 		sdmac->channel = i;
 
 		/*
diff --git a/drivers/dma/ioat/dma.c b/drivers/dma/ioat/dma.c
index 97e100c..31493d8 100644
--- a/drivers/dma/ioat/dma.c
+++ b/drivers/dma/ioat/dma.c
@@ -109,6 +109,7 @@ void ioat_init_channel(struct ioatdma_device *device, struct ioat_chan_common *c
 	chan->reg_base = device->reg_base + (0x80 * (idx + 1));
 	spin_lock_init(&chan->cleanup_lock);
 	chan->common.device = dma;
+	dma_cookie_init(&chan->common);
 	list_add_tail(&chan->common.device_node, &dma->channels);
 	device->idx[idx] = chan;
 	init_timer(&chan->timer);
diff --git a/drivers/dma/iop-adma.c b/drivers/dma/iop-adma.c
index 4370b10..1f3a703 100644
--- a/drivers/dma/iop-adma.c
+++ b/drivers/dma/iop-adma.c
@@ -1545,6 +1545,7 @@ static int __devinit iop_adma_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&iop_chan->chain);
 	INIT_LIST_HEAD(&iop_chan->all_slots);
 	iop_chan->common.device = dma_dev;
+	dma_cookie_init(&iop_chan->common);
 	list_add_tail(&iop_chan->common.device_node, &dma_dev->channels);
 
 	if (dma_has_cap(DMA_MEMCPY, dma_dev->cap_mask)) {
diff --git a/drivers/dma/mv_xor.c b/drivers/dma/mv_xor.c
index 486353e..fa5d55f 100644
--- a/drivers/dma/mv_xor.c
+++ b/drivers/dma/mv_xor.c
@@ -1193,6 +1193,7 @@ static int __devinit mv_xor_probe(struct platform_device *pdev)
 	INIT_LIST_HEAD(&mv_chan->completed_slots);
 	INIT_LIST_HEAD(&mv_chan->all_slots);
 	mv_chan->common.device = dma_dev;
+	dma_cookie_init(&mv_chan->common);
 
 	list_add_tail(&mv_chan->common.device_node, &dma_dev->channels);
 
diff --git a/drivers/dma/mxs-dma.c b/drivers/dma/mxs-dma.c
index 5f3492e..a2267f9 100644
--- a/drivers/dma/mxs-dma.c
+++ b/drivers/dma/mxs-dma.c
@@ -618,6 +618,7 @@ static int __init mxs_dma_probe(struct platform_device *pdev)
 
 		mxs_chan->mxs_dma = mxs_dma;
 		mxs_chan->chan.device = &mxs_dma->dma_device;
+		dma_cookie_init(&mxs_chan->chan);
 
 		tasklet_init(&mxs_chan->tasklet, mxs_dma_tasklet,
 			     (unsigned long) mxs_chan);
diff --git a/drivers/dma/ppc4xx/adma.c b/drivers/dma/ppc4xx/adma.c
index 9752062..ced9882 100644
--- a/drivers/dma/ppc4xx/adma.c
+++ b/drivers/dma/ppc4xx/adma.c
@@ -4497,6 +4497,7 @@ static int __devinit ppc440spe_adma_probe(struct platform_device *ofdev)
 	INIT_LIST_HEAD(&chan->all_slots);
 	chan->device = adev;
 	chan->common.device = &adev->common;
+	dma_cookie_init(&chan->common);
 	list_add_tail(&chan->common.device_node, &adev->common.channels);
 	tasklet_init(&chan->irq_tasklet, ppc440spe_adma_tasklet,
 		     (unsigned long)chan);
diff --git a/drivers/dma/shdma.c b/drivers/dma/shdma.c
index 50510ef..5c40886 100644
--- a/drivers/dma/shdma.c
+++ b/drivers/dma/shdma.c
@@ -1089,6 +1089,7 @@ static int __devinit sh_dmae_chan_probe(struct sh_dmae_device *shdev, int id,
 
 	/* reference struct dma_device */
 	new_sh_chan->common.device = &shdev->common;
+	dma_cookie_init(&new_sh_chan->common);
 
 	new_sh_chan->dev = shdev->common.dev;
 	new_sh_chan->id = id;
-- 
1.7.4.4
