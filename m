Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 95F0E1A0155
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 21:19:09 +1100 (AEDT)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Wed, 12 Nov 2014 15:49:02 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 9E2FC125805A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 15:49:02 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay03.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sACALAaY57671716
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 15:51:11 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sACAHg3Y007541
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 15:47:43 +0530
Date: Wed, 12 Nov 2014 15:47:41 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: kernelfans@gmail.com
Subject: Re: [RFC 02/11] powerpc: kvm: ensure vcpu-thread run only on primary
 hwthread
Message-ID: <20141112101741.GB16566@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
 <1413487800-7162-3-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1413487800-7162-3-git-send-email-kernelfans@gmail.com>
Cc: Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org,
 Alexander Graf <agraf@suse.de>, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

* kernelfans@gmail.com <kernelfans@gmail.com> [2014-10-16 15:29:51]:

> When vcpu thread runs at the first time, it will ensure to stick
> to the primary thread.
> 
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/kvm_host.h |  3 +++
>  arch/powerpc/kvm/book3s_hv.c        | 17 +++++++++++++++++
>  2 files changed, 20 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/kvm_host.h b/arch/powerpc/include/asm/kvm_host.h
> index 98d9dd5..9a3355e 100644
> --- a/arch/powerpc/include/asm/kvm_host.h
> +++ b/arch/powerpc/include/asm/kvm_host.h
> @@ -666,6 +666,9 @@ struct kvm_vcpu_arch {
>  	spinlock_t tbacct_lock;
>  	u64 busy_stolen;
>  	u64 busy_preempt;
> +#ifdef CONFIG_KVMPPC_ENABLE_SECONDARY
> +	bool cpu_selected;
> +#endif
>  #endif
>  };
>  
> diff --git a/arch/powerpc/kvm/book3s_hv.c b/arch/powerpc/kvm/book3s_hv.c
> index 27cced9..ba258c8 100644
> --- a/arch/powerpc/kvm/book3s_hv.c
> +++ b/arch/powerpc/kvm/book3s_hv.c
> @@ -1909,6 +1909,23 @@ static int kvmppc_vcpu_run_hv(struct kvm_run *run, struct kvm_vcpu *vcpu)
>  {
>  	int r;
>  	int srcu_idx;
> +#ifdef CONFIG_KVMPPC_ENABLE_SECONDARY
> +	int cpu = smp_processor_id();
> +	int target_cpu;
> +	unsigned int cpu;

2 variables with same name... cpu

> +	struct task_struct *p = current;
> +
> +	if (unlikely(!vcpu->arch.cpu_selected)) {
> +		vcpu->arch.cpu_selected = true;

Nit: something like cpumask_set seems to be better than cpu_selected

> +		for (cpu = 0; cpu < NR_CPUS; cpu+=threads_per_core) {
> +			cpumask_set_cpu(cpu, &p->sys_allowed);
		Dont we need to reset the cpumask first before we set
		the cpumask here?

> +		}
> +		if (cpu%threads_per_core != 0) {

At this time, cpu should be NR_CPUS and most times it should be a
multiple of threads_per_core. Unfortunately there wont be a cpu with
cpu number NR_CPUS.

> +			target_cpu = cpu/threads_per_core*threads_per_core;

Its probably better of to have parenthesis here. 

> +			migrate_task_to(current, target_cpu);
We are probably migrating to a non-existant cpu.
Also dont you need to check if the target_cpu is part of the cpumask?

> +		}
> +	}
> +#endif
>  
>  	if (!vcpu->arch.sane) {
>  		run->exit_reason = KVM_EXIT_INTERNAL_ERROR;
> -- 
> 1.8.3.1
> 
> 

-- 
Thanks and Regards
Srikar Dronamraju
