Return-Path: <iws@ovro.caltech.edu>
Received: from ozlabs.org (ozlabs.org [203.10.76.45])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "mx.ozlabs.org",
	Issuer "CA Cert Signing Authority" (verified OK))
	by bilbo.ozlabs.org (Postfix) with ESMTPS id 6DB83B728B
	for <linuxppc-dev@lists.ozlabs.org>;
	Sat, 20 Jun 2009 05:26:21 +1000 (EST)
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id C710CDDD1C
	for <linuxppc-dev@ozlabs.org>; Sat, 20 Jun 2009 05:26:20 +1000 (EST)
Date: Fri, 19 Jun 2009 12:26:17 -0700
From: Ira Snyder <iws@ovro.caltech.edu>
To: linuxppc-dev@ozlabs.org, Li Yang <leoli@freescale.com>,
	Dan Williams <dan.j.williams@intel.com>,
	Kumar Gala <galak@kernel.crashing.org>
Subject: [PATCH 1/2] fsldma: split apart external pause and request count
	features
Message-ID: <20090619192617.GB30992@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When using the Freescale DMA controller in external control mode, both the
request count and external pause bits need to be setup correctly. This was
being done with the same function.

The 83xx controller lacks the external pause feature, but has a similar
feature called external start. This feature requires that the request count
bits be setup correctly.

Split the function into two parts, to make it possible to use the external
start feature on the 83xx controller.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---

This patch splits apart the external pause feature from the request
count feature, to make it possible to use the external start feature on
the 83xx controller without writing the register directly after the
driver has been initialized.

The DMA_SLAVE patch depends on this patch.

 drivers/dma/fsldma.c |   45 +++++++++++++++++++++++++++++----------------
 drivers/dma/fsldma.h |    3 ++-
 2 files changed, 31 insertions(+), 17 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 6e60c77..dd9d4d6 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -280,28 +280,40 @@ static void fsl_chan_set_dest_loop_size(struct fsl_dma_chan *fsl_chan, int size)
 }
 
 /**
- * fsl_chan_toggle_ext_pause - Toggle channel external pause status
+ * fsl_chan_set_request_count - Set DMA Request Count for external control
  * @fsl_chan : Freescale DMA channel
- * @size     : Pause control size, 0 for disable external pause control.
- *             The maximum is 1024.
+ * @size     : Number of bytes to transfer in a single request
+ *
+ * The Freescale DMA channel can be controlled by the external signal DREQ#.
+ * The DMA request count is how many bytes are allowed to transfer before
+ * pausing the channel, after which a new assertion of DREQ# resumes channel
+ * operation.
  *
- * The Freescale DMA channel can be controlled by the external
- * signal DREQ#. The pause control size is how many bytes are allowed
- * to transfer before pausing the channel, after which a new assertion
- * of DREQ# resumes channel operation.
+ * A size of 0 disables external pause control. The maximum size is 1024.
  */
-static void fsl_chan_toggle_ext_pause(struct fsl_dma_chan *fsl_chan, int size)
+static void fsl_chan_set_request_count(struct fsl_dma_chan *fsl_chan, int size)
 {
-	if (size > 1024)
-		return;
+	BUG_ON(size > 1024);
+	DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr,
+		DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32)
+			| ((__ilog2(size) << 24) & 0x0f000000),
+		32);
+}
 
-	if (size) {
-		DMA_OUT(fsl_chan, &fsl_chan->reg_base->mr,
-			DMA_IN(fsl_chan, &fsl_chan->reg_base->mr, 32)
-				| ((__ilog2(size) << 24) & 0x0f000000),
-			32);
+/**
+ * fsl_chan_toggle_ext_pause - Toggle channel external pause status
+ * @fsl_chan : Freescale DMA channel
+ * @enable   : 0 is disabled, 1 is enabled.
+ *
+ * The Freescale DMA channel can be controlled by the external signal DREQ#.
+ * The DMA Request Count feature should be used in addition to this feature
+ * to set the number of bytes to transfer before pausing the channel.
+ */
+static void fsl_chan_toggle_ext_pause(struct fsl_dma_chan *fsl_chan, int enable)
+{
+	if (enable)
 		fsl_chan->feature |= FSL_DMA_CHAN_PAUSE_EXT;
-	} else
+	else
 		fsl_chan->feature &= ~FSL_DMA_CHAN_PAUSE_EXT;
 }
 
@@ -883,6 +895,7 @@ static int __devinit fsl_dma_chan_probe(struct fsl_dma_device *fdev,
 		new_fsl_chan->toggle_ext_start = fsl_chan_toggle_ext_start;
 		new_fsl_chan->set_src_loop_size = fsl_chan_set_src_loop_size;
 		new_fsl_chan->set_dest_loop_size = fsl_chan_set_dest_loop_size;
+		new_fsl_chan->set_request_count = fsl_chan_set_request_count;
 	}
 
 	spin_lock_init(&new_fsl_chan->desc_lock);
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index dc7f268..462208d 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -143,10 +143,11 @@ struct fsl_dma_chan {
 	struct tasklet_struct tasklet;
 	u32 feature;
 
-	void (*toggle_ext_pause)(struct fsl_dma_chan *fsl_chan, int size);
+	void (*toggle_ext_pause)(struct fsl_dma_chan *fsl_chan, int enable);
 	void (*toggle_ext_start)(struct fsl_dma_chan *fsl_chan, int enable);
 	void (*set_src_loop_size)(struct fsl_dma_chan *fsl_chan, int size);
 	void (*set_dest_loop_size)(struct fsl_dma_chan *fsl_chan, int size);
+	void (*set_request_count)(struct fsl_dma_chan *fsl_chan, int size);
 };
 
 #define to_fsl_chan(chan) container_of(chan, struct fsl_dma_chan, common)
-- 
1.5.4.3
