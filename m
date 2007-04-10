Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 61E24DDF6C
	for <linuxppc-dev@ozlabs.org>; Wed, 11 Apr 2007 02:59:57 +1000 (EST)
In-Reply-To: <1176188763.9836.16.camel@concordia.ozlabs.ibm.com>
References: <20061208045537.GA14626@in.ibm.com>
	<17798.6928.378248.28903@cargo.ozlabs.ibm.com>
	<20061218105706.GB3911@in.ibm.com>
	<20070306135754.GB7476@in.ibm.com>
	<1173190615.4675.30.camel@concordia.ozlabs.ibm.com>
	<20070306165529.GD7476@in.ibm.com>
	<1173202634.4675.37.camel@concordia.ozlabs.ibm.com>
	<20070307045341.GG7476@in.ibm.com>
	<1173264752.5101.49.camel@concordia.ozlabs.ibm.com>
	<20070409085732.GC4281@in.ibm.com>
	<1176188763.9836.16.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <eeb3b19029c753682f476e97dcfaa820@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Date: Tue, 10 Apr 2007 11:59:28 -0500
To: michael@ellerman.id.au
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


On Apr 10, 2007, at 2:06 AM, Michael Ellerman wrote:

> On Mon, 2007-04-09 at 14:27 +0530, Mohan Kumar M wrote:
>> On Wed, Mar 07, 2007 at 11:52:32AM +0100, Michael Ellerman wrote:
>>> There's already maxcpus in init/main.c, that would probably be 
>>> better,
>>> though still ugly.
>>>
>> Based on Mike's suggestions, I modified the patch. The attached patch
>> refers max_cpus variable to check whether the kernel is booted with
>> maxcpus=1 parameter and if maxcpus=1 is specified the patch assigns 
>> only
>> the current boot cpu to be the default distribution server.
>
> So the core of the problem is that if we haven't onlined all cpus then
> we can't use the default_distrib_server value given to us by firmware,
> because some of the cpus in that queue won't be online.
>
> We can detect this situation by comparing the number of cpus that are
> online vs the number that are present (not possible). This might even
> work if you boot with maxcpus=1 and then hotplug the rest in.
>
> How about this:
>
> Index: powerpc/arch/powerpc/platforms/pseries/xics.c
> ===================================================================
> --- powerpc.orig/arch/powerpc/platforms/pseries/xics.c
> +++ powerpc/arch/powerpc/platforms/pseries/xics.c
> @@ -167,7 +167,10 @@ static int get_irq_server(unsigned int v
>  		return default_server;
>
>  	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
> -		server = default_distrib_server;
> +		if (num_online_cpus() == num_present_cpus())
> +			server = default_distrib_server;
> +		else
> +			server = default_server;
>  	} else {
>  		cpus_and(tmp, cpu_online_map, cpumask);

This means we are doing population counts of two masks, when we really
just care that they are the same.   How about using
cpus_equal(cpu_online_mask, cpu_present_mask)?

>
> @@ -415,7 +418,10 @@ static void xics_set_affinity(unsigned i
>
>  	/* For the moment only implement delivery to all cpus or one cpu */
>  	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
> -		newmask = default_distrib_server;
> +		if (num_online_cpus() == num_present_cpus())
> +			newmask = default_distrib_server;
> +		else
> +			newmask = default_server;
>  	} else {
>  		cpus_and(tmp, cpu_online_map, cpumask);
>  		if (cpus_empty(tmp))

This shows how close these two functions are.  The difference is
what happens when cpus_empty is true -- we default in one and
ignore in the other.

How about adding another arg to get_server, that says to fail
or default for the empty case, with failure being -1?

I'll try to code this up, but it might be a day or two until i get
the time.

milton
