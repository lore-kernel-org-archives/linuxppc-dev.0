Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id BFD68B70DF
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue, 28 Sep 2010 08:58:00 +1000 (EST)
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] ste_dma40: implement support for scatterlist to
	scatterlist copy
Date: Mon, 27 Sep 2010 15:57:57 -0700
Message-Id: <1285628277-26894-5-git-send-email-iws@ovro.caltech.edu>
In-Reply-To: <1285628277-26894-1-git-send-email-iws@ovro.caltech.edu>
References: <1285628277-26894-1-git-send-email-iws@ovro.caltech.edu>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Cc: =?UTF-8?q?Per=20Frid=C3=A9n?= <per.friden@stericsson.com>,
	Linus Walleij <linus.ml.walleij@gmail.com>,
	Dan Williams <dan.j.williams@intel.com>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Now that the DMAEngine API has support for scatterlist to scatterlist
copy, implement support for the STE DMA40 DMA controller.

Cc: Linus Walleij <linus.ml.walleij@gmail.com>
Cc: Per Fridén <per.friden@stericsson.com>
Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/dma/ste_dma40.c |   17 +++++++++++++++++
 1 files changed, 17 insertions(+), 0 deletions(-)

diff --git a/drivers/dma/ste_dma40.c b/drivers/dma/ste_dma40.c
index 17e2600..cd48859 100644
--- a/drivers/dma/ste_dma40.c
+++ b/drivers/dma/ste_dma40.c
@@ -1857,6 +1857,18 @@ err:
 	return NULL;
 }
 
+static struct dma_async_tx_descriptor *
+d40_prep_sg(struct dma_chan *chan,
+	    struct scatterlist *dst_sg, unsigned int dst_nents,
+	    struct scatterlist *src_sg, unsigned int src_nents,
+	    unsigned long dma_flags)
+{
+	if (dst_nents != src_nents)
+		return -EINVAL;
+
+	return stedma40_memcpy_sg(chan, dst_sg, src_sg, dst_nents, dma_flags);
+}
+
 static int d40_prep_slave_sg_log(struct d40_desc *d40d,
 				 struct d40_chan *d40c,
 				 struct scatterlist *sgl,
@@ -2281,6 +2293,7 @@ static int __init d40_dmaengine_init(struct d40_base *base,
 	base->dma_slave.device_alloc_chan_resources = d40_alloc_chan_resources;
 	base->dma_slave.device_free_chan_resources = d40_free_chan_resources;
 	base->dma_slave.device_prep_dma_memcpy = d40_prep_memcpy;
+	base->dma_slave.device_prep_dma_sg = d40_prep_sg;
 	base->dma_slave.device_prep_slave_sg = d40_prep_slave_sg;
 	base->dma_slave.device_tx_status = d40_tx_status;
 	base->dma_slave.device_issue_pending = d40_issue_pending;
@@ -2301,10 +2314,12 @@ static int __init d40_dmaengine_init(struct d40_base *base,
 
 	dma_cap_zero(base->dma_memcpy.cap_mask);
 	dma_cap_set(DMA_MEMCPY, base->dma_memcpy.cap_mask);
+	dma_cap_set(DMA_SG, base->dma_slave.cap_mask);
 
 	base->dma_memcpy.device_alloc_chan_resources = d40_alloc_chan_resources;
 	base->dma_memcpy.device_free_chan_resources = d40_free_chan_resources;
 	base->dma_memcpy.device_prep_dma_memcpy = d40_prep_memcpy;
+	base->dma_slave.device_prep_dma_sg = d40_prep_sg;
 	base->dma_memcpy.device_prep_slave_sg = d40_prep_slave_sg;
 	base->dma_memcpy.device_tx_status = d40_tx_status;
 	base->dma_memcpy.device_issue_pending = d40_issue_pending;
@@ -2331,10 +2346,12 @@ static int __init d40_dmaengine_init(struct d40_base *base,
 	dma_cap_zero(base->dma_both.cap_mask);
 	dma_cap_set(DMA_SLAVE, base->dma_both.cap_mask);
 	dma_cap_set(DMA_MEMCPY, base->dma_both.cap_mask);
+	dma_cap_set(DMA_SG, base->dma_slave.cap_mask);
 
 	base->dma_both.device_alloc_chan_resources = d40_alloc_chan_resources;
 	base->dma_both.device_free_chan_resources = d40_free_chan_resources;
 	base->dma_both.device_prep_dma_memcpy = d40_prep_memcpy;
+	base->dma_slave.device_prep_dma_sg = d40_prep_sg;
 	base->dma_both.device_prep_slave_sg = d40_prep_slave_sg;
 	base->dma_both.device_tx_status = d40_tx_status;
 	base->dma_both.device_issue_pending = d40_issue_pending;
-- 
1.7.1
