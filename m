Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org [85.118.1.10])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id CC5811A035C
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  3 Mar 2016 21:24:23 +1100 (AEDT)
Date: Thu, 3 Mar 2016 11:20:02 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Michael Ellerman <mpe@ellerman.id.au>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org, mingo@redhat.com, paulus@samba.org
Subject: Re: hw_breakpoint: Fix Oops at destroying hw_breakpoint event on
 powerpc
Message-ID: <20160303102002.GK6356@twins.programming.kicks-ass.net>
References: <1456912517-5711-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20160302115324.63B35140BF5@ozlabs.org>
 <20160302115942.GC6356@twins.programming.kicks-ass.net>
 <1456997018.335.7.camel@ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1456997018.335.7.camel@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Mar 03, 2016 at 08:23:38PM +1100, Michael Ellerman wrote:
> On Wed, 2016-03-02 at 12:59 +0100, Peter Zijlstra wrote:
> 
> > On Wed, Mar 02, 2016 at 10:53:24PM +1100, Michael Ellerman wrote:
> 
> > > Peterz, acme, do you guys want to take this? Or should I?
> >
> > I'm not too happy its touching event->ctx at all. It really should not
> > be doing that.
> 
> Hmm OK.
> 
> It's been using ctx->task since it was merged in 2010. In fact that commit also
> added arch_unregister_hw_breakpoint(), and we're still the only user of that.

Yes, I saw that.

> The prima facie reason it's using ctx is to get at task->thread to clear
> last_hit_ubp.

Indeed, but if there's a preemption point in between setting and using
that state, the ctx->task pointer might not actually still point to the
same task. With inherited events the event might get swapped to the next
task if it has the exact same (inherited) event configuration instead of
reprogramming the hardware.

And if there's no preemption point in between then:

> It looks like other arches avoid needing to do something similar by storing the
> break point in a per-cpu array. Which I guess is what you meant in your other
> mail ("Why do you keep per task state anyway?").

this seems possible. And indeed, that was part of that question. The
other part was wondering how per-cpu breakpoints were treated, although
for those the per-cpu storage thing is an 'obvious' solution.

> I can't think of a reason why we can't also store it per-cpu, but I could be
> wrong, I don't know the code well and I haven't thought about it for very long.

Right, so I'm not really up to snuff on the whole hw_breakpoint stuff
either, that was bolted onto perf by mingo, fweisbec, kprasad and others
while I was doing PMU bits, and I've never really dug into it.

I understand kprasad is no longer with IBM, his email bounced. That's a
shame because he knew about this stuff.. :/

> Do you mind if I merge the following fix for now as a band-aid, and we'll try
> and fix it up properly in the next few weeks (but maybe not in time for 4.5
> final).

OK, that works for me.

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
