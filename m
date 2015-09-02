Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 4C55E1A1E38
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 20:50:08 +1000 (AEST)
Received: from /spool/local
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 2 Sep 2015 04:50:06 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 57B7019D8041
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 04:40:55 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t82Ao0Nm52363450
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Sep 2015 03:50:00 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t82AnwW5030259
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Sep 2015 04:50:00 -0600
Date: Wed, 2 Sep 2015 03:49:56 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Will Deacon <will.deacon@arm.com>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC 3/5] powerpc: atomic: implement
 atomic{,64}_{add,sub}_return_* variants
Message-ID: <20150902104956.GT4029@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1440730099-29133-1-git-send-email-boqun.feng@gmail.com>
 <1440730099-29133-4-git-send-email-boqun.feng@gmail.com>
 <20150828104854.GB16853@twins.programming.kicks-ass.net>
 <20150828120614.GC29325@fixme-laptop.cn.ibm.com>
 <20150828141602.GA924@fixme-laptop.cn.ibm.com>
 <20150828153921.GF19282@twins.programming.kicks-ass.net>
 <20150901190027.GP1612@arm.com>
 <20150901214540.GI4029@linux.vnet.ibm.com>
 <20150902095906.GC25720@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150902095906.GC25720@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Sep 02, 2015 at 10:59:06AM +0100, Will Deacon wrote:
> Hi Paul,
> 
> On Tue, Sep 01, 2015 at 10:45:40PM +0100, Paul E. McKenney wrote:
> > On Tue, Sep 01, 2015 at 08:00:27PM +0100, Will Deacon wrote:
> > > On Fri, Aug 28, 2015 at 04:39:21PM +0100, Peter Zijlstra wrote:
> > > > Yes, the difference between RCpc and RCsc is in the meaning of RELEASE +
> > > > ACQUIRE. With RCsc that implies a full memory barrier, with RCpc it does
> > > > not.
> > > 
> > > We've discussed this before, but for the sake of completeness, I don't
> > > think we're fully RCsc either because we don't order the actual RELEASE
> > > operation again a subsequent ACQUIRE operation:
> > > 
> > > P0
> > > smp_store_release(&x, 1);
> > > foo = smp_load_acquire(&y);
> > > 
> > > P1
> > > smp_store_release(&y, 1);
> > > bar = smp_load_acquire(&x);
> > > 
> > > We allow foo == bar == 0, which is prohibited by SC.
> > 
> > I certainly hope that no one expects foo == bar == 0 to be prohibited!!!
> 
> I just thought it was worth making this point, because it is prohibited
> in SC and I don't want people to think that our RELEASE/ACQUIRE operations
> are SC (even though they happen to be on arm64).

OK, good.

> > On the other hand, in this case, foo == bar == 1 will be prohibited:
> > 
> > P0
> > foo = smp_load_acquire(&y);
> > smp_store_release(&x, 1);
> > 
> > P1
> > bar = smp_load_acquire(&x);
> > smp_store_release(&y, 1);
> 
> Agreed.

Good as well.

> > > However, we *do* enforce ordering on any prior or subsequent accesses
> > > for the code snippet above (the release and acquire combine to give a
> > > full barrier), which makes these primitives well suited to things like
> > > message passing.
> > 
> > If I understand your example correctly, neither x86 nor Power implement
> > a full barrier in this case.  For example:
> > 
> > 	P0
> > 	WRITE_ONCE(a, 1);
> > 	smp_store_release(b, 1);
> > 	r1 = smp_load_acquire(c);
> > 	r2 = READ_ONCE(d);
> > 
> > 	P1
> > 	WRITE_ONCE(d, 1);
> > 	smp_mb();
> > 	r3 = READ_ONCE(a);
> > 
> > Both x86 and Power can reorder P0 as follows:
> > 
> > 	P0
> > 	r1 = smp_load_acquire(c);
> > 	r2 = READ_ONCE(d);
> > 	WRITE_ONCE(a, 1);
> > 	smp_store_release(b, 1);
> > 
> > Which clearly shows that the non-SC outcome r2 == 0 && r3 == 0 is allowed.
> > 
> > Or am I missing your point here?
> 
> I think this example is slightly different. Having the RELEASE/ACQUIRE
> operations being reordered with respect to each other is one thing, but
> I thought we were heading in a direction where they combined to give a
> full barrier with respect to other accesses. In that case, the reordering
> above would be forbidden.

It is certainly less added overhead to make unlock-lock a full barrier
than it is to make smp_store_release()-smp_load_acquire() a full barrier.
I am not fully convinced on either, aside from needing some way to make
unlock-lock a full barrier within the RCU implementation, for which the
now-privatized smp_mb__after_unlock_lock() suffices.

> Peter -- if the above reordering can happen on x86, then moving away
> from RCpc is going to be less popular than I hoped...

;-)

							Thanx, Paul
