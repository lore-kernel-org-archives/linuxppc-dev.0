Return-Path: <linus971@gmail.com>
Received: from mail-ve0-x22b.google.com (mail-ve0-x22b.google.com
 [IPv6:2607:f8b0:400c:c01::22b])
 (using TLSv1 with cipher ECDHE-RSA-RC4-SHA (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 732312C00A8
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 05:36:46 +1100 (EST)
Received: by mail-ve0-f171.google.com with SMTP id cz12so1410735veb.16
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 20 Mar 2014 11:36:42 -0700 (PDT)
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
Date: Thu, 20 Mar 2014 11:36:42 -0700
Message-ID: <CA+55aFwH2sJKCH6hUf8H-7nMPo8YwFCR6oP8McZ5VpMcGDrYSw@mail.gmail.com>
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
>
> Comparing with the patch I sent earlier this morning, looks equivalent,
> and fwiw, passes my initial qemu bootup, which is the first way of
> detecting anything stupid going on.
>
> So, Srikar, please try this patch out, as opposed to mine, you don't
> have to first revert the commit in question.

Ok, so it boots for me too, so hopefully it isn't totally broken.

However, since it's just closing a race, and since getting the counts
wrong should easily result in it *working* but always taking the slow
path (for example), I'd really like people to also verify that it
fixes the actual performance issue (ie assuming it fixes powerpc
behavior for Srikar, I'd like to get it double-checked that it also
avoids the spinlock in the common case). Because if the
increment/decrement pairings end up being wrong, we could have a
situation where the waiter count just ends up bogus, and it all works
from a correctness standpoint but not from the intended performance
optimization.

No way I can test that sanely on my single-socket machine. Davidlohr?

                  Linus
