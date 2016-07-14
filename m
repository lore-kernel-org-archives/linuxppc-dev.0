Return-Path: <anton@samba.org>
Received: from hr2.samba.org (hr2.samba.org [144.76.82.148])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rr8Qh6JPdzDqyV
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 15 Jul 2016 07:46:04 +1000 (AEST)
Date: Fri, 15 Jul 2016 07:42:57 +1000
From: Anton Blanchard <anton@samba.org>
To: Anna-Maria Gleixner <anna-maria@linutronix.de>
Cc: LKML <linux-kernel@vger.kernel.org>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>, Thomas Gleixner
 <tglx@linutronix.de>, rt@linutronix.de, Sebastian Andrzej Siewior
 <bigeasy@linutronix.de>, Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>, Bharata B Rao
 <bharata@linux.vnet.ibm.com>, Christophe Jaillet
 <christophe.jaillet@wanadoo.fr>, Linus Torvalds
 <torvalds@linux-foundation.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>, Paul Mackerras
 <paulus@samba.org>, Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [patch V2 30/67] powerpc/numa: Convert to hotplug state machine
Message-ID: <20160715074257.7801cd00@kryten>
In-Reply-To: <20160713153335.369278769@linutronix.de>
References: <20160713153219.128052238@linutronix.de>
 <20160713153335.369278769@linutronix.de>
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

Hi,

> From: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> 
> Install the callbacks via the state machine and let the core invoke
> the callbacks on the already online CPUs.

This is causing an oops on ppc64le QEMU, looks like a NULL pointer:

