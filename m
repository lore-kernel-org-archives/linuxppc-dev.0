Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 9ACF41A0B66
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 11 Aug 2014 13:26:55 +1000 (EST)
Message-ID: <1407725838.4508.57.camel@pasglop>
Subject: Re: [PATCH 4/14] powerpc/pseries: delete unneeded test before
 of_node_put
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Julia Lawall <Julia.Lawall@lip6.fr>
Date: Mon, 11 Aug 2014 12:57:18 +1000
In-Reply-To: <1407492475-26283-6-git-send-email-Julia.Lawall@lip6.fr>
References: <1407492475-26283-6-git-send-email-Julia.Lawall@lip6.fr>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>,
 Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= <u.kleine-koenig@pengutronix.de>,
 linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2014-08-08 at 12:07 +0200, Julia Lawall wrote:
> From: Julia Lawall <Julia.Lawall@lip6.fr>
> 
> Of_node_put supports NULL as its argument, so the initial test is not
> necessary.
> 
> Suggested by Uwe Kleine-König.
> 
> The semantic patch that fixes this problem is as follows:
> (http://coccinelle.lip6.fr/)
> 
> // <smpl>
> @@
> expression e;
> @@
> 
> -if (e)
>    of_node_put(e);
> // </smpl>
> 
> Signed-off-by: Julia Lawall <Julia.Lawall@lip6.fr>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> 
> ---
>  arch/powerpc/platforms/pseries/iommu.c |    3 +--
>  1 file changed, 1 insertion(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
> index 33b552f..2ea6831 100644
> --- a/arch/powerpc/platforms/pseries/iommu.c
> +++ b/arch/powerpc/platforms/pseries/iommu.c
> @@ -575,8 +575,7 @@ static void pci_dma_bus_setup_pSeries(struct pci_bus *bus)
>  	while (isa_dn && isa_dn != dn)
>  		isa_dn = isa_dn->parent;
>  
> -	if (isa_dn_orig)
> -		of_node_put(isa_dn_orig);
> +	of_node_put(isa_dn_orig);
>  
>  	/* Count number of direct PCI children of the PHB. */
>  	for (children = 0, tmp = dn->child; tmp; tmp = tmp->sibling)
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/
