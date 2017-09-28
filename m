Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x232.google.com (mail-pg0-x232.google.com
 [IPv6:2607:f8b0:400e:c05::232])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y2yZS3tZYzDsPr
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 01:01:36 +1000 (AEST)
Received: by mail-pg0-x232.google.com with SMTP id b11so1074867pgn.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Sep 2017 08:01:36 -0700 (PDT)
Date: Fri, 29 Sep 2017 01:01:12 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, Peter Zijlstra
 <peterz@infradead.org>, Ingo Molnar <mingo@redhat.com>, Alexander Viro
 <viro@zeniv.linux.org.uk>, linux-arch <linux-arch@vger.kernel.org>, Avi
 Kivity <avi@scylladb.com>, maged michael <maged.michael@gmail.com>, Boqun
 Feng <boqun.feng@gmail.com>, Dave Watson <davejwatson@fb.com>, Will Deacon
 <will.deacon@arm.com>, linux-kernel <linux-kernel@vger.kernel.org>, Andrew
 Hunter <ahh@google.com>, Paul Mackerras <paulus@samba.org>, Andy Lutomirski
 <luto@kernel.org>, Alan Stern <stern@rowland.harvard.edu>, linuxppc-dev
 <linuxppc-dev@lists.ozlabs.org>, gromer <gromer@google.com>
Subject: Re: [PATCH v4 for 4.14 1/3] membarrier: Provide register expedited
 private command
Message-ID: <20170929010112.3a54be0d@roar.ozlabs.ibm.com>
In-Reply-To: <911707916.20840.1506605496314.JavaMail.zimbra@efficios.com>
References: <20170926175151.14264-1-mathieu.desnoyers@efficios.com>
 <33948425.19289.1506458608221.JavaMail.zimbra@efficios.com>
 <20170927230436.4af88a62@roar.ozlabs.ibm.com>
 <911707916.20840.1506605496314.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 28 Sep 2017 13:31:36 +0000 (UTC)
Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:

> ----- On Sep 27, 2017, at 9:04 AM, Nicholas Piggin npiggin@gmail.com wrote:
> 
> > On Tue, 26 Sep 2017 20:43:28 +0000 (UTC)
> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> >   
> >> ----- On Sep 26, 2017, at 1:51 PM, Mathieu Desnoyers
> >> mathieu.desnoyers@efficios.com wrote:
> >>   
> >> > Provide a new command allowing processes to register their intent to use
> >> > the private expedited command.
> >> >     
> >> 
> >> I missed a few maintainers that should have been CC'd. Adding them now.
> >> This patch is aimed to go through Paul E. McKenney's tree.  
> > 
> > Honestly this is pretty ugly new user API and fairly large amount of
> > complexity just to avoid the powerpc barrier. And you end up with arch
> > specific hooks anyway!
> > 
> > So my plan was to add an arch-overridable loop primitive that iterates
> > over all running threads for an mm.  
> 
> Iterating over all threads for an mm is one possible solution that has
> been listed at the membarrier BOF at LPC. We ended up dismissing this
> solution because it would not inefficient for processes which have
> lots of threads (e.g. Java).

Sorry I meant hardware threads, I should have said "CPUs".

> 
> > powerpc will use its mm_cpumask for
> > iterating and use runqueue locks to avoid the barrier.  
> 
> This is another solution which has been rejected during the LPC BOF.
> 
> What I gather from past threads is that the mm_cpumask's bits on powerpc
> are pretty much only being set, never much cleared. Therefore, over the
> lifetime of a thread which is not affined to specific processors, chances
> are that this cpumask will end up having all cores on the system.

That's fine. If a user is not bound to a subset of CPUs, they could
also cause disturbances with other syscalls and faults, taking locks,
causing tlb flushes and IPIs and things.

> Therefore,
> you end up with the same rq lock disruption as if you would iterate on all
> online CPUs. If userspace does that in a loop, you end up, in PeterZ's words,
> with an Insta-DoS.

