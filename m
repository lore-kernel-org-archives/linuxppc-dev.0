Return-Path: <vinod.koul@intel.com>
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
 by ozlabs.org (Postfix) with ESMTP id 49C502C00A0
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Mar 2014 22:11:01 +1100 (EST)
Date: Tue, 11 Mar 2014 16:36:16 +0530
From: Vinod Koul <vinod.koul@intel.com>
To: hongbo.zhang@freescale.com
Subject: Re: [PATCH 3/7] DMA: Freescale: add fsl_dma_free_descriptor() to
 reduce code duplication
Message-ID: <20140311110616.GV1976@intel.com>
References: <1389851246-8564-1-git-send-email-hongbo.zhang@freescale.com>
 <1389851246-8564-4-git-send-email-hongbo.zhang@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1389851246-8564-4-git-send-email-hongbo.zhang@freescale.com>
Cc: linux-kernel@vger.kernel.org, scottwood@freescale.com,
 dmaengine@vger.kernel.org, dan.j.williams@intel.com,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Jan 16, 2014 at 01:47:22PM +0800, hongbo.zhang@freescale.com wrote:
> From: Hongbo Zhang <hongbo.zhang@freescale.com>
> 
> There are several places where descriptors are freed using identical code.
> This patch puts this code into a function to reduce code duplication.
> 
> Signed-off-by: Hongbo Zhang <hongbo.zhang@freescale.com>
> Signed-off-by: Qiang Liu <qiang.liu@freescale.com>
> ---
>  drivers/dma/fsldma.c |   38 ++++++++++++++++++++------------------
>  1 file changed, 20 insertions(+), 18 deletions(-)
> 
> diff --git a/drivers/dma/fsldma.c b/drivers/dma/fsldma.c
> index 95236e6..ad73538 100644
> --- a/drivers/dma/fsldma.c
> +++ b/drivers/dma/fsldma.c
> @@ -418,6 +418,21 @@ static dma_cookie_t fsl_dma_tx_submit(struct dma_async_tx_descriptor *tx)
>  }
>  
>  /**
> + * fsl_dma_free_descriptor - Free descriptor from channel's DMA pool.
> + * @chan : Freescale DMA channel
> + * @desc: descriptor to be freed
> + */
> +static void fsl_dma_free_descriptor(struct fsldma_chan *chan,
> +		struct fsl_desc_sw *desc)
> +{
> +	list_del(&desc->node);
> +#ifdef FSL_DMA_LD_DEBUG
> +	chan_dbg(chan, "LD %p free\n", desc);
> +#endif
why not wrap the define stuff in the defination of chan_dbg rather than its
usage :(

-- 
~Vinod

> +	dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
> +}
> +
> +/**
>   * fsl_dma_alloc_descriptor - Allocate descriptor from channel's DMA pool.
>   * @chan : Freescale DMA channel
>   *
> @@ -491,13 +506,8 @@ static void fsldma_free_desc_list(struct fsldma_chan *chan,
>  {
>  	struct fsl_desc_sw *desc, *_desc;
>  
> -	list_for_each_entry_safe(desc, _desc, list, node) {
> -		list_del(&desc->node);
> -#ifdef FSL_DMA_LD_DEBUG
> -		chan_dbg(chan, "LD %p free\n", desc);
> -#endif
> -		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
> -	}
> +	list_for_each_entry_safe(desc, _desc, list, node)
> +		fsl_dma_free_descriptor(chan, desc);
>  }
>  
>  static void fsldma_free_desc_list_reverse(struct fsldma_chan *chan,
> @@ -505,13 +515,8 @@ static void fsldma_free_desc_list_reverse(struct fsldma_chan *chan,
>  {
>  	struct fsl_desc_sw *desc, *_desc;
>  
> -	list_for_each_entry_safe_reverse(desc, _desc, list, node) {
> -		list_del(&desc->node);
> -#ifdef FSL_DMA_LD_DEBUG
> -		chan_dbg(chan, "LD %p free\n", desc);
> -#endif
> -		dma_pool_free(chan->desc_pool, desc, desc->async_tx.phys);
> -	}
> +	list_for_each_entry_safe_reverse(desc, _desc, list, node)
> +		fsl_dma_free_descriptor(chan, desc);
>  }
>  
>  /**
> @@ -827,10 +832,7 @@ static void fsldma_cleanup_descriptor(struct fsldma_chan *chan,
>  	dma_run_dependencies(txd);
>  
>  	dma_descriptor_unmap(txd);
> -#ifdef FSL_DMA_LD_DEBUG
> -	chan_dbg(chan, "LD %p free\n", desc);
> -#endif
> -	dma_pool_free(chan->desc_pool, desc, txd->phys);
> +	fsl_dma_free_descriptor(chan, desc);
>  }
>  
>  /**
> -- 
> 1.7.9.5
> 
> 
> 

-- 
