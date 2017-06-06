Return-Path: <tglx@linutronix.de>
Received: from Galois.linutronix.de (Galois.linutronix.de
 [IPv6:2a01:7a0:2:106d:700::1])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3whnv46b3YzDqLC
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Jun 2017 20:27:44 +1000 (AEST)
Date: Tue, 6 Jun 2017 12:27:38 +0200 (CEST)
From: Thomas Gleixner <tglx@linutronix.de>
To: Anju T Sudhakar <anju@linux.vnet.ibm.com>
cc: mpe@ellerman.id.au, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, ego@linux.vnet.ibm.com,
 bsingharora@gmail.com, anton@samba.org, sukadev@linux.vnet.ibm.com,
 mikey@neuling.org, stewart@linux.vnet.ibm.com, dja@axtens.net,
 eranian@google.com, hemant@linux.vnet.ibm.com, maddy@linux.vnet.ibm.com
Subject: Re: [PATCH v9 10/10] powerpc/perf: Thread imc cpuhotplug support
In-Reply-To: <1496665922-702-3-git-send-email-anju@linux.vnet.ibm.com>
Message-ID: <alpine.DEB.2.20.1706061209140.1885@nanos>
References: <1496665922-702-1-git-send-email-anju@linux.vnet.ibm.com>
 <1496665922-702-3-git-send-email-anju@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 5 Jun 2017, Anju T Sudhakar wrote:
>  static void thread_imc_mem_alloc(int cpu_id)
>  {
> -	u64 ldbar_addr, ldbar_value;
>  	int phys_id = topology_physical_package_id(cpu_id);
>  
>  	per_cpu_add[cpu_id] = (u64)alloc_pages_exact_nid(phys_id,
>  			(size_t)IMC_THREAD_COUNTER_MEM, GFP_KERNEL | __GFP_ZERO);

It took me a while to understand that per_cpu_add is an array and not a new
fangled per cpu function which adds something to a per cpu variable. 

So why is that storing the address as u64?

And why is this a NR_CPUS sized array instead of a regular per cpu variable?

> +}
> +
> +static void thread_imc_update_ldbar(unsigned int cpu_id)
> +{
> +	u64 ldbar_addr, ldbar_value;
> +
> +	if (per_cpu_add[cpu_id] == 0)
> +		thread_imc_mem_alloc(cpu_id);

So if that allocation fails then you happily proceed. Optmistic
programming, right?

> +
>  	ldbar_addr = (u64)virt_to_phys((void *)per_cpu_add[cpu_id]);

Ah, it's stored as u64 because you have to convert it back to a void
pointer at the place where it is actually used. Interesting approach.

>  	ldbar_value = (ldbar_addr & (u64)THREAD_IMC_LDBAR_MASK) |
> -		(u64)THREAD_IMC_ENABLE;
> +			(u64)THREAD_IMC_ENABLE;
>  	mtspr(SPRN_LDBAR, ldbar_value);
>  }
>  
> @@ -442,6 +450,26 @@ static void core_imc_change_cpu_context(int old_cpu, int new_cpu)
>  	perf_pmu_migrate_context(&core_imc_pmu->pmu, old_cpu, new_cpu);
>  }
>  
> +static int ppc_thread_imc_cpu_online(unsigned int cpu)
> +{
> +	thread_imc_update_ldbar(cpu);
> +	return 0;
> +}
> +
> +static int ppc_thread_imc_cpu_offline(unsigned int cpu)
> +{
> +	mtspr(SPRN_LDBAR, 0);
> +	return 0;
> +}
> +
> +void thread_imc_cpu_init(void)
> +{
> +	cpuhp_setup_state(CPUHP_AP_PERF_POWERPC_THREAD_IMC_ONLINE,
> +			  "perf/powerpc/imc_thread:online",
> +			  ppc_thread_imc_cpu_online,
> +			  ppc_thread_imc_cpu_offline);
> +}
> +
>  static int ppc_core_imc_cpu_online(unsigned int cpu)
>  {
>  	const struct cpumask *l_cpumask;
> @@ -953,6 +981,9 @@ int __init init_imc_pmu(struct imc_events *events, int idx,
>  		if (ret)
>  			return ret;
>  		break;
> +	case IMC_DOMAIN_THREAD:
> +		thread_imc_cpu_init();
> +		break;
>  	default:
>  		return -1;  /* Unknown domain */
>  	}

Just a general observation. If anything in init_imc_pmu() fails, then all
the hotplug callbacks are staying registered, at least I haven't seen
anything undoing it.

Thanks,

	tglx
