Return-Path: <compudj@efficios.com>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2wYK2P8qzDsPp
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 23:30:28 +1000 (AEST)
Date: Thu, 28 Sep 2017 13:31:36 +0000 (UTC)
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
Message-ID: <911707916.20840.1506605496314.JavaMail.zimbra@efficios.com>
In-Reply-To: <20170927230436.4af88a62@roar.ozlabs.ibm.com>
References: <20170926175151.14264-1-mathieu.desnoyers@efficios.com>
 <33948425.19289.1506458608221.JavaMail.zimbra@efficios.com>
 <20170927230436.4af88a62@roar.ozlabs.ibm.com>
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

----- On Sep 27, 2017, at 9:04 AM, Nicholas Piggin npiggin@gmail.com wrote:

> On Tue, 26 Sep 2017 20:43:28 +0000 (UTC)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> ----- On Sep 26, 2017, at 1:51 PM, Mathieu Desnoyers
>> mathieu.desnoyers@efficios.com wrote:
>> 
>> > Provide a new command allowing processes to register their intent to use
>> > the private expedited command.
>> >   
>> 
>> I missed a few maintainers that should have been CC'd. Adding them now.
>> This patch is aimed to go through Paul E. McKenney's tree.
> 
> Honestly this is pretty ugly new user API and fairly large amount of
> complexity just to avoid the powerpc barrier. And you end up with arch
> specific hooks anyway!
> 
> So my plan was to add an arch-overridable loop primitive that iterates
> over all running threads for an mm.

Iterating over all threads for an mm is one possible solution that has
been listed at the membarrier BOF at LPC. We ended up dismissing this
solution because it would not inefficient for processes which have
lots of threads (e.g. Java).

> powerpc will use its mm_cpumask for
> iterating and use runqueue locks to avoid the barrier.

This is another solution which has been rejected during the LPC BOF.

What I gather from past threads is that the mm_cpumask's bits on powerpc
are pretty much only being set, never much cleared. Therefore, over the
lifetime of a thread which is not affined to specific processors, chances
are that this cpumask will end up having all cores on the system. Therefore,
you end up with the same rq lock disruption as if you would iterate on all
online CPUs. If userspace does that in a loop, you end up, in PeterZ's words,
with an Insta-DoS. The name may sound cool, but I gather that this is not
a service the kernel willingly wants to provide to userspace.

A cunning process could easily find a way to fill its mm_cpumask and then
issue membarrier in a loop to bring a large system to its knees.

> x86 will most
> likely want to use its mm_cpumask to iterate.

Iterating on mm_cpumask rather than online cpus adds complexity wrt memory
barriers (unless we go for rq locks approach). We'd need, in addition to
ensure that we have the proper barriers before/after store to rq->curr,
to also ensure that we have the proper barriers between mm_cpumask
updates and user-space loads/stores. Considering that we're not aiming
at taking the rq locks anyway, iteration over all online cpus seems
less complex than iterating on mm_cpumask on the architectures that
keep track of it.

> 
> For the powerpc approach, yes there is some controversy about using
> runqueue locks even for cpus that we already can interfere with, but I
> think we have a lot of options we could look at *after* it ever shows
> up as a problem.

The DoS argument from Peter seems to be a strong opposition to grabbing
the rq locks.

Here is another point in favor of having a register command for the
private membarrier: This gives us greater flexibility to improve the
kernel scheduler and return-to-userspace barriers if need be in the
future.

For instance, I plan to propose a "MEMBARRIER_FLAG_SYNC_CORE" flag
that will also provide guarantees about context synchronization of
all cores for memory reclaim performed by JIT for the next merge
window. So far, the following architectures seems to have the proper
core serializing instructions already in place when returning to
user-space: x86 (iret), powerpc (rfi), arm32/64 (return from exception,
eret), s390/x (lpswe), ia64 (rfi), parisc (issue at least 7 instructions
while signing around a bonfire), and mips SMP (eret).

So far, AFAIU, only x86 (eventually going through sysexit), alpha
(appears to require an explicit imb), and sparc (explicit flush + 5
instructions around similar bonfire as parisc) appear to require special
handling.

I therefore plan to use the registration step with a
MEMBARRIER_FLAG_SYNC_CORE flag set to set TIF flags and add the
required context synchronizing barriers on sched_in() only for
processes wishing to use private expedited membarrier.

So I don't see much point in trying to remove that registration step.

Thanks,

Mathieu


> 
> Thanks,
> Nick

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
