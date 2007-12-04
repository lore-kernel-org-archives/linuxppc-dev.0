Return-Path: <benh@kernel.crashing.org>
Subject: Re: [PATCH 4/7] powerpc: Rework the
	machine_[restart|power_off|halt] routines
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Mark A. Greer" <mgreer@mvista.com>
In-Reply-To: <20071204054718.GE27862@mag.az.mvista.com>
References: <20071204053736.GA27862@mag.az.mvista.com>
	<20071204054718.GE27862@mag.az.mvista.com>
Content-Type: text/plain
Date: Tue, 04 Dec 2007 18:20:36 +1100
Message-Id: <1196752836.13230.262.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev <Linuxppc-dev@ozlabs.org>
Reply-To: benh@kernel.crashing.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Mon, 2007-12-03 at 22:47 -0700, Mark A. Greer wrote:
> From: Mark A. Greer <mgreer@mvista.com>
> 
> Factor out common code from the machine_xxx routines and make them better
> handle a ppc_md hook that doesn't exist or fails better.  In particular,
> have machine_power_off() try ppc_md.halt if ppc_md.power_off is NULL or fails,
> and have machine_halt() try to power off when ppc_md.halt is NULL or fails.
> 
> Signed-off-by: Mark A. Greer <mgreer@mvista.com>

Quick glance... looks fine.

> ---
>  arch/powerpc/kernel/setup-common.c |   40 ++++++++++++++-------------
>  1 file changed, 22 insertions(+), 18 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 6adb5a1..1f8f9aa 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -105,17 +105,23 @@ void machine_shutdown(void)
>  		ppc_md.machine_shutdown();
>  }
>  
> -void machine_restart(char *cmd)
> +static void default_halt(const char *s)
>  {
> -	machine_shutdown();
> -	if (ppc_md.restart)
> -		ppc_md.restart(cmd);
>  #ifdef CONFIG_SMP
>  	smp_send_stop();
>  #endif
> -	printk(KERN_EMERG "System Halted, OK to turn off power\n");
> +	printk(KERN_EMERG "%s", s);
>  	local_irq_disable();
> -	while (1) ;
> +	while (1);
> +}
> +
> +void machine_restart(char *cmd)
> +{
> +	machine_shutdown();
> +	if (ppc_md.restart)
> +		ppc_md.restart(cmd);
> +	default_halt("System not restarted; halting instead.\n"
> +			"OK to turn off power\n");
>  }
>  
>  void machine_power_off(void)
> @@ -123,12 +129,10 @@ void machine_power_off(void)
>  	machine_shutdown();
>  	if (ppc_md.power_off)
>  		ppc_md.power_off();
> -#ifdef CONFIG_SMP
> -	smp_send_stop();
> -#endif
> -	printk(KERN_EMERG "System Halted, OK to turn off power\n");
> -	local_irq_disable();
> -	while (1) ;
> +	printk(KERN_EMERG "System not powered off; halting instead.\n");
> +	if (ppc_md.halt)
> +		ppc_md.halt();
> +	default_halt("OK to turn off power\n");
>  }
>  /* Used by the G5 thermal driver */
>  EXPORT_SYMBOL_GPL(machine_power_off);
> @@ -141,12 +145,12 @@ void machine_halt(void)
>  	machine_shutdown();
>  	if (ppc_md.halt)
>  		ppc_md.halt();
> -#ifdef CONFIG_SMP
> -	smp_send_stop();
> -#endif
> -	printk(KERN_EMERG "System Halted, OK to turn off power\n");
> -	local_irq_disable();
> -	while (1) ;
> +	if (ppc_md.power_off) {
> +		printk(KERN_EMERG "System not halted; powering off instead.\n");
> +		ppc_md.power_off();
> +		printk(KERN_EMERG "Poweroff failed.\n");
> +	}
> +	default_halt("OK to turn off power\n");
>  }
>  
> 
