Return-Path: <paubert@iram.es>
Received: from torres.puc.rediris.es (torres.puc.rediris.es
 [IPv6:2001:720:418:ca00::22])
 (using TLSv1.2 with cipher DHE-RSA-AES128-SHA (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJ1tG4nMwzDt31
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Nov 2016 20:14:30 +1100 (AEDT)
Date: Tue, 15 Nov 2016 09:06:44 +0100
From: Gabriel Paubert <paubert@iram.es>
To: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, benh@kernel.crashing.org,
 linuxppc-dev@lists.ozlabs.org, paulus@samba.org, anton@samba.org,
 npiggin@gmail.com
Subject: Re: [PATCH v3 11/11] powerpc: rewrite local_t using soft_irq
Message-ID: <20161115080644.GA23527@visitor2.iram.es>
References: <1479146692-15726-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1479146692-15726-12-git-send-email-maddy@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1479146692-15726-12-git-send-email-maddy@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

    Hi,
    
On Mon, Nov 14, 2016 at 11:34:52PM +0530, Madhavan Srinivasan wrote:
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

s/patch/path/ ?

> really slow. Since CR5 based implementation proposed using __ex_table to find
> the rewind addressr, this rasied concerns about size of __ex_table and vmlinux.
> 
> https://lists.ozlabs.org/pipermail/linuxppc-dev/2014-December/123115.html
> 
> But this patch uses, powerpc_local_irq_pmu_save to soft_disable
> interrupts (including PMIs). After finishing the "op", powerpc_local_irq_pmu_restore()
> called and correspondingly interrupts are replayed if any occured.
> 
> patch re-write the current local_* functions to use arch_local_irq_disbale.
> Base flow for each function is
> 
> {
> 	powerpc_local_irq_pmu_save(flags)
> 	load
> 	..
> 	store
> 	powerpc_local_irq_pmu_restore(flags)
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
> _add_return	            28              7
> 
> Currently only asm/local.h has been rewrite, and also

s/rewrite/rewritten/

> the entire change is tested only in PPC64 (pseries guest)
> and PPC64 host (LE)

I'm really wondering whether this is the kind of thing that would
benefit from transactions. But transactional memory was only implemented
on Power7 and later IIRC, and we still need to support machines without
transactional memory. 

Boot time patching would probably be very cumbersome, so I believe
that the only sensible thing to do would be to add a config option 
that would generate a kernel that only runs on machines with 
transactional memory.

And then benchmark...

    Gabriel

> 
> Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
> Signed-off-by: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/local.h | 201 +++++++++++++++++++++++++++++++++++++++
>  1 file changed, 201 insertions(+)
> 
> diff --git a/arch/powerpc/include/asm/local.h b/arch/powerpc/include/asm/local.h
> index b8da91363864..7d117c07b0b1 100644
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
> @@ -14,6 +17,202 @@ typedef struct
>  #define local_read(l)	atomic_long_read(&(l)->a)
>  #define local_set(l,i)	atomic_long_set(&(l)->a, (i))
>  
> +#ifdef CONFIG_PPC64
> +
> +static __inline__ void local_add(long i, local_t *l)
> +{
> +	long t;
> +	unsigned long flags;
> +
> +	powerpc_local_irq_pmu_save(flags);
> +	__asm__ __volatile__(
> +	PPC_LL" %0,0(%2)\n\
> +	add	%0,%1,%0\n"
> +	PPC_STL" %0,0(%2)\n"
> +	: "=&r" (t)
> +	: "r" (i), "r" (&(l->a.counter)));
> +	powerpc_local_irq_pmu_restore(flags);
> +}
> +
> +static __inline__ void local_sub(long i, local_t *l)
> +{
> +	long t;
> +	unsigned long flags;
> +
> +	powerpc_local_irq_pmu_save(flags);
> +	__asm__ __volatile__(
> +	PPC_LL" %0,0(%2)\n\
> +	subf	%0,%1,%0\n"
> +	PPC_STL" %0,0(%2)\n"
> +	: "=&r" (t)
> +	: "r" (i), "r" (&(l->a.counter)));
> +	powerpc_local_irq_pmu_restore(flags);
> +}
> +
> +static __inline__ long local_add_return(long a, local_t *l)
> +{
> +	long t;
> +	unsigned long flags;
> +
> +	powerpc_local_irq_pmu_save(flags);
> +	__asm__ __volatile__(
> +	PPC_LL" %0,0(%2)\n\
> +	add	%0,%1,%0\n"
> +	PPC_STL "%0,0(%2)\n"
> +	: "=&r" (t)
> +	: "r" (a), "r" (&(l->a.counter))
> +	: "memory");
> +	powerpc_local_irq_pmu_restore(flags);
> +
> +	return t;
> +}
> +
> +#define local_add_negative(a, l)	(local_add_return((a), (l)) < 0)
> +
> +static __inline__ long local_sub_return(long a, local_t *l)
> +{
> +	long t;
> +	unsigned long flags;
> +
> +	powerpc_local_irq_pmu_save(flags);
> +	__asm__ __volatile__(
> +	PPC_LL" %0,0(%2)\n\
> +	subf	%0,%1,%0\n"
> +	PPC_STL "%0,0(%2)\n"
> +	: "=&r" (t)
> +	: "r" (a), "r" (&(l->a.counter))
> +	: "memory");
> +	powerpc_local_irq_pmu_restore(flags);
> +
> +	return t;
> +}
> +
> +static __inline__ long local_inc_return(local_t *l)
> +{
> +	long t;
> +	unsigned long flags;
> +
> +	powerpc_local_irq_pmu_save(flags);
> +	__asm__ __volatile__(
> +	PPC_LL" %0,0(%1)\n\
> +	addic	%0,%0,1\n"
> +	PPC_STL "%0,0(%1)\n"
> +	: "=&r" (t)
> +	: "r" (&(l->a.counter))
> +	: "xer", "memory");
> +	powerpc_local_irq_pmu_restore(flags);
> +
> +	return t;
> +}
> +
> +/*
> + * local_inc_and_test - increment and test
> + * @l: pointer of type local_t
> + *
> + * Atomically increments @l by 1
> + * and returns true if the result is zero, or false for all
> + * other cases.
> + */
> +#define local_inc_and_test(l) (local_inc_return(l) == 0)
> +
> +static __inline__ long local_dec_return(local_t *l)
> +{
> +	long t;
> +	unsigned long flags;
> +
> +	powerpc_local_irq_pmu_save(flags);
> +	__asm__ __volatile__(
> +	PPC_LL" %0,0(%1)\n\
> +	addic	%0,%0,-1\n"
> +	PPC_STL "%0,0(%1)\n"
> +	: "=&r" (t)
> +	: "r" (&(l->a.counter))
> +	: "xer", "memory");
> +	powerpc_local_irq_pmu_restore(flags);
> +
> +	return t;
> +}
> +
> +#define local_inc(l)	local_inc_return(l)
> +#define local_dec(l)	local_dec_return(l)
> +
> +#define local_cmpxchg(l, o, n) \
> +	(cmpxchg_local(&((l)->a.counter), (o), (n)))
> +#define local_xchg(l, n) (xchg_local(&((l)->a.counter), (n)))
> +
> +/**
> + * local_add_unless - add unless the number is a given value
> + * @l: pointer of type local_t
> + * @a: the amount to add to v...
> + * @u: ...unless v is equal to u.
> + *
> + * Atomically adds @a to @l, so long as it was not @u.
> + * Returns non-zero if @l was not @u, and zero otherwise.
> + */
> +static __inline__ int local_add_unless(local_t *l, long a, long u)
> +{
> +	long t;
> +	unsigned long flags;
> +
> +	powerpc_local_irq_pmu_save(flags);
> +	__asm__ __volatile__ (
> +	PPC_LL" %0,0(%1)\n\
> +	cmpw	0,%0,%3 \n\
> +	beq-	2f \n\
> +	add	%0,%2,%0 \n"
> +	PPC_STL" %0,0(%1) \n"
> +"       subf	%0,%2,%0 \n\
> +2:"
> +        : "=&r" (t)
> +        : "r" (&(l->a.counter)), "r" (a), "r" (u)
> +        : "cc", "memory");
> +        powerpc_local_irq_pmu_restore(flags);
> +
> +	return t != u;
> +}
> +
> +#define local_inc_not_zero(l) local_add_unless((l), 1, 0)
> +
> +#define local_sub_and_test(a, l)	(local_sub_return((a), (l)) == 0)
> +#define local_dec_and_test(l)		(local_dec_return((l)) == 0)
> +
> +/*
> + * Atomically test *l and decrement if it is greater than 0.
> + * The function returns the old value of *l minus 1.
> + */
> +static __inline__ long local_dec_if_positive(local_t *l)
> +{
> +	long t;
> +	unsigned long flags;
> +
> +	powerpc_local_irq_pmu_save(flags);
> +	__asm__ __volatile__(
> +	PPC_LL" %0,0(%1)\n\
> +	cmpwi	%0,1\n\
> +	addi	%0,%0,-1\n\
> +	blt-	2f\n"
> +	PPC_STL "%0,0(%1)\n"
> +	"\n\
> +2:"	: "=&b" (t)
> +	: "r" (&(l->a.counter))
> +	: "cc", "memory");
> +	powerpc_local_irq_pmu_restore(flags);
> +
> +	return t;
> +}
> +
> +/* Use these for per-cpu local_t variables: on some archs they are
> + * much more efficient than these naive implementations.  Note they take
> + * a variable, not an address.
> + */
> +
> +#define __local_inc(l)		((l)->a.counter++)
> +#define __local_dec(l)		((l)->a.counter++)
> +#define __local_add(i,l)	((l)->a.counter+=(i))
> +#define __local_sub(i,l)	((l)->a.counter-=(i))
> +
> +#else
> +
>  #define local_add(i,l)	atomic_long_add((i),(&(l)->a))
>  #define local_sub(i,l)	atomic_long_sub((i),(&(l)->a))
>  #define local_inc(l)	atomic_long_inc(&(l)->a)
> @@ -172,4 +371,6 @@ static __inline__ long local_dec_if_positive(local_t *l)
>  #define __local_add(i,l)	((l)->a.counter+=(i))
>  #define __local_sub(i,l)	((l)->a.counter-=(i))
>  
> +#endif /* CONFIG_PPC64 */
> +
>  #endif /* _ARCH_POWERPC_LOCAL_H */
> -- 
> 2.7.4
