Return-Path: <avi@scylladb.com>
Received: from mail-wm0-x233.google.com (mail-wm0-x233.google.com
 [IPv6:2a00:1450:400c:c09::233])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y7Bk26H1dzDqlM
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  5 Oct 2017 23:22:48 +1100 (AEDT)
Received: by mail-wm0-x233.google.com with SMTP id u138so1824082wmu.4
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 05 Oct 2017 05:22:48 -0700 (PDT)
Subject: Re: [PATCH tip/core/rcu 1/3] membarrier: Provide register expedited
 private command
To: Nicholas Piggin <npiggin@gmail.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: linux-kernel@vger.kernel.org, mingo@kernel.org, jiangshanlai@gmail.com,
 dipankar@in.ibm.com, akpm@linux-foundation.org,
 mathieu.desnoyers@efficios.com, josh@joshtriplett.org, tglx@linutronix.de,
 peterz@infradead.org, rostedt@goodmis.org, dhowells@redhat.com,
 edumazet@google.com, fweisbec@gmail.com, oleg@redhat.com,
 Boqun Feng <boqun.feng@gmail.com>, Andrew Hunter <ahh@google.com>,
 Maged Michael <maged.michael@gmail.com>, gromer@google.com,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Dave Watson <davejwatson@fb.com>, Alan Stern <stern@rowland.harvard.edu>,
 Will Deacon <will.deacon@arm.com>, Andy Lutomirski <luto@kernel.org>,
 Ingo Molnar <mingo@redhat.com>, Alexander Viro <viro@zeniv.linux.org.uk>,
 linuxppc-dev@lists.ozlabs.org, linux-arch@vger.kernel.org
References: <20171004213734.GA11463@linux.vnet.ibm.com>
 <1507153075-12345-1-git-send-email-paulmck@linux.vnet.ibm.com>
 <20171005142325.5a407f18@roar.ozlabs.ibm.com>
From: Avi Kivity <avi@scylladb.com>
Message-ID: <64c8984c-7140-ccce-513f-6b3f601257a7@scylladb.com>
Date: Thu, 5 Oct 2017 15:22:40 +0300
MIME-Version: 1.0
In-Reply-To: <20171005142325.5a407f18@roar.ozlabs.ibm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/05/2017 07:23 AM, Nicholas Piggin wrote:
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
>>    powerpc membarrier_arch_sched_in(), given that we want to specifically
>>    check the next thread state.
>> - Add missing ARCH_HAS_MEMBARRIER_HOOKS in Kconfig.
>> - Use task_thread_info() to pass thread_info from task to
>>    *_ti_thread_flag().
>>
>> Changes since v2:
>> - Move membarrier_arch_sched_in() call to finish_task_switch().
>> - Check for NULL t->mm in membarrier_arch_fork().
>> - Use membarrier_sched_in() in generic code, which invokes the
>>    arch-specific membarrier_arch_sched_in(). This fixes allnoconfig
>>    build on PowerPC.
>> - Move asm/membarrier.h include under CONFIG_MEMBARRIER, fixing
>>    allnoconfig build on PowerPC.
>> - Build and runtime tested on PowerPC.
>>
>> Changes since v3:
>> - Simply rely on copy_mm() to copy the membarrier_private_expedited mm
>>    field on fork.
>> - powerpc: test thread flag instead of reading
>>    membarrier_private_expedited in membarrier_arch_fork().
>> - powerpc: skip memory barrier in membarrier_arch_sched_in() if coming
>>    from kernel thread, since mmdrop() implies a full barrier.
>> - Set membarrier_private_expedited to 1 only after arch registration
>>    code, thus eliminating a race where concurrent commands could succeed
>>    when they should fail if issued concurrently with process
>>    registration.
>> - Use READ_ONCE() for membarrier_private_expedited field access in
>>    membarrier_private_expedited. Matches WRITE_ONCE() performed in
>>    process registration.
>>
>> Changes since v4:
>> - Move powerpc hook from sched_in() to switch_mm(), based on feedback
>>    from Nicholas Piggin.
> For now, the powerpc approach is okay by me. I plan to test
> others (e.g., taking runqueue locks) on larger systems, but that can
> be sent as an incremental patch at a later time.
>
> The main thing I would like is for people to review the userspace API.
>

As a future satisfied user of the expedited private membarrier syscall, 
I am happy with the change.
