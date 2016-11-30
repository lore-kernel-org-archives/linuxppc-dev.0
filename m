Return-Path: <maddy@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tTNbJ2fjLzDt1r
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  1 Dec 2016 01:49:00 +1100 (AEDT)
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAUEiL2D135105
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 09:48:57 -0500
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 by mx0a-001b2d01.pphosted.com with ESMTP id 27201cb8f1-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 09:48:57 -0500
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <maddy@linux.vnet.ibm.com>;
 Wed, 30 Nov 2016 20:18:53 +0530
Received: from d28relay06.in.ibm.com (d28relay06.in.ibm.com [9.184.220.150])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id E0993394005E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 20:18:50 +0530 (IST)
Received: from d28av06.in.ibm.com (d28av06.in.ibm.com [9.184.220.48])
 by d28relay06.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 uAUEmohb25559216
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 20:18:50 +0530
Received: from d28av06.in.ibm.com (localhost [127.0.0.1])
 by d28av06.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 uAUEmoti010905
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 30 Nov 2016 20:18:50 +0530
Subject: Re: [PATCH v3 4/4] powerpc/perf: macros for PowerISA v3.0 format
 encoding
To: Michael Ellerman <mpe@ellerman.id.au>
References: <1480296076-28880-1-git-send-email-maddy@linux.vnet.ibm.com>
 <1480296076-28880-5-git-send-email-maddy@linux.vnet.ibm.com>
 <878ts2rj1f.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org
From: Madhavan Srinivasan <maddy@linux.vnet.ibm.com>
Date: Wed, 30 Nov 2016 20:18:48 +0530
MIME-Version: 1.0
In-Reply-To: <878ts2rj1f.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252; format=flowed
Message-Id: <f6f55f1b-60ed-cc58-2958-c6c8e58bbbe2@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On Tuesday 29 November 2016 10:15 AM, Michael Ellerman wrote:
> Madhavan Srinivasan <maddy@linux.vnet.ibm.com> writes:
>
>> diff --git a/arch/powerpc/perf/isa207-common.c b/arch/powerpc/perf/isa207-common.c
>> index 2a2040ea5f99..e747bbf06661 100644
>> --- a/arch/powerpc/perf/isa207-common.c
>> +++ b/arch/powerpc/perf/isa207-common.c
>> @@ -55,6 +55,81 @@ static inline bool event_is_fab_match(u64 event)
>>   	return (event == 0x30056 || event == 0x4f052);
>>   }
>>   
>> +static bool is_event_valid(u64 event)
>> +{
>> +	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
>> +		(cpu_has_feature(CPU_FTR_POWER9_DD1)) &&
> You don't need ARCH_300 in these checks.
>
> POWER9_DD1 implies ARCH_300.
>
> And the way you've written it you have two arms that use
> EVENT_VALID_MASK, which is confusing.
>
>> +		(event & ~EVENT_VALID_MASK))
>> +		return false;
>> +	else if (cpu_has_feature(CPU_FTR_ARCH_300) &&
>> +		(event & ~ISA300_EVENT_VALID_MASK))
>> +		return false;
>> +	else if (event & ~EVENT_VALID_MASK)
>> +		return false;
>> +
>> +	return true;
>> +}
> I think it would read better as:
>
> 	u64 valid_mask = EVENT_VALID_MASK;
>          
> 	if (cpu_has_feature(CPU_FTR_ARCH_300) && !cpu_has_feature(CPU_FTR_POWER9_DD1))
> 		valid_mask = ISA300_EVENT_VALID_MASK;
>
> 	return !(event & ~valid_mask);

Yes. This is much better. Will make the changes

Thanks for review
Maddy

>> +static u64 mmcra_sdar_mode(u64 event)
>> +{
>> +	u64 sm;
>> +
>> +	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
>> +	   (cpu_has_feature(CPU_FTR_POWER9_DD1))) {
>> +		goto sm_tlb;
>> +	} else if (cpu_has_feature(CPU_FTR_ARCH_300)) {
>> +		sm = (event >> ISA300_SDAR_MODE_SHIFT) & ISA300_SDAR_MODE_MASK;
>> +		if (sm)
>> +			return sm<<MMCRA_SDAR_MODE_SHIFT;
>> +	} else
>> +		goto sm_tlb;
>> +
>> +sm_tlb:
>> +	return MMCRA_SDAR_MODE_TLB;
>> +}
> You should not need a goto to implement that logic.
>
>> +static u64 thresh_cmp_val(u64 value)
>> +{
>> +	if (cpu_has_feature(CPU_FTR_ARCH_300) &&
>> +	   (cpu_has_feature(CPU_FTR_POWER9_DD1)))
>> +		goto thr_cmp;
>> +	else if (cpu_has_feature(CPU_FTR_ARCH_300))
>> +		return value<<ISA300_MMCRA_THR_CMP_SHIFT;
>> +	else
>> +		goto thr_cmp;
>> +thr_cmp:
>> +	return value<<MMCRA_THR_CMP_SHIFT;
>> +}
> And similarly for this one and all the others.
>
>> diff --git a/arch/powerpc/perf/isa207-common.h b/arch/powerpc/perf/isa207-common.h
>> index 4d0a4e5017c2..0a240635cf48 100644
>> --- a/arch/powerpc/perf/isa207-common.h
>> +++ b/arch/powerpc/perf/isa207-common.h
>> @@ -134,6 +134,24 @@
>>   	 PERF_SAMPLE_BRANCH_KERNEL      |\
>>   	 PERF_SAMPLE_BRANCH_HV)
>>   
>> +/* Contants to support PowerISA v3.0 encoding format */
>> +#define ISA300_EVENT_COMBINE_SHIFT	10	/* Combine bit */
>> +#define ISA300_EVENT_COMBINE_MASK	0x3ull
>> +#define ISA300_SDAR_MODE_SHIFT		50
>> +#define ISA300_SDAR_MODE_MASK		0x3ull
> As I said in the previous patch, calling these P9 would be more accurate
> I think. And shorter.
>
>
> cheers
>
