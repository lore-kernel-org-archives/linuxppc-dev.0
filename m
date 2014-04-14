Return-Path: <scottwood@freescale.com>
Received: from na01-bn1-obe.outbound.protection.outlook.com
 (mail-bn1blp0184.outbound.protection.outlook.com [207.46.163.184])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BF53214007B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 09:36:03 +1000 (EST)
Message-ID: <1397518552.20280.235.camel@snotra.buserror.net>
Subject: Re: [PATCH 2/2] fsl/mpic_timer: make mpic_timer to support deep
 sleep feature
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Mon, 14 Apr 2014 18:35:52 -0500
In-Reply-To: <1397442250-14886-2-git-send-email-dongsheng.wang@freescale.com>
References: <1397442250-14886-1-git-send-email-dongsheng.wang@freescale.com>
 <1397442250-14886-2-git-send-email-dongsheng.wang@freescale.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc-dev@lists.ozlabs.org, chenhui.zhao@freescale.com,
 jason.jin@freescale.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2014-04-14 at 10:24 +0800, Dongsheng Wang wrote:
> From: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> At T104x platfrom the timer clock will be changed when system going to
> deep sleep.

Could you elaborate on what is changing and why?

> +#include <asm/mpc85xx.h>
>  #include <asm/mpic_timer.h>

So much for, "The driver currently is only tested on fsl chip, but it
can potentially support other global timers complying to OpenPIC
standard."

>  #define FSL_GLOBAL_TIMER		0x1
> @@ -71,8 +74,10 @@ struct timer_group_priv {
>  	struct timer_regs __iomem	*regs;
>  	struct mpic_timer		timer[TIMERS_PER_GROUP];
>  	struct list_head		node;
> +	unsigned long			idle;
>  	unsigned int			timerfreq;
> -	unsigned int			idle;

Why?

> +	unsigned int			suspended_timerfreq;
> +	unsigned int			resume_timerfreq;
>  	unsigned int			flags;
>  	spinlock_t			lock;
>  	void __iomem			*group_tcr;
> @@ -88,6 +93,7 @@ static struct cascade_priv cascade_timer[] = {
>  };
>  
>  static LIST_HEAD(timer_group_list);
> +static int switch_freq_flag;

Needs documentation, and based on "_flag" it should probably be a bool.

>  static void convert_ticks_to_time(struct timer_group_priv *priv,
>  		const u64 ticks, struct timeval *time)
> @@ -423,6 +429,33 @@ struct mpic_timer *mpic_request_timer(irq_handler_t fn, void *dev,
>  }
>  EXPORT_SYMBOL(mpic_request_timer);
>  
> +static void timer_group_get_suspended_freq(struct timer_group_priv *priv)
> +{
> +	struct device_node *np;
> +
> +	np = of_find_compatible_node(NULL, NULL, "fsl,qoriq-clockgen-2.0");
> +	if (!np) {
> +		pr_err("mpic timer: Missing clockgen device node.\n");

Why is it an error to not have a 2.0 QorIQ clockgen?

> +		return;
> +	}
> +
> +	of_property_read_u32(np, "clock-frequency", &priv->suspended_timerfreq);
> +	of_node_put(np);

Shouldn't this go through the clock API?

> +}
> +
> +static int need_to_switch_freq(void)
> +{
> +	u32 svr;
> +
> +	svr = mfspr(SPRN_SVR);
> +	if (SVR_SOC_VER(svr) == SVR_T1040 ||
> +			SVR_SOC_VER(svr) == SVR_T1042)
> +		return 1;

Explain why this is specific to T104x.

-Scott
