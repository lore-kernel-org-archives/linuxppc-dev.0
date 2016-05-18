Return-Path: <ego@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3r8hGZ1G7FzDqBh
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 18 May 2016 14:36:05 +1000 (AEST)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Wed, 18 May 2016 00:36:03 -0400
Date: Wed, 18 May 2016 10:05:51 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org
Subject: Re: [PATCH v2 1/9] powerpc/powernv: Move CHECK_HMI_INTERRUPT to
 exception-64s header
Message-ID: <20160518043551.GA3939@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1462263878-25237-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1462263878-25237-2-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1462263878-25237-2-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, May 03, 2016 at 01:54:30PM +0530, Shreyas B. Prabhu wrote:
> CHECK_HMI_INTERRUPT is used to check for HMI's in reset vector. Move
> the macro to a common location (exception-64s.h)
> This patch does not change any functionality.
> 

I suppose this code movement is to facilitate the invocation of
CHECK_HMI_INTERRUPT in some later patch ? In this case you could
add this to the commit message.

Otherwise,
Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> ---
>  arch/powerpc/include/asm/exception-64s.h | 18 ++++++++++++++++++
>  arch/powerpc/kernel/idle_power7.S        | 20 +-------------------
>  2 files changed, 19 insertions(+), 19 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> index 93ae809..6a625af 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -545,4 +545,22 @@ END_FTR_SECTION_IFSET(CPU_FTR_CAN_NAP)
>  #define FINISH_NAP
>  #endif
> 
> +#define CHECK_HMI_INTERRUPT						\
> +	mfspr	r0,SPRN_SRR1;						\
> +BEGIN_FTR_SECTION_NESTED(66);						\
> +	rlwinm	r0,r0,45-31,0xf;  /* extract wake reason field (P8) */	\
> +FTR_SECTION_ELSE_NESTED(66);						\
> +	rlwinm	r0,r0,45-31,0xe;  /* P7 wake reason field is 3 bits */	\
> +ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
> +	cmpwi	r0,0xa;			/* Hypervisor maintenance ? */	\
> +	bne	20f;							\
> +	/* Invoke opal call to handle hmi */				\
> +	ld	r2,PACATOC(r13);					\
> +	ld	r1,PACAR1(r13);						\
> +	std	r3,ORIG_GPR3(r1);	/* Save original r3 */		\
> +	li	r0,OPAL_HANDLE_HMI;	/* Pass opal token argument*/	\
> +	bl	opal_call_realmode;					\
> +	ld	r3,ORIG_GPR3(r1);	/* Restore original r3 */	\
> +20:	nop;
> +
>  #endif	/* _ASM_POWERPC_EXCEPTION_H */
> diff --git a/arch/powerpc/kernel/idle_power7.S b/arch/powerpc/kernel/idle_power7.S
> index 470ceeb..6b3404b 100644
> --- a/arch/powerpc/kernel/idle_power7.S
> +++ b/arch/powerpc/kernel/idle_power7.S
> @@ -19,6 +19,7 @@
>  #include <asm/kvm_book3s_asm.h>
>  #include <asm/opal.h>
>  #include <asm/cpuidle.h>
> +#include <asm/exception-64s.h>
>  #include <asm/book3s/64/mmu-hash.h>
> 
>  #undef DEBUG
> @@ -257,25 +258,6 @@ _GLOBAL(power7_winkle)
>  	b	power7_powersave_common
>  	/* No return */
> 
> -#define CHECK_HMI_INTERRUPT						\
> -	mfspr	r0,SPRN_SRR1;						\
> -BEGIN_FTR_SECTION_NESTED(66);						\
> -	rlwinm	r0,r0,45-31,0xf;  /* extract wake reason field (P8) */	\
> -FTR_SECTION_ELSE_NESTED(66);						\
> -	rlwinm	r0,r0,45-31,0xe;  /* P7 wake reason field is 3 bits */	\
> -ALT_FTR_SECTION_END_NESTED_IFSET(CPU_FTR_ARCH_207S, 66);		\
> -	cmpwi	r0,0xa;			/* Hypervisor maintenance ? */	\
> -	bne	20f;							\
> -	/* Invoke opal call to handle hmi */				\
> -	ld	r2,PACATOC(r13);					\
> -	ld	r1,PACAR1(r13);						\
> -	std	r3,ORIG_GPR3(r1);	/* Save original r3 */		\
> -	li	r0,OPAL_HANDLE_HMI;	/* Pass opal token argument*/	\
> -	bl	opal_call_realmode;					\
> -	ld	r3,ORIG_GPR3(r1);	/* Restore original r3 */	\
> -20:	nop;
> -
> -
>  _GLOBAL(power7_wakeup_tb_loss)
>  	ld	r2,PACATOC(r13);
>  	ld	r1,PACAR1(r13)
> -- 
> 2.4.11
> 
