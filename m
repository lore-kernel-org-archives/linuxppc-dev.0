Return-Path: <peterz@infradead.org>
Received: from bombadil.infradead.org (bombadil.infradead.org
 [IPv6:2001:1868:205::9])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 204951A0541
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 29 Aug 2015 01:39:39 +1000 (AEST)
Date: Fri, 28 Aug 2015 17:39:21 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC 3/5] powerpc: atomic: implement
 atomic{,64}_{add,sub}_return_* variants
Message-ID: <20150828153921.GF19282@twins.programming.kicks-ass.net>
References: <1440730099-29133-1-git-send-email-boqun.feng@gmail.com>
 <1440730099-29133-4-git-send-email-boqun.feng@gmail.com>
 <20150828104854.GB16853@twins.programming.kicks-ass.net>
 <20150828120614.GC29325@fixme-laptop.cn.ibm.com>
 <20150828141602.GA924@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150828141602.GA924@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 28, 2015 at 10:16:02PM +0800, Boqun Feng wrote:
> On Fri, Aug 28, 2015 at 08:06:14PM +0800, Boqun Feng wrote:
> > Hi Peter,
> > 
> > On Fri, Aug 28, 2015 at 12:48:54PM +0200, Peter Zijlstra wrote:
> > > On Fri, Aug 28, 2015 at 10:48:17AM +0800, Boqun Feng wrote:
> > > > +/*
> > > > + * Since {add,sub}_return_relaxed and xchg_relaxed are implemented with
> > > > + * a "bne-" instruction at the end, so an isync is enough as a acquire barrier
> > > > + * on the platform without lwsync.
> > > > + */
> > > > +#ifdef CONFIG_SMP
> > > > +#define smp_acquire_barrier__after_atomic() \
> > > > +	__asm__ __volatile__(PPC_ACQUIRE_BARRIER : : : "memory")
> > > > +#else
> > > > +#define smp_acquire_barrier__after_atomic() barrier()
> > > > +#endif
> > > > +#define arch_atomic_op_acquire(op, args...)				\
> > > > +({									\
> > > > +	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
> > > > +	smp_acquire_barrier__after_atomic();				\
> > > > +	__ret;								\
> > > > +})
> > > > +
> > > > +#define arch_atomic_op_release(op, args...)				\
> > > > +({									\
> > > > +	smp_lwsync();							\
> > > > +	op##_relaxed(args);						\
> > > > +})
> > > 
> > > Urgh, so this is RCpc. We were trying to get rid of that if possible.
> > > Lets wait until that's settled before introducing more of it.
> > > 
> > > lkml.kernel.org/r/20150820155604.GB24100@arm.com
> > 
> > OK, get it. Thanks.
> > 
> > So I'm not going to introduce these arch specific macros, I think what I
> > need to implement are just _relaxed variants and cmpxchg_acquire.
> 
> Ah.. just read through the thread you mentioned, I might misunderstand
> you, probably because I didn't understand RCpc well..
> 
> You are saying that in a RELEASE we -might- switch from smp_lwsync() to
> smp_mb() semantically, right? I guess this means we -might- switch from
> RCpc to RCsc, right?
> 
> If so, I think I'd better to wait until we have a conclusion for this.

Yes, the difference between RCpc and RCsc is in the meaning of RELEASE +
ACQUIRE. With RCsc that implies a full memory barrier, with RCpc it does
not.

Currently PowerPC is the only arch that (can, and) does RCpc and gives a
weaker RELEASE + ACQUIRE. Only the CPU who did the ACQUIRE is guaranteed
to see the stores of the CPU which did the RELEASE in order.

As it stands, RCU is the only _known_ codebase where this matters, but
we did in fact write code for a fair number of years 'assuming' RELEASE
+ ACQUIRE was a full barrier, so who knows what else is out there.


RCsc - release consistency sequential consistency
RCpc - release consistency processor consistency

https://en.wikipedia.org/wiki/Processor_consistency (where they have
s/sequential/causal/)
