Return-Path: <ego@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkRhm6wHHzDq5x
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 22:54:15 +1100 (AEDT)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2GBnFjN039445
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 07:54:10 -0400
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 by mx0a-001b2d01.pphosted.com with ESMTP id 297r0cybr8-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 07:54:09 -0400
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ego@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 07:54:09 -0400
Date: Thu, 16 Mar 2017 17:24:03 +0530
From: Gautham R Shenoy <ego@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>
Cc: linuxppc-dev@lists.ozlabs.org, Gautham R Shenoy <ego@linux.vnet.ibm.com>,
 Vaidyanathan Srinivasan <svaidy@linux.vnet.ibm.com>
Subject: Re: [PATCH 5/8] powerpc/64s: use PACA_THREAD_IDLE_STATE only in POWER8
Reply-To: ego@linux.vnet.ibm.com
References: <20170314092349.10981-1-npiggin@gmail.com>
 <20170314092349.10981-6-npiggin@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
In-Reply-To: <20170314092349.10981-6-npiggin@gmail.com>
Message-Id: <20170316115403.GC16462@in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Hi Nick,

On Tue, Mar 14, 2017 at 07:23:46PM +1000, Nicholas Piggin wrote:
> POWER9 does not use this field, so it should be moved into the POWER8
> code. Update the documentation in the paca struct too.
> 
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/paca.h   | 12 ++++++++++--
>  arch/powerpc/kernel/idle_book3s.S | 13 +++++++------
>  2 files changed, 17 insertions(+), 8 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/paca.h b/arch/powerpc/include/asm/paca.h
> index 708c3e592eeb..bbb59e226a9f 100644
> --- a/arch/powerpc/include/asm/paca.h
> +++ b/arch/powerpc/include/asm/paca.h
> @@ -165,11 +165,19 @@ struct paca_struct {
>  #endif
> 
>  #ifdef CONFIG_PPC_POWERNV
> -	/* Per-core mask tracking idle threads and a lock bit-[L][TTTTTTTT] */
> +	/* CPU idle fields */
> +
> +	/*
> +	 * Per-core word used to synchronize between threads. See
> +	 * asm/cpuidle.h, PNV_CORE_IDLE_*
> +	 */
>  	u32 *core_idle_state_ptr;
> -	u8 thread_idle_state;		/* PNV_THREAD_RUNNING/NAP/SLEEP	*/
>  	/* Mask to indicate thread id in core */
>  	u8 thread_mask;
> +
> +	/* POWER8 specific fields */
> +	/* PNV_THREAD_RUNNING/NAP/SLEEP	*/
> +	u8 thread_idle_state;

I am planning to use this in POWER9 DD1 to distinguish between a
SRESET received when the thread was running vs when it was in stop.
Unfortunately the SRR1[46:47] are not cleared in the former case. So
we need a way in software to distinguish between the two.

>  	/* Mask to denote subcore sibling threads */
>  	u8 subcore_sibling_mask;
>  #endif
> diff --git a/arch/powerpc/kernel/idle_book3s.S b/arch/powerpc/kernel/idle_book3s.S
> index 9284ea0762b1..9bdfba75a5e7 100644
> --- a/arch/powerpc/kernel/idle_book3s.S
> +++ b/arch/powerpc/kernel/idle_book3s.S
> @@ -389,9 +389,6 @@ FTR_SECTION_ELSE
>  	bl	pnv_restore_hyp_resource_arch207
>  ALT_FTR_SECTION_END_IFSET(CPU_FTR_ARCH_300)
> 
> -	li	r0,PNV_THREAD_RUNNING
> -	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
> -
>  #ifdef CONFIG_KVM_BOOK3S_HV_POSSIBLE
>  	li	r0,KVM_HWTHREAD_IN_KERNEL
>  	stb	r0,HSTATE_HWTHREAD_STATE(r13)
> @@ -445,9 +442,13 @@ pnv_restore_hyp_resource_arch207:
>  	ld	r2,PACATOC(r13);
> 
>  	lbz	r0,PACA_THREAD_IDLE_STATE(r13)
> -	cmpwi   cr2,r0,PNV_THREAD_NAP
> -	cmpwi   cr4,r0,PNV_THREAD_WINKLE
> -	bgt     cr2,pnv_wakeup_tb_loss	/* Either sleep or Winkle */
> +	cmpwi	cr2,r0,PNV_THREAD_NAP
> +	cmpwi	cr4,r0,PNV_THREAD_WINKLE
> +	li	r0,PNV_THREAD_RUNNING
> +	stb	r0,PACA_THREAD_IDLE_STATE(r13)	/* Clear thread state */
> +
> +	bgt	cr2,pnv_wakeup_tb_loss	/* Either sleep or Winkle */
> +
> 
>  	/*
>  	 * We fall through here if PACA_THREAD_IDLE_STATE shows we are waking
> -- 
> 2.11.0
> 
