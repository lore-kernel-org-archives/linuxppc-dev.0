Return-Path: <mark.rutland@arm.com>
Received: from foss.arm.com (usa-sjc-mx-foss1.foss.arm.com [217.140.101.70])
 by lists.ozlabs.org (Postfix) with ESMTP id 40HcNH3NykzF1sR
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  6 Apr 2018 21:07:10 +1000 (AEST)
Date: Fri, 6 Apr 2018 12:07:03 +0100
From: Mark Rutland <mark.rutland@arm.com>
To: Yury Norov <ynorov@caviumnetworks.com>
Cc: "Paul E. McKenney" <paulmck@linux.vnet.ibm.com>,
 Will Deacon <will.deacon@arm.com>, Chris Metcalf <cmetcalf@mellanox.com>,
 Christopher Lameter <cl@linux.com>,
 Russell King - ARM Linux <linux@armlinux.org.uk>,
 Steven Rostedt <rostedt@goodmis.org>,
 Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
 Catalin Marinas <catalin.marinas@arm.com>,
 Pekka Enberg <penberg@kernel.org>, David Rientjes <rientjes@google.com>,
 Joonsoo Kim <iamjoonsoo.kim@lge.com>,
 Andrew Morton <akpm@linux-foundation.org>,
 Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Alexey Klimov <klimov.linux@gmail.com>,
 linux-arm-kernel@lists.infradead.org, linuxppc-dev@lists.ozlabs.org,
 kvm-ppc@vger.kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/5] arm64: early ISB at exit from extended quiescent state
Message-ID: <20180406110702.pew7xfd3y5c72he7@lakrids.cambridge.arm.com>
References: <20180405171800.5648-1-ynorov@caviumnetworks.com>
 <20180405171800.5648-4-ynorov@caviumnetworks.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20180405171800.5648-4-ynorov@caviumnetworks.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Thu, Apr 05, 2018 at 08:17:58PM +0300, Yury Norov wrote:
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
> 
> Suggested-by: Will Deacon <will.deacon@arm.com>
> Signed-off-by: Yury Norov <ynorov@caviumnetworks.com>
> ---
>  arch/arm64/kernel/entry.S   | 16 +++++++++++++++-
>  arch/arm64/kernel/process.c |  7 +++++++
>  2 files changed, 22 insertions(+), 1 deletion(-)
> 
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

As I mentioned before, this is too early.

If we only kick active CPUs, then until we exit a quiescent state, we
can race with concurrent modification, and cannot reliably ensure that
instructions are up-to-date. Practically speaking, that means that we
cannot patch any code used on the path to exit a quiescent state.

Also, if this were needed in the SVC path, it would be necessary for all
exceptions from EL0. Buggy userspace can always trigger a data abort,
even if it doesn't intend to.

>  	enable_daif
>  	ct_user_exit
>  	el0_svc_restore_syscall_args
> diff --git a/arch/arm64/kernel/process.c b/arch/arm64/kernel/process.c
> index f08a2ed9db0d..74cad496b07b 100644
> --- a/arch/arm64/kernel/process.c
> +++ b/arch/arm64/kernel/process.c
> @@ -88,6 +88,13 @@ void arch_cpu_idle(void)
>  	trace_cpu_idle_rcuidle(PWR_EVENT_EXIT, smp_processor_id());
>  }
>  
> +void arch_cpu_idle_exit(void)
> +{
> +	/* Pairs with aarch64_insn_patch_text() for EQS CPUs. */
> +	if (!rcu_is_watching())
> +		isb();
> +}

Likewise, this is too early as we haven't left the extended quiescent
state yet.

Thanks,
Mark.
