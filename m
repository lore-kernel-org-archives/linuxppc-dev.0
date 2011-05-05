Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id 6F162B6F7B
	for <linuxppc-dev@ozlabs.org>; Thu,  5 May 2011 12:25:10 +1000 (EST)
Subject: Re: [RFC][PATCH] powerpc: respect how command line nr_cpus is set
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Kumar Gala <galak@kernel.crashing.org>
In-Reply-To: <1304540257-19831-1-git-send-email-galak@kernel.crashing.org>
References: <1304540257-19831-1-git-send-email-galak@kernel.crashing.org>
Content-Type: text/plain; charset="UTF-8"
Date: Thu, 05 May 2011 12:25:02 +1000
Message-ID: <1304562302.2513.418.camel@pasglop>
Mime-Version: 1.0
Cc: linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2011-05-04 at 15:17 -0500, Kumar Gala wrote:
> We should utilize nr_cpus as the max # of CPUs that we can have present
> instead of NR_CPUS.  This way we actually respect how nr_cpus is set on
> the command line rather than ignoring it.
> 
> Signed-off-by: Kumar Gala <galak@kernel.crashing.org>
> ---
> I think this is what we should be doing, but would like someone else to take
> a look.

The main question I have is should max_cpus absolutely limit the number
of possible CPUs or should it limit the number that get automatically
onlined at boot, potentially letting us bring the rest online later on ?

Cheers,
Ben.

> - k
> 
>  arch/powerpc/kernel/setup-common.c |   10 +++++-----
>  1 files changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup-common.c
> index 21f30cb..fedf813 100644
> --- a/arch/powerpc/kernel/setup-common.c
> +++ b/arch/powerpc/kernel/setup-common.c
> @@ -424,7 +424,7 @@ void __init smp_setup_cpu_maps(void)
>  
>  	DBG("smp_setup_cpu_maps()\n");
>  
> -	while ((dn = of_find_node_by_type(dn, "cpu")) && cpu < NR_CPUS) {
> +	while ((dn = of_find_node_by_type(dn, "cpu")) && cpu < nr_cpu_ids) {
>  		const int *intserv;
>  		int j, len;
>  
> @@ -443,7 +443,7 @@ void __init smp_setup_cpu_maps(void)
>  				intserv = &cpu;	/* assume logical == phys */
>  		}
>  
> -		for (j = 0; j < nthreads && cpu < NR_CPUS; j++) {
> +		for (j = 0; j < nthreads && cpu < nr_cpu_ids; j++) {
>  			DBG("    thread %d -> cpu %d (hard id %d)\n",
>  			    j, cpu, intserv[j]);
>  			set_cpu_present(cpu, true);
> @@ -483,12 +483,12 @@ void __init smp_setup_cpu_maps(void)
>  		if (cpu_has_feature(CPU_FTR_SMT))
>  			maxcpus *= nthreads;
>  
> -		if (maxcpus > NR_CPUS) {
> +		if (maxcpus > nr_cpu_ids) {
>  			printk(KERN_WARNING
>  			       "Partition configured for %d cpus, "
>  			       "operating system maximum is %d.\n",
> -			       maxcpus, NR_CPUS);
> -			maxcpus = NR_CPUS;
> +			       maxcpus, nr_cpu_ids);
> +			maxcpus = nr_cpu_ids;
>  		} else
>  			printk(KERN_INFO "Partition configured for %d cpus.\n",
>  			       maxcpus);
