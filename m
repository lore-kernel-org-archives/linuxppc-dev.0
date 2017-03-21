Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnRsS3lR6zDq7d
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 20:12:12 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2L93VxT013245
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 05:12:09 -0400
Received: from e28smtp09.in.ibm.com (e28smtp09.in.ibm.com [125.16.236.9])
 by mx0b-001b2d01.pphosted.com with ESMTP id 29ajfey3p3-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 05:12:09 -0400
Received: from localhost
 by e28smtp09.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 14:42:05 +0530
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay10.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v2L9AnWF16318464
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 14:40:49 +0530
Received: from d28av01.in.ibm.com (localhost [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v2L9C1Lx003756
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 14:42:02 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Laurent Dufour <ldufour@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, bsingharora@gmail.com,
 npiggin@gmail.com
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/3] powerpc/mm: handle VM_FAULT_RETRY earlier
In-Reply-To: <42011273e3edc4176dc8045b3956dfd218259143.1487090656.git.ldufour@linux.vnet.ibm.com>
References: <cover.1487090656.git.ldufour@linux.vnet.ibm.com>
 <42011273e3edc4176dc8045b3956dfd218259143.1487090656.git.ldufour@linux.vnet.ibm.com>
Date: Tue, 21 Mar 2017 14:42:01 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <877f3jouxq.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:

> In do_page_fault() if handle_mm_fault() returns VM_FAULT_RETRY, retry
> the page fault handling before anything else.
>
> This would simplify the handling of the mmap_sem lock in this part of
> the code.
>
> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
> ---
>  arch/powerpc/mm/fault.c | 67 ++++++++++++++++++++++++++++---------------------
>  1 file changed, 38 insertions(+), 29 deletions(-)
>
> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
> index ee09604bbe12..2a6bc7e6e69a 100644
> --- a/arch/powerpc/mm/fault.c
> +++ b/arch/powerpc/mm/fault.c
> @@ -434,6 +434,26 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  	 * the fault.
>  	 */
>  	fault = handle_mm_fault(vma, address, flags);
> +
> +	/*
> +	 * Handle the retry right now, the mmap_sem has been released in that
> +	 * case.
> +	 */
> +	if (unlikely(fault & VM_FAULT_RETRY)) {
> +		/* We retry only once */
> +		if (flags & FAULT_FLAG_ALLOW_RETRY) {
> +			/*
> +			 * Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk
> +			 * of starvation.
> +			 */
> +			flags &= ~FAULT_FLAG_ALLOW_RETRY;
> +			flags |= FAULT_FLAG_TRIED;
> +			if (!fatal_signal_pending(current))
> +				goto retry;
> +		}
> +		/* We will enter mm_fault_error() below */
> +	}
> +
>  	if (unlikely(fault & (VM_FAULT_RETRY|VM_FAULT_ERROR))) {
>  		if (fault & VM_FAULT_SIGSEGV)
>  			goto bad_area;
> @@ -445,38 +465,27 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>  	}

We could make it further simpler, by handling the FAULT_RETRY without
FLAG_ALLOW_RETRY set earlier. But i guess that can be done later ?

Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>


>
>  	/*
> -	 * Major/minor page fault accounting is only done on the
> -	 * initial attempt. If we go through a retry, it is extremely
> -	 * likely that the page will be found in page cache at that point.
> +	 * Major/minor page fault accounting.
>  	 */
> -	if (flags & FAULT_FLAG_ALLOW_RETRY) {
> -		if (fault & VM_FAULT_MAJOR) {
> -			current->maj_flt++;
> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
> -				      regs, address);
> +	if (fault & VM_FAULT_MAJOR) {
> +		current->maj_flt++;
> +		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
> +			      regs, address);
>  #ifdef CONFIG_PPC_SMLPAR
> -			if (firmware_has_feature(FW_FEATURE_CMO)) {
> -				u32 page_ins;
> -
> -				preempt_disable();
> -				page_ins = be32_to_cpu(get_lppaca()->page_ins);
> -				page_ins += 1 << PAGE_FACTOR;
> -				get_lppaca()->page_ins = cpu_to_be32(page_ins);
> -				preempt_enable();
> -			}
> -#endif /* CONFIG_PPC_SMLPAR */
> -		} else {
> -			current->min_flt++;
> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
> -				      regs, address);
> -		}
> -		if (fault & VM_FAULT_RETRY) {
> -			/* Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk
> -			 * of starvation. */
> -			flags &= ~FAULT_FLAG_ALLOW_RETRY;
> -			flags |= FAULT_FLAG_TRIED;
> -			goto retry;
> +		if (firmware_has_feature(FW_FEATURE_CMO)) {
> +			u32 page_ins;
> +
> +			preempt_disable();
> +			page_ins = be32_to_cpu(get_lppaca()->page_ins);
> +			page_ins += 1 << PAGE_FACTOR;
> +			get_lppaca()->page_ins = cpu_to_be32(page_ins);
> +			preempt_enable();
>  		}
> +#endif /* CONFIG_PPC_SMLPAR */
> +	} else {
> +		current->min_flt++;
> +		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
> +			      regs, address);
>  	}
>
>  	up_read(&mm->mmap_sem);
> -- 
> 2.7.4
