Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Peter Zijlstra <peterz@infradead.org>
Subject: Re: Invalid perf_branch_entry.to entries question
In-reply-to: <20130508155929.GA8459@dyad.programming.kicks-ass.net>
References: <25394.1367890528@ale.ozlabs.ibm.com>
 <20130508155929.GA8459@dyad.programming.kicks-ass.net>
Date: Thu, 09 May 2013 08:39:15 +1000
Message-ID: <14691.1368052755@ale.ozlabs.ibm.com>
Cc: Linux PPC dev <linuxppc-dev@ozlabs.org>, linux-kernel@vger.kernel.org,
 eranian@google.com, Anshuman Khandual <anshuman.khandual@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Peter Zijlstra <peterz@infradead.org> wrote:

> On Tue, May 07, 2013 at 11:35:28AM +1000, Michael Neuling wrote:
> > Peter & Stephane,
> > 
> > We are plumbing the POWER8 Branch History Rolling Buffer (BHRB) into
> > struct perf_branch_entry.
> > 
> > Sometimes on POWER8 we may not be able to fill out the "to" address.  
> 
> Just because I'm curious.. however does that happen? Surely the CPU
> knows where next to fetch instructions?

For computed gotos (ie. branch to a register value), the hardware gives
you the from and to address in the branch history buffer.

For branches where the branch target address is an immediate encoded in
the instruction, the hardware only logs the from address.  It assumes
that software (perf irq handler in this case) can read this branch
instruction, calculate the corresponding offset and hence the
to/target address.

It's entirely possible that when the perf IRQ handler happens, the
instruction in question is not readable or is no longer a branch (self
modifying code).  Hence we aren't able to calculate a valid to address.

Mikey

> 
> > We
> > initially thought of just making this 0, but it's feasible that this
> > could be a valid address to branch to. 
> 
> Right, while highly unlikely, x86 actually has some cases where 0 address is
> valid *shudder*..
> 
> > The other logical value to indicate an invalid entry would be all 1s
> > which is not possible (on POWER at least).
> > 
> > Do you guys have a preference as to what we should use as an invalid
> > entry?  This would have some consequences for the userspace tool also.
> > 
> > The alternative would be to add a flag alongside mispred/predicted to
> > indicate the validity of the "to" address.
> 
> Either would work with me I suppose.. Stephane do you have any preference?
> 
