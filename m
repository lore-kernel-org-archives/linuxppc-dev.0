Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id ED2FA1A0030
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 01:44:14 +1100 (AEDT)
Date: Mon, 5 Oct 2015 15:44:07 +0100
From: Will Deacon <will.deacon@arm.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC v2 4/7] powerpc: atomic: Implement xchg_* and
 atomic{,64}_xchg_* variants
Message-ID: <20151005144407.GI8818@arm.com>
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-5-git-send-email-boqun.feng@gmail.com>
 <20151001122440.GP2881@worktop.programming.kicks-ass.net>
 <20151001150909.GC4043@linux.vnet.ibm.com>
 <20151001171304.GX3816@twins.programming.kicks-ass.net>
 <20151001180301.GJ4043@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151001180301.GJ4043@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 01, 2015 at 07:03:01PM +0100, Paul E. McKenney wrote:
> On Thu, Oct 01, 2015 at 07:13:04PM +0200, Peter Zijlstra wrote:
> > On Thu, Oct 01, 2015 at 08:09:09AM -0700, Paul E. McKenney wrote:
> > > On Thu, Oct 01, 2015 at 02:24:40PM +0200, Peter Zijlstra wrote:
> > 
> > > > I must say I'm somewhat surprised by this level of relaxation, I had
> > > > expected to only loose SMP barriers, not the program order ones.
> > > > 
> > > > Is there a good argument for this?
> > > 
> > > Yes, when we say "relaxed", we really mean relaxed.  ;-)
> > > 
> > > Both the CPU and the compiler are allowed to reorder around relaxed
> > > operations.
> > 
> > Is this documented somewhere, because I completely missed this part.
> 
> Well, yes, these need to be added to the documentation.  I am assuming
> that Will is looking to have the same effect as C11 memory_order_relaxed,
> which is relaxed in this sense.  If he has something else in mind,
> he needs to tell us what it is and why.  ;-)

I was treating them purely as being single-copy atomic and not providing
any memory ordering guarantees (much like the non *_return atomic operations
that we already have). I think this lines up with C11, minus the bits
about data races which we don't call out anyway.

Will
