Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vl0qv4v0MzDqXc
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 20:47:23 +1100 (AEDT)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2H9d1JS085038
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 05:47:19 -0400
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 297nkpdwnh-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 17 Mar 2017 05:47:18 -0400
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Fri, 17 Mar 2017 05:47:18 -0400
Date: Fri, 17 Mar 2017 15:17:13 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/64s: fix idle wakeup potential to clobber
 registers
Reply-To: ego@linux.vnet.ibm.com
References: <20170317051320.7069-1-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170317051320.7069-1-npiggin@gmail.com>
Message-Id: <20170317094713.GH16462@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi ,


On Fri, Mar 17, 2017 at 03:13:20PM +1000, Nicholas Piggin wrote:
> We concluded there may be a window where the idle wakeup code could
> get to pnv_wakeup_tb_loss (which clobbers non-volatile GPRs), but the
> hardware may set SRR1[46:47] to 01b (no state loss) which would
> result in the wakeup code failing to restore non-volatile GPRs.
> 
> I was not able to trigger this condition with trivial tests on
> real hardware or simulator, but the ISA (at least 2.07) seems to
> allow for it, and Gautham says that it can happen if there is an
> exception pending when the sleep/winkle instruction is executed.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Acked-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

This fix should go into stable v4.8,v4.9 and v4.10.

Prior to commit 83289f909a72 ("powerpc/powernv: Rename idle_power7.S
to idle_book3s.S"), pnv_wakeup_tb_loss was explicitly restoring all
the GPRs to the saved value. So we are good for all the previous
kernel versions.

> ---
>  arch/powerpc/kernel/idle_book3s.S | 20 +++++++++++++++++---
>  1 file changed, 17 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 995728736677..6fd08219248d 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -449,9 +449,23 @@ END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
>  _GLOBAL(pnv_wakeup_tb_loss)
>  	ld	r1,PACAR1(r13)
>  	/*
> -	 * Before entering any idle state, the NVGPRs are saved in the stack
> -	 * and they are restored before switching to the process context. Hence
> -	 * until they are restored, they are free to be used.
> +	 * Before entering any idle state, the NVGPRs are saved in the stack.
> +	 * If there was a state loss, or PACA_NAPSTATELOST was set, then the
> +	 * NVGPRs are restored. If we are here, it is likely that state is lost,
> +	 * but not guaranteed -- neither ISA207 nor ISA300 tests to reach
> +	 * here are the same as the test to restore NVGPRS:
> +	 * PACA_THREAD_IDLE_STATE test for ISA207, PSSCR test for ISA300,
> +	 * and SRR1 test for restoring NVGPRs.
> +	 *
> +	 * We are about to clobber NVGPRs now, so set NAPSTATELOST to
> +	 * guarantee they will always be restored. This might be tightened
> +	 * with careful reading of specs (particularly for ISA300) but this
> +	 * is already a slow wakeup path and it's simpler to be safe.
> +	 */
> +	li	r0,1
> +	stb	r0,PACA_NAPSTATELOST(r13)
> +
> +	/*
>  	 *
>  	 * Save SRR1 and LR in NVGPRs as they might be clobbered in
>  	 * opal_call() (called in CHECK_HMI_INTERRUPT). SRR1 is required
> -- 
> 2.11.0
> 
--
Thanks and Regards
gautham.
