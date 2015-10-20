Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id DDB0B1A02CD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 20 Oct 2015 20:22:10 +1100 (AEDT)
Date: Tue, 20 Oct 2015 11:21:47 +0200
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
Message-ID: <20151020092147.GX17308@twins.programming.kicks-ass.net>
References: <1444838161-17209-1-git-send-email-boqun.feng@gmail.com>
 <1444838161-17209-2-git-send-email-boqun.feng@gmail.com>
 <20151014201916.GB3910@linux.vnet.ibm.com>
 <20151020071532.GB17714@fixme-laptop.cn.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151020071532.GB17714@fixme-laptop.cn.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 20, 2015 at 03:15:32PM +0800, Boqun Feng wrote:
> On Wed, Oct 14, 2015 at 01:19:17PM -0700, Paul E. McKenney wrote:
> > 
> > Am I missing something here?  If not, it seems to me that you need
> > the leading lwsync to instead be a sync.
> > 
> > Of course, if I am not missing something, then this applies also to the
> > value-returning RMW atomic operations that you pulled this pattern from.
> > If so, it would seem that I didn't think through all the possibilities
> > back when PPC_ATOMIC_EXIT_BARRIER moved to sync...  In fact, I believe
> > that I worried about the RMW atomic operation acting as a barrier,
> > but not as the load/store itself.  :-/
> > 
> 
> Paul, I know this may be difficult, but could you recall why the
> __futex_atomic_op() and futex_atomic_cmpxchg_inatomic() also got
> involved into the movement of PPC_ATOMIC_EXIT_BARRIER to "sync"?
> 
> I did some search, but couldn't find the discussion of that patch.
> 
> I ask this because I recall Peter once bought up a discussion:
> 
> https://lkml.org/lkml/2015/8/26/596
> 
> Peter's conclusion seems to be that we could(though didn't want to) live
> with futex atomics not being full barriers.
> 
> 
> Peter, just be clear, I'm not in favor of relaxing futex atomics. But if
> I make PPC_ATOMIC_ENTRY_BARRIER being "sync", it will also strengthen
> the futex atomics, just wonder whether such strengthen is a -fix- or
> not, considering that I want this patch to go to -stable tree.

So Linus' argued that since we only need to order against user accesses
(true) and priv changes typically imply strong barriers (open) we might
want to allow archs to rely on those instead of mandating they have
explicit barriers in the futex primitives.

And I indeed forgot to follow up on that discussion.

So; does PPC imply full barriers on user<->kernel boundaries? If so, its
not critical to the futex atomic implementations what extra barriers are
added.

If not; then strengthening the futex ops is indeed (probably) a good
thing :-)
