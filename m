Return-Path: <roger.larsson@norran.net>
Received: from mail.skekraft.net (ns.skekraft.net [213.199.96.131])
	by ozlabs.org (Postfix) with ESMTP id 88A2A67CB2
	for <linuxppc-embedded@ozlabs.org>;
	Thu,  7 Dec 2006 09:14:41 +1100 (EST)
Received: from icd.localnet (78.net216.skekraft.net [84.244.216.78])
	by mail.skekraft.net (Postfix) with ESMTP id 7BD3BA40AB
	for <linuxppc-embedded@ozlabs.org>;
	Wed,  6 Dec 2006 22:57:46 +0100 (CET)
From: Roger Larsson <roger.larsson@norran.net>
To: linuxppc-embedded@ozlabs.org
Subject: Re: shared config registers and locking
Date: Wed, 6 Dec 2006 22:57:44 +0100
References: <1165381847.5469.70.camel@localhost.localdomain>
In-Reply-To: <1165381847.5469.70.camel@localhost.localdomain>
MIME-Version: 1.0
Content-Type: text/plain;
  charset="iso-8859-1"
Message-Id: <200612062257.45153.roger.larsson@norran.net>
List-Id: Linux on Embedded PowerPC Developers Mail List
	<linuxppc-embedded.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-embedded>
List-Post: <mailto:linuxppc-embedded@ozlabs.org>
List-Help: <mailto:linuxppc-embedded-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-embedded>,
	<mailto:linuxppc-embedded-request@ozlabs.org?subject=subscribe>

On Wednesday 06 December 2006 06:10, Benjamin Herrenschmidt wrote:
>
> On UP configuration, there is no real problem: local_irq_disable/enable
> around the code tweaking those bits (read/modify/write) is enough and
> everybody is happy. That's what the current emac code does.
>
> However, on SMP, we need spinlocking (or a semaphore, but for simple
> register accesses like that, spinlocks are probably better).
>
It is actually simple.

You should use
spin_lock_irq_save()

include/linux/spinlock.h
#if defined(CONFIG_SMP) || defined(CONFIG_DEBUG_SPINLOCK)
#define spin_lock_irqsave(lock, flags)  flags = _spin_lock_irqsave(lock)
- - -
#else
#define spin_lock_irqsave(lock, flags)  _spin_lock_irqsave(lock, flags)
- - -
#endif

spinlock_api_smp.h:
	unsigned long __lockfunc _spin_lock_irqsave(spinlock_t *lock)
spinlock_api_up.h:
	/*
	 * In the UP-nondebug case there's no real locking going on, so the
	 * only thing we have to do is to keep the preempt counts and irq
	 * flags straight, to supress compiler warnings of unused lock
	 * variables, and to add the proper checker annotations:
	 */

	#define _spin_lock_irqsave(lock, flags) __LOCK_IRQSAVE(lock, flags)
	#define __LOCK_IRQSAVE(lock, flags) \
		do { local_irq_save(flags); __LOCK(lock); } while (0)
	#define __LOCK(lock) \
		do { preempt_disable(); __acquire(lock); (void)(lock); } while (0)
		-> disable preemption if compiled with preemption
		-> static checker annotation
		-> make compiler happy, use variable lock

So by using spin_lock_irqsave always you won't get anything more than 
local_irq_save when compiling on an UP box with kernel preemption disabled.

You could of cause use spin_lock_irq(lock) if you do not have nested locks -
it is not the lock that is the problem but the unlock.

#define local_irq_disable()     __asm__ __volatile__("cli": : :"memory")
#define local_irq_enable()      __asm__ __volatile__("sti": : :"memory")

local_irq_disable()
call
	local_irq_disable()
	local_irq_enable()
do_something(); // Is IRQ enabled or disabled here? Was that intended?
local_irq_enable()


Documentation to read:
	linux2.6/Documentation/spinlocks.txt
	linux2.6/Documentation/io_ordering.txt
	linux2.6/Documentation/preempt-locking.txt

/RogerL
