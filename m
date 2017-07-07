Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x3mGm3cd4zDqj8
 for <linuxppc-dev@lists.ozlabs.org>; Fri,  7 Jul 2017 17:20:32 +1000 (AEST)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v677IWrf027954
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Jul 2017 03:20:29 -0400
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 by mx0b-001b2d01.pphosted.com with ESMTP id 2bhwbypsq9-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 07 Jul 2017 03:20:29 -0400
Received: from localhost
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 7 Jul 2017 17:20:27 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay10.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v677J2PV917764
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Jul 2017 17:19:10 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v677Ib5u025827
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 7 Jul 2017 17:18:38 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Nicholas Piggin <npiggin@gmail.com>, linuxppc-dev@lists.ozlabs.org
Cc: Nicholas Piggin <npiggin@gmail.com>, Michael Ellerman <mpe@ellerman.id.au>
Subject: Re: [PATCH] powerpc/powernv: Fix local TLB flush for boot and MCE on
 POWER9
In-Reply-To: <20170706105128.6317-1-npiggin@gmail.com>
References: <20170706105128.6317-1-npiggin@gmail.com>
Date: Fri, 07 Jul 2017 12:48:14 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y3s0sojt.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Nicholas Piggin <npiggin@gmail.com> writes:

> There are two cases outside the normal address space management
> where a CPU's local TLB is to be flushed:
>
>   1. Host boot; in case something has left stale entries in the
>      TLB (e.g., kexec).
>
>   2. Machine check; to clean corrupted TLB entries.
>
> CPU state restore from deep idle states also flushes the TLB.
> However this seems to be a side effect of reusing the boot code to set
> CPU state, rather than a requirement itself.
>
> The current flushing has a number of problems with ISA v3.0B:
>
> - The current radix mode of the MMU is not taken into account. tlbiel
>   is undefined if the R field does not match the current radix mode.
>
> - ISA v3.0B hash must flush the partition and process table caches.
>
> - ISA v3.0B radix must flush partition and process scoped translations,
>   partition and process table caches, and also the page walk cache.
>
> Add POWER9 cases to handle these, with radix vs hash determined by the
> host MMU mode.
>
> Signed-off-by: Nicholas Piggin <npiggin@gmail.com>

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

