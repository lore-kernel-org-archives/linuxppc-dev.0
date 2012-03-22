Return-Path: <kumarrav@codeaurora.org>
Received: from wolverine01.qualcomm.com (wolverine01.qualcomm.com
 [199.106.114.254])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "wolverine01.qualcomm.com",
 Issuer "VeriSign Class 3 Secure Server CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 76E71B6EF4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Mar 2012 22:08:09 +1100 (EST)
From: Ravi Kumar V <kumarrav@codeaurora.org>
To: Vinod Koul <vinod.koul@intel.com>
Subject: [PATCH v4 1/2] dmaengine: Add context parameter to prep_dma_sg and
 prep_interleaved_dma
Date: Thu, 22 Mar 2012 16:24:52 +0530
Message-Id: <1332413692-8312-1-git-send-email-kumarrav@codeaurora.org>
Cc: tsoni@codeaurora.org, Russell King <linux@arm.linux.org.uk>,
 Ravi Kumar V <kumarrav@codeaurora.org>,
 Srinidhi Kasagar <srinidhi.kasagar@stericsson.com>,
 "Ira W. Snyder" <iws@ovro.caltech.edu>, linux-arm-msm@vger.kernel.or,
 linux-kernel@vger.kernel.org, Zhang Wei <zw@zh-kernel.org>,
 Bryan Huntsman <bryanh@codeaurora.org>, Al Viro <viro@zeniv.linux.org.uk>,
 Barry Song <baohua.song@csr.com>, Daniel Walker <dwalker@fifo99.com>,
 Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org,
 David Brown <davidb@codeaurora.org>, linux-arm-kernel@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Add new context parameter to DMA SG and Interleaveid mode for passing
per transfer specific private data, using this it enables the
dma devices which needs to pass the parameters which changes per
each transfer

