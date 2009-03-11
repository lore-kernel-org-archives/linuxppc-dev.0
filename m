Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 43160DE21D
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Mar 2009 13:22:09 +1100 (EST)
Subject: Re: [patch 16/18] powerpc: convert obsolete hw_interrupt_type to
	struct irq_chip
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Thomas Gleixner <tglx@linutronix.de>
In-Reply-To: <20090311003237.169865866@linutronix.de>
References: <20090311003204.592133594@linutronix.de>
	<20090311003237.169865866@linutronix.de>
Content-Type: text/plain
Date: Wed, 11 Mar 2009 13:19:49 +1100
Message-Id: <1236737989.7086.36.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Andrew Morton <akpm@linux-foundation.org>,
	Ingo Molnar <mingo@elte.hu>, LKML <linux-kernel@vger.kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Wed, 2009-03-11 at 00:46 +0000, Thomas Gleixner wrote:
> plain text document attachment
> (powerpc-convert-obsolete-hw-interrupt-type.patch)
> Impact: cleanup
> 
> Convert the last remaining users to struct irq_chip.

Ack too, same comment, happy to have that one in powerpc.

Ben.

> Signed-off-by: Thomas Gleixner <tglx@linutronix.de>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: linuxppc-dev@ozlabs.org
> ---
>  arch/powerpc/include/asm/hw_irq.h     |    2 +-
>  arch/powerpc/platforms/powermac/pic.h |    2 +-
>  2 files changed, 2 insertions(+), 2 deletions(-)
> 
> Index: linux-2.6/arch/powerpc/include/asm/hw_irq.h
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/include/asm/hw_irq.h
> +++ linux-2.6/arch/powerpc/include/asm/hw_irq.h
> @@ -129,7 +129,7 @@ static inline int irqs_disabled_flags(un
>   * interrupt-retrigger: should we handle this via lost interrupts and IPIs
>   * or should we not care like we do now ? --BenH.
>   */
> -struct hw_interrupt_type;
> +struct irq_chip;
>  
>  #endif	/* __KERNEL__ */
>  #endif	/* _ASM_POWERPC_HW_IRQ_H */
> Index: linux-2.6/arch/powerpc/platforms/powermac/pic.h
> ===================================================================
> --- linux-2.6.orig/arch/powerpc/platforms/powermac/pic.h
> +++ linux-2.6/arch/powerpc/platforms/powermac/pic.h
> @@ -3,7 +3,7 @@
>  
>  #include <linux/irq.h>
>  
> -extern struct hw_interrupt_type pmac_pic;
> +extern struct irq_chip pmac_pic;
>  
>  extern void pmac_pic_init(void);
>  extern int pmac_get_irq(void);
> 
