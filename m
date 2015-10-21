Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 2E4E21A0456
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 22 Oct 2015 06:29:22 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Wed, 21 Oct 2015 13:29:20 -0600
Received: from b03cxnp08025.gho.boulder.ibm.com
 (b03cxnp08025.gho.boulder.ibm.com [9.17.130.17])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 39E641FF0046
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 13:17:31 -0600 (MDT)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp08025.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id t9LJRvNE11076006
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 12:27:57 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t9LJTHEm021875
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 13:29:18 -0600
Date: Wed, 21 Oct 2015 12:29:23 -0700
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Peter Zijlstra <peterz@infradead.org>
Cc: Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will.deacon@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Message-ID: <20151021192923.GR5105@linux.vnet.ibm.com>
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
 <20151021082452.GC2881@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151021082452.GC2881@worktop.programming.kicks-ass.net>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, Oct 21, 2015 at 10:24:52AM +0200, Peter Zijlstra wrote:
> On Tue, Oct 20, 2015 at 04:34:51PM -0700, Paul E. McKenney wrote:
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
> 
> Oh!?

Behold sequential consistency, worshipped fervently by a surprisingly
large number of people!  Something about legacy proof methods, as near
as I can tell.  ;-)

> > There are actually a fair number of different combinations of
> > aspects of memory ordering.  We will need to choose wisely.  ;-)
> > 
> > My hope is that the store-ordering gets folded into the globally
> > visible transitive level.  Especially given that I have not (yet)
> > seen any algorithms used in production that relied on the ordering of
> > independent stores.
> 
> I would hope not, that's quite insane.

Your point being?  ;-)

							Thanx, Paul
