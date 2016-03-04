Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8C4601A045D
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  4 Mar 2016 19:43:40 +1100 (AEDT)
Message-ID: <1457081014.20076.6.camel@ellerman.id.au>
Subject: Re: hw_breakpoint: Fix Oops at destroying hw_breakpoint event on
 powerpc
From: Michael Ellerman <mpe@ellerman.id.au>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Ravi Bangoria <ravi.bangoria@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 acme@kernel.org,  mingo@redhat.com, paulus@samba.org
Date: Fri, 04 Mar 2016 19:43:34 +1100
In-Reply-To: <20160303102002.GK6356@twins.programming.kicks-ass.net>
References: <1456912517-5711-1-git-send-email-ravi.bangoria@linux.vnet.ibm.com>
 <20160302115324.63B35140BF5@ozlabs.org>
 <20160302115942.GC6356@twins.programming.kicks-ass.net>
 <1456997018.335.7.camel@ellerman.id.au>
 <20160303102002.GK6356@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2016-03-03 at 11:20 +0100, Peter Zijlstra wrote:
> On Thu, Mar 03, 2016 at 08:23:38PM +1100, Michael Ellerman wrote:
> > On Wed, 2016-03-02 at 12:59 +0100, Peter Zijlstra wrote:
>
> Indeed, but if there's a preemption point in between setting and using
> that state, the ctx->task pointer might not actually still point to the
> same task. With inherited events the event might get swapped to the next
> task if it has the exact same (inherited) event configuration instead of
> reprogramming the hardware.

Yep that sounds like it would be bad for this code.

> > I can't think of a reason why we can't also store it per-cpu, but I could be
> > wrong, I don't know the code well and I haven't thought about it for very long.
>
> Right, so I'm not really up to snuff on the whole hw_breakpoint stuff
> either, that was bolted onto perf by mingo, fweisbec, kprasad and others
> while I was doing PMU bits, and I've never really dug into it.
>
> I understand kprasad is no longer with IBM, his email bounced. That's a
> shame because he knew about this stuff.. :/

I don't know that for sure but I suspect you're right, which is definitely a
shame.

> > Do you mind if I merge the following fix for now as a band-aid, and we'll try
> > and fix it up properly in the next few weeks (but maybe not in time for 4.5
> > final).
>
> OK, that works for me.
>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Thanks. I've merged it into my fixes branch.

cheers
