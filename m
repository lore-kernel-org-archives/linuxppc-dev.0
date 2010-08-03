Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
	(using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
	(Client did not present a certificate)
	by ozlabs.org (Postfix) with ESMTPS id BFA8FB6EF3
	for <linuxppc-dev@lists.ozlabs.org>;
	Tue,  3 Aug 2010 14:46:30 +1000 (EST)
Subject: Re: [PATCH v4 1/2] powerpc: cleanup APIs for cpu/thread/core mappings
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
In-Reply-To: <20100722005707.12905.83615.stgit@drishya.in.ibm.com>
References: <20100722005219.12905.49197.stgit@drishya.in.ibm.com>
	<20100722005707.12905.83615.stgit@drishya.in.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Date: Tue, 03 Aug 2010 14:44:13 +1000
Message-ID: <1280810653.1902.87.camel@pasglop>
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>, Paul Mackerras <paulus@samba.org>,
	Anton Blanchard <anton@samba.org>, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2010-07-22 at 06:27 +0530, Vaidyanathan Srinivasan wrote:
> These APIs take logical cpu number as input
> Change cpu_first_thread_in_core() to cpu_leftmost_thread_sibling()
> Change cpu_last_thread_in_core() to cpu_rightmost_thread_sibling()

I'm still not happy here.

I don't find leftmost/rightmost to be a "progress" from the previous
naming. If you really want to change to avoid in_core() at the end, then
call them first_thread_sibling() and last_thread_sibling().

Then you change:

> -static inline int cpu_thread_to_core(int cpu)
> -{
> -	return cpu >> threads_shift;
> -}

  .../... to:

> -/* Must be called when no change can occur to cpu_present_mask,
> +/* Helper routines for cpu to core mapping */
> +int cpu_core_of_thread(int cpu)
> +{
> +	return cpu >> threads_shift;
> +}
> +EXPORT_SYMBOL_GPL(cpu_core_of_thread);

Any reason you are making it out of line other than gratuituous
bloat ? :-)

> +int cpu_first_thread_of_core(int core)
> +{
> +	return core << threads_shift;
> +}
> +EXPORT_SYMBOL_GPL(cpu_first_thread_of_core);

Same.

Ben.

> +/* Must be called when no change can occur to cpu_present_map,
>   * i.e. during cpu online or offline.
>   */
>  static struct device_node *cpu_to_l2cache(int cpu)
> @@ -527,7 +540,7 @@ int __devinit start_secondary(void *unused)
>  	notify_cpu_starting(cpu);
>  	set_cpu_online(cpu, true);
>  	/* Update sibling maps */
> -	base = cpu_first_thread_in_core(cpu);
> +	base = cpu_leftmost_thread_sibling(cpu);
>  	for (i = 0; i < threads_per_core; i++) {
>  		if (cpu_is_offline(base + i))
>  			continue;
> @@ -606,7 +619,7 @@ int __cpu_disable(void)
>  		return err;
>  
>  	/* Update sibling maps */
> -	base = cpu_first_thread_in_core(cpu);
> +	base = cpu_leftmost_thread_sibling(cpu);
>  	for (i = 0; i < threads_per_core; i++) {
>  		cpumask_clear_cpu(cpu, cpu_sibling_mask(base + i));
>  		cpumask_clear_cpu(base + i, cpu_sibling_mask(cpu));
> diff --git a/arch/powerpc/mm/mmu_context_nohash.c b/arch/powerpc/mm/mmu_context_nohash.c
> index ddfd7ad..22f3bc5 100644
> --- a/arch/powerpc/mm/mmu_context_nohash.c
> +++ b/arch/powerpc/mm/mmu_context_nohash.c
> @@ -111,8 +111,8 @@ static unsigned int steal_context_smp(unsigned int id)
>  		 * a core map instead but this will do for now.
>  		 */
>  		for_each_cpu(cpu, mm_cpumask(mm)) {
> -			for (i = cpu_first_thread_in_core(cpu);
> -			     i <= cpu_last_thread_in_core(cpu); i++)
> +			for (i = cpu_leftmost_thread_sibling(cpu);
> +			     i <= cpu_rightmost_thread_sibling(cpu); i++)
>  				__set_bit(id, stale_map[i]);
>  			cpu = i - 1;
>  		}
> @@ -264,14 +264,14 @@ void switch_mmu_context(struct mm_struct *prev, struct mm_struct *next)
>  	 */
>  	if (test_bit(id, stale_map[cpu])) {
>  		pr_hardcont(" | stale flush %d [%d..%d]",
> -			    id, cpu_first_thread_in_core(cpu),
> -			    cpu_last_thread_in_core(cpu));
> +			    id, cpu_leftmost_thread_sibling(cpu),
> +			    cpu_rightmost_thread_sibling(cpu));
>  
>  		local_flush_tlb_mm(next);
>  
>  		/* XXX This clear should ultimately be part of local_flush_tlb_mm */
> -		for (i = cpu_first_thread_in_core(cpu);
> -		     i <= cpu_last_thread_in_core(cpu); i++) {
> +		for (i = cpu_leftmost_thread_sibling(cpu);
> +		     i <= cpu_rightmost_thread_sibling(cpu); i++) {
>  			__clear_bit(id, stale_map[i]);
>  		}
>  	}
