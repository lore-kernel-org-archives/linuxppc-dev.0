Return-Path: <vinod.koul@intel.com>
Received: from mga03.intel.com (mga03.intel.com [143.182.124.21])
 by ozlabs.org (Postfix) with ESMTP id 3EC7C140308
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  3 May 2014 03:05:02 +1000 (EST)
Date: Fri, 2 May 2014 22:21:43 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: hongbo.zhang@freescale.com
Subject: Re: [PATCH v4 7/8] DMA: Freescale: use spin_lock_bh instead of
 spin_lock_irqsave
Message-ID: <20140502165143.GI32284@intel.com>
References: <1397809071-5353-1-git-send-email-hongbo.zhang@freescale.com>
 <1397809071-5353-8-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1397809071-5353-8-git-send-email-hongbo.zhang@freescale.com>
Cc: leo.li@freescale.com, vkoul@infradead.org, linux-kernel@vger.kernel.org,
 scottwood@freescale.com, dmaengine@vger.kernel.org, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Apr 18, 2014 at 04:17:50PM +0800, hongbo.zhang@freescale.com wrote:
> From: Hongbo Zhang <hongbo.zhang@freescale.com>
> 
> The usage of spin_lock_irqsave() is a stronger locking mechanism than is
> required throughout the driver. The minimum locking required should be used
> instead. Interrupts will be turned off and context will be saved, it is
> unnecessary to use irqsave.
> 
> This patch changes all instances of spin_lock_irqsave() to spin_lock_bh(). All
> manipulation of protected fields is done using tasklet context or weaker, which
> makes spin_lock_bh() the correct choice.
>

This doesnt apply, perhpas due to depends on 6/8

-- 
~Vinod
 
> Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
> Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
> ---
>  drivers/dma/fsldma.c |   25 ++++++++++---------------
>  1 file changed, 10 insertions(+), 15 deletions(-)
> 
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 374ca97..6e1c9b3 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -396,10 +396,9 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
>  	struct fsldma_chan *chan = to_fsl_chan(tx->chan);
>  	struct fsl_desc_sw *desc = tx_to_fsl_desc(tx);
>  	struct fsl_desc_sw *child;
> -	unsigned long flags;
>  	dma_cookie_t cookie = -EINVAL;
>  
> -	spin_lock_irqsave(&chan->desc_lock, flags);
> +	spin_lock_bh(&chan->desc_lock);
>  
>  	/*
>  	 * assign cookies to all of the software descriptors
> @@ -412,7 +411,7 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
>  	/* put this transaction onto the tail of the pending queue */
>  	append_ld_queue(chan, desc);
>  
> -	spin_unlock_irqrestore(&chan->desc_lock, flags);
> +	spin_unlock_bh(&chan->desc_lock);
>  
>  	return cookie;
>  }
> @@ -726,15 +725,14 @@ static void fsldma_free_desc_list_reverse(struct fsldma_chan *chan,
>  static void fsl_dma_free_chan_resources(struct dma_chan *dchan)
>  {
>  	struct fsldma_chan *chan = to_fsl_chan(dchan);
> -	unsigned long flags;
>  
>  	chan_dbg(chan, "free all channel resources\n");
> -	spin_lock_irqsave(&chan->desc_lock, flags);
> +	spin_lock_bh(&chan->desc_lock);
>  	fsldma_cleanup_descriptors(chan);
>  	fsldma_free_desc_list(chan, &chan->ld_pending);
>  	fsldma_free_desc_list(chan, &chan->ld_running);
>  	fsldma_free_desc_list(chan, &chan->ld_completed);
> -	spin_unlock_irqrestore(&chan->desc_lock, flags);
> +	spin_unlock_bh(&chan->desc_lock);
>  
>  	dma_pool_destroy(chan->desc_pool);
>  	chan->desc_pool = NULL;
> @@ -953,7 +951,6 @@ static int fsl_dma_device_control(struct dma_chan *dchan,
>  {
>  	struct dma_slave_config *config;
>  	struct fsldma_chan *chan;
> -	unsigned long flags;
>  	int size;
>  
>  	if (!dchan)
> @@ -963,7 +960,7 @@ static int fsl_dma_device_control(struct dma_chan *dchan,
>  
>  	switch (cmd) {
>  	case DMA_TERMINATE_ALL:
> -		spin_lock_irqsave(&chan->desc_lock, flags);
> +		spin_lock_bh(&chan->desc_lock);
>  
>  		/* Halt the DMA engine */
>  		dma_halt(chan);
> @@ -974,7 +971,7 @@ static int fsl_dma_device_control(struct dma_chan *dchan,
>  		fsldma_free_desc_list(chan, &chan->ld_completed);
>  		chan->idle = true;
>  
> -		spin_unlock_irqrestore(&chan->desc_lock, flags);
> +		spin_unlock_bh(&chan->desc_lock);
>  		return 0;
>  
>  	case DMA_SLAVE_CONFIG:
> @@ -1016,11 +1013,10 @@ static int fsl_dma_device_control(struct dma_chan *dchan,
>  static void fsl_dma_memcpy_issue_pending(struct dma_chan *dchan)
>  {
>  	struct fsldma_chan *chan = to_fsl_chan(dchan);
> -	unsigned long flags;
>  
> -	spin_lock_irqsave(&chan->desc_lock, flags);
> +	spin_lock_bh(&chan->desc_lock);
>  	fsl_chan_xfer_ld_queue(chan);
> -	spin_unlock_irqrestore(&chan->desc_lock, flags);
> +	spin_unlock_bh(&chan->desc_lock);
>  }
>  
>  /**
> @@ -1119,11 +1115,10 @@ static irqreturn_t fsldma_chan_irq(int irq, void *data)
>  static void dma_do_tasklet(unsigned long data)
>  {
>  	struct fsldma_chan *chan = (struct fsldma_chan *)data;
> -	unsigned long flags;
>  
>  	chan_dbg(chan, "tasklet entry\n");
>  
> -	spin_lock_irqsave(&chan->desc_lock, flags);
> +	spin_lock_bh(&chan->desc_lock);
>  
>  	/* the hardware is now idle and ready for more */
>  	chan->idle = true;
> @@ -1131,7 +1126,7 @@ static void dma_do_tasklet(unsigned long data)
>  	/* Run all cleanup for descriptors which have been completed */
>  	fsldma_cleanup_descriptors(chan);
>  
> -	spin_unlock_irqrestore(&chan->desc_lock, flags);
> +	spin_unlock_bh(&chan->desc_lock);
>  
>  	chan_dbg(chan, "tasklet exit\n");
>  }
> -- 
> 1.7.9.5
> 
> 
> 
> --
> To unsubscribe from this list: send the line "unsubscribe dmaengine" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html

-- 
