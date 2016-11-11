Return-Path: <alistair@popple.id.au>
Received: from ipmail04.adl6.internode.on.net (ipmail04.adl6.internode.on.net
 [150.101.137.141])
 by lists.ozlabs.org (Postfix) with ESMTP id 3tFM5w2lFMzDvq4
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 12:00:20 +1100 (AEDT)
From: Alistair Popple <alistair@popple.id.au>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 2/3] powerpc: add struct smp_ops_t.cause_nmi_ipi operation
Date: Fri, 11 Nov 2016 12:00:14 +1100
Message-ID: <2375478.VYA2BGbrTl@new-mexico>
In-Reply-To: <20161108140125.21455-3-npiggin@gmail.com>
References: <20161108140125.21455-1-npiggin@gmail.com>
 <20161108140125.21455-3-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 9 Nov 2016 01:01:24 AM Nicholas Piggin wrote:
> Allow platforms to provide an NMI IPI, and wire that to the NMI
> system.
> ---
>  arch/powerpc/include/asm/smp.h            |  5 +++++
>  arch/powerpc/kernel/smp.c                 | 21 ++++++++++++++++-----
>  arch/powerpc/platforms/85xx/smp.c         |  1 +
>  arch/powerpc/platforms/86xx/mpc86xx_smp.c |  1 +
>  arch/powerpc/platforms/chrp/smp.c         |  1 +
>  arch/powerpc/platforms/powermac/smp.c     |  1 +
>  arch/powerpc/platforms/powernv/smp.c      |  1 +
>  arch/powerpc/platforms/pseries/smp.c      |  1 +
>  8 files changed, 27 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/smp.h b/arch/powerpc/include/asm/smp.h
> index 055918d..15521c1 100644
> --- a/arch/powerpc/include/asm/smp.h
> +++ b/arch/powerpc/include/asm/smp.h
> @@ -37,11 +37,15 @@ extern int cpu_to_chip_id(int cpu);
>  
>  #ifdef CONFIG_SMP
>  
> +#define SMP_OP_NMI_TYPE_SAFE	1
> +#define SMP_OP_NMI_TYPE_HARD	2
> +
>  struct smp_ops_t {
>  	void  (*message_pass)(int cpu, int msg);
>  #ifdef CONFIG_PPC_SMP_MUXED_IPI
>  	void  (*cause_ipi)(int cpu, unsigned long data);
>  #endif
> +	int   (*cause_nmi_ipi)(int cpu, int type);
>  	void  (*probe)(void);
>  	int   (*kick_cpu)(int nr);
>  	void  (*setup_cpu)(int nr);
> @@ -53,6 +57,7 @@ struct smp_ops_t {
>  	int   (*cpu_bootable)(unsigned int nr);
>  };
>  
> +extern int smp_handle_nmi_ipi(struct pt_regs *regs);
>  extern void smp_send_debugger_break(void);
>  extern void start_secondary_resume(void);
>  extern void smp_generic_give_timebase(void);
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index 959d9dc..b3133e9 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -425,8 +425,10 @@ int smp_handle_nmi_ipi(struct pt_regs *regs)
>  	return ret;
>  }
>  
> -static void do_smp_send_nmi_ipi(int cpu)
> +static void do_smp_send_nmi_ipi(int cpu, int type)
>  {
> +	if (smp_ops->cause_nmi_ipi && smp_ops->cause_nmi_ipi(cpu, type))
> +		return;
>  	do_message_pass(cpu, PPC_MSG_NMI_IPI_SAFE);
>  }
>  
> @@ -453,9 +455,6 @@ int smp_send_nmi_ipi(int cpu, int function, void *data,
>  	if (unlikely(!smp_ops))
>  		return 0;
>  
> -	/* Have no real NMI capability yet */
> -	safe_udelay += hard_udelay;
> -
>  	get_online_cpus();
>  
>  	/* Take the nmi_ipi_busy count/lock with interrupts hard disabled */
> @@ -482,7 +481,7 @@ int smp_send_nmi_ipi(int cpu, int function, void *data,
>  
>  	if (safe_udelay) {
>  		for_each_cpu(c, &nmi_ipi_pending_mask)
> -			do_smp_send_nmi_ipi(c);
> +			do_smp_send_nmi_ipi(c, SMP_OP_NMI_TYPE_SAFE);
>  
>  		do {
>  			safe_udelay--;
> @@ -492,6 +491,18 @@ int smp_send_nmi_ipi(int cpu, int function, void *data,
>  		} while (safe_udelay);
>  	}
>  
> +	if (hard_udelay) {

So if the "safe" NMI fails we go onto the one that might break your system? 
Why would the safe NMI fail? Does it only fail when other CPUs are stuck with 
interrupts turned off? Or are there other cases? I'm just wondering how safe 
it is - is there a chance that the safe one might corrupt state we're 
interested in debugging?

I'm fairly confident we can make the hard NMI reliable (although perhaps not 
as good as the safe variant) so the safe one may not be worth it if there's a 
risk we loose debug state.

> +		for_each_cpu(c, &nmi_ipi_pending_mask)

Doesn't the H_CALL support a flag for all but self? For PowerNV/OPAL I was 
looking to implement this as well and on bare-metal it is (perhaps marginally) 
more efficient to loop through the CPUs in firmware.

Of course the issue with that is that I'm not sure firmware is aware of 
cpu_online_mask so ALLBUTSELF would reset all CPUs, not just online ones. Not 
sure if that would be an issue?

- Alistair

> +			do_smp_send_nmi_ipi(c, SMP_OP_NMI_TYPE_HARD);
> +
> +		do {
> +			hard_udelay--;
> +			udelay(1);
> +			if (cpumask_empty(&nmi_ipi_pending_mask))
> +				goto done;
> +		} while (hard_udelay);
> +	}
> +
>  	ret = 0; /* Could not gather all CPUs */
>  	cpumask_clear(&nmi_ipi_pending_mask);
>  done:
> diff --git a/arch/powerpc/platforms/85xx/smp.c 
b/arch/powerpc/platforms/85xx/smp.c
> index fe9f19e..cde7beb 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -343,6 +343,7 @@ static int smp_85xx_kick_cpu(int nr)
>  }
>  
>  struct smp_ops_t smp_85xx_ops = {
> +	.cause_nmi_ipi = NULL,
>  	.kick_cpu = smp_85xx_kick_cpu,
>  	.cpu_bootable = smp_generic_cpu_bootable,
>  #ifdef CONFIG_HOTPLUG_CPU
> diff --git a/arch/powerpc/platforms/86xx/mpc86xx_smp.c 
b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
> index af09bae..020e84a 100644
> --- a/arch/powerpc/platforms/86xx/mpc86xx_smp.c
> +++ b/arch/powerpc/platforms/86xx/mpc86xx_smp.c
> @@ -105,6 +105,7 @@ smp_86xx_setup_cpu(int cpu_nr)
>  
>  
>  struct smp_ops_t smp_86xx_ops = {
> +	.cause_nmi_ipi = NULL,
>  	.message_pass = smp_mpic_message_pass,
>  	.probe = smp_mpic_probe,
>  	.kick_cpu = smp_86xx_kick_cpu,
> diff --git a/arch/powerpc/platforms/chrp/smp.c 
b/arch/powerpc/platforms/chrp/smp.c
> index b6c9a0d..1451504 100644
> --- a/arch/powerpc/platforms/chrp/smp.c
> +++ b/arch/powerpc/platforms/chrp/smp.c
> @@ -44,6 +44,7 @@ static void smp_chrp_setup_cpu(int cpu_nr)
>  
>  /* CHRP with openpic */
>  struct smp_ops_t chrp_smp_ops = {
> +	.cause_nmi_ipi = NULL,
>  	.message_pass = smp_mpic_message_pass,
>  	.probe = smp_mpic_probe,
>  	.kick_cpu = smp_chrp_kick_cpu,
> diff --git a/arch/powerpc/platforms/powermac/smp.c 
b/arch/powerpc/platforms/powermac/smp.c
> index c9eb7d6..1d76e15 100644
> --- a/arch/powerpc/platforms/powermac/smp.c
> +++ b/arch/powerpc/platforms/powermac/smp.c
> @@ -446,6 +446,7 @@ void __init smp_psurge_give_timebase(void)
>  struct smp_ops_t psurge_smp_ops = {
>  	.message_pass	= NULL,	/* Use smp_muxed_ipi_message_pass */
>  	.cause_ipi	= smp_psurge_cause_ipi,
> +	.cause_nmi_ipi	= NULL,
>  	.probe		= smp_psurge_probe,
>  	.kick_cpu	= smp_psurge_kick_cpu,
>  	.setup_cpu	= smp_psurge_setup_cpu,
> diff --git a/arch/powerpc/platforms/powernv/smp.c 
b/arch/powerpc/platforms/powernv/smp.c
> index c789258..092ec1f 100644
> --- a/arch/powerpc/platforms/powernv/smp.c
> +++ b/arch/powerpc/platforms/powernv/smp.c
> @@ -244,6 +244,7 @@ static int pnv_cpu_bootable(unsigned int nr)
>  static struct smp_ops_t pnv_smp_ops = {
>  	.message_pass	= smp_muxed_ipi_message_pass,
>  	.cause_ipi	= NULL,	/* Filled at runtime by xics_smp_probe() */
> +	.cause_nmi_ipi	= NULL,
>  	.probe		= xics_smp_probe,
>  	.kick_cpu	= pnv_smp_kick_cpu,
>  	.setup_cpu	= pnv_smp_setup_cpu,
> diff --git a/arch/powerpc/platforms/pseries/smp.c 
b/arch/powerpc/platforms/pseries/smp.c
> index f6f83ae..0f6522c 100644
> --- a/arch/powerpc/platforms/pseries/smp.c
> +++ b/arch/powerpc/platforms/pseries/smp.c
> @@ -209,6 +209,7 @@ static __init void pSeries_smp_probe(void)
>  static struct smp_ops_t pseries_smp_ops = {
>  	.message_pass	= NULL,	/* Use smp_muxed_ipi_message_pass */
>  	.cause_ipi	= NULL,	/* Filled at runtime by pSeries_smp_probe() */
> +	.cause_nmi_ipi	= NULL,
>  	.probe		= pSeries_smp_probe,
>  	.kick_cpu	= smp_pSeries_kick_cpu,
>  	.setup_cpu	= smp_setup_cpu,
> 
