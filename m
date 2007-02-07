Return-Path: <paulus@ozlabs.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Message-ID: <17865.14407.190426.642030@cargo.ozlabs.ibm.com>
Date: Wed, 7 Feb 2007 13:24:07 +1100
From: Paul Mackerras <paulus@samba.org>
To: Manish Ahuja <ahuja@austin.ibm.com>
Subject: Re: [PATCH]Enabling Auto poweron after power is restored.
In-Reply-To: <45C40C97.807@austin.ibm.com>
References: <45707469.9060604@austin.ibm.com> <4575E76C.7030300@austin.ibm.com>
	<17785.415.574041.518517@cargo.ozlabs.ibm.com>
	<458EBE02.3010401@austin.ibm.com>
	<17827.5922.667200.166153@cargo.ozlabs.ibm.com>
	<45C40C97.807@austin.ibm.com>
Cc: ppc-dev <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Manish Ahuja writes:

> Index: 2.6.20-rc6-git1-t2/arch/powerpc/kernel/rtas.c
> ===================================================================
> --- 2.6.20-rc6-git1-t2.orig/arch/powerpc/kernel/rtas.c	2007-02-02 05:47:13.000000000 -0800
> +++ 2.6.20-rc6-git1-t2/arch/powerpc/kernel/rtas.c	2007-02-02 08:37:09.000000000 -0800
> @@ -607,13 +607,31 @@
>  	for (;;);
>  }
>  
> +/**
> + * rtas_power_off - tell firmware about how to power off the system.
> + *
> + * This function calls either the power-off rtas token in normal cases
> + * or the ibm,power-off-ups token (if present & requested) in case of
> + * a power failure. If power-off token is used, power on will only be
> + * possible with power button press. If ibm,power-off-ups token is used
> + * it will allow auto poweron after power is restored.
> + */
>  void rtas_power_off(void)
>  {
> +	int rc;
> +	int rtas_poweroff_ups_token = rtas_token("ibm,power-off-ups");
> +
>  	if (rtas_flash_term_hook)
> -		rtas_flash_term_hook(SYS_POWER_OFF);
> -	/* allow power on only with power button press */
> -	printk("RTAS power-off returned %d\n",
> -	       rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1));
> +	rtas_flash_term_hook(SYS_POWER_OFF);
> +
> +	if (rtas_poweron_auto == 0 ||
> +		rtas_poweroff_ups_token == RTAS_UNKNOWN_SERVICE) {
> +		rc = rtas_call(rtas_token("power-off"), 2, 1, NULL, -1, -1);
> +		printk(KERN_INFO "RTAS power-off returned %d\n", rc);
> +	} else {
> +		rc = rtas_call(rtas_poweroff_ups_token, 0, 1, NULL);
> +		printk(KERN_INFO "RTAS ibm,power-off-ups returned %d\n", rc);
> +	}

Unfortunately this causes a compilation error on platforms that use
RTAS but aren't pSeries, since rtas_poweron_auto is defined in
arch/powerpc/platforms/pseries/power.c.  Either define
rtas_poweron_auto in rtas.c, or move all this logic into
arch/powerpc/platforms/pseries (i.e., make the pSeries setup.c set
ppc_md.power_off to a pSeries-specific power off routine where you do
this logic, setting it to rtas_power_off).

Paul.
