Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f67.google.com (mail-pw0-f67.google.com
	[209.85.160.67]) by ozlabs.org (Postfix) with ESMTP id 58D2E100ED4
	for <linuxppc-dev@lists.ozlabs.org>;
	Thu, 30 Dec 2010 16:36:11 +1100 (EST)
Received: by mail-pw0-f67.google.com with SMTP id 3so1270441pwi.2
	for <linuxppc-dev@lists.ozlabs.org>;
	Wed, 29 Dec 2010 21:36:11 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 29 Dec 2010 22:36:08 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Ilya Yanok <yanok@emcraft.com>
Subject: Re: [PATCH 2/6] mpc512x_dma: fix the hanged transfer issue
Message-ID: <20101230053607.GE27954@angua.secretlab.ca>
References: <1285676696-5358-1-git-send-email-yanok@emcraft.com>
	<1288137180-3220-3-git-send-email-yanok@emcraft.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1288137180-3220-3-git-send-email-yanok@emcraft.com>
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

On Wed, Oct 27, 2010 at 01:52:56AM +0200, Ilya Yanok wrote:
> Current code clears interrupt active status _after_ submiting new
> transfers. This leaves a possibility of clearing the interrupt for this
> new transfer (if it is triggered fast enough) and thus lose this
> interrupt. We want to clear interrupt active status _before_ new
> transfers is submited and for current channel only.
> 
> Signed-off-by: Ilya Yanok <yanok@emcraft.com>
> Cc: Piotr Ziecik <kosmo@semihalf.com>

Merged for -next, thanks.

g.

> ---
>  drivers/dma/mpc512x_dma.c |    9 +++------
>  1 files changed, 3 insertions(+), 6 deletions(-)
> 
> diff --git a/drivers/dma/mpc512x_dma.c b/drivers/dma/mpc512x_dma.c
> index 1bc04aa..0717527 100644
> --- a/drivers/dma/mpc512x_dma.c
> +++ b/drivers/dma/mpc512x_dma.c
> @@ -276,6 +276,9 @@ static void mpc_dma_irq_process(struct mpc_dma *mdma, u32 is, u32 es, int off)
>  
>  		spin_lock(&mchan->lock);
>  
> +		out_8(&mdma->regs->dmacint, ch + off);
> +		out_8(&mdma->regs->dmacerr, ch + off);
> +
>  		/* Check error status */
>  		if (es & (1 << ch))
>  			list_for_each_entry(mdesc, &mchan->active, node)
> @@ -309,12 +312,6 @@ static irqreturn_t mpc_dma_irq(int irq, void *data)
>  	mpc_dma_irq_process(mdma, in_be32(&mdma->regs->dmaintl),
>  					in_be32(&mdma->regs->dmaerrl), 0);
>  
> -	/* Ack interrupt on all channels */
> -	out_be32(&mdma->regs->dmainth, 0xFFFFFFFF);
> -	out_be32(&mdma->regs->dmaintl, 0xFFFFFFFF);
> -	out_be32(&mdma->regs->dmaerrh, 0xFFFFFFFF);
> -	out_be32(&mdma->regs->dmaerrl, 0xFFFFFFFF);
> -
>  	/* Schedule tasklet */
>  	tasklet_schedule(&mdma->tasklet);
>  
> -- 
> 1.7.2.3
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
