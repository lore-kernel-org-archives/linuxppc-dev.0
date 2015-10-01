Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e33.co.us.ibm.com (e33.co.us.ibm.com [32.97.110.151])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 15C621A02FA
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 01:09:27 +1000 (AEST)
Received: from localhost
 by e33.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 1 Oct 2015 09:09:25 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 67EDA1FF0045
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 08:57:22 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t91F99Rx9503078
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Oct 2015 08:09:09 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t91F982r021121
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Oct 2015 09:09:09 -0600
Date: Thu, 1 Oct 2015 08:09:09 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC v2 4/7] powerpc: atomic: Implement xchg_* and
 atomic{,64}_xchg_* variants
Message-ID: <20151001150909.GC4043@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1442418575-12297-1-git-send-email-boqun.feng@gmail.com>
 <1442418575-12297-5-git-send-email-boqun.feng@gmail.com>
 <20151001122440.GP2881@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151001122440.GP2881@worktop.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 01, 2015 at 02:24:40PM +0200, Peter Zijlstra wrote:
> On Wed, Sep 16, 2015 at 11:49:32PM +0800, Boqun Feng wrote:
> > Implement xchg_relaxed and define atomic{,64}_xchg_* as xchg_relaxed,
> > based on these _relaxed variants, release/acquire variants can be built.
> > 
> > Note that xchg_relaxed and atomic_{,64}_xchg_relaxed are not compiler
> > barriers.
> 
> Hmm, and I note your previous patch creating the regular _relaxed
> thingies also removes the memory clobber.
> 
> And looking at the ARM _relaxed patch from Will, I see their _relaxed
> ops are also not a compiler barrier.
> 
> I must say I'm somewhat surprised by this level of relaxation, I had
> expected to only loose SMP barriers, not the program order ones.
> 
> Is there a good argument for this?

Yes, when we say "relaxed", we really mean relaxed.  ;-)

Both the CPU and the compiler are allowed to reorder around relaxed
operations.

							Thanx, Paul
