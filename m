Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AC9CD1A0017
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 21:17:32 +1100 (AEDT)
In-Reply-To: <1443378553-2146-2-git-send-email-raghavendra.kt@linux.vnet.ibm.com>
To: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>,
 <benh@kernel.crashing.org>, <paulus@samba.org>
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: nikunj@linux.vnet.ibm.com, nacc@linux.vnet.ibm.com,
 raghavendra.kt@linux.vnet.ibm.com, linux-kernel@vger.kernel.org,
 Raghavendra K T <raghavendra.kt@linux.inet.ibm.com>, anton@samba.org,
 grant.likely@linaro.org, cl@linux.com, khandual@linux.vnet.ibm.com,
 linuxppc-dev@lists.ozlabs.org, gkurz@linux.vnet.ibm.com
Subject: Re: [RFC,
 1/5] powerpc:numa Add numa_cpu_lookup function to update lookup table
Message-Id: <20151006101732.52907140D72@ozlabs.org>
Date: Tue,  6 Oct 2015 21:17:32 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, 2015-27-09 at 18:29:09 UTC, Raghavendra K T wrote:
> We access numa_cpu_lookup_table array directly in all the places
> to read/update numa cpu lookup information. Instead use a helper
> function to update.
> 
> This is helpful in changing the way numa<-->cpu mapping in single
> place when needed.
> 
> This is a cosmetic change, no change in functionality.
> 
> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.inet.ibm.com>
> Signed-off-by: Raghavendra K T <raghavendra.kt@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/mmzone.h |  2 +-
>  arch/powerpc/kernel/smp.c         | 10 +++++-----
>  arch/powerpc/mm/numa.c            | 28 +++++++++++++++++-----------
>  3 files changed, 23 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/mmzone.h b/arch/powerpc/include/asm/mmzone.h
> index 7b58917..c24a5f4 100644
> --- a/arch/powerpc/include/asm/mmzone.h
> +++ b/arch/powerpc/include/asm/mmzone.h
> @@ -29,7 +29,7 @@ extern struct pglist_data *node_data[];
>   * Following are specific to this numa platform.
>   */
>  
> -extern int numa_cpu_lookup_table[];
> +extern int numa_cpu_lookup(int cpu);

Can you rename it better :)

Something like cpu_to_nid().

Although maybe nid is wrong given the rest of the series.

> diff --git a/arch/powerpc/mm/numa.c b/arch/powerpc/mm/numa.c
> index 8b9502a..d5e6eee 100644
> --- a/arch/powerpc/mm/numa.c
> +++ b/arch/powerpc/mm/numa.c
> @@ -52,7 +52,6 @@ int numa_cpu_lookup_table[NR_CPUS];
>  cpumask_var_t node_to_cpumask_map[MAX_NUMNODES];
>  struct pglist_data *node_data[MAX_NUMNODES];
>  
> -EXPORT_SYMBOL(numa_cpu_lookup_table);
>  EXPORT_SYMBOL(node_to_cpumask_map);
>  EXPORT_SYMBOL(node_data);
>  
> @@ -134,19 +133,25 @@ static int __init fake_numa_create_new_node(unsigned long end_pfn,
>  	return 0;
>  }
>  
> -static void reset_numa_cpu_lookup_table(void)
> +int numa_cpu_lookup(int cpu)
>  {
> -	unsigned int cpu;
> -
> -	for_each_possible_cpu(cpu)
> -		numa_cpu_lookup_table[cpu] = -1;
> +	return numa_cpu_lookup_table[cpu];
>  }
> +EXPORT_SYMBOL(numa_cpu_lookup);

I don't see you changing any modular code that uses this, or any macros that
might be used by modules, so I don't see why this needs to be exported?

I think you just added it because num_cpu_lookup_table was exported?

cheers
