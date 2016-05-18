Return-Path: <ego@linux.vnet.ibm.com>
Received: from e31.co.us.ibm.com (e31.co.us.ibm.com [32.97.110.149])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r92302zbpzDq7s
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 19 May 2016 03:57:16 +1000 (AEST)
Received: from localhost
 by e31.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 18 May 2016 11:57:12 -0600
Date: Wed, 18 May 2016 23:27:02 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org
Subject: Re: [PATCH v2 7/9] powerpc/powernv: Add platform support for stop
 instruction
Message-ID: <20160518175702.GA4359@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1462263878-25237-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1462263878-25237-8-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462263878-25237-8-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Shreyas,

On Tue, May 03, 2016 at 01:54:36PM +0530, Shreyas B. Prabhu wrote:
> POWER ISA v3 defines a new idle processor core mechanism. In summary,
>  a) new instruction named stop is added. This instruction replaces
> 	instructions like nap, sleep, rvwinkle.
>  b) new per thread SPR named PSSCR is added which controls the behavior
> 	of stop instruction.
> 
> PSSCR has following key fields
> 	Bits 0:3  - Power-Saving Level Status. This field indicates the lowest
> 	power-saving state the thread entered since stop instruction was last
> 	executed.
> 
> 	Bit 42 - Enable State Loss
> 	0 - No state is lost irrespective of other fields
> 	1 - Allows state loss
> 
> 	Bits 44:47 - Power-Saving Level Limit
> 	This limits the power-saving level that can be entered into.
> 
> 	Bits 60:63 - Requested Level
> 	Used to specify which power-saving level must be entered on executing
> 	stop instruction
> 
> This patch adds support for stop instruction and PSSCR handling.
> 
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>

[..snip..]

> diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
> index 6a24769..d85f834 100644
> --- a/arch/powerpc/kernel/idle_power7.S
> +++ b/arch/powerpc/kernel/idle_power7.S
> @@ -46,7 +46,7 @@ core_idle_lock_held:
>  power7_enter_nap_mode:
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  	/* Tell KVM we're napping */
> -	li	r4,KVM_HWTHREAD_IN_NAP
> +	li	r4,KVM_HWTHREAD_IN_IDLE
>  	stb	r4,HSTATE_HWTHREAD_STATE(r13)
>  #endif
>  	stb	r3,PACA_THREAD_IDLE_STATE(r13)
> diff --git a/arch/powerpc/kernel/idle_power_common.S b/arch/powerpc/kernel/idle_power_common.S
> index ff7a541..f260fa8 100644
> --- a/arch/powerpc/kernel/idle_power_common.S
> +++ b/arch/powerpc/kernel/idle_power_common.S
> @@ -96,11 +96,35 @@ _GLOBAL(power_powersave_common)
>   * back to reset vector.
>   */
>  _GLOBAL(power7_restore_hyp_resource)
> +	GET_PACA(r13)
> +BEGIN_FTR_SECTION_NESTED(888)
> +	/*
> +	 * POWER ISA 3. Use PSSCR to determine if we
> +	 * are waking up from deep idle state
> +	 */
> +	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
> +	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
> +
> +	mfspr	r5,SPRN_PSSCR
> +	/*
> +	 * 0-4 bits correspond to Power-Saving Level Status
> +	 * which indicates the idle state we are waking up from
> +	 */
> +	rldicl  r5,r5,4,60
> +	cmpd	r5,r4
> +	bge	power_stop_wakeup_hyp_loss
>  	/*
> +	 * Waking up without hypervisor state loss. Return to
> +	 * reset vector
> +	 */
> +	blr
> +
> +END_FTR_SECTION_NESTED(CPU_FTR_ARCH_300,CPU_FTR_ARCH_300,888)
> +	/*
> +	 * POWER ISA 2.07 or less.
>  	 * Check if last bit of HSPGR0 is set. This indicates whether we are
>  	 * waking up from winkle.
>  	 */
> -	GET_PACA(r13)
>  	clrldi	r5,r13,63
>  	clrrdi	r13,r13,1
>  	cmpwi	cr4,r5,1
> diff --git a/arch/powerpc/kernel/idle_power_stop.S b/arch/powerpc/kernel/idle_power_stop.S
> new file mode 100644
> index 0000000..6c86c56
> --- /dev/null
> +++ b/arch/powerpc/kernel/idle_power_stop.S
> @@ -0,0 +1,221 @@
> +#include <linux/threads.h>
> +
> +#include <asm/processor.h>
> +#include <asm/cputable.h>
> +#include <asm/thread_info.h>
> +#include <asm/ppc_asm.h>
> +#include <asm/asm-offsets.h>
> +#include <asm/ppc-opcode.h>
> +#include <asm/hw_irq.h>
> +#include <asm/kvm_book3s_asm.h>
> +#include <asm/opal.h>
> +#include <asm/cpuidle.h>
> +#include <asm/book3s/64/mmu-hash.h>
> +#include <asm/exception-64s.h>
> +
> +#undef DEBUG
> +
> +/*
> + * rA - Requested stop state
> + * rB - Spare reg that can be used
> + */
> +#define PSSCR_REQUEST_STATE(rA, rB) 		\
> +	ld	rB, PACA_THREAD_PSSCR(r13);	\
> +	or	rB,rB,rA;			\
> +	mtspr	SPRN_PSSCR, rB;			\
> +
> +	.text
> +
> +	.globl	power_enter_stop
> +power_enter_stop:
> +#ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
> +	/* Tell KVM we're napping */
> +	li	r4,KVM_HWTHREAD_IN_IDLE
> +	stb	r4,HSTATE_HWTHREAD_STATE(r13)
> +#endif
> +	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
> +	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
> +	cmpd	cr3,r3,r4

