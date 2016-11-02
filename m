Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3t7yHm3vWFzDt3M
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 17:05:08 +1100 (AEDT)
Received: from pps.filterd (m0098399.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uA264heJ078863
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 02:05:06 -0400
Received: from e23smtp08.au.ibm.com (e23smtp08.au.ibm.com [202.81.31.141])
 by mx0a-001b2d01.pphosted.com with ESMTP id 26f96cc0tm-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 02 Nov 2016 02:05:06 -0400
Received: from localhost
 by e23smtp08.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Wed, 2 Nov 2016 16:05:04 +1000
Received: from d23relay09.au.ibm.com (d23relay09.au.ibm.com [9.185.63.181])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 0B0FC2CE8059
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  2 Nov 2016 17:05:02 +1100 (EST)
Received: from d23av06.au.ibm.com (d23av06.au.ibm.com [9.190.235.151])
 by d23relay09.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uA2652Qg40632368
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 17:05:02 +1100
Received: from d23av06.au.ibm.com (localhost [127.0.0.1])
 by d23av06.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uA2651wN019638
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 2 Nov 2016 17:05:01 +1100
Subject: Re: [PATCH] powerpc/64s: relocation, register save fixes for system
 reset interrupt
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20161013021714.6624-1-npiggin@gmail.com>
Cc: "Shreyas B . Prabhu" <shreyas@linux.vnet.ibm.com>,
 "Gautham R . Shenoy" <ego@linux.vnet.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Wed, 2 Nov 2016 11:34:59 +0530
MIME-Version: 1.0
In-Reply-To: <20161013021714.6624-1-npiggin@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <79d229aa-2b4e-67b7-157b-b839bc390cbf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 10/13/2016 07:47 AM, Nicholas Piggin wrote:
> This patch does a couple of things. First of all, powernv immediately
> explodes when running a relocated kernel, because the system reset
> exception for handling sleeps does not do correct relocated branches.
> 
> Secondly, the sleep handling code trashes the condition and cfar
> registers, which we would like to preserve for debugging purposes (for
> non-sleep case exception).
> 
> This patch changes the exception to use the standard format that saves
> registers before any tests or branches are made. It adds the test for
> idle-wakeup as an "extra" to break out of the normal exception path.
> Then it branches to a relocated idle handler that calls the various
> idle handling functions.
> 
> After this patch, POWER8 CPU simulator now boots powernv kernel that is
> running at non-zero.
> 
> Cc: Balbir Singh <bsingharora@gmail.com>
> Cc: Shreyas B. Prabhu <shreyas@linux.vnet.ibm.com>
> Cc: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/exception-64s.h | 16 ++++++++++
>  arch/powerpc/kernel/exceptions-64s.S     | 50 ++++++++++++++++++--------------
>  2 files changed, 45 insertions(+), 21 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/exception-64s.h b/arch/powerpc/include/asm/exception-64s.h
> index 2e4e7d8..84d49b1 100644
> --- a/arch/powerpc/include/asm/exception-64s.h
> +++ b/arch/powerpc/include/asm/exception-64s.h
> @@ -93,6 +93,10 @@
>  	ld	reg,PACAKBASE(r13);	/* get high part of &label */	\
>  	ori	reg,reg,(FIXED_SYMBOL_ABS_ADDR(label))@l;
> 
> +#define __LOAD_HANDLER(reg, label)					\
> +	ld	reg,PACAKBASE(r13);					\
> +	ori	reg,reg,(ABS_ADDR(label))@l;
> +
>  /* Exception register prefixes */
>  #define EXC_HV	H
>  #define EXC_STD
> @@ -208,6 +212,18 @@ END_FTR_SECTION_NESTED(ftr,ftr,943)
>  #define kvmppc_interrupt kvmppc_interrupt_pr
>  #endif
> 
> +#ifdef CONFIG_RELOCATABLE
> +#define BRANCH_TO_COMMON(reg, label)					\
> +	__LOAD_HANDLER(reg, label);					\
> +	mtctr	reg;							\
> +	bctr
> +
> +#else
> +#define BRANCH_TO_COMMON(reg, label)					\
> +	b	label
> +
> +#endif
> +
>  #define __KVM_HANDLER_PROLOG(area, n)					\
>  	BEGIN_FTR_SECTION_NESTED(947)					\
>  	ld	r10,area+EX_CFAR(r13);					\
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 08992f8..e680e84 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -95,19 +95,35 @@ __start_interrupts:
>  /* No virt vectors corresponding with 0x0..0x100 */
>  EXC_VIRT_NONE(0x4000, 0x4100)
> 
> -EXC_REAL_BEGIN(system_reset, 0x100, 0x200)
> -	SET_SCRATCH0(r13)
> +
>  #ifdef CONFIG_PPC_P7_NAP
> -BEGIN_FTR_SECTION
> -	/* Running native on arch 2.06 or later, check if we are
> -	 * waking up from nap/sleep/winkle.
> +	/*
> +	 * If running native on arch 2.06 or later, check if we are waking up
> +	 * from nap/sleep/winkle, and branch to idle handler.
>  	 */
> -	mfspr	r13,SPRN_SRR1
> -	rlwinm.	r13,r13,47-31,30,31
> -	beq	9f
> +#define IDLETEST(n)							\
> +	BEGIN_FTR_SECTION ;						\
> +	mfspr	r10,SPRN_SRR1 ;						\
> +	rlwinm.	r10,r10,47-31,30,31 ;					\
> +	beq-	1f ;							\
> +	cmpwi	cr3,r10,2 ;						\
> +	BRANCH_TO_COMMON(r10, system_reset_idle_common) ;		\
> +1:									\
> +	END_FTR_SECTION_IFSET(CPU_FTR_HVMODE | CPU_FTR_ARCH_206)
> +#else
> +#define IDLETEST NOTEST
> +#endif
> 
> -	cmpwi	cr3,r13,2
> -	GET_PACA(r13)
> +EXC_REAL_BEGIN(system_reset, 0x100, 0x200)
> +	SET_SCRATCH0(r13)
> +	EXCEPTION_PROLOG_PSERIES(PACA_EXGEN, system_reset_common, EXC_STD,
> +				 IDLETEST, 0x100)

Very sorry for late review. On arch 2.07 and less if we wakeup from
winkle then last bit of HSPGR0 would be set to 1. Hence before we access
paca we need to fix it by clearing that bit and that is done in
pnv_restore_hyp_resource(). But with this patch, we would end up there
after going through EXCEPTION_PROLOG_PSERIES(). This macro gets the paca
using GET_PACA(r13) and all the EXCEPTION_PROLOG_* starts
using/accessing r13/paca without fixing it. Wouldn't this break things
badly on arch 2.07 and less ? Am I missing anything ?

Thanks,
-Mahesh.
