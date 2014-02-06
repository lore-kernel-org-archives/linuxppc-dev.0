Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 5CC8C2C0084
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Feb 2014 03:38:47 +1100 (EST)
Date: Thu, 6 Feb 2014 17:38:37 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Torsten Duwe <duwe@lst.de>
Subject: Re: [PATCH] Convert powerpc simple spinlocks into ticket locks
Message-ID: <20140206163837.GT2936@laptop.programming.kicks-ass.net>
References: <20140206103736.GA18054@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20140206103736.GA18054@lst.de>
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

On Thu, Feb 06, 2014 at 11:37:37AM +0100, Torsten Duwe wrote:
> x86 has them, MIPS has them, ARM has them, even ia64 has them:
> ticket locks. They reduce memory bus and cache pressure especially
> for contended spinlocks, increasing performance.
> 
> This patch is a port of the x86 spin locks, mostly written in C,
> to the powerpc, introducing inline asm where needed. The pSeries
> directed yield for vCPUs is taken care of by an additional "holder"
> field in the lock.
> 

A few questions; what's with the ppc64 holder thing? Not having a 32bit
spinlock_t is sad.

Can you pair lwarx with sthcx ? I couldn't immediately find the answer
in the PowerISA doc. If so I think you can do better by being able to
atomically load both tickets but only storing the head without affecting
the tail.

In that case you can avoid the ll/sc on unlock, because only the lock
owner can modify the tail, so you can use a single half-word store.
