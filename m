Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id E7D7CDE872
	for <linuxppc-dev@ozlabs.org>; Thu, 22 May 2008 06:45:41 +1000 (EST)
Subject: Re: [PATCH] [POWERPC] mpic: cope with non mpic irqs
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stephen Rothwell <sfr@canb.auug.org.au>
In-Reply-To: <20080521162431.7b788987.sfr@canb.auug.org.au>
References: <20080521162431.7b788987.sfr@canb.auug.org.au>
Content-Type: text/plain
Date: Wed, 21 May 2008 16:45:24 -0400
Message-Id: <1211402724.8297.249.camel@pasglop>
Mime-Version: 1.0
Cc: ppc-dev <linuxppc-dev@ozlabs.org>, paulus@samba.org
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Wed, 2008-05-21 at 16:24 +1000, Stephen Rothwell wrote:
> Compiling ppc64_defconfig with gcc 4.3 gives thes warnings:
> 
> arch/powerpc/sysdev/mpic.c: In function 'mpic_irq_get_priority':
> arch/powerpc/sysdev/mpic.c:1351: warning: 'is_ipi' may be used uninitialized in this function
> arch/powerpc/sysdev/mpic.c: In function 'mpic_irq_set_priority':
> arch/powerpc/sysdev/mpic.c:1328: warning: 'is_ipi' may be used uninitialized in this function
> 
> It turns out that in the cases where is_ipi is uninitialized, another
> variable (mpic) will be NULL and it is dereferenced.  Protect against
> this by returning if mpic is NULL in mpic_irq_set_priority and removing
> mpic_irq_get_priority completely as it has no in tree callers.
> 
> This has the nice side effect of making the warning go away.
> 
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>

Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>

> ---
>  arch/powerpc/sysdev/mpic.c |   20 +++-----------------
>  include/asm-powerpc/mpic.h |    3 +--
>  2 files changed, 4 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 8619f2a..7680001 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -1331,6 +1331,9 @@ void mpic_irq_set_priority(unsigned int irq, unsigned int pri)
>  	unsigned long flags;
>  	u32 reg;
>  
> +	if (!mpic)
> +		return;
> +
>  	spin_lock_irqsave(&mpic_lock, flags);
>  	if (is_ipi) {
>  		reg = mpic_ipi_read(src - mpic->ipi_vecs[0]) &
> @@ -1346,23 +1349,6 @@ void mpic_irq_set_priority(unsigned int irq, unsigned int pri)
>  	spin_unlock_irqrestore(&mpic_lock, flags);
>  }
>  
> -unsigned int mpic_irq_get_priority(unsigned int irq)
> -{
> -	unsigned int is_ipi;
> -	struct mpic *mpic = mpic_find(irq, &is_ipi);
> -	unsigned int src = mpic_irq_to_hw(irq);
> -	unsigned long flags;
> -	u32 reg;
> -
> -	spin_lock_irqsave(&mpic_lock, flags);
> -	if (is_ipi)
> -		reg = mpic_ipi_read(src = mpic->ipi_vecs[0]);
> -	else
> -		reg = mpic_irq_read(src, MPIC_INFO(IRQ_VECTOR_PRI));
> -	spin_unlock_irqrestore(&mpic_lock, flags);
> -	return (reg & MPIC_VECPRI_PRIORITY_MASK) >> MPIC_VECPRI_PRIORITY_SHIFT;
> -}
> -
>  void mpic_setup_this_cpu(void)
>  {
>  #ifdef CONFIG_SMP
> diff --git a/include/asm-powerpc/mpic.h b/include/asm-powerpc/mpic.h
> index 943c5a3..a4d0f87 100644
> --- a/include/asm-powerpc/mpic.h
> +++ b/include/asm-powerpc/mpic.h
> @@ -428,12 +428,11 @@ extern void mpic_init(struct mpic *mpic);
>   */
>  
> 
> -/* Change/Read the priority of an interrupt. Default is 8 for irqs and
> +/* Change the priority of an interrupt. Default is 8 for irqs and
>   * 10 for IPIs. You can call this on both IPIs and IRQ numbers, but the
>   * IPI number is then the offset'ed (linux irq number mapped to the IPI)
>   */
>  extern void mpic_irq_set_priority(unsigned int irq, unsigned int pri);
> -extern unsigned int mpic_irq_get_priority(unsigned int irq);
>  
>  /* Setup a non-boot CPU */
>  extern void mpic_setup_this_cpu(void);
> -- 
> 1.5.5.1
> 
