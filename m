Return-Path: <compudj@efficios.com>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7SDN6dsSzDqhb
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 09:31:32 +1100 (AEDT)
Date: Thu, 5 Oct 2017 22:32:48 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>
Cc: linux-kernel <linux-kernel@vger.kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>,
 maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>,
 Avi Kivity <avi@scylladb.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>,
 Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 Nicholas Piggin <npiggin@gmail.com>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arch <linux-arch@vger.kernel.org>
Message-ID: <172059699.32347.1507242768488.JavaMail.zimbra@efficios.com>
In-Reply-To: <20171005214050.32700-2-mathieu.desnoyers@efficios.com>
References: <20171005214050.32700-1-mathieu.desnoyers@efficios.com>
 <20171005214050.32700-2-mathieu.desnoyers@efficios.com>
Subject: Re: [RFC PATCH for 4.14 2/2] Fix: membarrier: Handle CLONE_VM +
 !CLONE_THREAD correctly on powerpc
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

----- On Oct 5, 2017, at 5:40 PM, Mathieu Desnoyers mathieu.desnoyers@efficios.com wrote:

> Threads targeting the same VM but which belong to different thread
> groups is a tricky case. It has a few consequences:
> 
> It turns out that we cannot rely on get_nr_threads(p) to count the
> number of threads using a VM. We can use
> (atomic_read(&mm->mm_users) == 1 && get_nr_threads(p) == 1)
> instead to skip the synchronize_sched() for cases where the VM only has
> a single user, and that user only has a single thread.
> 
> It also turns out that we cannot use for_each_thread() to set
> thread flags in all threads using a VM, as it only iterates on the
> thread group.
> 
> Therefore, test the membarrier state variable directly rather than
> relying on thread flags. This means
> membarrier_register_private_expedited() needs to set the
> MEMBARRIER_STATE_SWITCH_MM flag, issue synchronize_sched(), and only
> then set MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY which allows private
> expedited membarrier commands to succeed. membarrier_arch_switch_mm()
> now tests for the MEMBARRIER_STATE_SWITCH_MM flag.

I forgot to remove the membarrier thread flag on powerpc (now unused
with this patch).

I'll send a v2 fixing this.

Thanks,

Mathieu

