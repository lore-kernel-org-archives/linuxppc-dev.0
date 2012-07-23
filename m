Return-Path: <hughd@google.com>
Received: from mail-pb0-f51.google.com (mail-pb0-f51.google.com
 [209.85.160.51])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 08D932C0201
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 17:25:36 +1000 (EST)
Received: by pbbrp16 with SMTP id rp16so10192358pbb.38
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 23 Jul 2012 00:25:34 -0700 (PDT)
Date: Mon, 23 Jul 2012 00:24:50 -0700 (PDT)
From: Hugh Dickins <hughd@google.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: next/mmotm unbootable on G5: irqdomain
In-Reply-To: <1343011543.2957.2.camel@pasglop>
Message-ID: <alpine.LSU.2.00.1207230023380.6948@eggly.anvils>
References: <alpine.LSU.2.00.1207211911160.1585@eggly.anvils>
 <1343011543.2957.2.camel@pasglop>
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Cc: Stephen Rothwell <sfr@canb.auug.org.au>, linux-kernel@vger.kernel.org,
 Milton Miller <miltonm@bga.com>, Paul Mundt <lethal@linux-sh.org>,
 Rob Herring <rob.herring@calxeda.com>,
 Andrew Morton <akpm@linux-foundation.org>, linuxppc-dev@lists.ozlabs.org,
 Thomas Gleixner <tglx@linutronix.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 23 Jul 2012, Benjamin Herrenschmidt wrote:
> On Sat, 2012-07-21 at 19:47 -0700, Hugh Dickins wrote:
> > I have to revert the patch below from mmotm 2012-07-20-16-30 or
> > next-20120720 in order to boot on the PowerPC G5: otherwise it
> > freezes before switching to the framebuffer console - but I'm
> > not certain where because that initial console doesn't scroll
> > (there are mpic messages at bottom and at top of screen, probably
> > later messages at the top but I don't know the sequence).
> 
> This fixes it

Confirmed: many thanks, Ben.

> (Grant, how do we avoid bisection breakage here ? I can
> put that in -powerpc and we can make sure that gets merged before your
> tree ?)
> 
> powerpc/mpic: Create a revmap with enough entries for IPIs and timers
> 
> The current mpic code creates a linear revmap just big enough for all
> the sources, which happens to miss the IPIs and timers on some machines.
> 
> This will in turn break when the irqdomain code loses the fallback of
> doing a linear search when the revmap fails (and really slows down IPIs
> otherwise).
> 
> This happens for example on the U4 based Apple machines such as the
> dual core PowerMac G5s.
> 
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 906f29c..bfc6211 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1376,7 +1376,7 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  	mpic->isu_mask = (1 << mpic->isu_shift) - 1;
>  
>  	mpic->irqhost = irq_domain_add_linear(mpic->node,
> -				       last_irq + 1,
> +				       intvec_top,
>  				       &mpic_host_ops, mpic);
>  
>  	/*
> 
> 
> 
