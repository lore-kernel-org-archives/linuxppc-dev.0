Return-Path: <will.deacon@arm.com>
Received: from foss.arm.com (foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 1A7891A0997
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 14 Oct 2015 00:21:35 +1100 (AEDT)
Date: Tue, 13 Oct 2015 14:21:32 +0100
From: Will Deacon <will.deacon@arm.com>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Peter Zijlstra <peterz@infradead.org>, Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>, Davidlohr Bueso <dave@stgolabs.net>
Subject: Re: [PATCH v3 4/6] powerpc: atomic: Implement atomic{, 64}_*_return_*
 variants
Message-ID: <20151013132132.GH21550@arm.com>
References: <1444659246-24769-1-git-send-email-boqun.feng@gmail.com>
 <1444659246-24769-5-git-send-email-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1444659246-24769-5-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Oct 12, 2015 at 10:14:04PM +0800, Boqun Feng wrote:
> On powerpc, acquire and release semantics can be achieved with
> lightweight barriers("lwsync" and "ctrl+isync"), which can be used to
> implement __atomic_op_{acquire,release}.
> 
> For release semantics, since we only need to ensure all memory accesses
> that issue before must take effects before the -store- part of the
> atomics, "lwsync" is what we only need. On the platform without
> "lwsync", "sync" should be used. Therefore, smp_lwsync() is used here.
> 
> For acquire semantics, "lwsync" is what we only need for the similar
> reason.  However on the platform without "lwsync", we can use "isync"
> rather than "sync" as an acquire barrier. So a new kind of barrier
> smp_acquire_barrier__after_atomic() is introduced, which is barrier() on
> UP, "lwsync" if available and "isync" otherwise.
> 
> __atomic_op_fence is defined as smp_lwsync() + _relaxed +
> smp_mb__after_atomic() to guarantee a full barrier.
> 
> Implement atomic{,64}_{add,sub,inc,dec}_return_relaxed, and build other
> variants with these helpers.
> 
> Signed-off-by: Boqun Feng <boqun.feng@gmail.com>
> ---
>  arch/powerpc/include/asm/atomic.h | 122 +++++++++++++++++++++++++-------------
>  1 file changed, 80 insertions(+), 42 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/atomic.h b/arch/powerpc/include/asm/atomic.h
> index 55f106e..3143af9 100644
> --- a/arch/powerpc/include/asm/atomic.h
> +++ b/arch/powerpc/include/asm/atomic.h
> @@ -12,6 +12,39 @@
>  
>  #define ATOMIC_INIT(i)		{ (i) }
>  
> +/*
> + * Since {add,sub}_return_relaxed and xchg_relaxed are implemented with
> + * a "bne-" instruction at the end, so an isync is enough as a acquire barrier
> + * on the platform without lwsync.
> + */
> +#ifdef CONFIG_SMP
> +#define smp_acquire_barrier__after_atomic() \
> +	__asm__ __volatile__(PPC_ACQUIRE_BARRIER : : : "memory")

I'm not keen on this barrier, as it sounds like it's part of the kernel
memory model, as opposed to an implementation detail on PowerPC (and
we've already got enough of that in the generic code ;).

Can you name it something different please (and maybe #undef it when
you're done)?

Will
