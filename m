Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id C6722DDEBC
	for <linuxppc-dev@ozlabs.org>; Fri, 20 Apr 2007 15:45:49 +1000 (EST)
In-Reply-To: <20070419115233.GA4172@in.ibm.com>
References: <20070306135754.GB7476@in.ibm.com>
	<1173190615.4675.30.camel@concordia.ozlabs.ibm.com>
	<20070306165529.GD7476@in.ibm.com>
	<1173202634.4675.37.camel@concordia.ozlabs.ibm.com>
	<20070307045341.GG7476@in.ibm.com>
	<1173264752.5101.49.camel@concordia.ozlabs.ibm.com>
	<20070409085732.GC4281@in.ibm.com>
	<1176188763.9836.16.camel@concordia.ozlabs.ibm.com>
	<eeb3b19029c753682f476e97dcfaa820@bga.com>
	<1176254201.4815.14.camel@concordia.ozlabs.ibm.com>
	<20070419115233.GA4172@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <080126626f9bea228426c0c3d7bf1730@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Date: Fri, 20 Apr 2007 00:45:15 -0500
To: mohan@in.ibm.com
Cc: ppcdev <linuxppc-dev@ozlabs.org>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, fastboot@lists.osdl.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Apr 19, 2007, at 6:52 AM, Mohan Kumar M wrote:

> On Wed, Apr 11, 2007 at 11:16:41AM +1000, Michael Ellerman wrote:
>> On Tue, 2007-04-10 at 11:59 -0500, Milton Miller wrote:
>>>
>>> This means we are doing population counts of two masks, when we 
>>> really
>>> just care that they are the same.   How about using
>>> cpus_equal(cpu_online_mask, cpu_present_mask)?
>>
>> Yep that's sensible.
>>
>>> This shows how close these two functions are.  The difference is
>>> what happens when cpus_empty is true -- we default in one and
>>> ignore in the other.
>>>
>>> How about adding another arg to get_server, that says to fail
>>> or default for the empty case, with failure being -1?
>
> I modified the patch based on suggestions given by Milton and Mike.
> Milton is this patch okay?

Well, its part of the way there.

>
> Tested on 2.6.21-rc7.
> Index: linux-2.6.21-rc4/arch/powerpc/platforms/pseries/xics.c
> ===================================================================
> --- linux-2.6.21-rc4.orig/arch/powerpc/platforms/pseries/xics.c
> +++ linux-2.6.21-rc4/arch/powerpc/platforms/pseries/xics.c
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
> @@ -167,21 +167,25 @@ static int get_irq_server(unsigned int v
>  		return default_server;
>
>  	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
> -		server = default_distrib_server;
> +		if (cpus_equal(cpu_online_map, cpu_present_map))
> +			server = default_distrib_server;
> +		else
> +			server = default_server;
>  	} else {
>  		cpus_and(tmp, cpu_online_map, cpumask);
>
> -		if (cpus_empty(tmp))
> +		if (cpus_empty(tmp) && !strict_check)
>  			server = default_distrib_server;
> +		else if(cpus_empty(tmp) && strict_check)
> +			server = -1;
>  		else
>  			server = get_hard_smp_processor_id(first_cpu(tmp));
>  	}

Don't test cpus_empty twice, instead do a nested if.

Actually, looking at this a bit, you need your default_distrib or
default_server check again.

How about reorder to be if (!cpus_equal(...ALL)) {
     cpus_and
     if !cpus_empty(tmp
         return get_hard(first);
     if (strict)
         return -1;
}

if (cpus_equal(online, preseent)
return distrib
return default_server

For that matter, can we just call first_cpu, and check its <= NUM_CPUS
elminating the call to cpus_empty ?   Only call get_hard_cpu if its
valid.

...
> @@ -415,7 +419,10 @@ static void xics_set_affinity(unsigned i
...
>  	/* For the moment only implement delivery to all cpus or one cpu */
>  	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
> -		newmask = default_distrib_server;
> +		if (cpus_equal(cpu_online_map, cpu_present_map))
>

this was supposed to be the call with strict = 1

milton
