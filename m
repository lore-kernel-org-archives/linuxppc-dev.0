Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DB3131A0023
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Oct 2015 11:54:12 +1100 (AEDT)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Mon, 5 Oct 2015 18:54:09 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 648D419D803E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  5 Oct 2015 18:42:19 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t960r90j11338082
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Oct 2015 17:53:09 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t960s6tW013550
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 5 Oct 2015 18:54:07 -0600
Date: Mon, 5 Oct 2015 09:57:03 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC v2 4/7] powerpc: atomic: Implement xchg_* and
 atomic{,64}_xchg_* variants
Message-ID: <20151005165703.GD4487@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-5-git-send-email-boqun.feng@gmail.com>
 <20151001122440.GP2881@worktop.programming.kicks-ass.net>
 <20151001150909.GC4043@linux.vnet.ibm.com>
 <20151001171304.GX3816@twins.programming.kicks-ass.net>
 <20151001180301.GJ4043@linux.vnet.ibm.com>
 <20151005144407.GI8818@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151005144407.GI8818@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 05, 2015 at 03:44:07PM +0100, Will Deacon wrote:
> On Thu, Oct 01, 2015 at 07:03:01PM +0100, Paul E. McKenney wrote:
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
> > that Will is looking to have the same effect as C11 memory_order_relaxed,
> > which is relaxed in this sense.  If he has something else in mind,
> > he needs to tell us what it is and why.  ;-)
> 
> I was treating them purely as being single-copy atomic and not providing
> any memory ordering guarantees (much like the non *_return atomic operations
> that we already have). I think this lines up with C11, minus the bits
> about data races which we don't call out anyway.

As long as it is single-copy atomic and not multi-copy atomic, I believe
we are on the saem page.  We have slowly been outlawing some sorts of
data races over the past few years, and I would guess that this will
continue, expecially if good tooling emerges (and KTSAN is showing some
promise from what I can see).

							Thanx, Paul
