Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 5659E1A03BF
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 20:14:37 +1100 (AEDT)
Date: Mon, 2 Nov 2015 10:14:24 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH powerpc/next 1/2] powerpc: Make value-returning atomics
 fully ordered
Message-ID: <20151102091424.GI17308@twins.programming.kicks-ass.net>
References: <1446427832-8742-1-git-send-email-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446427832-8742-1-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 02, 2015 at 09:30:31AM +0800, Boqun Feng wrote:
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

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
