Return-Path: <ldufour@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vnSsy06XDzDq93
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 20:57:41 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v2L9s9Wm025085
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 05:57:33 -0400
Received: from e06smtp13.uk.ibm.com (e06smtp13.uk.ibm.com [195.75.94.109])
 by mx0a-001b2d01.pphosted.com with ESMTP id 29avsndqrd-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 21 Mar 2017 05:57:33 -0400
Received: from localhost
 by e06smtp13.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <ldufour@linux.vnet.ibm.com>;
 Tue, 21 Mar 2017 09:57:30 -0000
Subject: Re: [PATCH 2/3] powerpc/mm: handle VM_FAULT_RETRY earlier
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>, mpe@ellerman.id.au,
 benh@kernel.crashing.org, paulus@samba.org, bsingharora@gmail.com,
 npiggin@gmail.com
References: <cover.1487090656.git.ldufour@linux.vnet.ibm.com>
 <42011273e3edc4176dc8045b3956dfd218259143.1487090656.git.ldufour@linux.vnet.ibm.com>
 <877f3jouxq.fsf@skywalker.in.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
From: Laurent Dufour <ldufour@linux.vnet.ibm.com>
Date: Tue, 21 Mar 2017 10:57:26 +0100
MIME-Version: 1.0
In-Reply-To: <877f3jouxq.fsf@skywalker.in.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <04f09a0d-146c-93da-0879-249e212a23f2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 21/03/2017 10:12, Aneesh Kumar K.V wrote:
> Laurent Dufour <ldufour@linux.vnet.ibm.com> writes:
> 
>> In do_page_fault() if handle_mm_fault() returns VM_FAULT_RETRY, retry
>> the page fault handling before anything else.
>>
>> This would simplify the handling of the mmap_sem lock in this part of
>> the code.
>>
>> Signed-off-by: Laurent Dufour <ldufour@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/mm/fault.c | 67 ++++++++++++++++++++++++++++---------------------
>>  1 file changed, 38 insertions(+), 29 deletions(-)
>>
>> diff --git a/arch/powerpc/mm/fault.c b/arch/powerpc/mm/fault.c
>> index ee09604bbe12..2a6bc7e6e69a 100644
>> --- a/arch/powerpc/mm/fault.c
>> +++ b/arch/powerpc/mm/fault.c
>> @@ -434,6 +434,26 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>>  	 * the fault.
>>  	 */
>>  	fault = handle_mm_fault(vma, address, flags);
>> +
>> +	/*
>> +	 * Handle the retry right now, the mmap_sem has been released in that
>> +	 * case.
>> +	 */
>> +	if (unlikely(fault & VM_FAULT_RETRY)) {
>> +		/* We retry only once */
>> +		if (flags & FAULT_FLAG_ALLOW_RETRY) {
>> +			/*
>> +			 * Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk
>> +			 * of starvation.
>> +			 */
>> +			flags &= ~FAULT_FLAG_ALLOW_RETRY;
>> +			flags |= FAULT_FLAG_TRIED;
>> +			if (!fatal_signal_pending(current))
>> +				goto retry;
>> +		}
>> +		/* We will enter mm_fault_error() below */
>> +	}
>> +
>>  	if (unlikely(fault & (VM_FAULT_RETRY|VM_FAULT_ERROR))) {
>>  		if (fault & VM_FAULT_SIGSEGV)
>>  			goto bad_area;
>> @@ -445,38 +465,27 @@ int do_page_fault(struct pt_regs *regs, unsigned long address,
>>  	}
> 
> We could make it further simpler, by handling the FAULT_RETRY without
> FLAG_ALLOW_RETRY set earlier. But i guess that can be done later ?


Thanks for the review,

I agree that double checking against VM_FAULT_RETRY is confusing here.

But handling all the retry path in the first if() statement means that
we'll have to handle part of the mm_fault_error() code and segv here...
Unless we can't identify what is really relevant in that retry path.

It would take time to review all that tricky part, but I agree it should
be simplified later.

> 
> Reviewed-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
> 
> 
>>
>>  	/*
>> -	 * Major/minor page fault accounting is only done on the
>> -	 * initial attempt. If we go through a retry, it is extremely
>> -	 * likely that the page will be found in page cache at that point.
>> +	 * Major/minor page fault accounting.
>>  	 */
>> -	if (flags & FAULT_FLAG_ALLOW_RETRY) {
>> -		if (fault & VM_FAULT_MAJOR) {
>> -			current->maj_flt++;
>> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
>> -				      regs, address);
>> +	if (fault & VM_FAULT_MAJOR) {
>> +		current->maj_flt++;
>> +		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MAJ, 1,
>> +			      regs, address);
>>  #ifdef CONFIG_PPC_SMLPAR
>> -			if (firmware_has_feature(FW_FEATURE_CMO)) {
>> -				u32 page_ins;
>> -
>> -				preempt_disable();
>> -				page_ins = be32_to_cpu(get_lppaca()->page_ins);
>> -				page_ins += 1 << PAGE_FACTOR;
>> -				get_lppaca()->page_ins = cpu_to_be32(page_ins);
>> -				preempt_enable();
>> -			}
>> -#endif /* CONFIG_PPC_SMLPAR */
>> -		} else {
>> -			current->min_flt++;
>> -			perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
>> -				      regs, address);
>> -		}
>> -		if (fault & VM_FAULT_RETRY) {
>> -			/* Clear FAULT_FLAG_ALLOW_RETRY to avoid any risk
>> -			 * of starvation. */
>> -			flags &= ~FAULT_FLAG_ALLOW_RETRY;
>> -			flags |= FAULT_FLAG_TRIED;
>> -			goto retry;
>> +		if (firmware_has_feature(FW_FEATURE_CMO)) {
>> +			u32 page_ins;
>> +
>> +			preempt_disable();
>> +			page_ins = be32_to_cpu(get_lppaca()->page_ins);
>> +			page_ins += 1 << PAGE_FACTOR;
>> +			get_lppaca()->page_ins = cpu_to_be32(page_ins);
>> +			preempt_enable();
>>  		}
>> +#endif /* CONFIG_PPC_SMLPAR */
>> +	} else {
>> +		current->min_flt++;
>> +		perf_sw_event(PERF_COUNT_SW_PAGE_FAULTS_MIN, 1,
>> +			      regs, address);
>>  	}
>>
>>  	up_read(&mm->mmap_sem);
>> -- 
>> 2.7.4
