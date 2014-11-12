Return-Path: <srikar@linux.vnet.ibm.com>
Received: from e23smtp09.au.ibm.com (e23smtp09.au.ibm.com [202.81.31.142])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id AEAEC1A0057
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 20:22:44 +1100 (AEDT)
Received: from /spool/local
 by e23smtp09.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <srikar@linux.vnet.ibm.com>;
 Wed, 12 Nov 2014 19:22:40 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp02.au.ibm.com (Postfix) with ESMTP id E2A622BB0086
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 20:22:37 +1100 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 sAC9OWKx14745718
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 20:24:34 +1100
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 sAC9MZKk000537
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Nov 2014 20:22:36 +1100
Date: Wed, 12 Nov 2014 14:52:24 +0530
From: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To: kernelfans@gmail.com
Subject: Re: [RFC 01/11] sched: introduce sys_cpumask in tsk to adapt
 asymmetric system
Message-ID: <20141112092224.GA16566@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <1413487800-7162-1-git-send-email-kernelfans@gmail.com>
 <1413487800-7162-2-git-send-email-kernelfans@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
In-Reply-To: <1413487800-7162-2-git-send-email-kernelfans@gmail.com>
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

* kernelfans@gmail.com <kernelfans@gmail.com> [2014-10-16 15:29:50]:

> Some system such as powerpc, some tsk (vcpu thread) can only run on
> the dedicated cpu. Since we adapt some asymmetric method to monitor the
> whole physical cpu. (powerKVM only allows the primary hwthread to
> set up runtime env for the secondary when entering guest).
> 
> Nowadays, powerKVM run with all the secondary hwthread offline to ensure
> the vcpu threads only run on the primary thread. But we plan to keep all
> cpus online when running powerKVM to give more power when switching back
> to host, so introduce sys_allowed cpumask to reflect the cpuset which
> the vcpu thread can run on.
> 
> Signed-off-by: Liu Ping Fan <pingfank@linux.vnet.ibm.com>
> ---
>  include/linux/init_task.h |  1 +
>  include/linux/sched.h     |  6 ++++++
>  kernel/sched/core.c       | 10 ++++++++--
>  3 files changed, 15 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/init_task.h b/include/linux/init_task.h
> index 2bb4c4f3..c56f69e 100644
> --- a/include/linux/init_task.h
> +++ b/include/linux/init_task.h
> @@ -172,6 +172,7 @@ extern struct task_group root_task_group;
>  	.normal_prio	= MAX_PRIO-20,					\
>  	.policy		= SCHED_NORMAL,					\
>  	.cpus_allowed	= CPU_MASK_ALL,					\
> +	.sys_allowed = CPU_MASK_ALL,			\

Do we really need another mask, cant we just use cpus_allowed itself.

>  	.nr_cpus_allowed= NR_CPUS,					\
>  	.mm		= NULL,						\
>  	.active_mm	= &init_mm,					\
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 5c2c885..ce429f3 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -1260,7 +1260,10 @@ struct task_struct {
>  
>  	unsigned int policy;
>  	int nr_cpus_allowed;
> +	/* Anded user and sys_allowed */
>  	cpumask_t cpus_allowed;
> +	/* due to the feature of asymmetric, some tsk can only run on such cpu */
> +	cpumask_t sys_allowed;
>  
>  #ifdef CONFIG_PREEMPT_RCU
>  	int rcu_read_lock_nesting;
> @@ -2030,6 +2033,9 @@ static inline void tsk_restore_flags(struct task_struct *task,
>  }
>  
>  #ifdef CONFIG_SMP
> +extern void set_cpus_sys_allowed(struct task_struct *p,
> +			const struct cpumask *new_mask);
> +
>  extern void do_set_cpus_allowed(struct task_struct *p,
>  			       const struct cpumask *new_mask);
>  
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index ec1a286..2cd1ae3 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -4596,13 +4596,19 @@ void init_idle(struct task_struct *idle, int cpu)
>  }
>  
>  #ifdef CONFIG_SMP
> +void set_cpus_sys_allowed(struct task_struct *p,
> +	const struct cpumask *new_mask)
> +{
> +	cpumask_copy(&p->sys_allowed, new_mask);
> +}
> +

This function doesnt seem to be used anywhere... Not sure why it is
introduced

>  void do_set_cpus_allowed(struct task_struct *p, const struct cpumask *new_mask)
>  {
>  	if (p->sched_class && p->sched_class->set_cpus_allowed)
>  		p->sched_class->set_cpus_allowed(p, new_mask);
>  
> -	cpumask_copy(&p->cpus_allowed, new_mask);
> -	p->nr_cpus_allowed = cpumask_weight(new_mask);
> +	cpumask_and(&p->cpus_allowed, &p->sys_allowed, new_mask);
> +	p->nr_cpus_allowed = cpumask_weight(&p->cpus_allowed);
>  }
>  
>  /*
> -- 
> 1.8.3.1
> 
> 

-- 
Thanks and Regards
Srikar Dronamraju
