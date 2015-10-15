Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id EAC141A0396
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 15 Oct 2015 21:35:50 +1100 (AEDT)
Date: Thu, 15 Oct 2015 11:35:44 +0100
From: Will Deacon <will.deacon@arm.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Peter Zijlstra <peterz@infradead.org>,
 Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Message-ID: <20151015103510.GA27524@arm.com>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151014210419.GY3604@twins.programming.kicks-ass.net>
 <20151014214453.GC3910@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151014214453.GC3910@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Dammit guys, it's never simple is it?

On Wed, Oct 14, 2015 at 02:44:53PM -0700, Paul E. McKenney wrote:
> To that end, the herd tool can make a diagram of what it thought
> happened, and I have attached it.  I used this diagram to try and force
> this scenario at https://www.cl.cam.ac.uk/~pes20/ppcmem/index.html#PPC,
> and succeeded.  Here is the sequence of events:
> 
> o	Commit P0's write.  The model offers to propagate this write
> 	to the coherence point and to P1, but don't do so yet.
> 
> o	Commit P1's write.  Similar offers, but don't take them up yet.
> 
> o	Commit P0's lwsync.
> 
> o	Execute P0's lwarx, which reads a=0.  Then commit it.
> 
> o	Commit P0's stwcx. as successful.  This stores a=1.

On arm64, this is a conditional-store-*release* and therefore cannot be
observed before the initial write to x...

> o	Commit P0's branch (not taken).
> 
> o	Commit P0's final register-to-register move.
> 
> o	Commit P1's sync instruction.
> 
> o	There is now nothing that can happen in either processor.
> 	P0 is done, and P1 is waiting for its sync.  Therefore,
> 	propagate P1's a=2 write to the coherence point and to
> 	the other thread.

... therefore this is illegal, because you haven't yet propagated that
prior write...

> 
> o	There is still nothing that can happen in either processor.
> 	So pick the barrier propagate, then the acknowledge sync.
> 
> o	P1 can now execute its read from x.  Because P0's write to
> 	x is still waiting to propagate to P1, this still reads
> 	x=0.  Execute and commit, and we now have both r3 registers
> 	equal to zero and the final value a=2.

... and P1 would have to read x == 1.

So arm64 is ok. Doesn't lwsync order store->store observability for PPC?

Will
