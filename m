Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x9sCf4lCWzDrCn
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 15:23:57 +1000 (AEST)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6H5JcW3011418
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 01:23:54 -0400
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bqf6t23m9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 01:23:54 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 17 Jul 2017 15:23:51 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6H5Nfq525624766
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 15:23:49 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6H5NGIL021582
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 17 Jul 2017 15:23:17 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <patch-notifications@ellerman.id.au>,
 Nicholas Piggin <npiggin@gmail.com>
Subject: Re: [PATCH/RFC] powerpc: Better handle "error" type page faults on
 book3s64
In-Reply-To: <1500021087.2865.86.camel@kernel.crashing.org>
References: <1500021087.2865.86.camel@kernel.crashing.org>
Date: Mon, 17 Jul 2017 10:52:49 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87mv83prh2.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Benjamin Herrenschmidt <benh@kernel.crashing.org> writes:

> There are a number of conditions in the DSISR that represent
> conditions for which there is no point looking for a VMA or
> trying to update a PTE. In fact, POWER9 adds a few with bad
> AMOs, bad "paste" instruction etc...
>
> This improve our existing code to use symbolic constants for
> all DSISR bits, properly avoid hash_page() for the new bits,
> and handle both the old and new bits early in do_page_fault()
>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
> --
>
> This obsoletes 
> [PATCH] powerpc: Hande page faults for bad paste and bad AMO
>
> Note: We should further update 32-bit etc... to do something
> similar, or even consolidate the code.
>
> According to architectures back to 1.07 and 32-bit 6xx PEM,
> those low DSISR bits are 0 on all other implementations, and
> we do mask out the SRR1 bits on instruction interrupts, so
> I think such consolidation, at least for BookS should be trivial
> but I will leave it as a separate patch.
>
> ---
>  arch/powerpc/include/asm/reg.h       | 18 ++++++++++++++++++
>  arch/powerpc/kernel/exceptions-64s.S |  6 ++++--
>  arch/powerpc/mm/fault.c              | 21 +++++++++++++++++++++
>  3 files changed, 43 insertions(+), 2 deletions(-)
>
> diff --git a/arch/powerpc/include/asm/reg.h b/arch/powerpc/include/asm/reg.h
> index 7e50e47..bf5f8ff 100644
> --- a/arch/powerpc/include/asm/reg.h
> +++ b/arch/powerpc/include/asm/reg.h
> @@ -272,16 +272,34 @@
>  #define SPRN_DAR	0x013	/* Data Address Register */
>  #define SPRN_DBCR	0x136	/* e300 Data Breakpoint Control Reg */
>  #define SPRN_DSISR	0x012	/* Data Storage Interrupt Status Register */
> +#define   DSISR_BAD_DIRECT_ST	0x80000000	/* Direct store error (obsolete) */
>  #define   DSISR_NOHPTE		0x40000000	/* no translation found */
> +#define   DSISR_ATT_CONFLICT	0x20000000	/* Attribute conflicts (P9) */
>  #define   DSISR_PROTFAULT	0x08000000	/* protection fault */
>  #define   DSISR_BADACCESS	0x04000000	/* bad access to CI or G */
>  #define   DSISR_ISSTORE		0x02000000	/* access was a store */
>  #define   DSISR_DABRMATCH	0x00400000	/* hit data breakpoint */
>  #define   DSISR_NOSEGMENT	0x00200000	/* SLB miss */
>  #define   DSISR_KEYFAULT	0x00200000	/* Key fault */
> +#define   DSISR_BAD_EXT_CTRL	0x00100000	/* External control error (obsolete) */
>  #define   DSISR_UNSUPP_MMU	0x00080000	/* Unsupported MMU config */
>  #define   DSISR_SET_RC		0x00040000	/* Failed setting of R/C bits */
>  #define   DSISR_PGDIRFAULT      0x00020000      /* Fault on page directory */
> +#define   DSISR_BAD_COPYPASTE   0x00000008      /* Copy/Paste on wrong mem type */
> +#define   DSISR_BAD_AMO		0x00000004	/* Incorrect AMO opcode */
> +#define   DSISR_BAD_CI_LDST	0x00000002	/* CI load/store with DR=1 or in G=0 HV space */
> +
> +/* Don't bother going to hash_page for any of these */
> +#define   DSISR_DONT_HASH	(DSISR_BAD_DIRECT_ST |	\
> +				 DSISR_ATT_CONFLICT |	\
> +				 DSISR_BADACCESS |	\
> +				 DSISR_DABRMATCH |	\
> +				 DSISR_BAD_EXT_CTRL |   \
> +				 DSISR_UNSUPP_MMU |	\
> +				 DSISR_BAD_COPYPASTE |	\
> +				 DSISR_BAD_AMO |	\
> +				 DSISR_BAD_CI_LDST)
> +
>  #define SPRN_TBRL	0x10C	/* Time Base Read Lower Register (user, R/O) */
>  #define SPRN_TBRU	0x10D	/* Time Base Read Upper Register (user, R/O) */
>  #define SPRN_CIR	0x11B	/* Chip Information Register (hyper, R/0) */
> diff --git a/arch/powerpc/kernel/exceptions-64s.S b/arch/powerpc/kernel/exceptions-64s.S
> index 5204bd6..58ad8ae 100644
> --- a/arch/powerpc/kernel/exceptions-64s.S
> +++ b/arch/powerpc/kernel/exceptions-64s.S
> @@ -1413,8 +1413,10 @@ USE_TEXT_SECTION()
>  	.balign	IFETCH_ALIGN_BYTES
>  do_hash_page:
>  #ifdef CONFIG_PPC_STD_MMU_64
> -	andis.	r0,r4,0xa450		/* weird error? */
> -	bne-	handle_page_fault	/* if not, try to insert a HPTE */
> +	lis	r0,DSISR_DONT_HASH@h
> +	ori	r0,r0,DSISR_DONT_HASH@l
> +	and.	r0,r0,r4
> +	bne-	handle_page_fault
>  	CURRENT_THREAD_INFO(r11, r1)
>  	lwz	r0,TI_PREEMPT(r11)	/* If we're in an "NMI" */
>  	andis.	r0,r0,NMI_MASK@h	/* (i.e. an irq when soft-disabled) */
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index 0266c66..e55cb5c 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -337,6 +337,27 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  	}
>  #endif /* CONFIG_PPC_ICSWX */
>
> +#ifdef CONFIG_PPC_STD_MMU_64
> +	/*
> +	 * These faults indicate various errors that can't be recovered
> +	 * by updating the PTE, there is no point handling them any later
> +	 * than here. I also noticed in some case the DAR isn't being set
> +	 * propertly (DSISR_BAD_COPYPASTE for example).
> +	 */
> +	if (error_code & (DSISR_ATT_CONFLICT |
> +			  DSISR_BADACCESS |
> +			  DSISR_UNSUPP_MMU |
> +			  DSISR_BAD_COPYPASTE |
> +			  DSISR_BAD_AMO |
> +			  DSISR_BAD_CI_LDST)) {
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
