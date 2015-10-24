Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 76DBC1A04D4
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 24 Oct 2015 21:26:40 +1100 (AEDT)
Date: Sat, 24 Oct 2015 12:26:27 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, Waiman Long <waiman.long@hp.com>,
 Davidlohr Bueso <dave@stgolabs.net>, stable@vger.kernel.org
Subject: Re: [PATCH tip/locking/core v4 1/6] powerpc: atomic: Make *xchg and
 *cmpxchg a full barrier
Message-ID: <20151024102627.GH17308@twins.programming.kicks-ass.net>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151020071532.GB17714@fixme-laptop.cn.ibm.com>
 <20151020092147.GX17308@twins.programming.kicks-ass.net>
 <20151020212835.GH5105@linux.vnet.ibm.com>
 <20151021084503.GE17714@fixme-laptop.cn.ibm.com>
 <20151021193523.GT5105@linux.vnet.ibm.com>
 <20151021194825.GH2508@worktop.programming.kicks-ass.net>
 <20151022120716.GA1481@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151022120716.GA1481@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Oct 22, 2015 at 08:07:16PM +0800, Boqun Feng wrote:
> On Wed, Oct 21, 2015 at 09:48:25PM +0200, Peter Zijlstra wrote:
> > On Wed, Oct 21, 2015 at 12:35:23PM -0700, Paul E. McKenney wrote:
> > > > > > > I ask this because I recall Peter once bought up a discussion:
> > > > > > > 
> > > > > > > https://lkml.org/lkml/2015/8/26/596
> > 
> > > > So a full barrier on one side of these operations is enough, I think.
> > > > IOW, there is no need to strengthen these operations.
> > > 
> > > Do we need to also worry about other futex use cases?
> > 
> > Worry, always!
> > 
> > But yes, there is one more specific usecase, which is that of a
> > condition variable.
> > 
> > When we go sleep on a futex, we might want to assume visibility of the
> > stores done by the thread that woke us by the time we wake up.
> > 
> 
> But the thing is futex atomics in PPC are already RELEASE(pc)+ACQUIRE
> and imply a full barrier, is an RELEASE(sc) semantics really needed
> here?

For this, no, the current code should be fine I think.

> Further more, is this condition variable visibility guaranteed by other
> part of futex? Because in futex_wake_op:
> 
> 	futex_wake_op()
> 	  ...
> 	  double_unlock_hb(hb1, hb2);  <- RELEASE(pc) barrier here.
> 	  wake_up_q(&wake_q);
> 
> and in futex_wait():
> 
> 	futex_wait()
> 	  ...
> 	  futex_wait_queue_me(hb, &q, to); <- schedule() here
> 	  ...
> 	  unqueue_me(&q)
> 	    drop_futex_key_refs(&q->key);
> 	    	iput()/mmdrop(); <- a full barrier
> 	  
> 
> The RELEASE(pc) barrier pairs with the full barrier, therefore the
> userspace wakee can observe the condition variable modification.

Right, futexes are a pain; and I think we all agreed we didn't want to
go rely on implementation details unless we absolutely _have_ to.

> > And.. aside from the thoughts I outlined in the email referenced above,
> > there is always the chance people accidentally rely on the strong
> > ordering on their x86 CPU and find things come apart when ran on their
> > ARM/MIPS/etc..
> > 
> > There are a fair number of people who use the raw futex call and we have
> > 0 visibility into many of them. The assumed and accidental ordering
> > guarantees will forever remain a mystery.
> > 
> 
> Understood. That's truely a potential problem. Considering not all the
> architectures imply a full barrier at user<->kernel boundries, maybe we
> can use one bit in the opcode of the futex system call to indicate
> whether userspace treats futex as fully ordered. Like:
> 
> #define FUTEX_ORDER_SEQ_CST  0
> #define FUTEX_ORDER_RELAXED  64 (bit 7 and bit 8 are already used)

Not unless there's an actual performance problem with any of this.
Futexes are painful enough as is.
