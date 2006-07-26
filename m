Return-Path: <ntl@pobox.com>
Received: from rune.pobox.com (rune.pobox.com [208.210.124.79])
	by ozlabs.org (Postfix) with ESMTP id 8CD5867B55
	for <linuxppc-dev@ozlabs.org>; Thu, 27 Jul 2006 08:05:23 +1000 (EST)
Date: Wed, 26 Jul 2006 17:04:41 -0500
From: Nathan Lynch <ntl@pobox.com>
To: Haren Myneni <haren@us.ibm.com>
Subject: Re: [PATCH] Add rtas_set_indicator_fast() for RTAS call without
	extended delay
Message-ID: <20060726220441.GZ19076@localdomain>
References: <44C6F521.8040609@us.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <44C6F521.8040609@us.ibm.com>
Cc: Milton Miller II <miltonm@us.ibm.com>, Paul Mackerras <paulus@samba.org>,
	External List <linuxppc-dev@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Haren Myneni wrote:
> diff -Naurp 2618-rc2.orig/arch/powerpc/kernel/rtas.c 2618-rc2/arch/powerpc/kernel/rtas.c
> --- 2618-rc2.orig/arch/powerpc/kernel/rtas.c	2006-07-25 19:34:11.000000000 -0700
> +++ 2618-rc2/arch/powerpc/kernel/rtas.c	2006-07-25 19:33:16.000000000 -0700
> @@ -569,6 +569,27 @@ int rtas_set_indicator(int indicator, in
>  }
>  EXPORT_SYMBOL(rtas_set_indicator);
>  
> +/*
> + * Ignoring RTAS extended delay
> + */
> +int rtas_set_indicator_fast(int indicator, int index, int new_value)
> +{
> +	int rc;
> +	int token = rtas_token("set-indicator");
> +
> +	if (token == RTAS_UNKNOWN_SERVICE)
> +		return -ENOENT;
> +
> +	rc = rtas_call(token, 3, 1, NULL, indicator, index, new_value);
> +
> +	WARN_ON(rc == -2 || (rc >= 9900 && rc <= 9905));
> +
> +	if (rc < 0)
> +		return rtas_error_rc(rc);
> +
> +	return rc;
> +}
> +
>  void rtas_restart(char *cmd)
>  {
>  	if (rtas_flash_term_hook)
> diff -Naurp 2618-rc2.orig/arch/powerpc/platforms/pseries/xics.c 2618-rc2/arch/powerpc/platforms/pseries/xics.c
> --- 2618-rc2.orig/arch/powerpc/platforms/pseries/xics.c	2006-07-25 19:34:41.000000000 -0700
> +++ 2618-rc2/arch/powerpc/platforms/pseries/xics.c	2006-07-25 19:33:36.000000000 -0700
> @@ -796,7 +796,7 @@ void xics_teardown_cpu(int secondary)
>  	 * so leave the master cpu in the group.
>  	 */
>  	if (secondary)
> -		rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE,
> +		rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE,
>  				   (1UL << interrupt_server_size) - 1 -
>  				   default_distrib_server, 0);
>  }
> @@ -813,7 +813,7 @@ void xics_migrate_irqs_away(void)
>  	xics_set_cpu_priority(cpu, 0);
>  
>  	/* remove ourselves from the global interrupt queue */
> -	status = rtas_set_indicator(GLOBAL_INTERRUPT_QUEUE,
> +	status = rtas_set_indicator_fast(GLOBAL_INTERRUPT_QUEUE,
>  		(1UL << interrupt_server_size) - 1 - default_distrib_server, 0);
>  	WARN_ON(status < 0);
>  

Looks fine to me from a quick look, but we need to use
rtas_set_indicator_fast in xics_setup_cpu as well (I think I neglected
to mention I saw the warning in the cpu up path, sorry).
