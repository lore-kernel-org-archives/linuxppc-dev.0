Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x242.google.com (mail-pg0-x242.google.com
 [IPv6:2607:f8b0:400e:c05::242])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vn2Hk2bJKzDqZY
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 04:00:02 +1100 (AEDT)
Received: by mail-pg0-x242.google.com with SMTP id 79so12239195pgf.0
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 20 Mar 2017 10:00:01 -0700 (PDT)
Date: Tue, 21 Mar 2017 02:59:46 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 "Shreyas B. Prabhu" <shreyasbp@gmail.com>, Shilpasri G Bhat
 <shilpa.bhat@linux.vnet.ibm.com>, Vaidyanathan Srinivasan
 <svaidy@linux.vnet.ibm.com>, Anton Blanchard <anton@samba.org>, Balbir
 Singh <bsingharora@gmail.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [v2 PATCH 4/4] powernv: Recover correct PACA on wakeup from a
 stop on P9 DD1
Message-ID: <20170321025946.3c0b68c5@roar.ozlabs.ibm.com>
In-Reply-To: <5beb1c3fb26ef0b487be3aa0488ea31aabfcb311.1490024477.git.ego@linux.vnet.ibm.com>
References: <cover.1490024477.git.ego@linux.vnet.ibm.com>
 <5beb1c3fb26ef0b487be3aa0488ea31aabfcb311.1490024477.git.ego@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, 20 Mar 2017 21:24:18 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> POWER9 DD1.0 hardware has an issue due to which the SPRs of a thread
> waking up from stop 0,1,2 with ESL=1 can endup being misplaced in the
> core. Thus the HSPRG0 of a thread waking up from can contain the paca
> pointer of its sibling.
> 
> This patch implements a context recovery framework within threads of a
> core, by provisioning space in paca_struct for saving every sibling
> threads's paca pointers. Basically, we should be able to arrive at the
> right paca pointer from any of the thread's existing paca pointer.
> 
> At bootup, during powernv idle-init, we save the paca address of every
> CPU in each one its siblings paca_struct in the slot corresponding to
> this CPU's index in the core.
> 
> On wakeup from a stop, the thread will determine its index in the core
> from the lower 2 bits of the PIR register and recover its PACA pointer
> by indexing into the correct slot in the provisioned space in the
> current PACA.
> 
> Furthermore, ensure that the NVGPRs are restored from the stack on the
> way out by setting the NAPSTATELOST in paca.

Thanks for expanding on this, it makes the patch easier to follow :)

As noted before, I think if we use PACA_EXNMI for system reset, then
*hopefully* there should be minimal races with the initial use of other
thread's PACA at the start of the exception. So I'll work on getting
that in, but it need not prevent this patch from being merged first
IMO.

> [Changelog written with inputs from svaidy@linux.vnet.ibm.com]
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/paca.h       |  5 ++++
>  arch/powerpc/kernel/asm-offsets.c     |  1 +
>  arch/powerpc/kernel/idle_book3s.S     | 49 ++++++++++++++++++++++++++++++++++-
>  arch/powerpc/platforms/powernv/idle.c | 22 ++++++++++++++++
>  4 files changed, 76 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> index 708c3e5..4405630 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -172,6 +172,11 @@ struct paca_struct {
>  	u8 thread_mask;
>  	/* Mask to denote subcore sibling threads */
>  	u8 subcore_sibling_mask;
> +	/*
> +	 * Pointer to an array which contains pointer
> +	 * to the sibling threads' paca.
> +	 */
> +	struct paca_struct *thread_sibling_pacas[8];

Is 8 the right number? I wonder if we have a define for it.

>  #endif
>  
>  #ifdef CONFIG_PPC_BOOK3S_64
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 4367e7d..6ec5016 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -727,6 +727,7 @@ int main(void)
>  	OFFSET(PACA_THREAD_IDLE_STATE, paca_struct, thread_idle_state);
>  	OFFSET(PACA_THREAD_MASK, paca_struct, thread_mask);
>  	OFFSET(PACA_SUBCORE_SIBLING_MASK, paca_struct, subcore_sibling_mask);
> +	OFFSET(PACA_SIBLING_PACA_PTRS, paca_struct, thread_sibling_pacas);
>  #endif
>  
>  	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 9957287..c2f2cfb 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -375,6 +375,46 @@ _GLOBAL(power9_idle_stop)
>  	li	r4,1
>  	b	pnv_powersave_common
>  	/* No return */
> +
> +
> +/*
> + * On waking up from stop 0,1,2 with ESL=1 on POWER9 DD1,
> + * HSPRG0 will be set to the HSPRG0 value of one of the
> + * threads in this core. Thus the value we have in r13
> + * may not be this thread's paca pointer.
> + *
> + * Fortunately, the PIR remains invariant. Since this thread's
> + * paca pointer is recorded in all its sibling's paca, we can
> + * correctly recover this thread's paca pointer if we
> + * know the index of this thread in the core.
> + *
> + * This index can be obtained from the lower two bits of the PIR.
> + *
> + * i.e, thread's position in the core = PIR[62:63].
> + * If this value is i, then this thread's paca is
> + * paca->thread_sibling_pacas[i].
> + */
> +power9_dd1_recover_paca:
> +	mfspr	r4, SPRN_PIR
> +	clrldi	r4, r4, 62

Does SPRN_TIR work?

> +	/*
> +	 * Since each entry in thread_sibling_pacas is 8 bytes
> +	 * we need to left-shift by 3 bits. Thus r4 = i * 8
> +	 */
> +	sldi	r4, r4, 3
> +	/* Get &paca->thread_sibling_pacas[0] in r5 */
> +	addi	r5, r13, PACA_SIBLING_PACA_PTRS
> +	/* Load paca->thread_sibling_pacas[i] into r13 */
> +	ldx	r13, r4, r5
> +	SET_PACA(r13)
> +	/*
> +	 * Indicate that we have lost NVGPR state
> +	 * which needs to be restored from the stack.
> +	 */
> +	li	r3, 1
> +	stb	r0,PACA_NAPSTATELOST(r13)
> +	blr
> +
>  /*
>   * Called from reset vector. Check whether we have woken up with
>   * hypervisor state loss. If yes, restore hypervisor state and return
> @@ -385,7 +425,14 @@ _GLOBAL(power9_idle_stop)
>   */
>  _GLOBAL(pnv_restore_hyp_resource)
>  BEGIN_FTR_SECTION
> -	ld	r2,PACATOC(r13);
> +BEGIN_FTR_SECTION_NESTED(70)
> +	mflr 	r6
> +	bl	power9_dd1_recover_paca
> +	mtlr	r6
> +	ld	r2, PACATOC(r13)
> +FTR_SECTION_ELSE_NESTED(70)
> +	ld	r2, PACATOC(r13)
> +ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_POWER9_DD1, 70)

This is quite neat now you've moved it to its own function. Nice.
It will be only a trivial clash with my patches now, I think.

Reviewed-by: Nicholas Piggin <npiggin@gmail.com>
