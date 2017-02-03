Return-Path: <efault@gmx.de>
Received: from mout.gmx.net (mout.gmx.net [212.227.17.21])
 (using TLSv1.2 with cipher DHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vFJH64yVNzDqBX
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 Feb 2017 00:53:22 +1100 (AEDT)
Message-ID: <1486129955.3993.6.camel@gmx.de>
Subject: Re: [tip:sched/core] sched/core: Add debugging code to catch
 missing update_rq_clock() calls
From: Mike Galbraith <efault@gmx.de>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Sachin Sant <sachinp@linux.vnet.ibm.com>, Ross Zwisler
 <zwisler@gmail.com>,  Matt Fleming <matt@codeblueprint.co.uk>, Michael
 Ellerman <mpe@ellerman.id.au>,  "linuxppc-dev@lists.ozlabs.org"
 <linuxppc-dev@lists.ozlabs.org>, "linux-next@vger.kernel.org"
 <linux-next@vger.kernel.org>, LKML <linux-kernel@vger.kernel.org>, Paul
 McKenney <paulmck@linux.vnet.ibm.com>
Date: Fri, 03 Feb 2017 14:52:35 +0100
In-Reply-To: <20170203133748.GB6515@twins.programming.kicks-ass.net>
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
 <20170203133748.GB6515@twins.programming.kicks-ass.net>
Content-Type: text/plain; charset="us-ascii"
Mime-Version: 1.0
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, 2017-02-03 at 14:37 +0100, Peter Zijlstra wrote:
> On Fri, Feb 03, 2017 at 01:59:34PM +0100, Mike Galbraith wrote:

> > FWIW, I'm not seeing stalls/hangs while beating hotplug up in tip. (so
> > next grew a wart?)
> 
> I've seen it on tip. It looks like hot unplug goes really slow when
> there's running tasks on the CPU being taken down.
> 
> What I did was something like:
> 
>   taskset -p $((1<<1)) $$
>   for ((i=0; i<20; i++)) do while :; do :; done & done
> 
>   taskset -p $((1<<0)) $$
>   echo 0 > /sys/devices/system/cpu/cpu1/online
> 
> And with those 20 tasks stuck sucking cycles on CPU1, the unplug goes
> _really_ slow and the RCU stall triggers. What I suspect happens is that
> hotplug stops participating in the RCU state machine early, but only
> tells RCU about it really late, and in between it gets suspicious it
> takes too long.

Ah.  I wasn't doing a really hard pounding, just running a couple
instances of Steven's script.  To beat hell out of it, I add futextest,
stockfish and a small kbuild on a big box.

	-Mike
