Return-Path: <linus971@gmail.com>
Received: from mail-ve0-x22f.google.com (mail-ve0-x22f.google.com
 [IPv6:2607:f8b0:400c:c01::22f])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3E8E92C00A1
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 05:16:21 +1100 (EST)
Received: by mail-ve0-f175.google.com with SMTP id oz11so1379322veb.34
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 11:16:18 -0700 (PDT)
MIME-Version: 1.0
Sender: linus971@gmail.com
In-Reply-To: <1395338607.14694.23.camel@buesod1.americas.hpqcorp.net>
References: <20140319152619.GB10406@linux.vnet.ibm.com>
 <20140319154705.GB8557@laptop.programming.kicks-ass.net>
 <20140319170829.GD8557@laptop.programming.kicks-ass.net>
 <20140320053350.GB30295@linux.vnet.ibm.com>
 <1395295019.2612.11.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFzP60Ucn0snFchHNw2tOnS6HYp-6n+f+9nxrbTPw8fTfQ@mail.gmail.com>
 <1395335909.14694.15.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFw-gGQ5hTdVPovpRgcEHGyhf3YDzoSLpavzP4SefkkBDg@mail.gmail.com>
 <1395338607.14694.23.camel@buesod1.americas.hpqcorp.net>
Date: Thu, 20 Mar 2014 11:16:18 -0700
Message-ID: <CA+55aFyNFwtf2A9nexVnLJ3YRm2FJeH1WJ1U3nMaTCEq8rrOBg@mail.gmail.com>
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

On Thu, Mar 20, 2014 at 11:03 AM, Davidlohr Bueso <davidlohr@hp.com> wrote:
>
> I still wonder about ppc and spinlocks (no ticketing!!) ... sure the
> "waiters" patch might fix the problem just because we explicitly count
> the members of the plist. And I guess if we cannot rely on all archs
> having an equivalent spinlock implementation, we simply cannot use this
> technique for futexes.

So the ticketing part means that on x86 we see pending waiters even
when a previous one does "spin_unlock()". I agree that that is a
fundamental difference between x86 and powerpc, and it does seem to be
the most likely culprit.

And dammit, I *liked* my "don't use an explicit waiter count"
approach, so I'd love to be able to do it. But I we've never really
guaranteed that "is_spin_locked()" shows whether there are spinners,
so I don't know how to do that.

I guess we could expose some interface for the spinlock code to say
whether it supports that or not, and then switch between the two
algorithms. But that just feels very very ugly to me.

But let's see if the explicit waiter count version even solves the
thing on powerpc. Maybe it's something else, and we'll have to revert
entirely for now.

                 Linus
