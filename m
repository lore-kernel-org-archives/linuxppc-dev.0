Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 05E121A05AA
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 15 Dec 2015 22:27:12 +1100 (AEDT)
In-Reply-To: <1446427832-8742-2-git-send-email-boqun.feng@gmail.com>
To: Boqun Feng <boqun.feng@gmail.com>, linux-kernel@vger.kernel.org,
 linuxppc-dev@lists.ozlabs.org
From: Michael Ellerman <mpe@ellerman.id.au>
Cc: Peter Zijlstra <peterz@infradead.org>, Boqun Feng <boqun.feng@gmail.com>,
 Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org,
 Paul Mackerras <paulus@samba.org>, Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Ingo Molnar <mingo@kernel.org>
Subject: Re: [powerpc/next,
 2/2] powerpc: Make {cmp}xchg* and their atomic_ versions fully ordered
Message-Id: <20151215112711.94D37140B04@ozlabs.org>
Date: Tue, 15 Dec 2015 22:27:11 +1100 (AEDT)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 2015-02-11 at 01:30:32 UTC, Boqun Feng wrote:
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
> Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>
> Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>

Applied to powerpc next, thanks.

https://git.kernel.org/powerpc/c/81d7a3294de7e9828310bbf9

cheers
