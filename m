Return-Path: <miltonm@bga.com>
Received: from ruth.realtime.net (mercury.realtime.net [205.238.132.86])
	by ozlabs.org (Postfix) with ESMTP id 6CB81DDD07
	for <linuxppc-dev@ozlabs.org>; Wed,  6 Jun 2007 19:44:01 +1000 (EST)
In-Reply-To: <20070604105455.GA4916@in.ibm.com>
References: <20070409085732.GC4281@in.ibm.com>
	<1176188763.9836.16.camel@concordia.ozlabs.ibm.com>
	<eeb3b19029c753682f476e97dcfaa820@bga.com>
	<1176254201.4815.14.camel@concordia.ozlabs.ibm.com>
	<20070419115233.GA4172@in.ibm.com>
	<080126626f9bea228426c0c3d7bf1730@bga.com>
	<20070426092455.GA4144@in.ibm.com>
	<4cb567d635b4ac3333e6b4b2c27c12f2@bga.com>
	<20070503144721.GA28460@in.ibm.com>
	<ca045e7e6fde9345b3461214777d8102@bga.com>
	<20070604105455.GA4916@in.ibm.com>
Mime-Version: 1.0 (Apple Message framework v624)
Content-Type: text/plain; charset=US-ASCII; format=flowed
Message-Id: <c1b8d82c8241fc3750c1339c34ecc799@bga.com>
From: Milton Miller <miltonm@bga.com>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Date: Wed, 6 Jun 2007 04:43:22 -0500
To: mohan@in.ibm.com
Cc: ppcdev <linuxppc-dev@ozlabs.org>, kexec@lists.infradead.org,
	Paul Mackerras <paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


On Jun 4, 2007, at 5:54 AM, Mohan Kumar M wrote:

> Milton,
>
> How about this patch?

I'd make a few minor changes (see below), but I'll ack it.

I've checked it compiles and boots but not the server selection.

> =============================================================
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
>
> Cc: Milton Miller <miltonm@bga.com>,
>     Michael Ellerman <michael@ellerman.id.au>
> Signed-off-by: Mohan Kumar M <mohan@in.ibm.com>

Acked-By: Milton Miller <miltonm@bga.com>

> @@ -166,22 +166,24 @@ static int get_irq_server(unsigned int v
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
> -	}
> +		server = first_cpu(tmp);
>
> -	return server;
> +		if (server < NR_CPUS)
> +			return get_hard_smp_processor_id(server);
> +		else if (strict_check)
> +				return -1;

The indent on the return is 1 tab too many.
See next comment.

> +	}
>
> +	if (cpus_equal(cpu_online_map, cpu_present_map))
> +		return default_distrib_server;
> +	else
> +		return default_server;

I'd actually remove both occurrences of "else" bringing this and the 
previous return back a tabstop.  The else is unnecessary because the if 
statement is return .  (Seperate the new if from the previous with a 
blank line in both cases).

>  }
>  #else
> -static int get_irq_server(unsigned int virq)
> +static int get_irq_server(unsigned int virq, unsigned int 
> strict_check)
>  {
>  	return default_server;
>  }
