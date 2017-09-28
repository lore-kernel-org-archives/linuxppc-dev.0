Return-Path: <compudj@efficios.com>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2z9k3c3SzDsPr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 01:28:42 +1000 (AEST)
Date: Thu, 28 Sep 2017 15:29:50 +0000 (UTC)
From: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>,
 Alexander Viro <viro@zeniv.linux.org.uk>,
 linux-arch <linux-arch@vger.kernel.org>, Avi Kivity <avi@scylladb.com>,
 maged michael <maged.michael@gmail.com>,
 Boqun Feng <boqun.feng@gmail.com>, Dave Watson <davejwatson@fb.com>,
 Will Deacon <will.deacon@arm.com>,
 linux-kernel <linux-kernel@vger.kernel.org>,
 Andrew Hunter <ahh@google.com>, Paul Mackerras <paulus@samba.org>,
 Andy Lutomirski <luto@kernel.org>,
 Alan Stern <stern@rowland.harvard.edu>,
 linuxppc-dev <linuxppc-dev@lists.ozlabs.org>, gromer <gromer@google.com>
Message-ID: <634837506.21241.1506612590749.JavaMail.zimbra@efficios.com>
In-Reply-To: <20170929010112.3a54be0d@roar.ozlabs.ibm.com>
References: <20170926175151.14264-1-mathieu.desnoyers@efficios.com>
 <33948425.19289.1506458608221.JavaMail.zimbra@efficios.com>
 <20170927230436.4af88a62@roar.ozlabs.ibm.com>
 <911707916.20840.1506605496314.JavaMail.zimbra@efficios.com>
 <20170929010112.3a54be0d@roar.ozlabs.ibm.com>
Subject: Re: [PATCH v4 for 4.14 1/3] membarrier: Provide register expedited
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

----- On Sep 28, 2017, at 11:01 AM, Nicholas Piggin npiggin@gmail.com wrote:

> On Thu, 28 Sep 2017 13:31:36 +0000 (UTC)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> ----- On Sep 27, 2017, at 9:04 AM, Nicholas Piggin npiggin@gmail.com wrote:
>> 
>> > On Tue, 26 Sep 2017 20:43:28 +0000 (UTC)
>> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> >   
>> >> ----- On Sep 26, 2017, at 1:51 PM, Mathieu Desnoyers
>> >> mathieu.desnoyers@efficios.com wrote:
>> >>
   
[...]

>> Therefore,
>> you end up with the same rq lock disruption as if you would iterate on all
>> online CPUs. If userspace does that in a loop, you end up, in PeterZ's words,
>> with an Insta-DoS.
> 
> I really don't see how that can be true. spinlock by definition is for
> sharing of resources, it's not an insta-DoS just because you take shared
> spinlocks!

[...]

>> 
>> > 
>> > For the powerpc approach, yes there is some controversy about using
>> > runqueue locks even for cpus that we already can interfere with, but I
>> > think we have a lot of options we could look at *after* it ever shows
>> > up as a problem.
>> 
>> The DoS argument from Peter seems to be a strong opposition to grabbing
>> the rq locks.
> 
> Well if I still can't unconvince you, then we should try testing that
> theory.

[ I'll let PeterZ pitch in on this part of the discussion ]

> 
>> 
>> Here is another point in favor of having a register command for the
>> private membarrier: This gives us greater flexibility to improve the
>> kernel scheduler and return-to-userspace barriers if need be in the
>> future.
>> 
>> For instance, I plan to propose a "MEMBARRIER_FLAG_SYNC_CORE" flag
>> that will also provide guarantees about context synchronization of
>> all cores for memory reclaim performed by JIT for the next merge
>> window. So far, the following architectures seems to have the proper
>> core serializing instructions already in place when returning to
>> user-space: x86 (iret), powerpc (rfi), arm32/64 (return from exception,
>> eret), s390/x (lpswe), ia64 (rfi), parisc (issue at least 7 instructions
>> while signing around a bonfire), and mips SMP (eret).
>> 
>> So far, AFAIU, only x86 (eventually going through sysexit), alpha
>> (appears to require an explicit imb), and sparc (explicit flush + 5
>> instructions around similar bonfire as parisc) appear to require special
>> handling.
>> 
>> I therefore plan to use the registration step with a
>> MEMBARRIER_FLAG_SYNC_CORE flag set to set TIF flags and add the
>> required context synchronizing barriers on sched_in() only for
>> processes wishing to use private expedited membarrier.
>> 
>> So I don't see much point in trying to remove that registration step.
> 
> I don't follow you. You are talking about the concept of registering
> intention to use a different function? And the registration API is not
> merged yet?

Yes, I'm talking about requiring processes to invoke membarrier cmd
MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED before they can successfully
invoke membarrier cmd MEMBARRIER_CMD_PRIVATE_EXPEDITED.

> Let me say I'm not completely against the idea of a registration API. But
> don't think registration for this expedited command is necessary.

Given that we have the powerpc lack-of-full-barrier-on-return-to-userspace
case now, and we foresee x86-sysexit, sparc, and alpha also requiring
special treatment when we introduce the MEMBARRIER_FLAG_SYNC_CORE behavior
in the next release, it seems that we'll have a hard time handling
architecture special cases efficiently if we don't expose the registration
API right away.

> 
> But (aside) let's say a tif flag turns out to be a good diea for your
> second case, why not just check the flag in the membarrier sys call and
> do the registration the first time it uses it?

We also considered that option. It's mainly about guaranteeing that
an expedited membarrier command never blocks. If we introduce this
"lazy auto-registration" behavior, we end up blocking the process
at a random point in its execution so we can issue a synchronize_sched().
By exposing an explicit registration, we can control where this delay
occurs, and even allow library constructors to invoke the registration
while the process is a single threaded, therefore allowing us to completely
skip synchronize_sched().

Thanks,

Mathieu

> 
> Thanks,
> Nick

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
