Return-Path: <scottwood@freescale.com>
Received: from va3outboundpool.messaging.microsoft.com
 (va3ehsobe006.messaging.microsoft.com [216.32.180.16])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 417412C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  8 Nov 2013 04:35:05 +1100 (EST)
Message-ID: <1383845691.23598.125.camel@snotra.buserror.net>
Subject: Re: [PATCH] powerpc/85xx: don't init the mpic ipi for the SoC which
 has doorbell support
From: Scott Wood <scottwood@freescale.com>
To: Kevin Hao <haokexin@gmail.com>
Date: Thu, 7 Nov 2013 11:34:51 -0600
In-Reply-To: <1383808637-26769-1-git-send-email-haokexin@gmail.com>
References: <1383808637-26769-1-git-send-email-haokexin@gmail.com>
Content-Type: text/plain; charset="UTF-8"
MIME-Version: 1.0
Cc: linuxppc <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2013-11-07 at 15:17 +0800, Kevin Hao wrote:
> It makes no sense to initialize the mpic ipi for the SoC which has
> doorbell support. So set the smp_85xx_ops.probe to NULL for this
> case. Since the smp_85xx_ops.probe is also used in function
> smp_85xx_setup_cpu() to check if we need to invoke
> mpic_setup_this_cpu(), we introduce a new setup_cpu function
> smp_85xx_basic_setup() to remove this dependency.

Is there any harm caused by setting up the IPIs?

What about other MPIC setup, such as setting the current task priority
register?


> Signed-off-by: Kevin Hao <haokexin@gmail.com>
> ---
> 
> Boot test on p2020rdb and p5020ds.
> 
>  arch/powerpc/platforms/85xx/smp.c | 17 +++++++++++------
>  1 file changed, 11 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/85xx/smp.c b/arch/powerpc/platforms/85xx/smp.c
> index 281b7f01df63..d3b310f87ce9 100644
> --- a/arch/powerpc/platforms/85xx/smp.c
> +++ b/arch/powerpc/platforms/85xx/smp.c
> @@ -388,15 +388,18 @@ static void mpc85xx_smp_machine_kexec(struct kimage *image)
>  }
>  #endif /* CONFIG_KEXEC */
>  
> -static void smp_85xx_setup_cpu(int cpu_nr)
> +static void smp_85xx_basic_setup(int cpu_nr)
>  {
> -	if (smp_85xx_ops.probe == smp_mpic_probe)
> -		mpic_setup_this_cpu();
> -
>  	if (cpu_has_feature(CPU_FTR_DBELL))
>  		doorbell_setup_this_cpu();
>  }
>  
> +static void smp_85xx_setup_cpu(int cpu_nr)
> +{
> +	mpic_setup_this_cpu();
> +	smp_85xx_basic_setup(cpu_nr);
> +}
> +
>  static const struct of_device_id mpc85xx_smp_guts_ids[] = {
>  	{ .compatible = "fsl,mpc8572-guts", },
>  	{ .compatible = "fsl,p1020-guts", },
> @@ -411,13 +414,14 @@ void __init mpc85xx_smp_init(void)
>  {
>  	struct device_node *np;
>  
> -	smp_85xx_ops.setup_cpu = smp_85xx_setup_cpu;
>  
>  	np = of_find_node_by_type(NULL, "open-pic");
>  	if (np) {
>  		smp_85xx_ops.probe = smp_mpic_probe;
> +		smp_85xx_ops.setup_cpu = smp_85xx_setup_cpu;
>  		smp_85xx_ops.message_pass = smp_mpic_message_pass;
> -	}
> +	} else
> +		smp_85xx_ops.setup_cpu = smp_85xx_basic_setup;
>  
>  	if (cpu_has_feature(CPU_FTR_DBELL)) {
>  		/*
> @@ -426,6 +430,7 @@ void __init mpc85xx_smp_init(void)
>  		 */
>  		smp_85xx_ops.message_pass = NULL;
>  		smp_85xx_ops.cause_ipi = doorbell_cause_ipi;
> +		smp_85xx_ops.probe = NULL;
>  	}

BTW, what exactly is probe() supposed to be doing?  It looks like its
main effect (with smp_mpic_probe) is to request IPIs, but the caller
seems to treat it mainly as a way to determine CPU count.

I looked at the caller of .probe() (which is smp_prepare_cpus()) to see
what happens when probe is NULL, and the handling of max_cpus doesn't
make much sense.  At first I was concerned by the gratuitous difference
between smp_mpic_probe() using cpu_possible_mask versus
smp_prepare_cpus() using NR_CPUS, but the value isn't even used (all the
code that consumed max_cpus after setting it has been removed), and the
value passed in to smp_prepare_cpus() is ignored.

-Scott
