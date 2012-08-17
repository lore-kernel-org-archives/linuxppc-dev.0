Return-Path: <michael@ellerman.id.au>
Message-ID: <1345166426.28806.0.camel@concordia>
Subject: Re: powerpc/perf: hw breakpoints return ENOSPC
From: Michael Ellerman <michael@ellerman.id.au>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Fri, 17 Aug 2012 11:20:26 +1000
In-Reply-To: <1345126502.29668.36.camel@twins>
References: <28857.1345091034@neuling.org>
 <1345102812.31459.114.camel@twins> <20344.1345115849@neuling.org>
 <1345117498.29668.23.camel@twins> <1345125747.20062.12.camel@concordia>
 <1345126502.29668.36.camel@twins>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Michael Neuling <mikey@neuling.org>,
 Frederic Weisbecker <fweisbec@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org, K Prasad <prasad@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, 2012-08-16 at 16:15 +0200, Peter Zijlstra wrote:
> On Fri, 2012-08-17 at 00:02 +1000, Michael Ellerman wrote:
> > You do want to guarantee that the task will always be subject to the
> > breakpoint, even if it moves cpus. So is there any way to guarantee that
> > other than reserving a breakpoint slot on every cpu ahead of time? 
> 
> That's not how regular perf works.. regular perf can overload hw
> resources at will and stuff is strictly per-cpu.
..
> For regular (!pinned) events, we'll RR the created events on the
> available hardware resources.

Yeah I know, but that isn't really the semantics you want for a
breakpoint. You don't want to sometimes have the breakpoint active and
sometimes not, it needs to be active at all times when the task is
running.

At the very least you want it to behave like a pinned event, ie. if it
can't be scheduled you get notified and can tell the user.

> HWBP does things completely different and reserves a slot over all CPUs
> for everything, thus stuff completely falls apart.

So it would seem :)

I guess my point was that reserving a slot on each cpu seems like a
reasonable way of guaranteeing that wherever the task goes we will be
able to install the breakpoint.

But obviously we need some way to make it play nice with perf.

cheers
