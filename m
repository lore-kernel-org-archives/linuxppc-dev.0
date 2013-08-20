Return-Path: <B07421@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe010.messaging.microsoft.com [216.32.180.30])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DE5CA2C00EE
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Aug 2013 10:21:23 +1000 (EST)
Message-ID: <1376958068.31636.385.camel@snotra.buserror.net>
Subject: Re: [PATCH] sata: fsl: save irqs while coalescing
From: Scott Wood <scottwood@freescale.com>
To: Anthony Foiani <anthony.foiani@gmail.com>
Date: Mon, 19 Aug 2013 19:21:08 -0500
In-Reply-To: <1376936128-1624-1-git-send-email-anthony.foiani@gmail.com>
References: <gsiy6olhp.fsf@dworkin.scrye.com>
 <1376936128-1624-1-git-send-email-anthony.foiani@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: Anthony Foiani <tkil@scrye.com>, linuxppc-dev@lists.ozlabs.org,
 Bhushan Bharat-R65777 <R65777@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-08-19 at 12:15 -0600, Anthony Foiani wrote:
> diff --git a/drivers/ata/sata_fsl.c b/drivers/ata/sata_fsl.c
> index 19720a0..851bd3f 100644
> --- a/drivers/ata/sata_fsl.c
> +++ b/drivers/ata/sata_fsl.c
> @@ -293,6 +293,7 @@ static void fsl_sata_set_irq_coalescing(struct ata_host *host,
>  {
>  	struct sata_fsl_host_priv *host_priv = host->private_data;
>  	void __iomem *hcr_base = host_priv->hcr_base;
> +	unsigned long flags;
>  
>  	if (count > ICC_MAX_INT_COUNT_THRESHOLD)
>  		count = ICC_MAX_INT_COUNT_THRESHOLD;
> @@ -305,12 +306,12 @@ static void fsl_sata_set_irq_coalescing(struct ata_host *host,
>  			(count > ICC_MIN_INT_COUNT_THRESHOLD))
>  		ticks = ICC_SAFE_INT_TICKS;
>  
> -	spin_lock(&host->lock);
> +	spin_lock_irqsave(&host->lock, flags);
>  	iowrite32((count << 24 | ticks), hcr_base + ICC);
>  
>  	intr_coalescing_count = count;
>  	intr_coalescing_ticks = ticks;
> -	spin_unlock(&host->lock);
> +	spin_unlock_irqrestore(&host->lock, flags);

This should go to the SATA list and maintainer.

-Scott