I really don't see how that can be true. spinlock by definition is for
sharing of resources, it's not an insta-DoS just because you take shared
spinlocks!

You can contend other common locks or resources too. Linux simply does not
have guaranteed strict isolation particularly when you allow threads to be
scheduled together on CPUs, so this can't be used arbitrarily.

If it was taking all locks at once that's one thing which has always been
good policy to avoid. But it's not, any single rq lock will only be taken
and released for a very short time, far shorter than a normal context
switch. And the entire operation will be moderated by the cost of the
syscall, and the number of runqueues it has to iterate.

There's better ways to cause DoS. Start lots of threads and burn cycles,
bounce between CPUs with affinty, sleep and wake one another between remote
CPUs etc. Run out of memory, cause hash collisions on various hashes that
are easy to control, cause lots of TLB flush IPIs...

The runqueue lock is not really special. Might equally complain about a
zone page allocator or lru lock, or an inode mutex or common dentry lock.

> The name may sound cool, but I gather that this is not
> a service the kernel willingly wants to provide to userspace.
> 
> A cunning process could easily find a way to fill its mm_cpumask and then
> issue membarrier in a loop to bring a large system to its knees.

I still don't see how. Nothing that you couldn't do with other resources or
configurations of threads and system calls. Sure you might cause a
disturbance and admin might notice and kill it.

> 
> > x86 will most
> > likely want to use its mm_cpumask to iterate.  
> 
> Iterating on mm_cpumask rather than online cpus adds complexity wrt memory
> barriers (unless we go for rq locks approach). We'd need, in addition to
> ensure that we have the proper barriers before/after store to rq->curr,
> to also ensure that we have the proper barriers between mm_cpumask
> updates and user-space loads/stores. Considering that we're not aiming
> at taking the rq locks anyway, iteration over all online cpus seems
> less complex than iterating on mm_cpumask on the architectures that
> keep track of it.

Well x86 does not *have* to implement it. I thought it probably would
like to, and I didn't think its barriers would have been all that
complex when I last looked, but didn't look too closely.

> 
> > 
> > For the powerpc approach, yes there is some controversy about using
> > runqueue locks even for cpus that we already can interfere with, but I
> > think we have a lot of options we could look at *after* it ever shows
> > up as a problem.  
> 
> The DoS argument from Peter seems to be a strong opposition to grabbing
> the rq locks.

Well if I still can't unconvince you, then we should try testing that
theory.

> 
> Here is another point in favor of having a register command for the
> private membarrier: This gives us greater flexibility to improve the
> kernel scheduler and return-to-userspace barriers if need be in the
> future.
> 
> For instance, I plan to propose a "MEMBARRIER_FLAG_SYNC_CORE" flag
> that will also provide guarantees about context synchronization of
> all cores for memory reclaim performed by JIT for the next merge
> window. So far, the following architectures seems to have the proper
> core serializing instructions already in place when returning to
> user-space: x86 (iret), powerpc (rfi), arm32/64 (return from exception,
> eret), s390/x (lpswe), ia64 (rfi), parisc (issue at least 7 instructions
> while signing around a bonfire), and mips SMP (eret).
> 
> So far, AFAIU, only x86 (eventually going through sysexit), alpha
> (appears to require an explicit imb), and sparc (explicit flush + 5
> instructions around similar bonfire as parisc) appear to require special
> handling.
> 
> I therefore plan to use the registration step with a
> MEMBARRIER_FLAG_SYNC_CORE flag set to set TIF flags and add the
> required context synchronizing barriers on sched_in() only for
> processes wishing to use private expedited membarrier.
> 
> So I don't see much point in trying to remove that registration step.

I don't follow you. You are talking about the concept of registering
intention to use a different function? And the registration API is not
merged yet?

Let me say I'm not completely against the idea of a registration API. But
don't think registration for this expedited command is necessary.

But (aside) let's say a tif flag turns out to be a good diea for your
second case, why not just check the flag in the membarrier sys call and
do the registration the first time it uses it?

Thanks,
Nick
