Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C119B1A0806
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 13 Oct 2015 10:24:29 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 12 Oct 2015 17:24:27 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id A7ABE3E4003F
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 17:24:19 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t9CNL6ex2752950
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 16:21:06 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9CNOIBW012186
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 12 Oct 2015 17:24:19 -0600
Date: Mon, 12 Oct 2015 16:24:26 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC v2 4/7] powerpc: atomic: Implement xchg_* and
 atomic{,64}_xchg_* variants
Message-ID: <20151012232426.GJ3910@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
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
> Hi Paul,
> 
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

As Will noted, we have two types of transitive.  The first type is that
of release-acquire chains, where the transitivity is only observable
within the chain.  The second type is that of smp_mb(), where the
transitivity is observable globally.

							Thanx, Paul

> RELAXED includes all _relaxed variants and non-return atomics, LOCAL
> includes all local atomics(local_* and {cmp}xchg_local), PARTIAL
> includes _acquire and _release operations and FULL includes all fully
> ordered global atomic operations.
> 
> Thoughts?
> 
> Regards,
> Boqun
> 
> > that Will is looking to have the same effect as C11 memory_order_relaxed,
> > which is relaxed in this sense.  If he has something else in mind,
> > he needs to tell us what it is and why.  ;-)
> > 
> > 							Thanx, Paul
> > 
