Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 712941A1199
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  2 Oct 2015 05:41:06 +1000 (AEST)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Thu, 1 Oct 2015 13:41:04 -0600
Received: from b03cxnp08028.gho.boulder.ibm.com
 (b03cxnp08028.gho.boulder.ibm.com [9.17.130.20])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 125BA19D8045
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Oct 2015 13:29:14 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t91Jdna07143684
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Oct 2015 12:39:49 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t91Jex2S024807
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 1 Oct 2015 13:41:01 -0600
Date: Thu, 1 Oct 2015 12:41:00 -0700
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
Message-ID: <20151001194100.GL4043@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20151001182309.GY3816@twins.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151001182309.GY3816@twins.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 01, 2015 at 08:23:09PM +0200, Peter Zijlstra wrote:
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
> > that Will is looking to have the same effect as C11 memory_order_relaxed,
> > which is relaxed in this sense.  If he has something else in mind,
> > he needs to tell us what it is and why.  ;-)
> 
> I suspect he is; but I'm not _that_ up to date on the whole C11 stuff.

Lucky you!  ;-)

							Thanx, Paul
