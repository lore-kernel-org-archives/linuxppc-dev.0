Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 827741A05AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 22:27:12 +1100 (AEDT)
In-Reply-To: <1446427832-8742-1-git-send-email-boqun.feng@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
Subject: Re: [powerpc/next,
 1/2] powerpc: Make value-returning atomics fully ordered
Message-Id: <20151215112712.6089E14031E@ozlabs.org>
Date: Tue, 15 Dec 2015 22:27:12 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-02-11 at 01:30:31 UTC, Boqun Feng wrote:
> According to memory-barriers.txt:
> 
> > Any atomic operation that modifies some state in memory and returns
> > information about the state (old or new) implies an SMP-conditional
> > general memory barrier (smp_mb()) on each side of the actual
> > operation ...
> 
> Which mean these operations should be fully ordered. However on PPC,
> PPC_ATOMIC_ENTRY_BARRIER is the barrier before the actual operation,
> which is currently "lwsync" if SMP=y. The leading "lwsync" can not
> guarantee fully ordered atomics, according to Paul Mckenney:
> 
> https://lkml.org/lkml/2015/10/14/970
> 
> To fix this, we define PPC_ATOMIC_ENTRY_BARRIER as "sync" to guarantee
> the fully-ordered semantics.
> 
> This also makes futex atomics fully ordered, which can avoid possible
> memory ordering problems if userspace code relies on futex system call
> for fully ordered semantics.
> 
> Cc: <stable@vger.kernel.org> # 3.4+
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/49e9cf3f0c04bf76ffa59242

cheers
