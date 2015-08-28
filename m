Return-Path: <peterz@infradead.org>
Received: from casper.infradead.org (casper.infradead.org
 [IPv6:2001:770:15f::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8CA041A01ED
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 28 Aug 2015 20:49:11 +1000 (AEST)
Date: Fri, 28 Aug 2015 12:48:54 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Boqun Feng <boqun.feng@gmail.com>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Ingo Molnar <mingo@kernel.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Thomas Gleixner <tglx@linutronix.de>, Will Deacon <will.deacon@arm.com>,
 "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Waiman Long <waiman.long@hp.com>
Subject: Re: [RFC 3/5] powerpc: atomic: implement
 atomic{,64}_{add,sub}_return_* variants
Message-ID: <20150828104854.GB16853@twins.programming.kicks-ass.net>
References: <1440730099-29133-1-git-send-email-boqun.feng@gmail.com>
 <1440730099-29133-4-git-send-email-boqun.feng@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1440730099-29133-4-git-send-email-boqun.feng@gmail.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Fri, Aug 28, 2015 at 10:48:17AM +0800, Boqun Feng wrote:
> +/*
> + * Since {add,sub}_return_relaxed and xchg_relaxed are implemented with
> + * a "bne-" instruction at the end, so an isync is enough as a acquire barrier
> + * on the platform without lwsync.
> + */
> +#ifdef CONFIG_SMP
> +#define smp_acquire_barrier__after_atomic() \
> +	__asm__ __volatile__(PPC_ACQUIRE_BARRIER : : : "memory")
> +#else
> +#define smp_acquire_barrier__after_atomic() barrier()
> +#endif
> +#define arch_atomic_op_acquire(op, args...)				\
> +({									\
> +	typeof(op##_relaxed(args)) __ret  = op##_relaxed(args);		\
> +	smp_acquire_barrier__after_atomic();				\
> +	__ret;								\
> +})
> +
> +#define arch_atomic_op_release(op, args...)				\
> +({									\
> +	smp_lwsync();							\
> +	op##_relaxed(args);						\
> +})

Urgh, so this is RCpc. We were trying to get rid of that if possible.
Lets wait until that's settled before introducing more of it.

lkml.kernel.org/r/20150820155604.GB24100@arm.com
