Return-Path: <wharms@bfs.de>
Received: from mx01-fr.bfs.de (mx01-fr.bfs.de [193.174.231.67])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t6TKs4TcQzDvRF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 31 Oct 2016 07:16:49 +1100 (AEDT)
Message-ID: <581653E3.5020207@bfs.de>
Date: Sun, 30 Oct 2016 21:11:15 +0100
From: walter harms <wharms@bfs.de>
Reply-To: wharms@bfs.de
MIME-Version: 1.0
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
CC: imunsie@au1.ibm.com, fbarrat@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] cxl: Fix memory allocation failure test
References: <20161030193557.23862-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20161030193557.23862-1-christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



Am 30.10.2016 20:35, schrieb Christophe JAILLET:
> 'cxl_context_alloc()' does not return an error pointer. It is just a
> shortcut for a call to 'kzalloc' with 'sizeof(struct cxl_context)' as the
> size parameter.
> 
> So its return value should be compared with NULL.
> While fixing it, simplify a bit the code.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> un-compiled because I don't have the required  cross build environment.
> ---
>  drivers/misc/cxl/api.c | 7 ++-----
>  1 file changed, 2 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/misc/cxl/api.c b/drivers/misc/cxl/api.c
> index 2e5233b60971..2b88ad8a2a89 100644
> --- a/drivers/misc/cxl/api.c
> +++ b/drivers/misc/cxl/api.c
> @@ -30,10 +30,8 @@ struct cxl_context *cxl_dev_context_init(struct pci_dev *dev)
>  		return ERR_CAST(afu);
>  
>  	ctx = cxl_context_alloc();
> -	if (IS_ERR(ctx)) {
> -		rc = PTR_ERR(ctx);
> -		goto err_dev;
> -	}
> +	if (!ctx)
> +		return ERR_PTR(-ENOMEM);
>  

So far i see it is only used 2 times,
To avoid such problems it should be replaced with
    kzalloc(sizeof(struct cxl_context), GFP_KERNEL); (from context.c)

or even better:
	ctx = kzalloc(*ctx, GFP_KERNEL);

This way the error had been spotted much more early.

just my 2 cents,
re,
 wh

>  	ctx->kernelapi = true;
>  
> @@ -61,7 +59,6 @@ struct cxl_context *cxl_dev_context_init(struct pci_dev *dev)
>  	kfree(mapping);
>  err_ctx:
>  	kfree(ctx);
> -err_dev:
>  	return ERR_PTR(rc);
>  }
>  EXPORT_SYMBOL_GPL(cxl_dev_context_init);