It is not clear what r3 is supposed to contain at this point. I think
it should contain the requested stop state. But I might be wrong!
Perhaps a comment above power_enter_stop can clarify that.

> +	bge	2f
> +	IDLE_STATE_ENTER_SEQ(PPC_STOP)
> +2:
> +	lbz     r7,PACA_THREAD_MASK(r13)
> +	ld      r14,PACA_CORE_IDLE_STATE_PTR(r13)
> +
> +lwarx_loop1:
> +	lwarx   r15,0,r14
> +	andi.   r9,r15,PNV_CORE_IDLE_LOCK_BIT
> +	bnel    core_idle_lock_held

The definition of core_idle_lock_held below jumps to lwarx_loop2
instead of doing a blr once it observed that the LOCK_BIT is no longer
set. This doesn't seem correct since the purpose of
core_idle_lock_held is to spin until the LOCK_BIT is cleared and then
resume whatever we were supposed to do next.

Can you clarify this part ?

> +	andc    r15,r15,r7                      /* Clear thread bit */
> +
> +	andi.   r15,r15,PNV_CORE_IDLE_THREAD_BITS
> +	stwcx.  r15,0,r14
> +	bne-    lwarx_loop1
> +
> +	/*
> +	 * Note all register i.e per-core, per-subcore or per-thread is saved
> +	 * here since any thread in the core might wake up first
> +	 */
> +	mfspr	r3,SPRN_RPR
> +	std	r3,_RPR(r1)
> +	mfspr	r3,SPRN_SPURR
> +	std	r3,_SPURR(r1)
> +	mfspr	r3,SPRN_PURR
> +	std	r3,_PURR(r1)
> +	mfspr	r3,SPRN_TSCR
> +	std	r3,_TSCR(r1)
> +	mfspr	r3,SPRN_DSCR
> +	std	r3,_DSCR(r1)
> +	mfspr	r3,SPRN_AMOR
> +	std	r3,_AMOR(r1)
> +
> +	IDLE_STATE_ENTER_SEQ(PPC_STOP)
> +
> +
> +_GLOBAL(power_stop)
> +	PSSCR_REQUEST_STATE(r3,r4)
> +	li	r4, 1
> +	LOAD_REG_ADDR(r5,power_enter_stop)
> +	b	power_powersave_common
> +
> +_GLOBAL(power_stop0)
> +	li	r3,0
> +	li	r4,1
> +	LOAD_REG_ADDR(r5,power_enter_stop)
> +	PSSCR_REQUEST_STATE(r3,r4)

r4 will get clobbered at this point. Move PSSCR_REQUEST_STATE before
"li r4,1". 

Also why cant this simply call "power_stop" having set r3
to 0 ?


> +	b	power_powersave_common
> +
> +_GLOBAL(power_stop_wakeup_hyp_loss)
> +	ld	r2,PACATOC(r13);
> +	ld	r1,PACAR1(r13)
> +	/*
> +	 * Before entering any idle state, the NVGPRs are saved in the stack
> +	 * and they are restored before switching to the process context. Hence
> +	 * until they are restored, they are free to be used.
> +	 *
> +	 * Save SRR1 in a NVGPR as it might be clobbered in opal_call_realmode
> +	 * (called in CHECK_HMI_INTERRUPT). SRR1 is required to determine the
> +	 * wakeup reason if we branch to kvm_start_guest.
> +	 */

Retain the comment from an earlier patch explaning why LR is being
cached in r17.

> +	mflr	r17
> +	mfspr	r16,SPRN_SRR1
> +BEGIN_FTR_SECTION
> +	CHECK_HMI_INTERRUPT
> +END_FTR_SECTION_IFSET(CPU_FTR_HVMODE)
> +
> +	lbz	r7,PACA_THREAD_MASK(r13)
> +	ld	r14,PACA_CORE_IDLE_STATE_PTR(r13)
> +lwarx_loop2:
> +	lwarx	r15,0,r14
> +	andi.	r9,r15,PNV_CORE_IDLE_LOCK_BIT
> +	/*
> +	 * Lock bit is set in one of the 2 cases-
> +	 * a. In the stop enter path, the last thread is executing
> +	 * fastsleep workaround code.
> +	 * b. In the wake up path, another thread is resyncing timebase or
> +	 * restoring context
> +	 * In either case loop until the lock bit is cleared.
> +	 */
> +	bne	core_idle_lock_held
> +
> +	cmpwi	cr2,r15,0
> +	lbz	r4,PACA_SUBCORE_SIBLING_MASK(r13)
> +	and	r4,r4,r15
> +	cmpwi	cr1,r4,0	/* Check if first in subcore */
> +
> +	or	r15,r15,r7		/* Set thread bit */
> +
> +	beq	cr1,first_thread_in_subcore
> +
> +	/* Not first thread in subcore to wake up */
> +	stwcx.	r15,0,r14
> +	bne-	lwarx_loop2
> +	isync
> +	b	common_exit

