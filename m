Return-Path: <mohan@in.ibm.com>
Received: from e5.ny.us.ibm.com (e5.ny.us.ibm.com [32.97.182.145])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client CN "e5.ny.us.ibm.com", Issuer "Equifax" (verified OK))
	by ozlabs.org (Postfix) with ESMTP id 320CDDDF1B
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 22:55:03 +1000 (EST)
Received: from d01relay02.pok.ibm.com (d01relay02.pok.ibm.com [9.56.227.234])
	by e5.ny.us.ibm.com (8.13.8/8.13.8) with ESMTP id l3ACsw3v031146
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 08:54:58 -0400
Received: from d01av02.pok.ibm.com (d01av02.pok.ibm.com [9.56.224.216])
	by d01relay02.pok.ibm.com (8.13.8/8.13.8/NCO v8.3) with ESMTP id
	l3ACswXK304396
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 08:54:58 -0400
Received: from d01av02.pok.ibm.com (loopback [127.0.0.1])
	by d01av02.pok.ibm.com (8.12.11.20060308/8.13.3) with ESMTP id
	l3ACsv7j025678
	for <linuxppc-dev@ozlabs.org>; Tue, 10 Apr 2007 08:54:58 -0400
Date: Tue, 10 Apr 2007 18:24:48 +0530
From: Mohan Kumar M <mohan@in.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH] Fix interrupt distribution in ppc970
Message-ID: <20070410125448.GD4281@in.ibm.com>
References: <17798.6928.378248.28903@cargo.ozlabs.ibm.com>
	<20061218105706.GB3911@in.ibm.com>
	<20070306135754.GB7476@in.ibm.com>
	<1173190615.4675.30.camel@concordia.ozlabs.ibm.com>
	<20070306165529.GD7476@in.ibm.com>
	<1173202634.4675.37.camel@concordia.ozlabs.ibm.com>
	<20070307045341.GG7476@in.ibm.com>
	<1173264752.5101.49.camel@concordia.ozlabs.ibm.com>
	<20070409085732.GC4281@in.ibm.com>
	<1176188763.9836.16.camel@concordia.ozlabs.ibm.com>
Mime-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1176188763.9836.16.camel@concordia.ozlabs.ibm.com>
Cc: ppcdev <linuxppc-dev@ozlabs.org>, fastboot@lists.osdl.org,
	Milton Miller <miltonm@bga.com>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>
Reply-To: mohan@in.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

On Tue, Apr 10, 2007 at 05:06:03PM +1000, Michael Ellerman wrote:
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

Right, This also solves the problem.

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
> 
