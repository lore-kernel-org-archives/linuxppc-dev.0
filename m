Return-Path: <ego@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rDTBx42XbzDqDq
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 24 May 2016 18:31:05 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Tue, 24 May 2016 04:31:03 -0400
Date: Tue, 24 May 2016 14:00:49 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: "Shreyas B. Prabhu" <shreyas@linux.vnet.ibm.com>
Cc: mpe@ellerman.id.au, linuxppc-dev@lists.ozlabs.org, paulus@ozlabs.org,
 linux-kernel@vger.kernel.org, mikey@neuling.org, ego@linux.vnet.ibm.com
Subject: Re: [PATCH v3 3/9] powerpc/powernv: Rename reusable idle functions
 to hardware agnostic names
Message-ID: <20160524083049.GB12860@in.ibm.com>
Reply-To: ego@linux.vnet.ibm.com
References: <1464016722-7488-1-git-send-email-shreyas@linux.vnet.ibm.com>
 <1464016722-7488-4-git-send-email-shreyas@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <1464016722-7488-4-git-send-email-shreyas@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Mon, May 23, 2016 at 08:48:36PM +0530, Shreyas B. Prabhu wrote:
> Functions like power7_wakeup_loss, power7_wakeup_noloss,
> power7_wakeup_tb_loss are used by POWER7 and POWER8 hardware. They can
> also be used by POWER9. Hence rename these functions hardware agnostic
> names.
> 
> Suggested-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> ---
> New in v3
> 
>  arch/powerpc/kernel/exceptions-64s.S    |  6 +++---
>  arch/powerpc/kernel/idle_power_common.S | 16 ++++++++--------
>  arch/powerpc/kvm/book3s_hv_rmhandlers.S |  4 ++--
>  3 files changed, 13 insertions(+), 13 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 4a74d6a..a0da627 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -108,7 +108,7 @@ BEGIN_FTR_SECTION
> 
>  	cmpwi	cr3,r13,2
>  	GET_PACA(r13)
> -	bl	power7_restore_hyp_resource
> +	bl	pnv_restore_hyp_resource
> 
>  	li	r0,PNV_THREAD_RUNNING
>  	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
> @@ -128,8 +128,8 @@ BEGIN_FTR_SECTION
>  	/* Return SRR1 from power7_nap() */
>  	mfspr	r3,SPRN_SRR1
>  	blt	cr3,2f
> -	b	power7_wakeup_loss
> -2:	b	power7_wakeup_noloss
> +	b	pnv_wakeup_loss
> +2:	b	pnv_wakeup_noloss
> 
>  9:
>  END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
> diff --git a/arch/powerpc/kernel/idle_power_common.S b/arch/powerpc/kernel/idle_power_common.S
> index db59613..973c9a1 100644
> --- a/arch/powerpc/kernel/idle_power_common.S
> +++ b/arch/powerpc/kernel/idle_power_common.S

The comment at the beginning of idle_power_common.S still reads

"This file contains the power_save function for Power7 CPUs."

Please update that as well.

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
