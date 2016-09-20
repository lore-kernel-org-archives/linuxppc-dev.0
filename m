Return-Path: <borntraeger@de.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3sdgJV5SzxzDsfj
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 21:19:38 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 u8KBI5S5139687
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 07:19:36 -0400
Received: from e06smtp09.uk.ibm.com (e06smtp09.uk.ibm.com [195.75.94.105])
 by mx0a-001b2d01.pphosted.com with ESMTP id 25jnp6tpbw-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 07:19:35 -0400
Received: from localhost
 by e06smtp09.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <borntraeger@de.ibm.com>;
 Tue, 20 Sep 2016 12:19:33 +0100
Received: from b06cxnps4075.portsmouth.uk.ibm.com
 (d06relay12.portsmouth.uk.ibm.com [9.149.109.197])
 by d06dlp01.portsmouth.uk.ibm.com (Postfix) with ESMTP id DA9CB17D8063
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 12:21:29 +0100 (BST)
Received: from d06av10.portsmouth.uk.ibm.com (d06av10.portsmouth.uk.ibm.com
 [9.149.37.251])
 by b06cxnps4075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u8KBJV7T14549284
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 11:19:31 GMT
Received: from d06av10.portsmouth.uk.ibm.com (localhost [127.0.0.1])
 by d06av10.portsmouth.uk.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u8KAJX9Z009404
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Sep 2016 04:19:33 -0600
Subject: Re: [PATCH][RFC] Implement arch primitives for busywait loops
To: Nicholas Piggin <npiggin@gmail.com>, linux-arch@vger.kernel.org
References: <20160916085736.7857-1-npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-s390 <linux-s390@vger.kernel.org>
From: Christian Borntraeger <borntraeger@de.ibm.com>
Date: Tue, 20 Sep 2016 13:19:30 +0200
MIME-Version: 1.0
In-Reply-To: <20160916085736.7857-1-npiggin@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <60adab94-f32e-2287-4821-81a88fa366d4@de.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 09/16/2016 10:57 AM, Nicholas Piggin wrote:
> Implementing busy wait loops with cpu_relax() in callers poses
> some difficulties for powerpc.
> 
> First, we want to put our SMT thread into a low priority mode for the
> duration of the loop, but then return to normal priority after exiting
> the loop.  Dependong on the CPU design, 'HMT_low() ; HMT_medium();' as
> cpu_relax() does may have HMT_medium take effect before HMT_low made
> any (or much) difference.
> 
> Second, it can be beneficial for some implementations to spin on the
> exit condition with a statically predicted-not-taken branch (i.e.,
> always predict the loop will exit).
> 
> This is a quick RFC with a couple of users converted to see what
> people think. I don't use a C branch with hints, because we don't want
> the compiler moving the loop body out of line, which makes it a bit
> messy unfortunately. If there's a better way to do it, I'm all ears.
> 
> I would not propose to switch all callers immediately, just some
> core synchronisation primitives.
Just a FYA,

On s390 we have a private version of cpu_relax that yields the cpu
time slice back to the hypervisor via a hypercall. As this turned out
to be problematic in some cases there is also now a cpu_relax_lowlatency.

Now, this seems still problematic as there are too many places still 
using cpu_relax instead of cpu_relax_lowlatency. So my plan is to do 
a change of that, make cpu_relax just be a barrier and add a new 
cpu_relax_yield that gives up the time slice. (so that s390 cpu_relax
is just like any other cpu_relax)

