Return-Path: <mikey@neuling.org>
From: Michael Neuling <mikey@neuling.org>
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH] KVM: PPC: BookE: HV: Fix compile
In-reply-to: <1343170954-9460-1-git-send-email-agraf@suse.de>
References: <1343170954-9460-1-git-send-email-agraf@suse.de>
Date: Thu, 26 Jul 2012 10:31:47 +1000
Message-ID: <9849.1343262707@neuling.org>
Cc: linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
 Linus Torvalds <torvalds@linux-foundation.org>, KVM list <kvm@vger.kernel.org>,
 kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexander Graf <agraf@suse.de> wrote:

> After merging the register type check patches from Ben's tree, the
> hv enabled booke implementation ceased to compile.
> 
> This patch fixes things up so everyone's happy again.

Is there a defconfig which catches this?

Mikey

> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  arch/powerpc/kvm/bookehv_interrupts.S |   77 +++++++++++++++++----------------
>  1 files changed, 39 insertions(+), 38 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
> index d28c2d4..099fe82 100644
> --- a/arch/powerpc/kvm/bookehv_interrupts.S
> +++ b/arch/powerpc/kvm/bookehv_interrupts.S
> @@ -50,8 +50,9 @@
>  #define HOST_R2         (3 * LONGBYTES)
>  #define HOST_CR         (4 * LONGBYTES)
>  #define HOST_NV_GPRS    (5 * LONGBYTES)
> -#define HOST_NV_GPR(n)  (HOST_NV_GPRS + ((n - 14) * LONGBYTES))
> -#define HOST_MIN_STACK_SIZE (HOST_NV_GPR(31) + LONGBYTES)
> +#define __HOST_NV_GPR(n)  (HOST_NV_GPRS + ((n - 14) * LONGBYTES))
> +#define HOST_NV_GPR(n)  __HOST_NV_GPR(__REG_##n)
> +#define HOST_MIN_STACK_SIZE (HOST_NV_GPR(R31) + LONGBYTES)
>  #define HOST_STACK_SIZE ((HOST_MIN_STACK_SIZE + 15) & ~15) /* Align. */
>  #define HOST_STACK_LR   (HOST_STACK_SIZE + LONGBYTES) /* In caller stack frame. */
>  
> @@ -410,24 +411,24 @@ heavyweight_exit:
>  	PPC_STL	r31, VCPU_GPR(R31)(r4)
>  
>  	/* Load host non-volatile register state from host stack. */
> -	PPC_LL	r14, HOST_NV_GPR(r14)(r1)
> -	PPC_LL	r15, HOST_NV_GPR(r15)(r1)
> -	PPC_LL	r16, HOST_NV_GPR(r16)(r1)
> -	PPC_LL	r17, HOST_NV_GPR(r17)(r1)
> -	PPC_LL	r18, HOST_NV_GPR(r18)(r1)
> -	PPC_LL	r19, HOST_NV_GPR(r19)(r1)
> -	PPC_LL	r20, HOST_NV_GPR(r20)(r1)
> -	PPC_LL	r21, HOST_NV_GPR(r21)(r1)
> -	PPC_LL	r22, HOST_NV_GPR(r22)(r1)
> -	PPC_LL	r23, HOST_NV_GPR(r23)(r1)
> -	PPC_LL	r24, HOST_NV_GPR(r24)(r1)
> -	PPC_LL	r25, HOST_NV_GPR(r25)(r1)
> -	PPC_LL	r26, HOST_NV_GPR(r26)(r1)
> -	PPC_LL	r27, HOST_NV_GPR(r27)(r1)
> -	PPC_LL	r28, HOST_NV_GPR(r28)(r1)
> -	PPC_LL	r29, HOST_NV_GPR(r29)(r1)
> -	PPC_LL	r30, HOST_NV_GPR(r30)(r1)
> -	PPC_LL	r31, HOST_NV_GPR(r31)(r1)
> +	PPC_LL	r14, HOST_NV_GPR(R14)(r1)
> +	PPC_LL	r15, HOST_NV_GPR(R15)(r1)
> +	PPC_LL	r16, HOST_NV_GPR(R16)(r1)
> +	PPC_LL	r17, HOST_NV_GPR(R17)(r1)
> +	PPC_LL	r18, HOST_NV_GPR(R18)(r1)
> +	PPC_LL	r19, HOST_NV_GPR(R19)(r1)
> +	PPC_LL	r20, HOST_NV_GPR(R20)(r1)
> +	PPC_LL	r21, HOST_NV_GPR(R21)(r1)
> +	PPC_LL	r22, HOST_NV_GPR(R22)(r1)
> +	PPC_LL	r23, HOST_NV_GPR(R23)(r1)
> +	PPC_LL	r24, HOST_NV_GPR(R24)(r1)
> +	PPC_LL	r25, HOST_NV_GPR(R25)(r1)
> +	PPC_LL	r26, HOST_NV_GPR(R26)(r1)
> +	PPC_LL	r27, HOST_NV_GPR(R27)(r1)
> +	PPC_LL	r28, HOST_NV_GPR(R28)(r1)
> +	PPC_LL	r29, HOST_NV_GPR(R29)(r1)
> +	PPC_LL	r30, HOST_NV_GPR(R30)(r1)
> +	PPC_LL	r31, HOST_NV_GPR(R31)(r1)
>  
>  	/* Return to kvm_vcpu_run(). */
>  	mtlr	r5
> @@ -453,24 +454,24 @@ _GLOBAL(__kvmppc_vcpu_run)
>  	stw	r5, HOST_CR(r1)
>  
>  	/* Save host non-volatile register state to stack. */
> -	PPC_STL	r14, HOST_NV_GPR(r14)(r1)
> -	PPC_STL	r15, HOST_NV_GPR(r15)(r1)
> -	PPC_STL	r16, HOST_NV_GPR(r16)(r1)
> -	PPC_STL	r17, HOST_NV_GPR(r17)(r1)
> -	PPC_STL	r18, HOST_NV_GPR(r18)(r1)
> -	PPC_STL	r19, HOST_NV_GPR(r19)(r1)
> -	PPC_STL	r20, HOST_NV_GPR(r20)(r1)
> -	PPC_STL	r21, HOST_NV_GPR(r21)(r1)
> -	PPC_STL	r22, HOST_NV_GPR(r22)(r1)
> -	PPC_STL	r23, HOST_NV_GPR(r23)(r1)
> -	PPC_STL	r24, HOST_NV_GPR(r24)(r1)
> -	PPC_STL	r25, HOST_NV_GPR(r25)(r1)
> -	PPC_STL	r26, HOST_NV_GPR(r26)(r1)
> -	PPC_STL	r27, HOST_NV_GPR(r27)(r1)
> -	PPC_STL	r28, HOST_NV_GPR(r28)(r1)
> -	PPC_STL	r29, HOST_NV_GPR(r29)(r1)
> -	PPC_STL	r30, HOST_NV_GPR(r30)(r1)
> -	PPC_STL	r31, HOST_NV_GPR(r31)(r1)
> +	PPC_STL	r14, HOST_NV_GPR(R14)(r1)
> +	PPC_STL	r15, HOST_NV_GPR(R15)(r1)
> +	PPC_STL	r16, HOST_NV_GPR(R16)(r1)
> +	PPC_STL	r17, HOST_NV_GPR(R17)(r1)
> +	PPC_STL	r18, HOST_NV_GPR(R18)(r1)
> +	PPC_STL	r19, HOST_NV_GPR(R19)(r1)
> +	PPC_STL	r20, HOST_NV_GPR(R20)(r1)
> +	PPC_STL	r21, HOST_NV_GPR(R21)(r1)
> +	PPC_STL	r22, HOST_NV_GPR(R22)(r1)
> +	PPC_STL	r23, HOST_NV_GPR(R23)(r1)
> +	PPC_STL	r24, HOST_NV_GPR(R24)(r1)
> +	PPC_STL	r25, HOST_NV_GPR(R25)(r1)
> +	PPC_STL	r26, HOST_NV_GPR(R26)(r1)
> +	PPC_STL	r27, HOST_NV_GPR(R27)(r1)
> +	PPC_STL	r28, HOST_NV_GPR(R28)(r1)
> +	PPC_STL	r29, HOST_NV_GPR(R29)(r1)
> +	PPC_STL	r30, HOST_NV_GPR(R30)(r1)
> +	PPC_STL	r31, HOST_NV_GPR(R31)(r1)
>  
>  	/* Load guest non-volatiles. */
>  	PPC_LL	r14, VCPU_GPR(R14)(r4)
> -- 
> 1.6.0.2
> 
> _______________________________________________
> Linuxppc-dev mailing list
> Linuxppc-dev@lists.ozlabs.org
> https://lists.ozlabs.org/listinfo/linuxppc-dev
> 
