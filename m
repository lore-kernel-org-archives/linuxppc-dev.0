Return-Path: <npiggin@gmail.com>
Received: from mail-pg0-x241.google.com (mail-pg0-x241.google.com
 [IPv6:2607:f8b0:400e:c05::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vjHMk2rLpzDqYQ
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 15 Mar 2017 01:35:30 +1100 (AEDT)
Received: by mail-pg0-x241.google.com with SMTP id b5so24912582pgg.1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Mar 2017 07:35:30 -0700 (PDT)
Date: Wed, 15 Mar 2017 00:35:13 +1000
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
Subject: Re: [PATCH 3/3] powernv:Recover correct PACA on wakeup from a stop
 on P9 DD1
Message-ID: <20170315003500.0320ac2d@roar.ozlabs.ibm.com>
In-Reply-To: <6a5d7270f893e4d8df1bd0c0c16c4aa6d10d23fa.1489383815.git.ego@linux.vnet.ibm.com>
References: <cover.1489383815.git.ego@linux.vnet.ibm.com>
 <6a5d7270f893e4d8df1bd0c0c16c4aa6d10d23fa.1489383815.git.ego@linux.vnet.ibm.com>
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

On Mon, 13 Mar 2017 11:31:28 +0530
"Gautham R. Shenoy" <ego@linux.vnet.ibm.com> wrote:

> From: "Gautham R. Shenoy" <ego@linux.vnet.ibm.com>
> 
> POWER9 platform can be configured to rebalance per-thread resources
> within a core in order to improve SMT performance.  Certain STOP
> states can be configure to relinquish resources include some
> hypervisor SPRs in order to enable SMT thread folding.
> 
> Due to relinquishing of per-thread resources under certain platform
> configuration, certain SPR context could be lost within a core that
> needs to be recovered.  This state lose is due to reconfiguration of
> SMT threads and not due to actual electrical power lose.

Interesting. This will clash slightly with my patches, but that's
no big deal.


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
> [Changelog written with inputs from svaidy@linux.vnet.ibm.com]
> 
> Signed-off-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/paca.h       |  5 ++++
>  arch/powerpc/kernel/asm-offsets.c     |  1 +
>  arch/powerpc/kernel/idle_book3s.S     | 43 ++++++++++++++++++++++++++++++++++-
>  arch/powerpc/platforms/powernv/idle.c | 22 ++++++++++++++++++
>  4 files changed, 70 insertions(+), 1 deletion(-)
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
> index 9957287..5a90f2c 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -385,7 +385,48 @@ _GLOBAL(power9_idle_stop)
>   */
>  _GLOBAL(pnv_restore_hyp_resource)
>  BEGIN_FTR_SECTION
> -	ld	r2,PACATOC(r13);
> +BEGIN_FTR_SECTION_NESTED(70)
> +/* Save our LR in r17 */
> +	mflr 	r17
> +/*
> + * On entering certain stop states, the thread might relinquish its
> + * per-thread resources due to some reconfiguration for improved SMT
> + * performance. This would result in certain SPR context such as
> + * HSPRG0 (which contains the paca pointer) to be lost within the core.
> + *
> + * Fortunately, the PIR is invariant to thread reconfiguration. Since
> + * this thread's paca pointer is recorded in all its sibling's
> + * paca, we can correctly recover this thread's paca pointer if we
> + * know the index of this thread in the core.
> + * This index can be obtained from the lower two bits of the PIR.
> + *
> + * i.e, thread's position in the core = PIR[62:63].
> + * If this value is i, then this thread's paca is
> + * paca->thread_sibling_pacas[i].
> + */
> +	mfspr	r4, SPRN_PIR
> +	andi.	r4, r4, 0x3
> +/*
> + * Since each entry in thread_sibling_pacas is 8 bytes
> + * we need to left-shift by 3 bits. Thus r4 = i * 8
> + */
> +	sldi	r4, r4, 3
> +/* Get &paca->thread_sibling_pacas[0] in r5 */
> +	addi	r5, r13, PACA_SIBLING_PACA_PTRS

I don't actually understand how this works. We have in r13 a paca
pointer already, and it must be a pointer to one of the threads in
this core, but it may not be a pointer to this thread's paca?

Can you explain how that works a bit more? Where does that r13 come
from?

The exception code before we reach here already saves registers into
the paca save area (PACA_EXGEN), so this is going to go bad if we
are saving into another thread's paca. I have a patch that makes the
0x100 vector use a a new save area, which would make it mostly work
(ignoring rare system reset interrupts).

And if we have any valid paca there, we should be able to load kbase
from it, so that should work with relocatable kernel.

But that all hinges on what exactly this r13 is...

Thanks,
Nick
