Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9BBAF1007D1
 for <linuxppc-dev@ozlabs.org>; Thu, 14 Jun 2012 21:34:08 +1000 (EST)
Message-ID: <1339673643.9220.162.camel@pasglop>
Subject: Re: [PATCH] Make hard_irq_disable() actually hard-disable interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Date: Thu, 14 Jun 2012 21:34:03 +1000
In-Reply-To: <20120614103112.GA15685@bloggs.ozlabs.ibm.com>
References: <20120614103112.GA15685@bloggs.ozlabs.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-06-14 at 20:31 +1000, Paul Mackerras wrote:
> At present, hard_irq_disable() does nothing because of this code in
> include/linux/interrupt.h:
> 
> #ifndef hard_irq_disable
> #define hard_irq_disable()	do { } while(0)
> #endif
> 
> So we need to make our hard_irq_disable() be a macro.
> 
> Signed-off-by: Paul Mackerras <paulus@samba.org>

This was broken by my rewrite of the lazy irq stuff when I turned that
from a macro to a function. So it should be CC'ed to stable 3.4.

Also I think it's simpler (and we do that commonly) to just do

#define hard_irq_disable hard_irq_disable

Cheers,
Ben.

> ---
>  arch/powerpc/include/asm/hw_irq.h |    3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index c9aac24..d8f873f 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -93,12 +93,13 @@ static inline bool arch_irqs_disabled(void)
>  #define __hard_irq_disable()	__mtmsrd(local_paca->kernel_msr, 1)
>  #endif
>  
> -static inline void hard_irq_disable(void)
> +static inline void _hard_irq_disable(void)
>  {
>  	__hard_irq_disable();
>  	get_paca()->soft_enabled = 0;
>  	get_paca()->irq_happened |= PACA_IRQ_HARD_DIS;
>  }
> +#define hard_irq_disable()	_hard_irq_disable()
>  
>  /*
>   * This is called by asynchronous interrupts to conditionally
