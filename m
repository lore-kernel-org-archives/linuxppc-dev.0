Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: tony@bakeyournoodle.com (Tony Breeds)
Subject: Re: [PATCH v2] Fix regression. Make hot unlplug of CPU0 work again. 
In-reply-to: <20071011073040.GD9814@bakeyournoodle.com> 
References: <20071005070519.GQ9814@bakeyournoodle.com>
	<200710051716.l95HG1cV019434@sullivan.realtime.net>
	<20071011073040.GD9814@bakeyournoodle.com>
Date: Thu, 11 Oct 2007 18:37:03 +1000
Message-ID: <12111.1192091823@neuling.org>
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>,
	Milton Miller <miltonm@bga.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

In message <20071011073040.GD9814@bakeyournoodle.com> you wrote:
> 
> Early in the 2.6.23 cycle we broke the ability to offline cpu0
> (7ccb4a662462616f6be5053e26b79580e02f1529).  This patch fixes that by
> ensuring that the (xics)  default irq server, will not be 0 when taking
> cpu0 offline.
> 
> Also catches a use of irq, when virq should be used (I think that's the
> last one).
> 
> This patch also include the fix from Milton which makes JS21 work
> aswell. In the commit message for that patch Milton writes:
> 	xics_set_affinity no longer looks at the cpu_mask arg, instead
> 	get_irq_server reads it from the irq descriptor.

This doesn't fix the problem for me.  

If I offline CPU0, then online it again, it's fine, but doing the same
for CPU1 kills the machine.

Mikey

> 
> Signed-off-by: Tony Breeds <tony@bakeyournoodle.com>
> Signed-off-by: Milton Miller <miltonm@bga.com>
> 
> ---
> Milton also says in his patch:
> > A more complete fix might be to pass the cpu_mask struct to get_irq_server,
> > but kernel/irq/manage.c currently sets the descriptor first.
> 
>  arch/powerpc/platforms/pseries/xics.c |   11 ++++++++++-
>  1 files changed, 10 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/pseries/xics.c b/arch/powerpc/platforms/p
series/xics.c
> index f0b5ff1..217ae5d 100644
> --- a/arch/powerpc/platforms/pseries/xics.c
> +++ b/arch/powerpc/platforms/pseries/xics.c
> @@ -837,6 +837,15 @@ void xics_migrate_irqs_away(void)
>  	/* Allow IPIs again... */
>  	xics_set_cpu_priority(cpu, DEFAULT_PRIORITY);
>  
> +	/* It would be bad to migrate any IRQs to the CPU we're taking down */
> +	if (default_server == cpu) {
> +		unsigned int new_server = first_cpu(cpu_online_map);
> +
> +		default_server = get_hard_smp_processor_id(new_server);
> +		printk(KERN_WARNING "%s: default server was %d, reset to %d\n",
> +		       __func__, cpu, default_server);
> +	}
> +
>  	for_each_irq(virq) {
>  		struct irq_desc *desc;
>  		int xics_status[2];
> @@ -881,8 +890,8 @@ void xics_migrate_irqs_away(void)
>  		       virq, cpu);
>  
>  		/* Reset affinity to all cpus */
> +		irq_desc[virq].affinity = CPU_MASK_ALL;
>  		desc->chip->set_affinity(virq, CPU_MASK_ALL);
> -		irq_desc[irq].affinity = CPU_MASK_ALL;
>  unlock:
>  		spin_unlock_irqrestore(&desc->lock, flags);
>  	}
> 
> Yours Tony
> 
>   linux.conf.au        http://linux.conf.au/ || http://lca2008.linux.org.au/
>   Jan 28 - Feb 02 2008 The Australian Linux Technical Conference!
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
> 
