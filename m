Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 338711A001B
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 16 Feb 2016 20:53:19 +1100 (AEDT)
Date: Tue, 16 Feb 2016 09:53:20 +0000
From: Will Deacon <will.deacon@arm.com>
To: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
Cc: Andy.Glew@imgtec.com, Leonid.Yegoshin@imgtec.com, peterz@infradead.org,
 linux-arch@vger.kernel.org, arnd@arndb.de, davem@davemloft.net,
 linux-arm-kernel@lists.infradead.org, linux-metag@vger.kernel.org,
 linux-mips@linux-mips.org, linux-xtensa@linux-xtensa.org,
 linuxppc-dev@lists.ozlabs.org, graham.whaley@gmail.com,
 torvalds@linux-foundation.org, hpa@zytor.com, mingo@kernel.org
Subject: Re: Writes, smp_wmb(), and transitivity?
Message-ID: <20160216095319.GA14509@arm.com>
References: <20160215175825.GA15878@linux.vnet.ibm.com>
 <20160215185832.GQ6298@arm.com>
 <20160215203512.GL6719@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20160215203512.GL6719@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Feb 15, 2016 at 12:35:12PM -0800, Paul E. McKenney wrote:
> On Mon, Feb 15, 2016 at 06:58:32PM +0000, Will Deacon wrote:
> > On Mon, Feb 15, 2016 at 09:58:25AM -0800, Paul E. McKenney wrote:
> > > Some architectures provide local transitivity for a chain of threads doing
> > > writes separated by smp_wmb(), as exemplified by the litmus tests below.
> > > The pattern is that each thread writes to a its own variable, does an
> > > smp_wmb(), then writes a different value to the next thread's variable.
> > > 
> > > I don't know of a use of this, but if everyone supports it, it might
> > > be good to mandate it.  Status quo is that smp_wmb() is non-transitive,
> > > so it currently isn't supported.
> > > 
> > > Anyone know of any architectures that do -not- support this?
> > > 
> > > Assuming all architectures -do- support this, any arguments -against-
> > > officially supporting it in Linux?
> > > 
> > > 							Thanx, Paul
> > > 
> > > ------------------------------------------------------------------------
> > > 
> > > Two threads:
> > > 
> > > 	int a, b;
> > > 
> > > 	void thread0(void)
> > > 	{
> > > 		WRITE_ONCE(a, 1);
> > > 		smp_wmb();
> > > 		WRITE_ONCE(b, 2);
> > > 	}
> > > 
> > > 	void thread1(void)
> > > 	{
> > > 		WRITE_ONCE(b, 1);
> > > 		smp_wmb();
> > > 		WRITE_ONCE(a, 2);
> > > 	}
> > > 
> > > 	/* After all threads have completed and the dust has settled... */
> > > 
> > > 	BUG_ON(a == 1 && b == 1);
> > 
> > My understanding is that this test, and the generalisation to n threads,
> > is forbidden on ARM. However, the transitivity of DMB ST (used to
> > construct smp_wmb()) has been the subject of long debates, because we
> > allow the following test:
> > 
> > 
> > P0:
> > Wx = 1
> > 
> > P1:
> > Rx == 1
> > DMB ST
> > Wy = 1
> > 
> > P2:
> > Ry == 1
> > <addr dep>
> > Rx == 0
> > 
> > 
> > so I'd be uneasy about saying "it's all transitive".
> 
> Agreed!  For one thing, doesn't DMB ST need writes on both sides?

Yes, but it's a common trap that people fall into where they think the
above is forbidden because the DMB ST in P1 should order P0's write
before its own write of y.

> But that is one reason that I am only semi-enthusiastic about this.
> The potentially locally transitive case is -very- restrictive, applying
> only to situations where -all- accesses are writes.

I think that we will confuse people more by trying to describe the
restricted case where we provide order than if we blanket say that its
not transitive. I know Linus prefers to be as strong as possible, but
this doesn't look like a realistic programming paradigm and having a
straightforward rule that "rmb and wmb are not transitive" is much
easier for people to deal with in my opinion.

Will
