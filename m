Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 258DF2C00B1
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 05:08:34 +1100 (EST)
Date: Thu, 6 Feb 2014 19:08:26 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH] Convert powerpc simple spinlocks into ticket locks
Message-ID: <20140206180826.GI5002@laptop.programming.kicks-ass.net>
References: <20140206103736.GA18054@lst.de>
 <20140206163837.GT2936@laptop.programming.kicks-ass.net>
 <20140206173727.GA13048@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140206173727.GA13048@lst.de>
Cc: linux-kernel@vger.kernel.org, Paul Mackerras <paulus@samba.org>,
 Anton Blanchard <anton@samba.org>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Feb 06, 2014 at 06:37:27PM +0100, Torsten Duwe wrote:
> On Thu, Feb 06, 2014 at 05:38:37PM +0100, Peter Zijlstra wrote:
> > On Thu, Feb 06, 2014 at 11:37:37AM +0100, Torsten Duwe wrote:
> > > x86 has them, MIPS has them, ARM has them, even ia64 has them:
> > > ticket locks. They reduce memory bus and cache pressure especially
> > > for contended spinlocks, increasing performance.
> > > 
> > > This patch is a port of the x86 spin locks, mostly written in C,
> > > to the powerpc, introducing inline asm where needed. The pSeries
> > > directed yield for vCPUs is taken care of by an additional "holder"
> > > field in the lock.
> > > 
> > 
> > A few questions; what's with the ppc64 holder thing? Not having a 32bit
> > spinlock_t is sad.
> 
> I must admit that I haven't tested the patch on non-pseries ppc64 nor on
> ppc32. Only ppc64 has the ldarx and I tried to atomically replace the 
> holder along with the locks. That might prove unneccessary.

But what is the holder for? Can't we do away with that field?

> > Can you pair lwarx with sthcx ? I couldn't immediately find the answer
> > in the PowerISA doc. If so I think you can do better by being able to
> > atomically load both tickets but only storing the head without affecting
> > the tail.
> 
> V2.06b, Book II, Chapter 3, "sthcx" says:
> | If a reservation exists and the length associated [...] is not 2 bytes,
> | it is undefined whether (RS)_48:63 are stored [...]
> 
> That doesn't make me feel comfortable :(

That's on page 692, right? The way I read that is of the lharx/sthcx
don't have the exact same address, storage is undefined. But I can't
find mention of non-matching load and store size, although I can imagine
it being the same undefined.
