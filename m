Return-Path: <B07421@freescale.com>
Received: from AM1EHSOBE002.bigfish.com (am1ehsobe003.messaging.microsoft.com
 [213.199.154.206])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "Microsoft Secure Server Authority" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 6C11CB6EEC
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 18 Feb 2012 10:17:16 +1100 (EST)
Message-ID: <4F3EDFEE.3040106@freescale.com>
Date: Fri, 17 Feb 2012 17:17:02 -0600
From: Scott Wood <scottwood@freescale.com>
MIME-Version: 1.0
To: Alexander Graf <agraf@suse.de>
Subject: Re: [PATCH 19/30] KVM: PPC: e500mc: add load inst fixup
References: <1329498837-11717-1-git-send-email-agraf@suse.de>
 <1329498837-11717-20-git-send-email-agraf@suse.de>
In-Reply-To: <1329498837-11717-20-git-send-email-agraf@suse.de>
Content-Type: text/plain; charset="UTF-8"
Cc: linuxppc-dev@lists.ozlabs.org, kvm@vger.kernel.org, kvm-ppc@vger.kernel.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 02/17/2012 11:13 AM, Alexander Graf wrote:
> There's always a chance we're unable to read a guest instruction. The guest
> could have its TLB mapped execute-, but not readable, something odd happens
> and our TLB gets flushed. So it's a good idea to be prepared for that case
> and have a fallback that allows us to fix things up in that case.
> 
> Add fixup code that keeps guest code from potentially crashing our host kernel.
> 
> Signed-off-by: Alexander Graf <agraf@suse.de>
> ---
>  arch/powerpc/kvm/bookehv_interrupts.S |   30 +++++++++++++++++++++++++++++-
>  1 files changed, 29 insertions(+), 1 deletions(-)
> 
> diff --git a/arch/powerpc/kvm/bookehv_interrupts.S b/arch/powerpc/kvm/bookehv_interrupts.S
> index 63023ae..e0f484c 100644
> --- a/arch/powerpc/kvm/bookehv_interrupts.S
> +++ b/arch/powerpc/kvm/bookehv_interrupts.S
> @@ -28,6 +28,7 @@
>  #include <asm/asm-compat.h>
>  #include <asm/asm-offsets.h>
>  #include <asm/bitsperlong.h>
> +#include <asm/thread_info.h>
>  
>  #include "../kernel/head_booke.h" /* for THREAD_NORMSAVE() */
>  
> @@ -171,9 +172,36 @@
>  	PPC_STL	r30, VCPU_GPR(r30)(r4)
>  	PPC_STL	r31, VCPU_GPR(r31)(r4)
>  	mtspr	SPRN_EPLC, r8
> +
> +	/* disable preemption, so we are sure we hit the fixup handler */
> +#ifdef CONFIG_PPC64
> +	clrrdi	r8,r1,THREAD_SHIFT
> +#else
> +	rlwinm	r8,r1,0,0,31-THREAD_SHIFT       /* current thread_info */
> +#endif
> +        lwz     r6,TI_PREEMPT(r8)
> +	addi	r7,r6,1
> +        stw     r7,TI_PREEMPT(r8)

Whitespace

The preempt count had better already be zero here, so we can just store
1 now, and 0 later, and avoid the stall on load results.

> +
>  	isync
> -	lwepx	r9, 0, r5
> +
> +	/*
> +	 * In case the read goes wrong, we catch it and write an invalid value
> +	 * in LAST_INST instead.
> +	 */
> +1:	lwepx	r9, 0, r5
> +2:
> +.section .fixup, "ax"
> +3:	li r9, KVM_INST_FETCH_FAILED
> +	b 2b

Please tab after the opcode

> +.previous
> +.section __ex_table,"a"
> +	PPC_LONG_ALIGN
> +	PPC_LONG 1b,3b
> +.previous
> +
>  	mtspr	SPRN_EPLC, r3
> +        stw     r6,TI_PREEMPT(r8)
>  	stw	r9, VCPU_LAST_INST(r4)

Whitespace

-Scott
