Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH v3 1/4] powerpc: Removing support for 'protected-sources'
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Meador Inge <meador_inge@mentor.com>
In-Reply-To: <1296861941-3370-2-git-send-email-meador_inge@mentor.com>
References: <1296861941-3370-1-git-send-email-meador_inge@mentor.com>
	<1296861941-3370-2-git-send-email-meador_inge@mentor.com>
Content-Type: text/plain; charset="UTF-8"
Date: Mon, 07 Feb 2011 10:35:36 +1100
Message-ID: <1297035336.14982.14.camel@pasglop>
Mime-Version: 1.0
Cc: Hollis Blanchard <hollis_blanchard@mentor.com>,
	devicetree-discuss@lists.ozlabs.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2011-02-04 at 17:25 -0600, Meador Inge wrote:
> In a recent thread [1,2,3] concerning device trees for AMP systems, the
> question of whether we really need 'protected-sources' arose.  The general
> consensus was that a new boolean property 'pic-no-reset' (described in more
> detail in a following patch) could be expanded to cover the use cases that
> 'protected-sources' was covering.
> 
> One concern that was raised was for legacy systems which already use the
> 'protected-sources' property [4].  For legacy use cases, 'protected-sources'
> will be treated as an alias of 'pic-no-reset'.  The sources
> encoded in the 'protected-sources' cells, however, will not be processed.  This
> legacy check is added in a later patch in the series.

I'm a bit annoyed here. Why do we need to do that ? Those Cell machines
are going to be real bastards to find and test with, and I don't really
see the point...

The reason for not resetting the MPIC wasn't -only- about the protected
sources, but also because, from memory, some MPIC implementations had
issues when toggling the reset lines (pseries I think is one).

That's actually why the MPIC_WANTS_RESET flag is working the other way
around, only platforms that actually want the reset set it.

This is orthogonal to the need to touch or not touch the interrupt
sources as set by firmware. Yes, having protected sources probably
implies no-reset but the reverse isn't necessarily true.

Ben.
 
> [1] http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-January/004038.html
> [2] http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-January/003991.html
> [3] http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-January/004043.html
> [4] http://lists.ozlabs.org/pipermail/devicetree-discuss/2011-February/004254.html
> 
> Signed-off-by: Meador Inge <meador_inge@mentor.com>
> Cc: Hollis Blanchard <hollis_blanchard@mentor.com>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>  arch/powerpc/include/asm/mpic.h |    3 ---
>  arch/powerpc/sysdev/mpic.c      |   38 --------------------------------------
>  2 files changed, 0 insertions(+), 41 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mpic.h b/arch/powerpc/include/asm/mpic.h
> index e000cce..9b94f18 100644
> --- a/arch/powerpc/include/asm/mpic.h
> +++ b/arch/powerpc/include/asm/mpic.h
> @@ -301,9 +301,6 @@ struct mpic
>  	struct mpic_reg_bank	cpuregs[MPIC_MAX_CPUS];
>  	struct mpic_reg_bank	isus[MPIC_MAX_ISU];
>  
> -	/* Protected sources */
> -	unsigned long		*protected;
> -
>  #ifdef CONFIG_MPIC_WEIRD
>  	/* Pointer to HW info array */
>  	u32			*hw_set;
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 7c13426..a98f41d 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -947,8 +947,6 @@ static int mpic_host_map(struct irq_host *h, unsigned int virq,
>  
>  	if (hw == mpic->spurious_vec)
>  		return -EINVAL;
> -	if (mpic->protected && test_bit(hw, mpic->protected))
> -		return -EINVAL;
>  
>  #ifdef CONFIG_SMP
>  	else if (hw >= mpic->ipi_vecs[0]) {
> @@ -1095,26 +1093,6 @@ struct mpic * __init mpic_alloc(struct device_node *node,
>  	if (node && of_get_property(node, "big-endian", NULL) != NULL)
>  		mpic->flags |= MPIC_BIG_ENDIAN;
>  
> -	/* Look for protected sources */
> -	if (node) {
> -		int psize;
> -		unsigned int bits, mapsize;
> -		const u32 *psrc =
> -			of_get_property(node, "protected-sources", &psize);
> -		if (psrc) {
> -			psize /= 4;
> -			bits = intvec_top + 1;
> -			mapsize = BITS_TO_LONGS(bits) * sizeof(unsigned long);
> -			mpic->protected = kzalloc(mapsize, GFP_KERNEL);
> -			BUG_ON(mpic->protected == NULL);
> -			for (i = 0; i < psize; i++) {
> -				if (psrc[i] > intvec_top)
> -					continue;
> -				__set_bit(psrc[i], mpic->protected);
> -			}
> -		}
> -	}
> -
>  #ifdef CONFIG_MPIC_WEIRD
>  	mpic->hw_set = mpic_infos[MPIC_GET_REGSET(flags)];
>  #endif
> @@ -1321,9 +1299,6 @@ void __init mpic_init(struct mpic *mpic)
>  		u32 vecpri = MPIC_VECPRI_MASK | i |
>  			(8 << MPIC_VECPRI_PRIORITY_SHIFT);
>  		
> -		/* check if protected */
> -		if (mpic->protected && test_bit(i, mpic->protected))
> -			continue;
>  		/* init hw */
>  		mpic_irq_write(i, MPIC_INFO(IRQ_VECTOR_PRI), vecpri);
>  		mpic_irq_write(i, MPIC_INFO(IRQ_DESTINATION), 1 << cpu);
> @@ -1492,13 +1467,6 @@ static unsigned int _mpic_get_one_irq(struct mpic *mpic, int reg)
>  			mpic_eoi(mpic);
>  		return NO_IRQ;
>  	}
> -	if (unlikely(mpic->protected && test_bit(src, mpic->protected))) {
> -		if (printk_ratelimit())
> -			printk(KERN_WARNING "%s: Got protected source %d !\n",
> -			       mpic->name, (int)src);
> -		mpic_eoi(mpic);
> -		return NO_IRQ;
> -	}
>  
>  	return irq_linear_revmap(mpic->irqhost, src);
>  }
> @@ -1532,12 +1500,6 @@ unsigned int mpic_get_coreint_irq(void)
>  			mpic_eoi(mpic);
>  		return NO_IRQ;
>  	}
> -	if (unlikely(mpic->protected && test_bit(src, mpic->protected))) {
> -		if (printk_ratelimit())
> -			printk(KERN_WARNING "%s: Got protected source %d !\n",
> -			       mpic->name, (int)src);
> -		return NO_IRQ;
> -	}
>  
>  	return irq_linear_revmap(mpic->irqhost, src);
>  #else
