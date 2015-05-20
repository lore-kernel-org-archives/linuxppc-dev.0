Return-Path: <shreyas@linux.vnet.ibm.com>
Received: from e28smtp06.in.ibm.com (e28smtp06.in.ibm.com [122.248.162.6])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3FB771A0611
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 03:28:48 +1000 (AEST)
Received: from /spool/local
 by e28smtp06.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <shreyas@linux.vnet.ibm.com>;
 Wed, 20 May 2015 22:58:46 +0530
Received: from d28relay01.in.ibm.com (d28relay01.in.ibm.com [9.184.220.58])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 45E3E1258059
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 23:00:59 +0530 (IST)
Received: from d28av05.in.ibm.com (d28av05.in.ibm.com [9.184.220.67])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4KHShtj32637104
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 22:58:43 +0530
Received: from d28av05.in.ibm.com (localhost [127.0.0.1])
 by d28av05.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4KHSg0I009738
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 20 May 2015 22:58:42 +0530
Message-ID: <555CC44A.5070508@linux.vnet.ibm.com>
Date: Wed, 20 May 2015 22:58:42 +0530
From: Shreyas B Prabhu <shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Jack Miller <millerjo@us.ibm.com>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv: Fix idle state allocation corruption
References: <1432141984-5804-1-git-send-email-millerjo@us.ibm.com>
In-Reply-To: <1432141984-5804-1-git-send-email-millerjo@us.ibm.com>
Content-Type: text/plain; charset=windows-1252
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, jk@ozlabs.org,
 jstancek@redhat.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Wednesday 20 May 2015 10:43 PM, Jack Miller wrote:
> pnv_alloc_idle_core_states is iterating over PACAs based on the
> configured maximum number of CPUs (NR_CPUS), but PACAs are only
> initialized up to nr_cpu_ids, so rein in loops to keep from overwriting
> adjacent memory.
> 

Hi Jack,

Jan Stancek has a patch fixing this (d52356e7f powerpc: fix memory
corruption by pnv_alloc_idle_core_states).

Thanks,
Shreyas

> Signed-off-by: Jack Miller <millerjo@us.ibm.com>
> ---
>  arch/powerpc/platforms/powernv/setup.c | 26 +++++++++++---------------
>  1 file changed, 11 insertions(+), 15 deletions(-)
> 
> diff --git a/arch/powerpc/platforms/powernv/setup.c b/arch/powerpc/platforms/powernv/setup.c
> index ad0e32e..8e794b6 100644
> --- a/arch/powerpc/platforms/powernv/setup.c
> +++ b/arch/powerpc/platforms/powernv/setup.c
> @@ -356,9 +356,8 @@ int pnv_save_sprs_for_winkle(void)
> 
>  static void pnv_alloc_idle_core_states(void)
>  {
> -	int i, j;
> -	int nr_cores = cpu_nr_cores();
> -	u32 *core_idle_state;
> +	u32 *core_idle_state = NULL;
> +	int i, thread;
> 
>  	/*
>  	 * core_idle_state - First 8 bits track the idle state of each thread
> @@ -371,20 +370,17 @@ static void pnv_alloc_idle_core_states(void)
>  	 * b. While the last thread in the core is saving the core state, it
>  	 * prevents a different thread from waking up.
>  	 */
> -	for (i = 0; i < nr_cores; i++) {
> -		int first_cpu = i * threads_per_core;
> -		int node = cpu_to_node(first_cpu);
> +	for (i = 0; i < nr_cpu_ids; i++) {
> +		thread = i % threads_per_core;
> 
> -		core_idle_state = kmalloc_node(sizeof(u32), GFP_KERNEL, node);
> -		*core_idle_state = PNV_CORE_IDLE_THREAD_BITS;
> -
> -		for (j = 0; j < threads_per_core; j++) {
> -			int cpu = first_cpu + j;
> -
> -			paca[cpu].core_idle_state_ptr = core_idle_state;
> -			paca[cpu].thread_idle_state = PNV_THREAD_RUNNING;
> -			paca[cpu].thread_mask = 1 << j;
> +		if (thread == 0) {
> +			core_idle_state = kmalloc_node(sizeof(u32), GFP_KERNEL, cpu_to_node(i));
> +			*core_idle_state = PNV_CORE_IDLE_THREAD_BITS;
>  		}
> +
> +		paca[i].core_idle_state_ptr = core_idle_state;
> +		paca[i].thread_idle_state = PNV_THREAD_RUNNING;
> +		paca[i].thread_mask = 1 << thread;
>  	}
> 
>  	update_subcore_sibling_mask();
> 
