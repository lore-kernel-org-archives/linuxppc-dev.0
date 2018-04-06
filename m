Return-Path: <james.morse@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 40Hb5h4MxTzF1sl
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 20:09:28 +1000 (AEST)
Subject: Re: [PATCH 3/5] arm64: early ISB at exit from extended quiescent state
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Mark Rutland <mark.rutland@arm.com>, Will Deacon <will.deacon@arm.com>,
 Chris Metcalf <cmetcalf@mellanox.com>, Christopher Lameter <cl@linux.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>, Pekka Enberg
 <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Klimov <klimov.linux@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20180405171800.5648-1-ynorov@caviumnetworks.com>
 <20180405171800.5648-4-ynorov@caviumnetworks.com>
From: James Morse <james.morse@arm.com>
Message-ID: <c7e03021-4c55-8e5f-3480-6628d83d8cd9@arm.com>
Date: Fri, 6 Apr 2018 11:06:35 +0100
MIME-Version: 1.0
In-Reply-To: <20180405171800.5648-4-ynorov@caviumnetworks.com>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Yury,

On 05/04/18 18:17, Yury Norov wrote:
> This series enables delaying of kernel memory synchronization
> for CPUs running in extended quiescent state (EQS) till the exit
> of that state.
> 
> ARM64 uses IPI mechanism to notify all cores in  SMP system that
> kernel text is changed; and IPI handler calls isb() to synchronize.
> 
> If we don't deliver IPI to EQS CPUs anymore, we should add ISB early
> in EQS exit path.
> 
> There are 2 such paths. One starts in do_idle() loop, and other
> in el0_svc entry. For do_idle(), isb() is added in
> arch_cpu_idle_exit() hook. And for SVC handler, isb is called in
> el0_svc_naked.

(I know nothing about this EQS stuff, but) there is a third path that might be
relevant.
>From include/linux/context_tracking.h:guest_enter_irqoff():
|	 * KVM does not hold any references to rcu protected data when it
|	 * switches CPU into a guest mode. In fact switching to a guest mode
|	 * is very similar to exiting to userspace from rcu point of view. In
|	 * addition CPU may stay in a guest mode for quite a long time (up to
|	 * one time slice). Lets treat guest mode as quiescent state, just like
|	 * we do with user-mode execution.

For non-VHE systems guest_enter_irqoff()() is called just before we jump to EL2.
Coming back gives us an exception-return, so we have a context-synchronisation
event there, and I assume we will never patch the hyp-text on these systems.

But with VHE on the upcoming kernel version we still go on to run code at the
same EL. Do we need an ISB on the path back from the guest once we've told RCU
we've 'exited user-space'?
If this code can be patched, do we have a problem here?


> diff --git a/arch/arm64/kernel/entry.S b/arch/arm64/kernel/entry.S
> index c8d9ec363ddd..b1e1c19b4432 100644
> --- a/arch/arm64/kernel/entry.S
> +++ b/arch/arm64/kernel/entry.S
> @@ -48,7 +48,7 @@
>  	.endm
>  
>  	.macro el0_svc_restore_syscall_args
> -#if defined(CONFIG_CONTEXT_TRACKING)
> +#if !defined(CONFIG_TINY_RCU) || defined(CONFIG_CONTEXT_TRACKING)
>  	restore_syscall_args
>  #endif
>  	.endm
> @@ -483,6 +483,19 @@ __bad_stack:
>  	ASM_BUG()
>  	.endm
>  
> +/*
> + * If CPU is in extended quiescent state we need isb to ensure that
> + * possible change of kernel text is visible by the core.
> + */
> +	.macro	isb_if_eqs
> +#ifndef CONFIG_TINY_RCU
> +	bl	rcu_is_watching
> +	cbnz	x0, 1f
> +	isb 					// pairs with aarch64_insn_patch_text
> +1:
> +#endif
> +	.endm
> +
>  el0_sync_invalid:
>  	inv_entry 0, BAD_SYNC
>  ENDPROC(el0_sync_invalid)
> @@ -949,6 +962,7 @@ alternative_else_nop_endif
>  
>  el0_svc_naked:					// compat entry point
>  	stp	x0, xscno, [sp, #S_ORIG_X0]	// save the original x0 and syscall number
> +	isb_if_eqs
>  	enable_daif
>  	ct_user_exit
>  	el0_svc_restore_syscall_args

Shouldn't this be at the point that RCU knows we've exited user-space? Otherwise
there is a gap where RCU thinks we're in user-space, we're not, and we're about
to tell it. Code-patching occurring in this gap would be missed.

This gap only contains 'enable_daif', and any exception that occurs here is
safe, but its going to give someone a nasty surprise...

Mark points out this ISB needs to be after RCU knows we're not quiescent:
https://lkml.org/lkml/2018/4/3/378

Can't this go in the rcu exit-quiescence code? Isn't this what your
rcu_dynticks_eqs_exit_sync() hook does?


Thanks,

James
