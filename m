Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8A3411A099E
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 20:14:44 +1100 (AEDT)
Date: Mon, 2 Nov 2015 10:14:40 +0100
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>, stable@vger.kernel.org
Subject: Re: [PATCH powerpc/next 2/2] powerpc: Make {cmp}xchg* and their
 atomic_ versions fully ordered
Message-ID: <20151102091440.GJ17308@twins.programming.kicks-ass.net>
References: <1446427832-8742-1-git-send-email-boqun.feng@gmail.com>
 <1446427832-8742-2-git-send-email-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1446427832-8742-2-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Nov 02, 2015 at 09:30:32AM +0800, Boqun Feng wrote:
> According to memory-barriers.txt, xchg*, cmpxchg* and their atomic_
> versions all need to be fully ordered, however they are now just
> RELEASE+ACQUIRE, which are not fully ordered.
> 
> So also replace PPC_RELEASE_BARRIER and PPC_ACQUIRE_BARRIER with
> PPC_ATOMIC_ENTRY_BARRIER and PPC_ATOMIC_EXIT_BARRIER in
> __{cmp,}xchg_{u32,u64} respectively to guarantee fully ordered semantics
> of atomic{,64}_{cmp,}xchg() and {cmp,}xchg(), as a complement of commit
> b97021f85517 ("powerpc: Fix atomic_xxx_return barrier semantics")
> 
> This patch depends on patch "powerpc: Make value-returning atomics fully
> ordered" for PPC_ATOMIC_ENTRY_BARRIER definition.
> 
> Cc: <stable@vger.kernel.org> # 3.4+
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
