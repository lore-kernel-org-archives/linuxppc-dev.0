Return-Path: <julia.lawall@lip6.fr>
Received: from mail2-relais-roc.national.inria.fr
 (mail2-relais-roc.national.inria.fr [192.134.164.83])
 (using TLSv1.2 with cipher RC4-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 035F31A0664
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 07:55:12 +1100 (AEDT)
Date: Sun, 11 Oct 2015 22:44:25 +0200 (CEST)
From: Julia Lawall <julia.lawall@lip6.fr>
To: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] powerpc/mpc5xxx: Use of_get_next_parent to simplify code
In-Reply-To: <1444595260-3332-1-git-send-email-christophe.jaillet@wanadoo.fr>
Message-ID: <alpine.DEB.2.02.1510112243420.2096@localhost6.localdomain6>
References: <1444595260-3332-1-git-send-email-christophe.jaillet@wanadoo.fr>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 11 Oct 2015, Christophe JAILLET wrote:

> of_get_next_parent can be used to simplify the while() loop and
> avoid the need of a temp variable.

Can you do something with the loop in __of_translate_address, in 
drivers/of/address.c?  Is there not an iterator for this?

julia


> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
>  arch/powerpc/sysdev/mpc5xxx_clocks.c | 5 +----
>  1 file changed, 1 insertion(+), 4 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/mpc5xxx_clocks.c b/arch/powerpc/sysdev/mpc5xxx_clocks.c
> index f4f0301..5732926 100644
> --- a/arch/powerpc/sysdev/mpc5xxx_clocks.c
> +++ b/arch/powerpc/sysdev/mpc5xxx_clocks.c
> @@ -13,7 +13,6 @@
>  
>  unsigned long mpc5xxx_get_bus_frequency(struct device_node *node)
>  {
> -	struct device_node *np;
>  	const unsigned int *p_bus_freq = NULL;
>  
>  	of_node_get(node);
> @@ -22,9 +21,7 @@ unsigned long mpc5xxx_get_bus_frequency(struct device_node *node)
>  		if (p_bus_freq)
>  			break;
>  
> -		np = of_get_parent(node);
> -		of_node_put(node);
> -		node = np;
> +		node = of_get_next_parent(node);
>  	}
>  	of_node_put(node);
>  
> -- 
> 2.1.4
> 
> --
> To unsubscribe from this list: send the line "unsubscribe kernel-janitors" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> 
