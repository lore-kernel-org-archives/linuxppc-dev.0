Return-Path: <iws@ovro.caltech.edu>
Received: from ovro.ovro.caltech.edu (ovro.ovro.caltech.edu [192.100.16.2])
 by ozlabs.org (Postfix) with ESMTP id 82BB92C0204
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 12 Jul 2012 02:17:18 +1000 (EST)
Date: Wed, 11 Jul 2012 09:17:13 -0700
From: "Ira W. Snyder" <iws@ovro.caltech.edu>
To: Qiang Liu <qiang.liu@freescale.com>
Subject: Re: [PATCH v2 2/4] fsl-dma: remove attribute DMA_INTERRUPT of
 dmaengine
Message-ID: <20120711161713.GC17539@ovro.caltech.edu>
References: <1341997253-18424-1-git-send-email-qiang.liu@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1341997253-18424-1-git-send-email-qiang.liu@freescale.com>
Cc: Vinod Koul <vinod.koul@intel.com>, herbert@gondor.hengli.com.au,
 linux-crypto@vger.kernel.org, Dan Williams <dan.j.williams@intel.com>,
 linuxppc-dev@lists.ozlabs.org, davem@davemloft.net
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Jul 11, 2012 at 05:00:53PM +0800, Qiang Liu wrote:
> Delete attribute DMA_INTERRUPT because fsl-dma doesn't support this function,
> exception will be thrown if talitos is used to offload xor at the same time.
> 

Both drivers/misc/carma/carma-fpga.c and
drivers/misc/carma/carma-fpga-program.c expect the DMA_INTERRUPT
property, though they do not use it. The mask is set for historical
reasons. It is safe to delete the line "dma_cap_set(DMA_INTERRUPT, mask);"
from both drivers.

I don't know which other drivers may expect this feature to be present.
These are only the ones which I maintain.

Other than that, you can add my:
Acked-by: Ira W. Snyder <iws@ovro.caltech.edu>

> Cc: Dan Williams <dan.j.williams@intel.com>
> Cc: Vinod Koul <vinod.koul@intel.com>
> Cc: Li Yang <leoli@freescale.com>
> Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
> ---
>  drivers/dma/fsldma.c |   31 -------------------------------
>  1 files changed, 0 insertions(+), 31 deletions(-)
> 
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 8f84761..4f2f212 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -543,35 +543,6 @@ static void fsl_dma_free_chan_resources(struct dma_chan *dchan)
>  }
> 
>  static struct dma_async_tx_descriptor *
> -fsl_dma_prep_interrupt(struct dma_chan *dchan, unsigned long flags)
> -{
> -	struct fsldma_chan *chan;
> -	struct fsl_desc_sw *new;
> -
> -	if (!dchan)
> -		return NULL;
> -
> -	chan = to_fsl_chan(dchan);
> -
> -	new = fsl_dma_alloc_descriptor(chan);
> -	if (!new) {
> -		chan_err(chan, "%s\n", msg_ld_oom);
> -		return NULL;
> -	}
> -
> -	new->async_tx.cookie = -EBUSY;
> -	new->async_tx.flags = flags;
> -
> -	/* Insert the link descriptor to the LD ring */
> -	list_add_tail(&new->node, &new->tx_list);
> -
> -	/* Set End-of-link to the last link descriptor of new list */
> -	set_ld_eol(chan, new);
> -
> -	return &new->async_tx;
> -}
> -
> -static struct dma_async_tx_descriptor *
>  fsl_dma_prep_memcpy(struct dma_chan *dchan,
>  	dma_addr_t dma_dst, dma_addr_t dma_src,
>  	size_t len, unsigned long flags)
> @@ -1352,12 +1323,10 @@ static int __devinit fsldma_of_probe(struct platform_device *op)
>  	fdev->irq = irq_of_parse_and_map(op->dev.of_node, 0);
> 
>  	dma_cap_set(DMA_MEMCPY, fdev->common.cap_mask);
> -	dma_cap_set(DMA_INTERRUPT, fdev->common.cap_mask);
>  	dma_cap_set(DMA_SG, fdev->common.cap_mask);
>  	dma_cap_set(DMA_SLAVE, fdev->common.cap_mask);
>  	fdev->common.device_alloc_chan_resources = fsl_dma_alloc_chan_resources;
>  	fdev->common.device_free_chan_resources = fsl_dma_free_chan_resources;
> -	fdev->common.device_prep_dma_interrupt = fsl_dma_prep_interrupt;
>  	fdev->common.device_prep_dma_memcpy = fsl_dma_prep_memcpy;
>  	fdev->common.device_prep_dma_sg = fsl_dma_prep_sg;
>  	fdev->common.device_tx_status = fsl_tx_status;
> --
> 1.7.5.1
> 
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
