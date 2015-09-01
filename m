Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B3ADA1A1E05
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Sep 2015 07:45:55 +1000 (AEST)
Received: from /spool/local
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Tue, 1 Sep 2015 15:45:52 -0600
Received: from b03cxnp08026.gho.boulder.ibm.com
 (b03cxnp08026.gho.boulder.ibm.com [9.17.130.18])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 7B5661FF004A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  1 Sep 2015 15:36:54 -0600 (MDT)
Received: from d03av04.boulder.ibm.com (d03av04.boulder.ibm.com [9.17.195.170])
 by b03cxnp08026.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t81LixYB43712522
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Sep 2015 14:44:59 -0700
Received: from d03av04.boulder.ibm.com (loopback [127.0.0.1])
 by d03av04.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t81LjhQf018977
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 1 Sep 2015 15:45:44 -0600
Date: Tue, 1 Sep 2015 14:45:40 -0700
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
Message-ID: <20150901214540.GI4029@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <1440730099-29133-1-git-send-email-boqun.feng@gmail.com>
 <1440730099-29133-4-git-send-email-boqun.feng@gmail.com>
 <20150828104854.GB16853@twins.programming.kicks-ass.net>
 <20150828120614.GC29325@fixme-laptop.cn.ibm.com>
 <20150828141602.GA924@fixme-laptop.cn.ibm.com>
 <20150828153921.GF19282@twins.programming.kicks-ass.net>
 <20150901190027.GP1612@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20150901190027.GP1612@arm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Sep 01, 2015 at 08:00:27PM +0100, Will Deacon wrote:
> On Fri, Aug 28, 2015 at 04:39:21PM +0100, Peter Zijlstra wrote:
> > On Fri, Aug 28, 2015 at 10:16:02PM +0800, Boqun Feng wrote:
> > > Ah.. just read through the thread you mentioned, I might misunderstand
> > > you, probably because I didn't understand RCpc well..
> > > 
> > > You are saying that in a RELEASE we -might- switch from smp_lwsync() to
> > > smp_mb() semantically, right? I guess this means we -might- switch from
> > > RCpc to RCsc, right?
> > > 
> > > If so, I think I'd better to wait until we have a conclusion for this.
> > 
> > Yes, the difference between RCpc and RCsc is in the meaning of RELEASE +
> > ACQUIRE. With RCsc that implies a full memory barrier, with RCpc it does
> > not.
> 
> We've discussed this before, but for the sake of completeness, I don't
> think we're fully RCsc either because we don't order the actual RELEASE
> operation again a subsequent ACQUIRE operation:
> 
> P0
> smp_store_release(&x, 1);
> foo = smp_load_acquire(&y);
> 
> P1
> smp_store_release(&y, 1);
> bar = smp_load_acquire(&x);
> 
> We allow foo == bar == 0, which is prohibited by SC.

I certainly hope that no one expects foo == bar == 0 to be prohibited!!!

On the other hand, in this case, foo == bar == 1 will be prohibited:

P0
foo = smp_load_acquire(&y);
smp_store_release(&x, 1);

P1
bar = smp_load_acquire(&x);
smp_store_release(&y, 1);

> However, we *do* enforce ordering on any prior or subsequent accesses
> for the code snippet above (the release and acquire combine to give a
> full barrier), which makes these primitives well suited to things like
> message passing.

If I understand your example correctly, neither x86 nor Power implement
a full barrier in this case.  For example:

	P0
	WRITE_ONCE(a, 1);
	smp_store_release(b, 1);
	r1 = smp_load_acquire(c);
	r2 = READ_ONCE(d);

	P1
	WRITE_ONCE(d, 1);
	smp_mb();
	r3 = READ_ONCE(a);

Both x86 and Power can reorder P0 as follows:

	P0
	r1 = smp_load_acquire(c);
	r2 = READ_ONCE(d);
	WRITE_ONCE(a, 1);
	smp_store_release(b, 1);

Which clearly shows that the non-SC outcome r2 == 0 && r3 == 0 is allowed.

Or am I missing your point here?

							Thanx, Paul
