Return-Path: <glikely@secretlab.ca>
Received: from mail-px0-f195.google.com (mail-px0-f195.google.com
	[209.85.212.195]) by ozlabs.org (Postfix) with ESMTP id B785B1010C2
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Dec 2010 16:36:17 +1100 (EST)
Received: by pxi3 with SMTP id 3so2067076pxi.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Dec 2010 21:36:16 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 29 Dec 2010 22:36:14 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH 4/6] mpc512x_dma: try to free descriptors in case of
	allocation failure
Message-ID: <20101230053614.GF27954@angua.secretlab.ca>
References: <1285676696-5358-1-git-send-email-yanok@emcraft.com>
	<1288137180-3220-5-git-send-email-yanok@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288137180-3220-5-git-send-email-yanok@emcraft.com>
Cc: vlad@emcraft.com, linuxppc-dev@lists.ozlabs.org, wd@denx.de, dzu@denx.de,
	Piotr Ziecik <kosmo@semihalf.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 27, 2010 at 01:52:58AM +0200, Ilya Yanok wrote:
> Currently completed descriptors are processed in the tasklet. This can
> lead to dead lock in case of CONFIG_NET_DMA enabled (new requests are
> submitted from softirq context and dma_memcpy_to_iovec() busy loops until
> the requests is submitted). To prevent this we should process completed
> descriptors from the allocation failure path in prepare_memcpy too.
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> Cc: Piotr Ziecik <kosmo@semihalf.com>

Merged for -next, thanks.

g.

> ---
>  drivers/dma/mpc512x_dma.c |   79 +++++++++++++++++++++++++-------------------
>  1 files changed, 45 insertions(+), 34 deletions(-)
> 
> diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
> index 97b92ec..59c2701 100644
> --- a/drivers/dma/mpc512x_dma.c
> +++ b/drivers/dma/mpc512x_dma.c
> @@ -328,19 +328,55 @@ static irqreturn_t mpc_dma_irq(int irq, void *data)
>  	return IRQ_HANDLED;
>  }
>  
> -/* DMA Tasklet */
> -static void mpc_dma_tasklet(unsigned long data)
> +/* proccess completed descriptors */
> +static void mpc_dma_process_completed(struct mpc_dma *mdma)
>  {
> -	struct mpc_dma *mdma = (void *)data;
>  	dma_cookie_t last_cookie = 0;
>  	struct mpc_dma_chan *mchan;
>  	struct mpc_dma_desc *mdesc;
>  	struct dma_async_tx_descriptor *desc;
>  	unsigned long flags;
>  	LIST_HEAD(list);
> -	uint es;
>  	int i;
>  
> +	for (i = 0; i < mdma->dma.chancnt; i++) {
> +		mchan = &mdma->channels[i];
> +
> +		/* Get all completed descriptors */
> +		spin_lock_irqsave(&mchan->lock, flags);
> +		if (!list_empty(&mchan->completed))
> +			list_splice_tail_init(&mchan->completed, &list);
> +		spin_unlock_irqrestore(&mchan->lock, flags);
> +
> +		if (list_empty(&list))
> +			continue;
> +
> +		/* Execute callbacks and run dependencies */
> +		list_for_each_entry(mdesc, &list, node) {
> +			desc = &mdesc->desc;
> +
> +			if (desc->callback)
> +				desc->callback(desc->callback_param);
> +
> +			last_cookie = desc->cookie;
> +			dma_run_dependencies(desc);
> +		}
> +
> +		/* Free descriptors */
> +		spin_lock_irqsave(&mchan->lock, flags);
> +		list_splice_tail_init(&list, &mchan->free);
> +		mchan->completed_cookie = last_cookie;
> +		spin_unlock_irqrestore(&mchan->lock, flags);
> +	}
> +}
> +
> +/* DMA Tasklet */
> +static void mpc_dma_tasklet(unsigned long data)
> +{
> +	struct mpc_dma *mdma = (void *)data;
> +	unsigned long flags;
> +	uint es;
> +
>  	spin_lock_irqsave(&mdma->error_status_lock, flags);
>  	es = mdma->error_status;
>  	mdma->error_status = 0;
> @@ -379,35 +415,7 @@ static void mpc_dma_tasklet(unsigned long data)
>  			dev_err(mdma->dma.dev, "- Destination Bus Error\n");
>  	}
>  
> -	for (i = 0; i < mdma->dma.chancnt; i++) {
> -		mchan = &mdma->channels[i];
> -
> -		/* Get all completed descriptors */
> -		spin_lock_irqsave(&mchan->lock, flags);
> -		if (!list_empty(&mchan->completed))
> -			list_splice_tail_init(&mchan->completed, &list);
> -		spin_unlock_irqrestore(&mchan->lock, flags);
> -
> -		if (list_empty(&list))
> -			continue;
> -
> -		/* Execute callbacks and run dependencies */
> -		list_for_each_entry(mdesc, &list, node) {
> -			desc = &mdesc->desc;
> -
> -			if (desc->callback)
> -				desc->callback(desc->callback_param);
> -
> -			last_cookie = desc->cookie;
> -			dma_run_dependencies(desc);
> -		}
> -
> -		/* Free descriptors */
> -		spin_lock_irqsave(&mchan->lock, flags);
> -		list_splice_tail_init(&list, &mchan->free);
> -		mchan->completed_cookie = last_cookie;
> -		spin_unlock_irqrestore(&mchan->lock, flags);
> -	}
> +	mpc_dma_process_completed(mdma);
>  }
>  
>  /* Submit descriptor to hardware */
> @@ -587,8 +595,11 @@ mpc_dma_prep_memcpy(struct dma_chan *chan, dma_addr_t dst, dma_addr_t src,
>  	}
>  	spin_unlock_irqrestore(&mchan->lock, iflags);
>  
> -	if (!mdesc)
> +	if (!mdesc) {
> +		/* try to free completed descriptors */
> +		mpc_dma_process_completed(mdma);
>  		return NULL;
> +	}
>  
>  	mdesc->error = 0;
>  	tcd = mdesc->tcd;
> -- 
> 1.7.2.3
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
