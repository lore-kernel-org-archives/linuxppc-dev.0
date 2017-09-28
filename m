Return-Path: <compudj@efficios.com>
Received: from mail.efficios.com (mail.efficios.com [167.114.142.141])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3y337R0tvtzDsPq
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Sep 2017 04:26:57 +1000 (AEST)
Date: Thu, 28 Sep 2017 18:28:07 +0000 (UTC)
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
Message-ID: <1163007565.21698.1506623287253.JavaMail.zimbra@efficios.com>
In-Reply-To: <20170929021622.5c7d6206@roar.ozlabs.ibm.com>
References: <20170926175151.14264-1-mathieu.desnoyers@efficios.com>
 <33948425.19289.1506458608221.JavaMail.zimbra@efficios.com>
 <20170927230436.4af88a62@roar.ozlabs.ibm.com>
 <911707916.20840.1506605496314.JavaMail.zimbra@efficios.com>
 <20170929010112.3a54be0d@roar.ozlabs.ibm.com>
 <634837506.21241.1506612590749.JavaMail.zimbra@efficios.com>
 <20170929021622.5c7d6206@roar.ozlabs.ibm.com>
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

----- On Sep 28, 2017, at 12:16 PM, Nicholas Piggin npiggin@gmail.com wrote:

> On Thu, 28 Sep 2017 15:29:50 +0000 (UTC)
> Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
> 
>> ----- On Sep 28, 2017, at 11:01 AM, Nicholas Piggin npiggin@gmail.com wrote:
>> 
>> > On Thu, 28 Sep 2017 13:31:36 +0000 (UTC)
>> > Mathieu Desnoyers <mathieu.desnoyers@efficios.com> wrote:
>> >   
>> >> ----- On Sep 27, 2017, at 9:04 AM, Nicholas Piggin npiggin@gmail.com wrote:
>> >>   
> 
> [snip]
> 
>> >> So I don't see much point in trying to remove that registration step.
>> > 
>> > I don't follow you. You are talking about the concept of registering
>> > intention to use a different function? And the registration API is not
>> > merged yet?
>> 
>> Yes, I'm talking about requiring processes to invoke membarrier cmd
>> MEMBARRIER_CMD_REGISTER_PRIVATE_EXPEDITED before they can successfully
>> invoke membarrier cmd MEMBARRIER_CMD_PRIVATE_EXPEDITED.
>> 
>> > Let me say I'm not completely against the idea of a registration API. But
>> > don't think registration for this expedited command is necessary.
>> 
>> Given that we have the powerpc lack-of-full-barrier-on-return-to-userspace
>> case now, and we foresee x86-sysexit, sparc, and alpha also requiring
>> special treatment when we introduce the MEMBARRIER_FLAG_SYNC_CORE behavior
>> in the next release, it seems that we'll have a hard time handling
>> architecture special cases efficiently if we don't expose the registration
>> API right away.
> 
> But SYNC_CORE is a different functionality, right? You can add the
> registration API for it when that goes in.

Sure, I could. However, I was hoping to re-use the same command, with a
"SYNC_CORE" flag, and I would have liked to have consistent behavior
for same commands used with different flags.

> 
>> > But (aside) let's say a tif flag turns out to be a good diea for your
>> > second case, why not just check the flag in the membarrier sys call and
>> > do the registration the first time it uses it?
>> 
>> We also considered that option. It's mainly about guaranteeing that
>> an expedited membarrier command never blocks. If we introduce this
>> "lazy auto-registration" behavior, we end up blocking the process
>> at a random point in its execution so we can issue a synchronize_sched().
>> By exposing an explicit registration, we can control where this delay
>> occurs, and even allow library constructors to invoke the registration
>> while the process is a single threaded, therefore allowing us to completely
>> skip synchronize_sched().
> 
> Okay I guess that could be a good reason. As I said I'm not opposed to
> the concept. I suppose you could even have a registration for expedited
> private even if it's a no-op on all architectures, just in case some new
> ways of implementing it can be done in future.

That's an approach I would be OK with too. Mandating explicit registration
will give us much more flexibility.

> I suppose I'm more objecting to the added complexity for powerpc, and
> more code in the fastpath to make the slowpath faster.

Just to make sure I understand your concern here. The "fastpath" you
refer to is the TIF flag test in membarrier_sched_in() within
finish_task_switch(), and the "slowpath" is switch_mm() which lacks
the required full barrier now, am I correct ?

Would it help if we invoke the membarrier hook from switch_mm()
instead ? We'd therefore only add the TIF flag test in switch_mm(),
rather than for every context switch.

Thanks,

Mathieu


> 
> Thanks,
> Nick

-- 
Mathieu Desnoyers
EfficiOS Inc.
http://www.efficios.com
