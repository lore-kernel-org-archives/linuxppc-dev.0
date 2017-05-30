Return-Path: <npiggin@gmail.com>
Received: from mail-pf0-x243.google.com (mail-pf0-x243.google.com
 [IPv6:2607:f8b0:400e:c00::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3wcNvV3LGrzDq5W
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 30 May 2017 16:27:50 +1000 (AEST)
Received: by mail-pf0-x243.google.com with SMTP id u26so15705377pfd.2
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 29 May 2017 23:27:50 -0700 (PDT)
Date: Tue, 30 May 2017 16:27:35 +1000
From: Nicholas Piggin <npiggin@gmail.com>
To: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling
 <mikey@neuling.org>, Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>,
 Shilpasri G Bhat <shilpa.bhat@linux.vnet.ibm.com>, Akshay Adiga
 <akshay.adiga@linux.vnet.ibm.com>, Benjamin Herrenschmidt
 <benh@kernel.crashing.org>, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH 5/6] powernv:idle: Use Requested Level for restoring
 state on P9 DD1
Message-ID: <20170530162735.564f863e@roar.ozlabs.ibm.com>
In-Reply-To: <70ede0d8bdcb14ea676c87f14a26788890a3ba4d.1494585671.git.ego@linux.vnet.ibm.com>
References: <cover.1494585671.git.ego@linux.vnet.ibm.com>
 <70ede0d8bdcb14ea676c87f14a26788890a3ba4d.1494585671.git.ego@linux.vnet.ibm.com>
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

On Tue, 16 May 2017 14:19:47 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> On Power9 DD1 due to a hardware bug the Power-Saving Level Status
> field (PLS) of the PSSCR for a thread waking up from a deep state can
> under-report if some other thread in the core is in a shallow stop
> state. The scenario in which this can manifest is as follows:
> 
>        1) All the threads of the core are in deep stop.
>        2) One of the threads is woken up. The PLS for this thread will
>           correctly reflect that it is waking up from deep stop.
>        3) The thread that has woken up now executes a shallow stop.
>        4) When some other thread in the core is woken, its PLS will reflect
>           the shallow stop state.
> 
> Thus, the subsequent thread for which the PLS is under-reporting the
> wakeup state will not restore the hypervisor resources.
> 
> Hence, on DD1 systems, use the Requested Level (RL) field as a
> workaround to restore the contents of the hypervisor resources on the
> wakeup from the stop state.
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>


Reviewed-by: Nicholas Piggin <npiggin@gmail.com>


> ---
>  arch/powerpc/include/asm/paca.h   |  2 ++
>  arch/powerpc/kernel/asm-offsets.c |  1 +
>  arch/powerpc/kernel/idle_book3s.S | 13 ++++++++++++-
>  3 files changed, 15 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> index 1c09f8f..77f60a0 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -177,6 +177,8 @@ struct paca_struct {
>  	 * to the sibling threads' paca.
>  	 */
>  	struct paca_struct **thread_sibling_pacas;
> +	/* The PSSCR value that the kernel requested before going to stop */
> +	u64 requested_psscr;
>  #endif
>  
>  #ifdef CONFIG_PPC_STD_MMU_64
> diff --git a/arch/powerpc/kernel/asm-offsets.c b/arch/powerpc/kernel/asm-offsets.c
> index 709e234..e15c178 100644
> --- a/arch/powerpc/kernel/asm-offsets.c
> +++ b/arch/powerpc/kernel/asm-offsets.c
> @@ -742,6 +742,7 @@ int main(void)
>  	OFFSET(PACA_THREAD_MASK, paca_struct, thread_mask);
>  	OFFSET(PACA_SUBCORE_SIBLING_MASK, paca_struct, subcore_sibling_mask);
>  	OFFSET(PACA_SIBLING_PACA_PTRS, paca_struct, thread_sibling_pacas);
> +	OFFSET(PACA_REQ_PSSCR, paca_struct, requested_psscr);
>  #endif
>  
>  	DEFINE(PPC_DBELL_SERVER, PPC_DBELL_SERVER);
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 6c9920d..98a6d07 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -379,6 +379,7 @@ _GLOBAL(power9_idle_stop)
>  	mfspr   r5,SPRN_PSSCR
>  	andc    r5,r5,r4
>  	or      r3,r3,r5
> +	std	r3, PACA_REQ_PSSCR(r13)
>  	mtspr 	SPRN_PSSCR,r3
>  	LOAD_REG_ADDR(r5,power_enter_stop)
>  	li	r4,1
> @@ -498,12 +499,22 @@ pnv_restore_hyp_resource_arch300:
>  	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
>  	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
>  
> -	mfspr	r5,SPRN_PSSCR
> +BEGIN_FTR_SECTION_NESTED(71)
> +	/*
> +	 * Assume that we are waking up from the state
> +	 * same as the Requested Level (RL) in the PSSCR
> +	 * which are Bits 60-63
> +	 */
> +	ld	r5,PACA_REQ_PSSCR(r13)
> +	rldicl  r5,r5,0,60
> +FTR_SECTION_ELSE_NESTED(71)
>  	/*
>  	 * 0-3 bits correspond to Power-Saving Level Status
>  	 * which indicates the idle state we are waking up from
>  	 */
> +	mfspr	r5, SPRN_PSSCR
>  	rldicl  r5,r5,4,60
> +ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_POWER9_DD1, 71)
>  	cmpd	cr4,r5,r4
>  	bge	cr4,pnv_wakeup_tb_loss /* returns to caller */
>  
