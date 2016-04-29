Return-Path: <Julia.Lawall@lip6.fr>
Received: from mail3-relais-sop.national.inria.fr
 (mail3-relais-sop.national.inria.fr [192.134.164.104])
 (using TLSv1.2 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxQSl3LXYzDqB2
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 30 Apr 2016 06:35:51 +1000 (AEST)
From: Julia Lawall <Julia.Lawall@lip6.fr>
To: Li Yang <leoli@freescale.com>
Cc: kernel-janitors@vger.kernel.org, Zhang Wei <zw@zh-kernel.org>,
 Vinod Koul <vinod.koul@intel.com>, Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev@lists.ozlabs.org, dmaengine@vger.kernel.org,
 linux-kernel@vger.kernel.org
Subject: [PATCH 5/5] dmaengine: fsldma: Use dma_pool_zalloc
Date: Fri, 29 Apr 2016 22:09:12 +0200
Message-Id: <1461960552-7429-6-git-send-email-Julia.Lawall@lip6.fr>
In-Reply-To: <1461960552-7429-1-git-send-email-Julia.Lawall@lip6.fr>
References: <1461960552-7429-1-git-send-email-Julia.Lawall@lip6.fr>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dma_pool_zalloc combines dma_pool_alloc and memset 0.  The semantic patch
that makes this transformation is as follows: (http://coccinelle.lip6.fr/)

// <smpl>
@@
expression d,e;
statement S;
@@

        d =
-            dma_pool_alloc
+            dma_pool_zalloc
             (...);
        if (!d) S
-       memset(d, 0, sizeof(*d));
// </smpl>

Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

---
 drivers/dma/fsldma.c |    3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index aac85c3..a8828ed 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -462,13 +462,12 @@ static struct fsl_desc_sw *fsl_dma_alloc_descriptor(struct fsldma_chan *chan)
 	struct fsl_desc_sw *desc;
 	dma_addr_t pdesc;
 
-	desc = dma_pool_alloc(chan->desc_pool, GFP_ATOMIC, &pdesc);
+	desc = dma_pool_zalloc(chan->desc_pool, GFP_ATOMIC, &pdesc);
 	if (!desc) {
 		chan_dbg(chan, "out of memory for link descriptor\n");
 		return NULL;
 	}
 
-	memset(desc, 0, sizeof(*desc));
 	INIT_LIST_HEAD(&desc->tx_list);
 	dma_async_tx_descriptor_init(&desc->async_tx, &chan->common);
 	desc->async_tx.tx_submit = fsl_dma_tx_submit;