As far as I can tell the only place where I want to change cpu_relax
to cpu_relax_lowlatency after that change is the stop machine run 
code, so I hope to have no conflicts with your changes.
> 
> ---
>  arch/powerpc/include/asm/processor.h | 22 ++++++++++++++++++++++
>  include/asm-generic/barrier.h        |  7 ++-----
>  include/linux/bit_spinlock.h         |  5 ++---
>  include/linux/cgroup.h               |  7 ++-----
>  include/linux/seqlock.h              | 10 ++++------
>  5 files changed, 32 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/processor.h b/arch/powerpc/include/asm/processor.h
> index 68e3bf5..e10aee2 100644
> --- a/arch/powerpc/include/asm/processor.h
> +++ b/arch/powerpc/include/asm/processor.h
> @@ -402,6 +402,28 @@ static inline unsigned long __pack_fe01(unsigned int fpmode)
> 
>  #ifdef CONFIG_PPC64
>  #define cpu_relax()	do { HMT_low(); HMT_medium(); barrier(); } while (0)
> +
> +#define spin_do						\
> +do {							\
> +	HMT_low();					\
> +	__asm__ __volatile__ (	"1010:");
> +
> +#define spin_while(cond)				\
> +	barrier();					\
> +	__asm__ __volatile__ (	"cmpdi	%0,0	\n\t"	\
> +				"beq-	1010b	\n\t"	\
> +				: : "r" (cond));	\
> +	HMT_medium();					\
> +} while (0)
> +
> +#define spin_until(cond)				\
> +	barrier();					\
> +	__asm__ __volatile__ (	"cmpdi	%0,0	\n\t"	\
> +				"bne-	1010b	\n\t"	\
> +				: : "r" (cond));	\
> +	HMT_medium();					\
> +} while (0)
> +
>  #else
>  #define cpu_relax()	barrier()
>  #endif
> diff --git a/include/asm-generic/barrier.h b/include/asm-generic/barrier.h
> index fe297b5..4c53b3a 100644
> --- a/include/asm-generic/barrier.h
> +++ b/include/asm-generic/barrier.h
> @@ -235,12 +235,9 @@ do {									\
>  #define smp_cond_load_acquire(ptr, cond_expr) ({		\
>  	typeof(ptr) __PTR = (ptr);				\
>  	typeof(*ptr) VAL;					\
> -	for (;;) {						\
> +	spin_do {						\
>  		VAL = READ_ONCE(*__PTR);			\
> -		if (cond_expr)					\
> -			break;					\
> -		cpu_relax();					\
> -	}							\
> +	} spin_until (cond_expr);				\
>  	smp_acquire__after_ctrl_dep();				\
>  	VAL;							\
>  })
> diff --git a/include/linux/bit_spinlock.h b/include/linux/bit_spinlock.h
> index 3b5bafc..695743c 100644
> --- a/include/linux/bit_spinlock.h
> +++ b/include/linux/bit_spinlock.h
> @@ -25,9 +25,8 @@ static inline void bit_spin_lock(int bitnum, unsigned long *addr)
>  #if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
>  	while (unlikely(test_and_set_bit_lock(bitnum, addr))) {
>  		preempt_enable();
> -		do {
> -			cpu_relax();
> -		} while (test_bit(bitnum, addr));
> +		spin_do {
> +		} spin_while (test_bit(bitnum, addr));
>  		preempt_disable();
>  	}
>  #endif
> diff --git a/include/linux/cgroup.h b/include/linux/cgroup.h
> index 984f73b..e7d395f 100644
> --- a/include/linux/cgroup.h
> +++ b/include/linux/cgroup.h
> @@ -450,12 +450,9 @@ task_get_css(struct task_struct *task, int subsys_id)
>  	struct cgroup_subsys_state *css;
> 
>  	rcu_read_lock();
> -	while (true) {
> +	spin_do {
>  		css = task_css(task, subsys_id);
> -		if (likely(css_tryget_online(css)))
> -			break;
> -		cpu_relax();
> -	}
> +	} spin_until (likely(css_tryget_online(css)));
>  	rcu_read_unlock();
>  	return css;
>  }
> diff --git a/include/linux/seqlock.h b/include/linux/seqlock.h
> index ead9765..93ed609 100644
> --- a/include/linux/seqlock.h
> +++ b/include/linux/seqlock.h
> @@ -108,12 +108,10 @@ static inline unsigned __read_seqcount_begin(const seqcount_t *s)
>  {
>  	unsigned ret;
> 
> -repeat:
> -	ret = READ_ONCE(s->sequence);
> -	if (unlikely(ret & 1)) {
> -		cpu_relax();
> -		goto repeat;
> -	}
> +	spin_do {
> +		ret = READ_ONCE(s->sequence);
> +	} spin_while (unlikely(ret & 1));
> +
>  	return ret;
>  }
> 