> ---
>
> This is a relatively minimal version which does not churn code too
> much or remove flushing from the CPU deep state idle restore path.
> Should be suitable for stable after some upstream testing.
>
> Thanks,
> Nick
>
>  arch/powerpc/kernel/cpu_setup_power.S | 13 ++++++--
>  arch/powerpc/kernel/dt_cpu_ftrs.c     | 13 ++------
>  arch/powerpc/kernel/mce_power.c       | 56 ++++++++++++++++++++++++++++++++++-
>  3 files changed, 67 insertions(+), 15 deletions(-)
>
> diff --git a/arch/powerpc/kernel/cpu_setup_power.S b/arch/powerpc/kernel/cpu_setup_power.S
> index 10cb2896b2ae..610955fe8b81 100644
> --- a/arch/powerpc/kernel/cpu_setup_power.S
> +++ b/arch/powerpc/kernel/cpu_setup_power.S
> @@ -218,13 +218,20 @@ __init_tlb_power8:
>  	ptesync
>  1:	blr
>
> +/*
> + * Flush the TLB in hash mode. Hash must flush with RIC=2 once for process
> + * and one for partition scope to clear process and partition table entries.
> + */
>  __init_tlb_power9:
> -	li	r6,POWER9_TLB_SETS_HASH
> +	li	r6,POWER9_TLB_SETS_HASH - 1
>  	mtctr	r6
>  	li	r7,0xc00	/* IS field = 0b11 */
> +	li	r8,0
>  	ptesync
> -2:	tlbiel	r7
> -	addi	r7,r7,0x1000
> +	PPC_TLBIEL(7, 8, 2, 1, 0)
> +	PPC_TLBIEL(7, 8, 2, 0, 0)
> +2:	addi	r7,r7,0x1000
> +	PPC_TLBIEL(7, 8, 0, 0, 0)
>  	bdnz	2b
>  	ptesync
>  1:	blr
> diff --git a/arch/powerpc/kernel/dt_cpu_ftrs.c b/arch/powerpc/kernel/dt_cpu_ftrs.c
> index 4c7656dc4e04..b0da3718437d 100644
> --- a/arch/powerpc/kernel/dt_cpu_ftrs.c
> +++ b/arch/powerpc/kernel/dt_cpu_ftrs.c
> @@ -105,24 +105,15 @@ static void cpufeatures_flush_tlb(void)
>  	case PVR_POWER8:
>  	case PVR_POWER8E:
>  	case PVR_POWER8NVL:
> -		num_sets = POWER8_TLB_SETS;
> +		__flush_tlb_power8(POWER8_TLB_SETS);
>  		break;
>  	case PVR_POWER9:
> -		num_sets = POWER9_TLB_SETS_HASH;
> +		__flush_tlb_power9(POWER9_TLB_SETS_HASH);
>  		break;
>  	default:
> -		num_sets = 1;
>  		pr_err("unknown CPU version for boot TLB flush\n");
>  		break;
>  	}
> -
> -	asm volatile("ptesync" : : : "memory");
> -	rb = TLBIEL_INVAL_SET;
> -	for (i = 0; i < num_sets; i++) {
> -		asm volatile("tlbiel %0" : : "r" (rb));
> -		rb += 1 << TLBIEL_INVAL_SET_SHIFT;
> -	}
> -	asm volatile("ptesync" : : : "memory");
>  }
>
>  static void __restore_cpu_cpufeatures(void)
> diff --git a/arch/powerpc/kernel/mce_power.c b/arch/powerpc/kernel/mce_power.c
> index d24e689e893f..b76ca198e09c 100644
> --- a/arch/powerpc/kernel/mce_power.c
> +++ b/arch/powerpc/kernel/mce_power.c
> @@ -53,6 +53,60 @@ static void flush_tlb_206(unsigned int num_sets, unsigned int action)
>  	asm volatile("ptesync" : : : "memory");
>  }
>
> +static void flush_tlb_300(unsigned int num_sets, unsigned int action)
> +{
> +	unsigned long rb;
> +	unsigned int i;
> +	unsigned int r;
> +
> +	switch (action) {
> +	case TLB_INVAL_SCOPE_GLOBAL:
> +		rb = TLBIEL_INVAL_SET;
> +		break;
> +	case TLB_INVAL_SCOPE_LPID:
> +		rb = TLBIEL_INVAL_SET_LPID;
> +		break;
> +	default:
> +		BUG();
> +		break;
> +	}
> +
> +	asm volatile("ptesync" : : : "memory");
> +
> +	if (early_radix_enabled())
> +		r = 1;
> +	else
> +		r = 0;
> +
> +	/*
> +	 * First flush table/PWC caches with set 0, then flush the
> +	 * rest of the sets, partition scope. Radix must then do it
> +	 * all again with process scope. Hash just has to flush
> +	 * process table.
> +	 */
> +	asm volatile(PPC_TLBIEL(%0, %1, %2, %3, %4) : :
> +			"r"(rb), "r"(0), "i"(2), "i"(0), "r"(r));
> +	for (i = 1; i < num_sets; i++) {
> +		unsigned long set = i * (1<<TLBIEL_INVAL_SET_SHIFT);
> +
> +		asm volatile(PPC_TLBIEL(%0, %1, %2, %3, %4) : :
> +				"r"(rb+set), "r"(0), "i"(2), "i"(0), "r"(r));
> +	}
> +
> +	asm volatile(PPC_TLBIEL(%0, %1, %2, %3, %4) : :
> +			"r"(rb), "r"(0), "i"(2), "i"(1), "r"(r));
> +	if (early_radix_enabled()) {
> +		for (i = 1; i < num_sets; i++) {
> +			unsigned long set = i * (1<<TLBIEL_INVAL_SET_SHIFT);
> +
> +			asm volatile(PPC_TLBIEL(%0, %1, %2, %3, %4) : :
> +				"r"(rb+set), "r"(0), "i"(2), "i"(1), "r"(r));
> +		}
> +	}
> +
> +	asm volatile("ptesync" : : : "memory");
> +}
> +
>  /*
>   * Generic routines to flush TLB on POWER processors. These routines
>   * are used as flush_tlb hook in the cpu_spec.
> @@ -79,7 +133,7 @@ void __flush_tlb_power9(unsigned int action)
>  	else
>  		num_sets = POWER9_TLB_SETS_HASH;
>
> -	flush_tlb_206(num_sets, action);
> +	flush_tlb_300(num_sets, action);
>  }
>
>
> -- 
> 2.11.0
