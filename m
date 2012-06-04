Return-Path: <anton@samba.org>
Date: Mon, 4 Jun 2012 12:31:04 +1000
From: Anton Blanchard <anton@samba.org>
To: Paul Mackerras <paulus@samba.org>
Subject: Re: [PATCH] powerpc/time: Sanity check of decrementer expiration is
 necessary
Message-ID: <20120604123104.20951358@kryten>
In-Reply-To: <20120601100102.GA11714@pale.ozlabs.ibm.com>
References: <20120601100102.GA11714@pale.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Paul,

> This reverts 68568add2c ("powerpc/time: Remove unnecessary sanity
> check of decrementer expiration").  We do need to check whether we
> have reached the expiration time of the next event, because we
> sometimes get an early decrementer interrupt, most notably when we
> set the decrementer to 1 in arch_irq_work_raise().  The effect of not
> having the sanity check is that if timer_interrupt() gets called
> early, we leave the decrementer set to its maximum value, which means
> we then don't get any more decrementer interrupts for about 4 seconds
> (or longer, depending on timebase frequency).  I saw these pauses as
> a consequence of getting a stray hypervisor decrementer interrupt
> left over from exiting a KVM guest.

Urgh, sorry for that mess.

Acked-by: Anton Blanchard <anton@samba.org>

Anton

> This isn't quite a straight revert because of changes to the
> surrounding code, but it restores the same algorithm as was
> previously used.
> 
> Cc: stable@kernel.org
> Cc: Anton Blanchard <anton@samba.org>
> Acked-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Signed-off-by: Paul Mackerras <paulus@samba.org>
> ---
> If there are no objections, I'll send this to Linus shortly.  This
> regression is present in 3.3 and 3.4 as well as current upstream.
> 
>  arch/powerpc/kernel/time.c |   14 +++++++++++---
>  1 file changed, 11 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 99a995c..be171ee 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -475,6 +475,7 @@ void timer_interrupt(struct pt_regs * regs)
>  	struct pt_regs *old_regs;
>  	u64 *next_tb = &__get_cpu_var(decrementers_next_tb);
>  	struct clock_event_device *evt =
> &__get_cpu_var(decrementers);
> +	u64 now;
>  
>  	/* Ensure a positive value is written to the decrementer, or
> else
>  	 * some CPUs will continue to take decrementer exceptions.
> @@ -509,9 +510,16 @@ void timer_interrupt(struct pt_regs * regs)
>  		irq_work_run();
>  	}
>  
> -	*next_tb = ~(u64)0;
> -	if (evt->event_handler)
> -		evt->event_handler(evt);
> +	now = get_tb_or_rtc();
> +	if (now >= *next_tb) {
> +		*next_tb = ~(u64)0;
> +		if (evt->event_handler)
> +			evt->event_handler(evt);
> +	} else {
> +		now = *next_tb - now;
> +		if (now <= DECREMENTER_MAX)
> +			set_dec((int)now);
> +	}
>  
>  #ifdef CONFIG_PPC64
>  	/* collect purr register values often, for accurate
> calculations */
