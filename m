Return-Path: <scottwood@freescale.com>
Received: from na01-bl2-obe.outbound.protection.outlook.com
 (mail-bl2lp0210.outbound.protection.outlook.com [207.46.163.210])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id E35F21400D8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Apr 2014 09:27:34 +1000 (EST)
Message-ID: <1397518031.20280.229.camel@snotra.buserror.net>
Subject: Re: [PATCH 1/2] powerpc/mpc85xx: add two functions to get suspend
 state which is standby or mem
From: Scott Wood <scottwood@freescale.com>
To: Dongsheng Wang <dongsheng.wang@freescale.com>
Date: Mon, 14 Apr 2014 18:27:11 -0500
In-Reply-To: <1397442250-14886-1-git-send-email-dongsheng.wang@freescale.com>
References: <1397442250-14886-1-git-send-email-dongsheng.wang@freescale.com>
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
> Add set_pm_suspend_state & pm_suspend_state functions to set/get suspend state.
> When system going to sleep, devices can get the system suspend state(STANDBY/MEM)
> through pm_suspend_state function and handle different situations.
> 
> Signed-off-by: Wang Dongsheng <dongsheng.wang@freescale.com>
> 
> diff --git a/arch/powerpc/platforms/85xx/common.c b/arch/powerpc/platforms/85xx/common.c
> index b564b5e..3853d43 100644
> --- a/arch/powerpc/platforms/85xx/common.c
> +++ b/arch/powerpc/platforms/85xx/common.c
> @@ -8,6 +8,7 @@
>  
>  #include <linux/of_irq.h>
>  #include <linux/of_platform.h>
> +#include <linux/suspend.h>
>  
>  #include <asm/qe.h>
>  #include <sysdev/cpm2_pic.h>
> @@ -47,6 +48,19 @@ int __init mpc85xx_common_publish_devices(void)
>  {
>  	return of_platform_bus_probe(NULL, mpc85xx_common_ids, NULL);
>  }
> +
> +static suspend_state_t pm_state;
> +
> +void set_pm_suspend_state(suspend_state_t state)
> +{
> +	pm_state = state;
> +}
> +
> +suspend_state_t pm_suspend_state(void)
> +{
> +	return pm_state;
> +}

These need to be namespaced to indicate that they apply only to mpc85xx.
Where do you plan on using these from, that mpc85xx can be safely
assumed?

This seems like a feature that should be implemented in generic code
instead.

-Scott