percpu: Embedded 3 pages/cpu @c00000001fe00000 s145816 r0 d50792 u1048576
Unable to handle kernel paging request for data at address 0x00001e08
Faulting instruction address: 0xc0000000001e6b78
Oops: Kernel access of bad area, sig: 11 [#1]
SMP NR_CPUS=2048 NUMA pSeries
Modules linked in:
CPU: 0 PID: 0 Comm: swapper Not tainted 4.7.0-rc7-00198-g425209e #14
task: c000000000d82a00 ti: c000000000dc4000 task.ti: c000000000dc4000
NIP: c0000000001e6b78 LR: c0000000001e6df4 CTR: 0000000000000000
REGS: c000000000dc7b60 TRAP: 0300   Not tainted  (4.7.0-rc7-00198-g425209e)
MSR: 8000000002001033 <SF,VEC,ME,IR,DR,RI,LE>  CR: 44000220  XER: 00000000
CFAR: 0000000000008468 DAR: 0000000000001e08 DSISR: 40000000 SOFTE: 0 
GPR00: 0000000000000006 c000000000dc7de0 c000000000dc6c00 0000000000000000 
GPR04: 0000000000000000 0000000000000000 c00000001fe1fb70 0000000000000010 
GPR08: c000000000dfe918 c000000000e50dd0 c000000000e56c00 0000000000000001 
GPR12: 0000000000000000 c00000000fe00000 0000000000000060 0000000000f1d618 
GPR16: 0000000000efccd8 0000000000efcb20 fffffffffffffffd 0000000000000000 
GPR20: 000000001f150000 c000000000dfa8e0 c000000000ccfafc c000000000dfeb18 
GPR24: c000000000dfee34 c000000000ccfaf8 0000000000000000 0000000000000001 
GPR28: c000000000ebad20 c000000000ccfb00 0000000000000000 c00000001fe1fb00 
NIP [c0000000001e6b78] local_memory_node+0x18/0x80
LR [c0000000001e6df4] __build_all_zonelists+0x214/0x2d0
Call Trace:
[c000000000dc7de0] [c0000000001e6ccc] __build_all_zonelists+0xec/0x2d0 (unreliable)
[c000000000dc7e70] [c000000000c39fbc] build_all_zonelists_init+0x1c/0x3c
[c000000000dc7e90] [c000000000282acc] build_all_zonelists+0x17c/0x18c
[c000000000dc7f00] [c000000000c13c54] start_kernel+0x18c/0x514
[c000000000dc7f90] [c000000000008c60] start_here_common+0x20/0xa0
Instruction dump:
38810178 7f63db78 48769171 60000000 4bfffd2c 60420000 3c4c00be 384200a0 
3d420009 78631f24 392aa1d0 7c69182a <81231e08> 38631e00 2b890002 419d001c 

Anton

> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Andrew Morton <akpm@linux-foundation.org>
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Bharata B Rao <bharata@linux.vnet.ibm.com>
> Cc: Christophe Jaillet <christophe.jaillet@wanadoo.fr>
> Cc: Linus Torvalds <torvalds@linux-foundation.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: Nikunj A Dadhania <nikunj@linux.vnet.ibm.com>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linuxppc-dev@lists.ozlabs.org
> Signed-off-by: Anna-Maria Gleixner <anna-maria@linutronix.de>
> ---
>  arch/powerpc/mm/numa.c     | 46
> ++++++++++++++++------------------------------
> include/linux/cpuhotplug.h |  1 + 2 files changed, 17 insertions(+),
> 30 deletions(-)
> 
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 669a15e..d48ac48 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -581,30 +581,22 @@ static void verify_cpu_node_mapping(int cpu,
> int node) }
>  }
>  
> -static int cpu_numa_callback(struct notifier_block *nfb, unsigned
> long action,
> -			     void *hcpu)
> +/* Must run before sched domains notifier. */
> +static int ppc_numa_cpu_prepare(unsigned int cpu)
>  {
> -	unsigned long lcpu = (unsigned long)hcpu;
> -	int ret = NOTIFY_DONE, nid;
> +	int nid;
>  
> -	switch (action) {
> -	case CPU_UP_PREPARE:
> -	case CPU_UP_PREPARE_FROZEN:
> -		nid = numa_setup_cpu(lcpu);
> -		verify_cpu_node_mapping((int)lcpu, nid);
> -		ret = NOTIFY_OK;
> -		break;
> +	nid = numa_setup_cpu(cpu);
> +	verify_cpu_node_mapping(cpu, nid);
> +	return 0;
> +}
> +
> +static int ppc_numa_cpu_dead(unsigned int cpu)
> +{
>  #ifdef CONFIG_HOTPLUG_CPU
> -	case CPU_DEAD:
> -	case CPU_DEAD_FROZEN:
> -	case CPU_UP_CANCELED:
> -	case CPU_UP_CANCELED_FROZEN:
> -		unmap_cpu_from_node(lcpu);
> -		ret = NOTIFY_OK;
> -		break;
> +	unmap_cpu_from_node(cpu);
>  #endif
> -	}
> -	return ret;
> +	return 0;
>  }
>  
>  /*
> @@ -913,11 +905,6 @@ static void __init
> dump_numa_memory_topology(void) }
>  }
>  
> -static struct notifier_block ppc64_numa_nb = {
> -	.notifier_call = cpu_numa_callback,
> -	.priority = 1 /* Must run before sched domains notifier. */
> -};
> -
>  /* Initialize NODE_DATA for a node on the local memory */
>  static void __init setup_node_data(int nid, u64 start_pfn, u64
> end_pfn) {
> @@ -953,7 +940,7 @@ static void __init setup_node_data(int nid, u64
> start_pfn, u64 end_pfn) 
>  void __init initmem_init(void)
>  {
> -	int nid, cpu;
> +	int nid;
>  
>  	max_low_pfn = memblock_end_of_DRAM() >> PAGE_SHIFT;
>  	max_pfn = max_low_pfn;
> @@ -985,15 +972,14 @@ void __init initmem_init(void)
>  	setup_node_to_cpumask_map();
>  
>  	reset_numa_cpu_lookup_table();
> -	register_cpu_notifier(&ppc64_numa_nb);
> +
>  	/*
>  	 * We need the numa_cpu_lookup_table to be accurate for all
> CPUs,
>  	 * even before we online them, so that we can use
> cpu_to_{node,mem}
>  	 * early in boot, cf. smp_prepare_cpus().
>  	 */
> -	for_each_present_cpu(cpu) {
> -		numa_setup_cpu((unsigned long)cpu);
> -	}
> +	cpuhp_setup_state(CPUHP_POWER_NUMA_PREPARE,
> "POWER_NUMA_PREPARE",
> +			  ppc_numa_cpu_prepare, ppc_numa_cpu_dead);
>  }
>  
>  static int __init early_numa(char *p)
> diff --git a/include/linux/cpuhotplug.h b/include/linux/cpuhotplug.h
> index 7449081..01133ec 100644
> --- a/include/linux/cpuhotplug.h
> +++ b/include/linux/cpuhotplug.h
> @@ -14,6 +14,7 @@ enum cpuhp_state {
>  	CPUHP_PERF_SUPERH,
>  	CPUHP_X86_HPET_DEAD,
>  	CPUHP_WORKQUEUE_PREP,
> +	CPUHP_POWER_NUMA_PREPARE,
>  	CPUHP_NOTIFY_PREPARE,
>  	CPUHP_BRINGUP_CPU,
>  	CPUHP_AP_IDLE_DEAD,
