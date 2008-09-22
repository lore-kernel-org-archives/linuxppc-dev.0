Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id F0BB8DDE19
	for <linuxppc-dev@ozlabs.org>; Mon, 22 Sep 2008 11:12:42 +1000 (EST)
Subject: Re: [PATCH] arch/powerpc/platforms/powermac/pic.c: move of_node_put
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Julia Lawall <julia@diku.dk>
In-Reply-To: <Pine.LNX.4.64.0809211301030.7450@ask.diku.dk>
References: <Pine.LNX.4.64.0809211301030.7450@ask.diku.dk>
Content-Type: text/plain
Date: Sun, 21 Sep 2008 18:12:28 -0700
Message-Id: <1222045948.12085.9.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, kernel-janitors@vger.kernel.org, paulus@samba.org,
	linux-kernel@vger.kernel.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Sun, 2008-09-21 at 13:01 +0200, Julia Lawall wrote:
> From: Julia Lawall <julia@diku.dk>
> 
> It seems better to dereference master before decrementing the reference
> count rather than afterwards.
> 
> The problem was found using the following semantic match:
> (http://www.emn.fr/x-info/coccinelle/)
> 
> // <smpl>
> @r exists@
> expression n,E;
> identifier fld;
> iterator I;
> statement S;
> @@
> 
> * of_node_put(n)
> ... when != n = E
>     when != I(n,...) S
> * n->fld
> // </smpl>
> 
> Signed-off-by: Julia Lawall <julia@diku.dk>

Ack.

No big deal, tho, those nodes are never going to go away :-)

Cheers,
Ben.

> ---
> 
>  arch/powerpc/platforms/powermac/pic.c          |    2 +-
>  1 files changed, 1 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powermac/pic.c b/arch/powerpc/platforms/powermac/pic.c
> index 6d149ae..d17aa2b 100644
> --- a/arch/powerpc/platforms/powermac/pic.c
> +++ b/arch/powerpc/platforms/powermac/pic.c
> @@ -395,10 +395,10 @@ static void __init pmac_pic_probe_oldstyle(void)
>  	if (max_real_irqs > 32)
>  		pmac_irq_hw[i++] = (volatile struct pmac_irq_hw __iomem *)
>  			(addr + 0x10);
> -	of_node_put(master);
>  
>  	printk(KERN_INFO "irq: Found primary Apple PIC %s for %d irqs\n",
>  	       master->full_name, max_real_irqs);
> +	of_node_put(master);
>  
>  	/* Map interrupts of cascaded controller */
>  	if (slave && !of_address_to_resource(slave, 0, &r)) {
