Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFHxK0BjwzDqBX
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Feb 2017 00:37:57 +1100 (AEDT)
Date: Fri, 3 Feb 2017 14:37:48 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Mike Galbraith <efault@gmx.de>
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>, Ross Zwisler <zwisler@gmail.com>,
 Matt Fleming <matt@codeblueprint.co.uk>,
 Michael Ellerman <mpe@ellerman.id.au>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 "linux-next@vger.kernel.org" <linux-next@vger.kernel.org>,
 LKML <linux-kernel@vger.kernel.org>,
 Paul McKenney <paulmck@linux.vnet.ibm.com>
Subject: Re: [tip:sched/core] sched/core: Add debugging code to catch missing
 update_rq_clock() calls
Message-ID: <20170203133748.GB6515@twins.programming.kicks-ass.net>
References: <tip-cb42c9a3ebbbb23448c3f9a25417fae6309b1a92@git.kernel.org>
 <87tw8gutp6.fsf@concordia.ellerman.id.au>
 <20170130213435.GM31613@codeblueprint.co.uk>
 <33118425-8548-475A-8DED-9A2424C0BCCC@linux.vnet.ibm.com>
 <1485863317.4498.2.camel@gmx.de>
 <CAOxpaSW_GnndoxLBPtyTrqPJ9XOWvgXOQNDf8D+6OohWeObn5Q@mail.gmail.com>
 <20170202155506.GX6515@twins.programming.kicks-ass.net>
 <3BAB5673-2BF8-46E0-8018-6A0F3DEEC9F7@linux.vnet.ibm.com>
 <20170203085301.GA6515@twins.programming.kicks-ass.net>
 <1486126774.4277.6.camel@gmx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1486126774.4277.6.camel@gmx.de>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Feb 03, 2017 at 01:59:34PM +0100, Mike Galbraith wrote:
> On Fri, 2017-02-03 at 09:53 +0100, Peter Zijlstra wrote:
> > On Fri, Feb 03, 2017 at 10:03:14AM +0530, Sachin Sant wrote:
> 
> > > I ran few cycles of cpu hot(un)plug tests. In most cases it works except one
> > > where I ran into rcu stall:
> > > 
> > > [  173.493453] INFO: rcu_sched detected stalls on CPUs/tasks:
> > > [  173.493473] > > 	> > 8-...: (2 GPs behind) idle=006/140000000000000/0 softirq=0/0 fqs=2996 
> > > [  173.493476] > > 	> > (detected by 0, t=6002 jiffies, g=885, c=884, q=6350)
> > 
> > Right, I actually saw that too, but I don't think that would be related
> > to my patch. I'll see if I can dig into this though, ought to get fixed
> > regardless.
> 
> FWIW, I'm not seeing stalls/hangs while beating hotplug up in tip. (so
> next grew a wart?)

I've seen it on tip. It looks like hot unplug goes really slow when
there's running tasks on the CPU being taken down.

What I did was something like:

  taskset -p $((1<<1)) $$
  for ((i=0; i<20; i++)) do while :; do :; done & done

  taskset -p $((1<<0)) $$
  echo 0 > /sys/devices/system/cpu/cpu1/online

And with those 20 tasks stuck sucking cycles on CPU1, the unplug goes
_really_ slow and the RCU stall triggers. What I suspect happens is that
hotplug stops participating in the RCU state machine early, but only
tells RCU about it really late, and in between it gets suspicious it
takes too long.

I've yet to dig through the RCU code to figure out the exact sequence of
events, but found the above to be fairly reliable in triggering the
issue.
