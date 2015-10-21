Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 045491A0174
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 21 Oct 2015 19:24:46 +1100 (AEDT)
Date: Wed, 21 Oct 2015 10:24:52 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Boqun Feng <boqun.feng@gmail.com>, Will Deacon <will.deacon@arm.com>,
 Michael Ellerman <mpe@ellerman.id.au>, linux-arch@vger.kernel.org,
 linux-kernel@vger.kernel.org, Anton Blanchard <anton@samba.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] barriers: introduce smp_mb__release_acquire and
 update documentation
Message-ID: <20151021082452.GC2881@worktop.programming.kicks-ass.net>
References: <20151007111915.GF17308@twins.programming.kicks-ass.net>
 <20151007132317.GK16065@arm.com>
 <20151007152501.GI3910@linux.vnet.ibm.com>
 <1444276236.9940.5.camel@ellerman.id.au>
 <20151008111638.GL3816@twins.programming.kicks-ass.net>
 <20151008214439.GE3910@linux.vnet.ibm.com>
 <20151009083138.GU3816@twins.programming.kicks-ass.net>
 <20151009094039.GD26278@arm.com>
 <20151019011718.GB924@fixme-laptop.cn.ibm.com>
 <20151020233451.GI5105@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20151020233451.GI5105@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Oct 20, 2015 at 04:34:51PM -0700, Paul E. McKenney wrote:
> There is also the question of whether the barrier forces ordering
> of unrelated stores, everything initially zero and all accesses
> READ_ONCE() or WRITE_ONCE():
> 
> 	P0		P1		P2		P3
> 	X = 1;		Y = 1;		r1 = X;		r3 = Y;
> 					some_barrier();	some_barrier();
> 					r2 = Y;		r4 = X;
> 
> P2's and P3's ordering could be globally visible without requiring
> P0's and P1's independent stores to be ordered, for example, if you
> used smp_rmb() for some_barrier().  In contrast, if we used smp_mb()
> for barrier, everyone would agree on the order of P0's and P0's stores.

Oh!?

> There are actually a fair number of different combinations of
> aspects of memory ordering.  We will need to choose wisely.  ;-)
> 
> My hope is that the store-ordering gets folded into the globally
> visible transitive level.  Especially given that I have not (yet)
> seen any algorithms used in production that relied on the ordering of
> independent stores.

I would hope not, that's quite insane.
