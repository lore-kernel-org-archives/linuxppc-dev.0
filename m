Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id BB23EB7048
 for <linuxppc-dev@ozlabs.org>; Fri, 15 Jun 2012 16:02:17 +1000 (EST)
Message-ID: <1339740132.9220.183.camel@pasglop>
Subject: Re: [PATCH v2] Make hard_irq_disable() actually hard-disable
 interrupts
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Paul Mackerras <paulus@samba.org>
Date: Fri, 15 Jun 2012 16:02:12 +1000
In-Reply-To: <20120615045139.GA11041@pale.ozlabs.ibm.com>
References: <20120615045139.GA11041@pale.ozlabs.ibm.com>
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

On Fri, 2012-06-15 at 14:51 +1000, Paul Mackerras wrote:
> At present, hard_irq_disable() does nothing on powerpc because of
> this code in include/linux/interrupt.h:
> 
> #ifndef hard_irq_disable
> #define hard_irq_disable()      do { } while(0)
> #endif
> 
> So we need to make our hard_irq_disable be a macro.
> 
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Paul Mackerras <paulus@samba.org>

Add:

CC: <stable@kernel.org> [v3.4]

Before sending to Linus so it hits stable automagically.

Cheers,
Ben.

> --
>  arch/powerpc/include/asm/hw_irq.h |    3 +++
>  1 file changed, 3 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index c9aac24..32b394f 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -100,6 +100,9 @@ static inline void hard_irq_disable(void)
>  	get_paca()->irq_happened |= PACA_IRQ_HARD_DIS;
>  }
>  
> +/* include/linux/interrupt.h needs hard_irq_disable to be a macro */
> +#define hard_irq_disable	hard_irq_disable
> +
>  /*
>   * This is called by asynchronous interrupts to conditionally
>   * re-enable hard interrupts when soft-disabled after having
