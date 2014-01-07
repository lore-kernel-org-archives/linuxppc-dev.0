Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id A14202C00B8
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Jan 2014 16:49:47 +1100 (EST)
Message-ID: <1389073776.4672.5.camel@pasglop>
Subject: Re: [PATCH] powerpc/mpic: supply a .disable callback
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Tue, 07 Jan 2014 16:49:36 +1100
In-Reply-To: <1389073086-6763-1-git-send-email-dongsheng.wang@freescale.com>
References: <1389073086-6763-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: scottwood@freescale.com, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, 2014-01-07 at 13:38 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> Currently MPIC provides .mask, but not .disable.  This means that
> effectively disable_irq() soft-disables the interrupt, and you get
> a .mask call if an interrupt actually occurs.
> 
> I'm not sure if this was intended as a performance benefit (it seems common
> to omit .disable on powerpc interrupt controllers, but nowhere else), but it
> interacts badly with threaded/workqueue interrupts (including KVM
> reflection).  In such cases, where the real interrupt handler does a
> disable_irq_nosync(), schedules defered handling, and returns, we get two
> interrupts for every real interrupt.  The second interrupt does nothing
> but see that IRQ_DISABLED is set, and decide that it would be a good
> idea to actually call .mask.

We probably don't want to do that for edge, only level interrupts.

Cheers,
Ben.

> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> diff --git a/arch/powerpc/sysdev/mpic.c b/arch/powerpc/sysdev/mpic.c
> index 0e166ed..dd7564b 100644
> --- a/arch/powerpc/sysdev/mpic.c
> +++ b/arch/powerpc/sysdev/mpic.c
> @@ -975,6 +975,7 @@ void mpic_set_destination(unsigned int virq, unsigned int cpuid)
>  }
>  
>  static struct irq_chip mpic_irq_chip = {
> +	.irq_disable	= mpic_mask_irq,
>  	.irq_mask	= mpic_mask_irq,
>  	.irq_unmask	= mpic_unmask_irq,
>  	.irq_eoi	= mpic_end_irq,
> @@ -984,6 +985,7 @@ static struct irq_chip mpic_irq_chip = {
>  
>  #ifdef CONFIG_SMP
>  static struct irq_chip mpic_ipi_chip = {
> +	.irq_disable	= mpic_mask_ipi,
>  	.irq_mask	= mpic_mask_ipi,
>  	.irq_unmask	= mpic_unmask_ipi,
>  	.irq_eoi	= mpic_end_ipi,
> @@ -991,6 +993,7 @@ static struct irq_chip mpic_ipi_chip = {
>  #endif /* CONFIG_SMP */
>  
>  static struct irq_chip mpic_tm_chip = {
> +	.irq_disable	= mpic_mask_tm,
>  	.irq_mask	= mpic_mask_tm,
>  	.irq_unmask	= mpic_unmask_tm,
>  	.irq_eoi	= mpic_end_irq,
> @@ -1001,6 +1004,7 @@ static struct irq_chip mpic_tm_chip = {
>  static struct irq_chip mpic_irq_ht_chip = {
>  	.irq_startup	= mpic_startup_ht_irq,
>  	.irq_shutdown	= mpic_shutdown_ht_irq,
> +	.irq_disable	= mpic_mask_irq,
>  	.irq_mask	= mpic_mask_irq,
>  	.irq_unmask	= mpic_unmask_ht_irq,
>  	.irq_eoi	= mpic_end_ht_irq,
