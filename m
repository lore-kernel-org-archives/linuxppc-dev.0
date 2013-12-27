Return-Path: <scottwood@freescale.com>
Received: from na01-by2-obe.outbound.protection.outlook.com
 (mail-by2lp0241.outbound.protection.outlook.com [207.46.163.241])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id B82472C0090
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 28 Dec 2013 10:59:55 +1100 (EST)
Message-ID: <1388188783.21454.27.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/mpic_timer: fix the time calculation is not
 accurate
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Fri, 27 Dec 2013 17:59:43 -0600
In-Reply-To: <1387766025-46101-1-git-send-email-dongsheng.wang@freescale.com>
References: <1387766025-46101-1-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2013-12-23 at 10:33 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> When the timer GTCCR toggle bit is inverted, we calculated the rest
> of the time is not accurate. So we need to ignore this bit.
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> diff --git a/arch/powerpc/sysdev/mpic_timer.c b/arch/powerpc/sysdev/mpic_timer.c
> index 22d7d57..0fb70c9 100644
> --- a/arch/powerpc/sysdev/mpic_timer.c
> +++ b/arch/powerpc/sysdev/mpic_timer.c
> @@ -41,6 +41,7 @@
>  #define MPIC_TIMER_TCR_ROVR_OFFSET	24
>  
>  #define TIMER_STOP			0x80000000
> +#define GTCCR_TOG			0x80000000
>  #define TIMERS_PER_GROUP		4
>  #define MAX_TICKS			(~0U >> 1)
>  #define MAX_TICKS_CASCADE		(~0U)
> @@ -96,8 +97,15 @@ static void convert_ticks_to_time(struct timer_group_priv *priv,
>  	time->tv_sec = (__kernel_time_t)div_u64(ticks, priv->timerfreq);
>  	tmp_sec = (u64)time->tv_sec * (u64)priv->timerfreq;
>  
> -	time->tv_usec = (__kernel_suseconds_t)
> -		div_u64((ticks - tmp_sec) * 1000000, priv->timerfreq);
> +	time->tv_usec = 0;
> +
> +	/*
> +	 * In some cases tmp_sec may be greater than ticks, because in the
> +	 * process of calculation ticks and tmp_sec will be rounded.
> +	 */
> +	if (tmp_sec <= ticks)
> +		time->tv_usec = (__kernel_suseconds_t)
> +			div_u64((ticks - tmp_sec) * 1000000, priv->timerfreq);

I don't see how this part of the patch relates to the patch description.

-Scott
