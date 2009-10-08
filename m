Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id A721DB7088
	for <linuxppc-dev@ozlabs.org>; Fri,  9 Oct 2009 07:13:08 +1100 (EST)
Subject: Re: [PATCH/RFC] powerpc: Fix decrementer setup on 1GHz boards
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Stefan Roese <sr@denx.de>
In-Reply-To: <1255013362-27135-1-git-send-email-sr@denx.de>
References: <1255013362-27135-1-git-send-email-sr@denx.de>
Content-Type: text/plain; charset="UTF-8"
Date: Fri, 09 Oct 2009 07:12:56 +1100
Message-Id: <1255032776.2146.7.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org, Anton Blanchard <anton@samba.org>,
	Detlev Zundel <dzu@denx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2009-10-08 at 16:49 +0200, Stefan Roese wrote:
> We noticed that recent kernels didn't boot on our 1GHz Canyonlands 460EX
> boards anymore. As it seems, patch 8d165db1 [powerpc: Improve
> decrementer accuracy] introduced this problem. The routine div_sc()
> overflows with shift = 32 resulting in this incorrect setup:
> 
> time_init: decrementer frequency = 1000.000012 MHz
> time_init: processor frequency   = 1000.000012 MHz
> clocksource: timebase mult[400000] shift[22] registered
> clockevent: decrementer mult[33] shift[32] cpu[0]
> 
> This patch now introduces a local div_dc64() version of this function
> so that this overflow doesn't happen anymore.

Ugh ? We never expected that the decrementer would be ticking that fast.
This is too fast actually. Somebody at AMCC must be told to stick a
divider in front of the timebase when reaching such frequencies.

Ben.

> 
> Signed-off-by: Stefan Roese <sr@denx.de>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Anton Blanchard <anton@samba.org>
> Cc: Detlev Zundel <dzu@denx.de>
> ---
> Ben, Anton, how should we handle this? Is this patch acceptable? Or how
> should this be solved?
> 
>  arch/powerpc/kernel/time.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/time.c b/arch/powerpc/kernel/time.c
> index 92dc844..3ad729f 100644
> --- a/arch/powerpc/kernel/time.c
> +++ b/arch/powerpc/kernel/time.c
> @@ -882,12 +882,21 @@ static void decrementer_set_mode(enum clock_event_mode mode,
>  		decrementer_set_next_event(DECREMENTER_MAX, dev);
>  }
>  
> +static inline uint64_t div_sc64(unsigned long ticks, unsigned long nsec,
> +				int shift)
> +{
> +	uint64_t tmp = ((uint64_t)ticks) << shift;
> +
> +	do_div(tmp, nsec);
> +	return tmp;
> +}
> +
>  static void __init setup_clockevent_multiplier(unsigned long hz)
>  {
>  	u64 mult, shift = 32;
>  
>  	while (1) {
> -		mult = div_sc(hz, NSEC_PER_SEC, shift);
> +		mult = div_sc64(hz, NSEC_PER_SEC, shift);
>  		if (mult && (mult >> 32UL) == 0UL)
>  			break;
>  
