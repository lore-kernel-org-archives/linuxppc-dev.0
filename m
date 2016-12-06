Return-Path: <boqun.feng@gmail.com>
Received: from mail-pg0-x244.google.com (mail-pg0-x244.google.com
 [IPv6:2607:f8b0:400e:c05::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tXjfh3hW1zDvvf
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Dec 2016 11:48:28 +1100 (AEDT)
Received: by mail-pg0-x244.google.com with SMTP id e9so17946915pgc.1
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 05 Dec 2016 16:48:28 -0800 (PST)
Date: Tue, 6 Dec 2016 08:47:47 +0800
From: Boqun Feng <boqun.feng@gmail.com>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 peterz@infradead.org, mingo@redhat.com, paulmck@linux.vnet.ibm.com,
 waiman.long@hpe.com, virtualization@lists.linux-foundation.org
Subject: Re: [PATCH v8 1/6] powerpc/qspinlock: powerpc support qspinlock
Message-ID: <20161206004747.GB18164@tardis.cn.ibm.com>
References: <1480951166-44830-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1480951166-44830-2-git-send-email-xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
 protocol="application/pgp-signature"; boundary="KdquIMZPjGJQvRdI"
In-Reply-To: <1480951166-44830-2-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


--KdquIMZPjGJQvRdI
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Dec 05, 2016 at 10:19:21AM -0500, Pan Xinhui wrote:
> This patch add basic code to enable qspinlock on powerpc. qspinlock is
> one kind of fairlock implementation. And seen some performance improvement
> under some scenarios.
>=20
> queued_spin_unlock() release the lock by just one write of NULL to the
> ::locked field which sits at different places in the two endianness
> system.
>=20
> We override some arch_spin_XXX as powerpc has io_sync stuff which makes
> sure the io operations are protected by the lock correctly.
>=20
> There is another special case, see commit
> 2c610022711 ("locking/qspinlock: Fix spin_unlock_wait() some more")
>=20
> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/qspinlock.h      | 66 +++++++++++++++++++++++++=
++++++
>  arch/powerpc/include/asm/spinlock.h       | 31 +++++++++------
>  arch/powerpc/include/asm/spinlock_types.h |  4 ++
>  arch/powerpc/lib/locks.c                  | 59 +++++++++++++++++++++++++=
++
>  4 files changed, 147 insertions(+), 13 deletions(-)
>  create mode 100644 arch/powerpc/include/asm/qspinlock.h
>=20
> diff --git a/arch/powerpc/include/asm/qspinlock.h b/arch/powerpc/include/=
asm/qspinlock.h
> new file mode 100644
> index 0000000..4c89256
> --- /dev/null
> +++ b/arch/powerpc/include/asm/qspinlock.h
> @@ -0,0 +1,66 @@
> +#ifndef _ASM_POWERPC_QSPINLOCK_H
> +#define _ASM_POWERPC_QSPINLOCK_H
> +
> +#include <asm-generic/qspinlock_types.h>
> +
> +#define SPIN_THRESHOLD (1 << 15)
> +#define queued_spin_unlock queued_spin_unlock
> +#define queued_spin_is_locked queued_spin_is_locked
> +#define queued_spin_unlock_wait queued_spin_unlock_wait
> +
> +extern void queued_spin_unlock_wait(struct qspinlock *lock);
> +
> +static inline u8 *__qspinlock_lock_byte(struct qspinlock *lock)
> +{
> +	return (u8 *)lock + 3 * IS_BUILTIN(CONFIG_CPU_BIG_ENDIAN);
> +}
> +
> +static inline void queued_spin_unlock(struct qspinlock *lock)
> +{
> +	/* release semantics is required */
> +	smp_store_release(__qspinlock_lock_byte(lock), 0);
> +}
> +
> +static inline int queued_spin_is_locked(struct qspinlock *lock)
> +{
> +	smp_mb();
> +	return atomic_read(&lock->val);
> +}
> +
> +#include <asm-generic/qspinlock.h>
> +
> +/* we need override it as ppc has io_sync stuff */
> +#undef arch_spin_trylock
> +#undef arch_spin_lock
> +#undef arch_spin_lock_flags
> +#undef arch_spin_unlock
> +#define arch_spin_trylock arch_spin_trylock
> +#define arch_spin_lock arch_spin_lock
> +#define arch_spin_lock_flags arch_spin_lock_flags
> +#define arch_spin_unlock arch_spin_unlock
> +
> +static inline int arch_spin_trylock(arch_spinlock_t *lock)
> +{
> +	CLEAR_IO_SYNC;
> +	return queued_spin_trylock(lock);
> +}
> +
> +static inline void arch_spin_lock(arch_spinlock_t *lock)
> +{
> +	CLEAR_IO_SYNC;
> +	queued_spin_lock(lock);
> +}
> +
> +static inline
> +void arch_spin_lock_flags(arch_spinlock_t *lock, unsigned long flags)
> +{
> +	CLEAR_IO_SYNC;
> +	queued_spin_lock(lock);
> +}
> +
> +static inline void arch_spin_unlock(arch_spinlock_t *lock)
> +{
> +	SYNC_IO;
> +	queued_spin_unlock(lock);
> +}
> +#endif /* _ASM_POWERPC_QSPINLOCK_H */
> diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/a=
sm/spinlock.h
> index 8c1b913..954099e 100644
> --- a/arch/powerpc/include/asm/spinlock.h
> +++ b/arch/powerpc/include/asm/spinlock.h
> @@ -60,6 +60,23 @@ static inline bool vcpu_is_preempted(int cpu)
>  }
>  #endif
> =20
> +#if defined(CONFIG_PPC_SPLPAR)
> +/* We only yield to the hypervisor if we are in shared processor mode */
> +#define SHARED_PROCESSOR (lppaca_shared_proc(local_paca->lppaca_ptr))
> +extern void __spin_yield(arch_spinlock_t *lock);
> +extern void __rw_yield(arch_rwlock_t *lock);
> +#else /* SPLPAR */
> +#define __spin_yield(x)        barrier()
> +#define __rw_yield(x)  barrier()
> +#define SHARED_PROCESSOR       0
> +#endif
> +
> +#ifdef CONFIG_QUEUED_SPINLOCKS
> +#include <asm/qspinlock.h>
> +#else
> +
> +#define arch_spin_relax(lock)  __spin_yield(lock)
> +
>  static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
>  {
>  	return lock.slock =3D=3D 0;
> @@ -114,18 +131,6 @@ static inline int arch_spin_trylock(arch_spinlock_t =
*lock)
>   * held.  Conveniently, we have a word in the paca that holds this
>   * value.
>   */
> -
> -#if defined(CONFIG_PPC_SPLPAR)
> -/* We only yield to the hypervisor if we are in shared processor mode */
> -#define SHARED_PROCESSOR (lppaca_shared_proc(local_paca->lppaca_ptr))
> -extern void __spin_yield(arch_spinlock_t *lock);
> -extern void __rw_yield(arch_rwlock_t *lock);
> -#else /* SPLPAR */
> -#define __spin_yield(x)	barrier()
> -#define __rw_yield(x)	barrier()
> -#define SHARED_PROCESSOR	0
> -#endif
> -
>  static inline void arch_spin_lock(arch_spinlock_t *lock)
>  {
>  	CLEAR_IO_SYNC;
> @@ -203,6 +208,7 @@ static inline void arch_spin_unlock_wait(arch_spinloc=
k_t *lock)
>  	smp_mb();
>  }
> =20
> +#endif /* !CONFIG_QUEUED_SPINLOCKS */
>  /*
>   * Read-write spinlocks, allowing multiple readers
>   * but only one writer.
> @@ -338,7 +344,6 @@ static inline void arch_write_unlock(arch_rwlock_t *r=
w)
>  #define arch_read_lock_flags(lock, flags) arch_read_lock(lock)
>  #define arch_write_lock_flags(lock, flags) arch_write_lock(lock)
> =20
> -#define arch_spin_relax(lock)	__spin_yield(lock)
>  #define arch_read_relax(lock)	__rw_yield(lock)
>  #define arch_write_relax(lock)	__rw_yield(lock)
> =20
> diff --git a/arch/powerpc/include/asm/spinlock_types.h b/arch/powerpc/inc=
lude/asm/spinlock_types.h
> index 2351adc..bd7144e 100644
> --- a/arch/powerpc/include/asm/spinlock_types.h
> +++ b/arch/powerpc/include/asm/spinlock_types.h
> @@ -5,11 +5,15 @@
>  # error "please don't include this file directly"
>  #endif
> =20
> +#ifdef CONFIG_QUEUED_SPINLOCKS
> +#include <asm-generic/qspinlock_types.h>
> +#else
>  typedef struct {
>  	volatile unsigned int slock;
>  } arch_spinlock_t;
> =20
>  #define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
> +#endif
> =20
>  typedef struct {
>  	volatile signed int lock;
> diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
> index b7b1237..6574626 100644
> --- a/arch/powerpc/lib/locks.c
> +++ b/arch/powerpc/lib/locks.c
> @@ -23,6 +23,7 @@
>  #include <asm/hvcall.h>
>  #include <asm/smp.h>
> =20
> +#ifndef CONFIG_QUEUED_SPINLOCKS
>  void __spin_yield(arch_spinlock_t *lock)
>  {
>  	unsigned int lock_value, holder_cpu, yield_count;
> @@ -42,6 +43,7 @@ void __spin_yield(arch_spinlock_t *lock)
>  		get_hard_smp_processor_id(holder_cpu), yield_count);
>  }
>  EXPORT_SYMBOL_GPL(__spin_yield);
> +#endif
> =20
>  /*
>   * Waiting for a read lock or a write lock on a rwlock...
> @@ -68,3 +70,60 @@ void __rw_yield(arch_rwlock_t *rw)
>  		get_hard_smp_processor_id(holder_cpu), yield_count);
>  }
>  #endif
> +
> +#ifdef CONFIG_QUEUED_SPINLOCKS
> +/*
> + * This forbid we load an old value in another LL/SC. Because the SC her=
e force
> + * another LL/SC repeat. So we guarantee all loads in another LL and SC =
will
> + * read correct value.
> + */
> +static inline u32 atomic_read_sync(atomic_t *v)
> +{
> +	u32 val;
> +
> +	__asm__ __volatile__(
> +"1:	" PPC_LWARX(%0, 0, %2, 0) "\n"
> +"	stwcx. %0, 0, %2\n"
> +"	bne- 1b\n"
> +	: "=3D&r" (val), "+m" (*v)
> +	: "r" (v)
> +	: "cr0", "xer");
> +
> +	return val;
> +}
> +
> +void queued_spin_unlock_wait(struct qspinlock *lock)
> +{
> +
> +	u32 val;
> +
> +	smp_mb();
> +
> +	/*
> +	 * copied from generic queue_spin_unlock_wait with little modification
> +	 */
> +	for (;;) {
> +		/* need _sync, as we might race with another LL/SC in lock()*/
> +		val =3D atomic_read_sync(&lock->val);
> +
> +		if (!val) /* not locked, we're done */
> +			goto done;
> +
> +		if (val & _Q_LOCKED_MASK) /* locked, go wait for unlock */
> +			break;
> +
> +		/* not locked, but pending, wait until we observe the lock */
> +		cpu_relax();
> +	}
> +
> +	/*
> +	 * any unlock is good. And need not _sync, as ->val is set by the SC in
> +	 * unlock(), any loads in lock() must see the correct value.
> +	 */

I don't think the comment here about _sync is correct. First, not all
unlock() has a SC part, and for unlock_wait() case there is nothing to
do with whether lock() see the correct value or not. The reason with
_sync is not needed here is:

/*
 * _sync() is not needed here, because once we got here, we must already
 * read the ->val as LOCKED via a _sync(). Combining the smp_mb()
 * before, we guarantee that all the memory accesses before
 * unlock_wait() must be observed by the next lock critical section.
 */

Regards,
Boqun

> +	while (atomic_read(&lock->val) & _Q_LOCKED_MASK)
> +		cpu_relax();
> +done:
> +	smp_mb();
> +}
> +EXPORT_SYMBOL(queued_spin_unlock_wait);
> +#endif
> --=20
> 2.4.11
>=20

--KdquIMZPjGJQvRdI
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEcBAABCAAGBQJYRgqtAAoJEEl56MO1B/q4zsIH/2DFp++QFlWdX+oiE03bWKB+
kHFGooQKf+BPDcfesroSG1u8qvxv2aFr/xhY4P5BdqOZ4UKo7pAFAhqIfBH5VsCD
SFeSeq/WkRpa+7GFIzh2SIMGVbgV+TtfZHPwm7E0EFIW1vMC6HQB51ToHBltLWYj
6UlJ1Ei2SAs2bwgVkUfDoKH36eQGUspsQ4d/Gx6YqU5oGwiQLLmjnMvcHGdlYZi8
JWSHB+HZ1JAWIDo+dO7LG/tl9pl8PSHN4U9e9f1F0CM4THg8KBsBODoZGu5FuLDN
IPU+MscmgZesY7rITp0fdM362ZVMsZEo+wBymx3Hm8cIJ5ViTdrqpYOwdHPI42U=
=QjSx
-----END PGP SIGNATURE-----

--KdquIMZPjGJQvRdI--
