Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 1F182DDF82
	for <linuxppc-dev@ozlabs.org>; Thu,  7 Aug 2008 13:10:25 +1000 (EST)
Sender: miltonm@bga.com
From: "miltonm" <miltonm@bga.com>
To: michael@ellerman.id.au,miltonm@bga.com
Subject: Re: [PATCH] powerpc: EOI spurious irqs during boot so they can be
	reenabled later
Date: Wed, 06 Aug 2008 21:10:19 -0600
Message-id: <489a679b.80.592f.1469312305@bga.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="iso-8859-1"
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
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
To: miltonm@bga.com
Cc: Paul Mackerras <paulus@samba.org>,
linuxppc-dev@ozlabs.org, Segher Boessenkool
<segher@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: EOI spurious irqs during boot
so they can be reenabled later
Date: Wed, 06 Aug 2008 14:53:54 +1000

> On Tue, 2008-08-05 at 20:55 -0600, miltonm wrote:
> > ----- Original Message Follows -----
> > From: Michael Ellerman <michael@ellerman.id.au>
> > To: Paul Mackerras <paulus@samba.org>
> > Cc: <linuxppc-dev@ozlabs.org>, Milton Miller
> > <miltonm@bga.com>, Segher Boessenkool
> > <segher@kernel.crashing.org>
> > Subject: [PATCH] powerpc: EOI spurious irqs during boot
> > so they can be reenabled later
> > Date: Wed,  6 Aug 2008 12:03:37 +1000 (EST)
> >  
>


> > 
> > I really dislike this great big if in the middle of a
> > function.
> > we called this function from two different call sites
> > where the
> > choice of which to call was based on their environment.
> >  
> > Please move the call to eoi the hwirq to the callers,
> > who know which path to take.
> 
> It's not pretty, but the alternative is worse I think:
> 

Well, it needs a bit of refinement.

> >From 0a908825c8de6cd4c26288aba8c5b7fe3ed0a69f Mon Sep 17
> 00:00:00 2001 From: Michael Ellerman
> <michael@ellerman.id.au> Date: Tue, 5 Aug 2008 22:34:48
> +1000 Subject: [PATCH] powerpc: EOI spurious irqs during
> boot so they can be reenabled later
> 
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
> So when we receive a spurious irq mask it and then EOI it.
> 
> Signed-off-by: Michael Ellerman <michael@ellerman.id.au>
> ---
>  arch/powerpc/platforms/pseries/xics.c |   74
> ++++++++++++++++++++++-----------
>  1 files changed, 50 insertions(+), 24 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/xics.c
> b/arch/powerpc/platforms/pseries/xics.c index
> 0fc830f..754706c 100644 ---
> a/arch/powerpc/platforms/pseries/xics.c +++
> b/arch/powerpc/platforms/pseries/xics.c @@ -90,7 +90,7 @@
> static inline unsigned int direct_xirr_info_get(void)
>  {
>      int cpu = smp_processor_id();
>  
> -    return in_be32(&xics_per_cpu[cpu]->xirr.word);
> +    return in_be32(&xics_per_cpu[cpu]->xirr.word) &
> 0x00ffffff;
>  }
>  
>  static inline void direct_xirr_info_set(int value)
> @@ -124,7 +124,8 @@ static inline unsigned int
> lpar_xirr_info_get(void)
>      lpar_rc = plpar_xirr(&return_value);
>      if (lpar_rc != H_SUCCESS)
>          panic(" bad return code xirr - rc = %lx \n",
> lpar_rc); -    return (unsigned int)return_value;
> +
> +    return (unsigned int)return_value & 0x00ffffff;
>  }
> 

No, don't put the & 0x00FFFFFF here.
(1) this is not get_vector
(2) we can take advantage of the full value

Instead we need a macro to extract this out.

The value returned is the value that is supposed to be used
to EOI.  The top byte is the  old priority of the CPPR and
the bottom 3 is the vector.   xics has priority levels
even though linux does not, and hence can allow limited
nesting.  we use that to allow
only ipis to nest hardware irqs, but once we take an eoi we
actually drop and let
any new hwirq in.   that's a seperate bug/hole.
 
>  static inline void lpar_xirr_info_set(int value)
> @@ -321,49 +322,74 @@ static unsigned int
> xics_startup(unsigned int virq)
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

so if we undo this part

>  
>  static inline unsigned int xics_remap_irq(unsigned int
> vec)
>  {
> -    unsigned int irq;
> -
> -    vec &= 0x00ffffff;
> -
> -    if (vec == XICS_IRQ_SPURIOUS)
> -        return NO_IRQ;
> -    irq = irq_radix_revmap(xics_host, vec);
> -    if (likely(irq != NO_IRQ))
> -        return irq;
> +    return irq_radix_revmap(xics_host, vec);
> +}
>  
> -    printk(KERN_ERR "Interrupt %u (real) is invalid,"
> -           " disabling it.\n", vec);
> -    xics_mask_real_irq(vec);
> -    return NO_IRQ;
> +static void xics_report_bad_irq(unsigned int hwirq)
> +{
> +    pr_err("%s: no mapping for hwirq %u, disabling it.\n"
> , __func__, hwirq);
>  }
>  

merge the mask into here (we always call rtas)



>  static unsigned int xics_get_irq_direct(void)
>  {
> -    return xics_remap_irq(direct_xirr_info_get());
> +    unsigned int virq, hwirq;
> +
> +    hwirq = direct_xirr_info_get();

store the whole xirr_get here, compare #define on the next
line

> +    if (hwirq == XICS_IRQ_SPURIOUS)
> +        return NO_IRQ;
> +
> +    virq = xics_remap_irq(hwirq);
> +
> +    if (unlikely(virq == NO_IRQ)) {
> +        xics_report_bad_irq(hwirq);
> +        xics_mask_real_irq(hwirq);
> +        xics_eoi_hwirq_direct(hwirq);

and make this direct_xirr_set(hwirq) 


> +    }
> +
> +    return virq;
>  }
>  

Then I think it will be cleaner.

>  static unsigned int xics_get_irq_lpar(void)
>  {
> -    return xics_remap_irq(lpar_xirr_info_get());
> +    unsigned int virq, hwirq;
> +
> +    hwirq = lpar_xirr_info_get();
> +    if (hwirq == XICS_IRQ_SPURIOUS)
> +        return NO_IRQ;
> +
> +    virq = xics_remap_irq(hwirq);
> +
> +    if (unlikely(virq == NO_IRQ)) {
> +        xics_report_bad_irq(hwirq);
> +        xics_mask_real_irq(hwirq);
> +        xics_eoi_hwirq_lpar(hwirq);
> +    }
> +
> +    return virq;
>  }

similar

hmm.. i see we can also avoid the masking in lpar if we make
the argument unsigned int.  we build it from unsigned int
anyways.

i suppose i should just create this series.

milton
