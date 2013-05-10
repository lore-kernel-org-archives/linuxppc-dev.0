Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client did not present a certificate)
 by ozlabs.org (Postfix) with ESMTPS id 9BDA92C009B
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 10 May 2013 17:00:57 +1000 (EST)
Message-ID: <1368169245.4524.10.camel@pasglop>
Subject: Re: [PATCH v2 1/4] powerpc: hard_irq_disable(): Call
 trace_hardirqs_off after disabling
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Scott Wood <scottwood@freescale.com>
Date: Fri, 10 May 2013 17:00:45 +1000
In-Reply-To: <1368155384-11035-2-git-send-email-scottwood@freescale.com>
References: <1368155384-11035-1-git-send-email-scottwood@freescale.com>
 <1368155384-11035-2-git-send-email-scottwood@freescale.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, Alexander Graf <agraf@suse.de>,
 kvm-ppc@vger.kernel.org, kvm@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-05-09 at 22:09 -0500, Scott Wood wrote:
> lockdep.c has this:
>         /*
>          * So we're supposed to get called after you mask local IRQs,
>          * but for some reason the hardware doesn't quite think you did
>          * a proper job.
>          */
> 	if (DEBUG_LOCKS_WARN_ON(!irqs_disabled()))
> 		return;
> 
> Since irqs_disabled() is based on soft_enabled(), that (not just the
> hard EE bit) needs to be 0 before we call trace_hardirqs_off.
> 
> Signed-off-by: Scott Wood <scottwood@freescale.com>

Oops ;-)

I'll apply that to my tree and will send it to Linus right after -rc1,
the rest will go the normal way for KVM patches.

Cheers,
Ben.

> ---
>  arch/powerpc/include/asm/hw_irq.h |    5 +++--
>  1 file changed, 3 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/hw_irq.h b/arch/powerpc/include/asm/hw_irq.h
> index d615b28..ba713f1 100644
> --- a/arch/powerpc/include/asm/hw_irq.h
> +++ b/arch/powerpc/include/asm/hw_irq.h
> @@ -96,11 +96,12 @@ static inline bool arch_irqs_disabled(void)
>  #endif
>  
>  #define hard_irq_disable()	do {			\
> +	u8 _was_enabled = get_paca()->soft_enabled;	\
>  	__hard_irq_disable();				\
> -	if (local_paca->soft_enabled)			\
> -		trace_hardirqs_off();			\
>  	get_paca()->soft_enabled = 0;			\
>  	get_paca()->irq_happened |= PACA_IRQ_HARD_DIS;	\
> +	if (_was_enabled)				\
> +		trace_hardirqs_off();			\
>  } while(0)
>  
>  static inline bool lazy_irq_pending(void)
