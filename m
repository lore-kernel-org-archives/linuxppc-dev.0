Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id B6A0FB7140
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2011 06:53:54 +1100 (EST)
Date: Mon, 28 Feb 2011 11:53:50 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: [PATCH 0/8] fsldma: lockup fixes
Message-ID: <20110228195350.GA31428@ovro.caltech.edu>
References: <4D6BEDCE.3020102@embedded-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D6BEDCE.3020102@embedded-sol.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 28, 2011 at 08:47:42PM +0200, Felix Radensky wrote:
>     <br>
>     Hi Ira,<br>
>     <br>
>     Attached dmesg output.<br>
>     <br>
>     Felix.<br>
>     <br>
>     <pre>On Mon, Feb 28, 2011 at 01:36:38PM +0200, Felix Radensky wrote:

> &gt; Hi Ira,
> &gt; 
> &gt; I've tried your patches with linux-2.6.38-rc6 on P2020RDB.
> &gt; DMA test fails with the following errors if threads_per_chan != 1
> &gt; 
> &gt; dma0chan0-copy1: terminating after 1 tests, 1 failures (status 0)
> &gt; dma0chan0-copy2: #0: test timed out
> &gt; 
> &gt; I've run the test like this:
> &gt; 
> &gt; modprobe dmatest threads_per_chan=2 iterations=1
> &gt; 
> 
> Thanks Felix. This works fine on the 83xx DMA controller. When you have
> a chance, can you add "#define DEBUG 1" as the first line of
> drivers/dma/fsldma.c and then rerun your test with:
> 
> modprobe dmatest threads_per_chan=2 iterations=1 max_channels=1
> 
> And send me the dmesg output.
> 
> I don't quite understand the difference between links and lists in the
> 85xx controller yet. I'll work my way through the datasheet this morning
> and send out a fixed patch.
> 
> Thanks very much for running the tests!
> 
> Ira

[ snip most of dmesg output ]

> Freeing unused kernel memory: 136k init
> __dma_request_channel: success (dma0chan0)
> of:fsl-elo-dma ffe0c300.dma: chan0: idle, starting controller
> dmatest: Started 2 threads using dma0chan0
> of:fsl-elo-dma ffe0c300.dma: chan0: irq: stat = 0x8
> of:fsl-elo-dma ffe0c300.dma: chan0: irq: End-of-link INT
> of:fsl-elo-dma ffe0c300.dma: chan0: irq: Exit
> of:fsl-elo-dma ffe0c300.dma: chan0: tasklet entry
> of:fsl-elo-dma ffe0c300.dma: chan0: completed_cookie=1
> of:fsl-elo-dma ffe0c300.dma: chan0: no pending LDs
> of:fsl-elo-dma ffe0c300.dma: chan0: tasklet exit
> dma0chan0-copy0: verifying source buffer...
> dma0chan0-copy0: verifying dest buffer...
> dma0chan0-copy0: #0: No errors with src_off=0x3a2 dst_off=0xc1e len=0x2ce5
> dma0chan0-copy0: terminating after 1 tests, 0 failures (status 0)
> of:fsl-elo-dma ffe0c300.dma: chan0: idle, starting controller
> dma0chan0-copy1: #0: test timed out
> dma0chan0-copy1: terminating after 1 tests, 1 failures (status 0)

Thank you very much Felix. The dmesg output shows that the controller
never got an interrupt for the second transaction. The patch below has
extra debugging information that may help determine why this happens.
Please apply it and re-run the test.

The last section of dmesg (after "Freeing unused kernel memory") is all
I need.

Thanks again,
Ira


>From 8935444cb18c921332ebe1d055531e54f0c100e9 Mon Sep 17 00:00:00 2001
From: Ira W. Snyder <iws@ovro.caltech.edu>
Date: Mon, 28 Feb 2011 11:33:17 -0800
Subject: [PATCH] fsldma: try and debug 85xx controller

1 - reduce the maximum transfer size to 1000 bytes to force chains
2 - re-enable end-of-segment interrupts to see what the hardware does
3 - enable end-of-list interrupts to see what the hardware does
4 - debug cookies (this shouldn't be a problem, but just in case)

NOT AT ALL Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/dma/fsldma.c |   16 ++++++++++++++++
 drivers/dma/fsldma.h |    3 ++-
 2 files changed, 18 insertions(+), 1 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index 3dc27a9..b82b76e 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -24,6 +24,9 @@
  *
  */
 
+#define DEBUG 1
+#define FSL_DMA_LD_DEBUG 1
+
 #include <linux/init.h>
 #include <linux/module.h>
 #include <linux/pci.h>
@@ -162,6 +165,7 @@ static void dma_init(struct fsldma_chan *chan)
 		 * BWC - Bandwidth sharing among channels
 		 */
 		DMA_OUT(chan, &chan->regs->mr, FSL_DMA_MR_BWC
+				| FSL_DMA_MR_EOSIE | FSL_DMA_MR_EOLSIE
 				| FSL_DMA_MR_EIE | FSL_DMA_MR_EOLNIE, 32);
 		break;
 	case FSL_DMA_IP_83XX:
@@ -389,6 +393,7 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 	 * that make up this transaction
 	 */
 	cookie = chan->common.cookie;
+	dev_dbg(chan->dev, "%s: assign cookies: start=%d\n", chan->name, cookie);
 	list_for_each_entry(child, &desc->tx_list, node) {
 		cookie++;
 		if (cookie < DMA_MIN_COOKIE)
@@ -397,6 +402,7 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
 		child->async_tx.cookie = cookie;
 	}
 
+	dev_dbg(chan->dev, "%s: assign cookies: end=%d\n", chan->name, cookie);
 	chan->common.cookie = cookie;
 
 	/* put this transaction onto the tail of the pending queue */
@@ -1018,6 +1024,16 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
 		stat &= ~FSL_DMA_SR_EOLNI;
 	}
 
+	if (stat & FSL_DMA_SR_EOLSI) {
+		dev_dbg(chan->dev, "%s: irq: End-of-list INT\n", name);
+		stat &= ~FSL_DMA_SR_EOLSI;
+	}
+
+	if (stat & FSL_DMA_SR_EOSI) {
+		dev_dbg(chan->dev, "%s: irq: End-of-segment INT\n", name);
+		stat &= ~FSL_DMA_SR_EOSI;
+	}
+
 	/* check that the DMA controller is really idle */
 	if (!dma_is_idle(chan))
 		dev_err(chan->dev, "%s: irq: controller not idle!\n", name);
diff --git a/drivers/dma/fsldma.h b/drivers/dma/fsldma.h
index 9cb5aa5..322aa0c 100644
--- a/drivers/dma/fsldma.h
+++ b/drivers/dma/fsldma.h
@@ -73,7 +73,8 @@
 #define FSL_DMA_EOSIE		0x8
 #define FSL_DMA_NLDA_MASK	(~(u64)0x1f)
 
-#define FSL_DMA_BCR_MAX_CNT	0x03ffffffu
+//#define FSL_DMA_BCR_MAX_CNT	0x03ffffffu
+#define FSL_DMA_BCR_MAX_CNT	1000
 
 #define FSL_DMA_DGSR_TE		0x80
 #define FSL_DMA_DGSR_CH		0x20
-- 
1.7.3.4
