Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id EB0011A073D
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 15:00:11 +1100 (AEDT)
In-Reply-To: <1444595260-3332-1-git-send-email-christophe.jaillet@wanadoo.fr>
To: Christophe Jaillet <christophe.jaillet@wanadoo.fr>,
 benh@kernel.crashing.org, paulus@samba.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: kernel-janitors@vger.kernel.org,
 Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: powerpc/mpc5xxx: Use of_get_next_parent to simplify code
Message-Id: <20151014040011.8AB1514110A@ozlabs.org>
Date: Wed, 14 Oct 2015 15:00:11 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-11-10 at 20:27:40 UTC, Christophe Jaillet wrote:
> of_get_next_parent can be used to simplify the while() loop and
> avoid the need of a temp variable.
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


This conversion is OK, but the logic in the function is still wrong.

It uses of_get_property() inside the loop, but then drops the reference to the
node before dereferencing the p_bus_freq pointer, which could by then point to
junk if the node has been freed.

Instead it should use of_property_read_u32() to actually read the property
value before dropping the reference.

cheers
