Return-Path: <walken@google.com>
Received: from mail-ie0-x22d.google.com (mail-ie0-x22d.google.com
 [IPv6:2607:f8b0:4001:c03::22d])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (Client CN "smtp.gmail.com", Issuer "Google Internet Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 943542C0089
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 19 Feb 2013 02:45:32 +1100 (EST)
Received: by mail-ie0-f173.google.com with SMTP id 9so7410216iec.18
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Feb 2013 07:45:26 -0800 (PST)
MIME-Version: 1.0
In-Reply-To: <20130218123856.26245.46705.stgit@srivatsabhat.in.ibm.com>
References: <20130218123714.26245.61816.stgit@srivatsabhat.in.ibm.com>
 <20130218123856.26245.46705.stgit@srivatsabhat.in.ibm.com>
Date: Mon, 18 Feb 2013 23:45:26 +0800
Message-ID: <CANN689F9S7c1M8+cEpz3tsxGF34+NTRBLvxgPUOtbvav5u+RRA@mail.gmail.com>
Subject: Re: [PATCH v6 04/46] percpu_rwlock: Implement the core design of
 Per-CPU Reader-Writer Locks
From: Michel Lespinasse <walken@google.com>
To: "Srivatsa S. Bhat" <srivatsa.bhat@linux.vnet.ibm.com>
Content-Type: text/plain; charset=ISO-8859-1
Cc: linux-doc@vger.kernel.org, peterz@infradead.org, fweisbec@gmail.com,
 linux-kernel@vger.kernel.org, mingo@kernel.org, linux-arch@vger.kernel.org,
 linux@arm.linux.org.uk, xiaoguangrong@linux.vnet.ibm.com,
 wangyun@linux.vnet.ibm.com, paulmck@linux.vnet.ibm.com,
 nikunj@linux.vnet.ibm.com, linux-pm@vger.kernel.org, rusty@rustcorp.com.au,
 rostedt@goodmis.org, rjw@sisk.pl, namhyung@kernel.org, tglx@linutronix.de,
 linux-arm-kernel@lists.infradead.org, netdev@vger.kernel.org, oleg@redhat.com,
 vincent.guittot@linaro.org, sbw@mit.edu, tj@kernel.org,
 akpm@linux-foundation.org, linuxppc-dev@lists.ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Srivasta,

I admit not having followed in detail the threads about the previous
iteration, so some of my comments may have been discussed already
before - apologies if that is the case.

On Mon, Feb 18, 2013 at 8:38 PM, Srivatsa S. Bhat
<srivatsa.bhat@linux.vnet.ibm.com> wrote:
> Reader-writer locks and per-cpu counters are recursive, so they can be
> used in a nested fashion in the reader-path, which makes per-CPU rwlocks also
> recursive. Also, this design of switching the synchronization scheme ensures
> that you can safely nest and use these locks in a very flexible manner.

I like the general idea of switching between per-cpu and global
rwlocks as needed; however I dislike unfair locks, and especially
unfair recursive rwlocks.

If you look at rwlock_t, the main reason we haven't been able to
implement reader/writer fairness there is because tasklist_lock makes
use of the recursive nature of the rwlock_t read side. I'm worried
about introducing more lock usages that would make use of the same
property for your proposed lock.

I am fine with your proposal not implementing reader/writer fairness
from day 1, but I am worried about your proposal having a recursive
reader side. Or, to put it another way: if your proposal didn't have a
recursive reader side, and rwlock_t could somehow be changed to
implement reader/writer fairness, then this property could
automatically propagate into your proposed rwlock; but if anyone makes
use of the recursive nature of your proposal then implementing
reader/writer fairness later won't be as easy.

I see that the very next change in this series is talking about
acquiring the read side from interrupts, so it does look like you're
planning to make use of the recursive nature of the read side. I kinda
wish you didn't, as this is exactly replicating the design of
tasklist_lock which is IMO problematic. Your prior proposal of
disabling interrupts during the read side had other disadvantages, but
I think it was nice that it didn't rely on having a recursive read
side.

> +#define reader_yet_to_switch(pcpu_rwlock, cpu)                             \
> +       (ACCESS_ONCE(per_cpu_ptr((pcpu_rwlock)->rw_state, cpu)->reader_refcnt))
> +
> +#define reader_percpu_nesting_depth(pcpu_rwlock)                 \
> +       (__this_cpu_read((pcpu_rwlock)->rw_state->reader_refcnt))
> +
> +#define reader_uses_percpu_refcnt(pcpu_rwlock)                         \
> +                               reader_percpu_nesting_depth(pcpu_rwlock)
> +
> +#define reader_nested_percpu(pcpu_rwlock)                              \
> +                       (reader_percpu_nesting_depth(pcpu_rwlock) > 1)
> +
> +#define writer_active(pcpu_rwlock)                                     \
> +       (__this_cpu_read((pcpu_rwlock)->rw_state->writer_signal))

I'm personally not a fan of such one-line shorthand functions - I
think they tend to make the code harder to read instead of easier, as
one constantly has to refer to them to understand what's actually
going on.

>  void percpu_write_lock(struct percpu_rwlock *pcpu_rwlock)
>  {
> +       unsigned int cpu;
> +
> +       /*
> +        * Tell all readers that a writer is becoming active, so that they
> +        * start switching over to the global rwlock.
> +        */
> +       for_each_possible_cpu(cpu)
> +               per_cpu_ptr(pcpu_rwlock->rw_state, cpu)->writer_signal = true;

I don't see anything preventing a race with the corresponding code in
percpu_write_unlock() that sets writer_signal back to false. Did I
miss something here ? It seems to me we don't have any guarantee that
all writer signals will be set to true at the end of the loop...

-- 
Michel "Walken" Lespinasse
A program is never fully debugged until the last user dies.
