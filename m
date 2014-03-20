Return-Path: <davidlohr@hp.com>
Received: from g2t2353.austin.hp.com (g2t2353.austin.hp.com [15.217.128.52])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 335C82C00AE
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 21 Mar 2014 07:20:17 +1100 (EST)
Message-ID: <1395346808.14694.62.camel@buesod1.americas.hpqcorp.net>
Subject: Re: Tasks stuck in futex code (in 3.14-rc6)
From: Davidlohr Bueso <davidlohr@hp.com>
To: Linus Torvalds <torvalds@linux-foundation.org>
Date: Thu, 20 Mar 2014 13:20:08 -0700
In-Reply-To: <CA+55aFw8wSe-DUtZ8=rjFJzXYmOSsZ0JzS-_jsZKrDai8LZMXw@mail.gmail.com>
References: <20140319152619.GB10406@linux.vnet.ibm.com>
 <20140319154705.GB8557@laptop.programming.kicks-ass.net>
 <20140319170829.GD8557@laptop.programming.kicks-ass.net>
 <20140320053350.GB30295@linux.vnet.ibm.com>
 <1395295019.2612.11.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFzP60Ucn0snFchHNw2tOnS6HYp-6n+f+9nxrbTPw8fTfQ@mail.gmail.com>
 <1395335909.14694.15.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFwH2sJKCH6hUf8H-7nMPo8YwFCR6oP8McZ5VpMcGDrYSw@mail.gmail.com>
 <1395342510.14694.43.camel@buesod1.americas.hpqcorp.net>
 <CA+55aFw8wSe-DUtZ8=rjFJzXYmOSsZ0JzS-_jsZKrDai8LZMXw@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
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

On Thu, 2014-03-20 at 12:25 -0700, Linus Torvalds wrote:
> On Thu, Mar 20, 2014 at 12:08 PM, Davidlohr Bueso <davidlohr@hp.com> wrote:
> >
> > Oh, it does. This atomics technique was tested at a customer's site and
> > ready for upstream.
> 
> I'm not worried about the *original* patch. I'm worried about the
> incremental one.
> 
> Your original patch never applied to my tree - I think it was based on
> -mm or something. So I couldn't verify my "let's go back to the
> explicit 'waiters'" incremental patch against reverting and
> re-applying the original patch.

Ok, so a big reason why this patch doesn't apply cleanly after reverting
is because *most* of the changes were done at the top of the file with
regards to documenting the ordering guarantees, the actual code changes
are quite minimal.

I reverted commits 99b60ce6 (documentation) and b0c29f79 (the offending
commit), and then I cleanly applied the equivalent ones from v3 of the
series (which was already *tested* and ready for upstream until you
suggested looking into the alternative spinlock approach):

https://lkml.org/lkml/2013/12/19/624
https://lkml.org/lkml/2013/12/19/630

Assuming the atomics solves the issue, would you be willing to take this
path? Any pending documentation fixes can be added afterwards. The
important thing is that the actual code is well tested.

Thanks,
Davidlohr
