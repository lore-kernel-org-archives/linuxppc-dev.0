Return-Path: <nfont@austin.ibm.com>
Received: from e6.ny.us.ibm.com (e6.ny.us.ibm.com [32.97.182.146])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e6.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTPS id 590BBDE594
	for <linuxppc-dev@ozlabs.org>; Tue, 14 Oct 2008 07:20:28 +1100 (EST)
Received: from d01relay04.pok.ibm.com (d01relay04.pok.ibm.com [9.56.227.236])
	by e6.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id m9DKN7C1012723
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 16:23:07 -0400
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
	by d01relay04.pok.ibm.com (8.13.8/8.13.8/NCO v9.1) with ESMTP id
	m9DKKFpm235390
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 16:20:15 -0400
Received: from d01av04.pok.ibm.com (loopback [127.0.0.1])
	by d01av04.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	m9DKK99S032532
	for <linuxppc-dev@ozlabs.org>; Mon, 13 Oct 2008 16:20:12 -0400
Message-ID: <48F3A9C6.1010309@austin.ibm.com>
Date: Mon, 13 Oct 2008 15:04:22 -0500
From: Nathan Fontenot <nfont@austin.ibm.com>
MIME-Version: 1.0
To: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH 2/16] xics: update default_server during migrate_irqs_away
References: <patch-xics-2@bga.com>
In-Reply-To: <patch-xics-2@bga.com>
Content-Type: text/plain; charset=ISO-8859-1; format=flowed
Cc: linuxppc-dev@ozlabs.org, Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Milton Miller wrote:
> Currently, every time we determine which irq server to use, we check if
> default_server, which is the id of the bootcpu, is still online.  But
> default_server is a hardware cpu, not the logical cpu id needed to index
> cpu_online_map.  
> 
> Since the default server can only go offline during a cpu hotplug event,
> explicitly check the default server and choose the new one when we move
> irqs away from the cpu being offlined.
> 
> This has the added benefit of only needing the boot_cpuid to be updated
> and not relying on the cpu being marked offline during migrate_irqs_away.
> 
> Also, since xics_update_irq_servers only reads device tree information, we
> can call it before xics_init_host in xics_init_IRQ and then default_server
> will always be valid when we can reach get_irq_server via the host ops.
> 
> Signed-off-by: Milton Miller <miltonm@bga.com>

Acked-by: Nathan Fontenot <nfont@austin.ibm.com>

> ---
> I realized the hard vs soft cpu id as I was writing the patch description.
> get_irq_server is called from unmask and set affinity.  
> 
> The effects of this bug would be the increased pathlength to walk the
> device tree in the unmask and set affinity methods, and possible failure
> to migrate irqs during cpu hotplug removal (not likely to be seen on
> until a sequence of remove and adds is performed).
> 
> This check dates to 2.6.25 via de0723dcca6e593a12a259798a54eb0e82628fb8.
> 
> Index: next.git/arch/powerpc/platforms/pseries/xics.c
> ===================================================================
> --- next.git.orig/arch/powerpc/platforms/pseries/xics.c	2008-10-04 16:36:07.000000000 -0500
> +++ next.git/arch/powerpc/platforms/pseries/xics.c	2008-10-04 16:36:09.000000000 -0500
> @@ -208,9 +208,6 @@ static int get_irq_server(unsigned int v
>  	cpumask_t cpumask = irq_desc[virq].affinity;
>  	cpumask_t tmp = CPU_MASK_NONE;
>  
> -	if (! cpu_isset(default_server, cpu_online_map))
> -		xics_update_irq_servers();
> -
>  	if (!distribute_irqs)
>  		return default_server;
>  
> @@ -685,8 +682,8 @@ void __init xics_init_IRQ(void)
>  	if (found == 0)
>  		return;
>  
> -	xics_init_host();
>  	xics_update_irq_servers();
> +	xics_init_host();
>  
>  	if (firmware_has_feature(FW_FEATURE_LPAR))
>  		ppc_md.get_irq = xics_get_irq_lpar;
> @@ -779,6 +776,10 @@ void xics_migrate_irqs_away(void)
>  	int cpu = smp_processor_id(), hw_cpu = hard_smp_processor_id();
>  	unsigned int irq, virq;
>  
> +	/* If we used to be the default server, move to the new "boot_cpuid" */
> +	if (hw_cpu == default_server)
> +		xics_update_irq_servers();
> +
>  	/* Reject any interrupt that was queued to us... */
>  	xics_set_cpu_priority(0);
>  
