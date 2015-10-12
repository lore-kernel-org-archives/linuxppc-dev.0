Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 272121A0021
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 20:28:59 +1100 (AEDT)
Date: Mon, 12 Oct 2015 10:28:56 +0100
From: Will Deacon <will.deacon@arm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC v2 4/7] powerpc: atomic: Implement xchg_* and
 atomic{,64}_xchg_* variants
Message-ID: <20151012092856.GB16124@arm.com>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-5-git-send-email-boqun.feng@gmail.com>
 <20151001122440.GP2881@worktop.programming.kicks-ass.net>
 <20151001150909.GC4043@linux.vnet.ibm.com>
 <20151001171304.GX3816@twins.programming.kicks-ass.net>
 <20151001180301.GJ4043@linux.vnet.ibm.com>
 <20151012011749.GD27351@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151012011749.GD27351@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 12, 2015 at 09:17:50AM +0800, Boqun Feng wrote:
> On Thu, Oct 01, 2015 at 11:03:01AM -0700, Paul E. McKenney wrote:
> > On Thu, Oct 01, 2015 at 07:13:04PM +0200, Peter Zijlstra wrote:
> > > On Thu, Oct 01, 2015 at 08:09:09AM -0700, Paul E. McKenney wrote:
> > > > On Thu, Oct 01, 2015 at 02:24:40PM +0200, Peter Zijlstra wrote:
> > > 
> > > > > I must say I'm somewhat surprised by this level of relaxation, I had
> > > > > expected to only loose SMP barriers, not the program order ones.
> > > > > 
> > > > > Is there a good argument for this?
> > > > 
> > > > Yes, when we say "relaxed", we really mean relaxed.  ;-)
> > > > 
> > > > Both the CPU and the compiler are allowed to reorder around relaxed
> > > > operations.
> > > 
> > > Is this documented somewhere, because I completely missed this part.
> > 
> > Well, yes, these need to be added to the documentation.  I am assuming
> 
> Maybe it's good time for us to call it out which operation should be
> a compiler barrier or a CPU barrier?
> 
> I had something in my mind while I was working on this series, not
> really sure whether it's correct, but probably a start point:
> 
> All global and local atomic operations are at least atomic(no one can
> observe the middle state) and volatile(compilers can't optimize out the
> memory access). Based on this, there are four strictness levels, one
> can rely on them:
> 
> RELAXED: neither a compiler barrier or a CPU barrier
> LOCAL: a compiler barrier
> PARTIAL: both a compiler barrier and a CPU barrier but not transitive
> FULL: both compiler barrier and a CPU barrier, and transitive.
> 
> RELAXED includes all _relaxed variants and non-return atomics, LOCAL
> includes all local atomics(local_* and {cmp}xchg_local), PARTIAL
> includes _acquire and _release operations and FULL includes all fully
> ordered global atomic operations.
> 
> Thoughts?

I think that's where we currently are already, apart from defining
transitivity (see the other thread), which makes things a whole lot more
muddy.

That said, on Friday we seemed to be in broad agreement on the semantics
-- the difficult part is getting the language right (which is why we
started to discuss including litmus tests alongside the documentation).

Will
