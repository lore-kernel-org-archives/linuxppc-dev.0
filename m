Return-Path: <gsi@denx.de>
From: Gerhard Sittig <gsi@denx.de>
To: linuxppc-dev@lists.ozlabs.org, devicetree-discuss@lists.ozlabs.org,
 Alexander Popov <a13xp0p0v88@gmail.com>
Subject: [PATCH RFC 3/8] dma: mpc512x: support 'terminate all' control request
Date: Fri, 12 Jul 2013 17:26:16 +0200
Message-Id: <1373642781-32631-4-git-send-email-gsi@denx.de>
In-Reply-To: <1373642781-32631-1-git-send-email-gsi@denx.de>
References: <1373642781-32631-1-git-send-email-gsi@denx.de>
Cc: Lars-Peter Clausen <lars@metafoo.de>, Arnd Bergmann <arnd@arndb.de>,
 Vinod Koul <vinod.koul@intel.com>, Gerhard Sittig <gsi@denx.de>,
 Dan Williams <djbw@fb.com>, Anatolij Gustschin <agust@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

implement the TERMINATE_ALL request in the device_control() callback
of the DMA engine driver for the MPC512x DMA controller

reword variable initialization to better follow the code path and to
avoid artificial diffs later on (this style change vanishes when this
patch gets squashed with the device_control() routine's introduction)

Signed-off-by: Gerhard Sittig <gsi@denx.de>
---
 drivers/dma/mpc512x_dma.c |   15 +++++++++++++--
 1 file changed, 13 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
index df10a48..0053ff8 100644
--- a/drivers/dma/mpc512x_dma.c
+++ b/drivers/dma/mpc512x_dma.c
@@ -748,11 +748,22 @@ static struct dma_async_tx_descriptor *mpc_dma_prep_slave_sg(
 static int mpc_dma_device_control(struct dma_chan *chan, enum dma_ctrl_cmd cmd,
 				  unsigned long arg)
 {
-	struct mpc_dma_chan *mchan = dma_chan_to_mpc_dma_chan(chan);
-	struct dma_slave_config *cfg = (void *)arg;
+	struct mpc_dma_chan *mchan;
+	struct mpc_dma *mdma;
+	struct dma_slave_config *cfg;
 
+	mchan = dma_chan_to_mpc_dma_chan(chan);
 	switch (cmd) {
+	case DMA_TERMINATE_ALL:
+		/* disable channel requests */
+		mdma = dma_chan_to_mpc_dma(chan);
+		out_8(&mdma->regs->dmacerq, chan->chan_id);
+		list_splice_tail_init(&mchan->prepared, &mchan->free);
+		list_splice_tail_init(&mchan->queued, &mchan->free);
+		list_splice_tail_init(&mchan->active, &mchan->free);
+		return 0;
 	case DMA_SLAVE_CONFIG:
+		cfg = (void *)arg;
 		if (cfg->src_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES &&
 		    cfg->dst_addr_width != DMA_SLAVE_BUSWIDTH_4_BYTES)
 			return -EINVAL;
-- 
1.7.10.4
