Return-Path: <compudj@efficios.com>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y83JZ6Z9mzDqhf
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  7 Oct 2017 08:52:14 +1100 (AEDT)
Date: Fri, 6 Oct 2017 21:53:33 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>,
 maged michael <maged.michael@gmail.com>, gromer <gromer@google.com>,
 Avi Kivity <avi@scylladb.com>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>,
 Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 linux-arch <linux-arch@vger.kernel.org>
Message-ID: <285657409.33327.1507326813468.JavaMail.zimbra@efficios.com>
In-Reply-To: <20171006210801.GL3521@linux.vnet.ibm.com>
References: <20171005223327.3500-1-mathieu.desnoyers@efficios.com>
 <20171006210801.GL3521@linux.vnet.ibm.com>
Subject: Re: [RFC PATCH for 4.14 1/2] membarrier: Remove unused code for
 architectures without membarrier hooks
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


----- On Oct 6, 2017, at 5:08 PM, Paul E. McKenney paulmck@linux.vnet.ibm.com wrote:

> On Thu, Oct 05, 2017 at 06:33:26PM -0400, Mathieu Desnoyers wrote:
>> Architectures without membarrier hooks don't need to emit the
>> empty membarrier_arch_switch_mm() static inline when
>> CONFIG_MEMBARRIER=y.
>> 
>> Adapt the CONFIG_MEMBARRIER=n counterpart to only emit the empty
>> membarrier_arch_switch_mm() for architectures with membarrier hooks.
>> 
>> Reported-by: Nicholas Piggin <npiggin@gmail.com>
>> Signed-off-by: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
> 
> Queued for further review and testing, targeting v4.15.  Please let me
> know if you need it sooner.

Hi Paul,

Given that the following patch in this patchset (2/2)
"Fix: membarrier: Handle CLONE_VM + !CLONE_THREAD correctly on powerpc"
is based on this patch, and that the fix needs to go into 4.14,
I would recommend queuing both patches for 4.14 is possible.

Otherwise I could try swapping the order of the two patches if
needed, but since both are touching nearby code areas, rebasing
is not straightforward.

Thanks,

Mathieu

> 
>							Thanx, Paul
> 
>> CC: Peter Zijlstra <peterz@infradead.org>
>> CC: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
>> CC: Boqun Feng <boqun.feng@gmail.com>
>> CC: Andrew Hunter <ahh@google.com>
>> CC: Maged Michael <maged.michael@gmail.com>
>> CC: gromer@google.com
>> CC: Avi Kivity <avi@scylladb.com>
>> CC: Benjamin Herrenschmidt <benh@kernel.crashing.org>
>> CC: Paul Mackerras <paulus@samba.org>
>> CC: Michael Ellerman <mpe@ellerman.id.au>
>> CC: Dave Watson <davejwatson@fb.com>
>> CC: Alan Stern <stern@rowland.harvard.edu>
>> CC: Will Deacon <will.deacon@arm.com>
>> CC: Andy Lutomirski <luto@kernel.org>
>> CC: Ingo Molnar <mingo@redhat.com>
>> CC: Alexander Viro <viro@zeniv.linux.org.uk>
>> CC: linuxppc-dev@lists.ozlabs.org
>> CC: linux-arch@vger.kernel.org
>> ---
>>  include/linux/sched/mm.h | 6 ++----
>>  1 file changed, 2 insertions(+), 4 deletions(-)
>> 
>> diff --git a/include/linux/sched/mm.h b/include/linux/sched/mm.h
>> index d5a9ab8f3836..b2767ecb21a8 100644
>> --- a/include/linux/sched/mm.h
>> +++ b/include/linux/sched/mm.h
>> @@ -215,10 +215,6 @@ static inline void memalloc_noreclaim_restore(unsigned int
>> flags)
>>  #ifdef CONFIG_ARCH_HAS_MEMBARRIER_HOOKS
>>  #include <asm/membarrier.h>
>>  #else
>> -static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
>> -		struct mm_struct *next, struct task_struct *tsk)
>> -{
>> -}
>>  static inline void membarrier_arch_fork(struct task_struct *t,
>>  		unsigned long clone_flags)
>>  {
>> @@ -247,10 +243,12 @@ static inline void membarrier_execve(struct task_struct
>> *t)
>>  	membarrier_arch_execve(t);
>>  }
>>  #else
>> +#ifdef CONFIG_ARCH_HAS_MEMBARRIER_HOOKS
>>  static inline void membarrier_arch_switch_mm(struct mm_struct *prev,
>>  		struct mm_struct *next, struct task_struct *tsk)
>>  {
>>  }
>> +#endif
>>  static inline void membarrier_fork(struct task_struct *t,
>>  		unsigned long clone_flags)
>>  {
>> --
>> 2.11.0

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
