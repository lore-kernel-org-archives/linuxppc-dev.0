Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 0554FDDFB2
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Aug 2008 12:55:57 +1000 (EST)
Sender: miltonm@bga.com
From: "miltonm" <miltonm@bga.com>
To: Michael Ellerman <michael@ellerman.id.au>,
	Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc: EOI spurious irqs during boot so they can be
	reenabled later
Date: Tue, 05 Aug 2008 20:55:50 -0600
Message-id: <489912b6.cc.1809.1931903668@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, Milton Miller <miltonm@bga.com>
Reply-To: miltonm@bga.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

----- Original Message Follows -----
From: Michael Ellerman <michael@ellerman.id.au>
To: Paul Mackerras <paulus@samba.org>
Cc: <linuxppc-dev@ozlabs.org>, Milton Miller
<miltonm@bga.com>, Segher Boessenkool
<segher@kernel.crashing.org>
Subject: [PATCH] powerpc: EOI spurious irqs during boot so
they can be reenabled later
Date: Wed,  6 Aug 2008 12:03:37 +1000 (EST)
 
> In the xics code, if we receive an irq during boot that
> hasn't been setup yet - ie. we have no reverse mapping for
> it - we mask the irq so we don't hear from it again.
> 
> Later on if someone request_irq()'s that irq, we'll unmask
> it but it will still never fire. This is because we never
> EOI'ed the irq when we originally received it - when it
> was spurious.
> 
> This can be reproduced trivially by banging the keyboard
> while kexec'ing on a P5 LPAR, even though the hvc_console
> driver request's the console irq, the console is
> non-functional because we're receiving no console
> interrupts.
> 
 
which means some driver didn't disable interrupts on its
shutdown, but I digress.
 
> So when we receive a spurious irq mask it and then EOI it.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  arch/powerpc/platforms/pseries/xics.c |   29
> ++++++++++++++++++++---------
>  1 files changed, 20 insertions(+), 9 deletions(-)
> 
> 
> Updated to mask then EOI, thanks to Segher for whacking me
> with the clue stick.
>
 
Actually, just sending the EOI would likely result in the
exact same interrupt comming back, as the mask will set
a bit near the source but the interrupt would have already
been missed.  (most irqs in xics systems are level).
 
Thanks to segher for noticing the order.   However...
 
 
 
> diff --git a/arch/powerpc/platforms/pseries/xics.c
> b/arch/powerpc/platforms/pseries/xics.c index
> 0fc830f..4c692b2 100644 ---
> a/arch/powerpc/platforms/pseries/xics.c +++
> b/arch/powerpc/platforms/pseries/xics.c @@ -321,21 +321,26
> @@ static unsigned int xics_startup(unsigned int virq)
>      return 0;
>  }
>  
> +static void xics_eoi_hwirq_direct(unsigned int hwirq)
> +{
> +    iosync();
> +    direct_xirr_info_set((0xff << 24) | hwirq);
> +}
> +
>  static void xics_eoi_direct(unsigned int virq)
>  {
> -    unsigned int irq = (unsigned int)irq_map[virq].hwirq;
> +    xics_eoi_hwirq_direct((unsigned
> int)irq_map[virq].hwirq); +}
>  
> +static void xics_eoi_hwirq_lpar(unsigned int hwirq)
> +{
>      iosync();
> -    direct_xirr_info_set((0xff << 24) | irq);
> +    lpar_xirr_info_set((0xff << 24) | hwirq);
>  }
>  
> -
>  static void xics_eoi_lpar(unsigned int virq)
>  {
> -    unsigned int irq = (unsigned int)irq_map[virq].hwirq;
> -
> -    iosync();
> -    lpar_xirr_info_set((0xff << 24) | irq);
> +    xics_eoi_hwirq_lpar((unsigned
> int)irq_map[virq].hwirq);
>  }
>  
>  static inline unsigned int xics_remap_irq(unsigned int
> vec) @@ -350,9 +355,15 @@ static inline unsigned int
> xics_remap_irq(unsigned int vec)
>      if (likely(irq != NO_IRQ))
>          return irq;
>  
> -    printk(KERN_ERR "Interrupt %u (real) is invalid,"
> -           " disabling it.\n", vec);
> +    pr_err("%s: no mapping for hwirq %u, disabling it.\n"
> , __func__, vec); +
>      xics_mask_real_irq(vec);
> +
> +    if (firmware_has_feature(FW_FEATURE_LPAR))
> +        xics_eoi_hwirq_lpar(vec);
> +    else
> +        xics_eoi_hwirq_direct(vec);
> +
>      return NO_IRQ;
>  }
 
 
I really dislike this great big if in the middle of a
function.
we called this function from two different call sites where
the
choice of which to call was based on their environment.
 
Please move the call to eoi the hwirq to the callers, who
know
which path to take.
 
I guess it might make sense to put the printk in a 
mask_invalid_real_irq wrapper, and then perhaps just
duplicate 
the small remaining code?   Or split the return of spurious
from NO_IRQ (ie should spurious be NO_IRQ_IGNORE?)
 
>  
> -- 
> 1.5.5
> 
