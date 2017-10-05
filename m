Return-Path: <compudj@efficios.com>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7HMZ0jzYzDr5L
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Oct 2017 02:52:08 +1100 (AEDT)
Date: Thu, 5 Oct 2017 15:53:36 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Ingo Molnar <mingo@kernel.org>, Lai Jiangshan <jiangshanlai@gmail.com>,
 dipankar <dipankar@in.ibm.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Josh Triplett <josh@joshtriplett.org>,
 Thomas Gleixner <tglx@linutronix.de>,
 Peter Zijlstra <peterz@infradead.org>, rostedt <rostedt@goodmis.org>,
 David Howells <dhowells@redhat.com>,
 Eric Dumazet <edumazet@google.com>, fweisbec <fweisbec@gmail.com>,
 Oleg Nesterov <oleg@redhat.com>, Boqun Feng <boqun.feng@gmail.com>,
 Andrew Hunter <ahh@google.com>,
 maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>,
 Avi Kivity <avi@scylladb.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>,
 Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arch <linux-arch@vger.kernel.org>
Message-ID: <1411969338.31702.1507218816138.JavaMail.zimbra@efficios.com>
In-Reply-To: <20171005142325.5a407f18@roar.ozlabs.ibm.com>
References: <20171004213734.GA11463@linux.vnet.ibm.com>
 <1507153075-12345-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171005142325.5a407f18@roar.ozlabs.ibm.com>
Subject: Re: [PATCH tip/core/rcu 1/3] membarrier: Provide register expedited
 private command
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

----- On Oct 5, 2017, at 12:23 AM, Nicholas Piggin npiggin@gmail.com wrote:

> On Wed,  4 Oct 2017 14:37:53 -0700
> "Paul E. McKenney" <paulmck@linux.vnet.ibm.com> wrote:
> 
>> From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
>> 
>> Provide a new command allowing processes to register their intent to use
>> the private expedited command.
>> 
>> This allows PowerPC to skip the full memory barrier in switch_mm(), and
>> only issue the barrier when scheduling into a task belonging to a
>> process that has registered to use expedited private.
>> 
>> Processes are now required to register before using
>> MEMBARRIER_CMD_PRIVATE_EXPEDITED, otherwise that command returns EPERM.
>> 
>> Changes since v1:
>> - Use test_ti_thread_flag(next, ...) instead of test_thread_flag() in
>>   powerpc membarrier_arch_sched_in(), given that we want to specifically
>>   check the next thread state.
>> - Add missing ARCH_HAS_MEMBARRIER_HOOKS in Kconfig.
>> - Use task_thread_info() to pass thread_info from task to
>>   *_ti_thread_flag().
>> 
>> Changes since v2:
>> - Move membarrier_arch_sched_in() call to finish_task_switch().
>> - Check for NULL t->mm in membarrier_arch_fork().
>> - Use membarrier_sched_in() in generic code, which invokes the
>>   arch-specific membarrier_arch_sched_in(). This fixes allnoconfig
>>   build on PowerPC.
>> - Move asm/membarrier.h include under CONFIG_MEMBARRIER, fixing
>>   allnoconfig build on PowerPC.
>> - Build and runtime tested on PowerPC.
>> 
>> Changes since v3:
>> - Simply rely on copy_mm() to copy the membarrier_private_expedited mm
>>   field on fork.
>> - powerpc: test thread flag instead of reading
>>   membarrier_private_expedited in membarrier_arch_fork().
>> - powerpc: skip memory barrier in membarrier_arch_sched_in() if coming
>>   from kernel thread, since mmdrop() implies a full barrier.
>> - Set membarrier_private_expedited to 1 only after arch registration
>>   code, thus eliminating a race where concurrent commands could succeed
>>   when they should fail if issued concurrently with process
>>   registration.
>> - Use READ_ONCE() for membarrier_private_expedited field access in
>>   membarrier_private_expedited. Matches WRITE_ONCE() performed in
>>   process registration.
>> 
>> Changes since v4:
>> - Move powerpc hook from sched_in() to switch_mm(), based on feedback
>>   from Nicholas Piggin.
> 
> For now, the powerpc approach is okay by me. I plan to test
> others (e.g., taking runqueue locks) on larger systems, but that can
> be sent as an incremental patch at a later time.
> 
> The main thing I would like is for people to review the userspace API.
> 
> 
>> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
>> index 3a19c253bdb1..4af1b719c65f 100644
>> --- a/include/linux/sched/mm.h
>> +++ b/include/linux/sched/mm.h
>> @@ -205,4 +205,54 @@ static inline void memalloc_noreclaim_restore(unsigned int
>> flags)
>>  	current->flags = (current->flags & ~PF_MEMALLOC) | flags;
>>  }
>>  
>> +#ifdef CONFIG_MEMBARRIER
>> +
>> +#ifdef CONFIG_ARCH_HAS_MEMBARRIER_HOOKS
>> +#include <asm/membarrier.h>
>> +#else
>> +static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
>> +		struct mm_struct *next, struct task_struct *tsk)
>> +{
>> +}
> 
> This is no longer required in architecture independent code, is it?

Yes, good point! I'll remove this unused code in a follow up patch.

Thanks,

Mathieu

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
