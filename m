Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkQzX14sQzDqGk
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 22:21:59 +1100 (AEDT)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2GBDT40093983
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 07:21:56 -0400
Received: from e12.ny.us.ibm.com (e12.ny.us.ibm.com [129.33.205.202])
 by mx0a-001b2d01.pphosted.com with ESMTP id 297s9s1hgc-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 07:21:55 -0400
Received: from localhost
 by e12.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 07:21:54 -0400
Date: Thu, 16 Mar 2017 16:51:49 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 3/8] powerpc/64s: use alternative feature patching
Reply-To: ego@linux.vnet.ibm.com
References: <20170314092349.10981-1-npiggin@gmail.com>
 <20170314092349.10981-4-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170314092349.10981-4-npiggin@gmail.com>
Message-Id: <20170316112149.GB16462@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On Tue, Mar 14, 2017 at 07:23:44PM +1000, Nicholas Piggin wrote:
> This reduces the number of nops for POWER8.

Nice!
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>

> ---
>  arch/powerpc/kernel/idle_book3s.S | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 405631b2c229..9284ea0762b1 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -383,7 +383,11 @@ _GLOBAL(power9_idle_stop)
>   */
>  .global pnv_powersave_wakeup
>  pnv_powersave_wakeup:
> -	bl	pnv_restore_hyp_resource
> +BEGIN_FTR_SECTION
> +	bl	pnv_restore_hyp_resource_arch300
> +FTR_SECTION_ELSE
> +	bl	pnv_restore_hyp_resource_arch207
> +ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
> 
>  	li	r0,PNV_THREAD_RUNNING
>  	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
> @@ -411,14 +415,13 @@ pnv_powersave_wakeup:
>   *
>   * cr3 - set to gt if waking up with partial/complete hypervisor state loss
>   */
> -pnv_restore_hyp_resource:
> -	ld	r2,PACATOC(r13);
> -
> -BEGIN_FTR_SECTION
> +pnv_restore_hyp_resource_arch300:
>  	/*
>  	 * POWER ISA 3. Use PSSCR to determine if we
>  	 * are waking up from deep idle state
>  	 */
> +	ld	r2,PACATOC(r13);
> +
>  	LOAD_REG_ADDRBASE(r5,pnv_first_deep_stop_state)
>  	ld	r4,ADDROFF(pnv_first_deep_stop_state)(r5)
> 
> @@ -433,12 +436,14 @@ BEGIN_FTR_SECTION
> 
>  	blr	/* Waking up without hypervisor state loss. */
> 
> -END_FTR_SECTION_IFSET(CPU_FTR_ARCH_300)
> -
> +/* Same calling convention as arch300 */
> +pnv_restore_hyp_resource_arch207:
>  	/*
>  	 * POWER ISA 2.07 or less.
>  	 * Check if we slept with winkle.
>  	 */
> +	ld	r2,PACATOC(r13);
> +
>  	lbz	r0,PACA_THREAD_IDLE_STATE(r13)
>  	cmpwi   cr2,r0,PNV_THREAD_NAP
>  	cmpwi   cr4,r0,PNV_THREAD_WINKLE
> -- 
> 2.11.0
> 
