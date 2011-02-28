Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
	by ozlabs.org (Postfix) with ESMTP id 0B661B716B
	for <linuxppc-dev@ozlabs.org>; Tue,  1 Mar 2011 08:11:07 +1100 (EST)
Date: Mon, 28 Feb 2011 13:11:04 -0800
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Felix Radensky <felix@embedded-sol.com>
Subject: Re: [PATCH 0/8] fsldma: lockup fixes
Message-ID: <20110228211103.GB31428@ovro.caltech.edu>
References: <4D6BEDCE.3020102@embedded-sol.com>
	<20110228195350.GA31428@ovro.caltech.edu>
	<4D6C0275.6000807@embedded-sol.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <4D6C0275.6000807@embedded-sol.com>
Cc: "linuxppc-dev@ozlabs.org" <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 28, 2011 at 10:15:49PM +0200, Felix Radensky wrote:
> Hi Ira,
> 
> > Thank you very much Felix. The dmesg output shows that the controller
> > never got an interrupt for the second transaction. The patch below has
> > extra debugging information that may help determine why this happens.
> > Please apply it and re-run the test.
> >
> > The last section of dmesg (after "Freeing unused kernel memory") is all
> > I need.
> >
> 
> Attached relevant dmesg portion.
> 

Ok, try this patch on top of the last one.

It looks like you used the dmatest module in multi-channel mode last
time. One channel makes it easier to debug:

modprobe dmatest max_channels=1 threads_per_chan=2 iterations=1

Thanks for your help in debugging this. Hopefully this is the last
patch to test. :)

Ira


>From 58bc23c3b68f8db0aa09434fdeb6aef641a5eadd Mon Sep 17 00:00:00 2001
From: Ira W. Snyder <iws@ovro.caltech.edu>
Date: Mon, 28 Feb 2011 12:55:55 -0800
Subject: [PATCH] fsldma: enable end-of-segments interrupt on last descriptor

This is a hack to manually set the end-of-segments interrupt on the last
descriptor in each chain. It appears that the P2020RDB controller
doesn't generate the end-of-links interrupt as explained in the
datasheet.

Signed-off-by: Ira W. Snyder <iws@ovro.caltech.edu>
---
 drivers/dma/fsldma.c |    3 +--
 1 files changed, 1 insertions(+), 2 deletions(-)

diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
index b82b76e..e4d9d17 100644
--- a/drivers/dma/fsldma.c
+++ b/drivers/dma/fsldma.c
@@ -141,7 +141,7 @@ static void set_ld_eol(struct fsldma_chan *chan, struct fsl_desc_sw *desc)
 	u64 snoop_bits;
 
 	snoop_bits = ((chan->feature & FSL_DMA_IP_MASK) == FSL_DMA_IP_83XX)
-		? FSL_DMA_SNEN : 0;
+		? FSL_DMA_SNEN : (u64)(0x8);
 
 	desc->hw.next_ln_addr = CPU_TO_DMA(chan,
 		DMA_TO_CPU(chan, desc->hw.next_ln_addr, 64) | FSL_DMA_EOL
@@ -165,7 +165,6 @@ static void dma_init(struct fsldma_chan *chan)
 		 * BWC - Bandwidth sharing among channels
 		 */
 		DMA_OUT(chan, &chan->regs->mr, FSL_DMA_MR_BWC
-				| FSL_DMA_MR_EOSIE | FSL_DMA_MR_EOLSIE
 				| FSL_DMA_MR_EIE | FSL_DMA_MR_EOLNIE, 32);
 		break;
 	case FSL_DMA_IP_83XX:
-- 
1.7.3.4