> 
> Reported-by: Peter Zijlstra <peterz@infradead.org>
> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> CC: Boqun Feng <boqun.feng@gmail.com>
> CC: Andrew Hunter <ahh@google.com>
> CC: Maged Michael <maged.michael@gmail.com>
> CC: gromer@google.com
> CC: Avi Kivity <avi@scylladb.com>
> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> CC: Paul Mackerras <paulus@samba.org>
> CC: Michael Ellerman <mpe@ellerman.id.au>
> CC: Dave Watson <davejwatson@fb.com>
> CC: Alan Stern <stern@rowland.harvard.edu>
> CC: Will Deacon <will.deacon@arm.com>
> CC: Andy Lutomirski <luto@kernel.org>
> CC: Ingo Molnar <mingo@redhat.com>
> CC: Alexander Viro <viro@zeniv.linux.org.uk>
> CC: Nicholas Piggin <npiggin@gmail.com>
> CC: linuxppc-dev@lists.ozlabs.org
> CC: linux-arch@vger.kernel.org
> ---
> arch/powerpc/include/asm/membarrier.h | 21 ++-------------------
> arch/powerpc/kernel/membarrier.c      | 17 ++++-------------
> include/linux/mm_types.h              |  2 +-
> include/linux/sched/mm.h              | 28 ++++++----------------------
> kernel/fork.c                         |  2 --
> kernel/sched/membarrier.c             | 16 +++++++++++++---
> 6 files changed, 26 insertions(+), 60 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/membarrier.h
> b/arch/powerpc/include/asm/membarrier.h
> index 61152a7a3cf9..0951646253d9 100644
> --- a/arch/powerpc/include/asm/membarrier.h
> +++ b/arch/powerpc/include/asm/membarrier.h
> @@ -11,8 +11,8 @@ static inline void membarrier_arch_switch_mm(struct mm_struct
> *prev,
> 	 * when switching from userspace to kernel is not needed after
> 	 * store to rq->curr.
> 	 */
> -	if (likely(!test_ti_thread_flag(task_thread_info(tsk),
> -			TIF_MEMBARRIER_PRIVATE_EXPEDITED) || !prev))
> +	if (likely(!(atomic_read(&next->membarrier_state)
> +			& MEMBARRIER_STATE_SWITCH_MM) || !prev))
> 		return;
> 
> 	/*
> @@ -21,23 +21,6 @@ static inline void membarrier_arch_switch_mm(struct mm_struct
> *prev,
> 	 */
> 	smp_mb();
> }
> -static inline void membarrier_arch_fork(struct task_struct *t,
> -		unsigned long clone_flags)
> -{
> -	/*
> -	 * Coherence of TIF_MEMBARRIER_PRIVATE_EXPEDITED against thread
> -	 * fork is protected by siglock. membarrier_arch_fork is called
> -	 * with siglock held.
> -	 */
> -	if (test_thread_flag(TIF_MEMBARRIER_PRIVATE_EXPEDITED))
> -		set_ti_thread_flag(task_thread_info(t),
> -				TIF_MEMBARRIER_PRIVATE_EXPEDITED);
> -}
> -static inline void membarrier_arch_execve(struct task_struct *t)
> -{
> -	clear_ti_thread_flag(task_thread_info(t),
> -			TIF_MEMBARRIER_PRIVATE_EXPEDITED);
> -}
> void membarrier_arch_register_private_expedited(struct task_struct *t);
> 
> #endif /* _ASM_POWERPC_MEMBARRIER_H */
> diff --git a/arch/powerpc/kernel/membarrier.c b/arch/powerpc/kernel/membarrier.c
> index b0d79a5f5981..4795ad59b833 100644
> --- a/arch/powerpc/kernel/membarrier.c
> +++ b/arch/powerpc/kernel/membarrier.c
> @@ -19,24 +19,15 @@
> #include <linux/thread_info.h>
> #include <linux/spinlock.h>
> #include <linux/rcupdate.h>
> +#include <linux/atomic.h>
> 
> void membarrier_arch_register_private_expedited(struct task_struct *p)
> {
> -	struct task_struct *t;
> +	struct mm_struct *mm = p->mm;
> 
> -	if (get_nr_threads(p) == 1) {
> -		set_thread_flag(TIF_MEMBARRIER_PRIVATE_EXPEDITED);
> +	atomic_or(MEMBARRIER_STATE_SWITCH_MM, &mm->membarrier_state);
> +	if (atomic_read(&mm->mm_users) == 1 && get_nr_threads(p) == 1)
> 		return;
> -	}
> -	/*
> -	 * Coherence of TIF_MEMBARRIER_PRIVATE_EXPEDITED against thread
> -	 * fork is protected by siglock.
> -	 */
> -	spin_lock(&p->sighand->siglock);
> -	for_each_thread(p, t)
> -		set_ti_thread_flag(task_thread_info(t),
> -				TIF_MEMBARRIER_PRIVATE_EXPEDITED);
> -	spin_unlock(&p->sighand->siglock);
> 	/*
> 	 * Ensure all future scheduler executions will observe the new
> 	 * thread flag state for this process.
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index 5e0fe8ce053b..1861ea8dba77 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -446,7 +446,7 @@ struct mm_struct {
> 
> 	struct core_state *core_state; /* coredumping support */
> #ifdef CONFIG_MEMBARRIER
> -	int membarrier_private_expedited;
> +	atomic_t membarrier_state;
> #endif
> #ifdef CONFIG_AIO
> 	spinlock_t			ioctx_lock;
> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
> index b2767ecb21a8..2fb6089efcd7 100644
> --- a/include/linux/sched/mm.h
> +++ b/include/linux/sched/mm.h
> @@ -212,35 +212,23 @@ static inline void memalloc_noreclaim_restore(unsigned int
> flags)
> 
> #ifdef CONFIG_MEMBARRIER
> 
> +enum {
> +	MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY	= (1U << 0),
> +	MEMBARRIER_STATE_SWITCH_MM			= (1U << 1),
> +};
> +
> #ifdef CONFIG_ARCH_HAS_MEMBARRIER_HOOKS
> #include <asm/membarrier.h>
> #else
> -static inline void membarrier_arch_fork(struct task_struct *t,
> -		unsigned long clone_flags)
> -{
> -}
> -static inline void membarrier_arch_execve(struct task_struct *t)
> -{
> -}
> static inline void membarrier_arch_register_private_expedited(
> 		struct task_struct *p)
> {
> }
> #endif
> 
> -static inline void membarrier_fork(struct task_struct *t,
> -		unsigned long clone_flags)
> -{
> -	/*
> -	 * Prior copy_mm() copies the membarrier_private_expedited field
> -	 * from current->mm to t->mm.
> -	 */
> -	membarrier_arch_fork(t, clone_flags);
> -}
> static inline void membarrier_execve(struct task_struct *t)
> {
> -	t->mm->membarrier_private_expedited = 0;
> -	membarrier_arch_execve(t);
> +	atomic_set(&t->mm->membarrier_state, 0);
> }
> #else
> #ifdef CONFIG_ARCH_HAS_MEMBARRIER_HOOKS
> @@ -249,10 +237,6 @@ static inline void membarrier_arch_switch_mm(struct
> mm_struct *prev,
> {
> }
> #endif
> -static inline void membarrier_fork(struct task_struct *t,
> -		unsigned long clone_flags)
> -{
> -}
> static inline void membarrier_execve(struct task_struct *t)
> {
> }
> diff --git a/kernel/fork.c b/kernel/fork.c
> index bd4a93915e08..10646182440f 100644
> --- a/kernel/fork.c
> +++ b/kernel/fork.c
> @@ -1840,8 +1840,6 @@ static __latent_entropy struct task_struct *copy_process(
> 	 */
> 	copy_seccomp(p);
> 
> -	membarrier_fork(p, clone_flags);
> -
> 	/*
> 	 * Process group and session signals need to be delivered to just the
> 	 * parent before the fork or both the parent and the child after the
> diff --git a/kernel/sched/membarrier.c b/kernel/sched/membarrier.c
> index f06949a279ca..23bd256f8458 100644
> --- a/kernel/sched/membarrier.c
> +++ b/kernel/sched/membarrier.c
> @@ -18,6 +18,7 @@
> #include <linux/membarrier.h>
> #include <linux/tick.h>
> #include <linux/cpumask.h>
> +#include <linux/atomic.h>
> 
> #include "sched.h"	/* for cpu_rq(). */
> 
> @@ -40,7 +41,8 @@ static int membarrier_private_expedited(void)
> 	bool fallback = false;
> 	cpumask_var_t tmpmask;
> 
> -	if (!READ_ONCE(current->mm->membarrier_private_expedited))
> +	if (!(atomic_read(&current->mm->membarrier_state)
> +			& MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY))
> 		return -EPERM;
> 
> 	if (num_online_cpus() == 1)
> @@ -104,11 +106,19 @@ static int membarrier_private_expedited(void)
> static void membarrier_register_private_expedited(void)
> {
> 	struct task_struct *p = current;
> +	struct mm_struct *mm = p->mm;
> 
> -	if (READ_ONCE(p->mm->membarrier_private_expedited))
> +	/*
> +	 * We need to consider threads belonging to different thread
> +	 * groups, which use the same mm. (CLONE_VM but not
> +	 * CLONE_THREAD).
> +	 */
> +	if (atomic_read(&mm->membarrier_state)
> +			& MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY)
> 		return;
> 	membarrier_arch_register_private_expedited(p);
> -	WRITE_ONCE(p->mm->membarrier_private_expedited, 1);
> +	atomic_or(MEMBARRIER_STATE_PRIVATE_EXPEDITED_READY,
> +			&mm->membarrier_state);
> }
> 
> /**
> --
> 2.11.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
