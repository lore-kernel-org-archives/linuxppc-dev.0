Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 43AF52C00C4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 27 Aug 2013 17:53:48 +1000 (EST)
Message-ID: <1377590004.3819.120.camel@pasglop>
Subject: Re: [PATCH 1/2] powerpc/irq: remove the unneeded flag PACA_IRQ_EE_EDGE
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kevin Hao <haokexin@gmail.com>
Date: Tue, 27 Aug 2013 17:53:24 +1000
In-Reply-To: <1365643954-20798-2-git-send-email-haokexin@gmail.com>
References: <1365643954-20798-1-git-send-email-haokexin@gmail.com>
 <1365643954-20798-2-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-04-11 at 09:32 +0800, Kevin Hao wrote:
> In order to support the Book3E external proxy, the flag
> PACA_IRQ_EE_EDGE was introduced in patch 7230c564 (powerpc: Rework
> lazy-interrupt handling). But it turns out that this is not needed.
> And it is also not used by any code in the current kernel. According
> to the PowerISA 2.0.6, the content of EPR (External Proxy Register)
> is valid until MSR[EE] is set to 1. Since we never enable the hard irq
> before replaying a external interrupt. That means we still can get
> the valid interrupt vector from EPR when replaying irq.

I assume you understand why that patch is broken and this is superseeded
by your more recent series to actually make use of PACA_IRQ_EE_EDGE
right ? :-)

(Just making sure I can take that one out of patchwork).

> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
>  arch/powerpc/include/asm/hw_irq.h    | 1 -
>  arch/powerpc/kernel/exceptions-64e.S | 1 -
>  arch/powerpc/kernel/irq.c            | 8 --------
>  3 files changed, 10 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index e45c494..8bf0789 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -24,7 +24,6 @@
>  #define PACA_IRQ_DBELL		0x02
>  #define PACA_IRQ_EE		0x04
>  #define PACA_IRQ_DEC		0x08 /* Or FIT */
> -#define PACA_IRQ_EE_EDGE	0x10 /* BookE only */
>  
>  #endif /* CONFIG_PPC64 */
>  
> diff --git a/arch/powerpc/kernel/exceptions-64e.S b/arch/powerpc/kernel/exceptions-64e.S
> index 42a756e..64f2fbd 100644
> --- a/arch/powerpc/kernel/exceptions-64e.S
> +++ b/arch/powerpc/kernel/exceptions-64e.S
> @@ -701,7 +701,6 @@ kernel_dbg_exc:
>  .endm
>  
>  masked_interrupt_book3e_0x500:
> -	// XXX When adding support for EPR, use PACA_IRQ_EE_EDGE
>  	masked_interrupt_book3e PACA_IRQ_EE 1
>  
>  masked_interrupt_book3e_0x900:
> diff --git a/arch/powerpc/kernel/irq.c b/arch/powerpc/kernel/irq.c
> index 4f97fe3..dbc1c05 100644
> --- a/arch/powerpc/kernel/irq.c
> +++ b/arch/powerpc/kernel/irq.c
> @@ -171,14 +171,6 @@ notrace unsigned int __check_irq_replay(void)
>  		return 0x500;
>  
>  #ifdef CONFIG_PPC_BOOK3E
> -	/* Finally check if an EPR external interrupt happened
> -	 * this bit is typically set if we need to handle another
> -	 * "edge" interrupt from within the MPIC "EPR" handler
> -	 */
> -	local_paca->irq_happened &= ~PACA_IRQ_EE_EDGE;
> -	if (happened & PACA_IRQ_EE_EDGE)
> -		return 0x500;
> -
>  	local_paca->irq_happened &= ~PACA_IRQ_DBELL;
>  	if (happened & PACA_IRQ_DBELL)
>  		return 0x280;
