Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 1610EDE301
	for <linuxppc-dev@ozlabs.org>; Sat, 10 Jan 2009 08:10:07 +1100 (EST)
Subject: Re: mal_probe crash
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
In-Reply-To: <200901091549.56943.matthias.fuchs@esd-electronics.com>
References: <20090107154434.0c9437ef@lappy.seanm.ca>
	<20090108204634.GB2337@yoda.jdub.homelinux.org>
	<1231368610.2142.27.camel@pasglop>
	<200901091549.56943.matthias.fuchs@esd-electronics.com>
Content-Type: text/plain
Date: Sat, 10 Jan 2009 08:09:40 +1100
Message-Id: <1231535380.2142.68.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Sean MacLennan <smaclennan@pikatech.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


> Could it be that simple. Probably not. It works at a first glace on
> a 405EP ang GPr board. But it might cause problems when having more than 
> one EMAC up at the same time.

I talked with the network folks and that should be ok.

We only need to be a bit careful in case for some reason the EMAC we
linked to NAPI get removed/destroyed... We only do all at once for now
but heh..

Ben.

> Matthias
> 
> [PATCH] powerpc: Fix ibm_newemac driver
> 
> Since commit d565b0a1a9b6ee7d netif_napi_add must be called
> if a proper net_device pointer != NULL.
> 
> Signed-off-by: Matthias Fuchs <matthias.fuchs@esd-electronics.com>
> ---
>  drivers/net/ibm_newemac/core.c |    3 +++
>  drivers/net/ibm_newemac/mal.c  |    5 +----
>  drivers/net/ibm_newemac/mal.h  |    1 +
>  3 files changed, 5 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ibm_newemac/core.c b/drivers/net/ibm_newemac/core.c
> index 87a7066..9bd4d6d 100644
> --- a/drivers/net/ibm_newemac/core.c
> +++ b/drivers/net/ibm_newemac/core.c
> @@ -2767,6 +2767,9 @@ static int __devinit emac_probe(struct of_device *ofdev,
>  	if (dev->mdio_dev != NULL)
>  		dev->mdio_instance = dev_get_drvdata(&dev->mdio_dev->dev);
>  
> +	netif_napi_add(ndev, &dev->mal->napi, mal_poll,
> +		       CONFIG_IBM_NEW_EMAC_POLL_WEIGHT);
> +
>  	/* Register with MAL */
>  	dev->commac.ops = &emac_commac_ops;
>  	dev->commac.dev = dev;
> diff --git a/drivers/net/ibm_newemac/mal.c b/drivers/net/ibm_newemac/mal.c
> index ecf9798..d5306ae 100644
> --- a/drivers/net/ibm_newemac/mal.c
> +++ b/drivers/net/ibm_newemac/mal.c
> @@ -391,7 +391,7 @@ void mal_poll_enable(struct mal_instance *mal, struct mal_commac *commac)
>  	napi_schedule(&mal->napi);
>  }
>  
> -static int mal_poll(struct napi_struct *napi, int budget)
> +int mal_poll(struct napi_struct *napi, int budget)
>  {
>  	struct mal_instance *mal = container_of(napi, struct mal_instance, napi);
>  	struct list_head *l;
> @@ -613,9 +613,6 @@ static int __devinit mal_probe(struct of_device *ofdev,
>  	INIT_LIST_HEAD(&mal->list);
>  	spin_lock_init(&mal->lock);
>  
> -	netif_napi_add(NULL, &mal->napi, mal_poll,
> -		       CONFIG_IBM_NEW_EMAC_POLL_WEIGHT);
> -
>  	/* Load power-on reset defaults */
>  	mal_reset(mal);
>  
> diff --git a/drivers/net/ibm_newemac/mal.h b/drivers/net/ibm_newemac/mal.h
> index 2f0a873..51597bd 100644
> --- a/drivers/net/ibm_newemac/mal.h
> +++ b/drivers/net/ibm_newemac/mal.h
> @@ -282,6 +282,7 @@ void mal_disable_rx_channel(struct mal_instance *mal, int channel);
>  
>  void mal_poll_disable(struct mal_instance *mal, struct mal_commac *commac);
>  void mal_poll_enable(struct mal_instance *mal, struct mal_commac *commac);
> +int mal_poll(struct napi_struct *napi, int budget);
>  
>  /* Add/remove EMAC to/from MAL polling list */
>  void mal_poll_add(struct mal_instance *mal, struct mal_commac *commac);