Change-Id: Ia9ee19f2c253e68b8e5ff254a57478dcc51014ca
Signed-off-by: Ravi Kumar V <kumarrav@codeaurora.org>
---
 drivers/dma/fsldma.c                    |    2 +-
 drivers/dma/sirf-dma.c                  |    2 +-
 drivers/dma/ste_dma40.c                 |    2 +-
 drivers/misc/carma/carma-fpga-program.c |    2 +-
 drivers/misc/carma/carma-fpga.c         |    7 +++----
 include/linux/dmaengine.h               |   22 ++++++++++++++++++++--
 6 files changed, 27 insertions(+), 10 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index b98070c..f9f77db 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -645,7 +645,7 @@ fail:
 static struct dma_async_tx_descriptor *fsl_dma_prep_sg(struct dma_chan *dchan,
 	struct scatterlist *dst_sg, unsigned int dst_nents,
 	struct scatterlist *src_sg, unsigned int src_nents,
-	unsigned long flags)
+	unsigned long flags, void *context)
 {
 	struct fsl_desc_sw *first = NULL, *prev = NULL, *new = NULL;
 	struct fsldma_chan *chan = to_fsl_chan(dchan);
diff --git a/drivers/dma/sirf-dma.c b/drivers/dma/sirf-dma.c
index 2333810..ff4d344 100644
--- a/drivers/dma/sirf-dma.c
+++ b/drivers/dma/sirf-dma.c
@@ -428,7 +428,7 @@ sirfsoc_dma_tx_status(struct dma_chan *chan, dma_cookie_t cookie,
 
 static struct dma_async_tx_descriptor *sirfsoc_dma_prep_interleaved(
 	struct dma_chan *chan, struct dma_interleaved_template *xt,
-	unsigned long flags)
+	unsigned long flags, void *context)
 {
 	struct sirfsoc_dma *sdma = dma_chan_to_sirfsoc_dma(chan);
 	struct sirfsoc_dma_chan *schan = dma_chan_to_sirfsoc_dma_chan(chan);
diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index cc5ecbc..2f58ba9 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -2287,7 +2287,7 @@ static struct dma_async_tx_descriptor *
 d40_prep_memcpy_sg(struct dma_chan *chan,
 		   struct scatterlist *dst_sg, unsigned int dst_nents,
 		   struct scatterlist *src_sg, unsigned int src_nents,
-		   unsigned long dma_flags)
+		   unsigned long dma_flags, void *context)
 {
 	if (dst_nents != src_nents)
 		return NULL;
diff --git a/drivers/misc/carma/carma-fpga-program.c b/drivers/misc/carma/carma-fpga-program.c
index a2d25e4..3739a12 100644
--- a/drivers/misc/carma/carma-fpga-program.c
+++ b/drivers/misc/carma/carma-fpga-program.c
@@ -530,7 +530,7 @@ static noinline int fpga_program_dma(struct fpga_dev *priv)
 	}
 
 	/* setup and submit the DMA transaction */
-	tx = chan->device->device_prep_dma_sg(chan,
+	tx = chan->device->dmaengine_prep_dma_sg(chan,
 					      table.sgl, num_pages,
 					      vb->sglist, vb->sglen, 0);
 	if (!tx) {
diff --git a/drivers/misc/carma/carma-fpga.c b/drivers/misc/carma/carma-fpga.c
index 14e974b2..be0baf6 100644
--- a/drivers/misc/carma/carma-fpga.c
+++ b/drivers/misc/carma/carma-fpga.c
@@ -638,10 +638,9 @@ static int data_submit_dma(struct fpga_device *priv, struct data_buf *buf)
 	 */
 
 	/* setup the scatterlist to scatterlist transfer */
-	tx = chan->device->device_prep_dma_sg(chan,
-					      dst_sg, dst_nents,
-					      src_sg, src_nents,
-					      0);
+	tx = dmaengine_prep_dma_sg(chan, dst_sg, dst_nents,
+					 src_sg, src_nents,
+					 0);
 	if (!tx) {
 		dev_err(priv->dev, "unable to prep scatterlist DMA\n");
 		return -ENOMEM;
diff --git a/include/linux/dmaengine.h b/include/linux/dmaengine.h
index 679b349..68a57da 100644
--- a/include/linux/dmaengine.h
+++ b/include/linux/dmaengine.h
@@ -570,7 +570,7 @@ struct dma_device {
 		struct dma_chan *chan,
 		struct scatterlist *dst_sg, unsigned int dst_nents,
 		struct scatterlist *src_sg, unsigned int src_nents,
-		unsigned long flags);
+		unsigned long flags, void *context);
 
 	struct dma_async_tx_descriptor *(*device_prep_slave_sg)(
 		struct dma_chan *chan, struct scatterlist *sgl,
@@ -581,7 +581,7 @@ struct dma_device {
 		size_t period_len, enum dma_transfer_direction direction);
 	struct dma_async_tx_descriptor *(*device_prep_interleaved_dma)(
 		struct dma_chan *chan, struct dma_interleaved_template *xt,
-		unsigned long flags);
+		unsigned long flags, void *context);
 	int (*device_control)(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 		unsigned long arg);
 
@@ -615,6 +615,24 @@ static inline struct dma_async_tx_descriptor *dmaengine_prep_slave_single(
 	return chan->device->device_prep_slave_sg(chan, &sg, 1, dir, flags);
 }
 
+static inline struct dma_async_tx_descriptor *dmaengine_prep_dma_sg(
+			struct dma_chan *chan, struct scatterlist *dst_sg,
+			unsigned int dst_nents,	struct scatterlist *src_sg,
+			unsigned int src_nents,	unsigned long flags)
+{
+	return chan->device->device_prep_dma_sg(chan, dst_sg, dst_nents,
+					src_sg, src_nents, flags, NULL);
+}
+
+static inline struct dma_async_tx_descriptor *dmaengine_prep_interleaved_dma(
+			struct dma_chan *chan,
+			struct dma_interleaved_template *xt,
+			unsigned long flags)
+{
+	return chan->device->device_prep_interleaved_dma(chan, xt,
+							flags, NULL);
+}
+
 static inline int dmaengine_terminate_all(struct dma_chan *chan)
 {
 	return dmaengine_device_control(chan, DMA_TERMINATE_ALL, 0);
-- 
Sent by a consultant of the Qualcomm Innovation Center, Inc.
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum.
