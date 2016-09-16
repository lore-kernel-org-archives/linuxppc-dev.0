Return-Path: <npiggin@gmail.com>
Received: from mail-pa0-x243.google.com (mail-pa0-x243.google.com
 [IPv6:2607:f8b0:400e:c03::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sbC5Q0rxzzDsZ3
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 21:01:30 +1000 (AEST)
Received: by mail-pa0-x243.google.com with SMTP id vz6so3370603pab.1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 16 Sep 2016 04:01:30 -0700 (PDT)
Date: Fri, 16 Sep 2016 21:01:20 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: benh@kernel.crashing.org, mpe@ellerman.id.au, anton@samba.org,
 paulus@samba.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH 13/13] powerpc: rewrite local_t using soft_irq
Message-ID: <20160916210120.395a52be@roar.ozlabs.ibm.com>
In-Reply-To: <1473944523-624-14-git-send-email-maddy@linux.vnet.ibm.com>
References: <1473944523-624-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1473944523-624-14-git-send-email-maddy@linux.vnet.ibm.com>
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

On Thu, 15 Sep 2016 18:32:03 +0530
Madhavan Srinivasan <maddy@linux.vnet.ibm.com> wrote:

> Local atomic operations are fast and highly reentrant per CPU counters.
> Used for percpu variable updates. Local atomic operations only guarantee
> variable modification atomicity wrt the CPU which owns the data and
> these needs to be executed in a preemption safe way.
> 
> Here is the design of this patch. Since local_* operations
> are only need to be atomic to interrupts (IIUC), we have two options.
> Either replay the "op" if interrupted or replay the interrupt after
> the "op". Initial patchset posted was based on implementing local_* operation
> based on CR5 which replay's the "op". Patchset had issues in case of
> rewinding the address pointor from an array. This make the slow patch
> really slow. Since CR5 based implementation proposed using __ex_table to find
> the rewind addressr, this rasied concerns about size of __ex_table and vmlinux.
> 
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-December/123115.html
> 
> But this patch uses, local_irq_pmu_save to soft_disable
> interrupts (including PMIs). After finishing the "op", local_irq_pmu_restore()
> called and correspondingly interrupts are replayed if any occured.
> 
> patch re-write the current local_* functions to use arch_local_irq_disbale.
> Base flow for each function is
> 
> {
> 	local_irq_pmu_save(flags)
> 	load
> 	..
> 	store
> 	local_irq_pmu_restore(flags)
> }
> 
> Reason for the approach is that, currently l[w/d]arx/st[w/d]cx.
> instruction pair is used for local_* operations, which are heavy
> on cycle count and they dont support a local variant. So to
> see whether the new implementation helps, used a modified
> version of Rusty's benchmark code on local_t.
> 
> https://lkml.org/lkml/2008/12/16/450
> 
> Modifications to Rusty's benchmark code:
> - Executed only local_t test
> 
> Here are the values with the patch.
> 
> Time in ns per iteration
> 
> Local_t             Without Patch           With Patch
> 
> _inc                        28              8
> _add                        28              8
> _read                       3               3
> _add_return         28              7
> 
> Currently only asm/local.h has been rewrite, and also
> the entire change is tested only in PPC64 (pseries guest)
> and PPC64 host (LE)
> 
> TODO:
> 	- local_cmpxchg and local_xchg needs modification.
> 
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/local.h | 94 ++++++++++++++++++++++++++++------------
>  1 file changed, 66 insertions(+), 28 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
> index b8da91363864..fb5728abb4e9 100644
> --- a/arch/powerpc/include/asm/local.h
> +++ b/arch/powerpc/include/asm/local.h
> @@ -3,6 +3,9 @@
>  
>  #include <linux/percpu.h>
>  #include <linux/atomic.h>
> +#include <linux/irqflags.h>
> +
> +#include <asm/hw_irq.h>
>  
>  typedef struct
>  {
> @@ -14,24 +17,50 @@ typedef struct
>  #define local_read(l)	atomic_long_read(&(l)->a)
>  #define local_set(l,i)	atomic_long_set(&(l)->a, (i))
>  
> -#define local_add(i,l)	atomic_long_add((i),(&(l)->a))
> -#define local_sub(i,l)	atomic_long_sub((i),(&(l)->a))
> -#define local_inc(l)	atomic_long_inc(&(l)->a)
> -#define local_dec(l)	atomic_long_dec(&(l)->a)
> +static __inline__ void local_add(long i, local_t *l)
> +{
> +	long t;
> +	unsigned long flags;
> +
> +	local_irq_pmu_save(flags);
> +	__asm__ __volatile__(
> +	PPC_LL" %0,0(%2)\n\
> +	add     %0,%1,%0\n"
> +	PPC_STL" %0,0(%2)\n"
> +	: "=&r" (t)
> +	: "r" (i), "r" (&(l->a.counter)));
> +	local_irq_pmu_restore(flags);
> +}
> +
> +static __inline__ void local_sub(long i, local_t *l)
> +{
> +	long t;
> +	unsigned long flags;
> +
> +	local_irq_pmu_save(flags);
> +	__asm__ __volatile__(
> +	PPC_LL" %0,0(%2)\n\
> +	subf    %0,%1,%0\n"
> +	PPC_STL" %0,0(%2)\n"
> +	: "=&r" (t)
> +	: "r" (i), "r" (&(l->a.counter)));
> +	local_irq_pmu_restore(flags);
> +}
>  
>  static __inline__ long local_add_return(long a, local_t *l)
>  {
>  	long t;
> +	unsigned long flags;
>  
> +	local_irq_pmu_save(flags);
>  	__asm__ __volatile__(
> -"1:"	PPC_LLARX(%0,0,%2,0) "			# local_add_return\n\
> +	PPC_LL" %0,0(%2)\n\
>  	add	%0,%1,%0\n"
> -	PPC405_ERR77(0,%2)
> -	PPC_STLCX	"%0,0,%2 \n\
> -	bne-	1b"
> +	PPC_STL	"%0,0(%2)\n"
>  	: "=&r" (t)
>  	: "r" (a), "r" (&(l->a.counter))
>  	: "cc", "memory");
> +	local_irq_pmu_restore(flags);

Are all your clobbers correct? You might not be clobbering "cc" here
anymore, for example. Could you double check those? Otherwise, awesome
patch!

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
