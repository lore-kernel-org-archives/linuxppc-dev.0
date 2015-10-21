Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e36.co.us.ibm.com (e36.co.us.ibm.com [32.97.110.154])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id B35F61A0329
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 06:34:23 +1100 (AEDT)
Received: from localhost
 by e36.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 21 Oct 2015 13:34:21 -0600
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id 163F919D8048
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 13:22:28 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t9LJYHVZ12452110
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 12:34:17 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9LJYGSt012469
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 13:34:17 -0600
Date: Wed, 21 Oct 2015 12:34:22 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: David Laight <David.Laight@ACULAB.COM>
Cc: Boqun Feng <boqun.feng@gmail.com>,
 "linux-arch@vger.kernel.org" <linux-arch@vger.kernel.org>,
 Peter Zijlstra <peterz@infradead.org>, Will Deacon <will.deacon@arm.com>,
 "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
 Paul Mackerras <paulus@samba.org>, Anton Blanchard <anton@samba.org>,
 "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Message-ID: <20151021193422.GS5105@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
References: <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008214439.GE3910@linux.vnet.ibm.com>
 <20151009083138.GU3816@twins.programming.kicks-ass.net>
 <20151009094039.GD26278@arm.com>
 <20151019011718.GB924@fixme-laptop.cn.ibm.com>
 <20151020233451.GI5105@linux.vnet.ibm.com>
 <063D6719AE5E284EB5DD2968C1650D6D1CBBD844@AcuExch.aculab.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <063D6719AE5E284EB5DD2968C1650D6D1CBBD844@AcuExch.aculab.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 21, 2015 at 04:04:04PM +0000, David Laight wrote:
> From: Paul E. McKenney
> > Sent: 21 October 2015 00:35
> ...
> > There is also the question of whether the barrier forces ordering
> > of unrelated stores, everything initially zero and all accesses
> > READ_ONCE() or WRITE_ONCE():
> > 
> > 	P0		P1		P2		P3
> > 	X = 1;		Y = 1;		r1 = X;		r3 = Y;
> > 					some_barrier();	some_barrier();
> > 					r2 = Y;		r4 = X;
> > 
> > P2's and P3's ordering could be globally visible without requiring
> > P0's and P1's independent stores to be ordered, for example, if you
> > used smp_rmb() for some_barrier().  In contrast, if we used smp_mb()
> > for barrier, everyone would agree on the order of P0's and P0's stores.
> > 
> > There are actually a fair number of different combinations of
> > aspects of memory ordering.  We will need to choose wisely.  ;-)
> 
> My thoughts on this are that most code probably isn't performance critical
> enough to be using anything other than normal locks for inter-cpu
> synchronisation.
> Certainly most people are likely to get it wrong somewhere.
> So you want a big red sticker saying 'Don't try to be too clever'.

I am afraid that I would run out of red stickers rather quickly,
given the large number of ways that one can shoot oneself in the
foot, even when single-threaded.

> Also without examples of why things go wrong (eg member_consumer()
> and alpha) it is difficult to understand the differences between
> all the barriers (etc).

Not just the hardware peculiarities.  It is also important to understand
the common use cases.

> OTOH device driver code may need things slightly stronger than
> barrier() (which I think is asm(:::"memory")) to sequence accesses
> to hardware devices (and memory the hardware reads), but without
> having a strong barrier in every ioread/write() access.

There are more memory models than you can shake a stick at, so yes,
we do have to choose carefully.  And yes, it does get more complex
when you add MMIO, and no, I don't know of any formal model that
takes MMIO into account.

							Thanx, Paul
