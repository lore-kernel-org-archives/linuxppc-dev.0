Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id ADAE7DDEF5
	for <linuxppc-dev@ozlabs.org>; Mon, 11 Jun 2007 11:58:31 +1000 (EST)
In-Reply-To: <20070606113134.GC4916@in.ibm.com>
References: <eeb3b19029c753682f476e97dcfaa820@bga.com>
	<1176254201.4815.14.camel@concordia.ozlabs.ibm.com>
	<20070419115233.GA4172@in.ibm.com>
	<080126626f9bea228426c0c3d7bf1730@bga.com>
	<20070426092455.GA4144@in.ibm.com>
	<4cb567d635b4ac3333e6b4b2c27c12f2@bga.com>
	<20070503144721.GA28460@in.ibm.com>
	<ca045e7e6fde9345b3461214777d8102@bga.com>
	<20070604105455.GA4916@in.ibm.com>
	<c1b8d82c8241fc3750c1339c34ecc799@bga.com>
	<20070606113134.GC4916@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ac119a2f080a47cf41f7c916010eaccd@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Date: Sun, 10 Jun 2007 20:58:10 -0500
To: mohan@in.ibm.com
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	kexec@lists.infradead.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Jun 6, 2007, at 6:31 AM, Mohan Kumar M wrote:
> I updated the patch with correct tab spacing and removed unnecessary
> "else".


> In some of the PPC970 based systems, interrupt would be distributed to
> offline cpus also even when booted with "maxcpus=1". So check whether
> cpu online map and cpu present map are equal or not. If they are equal
> default_distrib_server is used as interrupt server otherwise boot cpu
> (default_server) used as interrupt server.
>
> In addition to this, if an interrupt is assigned to a specific cpu (ie
> smp affinity) and if that cpu is not online, the earlier code used to
> return the default_distrib_server as interrupt server. This patch
> introduces an additional paramter to the get_irq function ie
> strict_check, based on this parameter, if the cpu is not online either
> default_distrib_server or -1 is returned.


The code is structured cleanly.  However, when testing this patch, I 
found (1) you printed the mask as a cpulist instead of a cpumask.  
Since the user writes a cpumask to /proc/irq/xx/smp_affinity, it would 
make more sense to print a mask in the error message.

However, this is all mute because (2) the common in /kenrel/irq/proc.c 
checks that a cpu in the mask is online and returns -EINVAL to the user 
without calling the ->set_affinity hook (we have no select_smp_affinity 
hook arch code).   Unless there is another path to call ->set_affinity, 
we can only trigger the case of no online cpu by racing between setting 
the affinity and taking a cpu offline.

Does anyone know of another path to set the affinity?  If not I would 
remove this extra logic and change the behavior from ignore to set to 
default server.


milton

>  #ifdef CONFIG_SMP
> -static int get_irq_server(unsigned int virq)
> +static int get_irq_server(unsigned int virq, unsigned int 
> strict_check)
>  {
> -	unsigned int server;
> +	int server;
>  	/* For the moment only implement delivery to all cpus or one cpu */
>  	cpumask_t cpumask = irq_desc[virq].affinity;
>  	cpumask_t tmp = CPU_MASK_NONE;
> @@ -166,22 +166,25 @@ static int get_irq_server(unsigned int v
>  	if (!distribute_irqs)
>  		return default_server;
>
> -	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
> -		server = default_distrib_server;
> -	} else {
> +	if (!cpus_equal(cpumask, CPU_MASK_ALL)) {
>  		cpus_and(tmp, cpu_online_map, cpumask);
>
> -		if (cpus_empty(tmp))
> -			server = default_distrib_server;
> -		else
> -			server = get_hard_smp_processor_id(first_cpu(tmp));
> +		server = first_cpu(tmp);
> +
> +		if (server < NR_CPUS)
> +			return get_hard_smp_processor_id(server);
> +
> +		if (strict_check)
> +			return -1;
>  	}
>
> -	return server;
> +	if (cpus_equal(cpu_online_map, cpu_present_map))
> +		return default_distrib_server;
>
> +	return default_server;
>  }
>

...

> +	/*
> +	 * For the moment only implement delivery to all cpus or one cpu.
> +	 * Get current irq_server for the given irq
> +	 */
> +	irq_server = get_irq_server(irq, 1);
> +	if (irq_server == -1) {
> +		char cpulist[128];
> +		cpulist_scnprintf(cpulist, sizeof(cpulist), cpumask);
> +		printk(KERN_WARNING "xics_set_affinity: No online cpus in "
> +				"the mask %s for irq %d\n", cpulist, virq);
> +		return;
>  	}
