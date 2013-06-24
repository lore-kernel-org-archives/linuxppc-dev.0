Return-Path: <jesper.nilsson@axis.com>
Received: from ra.se.axis.com (ra.se.axis.com [195.60.68.13])
 by ozlabs.org (Postfix) with ESMTP id 26F412C0504
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 24 Jun 2013 16:48:03 +1000 (EST)
Date: Mon, 24 Jun 2013 08:41:56 +0200
From: Jesper Nilsson <jesper.nilsson@axis.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Subject: Re: [PATCH 33/45] cris/smp: Use get/put_online_cpus_atomic() to
 prevent CPU offline
Message-ID: <20130624064156.GR23735@axis.com>
References: <20130623133642.19094.16038.stgit@srivatsabhat.in.ibm.com>
 <20130623134536.19094.52797.stgit@srivatsabhat.in.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20130623134536.19094.52797.stgit@srivatsabhat.in.ibm.com>
Cc: peterz@infradead.org, fweisbec@gmail.com, linux-kernel@vger.kernel.org,
 walken@google.com, mingo@kernel.org, linux-arch@vger.kernel.org,
 vincent.guittot@linaro.org, linux-cris-kernel@axis.com,
 xiaoguangrong@linux.vnet.ibm.com, wangyun@linux.vnet.ibm.com,
 paulmck@linux.vnet.ibm.com, nikunj@linux.vnet.ibm.com,
 linux-pm@vger.kernel.org, rusty@rustcorp.com.au, rostedt@goodmis.org,
 Jesper Nilsson <jespern@axis.com>, Mikael Starvik <starvik@axis.com>,
 namhyung@kernel.org, tglx@linutronix.de, laijs@cn.fujitsu.com,
 zhong@linux.vnet.ibm.com, netdev@vger.kernel.org, oleg@redhat.com, sbw@mit.edu,
 tj@kernel.org, akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Sun, Jun 23, 2013 at 07:15:39PM +0530, Srivatsa S. Bhat wrote:
> Once stop_machine() is gone from the CPU offline path, we won't be able
> to depend on disabling preemption to prevent CPUs from going offline
> from under us.
> 
> Use the get/put_online_cpus_atomic() APIs to prevent CPUs from going
> offline, while invoking from atomic context.
> 
> Cc: Mikael Starvik <starvik@axis.com>

Acked-by: Jesper Nilsson <jesper.nilsson@axis.com>

> Cc: Thomas Gleixner <tglx@linutronix.de>
> Cc: linux-cris-kernel@axis.com
> Signed-off-by: Srivatsa S. Bhat <srivatsa.bhat@linux.vnet.ibm.com>
> ---
> 
>  arch/cris/arch-v32/kernel/smp.c |    5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/arch/cris/arch-v32/kernel/smp.c b/arch/cris/arch-v32/kernel/smp.c
> index cdd1202..b2d4612 100644
> --- a/arch/cris/arch-v32/kernel/smp.c
> +++ b/arch/cris/arch-v32/kernel/smp.c
> @@ -13,6 +13,7 @@
>  #include <linux/init.h>
>  #include <linux/timex.h>
>  #include <linux/sched.h>
> +#include <linux/cpu.h>
>  #include <linux/kernel.h>
>  #include <linux/cpumask.h>
>  #include <linux/interrupt.h>
> @@ -222,6 +223,7 @@ void flush_tlb_common(struct mm_struct* mm, struct vm_area_struct* vma, unsigned
>  	unsigned long flags;
>  	cpumask_t cpu_mask;
>  
> +	get_online_cpus_atomic();
>  	spin_lock_irqsave(&tlbstate_lock, flags);
>  	cpu_mask = (mm == FLUSH_ALL ? cpu_all_mask : *mm_cpumask(mm));
>  	cpumask_clear_cpu(smp_processor_id(), &cpu_mask);
> @@ -230,6 +232,7 @@ void flush_tlb_common(struct mm_struct* mm, struct vm_area_struct* vma, unsigned
>  	flush_addr = addr;
>  	send_ipi(IPI_FLUSH_TLB, 1, cpu_mask);
>  	spin_unlock_irqrestore(&tlbstate_lock, flags);
> +	put_online_cpus_atomic();
>  }
>  
>  void flush_tlb_all(void)
> @@ -319,10 +322,12 @@ int smp_call_function(void (*func)(void *info), void *info, int wait)
>  	data.info = info;
>  	data.wait = wait;
>  
> +	get_online_cpus_atomic();
>  	spin_lock(&call_lock);
>  	call_data = &data;
>  	ret = send_ipi(IPI_CALL, wait, cpu_mask);
>  	spin_unlock(&call_lock);
> +	put_online_cpus_atomic();
>  
>  	return ret;
>  }
> 
> --
> To unsubscribe from this list: send the line "unsubscribe linux-kernel" in
> the body of a message to majordomo@vger.kernel.org
> More majordomo info at  http://vger.kernel.org/majordomo-info.html
> Please read the FAQ at  http://www.tux.org/lkml/

/^JN - Jesper Nilsson
-- 
               Jesper Nilsson -- jesper.nilsson@axis.com
