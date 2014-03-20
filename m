Return-Path: <linus971@gmail.com>
Received: from mail-ve0-x235.google.com (mail-ve0-x235.google.com
 [IPv6:2607:f8b0:400c:c01::235])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id F2B2A2C0097
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 04:42:06 +1100 (EST)
Received: by mail-ve0-f181.google.com with SMTP id oy12so1353914veb.12
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 10:42:02 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1395335909.14694.15.camel@buesod1.americas.hpqcorp.net>
References: <20140319152619.GB10406@linux.vnet.ibm.com>
 <20140319154705.GB8557@laptop.programming.kicks-ass.net>
 <20140319170829.GD8557@laptop.programming.kicks-ass.net>
 <20140320053350.GB30295@linux.vnet.ibm.com>
 <1395295019.2612.11.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFzP60Ucn0snFchHNw2tOnS6HYp-6n+f+9nxrbTPw8fTfQ@mail.gmail.com>
 <1395335909.14694.15.camel@buesod1.americas.hpqcorp.net>
Date: Thu, 20 Mar 2014 10:42:02 -0700
Message-ID: <CA+55aFw-gGQ5hTdVPovpRgcEHGyhf3YDzoSLpavzP4SefkkBDg@mail.gmail.com>
Subject: Re: Tasks stuck in futex code (in 3.14-rc6)
From: Linus Torvalds <torvalds@linux-foundation.org>
To: Davidlohr Bueso <davidlohr@hp.com>
Content-Type: text/plain; charset=UTF-8
Cc: Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, LKML <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>,
 ppc-dev <linuxppc-dev@lists.ozlabs.org>, Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 20, 2014 at 10:18 AM, Davidlohr Bueso <davidlohr@hp.com> wrote:
>> It strikes me that the "spin_is_locked()" test has no barriers wrt the
>> writing of the new futex value on the wake path. And the read barrier
>> obviously does nothing wrt the write either. Or am I missing
>> something? So the write that actually released the futex might be
>> almost arbitrarily delayed on the waking side. So the waiting side may
>> not see the new value, even though the waker assumes it does due to
>> the ordering of it doing the write first.
>
> Aha, that would certainly violate the ordering guarantees. I feared
> _something_ like that when we originally discussed your suggestion as
> opposed to the atomics one, but didn't have any case for it either.

Actually, looking closer, we have the memory barrier in
get_futex_key_refs() (called by "get_futex_key()") so that's not it.
In fact, your "atomic_read(&hb->waiters)" doesn't have any more
serialization than the spin_is_locked() test had.

But the spin_is_locked() and queue-empty tests are two separate memory
reads, and maybe there is some ordering wrt those two that we missed,
so the "waiters" patch is worth trying anyway.

I do still dislike how the "waiters" thing adds an atomic update, but whatever..

          Linus
