Return-Path: <galak@kernel.crashing.org>
Received: from nommos.sslcatacombnetworking.com
	(nommos.sslcatacombnetworking.com [67.18.224.114])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTP id 81B7967A64
	for <linuxppc-dev@ozlabs.org>; Wed, 28 Jun 2006 14:49:04 +1000 (EST)
In-Reply-To: <20060620084726.GC30974@krispykreme>
References: <20060620084726.GC30974@krispykreme>
Mime-Version: 1.0 (Apple Message framework v750)
Content-Type: text/plain; charset=US-ASCII; delsp=yes; format=flowed
Message-Id: <0107ED1F-B674-48C3-AA07-BDF9FD2F7678@kernel.crashing.org>
From: Kumar Gala <galak@kernel.crashing.org>
Subject: Re: [PATCH] powerpc: support ibm,extended-*-frequency properties
Date: Tue, 27 Jun 2006 23:48:57 -0500
To: Anton Blanchard <anton@samba.org>
Cc: linuxppc-dev@ozlabs.org, paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 20, 2006, at 3:47 AM, Anton Blanchard wrote:

>
> Support the ibm,extended-*-frequency properties found in recent POWER5
> firmware:
>
> cpus/PowerPC,POWER5@0/clock-frequency
>                  59aa5880 (1504336000)
> cpus/PowerPC,POWER5@0/ibm,extended-clock-frequency
>                  00000000 59aa5880
> cpus/PowerPC,POWER5@0/timebase-frequency
>                  0b354b10 (188042000)
> cpus/PowerPC,POWER5@0/ibm,extended-timebase-frequency
>                  00000000 0b354b10
>
> Signed-off-by: Anton Blanchard <anton@samba.org>
> ---
>
> Index: build/arch/powerpc/kernel/time.c
> ===================================================================
> --- build.orig/arch/powerpc/kernel/time.c	2006-06-20  
> 11:55:34.000000000 +1000
> +++ build/arch/powerpc/kernel/time.c	2006-06-20 18:25:35.000000000  
> +1000
> @@ -857,42 +857,50 @@ int do_settimeofday(struct timespec *tv)
>
>  EXPORT_SYMBOL(do_settimeofday);
>
> -void __init generic_calibrate_decr(void)
> +static int __init get_freq(char *name, int cells, unsigned long *val)
>  {
>  	struct device_node *cpu;
>  	unsigned int *fp;
> -	int node_found;
> +	int found = 0;
>
> -	/*
> -	 * The cpu node should have a timebase-frequency property
> -	 * to tell us the rate at which the decrementer counts.
> -	 */
> +	/* The cpu node should have timebase and clock frequency  
> properties */
>  	cpu = of_find_node_by_type(NULL, "cpu");
>
> -	ppc_tb_freq = DEFAULT_TB_FREQ;		/* hardcoded default */
> -	node_found = 0;
>  	if (cpu) {
> -		fp = (unsigned int *)get_property(cpu, "timebase-frequency",
> -						  NULL);
> +		fp = (unsigned int *)get_property(cpu, name, NULL);
>  		if (fp) {
> -			node_found = 1;
> -			ppc_tb_freq = *fp;
> +			found = 1;
> +			*val = 0;
> +			while (cells--)
> +				*val = (*val << 32) | *fp++;

Is it reasonable for cells to be greater than 1 on a 32-bit system?   
If not, ok to protect this with a CONFIG_PPC64

>  		}
> +
> +		of_node_put(cpu);
>  	}
> -	if (!node_found)
> +
> +	return found;
> +}
> +
> +void __init generic_calibrate_decr(void)
> +{
> +	ppc_tb_freq = DEFAULT_TB_FREQ;		/* hardcoded default */
> +
> +	if (!get_freq("ibm,extended-timebase-frequency", 2, &ppc_tb_freq) &&
> +	    !get_freq("timebase-frequency", 1, &ppc_tb_freq)) {
> +
>  		printk(KERN_ERR "WARNING: Estimating decrementer frequency "
>  				"(not found)\n");
> +	}
>
> -	ppc_proc_freq = DEFAULT_PROC_FREQ;
> -	node_found = 0;
> -	if (cpu) {
> -		fp = (unsigned int *)get_property(cpu, "clock-frequency",
> -						  NULL);
> -		if (fp) {
> -			node_found = 1;
> -			ppc_proc_freq = *fp;
> -		}
> +	ppc_proc_freq = DEFAULT_PROC_FREQ;	/* hardcoded default */
> +
> +	if (!get_freq("ibm,extended-clock-frequency", 2, &ppc_proc_freq) &&
> +	    !get_freq("clock-frequency", 1, &ppc_proc_freq)) {
> +
> +		printk(KERN_ERR "WARNING: Estimating processor frequency "
> +				"(not found)\n");
>  	}
> +
>  #ifdef CONFIG_BOOKE
>  	/* Set the time base to zero */
>  	mtspr(SPRN_TBWL, 0);
> @@ -904,11 +912,6 @@ void __init generic_calibrate_decr(void)
>  	/* Enable decrementer interrupt */
>  	mtspr(SPRN_TCR, TCR_DIE);
>  #endif
> -	if (!node_found)
> -		printk(KERN_ERR "WARNING: Estimating processor frequency "
> -				"(not found)\n");
> -
> -	of_node_put(cpu);
>  }
>
>  unsigned long get_boot_time(void)
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@ozlabs.org
> https://ozlabs.org/mailman/listinfo/linuxppc-dev
