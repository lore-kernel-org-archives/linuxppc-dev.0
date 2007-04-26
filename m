Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id E6599DDEF0
	for <linuxppc-dev@ozlabs.org>; Fri, 27 Apr 2007 00:43:19 +1000 (EST)
In-Reply-To: <20070426092455.GA4144@in.ibm.com>
References: <20070306165529.GD7476@in.ibm.com>
	<1173202634.4675.37.camel@concordia.ozlabs.ibm.com>
	<20070307045341.GG7476@in.ibm.com>
	<1173264752.5101.49.camel@concordia.ozlabs.ibm.com>
	<20070409085732.GC4281@in.ibm.com>
	<1176188763.9836.16.camel@concordia.ozlabs.ibm.com>
	<eeb3b19029c753682f476e97dcfaa820@bga.com>
	<1176254201.4815.14.camel@concordia.ozlabs.ibm.com>
	<20070419115233.GA4172@in.ibm.com>
	<080126626f9bea228426c0c3d7bf1730@bga.com>
	<20070426092455.GA4144@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <4cb567d635b4ac3333e6b4b2c27c12f2@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Date: Thu, 26 Apr 2007 09:42:50 -0500
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

On Apr 26, 2007, at 4:24 AM, Mohan Kumar M wrote:
> On Fri, Apr 20, 2007 at 12:45:15AM -0500, Milton Miller wrote:
[snip]
> Milton, I hope this patch meets all your requirements.

Closer, much better.
> Cc: Milton Miller <miltonm@bga.com>,
>     Michael Ellerman <michael@ellerman.id.au>
> Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>
> ---
>  arch/powerpc/platforms/pseries/xics.c |   39 
> ++++++++++++++++++++--------------
>  1 file changed, 24 insertions(+), 15 deletions(-)
>
> Index: linux-2.6.21-rc4/arch/powerpc/platforms/pseries/xics.c
> ===================================================================
> --- linux-2.6.21-rc4.orig/arch/powerpc/platforms/pseries/xics.c
> +++ linux-2.6.21-rc4/arch/powerpc/platforms/pseries/xics.c
> @@ -156,9 +156,9 @@ static inline void lpar_qirr_info(int n_
[snipping]
> +	if (!cpus_equal(cpumask, CPU_MASK_ALL)) {
>  		cpus_and(tmp, cpu_online_map, cpumask);
>
> +		server = first_cpu(tmp);
> +
> +		if (server < NR_CPUS)
> +			return get_hard_smp_processor_id(server);
> +		else {
> +			if(strict_check)
> +				return (-1);

No parens around the return value.  That is, use return -1;

> +			else
> +				return default_distrib_server;
> +		}
...

> @@ -415,7 +421,10 @@ static void xics_set_affinity(unsigned i
>
>  	/* For the moment only implement delivery to all cpus or one cpu */
>  	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
> -		newmask = default_distrib_server;
> +		if (cpus_equal(cpu_online_map, cpu_present_map))
> +			newmask = default_distrib_server;
> +		else
> +			newmask = default_server;
>  	} else {
>  		cpus_and(tmp, cpu_online_map, cpumask);
>  		if (cpus_empty(tmp))
>
>
> ===================
>> ...
>>> @@ -415,7 +419,10 @@ static void xics_set_affinity(unsigned i
>> ...
>>> 	/* For the moment only implement delivery to all cpus or one cpu */
>>> 	if (cpus_equal(cpumask, CPU_MASK_ALL)) {
>>> -		newmask = default_distrib_server;
>>> +		if (cpus_equal(cpu_online_map, cpu_present_map))
>>>
>>
>> this was supposed to be the call with strict = 1
>
> Do you mean to use 'strict_check' argument in xics_set_affinity?
> set_affinity call is declared in linux/irq.h, so if modifying
> xics_set_affinity will affect other arch's set_affinity also.

Yes.   The whole point of
> -static int get_irq_server(unsigned int virq)
> +static int get_irq_server(unsigned int virq, unsigned int 
> strict_check)
was to factor out the common code in this function.

I wasn't trying to change the prototype of xics_set_affinity.

Looking at the code a bit, I think part of the confusion is that newmask
is horribly misnamed.   Please rename it to server or irqserver.
Obtain its value by calling get_irq_server.  If the server returned
is -1 (in strict mode), don't call rtas (just return like today).
I guess a printk could be in order since the function is void, and
only root can request the change.

milton
