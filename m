Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFTqN5xcyzDvfn
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 17:03:12 +1100 (AEDT)
Received: from mail-pf0-x241.google.com (mail-pf0-x241.google.com
 [IPv6:2607:f8b0:400e:c00::241])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tFTqN12LPz9t1P
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 17:03:12 +1100 (AEDT)
Received: by mail-pf0-x241.google.com with SMTP id i88so1240688pfk.2
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2016 22:03:12 -0800 (PST)
Subject: Re: [PATCH 3/3] Enable storage keys for radix - user mode execution
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <1478007500-23624-1-git-send-email-bsingharora@gmail.com>
 <1478007500-23624-4-git-send-email-bsingharora@gmail.com>
 <874m3i2biv.fsf@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <84a7f1a7-5514-4345-7df8-383ca5eb84df@gmail.com>
Date: Fri, 11 Nov 2016 17:02:56 +1100
MIME-Version: 1.0
In-Reply-To: <874m3i2biv.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/11/16 03:15, Aneesh Kumar K.V wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
>> ISA 3 defines new encoded access authority that allows instruction
>> access prevention in privileged mode and allows normal access
>> to problem state. This patch just enables IAMR (Instruction Authority
>> Mask Register), enabling AMR would require more work.
> 
> 
> We may want to explain what the rules are with details like IAMR class 0
> bit 1 controls the instruction access etc. Also we can metion that we
> now setup user pages such that EAA[0] is set to 0
> 
>>
>> I've tested this with a buggy driver and a simple payload. The payload
>> is specific to the build I've tested.
>>
>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
>> ---
>>  arch/powerpc/mm/pgtable-radix.c | 19 +++++++++++++++++++
>>  1 file changed, 19 insertions(+)
>>
>> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
>> index 0fdd8ed..cd3d400 100644
>> --- a/arch/powerpc/mm/pgtable-radix.c
>> +++ b/arch/powerpc/mm/pgtable-radix.c
>> @@ -339,6 +339,24 @@ static void __init radix_init_amor(void)
>>  	mtspr(SPRN_AMOR, amor);
>>  }
>>  
>> +/*
>> + * For radix page tables we setup, the IAMR values as follows
>> + * IMAR = 0100...00 (key 0 is set to 1)
>> + * AMR, UAMR, UAMOR are not affected
>> + */
>> +static void __init radix_init_iamr(void)
>> +{
>> +	unsigned long iamr_mask = 0x4000000000000000;
>> +	unsigned long iamr = mfspr(SPRN_IAMR);
>> +
>> +	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
>> +		return;
> 
> is this needed ?
> 

Yes, IAMR support is DD1+

>> +
>> +	iamr |= iamr_mask;
>> +
>> +	mtspr(SPRN_IAMR, iamr);
>> +}
> 
> Why do '|'. Who else can set this ?
> 
>> +
>>  void __init radix__early_init_mmu(void)
>>  {
>>  	unsigned long lpcr;
>> @@ -398,6 +416,7 @@ void __init radix__early_init_mmu(void)
>>  		radix_init_amor();
>>  	}
>>  
>> +	radix_init_iamr();
>>  	radix_init_pgtable();
>>  }
> 
> What about secondary cpus ?
> 

Oops..Yes, will do a v3. 

> -aneesh
> 
