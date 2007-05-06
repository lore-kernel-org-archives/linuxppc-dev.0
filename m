Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 3EAAFDDEF6
	for <linuxppc-dev@ozlabs.org>; Sun,  6 May 2007 16:53:23 +1000 (EST)
In-Reply-To: <20070503144721.GA28460@in.ibm.com>
References: <20070307045341.GG7476@in.ibm.com>
	<1173264752.5101.49.camel@concordia.ozlabs.ibm.com>
	<20070409085732.GC4281@in.ibm.com>
	<1176188763.9836.16.camel@concordia.ozlabs.ibm.com>
	<eeb3b19029c753682f476e97dcfaa820@bga.com>
	<1176254201.4815.14.camel@concordia.ozlabs.ibm.com>
	<20070419115233.GA4172@in.ibm.com>
	<080126626f9bea228426c0c3d7bf1730@bga.com>
	<20070426092455.GA4144@in.ibm.com>
	<4cb567d635b4ac3333e6b4b2c27c12f2@bga.com>
	<20070503144721.GA28460@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <ca045e7e6fde9345b3461214777d8102@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Date: Sun, 6 May 2007 01:52:44 -0500
To: mohan@in.ibm.com
Cc: kexec@lists.infradead.org, fastboot@lists.osdl.org,
	ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On May 3, 2007, at 9:47 AM, Mohan Kumar M wrote:
> On Thu, Apr 26, 2007 at 09:42:50AM -0500, Milton Miller wrote:
>> Yes.   The whole point of
>>> -static int get_irq_server(unsigned int virq)
>>> +static int get_irq_server(unsigned int virq, unsigned int
>>> strict_check)
>> was to factor out the common code in this function.
>
> Milton,
>
> How about this patch?

Getting closer, still not right.

>
> Index: linux-2.6.21.1/arch/powerpc/platforms/pseries/xics.c
> ===================================================================
> --- linux-2.6.21.1.orig/arch/powerpc/platforms/pseries/xics.c
> +++ linux-2.6.21.1/arch/powerpc/platforms/pseries/xics.c
> @@ -156,9 +156,9 @@ static inline void lpar_qirr_info(int n_
>
>
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
> @@ -166,22 +166,28 @@ static int get_irq_server(unsigned int v
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
> +		server = first_cpu(tmp);
> +
> +		if (server < NR_CPUS)
> +			return get_hard_smp_processor_id(server);
> +		else {
> +			if (strict_check)
> +				return -1;


> +			else
> +				return default_distrib_server;
> +		}
> +	} else {

Take out the above 4 lines, so that the return always has cpu_online
vs cpu_present factored in, by falling through from specific mask to
default server selection.

> +		if (cpus_equal(cpu_online_map, cpu_present_map))
> +			return default_distrib_server;
>  		else
> -			server = get_hard_smp_processor_id(first_cpu(tmp));
> +			return default_server;
>  	}

[This matching brace will go and indent will change.]

> -
> -	return server;
> -
>  }
...

> @@ -398,8 +404,7 @@ static void xics_set_affinity(unsigned i
>  	unsigned int irq;
>  	int status;
>  	int xics_status[2];
> -	unsigned long newmask;
> -	cpumask_t tmp = CPU_MASK_NONE;
> +	int irq_server;
>
>  	irq = (unsigned int)irq_map[virq].hwirq;
>  	if (irq == XICS_IPI || irq == XICS_IRQ_SPURIOUS)
> @@ -413,18 +418,28 @@ static void xics_set_affinity(unsigned i
>  		return;
>  	}
>
> -	/* For the moment only implement delivery to all cpus or one cpu */
> -	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
> -		newmask = default_distrib_server;
> -	} else {
> -		cpus_and(tmp, cpu_online_map, cpumask);
> -		if (cpus_empty(tmp))
> +	/* Get current irq_server for the given irq */
> +	irq_server = get_irq_server(irq, 1);
> +	if (irq_server == -1) {
> +		printk(KERN_ERR "xics_set_affinity: Invalid cpumask\n");

WARNING or NOTICE would be fine.  The interrupt number should be 
printed.
and maybe "No online cpus in <cpumask> for irq %d" would be better (I
think there is a print cpumask helper).

> +		return;
> +	}
> +
> +	/* For the moment only implement delivery to all cpus or one cpu.
> +	 * Compare the irq_server with the new cpumask. If the irq_server
> +	 * is specified in cpumask, do the required rtas_call, otherwise
> +	 * return by printing an error message
> +	 */
> +	if (!cpus_equal(cpumask, CPU_MASK_ALL)) {
> +		if (!cpu_isset(irq_server, cpumask)) {
> +			printk(KERN_ERR "xics_set_affinity: Invalid "
> +							"cpumask\n");
>  			return;

I don't understand what you are trying to do here.  We already
chose the mask, and printed an error if we got -1 due to strict.
I think this can just be dropped?

> -		newmask = get_hard_smp_processor_id(first_cpu(tmp));
> +		}
>  	}
>
>  	status = rtas_call(ibm_set_xive, 3, 1, NULL,
> -				irq, newmask, xics_status[1]);
> +				irq, irq_server, xics_status[1]);
>
>  	if (status) {
>  		printk(KERN_ERR "xics_set_affinity: irq=%u ibm,set-xive "


milton
