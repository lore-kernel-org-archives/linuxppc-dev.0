Return-Path: <mahesh@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vkSkt653SzDq8f
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 23:41:10 +1100 (AEDT)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2GCdvee135963
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 08:41:01 -0400
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 by mx0a-001b2d01.pphosted.com with ESMTP id 297mmxba5c-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 08:41:01 -0400
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <mahesh@linux.vnet.ibm.com>;
 Thu, 16 Mar 2017 18:10:58 +0530
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay01.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2GCeshs10289294
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:10:54 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2GCerPE030499
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 16 Mar 2017 18:10:54 +0530
Subject: Re: [PATCH 4/8] powerpc/64s: fix POWER9 machine check handler from
 stop state
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
References: <20170314092349.10981-1-npiggin@gmail.com>
 <20170314092349.10981-5-npiggin@gmail.com>
Cc: Gautham R Shenoy <ego@linux.vnet.ibm.com>
From: Mahesh Jagannath Salgaonkar <mahesh@linux.vnet.ibm.com>
Date: Thu, 16 Mar 2017 18:10:48 +0530
MIME-Version: 1.0
In-Reply-To: <20170314092349.10981-5-npiggin@gmail.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <67bd0a9f-ebaa-acdb-cfbf-8a4acba256a3@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 03/14/2017 02:53 PM, Nicholas Piggin wrote:
> The ISA specifies power save wakeup can cause a machine check interrupt.
> The machine check handler currently has code to handle that for POWER8,
> but POWER9 crashes when trying to execute the P8 style sleep
> instructions.
> 
> So queue up the machine check, then call into the idle code to wake up
> as the system reset interrupt does, rather than attempting to sleep
> again without going through the main idle path.
> 
> Reviewed-by: Gautham R. Shenoy <ego@linux.vnet.ibm.com>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>
> ---
>  arch/powerpc/include/asm/reg.h       |  1 +
>  arch/powerpc/kernel/exceptions-64s.S | 69 ++++++++++++++++++------------------
>  2 files changed, 35 insertions(+), 35 deletions(-)
> 
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index fc879fd6bdae..8bbdfacce970 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -656,6 +656,7 @@
>  #define   SRR1_ISI_PROT		0x08000000 /* ISI: Other protection fault */
>  #define   SRR1_WAKEMASK		0x00380000 /* reason for wakeup */
>  #define   SRR1_WAKEMASK_P8	0x003c0000 /* reason for wakeup on POWER8 and 9 */
> +#define   SRR1_WAKEMCE_RESVD	0x003c0000 /* Unused/reserved value used by MCE wakeup to indicate cause to idle wakeup handler */
>  #define   SRR1_WAKESYSERR	0x00300000 /* System error */
>  #define   SRR1_WAKEEE		0x00200000 /* External interrupt */
>  #define   SRR1_WAKEHVI		0x00240000 /* Hypervisor Virtualization Interrupt (P9) */
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index e390fcd04bcb..5779d2d6a192 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -306,6 +306,33 @@ EXC_COMMON_BEGIN(machine_check_common)
>  	/* restore original r1. */			\
>  	ld	r1,GPR1(r1)
> 
> +#ifdef CONFIG_PPC_P7_NAP
> +EXC_COMMON_BEGIN(machine_check_idle_common)
> +	bl	machine_check_queue_event
> +	/*
> +	 * Queue the machine check, then reload SRR1 and use it to set
> +	 * CR3 according to pnv_powersave_wakeup convention.
> +	 */
> +	ld	r12,_MSR(r1)
> +	rlwinm	r11,r12,47-31,30,31
> +	cmpwi	cr3,r11,2
> +
> +	/*
> +	 * Now put SRR1_WAKEMCE_RESVD into SRR1, allows it to follow the
> +	 * system reset wakeup code.
> +	 */
> +	oris	r12,r12,SRR1_WAKEMCE_RESVD@h
> +	mtspr	SPRN_SRR1,r12
> +	std	r12,_MSR(r1)
> +
> +	/*
> +	 * Decrement MCE nesting after finishing with the stack.
> +	 */
> +	lhz	r11,PACA_IN_MCE(r13)
> +	subi	r11,r11,1
> +	sth	r11,PACA_IN_MCE(r13)

Looks like we are not winding up.. Shouldn't we ? What if we may end up
in pnv_wakeup_noloss() which assumes that no GPRs are lost. Am I missing
anything ?

> +	b	pnv_powersave_wakeup
> +#endif
>  	/*

[...]

Rest looks good to me.

Reviewed-by: Mahesh J Salgaonkar <mahesh@linux.vnet.ibm.com>

Thanks,
-Mahesh.
