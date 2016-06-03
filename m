Return-Path: <xinhui.pan@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rLVzc6P0TzDqj7
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 14:12:12 +1000 (AEST)
Received: from pps.filterd (m0082756.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u534BP1s032615
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jun 2016 00:12:10 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 23ag2n0r3q-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 03 Jun 2016 00:12:09 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <xinhui.pan@linux.vnet.ibm.com>;
 Fri, 3 Jun 2016 14:12:07 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 4D3D6357805C
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  3 Jun 2016 14:12:00 +1000 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u534BoAn8323582
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jun 2016 14:11:55 +1000
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u534Bc0X026754
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 3 Jun 2016 14:11:39 +1000
Date: Fri, 03 Jun 2016 12:10:59 +0800
From: xinhui <xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
To: benh@au1.ibm.com, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, virtualization@lists.linux-foundation.org
CC: paulus@samba.org, mpe@ellerman.id.au, peterz@infradead.org,
 mingo@redhat.com, paulmck@linux.vnet.ibm.com, waiman.long@hpe.com
Subject: Re: [PATCH v5 1/6] qspinlock: powerpc support qspinlock
References: <1464859370-5162-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1464859370-5162-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1464917520.26773.11.camel@kernel.crashing.org>
 <1464917548.26773.12.camel@au1.ibm.com>
In-Reply-To: <1464917548.26773.12.camel@au1.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Message-Id: <57510353.1020209@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>


On 2016年06月03日 09:32, Benjamin Herrenschmidt wrote:
> On Fri, 2016-06-03 at 11:32 +1000, Benjamin Herrenschmidt wrote:
>> On Thu, 2016-06-02 at 17:22 +0800, Pan Xinhui wrote:
>>>
>>> Base code to enable qspinlock on powerpc. this patch add some
>>> #ifdef
>>> here and there. Although there is no paravirt related code, we can
>>> successfully build a qspinlock kernel after apply this patch.
>> This is missing the IO_SYNC stuff ... It means we'll fail to do a
>> full
>> sync to order vs MMIOs.
>>
>> You need to add that back in the unlock path.
>
> Well, and in the lock path as well...
>
Oh, yes. I missed IO_SYNC stuff.

thank you, Ben :)

