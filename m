Return-Path: <sshtylyov@ru.mvista.com>
Received: from imap.sh.mvista.com (unknown [63.81.120.155])
	by ozlabs.org (Postfix) with ESMTP id 1EF17DDF66
	for <linuxppc-dev@ozlabs.org>; Wed,  7 Feb 2007 23:39:22 +1100 (EST)
Message-ID: <45C9C870.5000904@ru.mvista.com>
Date: Wed, 07 Feb 2007 15:39:12 +0300
From: Sergei Shtylyov <sshtylyov@ru.mvista.com>
MIME-Version: 1.0
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Subject: Re: [PATCH] (2.6.20-rt3) PowerPC: convert spinlocks into raw
References: <200702062026.40875.sshtylyov@ru.mvista.com>
	<1170793464.2620.251.camel@localhost.localdomain>
In-Reply-To: <1170793464.2620.251.camel@localhost.localdomain>
Content-Type: text/plain; charset=us-ascii; format=flowed
Cc: linuxppc-dev@ozlabs.org, mingo@elte.hu, linux-kernel@vger.kernel.org,
	dwalker@mvista.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>

Hello.

Benjamin Herrenschmidt wrote:

>>Convert the spinlocks in the PowerPC interrupt related code into the raw ones,
>>also convert the PURR and PMC related spinlocks...

> Care to explain the difference ?

    In the realtime preemption mode, spinlocks are implemented via mutexes, 
and the kernel may be preempted if the lock it's trying to acquire is already 
taken by another process which shouldn't happen in the interrupt (or otherwise 
non-preempatble) context. In such context, the "raw" spinlocks must still be 
used which are (almost?) the same as the "usual" Linux spinlocks.
    IIUC, the notion of the interrupt context" in the realtim (and also in the 
low-latency desktop with hardirq preemption) mode is somewhat different form 
the usual as the interrupt handlers are executed in their own threads, and so, 
out of the interrupt context (that's not an absolute law: the timer interrupts 
are still handled the usual way, for example)...
    I hope Ingo will correct me where I may be wrong. :-)

 > This is related to the -rt stuff ?

    Yes, it's CONFIG_PREEMPT_RT specific. That's whey I specified 2.6.20-rt3 
in the subject.

> Cheers,
> Ben.

    In my turn, I'd like to have your (or anybody's) comments since I have 
doubts about the nee of some conversions below which Mark have originally done 
(though I limited myself to only adding couple more that seemed really necessary)

>>Signed-off-by: Mark A. Greer <mgreer@mvista.com>
>>Signed-off-by: Sergei Shtylyov <sshtylyov@ru.mvista.com>

>>Index: linux-2.6/arch/powerpc/kernel/irq.c
>>===================================================================
>>--- linux-2.6.orig/arch/powerpc/kernel/irq.c
>>+++ linux-2.6/arch/powerpc/kernel/irq.c
>>@@ -392,7 +392,7 @@ EXPORT_SYMBOL(do_softirq);
>> #ifdef CONFIG_PPC_MERGE
>> 
>> static LIST_HEAD(irq_hosts);
>>-static spinlock_t irq_big_lock = SPIN_LOCK_UNLOCKED;
>>+static DEFINE_RAW_SPINLOCK(irq_big_lock);
>> static DEFINE_PER_CPU(unsigned int, irq_radix_reader);
>> static unsigned int irq_radix_writer;
>> struct irq_map_entry irq_map[NR_IRQS];

    Erm, not very sure about irq_big_lock -- seems to only be used by IRQ 
mapping code...

>>Index: linux-2.6/arch/powerpc/kernel/pmc.c
>>===================================================================
>>--- linux-2.6.orig/arch/powerpc/kernel/pmc.c
>>+++ linux-2.6/arch/powerpc/kernel/pmc.c
>>@@ -52,7 +52,7 @@ static void dummy_perf(struct pt_regs *r
>> }
>> #endif
>> 
>>-static DEFINE_SPINLOCK(pmc_owner_lock);
>>+static DEFINE_RAW_SPINLOCK(pmc_owner_lock);
>> static void *pmc_owner_caller; /* mostly for debugging */
>> perf_irq_t perf_irq = dummy_perf;

    Not sure about this one -- it seemed to guard reserving/releasing the PMC 
hardware (by Oprofile) and only be taken out of the interrupt context...

>>Index: linux-2.6/arch/powerpc/kernel/time.c
>>===================================================================
>>--- linux-2.6.orig/arch/powerpc/kernel/time.c
>>+++ linux-2.6/arch/powerpc/kernel/time.c
>>@@ -223,7 +223,7 @@ struct cpu_purr_data {
>> 	int	initialized;			/* thread is running */
>> 	u64	tb;			/* last TB value read */
>> 	u64	purr;			/* last PURR value read */
>>-	spinlock_t lock;
>>+	raw_spinlock_t lock;
>> };
>> 
>> static DEFINE_PER_CPU(struct cpu_purr_data, cpu_purr_data);

    The PURR spinlock obviously needed to be raw being used by the timer 
interrupt.

[...]
>>Index: linux-2.6/arch/powerpc/sysdev/mpic.c
>>===================================================================
>>--- linux-2.6.orig/arch/powerpc/sysdev/mpic.c
>>+++ linux-2.6/arch/powerpc/sysdev/mpic.c
>>@@ -44,7 +44,7 @@
>> 
>> static struct mpic *mpics;
>> static struct mpic *mpic_primary;
>>-static DEFINE_SPINLOCK(mpic_lock);
>>+static DEFINE_RAW_SPINLOCK(mpic_lock);
>> 
>> #ifdef CONFIG_PPC32	/* XXX for now */
>> #ifdef CONFIG_IRQ_ALL_CPUS

    Not sure about this one -- it seemed to only be taken out of the interrupt 
context...

>>Index: linux-2.6/include/asm-powerpc/mpic.h
>>===================================================================
>>--- linux-2.6.orig/include/asm-powerpc/mpic.h
>>+++ linux-2.6/include/asm-powerpc/mpic.h
>>@@ -279,7 +279,7 @@ struct mpic
>> #ifdef CONFIG_MPIC_BROKEN_U3
>> 	/* The fixup table */
>> 	struct mpic_irq_fixup	*fixups;
>>-	spinlock_t		fixup_lock;
>>+	raw_spinlock_t		fixup_lock;
>> #endif
>> 
>> 	/* Register access method */

    This one is also taken by the OpenPIC code in the interrupt context.

WBR, Sergei