The code from lwarx_loop2 till the end of the definition of
common_exit is the same as the lwarx_loop2 to common_exit in
idle_power7.S. Well, except for a minor bit in the manner in which
return from core_idle_lock_held is handled and the fact that we're not
defining pnv_fastsleep_workaround_at_exit immediately in
first_thread_in_core. I prefer the original version where
core_idle_lock_held does a blr instead of explicitly jumping back to
lwarx_loop2 since it can be invoked safely from multiple places.

Can we move this to a common place and invoke it from these two places
instead of duplicating the code ?

> +
> +core_idle_lock_held:
> +	HMT_LOW
> +core_idle_lock_loop:
> +	lwz	r15,0(14)
> +	andi.   r9,r15,PNV_CORE_IDLE_LOCK_BIT
> +	bne	core_idle_lock_loop
> +	HMT_MEDIUM
> +	b	lwarx_loop2
> +
> +first_thread_in_subcore:
> +	/* First thread in subcore to wakeup */
> +	ori	r15,r15,PNV_CORE_IDLE_LOCK_BIT
> +	stwcx.	r15,0,r14
> +	bne-	lwarx_loop2
> +	isync
> +
> +	/*
> +	 * If waking up from sleep, subcore state is not lost. Hence
> +	 * skip subcore state restore
> +	 */
> +	bne	cr4,subcore_state_restored
> +
> +	/* Restore per-subcore state */
> +	ld      r4,_RPR(r1)
> +	mtspr   SPRN_RPR,r4
> +	ld	r4,_AMOR(r1)
> +	mtspr	SPRN_AMOR,r4
> +
> +subcore_state_restored:
> +	/*
> +	 * Check if the thread is also the first thread in the core. If not,
> +	 * skip to clear_lock.
> +	 */
> +	bne	cr2,clear_lock
> +
> +first_thread_in_core:

I suppose we don't need the pnv_fastsleep_workaround_at_exit at this
point anymore.

> +
> +timebase_resync:
> +	/* Do timebase resync if we are waking up from sleep. Use cr3 value
> +	 * set in exceptions-64s.S */
> +	ble	cr3,clear_lock
> +	/* Time base re-sync */
> +	li	r0,OPAL_RESYNC_TIMEBASE
> +	bl	opal_call_realmode;
> +
> +	/*
> +	 * If waking up from sleep, per core state is not lost, skip to
> +	 * clear_lock.
> +	 */
> +	bne	cr4,clear_lock
> +
> +	/* Restore per core state */
> +	ld	r4,_TSCR(r1)
> +	mtspr	SPRN_TSCR,r4
> +
> +clear_lock:
> +	andi.	r15,r15,PNV_CORE_IDLE_THREAD_BITS
> +	lwsync
> +	stw	r15,0(r14)
> +
> +common_exit:
> +	/*
> +	 * Common to all threads.
> +	 *
> +	 * If waking up from sleep, hypervisor state is not lost. Hence
> +	 * skip hypervisor state restore.
> +	 */
> +	bne	cr4,hypervisor_state_restored
> +
> +	/* Waking up from deep idle state */
> +
> +	/* Restore per thread state */
> +	bl	__restore_cpu_power8
> +
> +	ld	r4,_SPURR(r1)
> +	mtspr	SPRN_SPURR,r4
> +	ld	r4,_PURR(r1)
> +	mtspr	SPRN_PURR,r4
> +	ld	r4,_DSCR(r1)
> +	mtspr	SPRN_DSCR,r4
> +
> +hypervisor_state_restored:
> +
> +	mtspr	SPRN_SRR1,r16
> +	mtlr	r17
> +	blr

[..snip..]

> @@ -264,6 +275,30 @@ static int __init pnv_init_idle_states(void)
>  		goto out_free;
>  	}
> 
> +	if (cpu_has_feature(CPU_FTR_ARCH_300)) {
> +		psscr_val = kcalloc(dt_idle_states, sizeof(*psscr_val),
> +					GFP_KERNEL);

Need to handle the case whe the kcalloc fails to allocate memory for
psscr_val here.

> +		if (of_property_read_u64_array(power_mgt,
> +			"ibm,cpu-idle-state-psscr",
> +			psscr_val, dt_idle_states)) {
> +			pr_warn("cpuidle-powernv: missing ibm,cpu-idle-states-psscr in DT\n");
> +			goto out_free_psscr;
> +		}

The remainder of the patch looks ok.

--
Thanks and Regards
gautham.
