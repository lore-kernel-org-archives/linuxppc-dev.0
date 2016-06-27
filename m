Return-Path: <peterz@infradead.org>
Received: from merlin.infradead.org (merlin.infradead.org
 [IPv6:2001:4978:20e::2])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rdWHB6LvkzDqRd
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 28 Jun 2016 00:17:42 +1000 (AEST)
Date: Mon, 27 Jun 2016 16:17:35 +0200
From: Peter Zijlstra <peterz@infradead.org>
To: Pan Xinhui <xinhui.pan@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 paulmck@linux.vnet.ibm.com, mingo@redhat.com, mpe@ellerman.id.au,
 paulus@samba.org, benh@kernel.crashing.org, Waiman.Long@hpe.com,
 boqun.feng@gmail.com, will.deacon@arm.com, dave@stgolabs.net
Subject: Re: [PATCH 2/3] powerpc/spinlock: support vcpu preempted check
Message-ID: <20160627141735.GC30909@twins.programming.kicks-ass.net>
References: <1467049290-32359-1-git-send-email-xinhui.pan@linux.vnet.ibm.com>
 <1467049290-32359-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1467049290-32359-3-git-send-email-xinhui.pan@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, Jun 27, 2016 at 01:41:29PM -0400, Pan Xinhui wrote:
> diff --git a/arch/powerpc/include/asm/spinlock.h b/arch/powerpc/include/asm/spinlock.h
> index 523673d..ae938ee 100644
> --- a/arch/powerpc/include/asm/spinlock.h
> +++ b/arch/powerpc/include/asm/spinlock.h
> @@ -52,6 +52,21 @@
>  #define SYNC_IO
>  #endif
>  
> +/* For fixing some spinning issues in a guest.
> + * kernel would check if vcpu is preempted during a spin loop.
> + * we support that.
> + */

If you look around in that file you'll notice that the above comment
style is inconsistent.

Nor is the comment really clarifying things, for one you fail to mention
the problem by its known name. You also forget to explain how this
interface will help. How about something like this:

/*
 * In order to deal with a various lock holder preemption issues provide
 * an interface to see if a vCPU is currently running or not.
 *
 * This allows us to terminate optimistic spin loops and block,
 * analogous to the native optimistic spin heuristic of testing if the
 * lock owner task is running or not.
 */

Also, since you now have a useful comment, which is not architecture
specific, I would place it with the common vcpu_is_preempted()
definition in sched.h.

Hmm?

> +#define arch_vcpu_is_preempted arch_vcpu_is_preempted
> +static inline bool arch_vcpu_is_preempted(int cpu)
> +{
> +	struct lppaca *lp = &lppaca_of(cpu);
> +
> +	if (unlikely(!(lppaca_shared_proc(lp) ||
> +			lppaca_dedicated_proc(lp))))
> +		return false;
> +	return !!(be32_to_cpu(lp->yield_count) & 1);
> +}
> +
>  static __always_inline int arch_spin_value_unlocked(arch_spinlock_t lock)
>  {
>  	return lock.slock == 0;
> -- 
> 2.4.11
> 
