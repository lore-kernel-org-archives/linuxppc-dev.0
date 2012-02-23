Return-Path: <glikely@secretlab.ca>
Received: from mail-pw0-f51.google.com (mail-pw0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EECA4B6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 Feb 2012 12:39:52 +1100 (EST)
Received: by pbbrp2 with SMTP id rp2so886173pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 Feb 2012 17:39:50 -0800 (PST)
Sender: Grant Likely <glikely@secretlab.ca>
Date: Wed, 22 Feb 2012 18:39:47 -0700
From: Grant Likely <grant.likely@secretlab.ca>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: powerpc/mpic: Fix allocation of reverse-map for multi-ISU mpics
Message-ID: <20120223013947.GC3212@ponder.secretlab.ca>
References: <1329954613.20389.15.camel@pasglop>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1329954613.20389.15.camel@pasglop>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 23, 2012 at 10:50:13AM +1100, Benjamin Herrenschmidt wrote:
> When using a multi-ISU MPIC, we can interrupts up to
> isu_size * MPIC_MAX_ISU, not just isu_size, so allocate
> the right size reverse map.
> 
> Without this, the code will constantly fallback to
> a linear search.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

Looks fine to me.  This will conflict with the irqdomain tree in linux-next,
but it will be a trivial fixup.  Still, if you prefer I can pick this
up into my tree.

g.

> ---
> 
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 4e9ccb1..7fb3ab5 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1346,7 +1346,8 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  	mpic->isu_mask = (1 << mpic->isu_shift) - 1;
>  
>  	mpic->irqhost = irq_alloc_host(mpic->node, IRQ_HOST_MAP_LINEAR,
> -				       isu_size ? isu_size : mpic->num_sources,
> +				       isu_size ? isu_size *  MPIC_MAX_ISU :
> +				       mpic->num_sources,
>  				       &mpic_host_ops,
>  				       flags & MPIC_LARGE_VECTORS ? 2048 : 256);
>  
> 
> 
