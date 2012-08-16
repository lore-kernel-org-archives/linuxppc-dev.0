Return-Path: <michael@ellerman.id.au>
Message-ID: <1345125747.20062.12.camel@concordia>
Subject: Re: powerpc/perf: hw breakpoints return ENOSPC
From: Michael Ellerman <michael@ellerman.id.au>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Date: Fri, 17 Aug 2012 00:02:27 +1000
In-Reply-To: <1345117498.29668.23.camel@twins>
References: <28857.1345091034@neuling.org>
 <1345102812.31459.114.camel@twins> <20344.1345115849@neuling.org>
 <1345117498.29668.23.camel@twins>
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

On Thu, 2012-08-16 at 13:44 +0200, Peter Zijlstra wrote:
> On Thu, 2012-08-16 at 21:17 +1000, Michael Neuling wrote:
> > Peter,
> > 
> > > > On this second syscall, fetch_bp_busy_slots() sets slots.pinned to be 1,
> > > > despite there being no breakpoint on this CPU.  This is because the call
> > > > the task_bp_pinned, checks all CPUs, rather than just the current CPU.
> > > > POWER7 only has one hardware breakpoint per CPU (ie. HBP_NUM=1), so we
> > > > return ENOSPC.
> > > 
> > > I think this comes from the ptrace legacy, we register a breakpoint on
> > > all cpus because when we migrate a task it cannot fail to migrate the
> > > breakpoint.
> > > 
> > > Its one of the things I hate most about the hwbp stuff as it relates to
> > > perf.
> > > 
> > > Frederic knows more...
> > 
> > Maybe I should wait for Frederic to respond but I'm not sure I
> > understand what you're saying.
> > 
> > I can see how using ptrace hw breakpoints and perf hw breakpoints at the
> > same time could be a problem, but I'm not sure how this would stop it.
> 
> ptrace uses perf for hwbp support so we're stuck with all kinds of
> stupid ptrace constraints.. or somesuch.
> 
> > Are you saying that we need to keep at least 1 slot free at all times,
> > so that we can use it for ptrace?
> 
> No, I'm saying perf-hwbp is weird because of ptrace, maybe the ptrace
> weirdness shouldn't live in perf-hwpb but in the ptrace-perf glue
> however..

But how else would it work, even if ptrace wasn't in the picture?

You do want to guarantee that the task will always be subject to the
breakpoint, even if it moves cpus. So is there any way to guarantee that
other than reserving a breakpoint slot on every cpu ahead of time?

Or can a hwbp event go into error state if it can't be installed on the
new cpu, like a pinned event does? I can't see any code that does that.

cheers
