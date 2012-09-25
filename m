Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Frederic Weisbecker <fweisbec@gmail.com>
Subject: Re: powerpc/perf: hw breakpoints return ENOSPC
In-reply-to: <11821.1345240695@neuling.org>
References: <28857.1345091034@neuling.org> <20120817161554.GA3772@somewhere>
 <11821.1345240695@neuling.org>
Date: Tue, 25 Sep 2012 17:10:14 +1000
Message-ID: <29084.1348557014@neuling.org>
Cc: Ingo Molnar <mingo@kernel.org>, linuxppc-dev@ozlabs.org,
 K Prasad <prasad@linux.vnet.ibm.com>, linux-kernel@vger.kernel.org,
 Peter Zijlstra <a.p.zijlstra@chello.nl>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Neuling <mikey@neuling.org> wrote:

> Frederic Weisbecker <fweisbec@gmail.com> wrote:
> 
> > On Thu, Aug 16, 2012 at 02:23:54PM +1000, Michael Neuling wrote:
> > > Hi,
> > > 
> > > I've been trying to get hardware breakpoints with perf to work on POWER7
> > > but I'm getting the following:
> > > 
> > >   % perf record -e mem:0x10000000 true
> > > 
> > >     Error: sys_perf_event_open() syscall returned with 28 (No space left on device).  /bin/dmesg may provide additional information.
> > > 
> > >     Fatal: No CONFIG_PERF_EVENTS=y kernel support configured?
> > > 
> > >   true: Terminated
> > > 
> > > (FWIW adding -a and it works fine)
> > > 
> > > Debugging it seems that __reserve_bp_slot() is returning ENOSPC because
> > > it thinks there are no free breakpoint slots on this CPU.
> > > 
> > > I have a 2 CPUs, so perf userspace is doing two perf_event_open syscalls
> > > to add a counter to each CPU [1].  The first syscall succeeds but the
> > > second is failing.
> > > 
> > > On this second syscall, fetch_bp_busy_slots() sets slots.pinned to be 1,
> > > despite there being no breakpoint on this CPU.  This is because the call
> > > the task_bp_pinned, checks all CPUs, rather than just the current CPU.
> > > POWER7 only has one hardware breakpoint per CPU (ie. HBP_NUM=1), so we
> > > return ENOSPC.
> > > 
> > > The following patch fixes this by checking the associated CPU for each
> > > breakpoint in task_bp_pinned.  I'm not familiar with this code, so it's
> > > provided as a reference to the above issue.
> > > 
> > > Mikey
> > > 
> > > 1. not sure why it doesn't just do one syscall and specify all CPUs, but
> > > that's another issue.  Using two syscalls should work.
> > 
> > This patch seems to make sense. I'll try it and run some tests.
> > Can I have your Signed-off-by ?

Frederic,

Did you ever get to testing or integrating this patch?

Mikey

> Of course...
> 
> Signed-off-by: Michael Neuling <mikey@neuling.org>
