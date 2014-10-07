Return-Path: <benh@kernel.crashing.org>
Received: from gate.crashing.org (gate.crashing.org [63.228.1.57])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 313421A021A
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  7 Oct 2014 16:11:36 +1100 (EST)
Message-ID: <1412658682.30859.137.camel@pasglop>
Subject: Re: [PATCH v2 2/3] powerpc/kvm/book3s_hv: Enable CPUs to run guest
 after waking up from fast-sleep
From: Benjamin Herrenschmidt <benh@kernel.crashing.org>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Date: Tue, 07 Oct 2014 16:11:22 +1100
In-Reply-To: <1412149560-2953-3-git-send-email-shreyas@linux.vnet.ibm.com>
References: <1412149560-2953-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1412149560-2953-3-git-send-email-shreyas@linux.vnet.ibm.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Cc: Preeti U Murthy <preeti@linux.vnet.ibm.com>, linuxppc-dev@lists.ozlabs.org,
 Paul Mackerras <paulus@samba.org>, linux-kernel@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Wed, 2014-10-01 at 13:15 +0530, Shreyas B. Prabhu wrote:
> When guests have to be launched, the secondary threads which are offline
> are woken up to run the guests. Today these threads wake up from nap
> and check if they have to run guests. Now that the offline secondary
> threads can go to fastsleep or going ahead a deeper idle state such as winkle,
> add this check in the wakeup from any of the deep idle states path as well.
> 
> Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> Cc: Paul Mackerras <paulus@samba.org>
> Cc: Michael Ellerman <mpe@ellerman.id.au>
> Cc: linuxppc-dev@lists.ozlabs.org
> Suggested-by: "Srivatsa S. Bhat" <srivatsa@mit.edu>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> [ Changelog added by <preeti@linux.vnet.ibm.com> ]
> Signed-off-by: Preeti U Murthy <preeti@linux.vnet.ibm.com>
> ---
>  arch/powerpc/kernel/exceptions-64s.S | 35 ++++++++++++++++-------------------
>  1 file changed, 16 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 050f79a..c64f3cc0 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -100,25 +100,8 @@ system_reset_pSeries:
>  	SET_SCRATCH0(r13)
>  #ifdef CONFIG_PPC_P7_NAP
>  BEGIN_FTR_SECTION
> -	/* Running native on arch 2.06 or later, check if we are
> -	 * waking up from nap. We only handle no state loss and
> -	 * supervisor state loss. We do -not- handle hypervisor
> -	 * state loss at this time.
> -	 */
> -	mfspr	r13,SPRN_SRR1
> -	rlwinm.	r13,r13,47-31,30,31
> -	beq	9f
>  
> -	/* waking up from powersave (nap) state */
> -	cmpwi	cr1,r13,2
> -	/* Total loss of HV state is fatal, we could try to use the
> -	 * PIR to locate a PACA, then use an emergency stack etc...
> -	 * OPAL v3 based powernv platforms have new idle states
> -	 * which fall in this catagory.
> -	 */
> -	bgt	cr1,8f
>  	GET_PACA(r13)
> -
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  	li	r0,KVM_HWTHREAD_IN_KERNEL
>  	stb	r0,HSTATE_HWTHREAD_STATE(r13)
> @@ -131,13 +114,27 @@ BEGIN_FTR_SECTION
>  1:
>  #endif

So you moved the state loss check to after the KVM check ? Was this
reviewed by Paul ? Is that ok ? (Does this match what we have in
PowerKVM ?). Is it possible that we end up calling kvm_start_guest
after a HV state loss or do we know for sure that this won't happen
for a reason or another ? If that's the case, then that reason needs
to be clearly documented here in a comment.
 
> +	/* Running native on arch 2.06 or later, check if we are
> +	 * waking up from nap. We only handle no state loss and
> +	 * supervisor state loss. We do -not- handle hypervisor
> +	 * state loss at this time.
> +	 */
> +	mfspr	r13,SPRN_SRR1
> +	rlwinm.	r13,r13,47-31,30,31
> +	beq	9f
> +
> +	/* waking up from powersave (nap) state */
> +	cmpwi	cr1,r13,2
> +	GET_PACA(r13)
> +
> +	bgt	cr1,8f
> +
>  	beq	cr1,2f
>  	b	power7_wakeup_noloss
>  2:	b	power7_wakeup_loss
>  
>  	/* Fast Sleep wakeup on PowerNV */
> -8:	GET_PACA(r13)
> -	b 	power7_wakeup_tb_loss
> +8:	b 	power7_wakeup_tb_loss
>  
>  9:
>  END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
