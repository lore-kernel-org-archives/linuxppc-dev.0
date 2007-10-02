Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id E1359DDEF2
	for <linuxppc-dev@ozlabs.org>; Tue,  2 Oct 2007 15:14:18 +1000 (EST)
Subject: Re: [PATCH 3/7] Use dcr_host_t.base in ibm_emac_mal
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Michael Ellerman <michael@ellerman.id.au>
In-Reply-To: <5022a72815fe6334b5255dbe1288036131c2c961.1190009070.git.michael@ellerman.id.au>
References: <449a181e8169af98984bb2d61a759c23e55d19b4.1190009070.git.michael@ellerman.id.au>
	<5022a72815fe6334b5255dbe1288036131c2c961.1190009070.git.michael@ellerman.id.au>
Content-Type: text/plain
Date: Tue, 02 Oct 2007 15:13:45 +1000
Message-Id: <1191302025.6310.70.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-09-17 at 16:05 +1000, Michael Ellerman wrote:
> This requires us to do a sort-of fake dcr_map(), so that base is set
> properly. This will be fixed/removed when the device-tree-aware emac driver
> is merged.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
---

(Have you actually tested btw ? :-)

> ---
>  drivers/net/ibm_emac/ibm_emac_mal.c |    5 ++++-
>  drivers/net/ibm_emac/ibm_emac_mal.h |    5 ++---
>  2 files changed, 6 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/net/ibm_emac/ibm_emac_mal.c b/drivers/net/ibm_emac/ibm_emac_mal.c
> index cabd984..b08da96 100644
> --- a/drivers/net/ibm_emac/ibm_emac_mal.c
> +++ b/drivers/net/ibm_emac/ibm_emac_mal.c
> @@ -421,7 +421,10 @@ static int __init mal_probe(struct ocp_device *ocpdev)
>  		       ocpdev->def->index);
>  		return -ENOMEM;
>  	}
> -	mal->dcrbase = maldata->dcr_base;
> +
> +	/* XXX This only works for native dcr for now */
> +	mal->dcrhost = dcr_map(NULL, maldata->dcr_base, 0);
> +
>  	mal->def = ocpdev->def;
>  
>  	INIT_LIST_HEAD(&mal->poll_list);
> diff --git a/drivers/net/ibm_emac/ibm_emac_mal.h b/drivers/net/ibm_emac/ibm_emac_mal.h
> index 64bc338..6b1fbeb 100644
> --- a/drivers/net/ibm_emac/ibm_emac_mal.h
> +++ b/drivers/net/ibm_emac/ibm_emac_mal.h
> @@ -191,7 +191,6 @@ struct mal_commac {
>  };
>  
>  struct ibm_ocp_mal {
> -	int			dcrbase;
>  	dcr_host_t		dcrhost;
>  
>  	struct list_head	poll_list;
> @@ -209,12 +208,12 @@ struct ibm_ocp_mal {
>  
>  static inline u32 get_mal_dcrn(struct ibm_ocp_mal *mal, int reg)
>  {
> -	return dcr_read(mal->dcrhost, mal->dcrbase + reg);
> +	return dcr_read(mal->dcrhost, mal->dcrhost.base + reg);
>  }
>  
>  static inline void set_mal_dcrn(struct ibm_ocp_mal *mal, int reg, u32 val)
>  {
> -	dcr_write(mal->dcrhost, mal->dcrbase + reg, val);
> +	dcr_write(mal->dcrhost, mal->dcrhost.base + reg, val);
>  }
>  
>  /* Register MAL devices */
