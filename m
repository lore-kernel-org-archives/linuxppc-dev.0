Return-Path: <nacc@linux.vnet.ibm.com>
Received: from e9.ny.us.ibm.com (e9.ny.us.ibm.com [32.97.182.139])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 383111A0037
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  3 Sep 2014 13:03:02 +1000 (EST)
Received: from /spool/local
 by e9.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <nacc@linux.vnet.ibm.com>;
 Tue, 2 Sep 2014 23:03:00 -0400
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 855DA38C8054
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  2 Sep 2014 23:02:57 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 s8332vQh7405942
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 3 Sep 2014 03:02:57 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 s8332uVJ001034
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 2 Sep 2014 23:02:57 -0400
Date: Tue, 2 Sep 2014 20:02:47 -0700
From: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH v3 2/3] powerpc: Only set numa node information for
 present cpus at boottime
Message-ID: <20140903030247.GB31420@linux.vnet.ibm.com>
References: <1409132041-11890-1-git-send-email-zhong@linux.vnet.ibm.com>
 <1409132041-11890-2-git-send-email-zhong@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1409132041-11890-2-git-send-email-zhong@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, Nathan Fontenot <nfont@linux.vnet.ibm.com>,
 paulus@samba.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 27.08.2014 [17:34:00 +0800], Li Zhong wrote:
> As Nish suggested, it makes more sense to init the numa node informatiion
> for present cpus at boottime, which could also avoid WARN_ON(1) in
> numa_setup_cpu().
> 
> With this change, we also need to change the smp_prepare_cpus() to set up
> numa information only on present cpus.
> 
> For those possible, but not present cpus, their numa information
> will be set up after they are started, as the original code did before commit
> 2fabf084b6ad.
> 
> Cc: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> Cc: Nathan Fontenot <nfont@linux.vnet.ibm.com>
> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>

Acked-by: Nishanth Aravamudan <nacc@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/smp.c | 10 ++++++++--
>  arch/powerpc/mm/numa.c    |  2 +-
>  2 files changed, 9 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index a0738af..dc0e774 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -379,8 +379,11 @@ void __init smp_prepare_cpus(unsigned int max_cpus)
>  		/*
>  		 * numa_node_id() works after this.
>  		 */
> -		set_cpu_numa_node(cpu, numa_cpu_lookup_table[cpu]);
> -		set_cpu_numa_mem(cpu, local_memory_node(numa_cpu_lookup_table[cpu]));
> +		if (cpu_present(cpu)) {
> +			set_cpu_numa_node(cpu, numa_cpu_lookup_table[cpu]);
> +			set_cpu_numa_mem(cpu,
> +				local_memory_node(numa_cpu_lookup_table[cpu]));
> +		}
>  	}
> 
>  	cpumask_set_cpu(boot_cpuid, cpu_sibling_mask(boot_cpuid));
> @@ -728,6 +731,9 @@ void start_secondary(void *unused)
>  	}
>  	traverse_core_siblings(cpu, true);
> 
> +	set_numa_node(numa_cpu_lookup_table[cpu]);
> +	set_numa_mem(local_memory_node(numa_cpu_lookup_table[cpu]));
> +
>  	smp_wmb();
>  	notify_cpu_starting(cpu);
>  	set_cpu_online(cpu, true);
> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 9918c02..3a9061e 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -1127,7 +1127,7 @@ void __init do_init_bootmem(void)
>  	 * even before we online them, so that we can use cpu_to_{node,mem}
>  	 * early in boot, cf. smp_prepare_cpus().
>  	 */
> -	for_each_possible_cpu(cpu) {
> +	for_each_present_cpu(cpu) {
>  		numa_setup_cpu((unsigned long)cpu);
>  	}
>  }
> -- 
> 1.9.1
> 
