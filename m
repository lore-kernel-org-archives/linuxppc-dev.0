Return-Path: <bsingharora@gmail.com>
Received: from mail-pg0-x243.google.com (mail-pg0-x243.google.com
 [IPv6:2607:f8b0:400e:c05::243])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tJhDG4NsDzDvmn
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 22:02:22 +1100 (AEDT)
Received: by mail-pg0-x243.google.com with SMTP id p66so14464315pga.2
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 16 Nov 2016 03:02:22 -0800 (PST)
Subject: Re: [PATCH v2] powerpc/mm/radix: Invalidate ERAT on tlbiel for POWER9
 DD1
To: Michael Ellerman <mpe@ellerman.id.au>, Michael Neuling <mikey@neuling.org>
References: <20161116052319.15507-1-mikey@neuling.org>
 <87lgwjy9x5.fsf@concordia.ellerman.id.au>
Cc: linuxppc-dev@lists.ozlabs.org, aneesh.kumar@linux.vnet.ibm.com
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <426fb387-a925-04f3-1027-7e347e2885bb@gmail.com>
Date: Wed, 16 Nov 2016 22:02:13 +1100
MIME-Version: 1.0
In-Reply-To: <87lgwjy9x5.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 16/11/16 21:51, Michael Ellerman wrote:
> Michael Neuling <mikey@neuling.org> writes:
>> diff --git a/arch/powerpc/mm/tlb-radix.c b/arch/powerpc/mm/tlb-radix.c
>> index bda8c43be7..4a19cdd8a0 100644
>> --- a/arch/powerpc/mm/tlb-radix.c
>> +++ b/arch/powerpc/mm/tlb-radix.c
>> @@ -50,6 +50,9 @@ static inline void _tlbiel_pid(unsigned long pid, unsigned long ric)
>>  	for (set = 0; set < POWER9_TLB_SETS_RADIX ; set++) {
>>  		__tlbiel_pid(pid, set, ric);
>>  	}
>> +	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
>> +		asm volatile(PPC_SLBIA(0x7)
>> +			     : : :"memory");
> 
> Ah of course I'll use slbia to invalidate the ERAT.
> 
> How about we do:
> 
> #define PPC_INVALIDATE_ERAT	PPC_SLBIA(0x7)
> 

While you are at it, could you also add a TODO
to use a HCALL when LPCR_GTSE is not set
(when running in guest mode)

Balbir Singh.
