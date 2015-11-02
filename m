Return-Path: <paulmck@linux.vnet.ibm.com>
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 422611A03C6
 for <linuxppc-dev@lists.ozlabs.org>; Mon,  2 Nov 2015 13:25:53 +1100 (AEDT)
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <paulmck@linux.vnet.ibm.com>;
 Sun, 1 Nov 2015 19:25:51 -0700
Received: from b03cxnp07029.gho.boulder.ibm.com
 (b03cxnp07029.gho.boulder.ibm.com [9.17.130.16])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id E3F7F19D8042
 for <linuxppc-dev@lists.ozlabs.org>; Sun,  1 Nov 2015 19:13:57 -0700 (MST)
Received: from d03av05.boulder.ibm.com (d03av05.boulder.ibm.com [9.17.195.85])
 by b03cxnp07029.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with
 ESMTP id tA22PmmK11927998
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 1 Nov 2015 19:25:48 -0700
Received: from d03av05.boulder.ibm.com (localhost [127.0.0.1])
 by d03av05.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 tA22PlWe018194
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 1 Nov 2015 19:25:48 -0700
Date: Sun, 1 Nov 2015 18:26:02 -0800
From: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 Will Deacon <will.deacon@arm.com>, stable@vger.kernel.org
Subject: Re: [PATCH powerpc/next 1/2] powerpc: Make value-returning atomics
 fully ordered
Message-ID: <20151102022602.GL4122@linux.vnet.ibm.com>
Reply-To: paulmck@linux.vnet.ibm.com
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

Reviewed-by: Paul E. McKenney <paulmck@linux.vnet.ibm.com>

> ---
> These two are separated and splited from the patchset of powerpc atomic
> variants implementation, whose link is:
> 
> https://lkml.org/lkml/2015/10/26/141
> 
> Based on next branch of powerpc tree, tested by 0day.
> 
>  arch/powerpc/include/asm/synch.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/synch.h b/arch/powerpc/include/asm/synch.h
> index e682a71..c508686 100644
> --- a/arch/powerpc/include/asm/synch.h
> +++ b/arch/powerpc/include/asm/synch.h
> @@ -44,7 +44,7 @@ static inline void isync(void)
>  	MAKE_LWSYNC_SECTION_ENTRY(97, __lwsync_fixup);
>  #define PPC_ACQUIRE_BARRIER	 "\n" stringify_in_c(__PPC_ACQUIRE_BARRIER)
>  #define PPC_RELEASE_BARRIER	 stringify_in_c(LWSYNC) "\n"
> -#define PPC_ATOMIC_ENTRY_BARRIER "\n" stringify_in_c(LWSYNC) "\n"
> +#define PPC_ATOMIC_ENTRY_BARRIER "\n" stringify_in_c(sync) "\n"
>  #define PPC_ATOMIC_EXIT_BARRIER	 "\n" stringify_in_c(sync) "\n"
>  #else
>  #define PPC_ACQUIRE_BARRIER
> -- 
> 2.6.2
> 
