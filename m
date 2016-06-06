Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rNMkF3Y3czDq64
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  6 Jun 2016 14:52:05 +1000 (AEST)
In-Reply-To: <20160603034948.17589-1-boqun.feng@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Will Deacon <will.deacon@arm.com>, Paul Mackerras <paulus@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Subject: Re: [v2] powerpc: spinlock: Fix spin_unlock_wait()
Message-Id: <3rNMkF2Y1sz9t4P@ozlabs.org>
Date: Mon,  6 Jun 2016 14:52:05 +1000 (AEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2016-03-06 at 03:49:48 UTC, Boqun Feng wrote:
> There is an ordering issue with spin_unlock_wait() on powerpc, because
> the spin_lock primitive is an ACQUIRE and an ACQUIRE is only ordering
> the load part of the operation with memory operations following it.

...
> diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
> index 523673d7583c..2ed893662866 100644
> --- a/arch/powerpc/include/asm/spinlock.h
> +++ b/arch/powerpc/include/asm/spinlock.h
> @@ -162,12 +181,23 @@ static inline void arch_spin_unlock(arch_spinlock_t *lock)
>  	lock->slock = 0;
>  }
>  
> -#ifdef CONFIG_PPC64
> -extern void arch_spin_unlock_wait(arch_spinlock_t *lock);
> -#else
> -#define arch_spin_unlock_wait(lock) \
> -	do { while (arch_spin_is_locked(lock)) cpu_relax(); } while (0)
> -#endif
> +static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
> +{
> +	smp_mb();
> +
> +	if (!arch_spin_is_locked_sync(lock))
> +		goto out;
> +
> +	while (!arch_spin_value_unlocked(*lock)) {
> +		HMT_low();
> +		if (SHARED_PROCESSOR)
> +			__spin_yield(lock);
> +	}
> +	HMT_medium();
> +
> +out:
> +	smp_mb();
> +}

I think this would actually be easier to follow if it was all just in one routine:

static inline void arch_spin_unlock_wait(arch_spinlock_t *lock)
{
	arch_spinlock_t lock_val;

	smp_mb();

	/*
	 * Atomically load and store back the lock value (unchanged). This
	 * ensures that our observation of the lock value is ordered with
	 * respect to other lock operations.
	 */
	__asm__ __volatile__(
"1:	" PPC_LWARX(%0, 0, %2, 1) "\n"
"	stwcx. %0, 0, %2\n"
"	bne- 1b\n"
	: "=&r" (lock_val), "+m" (*lock)
	: "r" (lock)
	: "cr0", "xer");

	if (arch_spin_value_unlocked(lock_val))
		goto out;

	while (!arch_spin_value_unlocked(*lock)) {
		HMT_low();
		if (SHARED_PROCESSOR)
			__spin_yield(lock);
	}
	HMT_medium();

out:
	smp_mb();
}


Thoughts?

cheers