> Cheers,
> Ben.
>
>>>
>>> Signed-off-by: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
>>> ---
>>>   arch/powerpc/include/asm/qspinlock.h      | 26
>>> ++++++++++++++++++++++++++
>>>   arch/powerpc/include/asm/spinlock.h       | 27 +++++++++++++++----
>>> --------
>>>   arch/powerpc/include/asm/spinlock_types.h |  4 ++++
>>>   arch/powerpc/lib/locks.c                  |  4 ++++
>>>   4 files changed, 49 insertions(+), 12 deletions(-)
>>>   create mode 100644 arch/powerpc/include/asm/qspinlock.h
>>>
>>> diff --git a/arch/powerpc/include/asm/qspinlock.h
>>> b/arch/powerpc/include/asm/qspinlock.h
>>> new file mode 100644
>>> index 0000000..fc83cd2
>>> --- /dev/null
>>> +++ b/arch/powerpc/include/asm/qspinlock.h
>>> @@ -0,0 +1,26 @@
>>> +#ifndef _ASM_POWERPC_QSPINLOCK_H
>>> +#define _ASM_POWERPC_QSPINLOCK_H
>>> +
>>> +#include <asm-generic/qspinlock_types.h>
>>> +
>>> +#define SPIN_THRESHOLD (1 << 15)
>>> +#define queued_spin_unlock queued_spin_unlock
>>> +
>>> +static inline void native_queued_spin_unlock(struct qspinlock
>>> *lock)
>>> +{
>>> +	u8 *locked = (u8 *)lock;
>>> +#ifdef __BIG_ENDIAN
>>> +	locked += 3;
>>> +#endif
>>> +	/* no load/store can be across the unlock()*/
>>> +	smp_store_release(locked, 0);
>>> +}
>>> +
>>> +static inline void queued_spin_unlock(struct qspinlock *lock)
>>> +{
>>> +	native_queued_spin_unlock(lock);
>>> +}
>>> +
>>> +#include <asm-generic/qspinlock.h>
>>> +
>>> +#endif /* _ASM_POWERPC_QSPINLOCK_H */
>>> diff --git a/arch/powerpc/include/asm/spinlock.h
>>> b/arch/powerpc/include/asm/spinlock.h
>>> index 523673d..4359ee6 100644
>>> --- a/arch/powerpc/include/asm/spinlock.h
>>> +++ b/arch/powerpc/include/asm/spinlock.h
>>> @@ -52,6 +52,20 @@
>>>   #define SYNC_IO
>>>   #endif
>>>
>>> +#if defined(CONFIG_PPC_SPLPAR)
>>> +/* We only yield to the hypervisor if we are in shared processor
>>> mode */
>>> +#define SHARED_PROCESSOR (lppaca_shared_proc(local_paca-
>>>>
>>>> lppaca_ptr))
>>> +extern void __spin_yield(arch_spinlock_t *lock);
>>> +extern void __rw_yield(arch_rwlock_t *lock);
>>> +#else /* SPLPAR */
>>> +#define __spin_yield(x)	barrier()
>>> +#define __rw_yield(x)	barrier()
>>> +#define SHARED_PROCESSOR	0
>>> +#endif
>>> +
>>> +#ifdef CONFIG_QUEUED_SPINLOCKS
>>> +#include <asm/qspinlock.h>
>>> +#else
>>>   static __always_inline int
>>> arch_spin_value_unlocked(arch_spinlock_t
>>> lock)
>>>   {
>>>   	return lock.slock == 0;
>>> @@ -106,18 +120,6 @@ static inline int
>>> arch_spin_trylock(arch_spinlock_t *lock)
>>>    * held.  Conveniently, we have a word in the paca that holds this
>>>    * value.
>>>    */
>>> -
>>> -#if defined(CONFIG_PPC_SPLPAR)
>>> -/* We only yield to the hypervisor if we are in shared processor
>>> mode */
>>> -#define SHARED_PROCESSOR (lppaca_shared_proc(local_paca-
>>>>
>>>> lppaca_ptr))
>>> -extern void __spin_yield(arch_spinlock_t *lock);
>>> -extern void __rw_yield(arch_rwlock_t *lock);
>>> -#else /* SPLPAR */
>>> -#define __spin_yield(x)	barrier()
>>> -#define __rw_yield(x)	barrier()
>>> -#define SHARED_PROCESSOR	0
>>> -#endif
>>> -
>>>   static inline void arch_spin_lock(arch_spinlock_t *lock)
>>>   {
>>>   	CLEAR_IO_SYNC;
>>> @@ -169,6 +171,7 @@ extern void
>>> arch_spin_unlock_wait(arch_spinlock_t
>>> *lock);
>>>   	do { while (arch_spin_is_locked(lock)) cpu_relax(); }
>>> while
>>> (0)
>>>   #endif
>>>
>>> +#endif /* !CONFIG_QUEUED_SPINLOCKS */
>>>   /*
>>>    * Read-write spinlocks, allowing multiple readers
>>>    * but only one writer.
>>> diff --git a/arch/powerpc/include/asm/spinlock_types.h
>>> b/arch/powerpc/include/asm/spinlock_types.h
>>> index 2351adc..bd7144e 100644
>>> --- a/arch/powerpc/include/asm/spinlock_types.h
>>> +++ b/arch/powerpc/include/asm/spinlock_types.h
>>> @@ -5,11 +5,15 @@
>>>   # error "please don't include this file directly"
>>>   #endif
>>>
>>> +#ifdef CONFIG_QUEUED_SPINLOCKS
>>> +#include <asm-generic/qspinlock_types.h>
>>> +#else
>>>   typedef struct {
>>>   	volatile unsigned int slock;
>>>   } arch_spinlock_t;
>>>
>>>   #define __ARCH_SPIN_LOCK_UNLOCKED	{ 0 }
>>> +#endif
>>>
>>>   typedef struct {
>>>   	volatile signed int lock;
>>> diff --git a/arch/powerpc/lib/locks.c b/arch/powerpc/lib/locks.c
>>> index f7deebd..a9ebd71 100644
>>> --- a/arch/powerpc/lib/locks.c
>>> +++ b/arch/powerpc/lib/locks.c
>>> @@ -23,6 +23,7 @@
>>>   #include <asm/hvcall.h>
>>>   #include <asm/smp.h>
>>>
>>> +#ifndef CONFIG_QUEUED_SPINLOCKS
>>>   void __spin_yield(arch_spinlock_t *lock)
>>>   {
>>>   	unsigned int lock_value, holder_cpu, yield_count;
>>> @@ -42,6 +43,7 @@ void __spin_yield(arch_spinlock_t *lock)
>>>   		get_hard_smp_processor_id(holder_cpu),
>>> yield_count);
>>>   }
>>>   EXPORT_SYMBOL_GPL(__spin_yield);
>>> +#endif
>>>
>>>   /*
>>>    * Waiting for a read lock or a write lock on a rwlock...
>>> @@ -69,6 +71,7 @@ void __rw_yield(arch_rwlock_t *rw)
>>>   }
>>>   #endif
>>>
>>> +#ifndef CONFIG_QUEUED_SPINLOCKS
>>>   void arch_spin_unlock_wait(arch_spinlock_t *lock)
>>>   {
>>>   	smp_mb();
>>> @@ -84,3 +87,4 @@ void arch_spin_unlock_wait(arch_spinlock_t *lock)
>>>   }
>>>
>>>   EXPORT_SYMBOL(arch_spin_unlock_wait);
>>> +#endif
