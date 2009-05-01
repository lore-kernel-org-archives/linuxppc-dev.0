Return-Path: <galak@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id D903BDDE0D
	for <linuxppc-dev@ozlabs.org>; Sat,  2 May 2009 06:53:38 +1000 (EST)
Message-Id: <D823E17E-3066-45D5-A33D-539FA0883B55@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
To: Timur Tabi <timur@freescale.com>
In-Reply-To: <1240859144-20893-1-git-send-email-timur@freescale.com>
Content-Type: text/plain; charset=US-ASCII; format=flowed; delsp=yes
Mime-Version: 1.0 (Apple Message framework v930.3)
Subject: Re: [PATCH v6] introduce macro spin_event_timeout()
Date: Fri, 1 May 2009 15:51:19 -0500
References: <1240859144-20893-1-git-send-email-timur@freescale.com>
Cc: scottwood@freescale.com, linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 27, 2009, at 2:05 PM, Timur Tabi wrote:

> The macro spin_event_timeout() takes a condition and timeout value
> (in microseconds) as parameters.  It spins until either the  
> condition is true
> or the timeout expires.  It returns the result of the condition when  
> the loop
> was terminated.
>
> This primary purpose of this macro is to poll on a hardware register  
> until a
> status bit changes.  The timeout ensures that the loop still  
> terminates if the
> bit doesn't change as expected.  This macro makes it easier for driver
> developers to perform this kind of operation properly.
>
> Signed-off-by: Timur Tabi <timur@freescale.com>
> ---
>
> I'm making this a PowerPC-specific patch because I want to use
> tb_ticks_per_usec, which does not exist on all other platforms.  I  
> don't want
> to use jiffies because jiffies works only when interrupts are  
> enabled, and
> the resolution may not be fine enough.
>
> arch/powerpc/include/asm/delay.h |   27 +++++++++++++++++++++++++++
> 1 files changed, 27 insertions(+), 0 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/delay.h b/arch/powerpc/include/ 
> asm/delay.h
> index f9200a6..1939e0f 100644
> --- a/arch/powerpc/include/asm/delay.h
> +++ b/arch/powerpc/include/asm/delay.h
> @@ -2,6 +2,8 @@
> #define _ASM_POWERPC_DELAY_H
> #ifdef __KERNEL__
>
> +#include <asm/time.h>
> +
> /*
>  * Copyright 1996, Paul Mackerras.
>  *
> @@ -30,5 +32,30 @@ extern void udelay(unsigned long usecs);
> #define mdelay(n)	udelay((n) * 1000)
> #endif
>
> +/**
> + * spin_event_timeout - spin until a condition gets true or a  
> timeout elapses
> + * @condition: a C expression to evalate
> + * @timeout: timeout, in microseconds
> + * @delay: the number of microseconds to delay between eache  
> evaluation of
> + *         @condition
> + * @rc: the last value of the condition
> + *
> + * The process spins until the condition evaluates to true (non- 
> zero) or the
> + * timeout elapses.  Upon exit, @rc contains the value of the  
> condition. This
> + * allows you to test the condition without incurring any side  
> effects.
> + *
> + * This primary purpose of this macro is to poll on a hardware  
> register
> + * until a status bit changes.  The timeout ensures that the loop  
> still
> + * terminates if the bit never changes.  The delay is for devices  
> that need a
> + * delay in between successive reads.
> + */
> +#define spin_event_timeout(condition, timeout, delay,  
> rc)                   \
> + 
> {                                                                           \
> +	unsigned long __loops = tb_ticks_per_usec *  
> timeout;                \
> +	unsigned long __start =  
> get_tbl();                                  \
> +	while (!(rc = (condition)) && (tb_ticks_since(__start) <=  
> __loops)) \
> +		udelay(delay);                                      	    \
> +}
> +

I wouldn't call it spin_event_timeout as its a bit too generic of a  
name for something that is arch specific.

- k
