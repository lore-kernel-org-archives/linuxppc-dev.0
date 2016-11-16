Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJhq93KyqzDvmq
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 22:29:09 +1100 (AEDT)
Received: from pps.filterd (m0098420.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAGBSZZk086350
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 06:29:07 -0500
Received: from e32.co.us.ibm.com (e32.co.us.ibm.com [32.97.110.150])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26rnvv9tyv-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 06:29:06 -0500
Received: from localhost
 by e32.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 16 Nov 2016 04:29:06 -0700
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>,
 Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH v2] powerpc/mm/radix: Invalidate ERAT on tlbiel for POWER9
 DD1
In-Reply-To: <426fb387-a925-04f3-1027-7e347e2885bb@gmail.com>
References: <20161116052319.15507-1-mikey@neuling.org>
 <87lgwjy9x5.fsf@concordia.ellerman.id.au>
 <426fb387-a925-04f3-1027-7e347e2885bb@gmail.com>
Date: Wed, 16 Nov 2016 16:58:58 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87vavnll39.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Balbir Singh <bsingharora@gmail.com> writes:

> On 16/11/16 21:51, Michael Ellerman wrote:
>> Michael Neuling <mikey@neuling.org> writes:
>>> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
>>> index bda8c43be7..4a19cdd8a0 100644
>>> --- a/arch/powerpc/mm/tlb-radix.c
>>> +++ b/arch/powerpc/mm/tlb-radix.c
>>> @@ -50,6 +50,9 @@ static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
>>>  	for (set = 0; set < POWER9_TLB_SETS_RADIX ; set++) {
>>>  		__tlbiel_pid(pid, set, ric);
>>>  	}
>>> +	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
>>> +		asm volatile(PPC_SLBIA(0x7)
>>> +			     : : :"memory");
>> 
>> Ah of course I'll use slbia to invalidate the ERAT.
>> 
>> How about we do:
>> 
>> #define PPC_INVALIDATE_ERAT	PPC_SLBIA(0x7)
>> 
>
> While you are at it, could you also add a TODO
> to use a HCALL when LPCR_GTSE is not set
> (when running in guest mode)

In what config we use that ? With radix we always run with GTSE = 1 and
with hash we don't use tlbiel in guest.

-aneesh
