Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 1B56FDDDF4
	for <linuxppc-dev@ozlabs.org>; Thu, 21 Feb 2008 16:51:06 +1100 (EST)
Mime-Version: 1.0 (Apple Message framework v624)
In-Reply-To: <1203507104.17534.32.camel@johannes.berg>
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <91eb052edd9d5c608658fcdcfdc7589c@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] mpic: make sparse happy
Date: Wed, 20 Feb 2008 23:50:57 -0600
To: Johannes Berg <johannes@sipsolutions.net>
Cc: ppcdev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

At Wed Feb 20 22:31:44 EST 2008, Johannes Berg wrote:
> I was running sparse on something else and noticed sparse warnings
> and especially the bogus code that is fixed by the first hunk of
> this patch, so I fixed them all while at it.

But your change is not equivalent!

> --- everything.orig/arch/powerpc/sysdev/mpic.c  2008-02-20 
> 12:25:41.000000000 +0100
> +++ everything/arch/powerpc/sysdev/mpic.c       2008-02-20 
> 12:28:37.000000000 +0100
> @@ -175,13 +175,13 @@ static inline void _mpic_write(enum mpic
>         switch(type) {
>  #ifdef CONFIG_PPC_DCR
>         case mpic_access_dcr:
> -               return dcr_write(rb->dhost, reg, value);
> +               dcr_write(rb->dhost, reg, value);
>  #endif
>         case mpic_access_mmio_be:
> -               return out_be32(rb->base + (reg >> 2), value);
> +               out_be32(rb->base + (reg >> 2), value);
>         case mpic_access_mmio_le:
>         default:
> -               return out_le32(rb->base + (reg >> 2), value);
> +               out_le32(rb->base + (reg >> 2), value);
>         }
>  }

You now write to the register with dcr, big, and little endian variants!

Either put a return or break after the calls to the void functions so 
you don't fall through.

...

> @@ -1107,10 +1108,10 @@ struct mpic * __init mpic_alloc(struct d
>          * in, try to obtain one
>          */
>         if (paddr == 0 && !(mpic->flags & MPIC_USES_DCR)) {
> -               const u32 *reg;
> -               reg = of_get_property(node, "reg", NULL);
> -               BUG_ON(reg == NULL);
> -               paddr = of_translate_address(node, reg);
> +               const u32 *regprop;
> +               regprop = of_get_property(node, "reg", NULL);
> +               BUG_ON(regprop == NULL);
> +               paddr = of_translate_address(node, regprop);
>                 BUG_ON(paddr == OF_BAD_ADDR);
>         }

This is reg variable is shadowed ... ok, although i might have renamed 
the outer one features or greg_feature.  For that matter, I would have 
initialized this reg/regprop on definition.
