Return-Path: <srivatsa.bhat@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 248D82C0098
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 18:39:07 +1000 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srivatsa.bhat@linux.vnet.ibm.com>;
 Tue, 11 Jun 2013 14:02:24 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp01.in.ibm.com (Postfix) with ESMTP id 2AD93E0043
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 14:08:14 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5B8cqGj8192010
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 14:08:52 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5B8ctJl001002
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jun 2013 08:38:56 GMT
Message-ID: <51B6E164.4050603@linux.vnet.ibm.com>
Date: Tue, 11 Jun 2013 14:05:48 +0530
From: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
MIME-Version: 1.0
To: Li Zhong <zhong@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH powerpc] Set cpu sibling mask before online cpu
References: <1368699626.2618.183.camel@ThinkPad-T5421>
In-Reply-To: <1368699626.2618.183.camel@ThinkPad-T5421>
Content-Type: text/plain; charset=ISO-8859-1
Cc: Paul Mackerras <paulus@samba.org>,
 PowerPC email list <linuxppc-dev@lists.ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 05/16/2013 03:50 PM, Li Zhong wrote:
> It seems following race is possible:
> 
> 	cpu0					cpux
> smp_init->cpu_up->_cpu_up
> 	__cpu_up
> 		kick_cpu(1)
> -------------------------------------------------------------------------
> 		waiting online			...
> 		...				notify CPU_STARTING
> 							set cpux active
> 						set cpux online
> -------------------------------------------------------------------------
> 		finish waiting online
> 		...
> sched_init_smp
> 	init_sched_domains(cpu_active_mask)
> 		build_sched_domains
> 						set cpux sibling info
> -------------------------------------------------------------------------
> 
[...]
> This patch tries to move the sibling maps updating before
> notify_cpu_starting() and cpu online, and a write barrier there to make
> sure sibling maps are updated before active and online mask. 
> 
> Signed-off-by: Li Zhong <zhong@linux.vnet.ibm.com>
> ---

Reviewed-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>

Regards,
Srivatsa S. Bhat

>  arch/powerpc/kernel/smp.c |    8 +++++---
>  1 files changed, 5 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/smp.c b/arch/powerpc/kernel/smp.c
> index ee7ac5e..c765937 100644
> --- a/arch/powerpc/kernel/smp.c
> +++ b/arch/powerpc/kernel/smp.c
> @@ -637,12 +637,10 @@ __cpuinit void start_secondary(void *unused)
> 
>  	vdso_getcpu_init();
>  #endif
> -	notify_cpu_starting(cpu);
> -	set_cpu_online(cpu, true);
>  	/* Update sibling maps */
>  	base = cpu_first_thread_sibling(cpu);
>  	for (i = 0; i < threads_per_core; i++) {
> -		if (cpu_is_offline(base + i))
> +		if (cpu_is_offline(base + i) && (cpu != base + i))
>  			continue;
>  		cpumask_set_cpu(cpu, cpu_sibling_mask(base + i));
>  		cpumask_set_cpu(base + i, cpu_sibling_mask(cpu));
> @@ -667,6 +665,10 @@ __cpuinit void start_secondary(void *unused)
>  	}
>  	of_node_put(l2_cache);
> 
> +	smp_wmb();
> +	notify_cpu_starting(cpu);
> +	set_cpu_online(cpu, true);
> +
>  	local_irq_enable();
> 
>  	cpu_startup_entry(CPUHP_ONLINE);
> 
> 
> 
