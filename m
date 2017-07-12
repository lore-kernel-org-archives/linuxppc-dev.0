Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6s6t4Z6szDqgR
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 18:09:26 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6C63jFm093388
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 02:08:08 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bncj4u2rd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 02:08:07 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 12 Jul 2017 16:08:04 +1000
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6C6837x27328586
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 16:08:03 +1000
Received: from d23av04.au.ibm.com (localhost [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6C681wK028520
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jul 2017 16:08:01 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Neuling <michael.neuling@au1.ibm.com>
Subject: Re: [PATCH] powerpc: Hande page faults for bad paste and bad AMO
In-Reply-To: <1499830007.2865.36.camel@kernel.crashing.org>
References: <1499830007.2865.36.camel@kernel.crashing.org>
Date: Wed, 12 Jul 2017 11:37:55 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <8760eyqjb8.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> On POWER9 and bad paste instruction (targeting the wrong memory
> type) or an invalid opcode in an AMO (atomic memory operation)
> will result in specific DSISR bits to be set.
>
> We currently don't understand those bits and thus just "hang"
> the process taking constant page faults.
>
> Additionally in the case of paste, it appears that we don't
> always get a valid DAR value when the error is a wrong memory
> type.
>
> So we need to test those errors early in do_page_fault(),
> I chose to generate a SIGBUS which is more correct than a SIGSEGV.

This is true even for hash right ? If so do we want to update
do_hash_page:
#ifdef CONFIG_PPC_STD_MMU_64
	andis.	r0,r4,0xa450		/* weird error? */
	bne-	handle_page_fault	/* if not, try to insert a HPTE */

that 0xa450 such that we add these errors and call hand_page_fault in
case of these DSISR values ?


>
> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> ---
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 0266c664014a..5dfce2022f74 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -337,6 +337,21 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  	}
>  #endif /* CONFIG_PPC_ICSWX */
>  
> +#ifdef CONFIG_PPC_STD_MMU_64
> +	/*
> +	 * These faults indicate a copy/paste on an invalid memory type
> +	 * or an incorrect AMO operation. They have been observed as not
> +	 * properly updating the DAR, so handle them early
> +	 */
> +	if (error_code & (DSISR_BAD_COPYPASTE | DSISR_BAD_AMO)) {
> +		if (user_mode(regs))
> +			_exception(SIGBUS, regs, BUS_OBJERR, address);
> +		else
> +			rc = SIGBUS;
> +		goto bail;
> +	}
> +#endif /* CONFIG_PPC_STD_MMU_64 */
> +
>  	if (notify_page_fault(regs))
>  		goto bail;
>  
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 7e50e47375d6..71f524f2b109 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -282,6 +282,8 @@
>  #define   DSISR_UNSUPP_MMU	0x00080000	/* Unsupported MMU config */
>  #define   DSISR_SET_RC		0x00040000	/* Failed setting of R/C bits */
>  #define   DSISR_PGDIRFAULT      0x00020000      /* Fault on page directory */
> +#define   DSISR_BAD_COPYPASTE   0x00000008      /* Copy/Paste on wrong mem type */
> +#define   DSISR_BAD_AMO		0x00000004	/* Incorrect AMO opcode */
>  #define SPRN_TBRL	0x10C	/* Time Base Read Lower Register (user, R/O) */
>  #define SPRN_TBRU	0x10D	/* Time Base Read Upper Register (user, R/O) */
>  #define SPRN_CIR	0x11B	/* Chip Information Register (hyper, R/0) */

-aneesh
