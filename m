Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Peter Zijlstra <a.p.zijlstra@chello.nl>
Subject: Re: powerpc/perf: hw breakpoints return ENOSPC
In-reply-to: <1345102812.31459.114.camel@twins>
References: <28857.1345091034@neuling.org> <1345102812.31459.114.camel@twins>
Date: Thu, 16 Aug 2012 21:17:29 +1000
Message-ID: <20344.1345115849@neuling.org>
Cc: Ingo Molnar <mingo@kernel.org>, Frederic Weisbecker <fweisbec@gmail.com>,
 K Prasad <prasad@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@ozlabs.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter,

> > On this second syscall, fetch_bp_busy_slots() sets slots.pinned to be 1,
> > despite there being no breakpoint on this CPU.  This is because the call
> > the task_bp_pinned, checks all CPUs, rather than just the current CPU.
> > POWER7 only has one hardware breakpoint per CPU (ie. HBP_NUM=1), so we
> > return ENOSPC.
> 
> I think this comes from the ptrace legacy, we register a breakpoint on
> all cpus because when we migrate a task it cannot fail to migrate the
> breakpoint.
> 
> Its one of the things I hate most about the hwbp stuff as it relates to
> perf.
> 
> Frederic knows more...

Maybe I should wait for Frederic to respond but I'm not sure I
understand what you're saying.

I can see how using ptrace hw breakpoints and perf hw breakpoints at the
same time could be a problem, but I'm not sure how this would stop it.

Are you saying that we need to keep at least 1 slot free at all times,
so that we can use it for ptrace?

Is "perf record -e mem:0x10000000 true" ever going to be able to work on
POWER7 with only one hw breakpoint resource per CPU?  

Thanks,
Mikey
