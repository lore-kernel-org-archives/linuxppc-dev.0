Return-Path: <bsingharora@gmail.com>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tFV5r62DRzDvnH
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 11 Nov 2016 17:15:44 +1100 (AEDT)
Received: from mail-pf0-x244.google.com (mail-pf0-x244.google.com
 [IPv6:2607:f8b0:400e:c00::244])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id 3tFV5r1Xgfz9t0w
 for <linuxppc-dev@ozlabs.org>; Fri, 11 Nov 2016 17:15:44 +1100 (AEDT)
Received: by mail-pf0-x244.google.com with SMTP id i88so1284275pfk.2
 for <linuxppc-dev@ozlabs.org>; Thu, 10 Nov 2016 22:15:44 -0800 (PST)
Subject: Re: [PATCH 1/3] Setup AMOR in HV mode
To: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 linuxppc-dev <linuxppc-dev@ozlabs.org>, Michael Ellerman <mpe@ellerman.id.au>
References: <1478007500-23624-1-git-send-email-bsingharora@gmail.com>
 <1478007500-23624-2-git-send-email-bsingharora@gmail.com>
 <87a8da2edy.fsf@linux.vnet.ibm.com>
From: Balbir Singh <bsingharora@gmail.com>
Message-ID: <7ff5fdfd-751a-a435-c2be-439ae849ed00@gmail.com>
Date: Fri, 11 Nov 2016 17:15:28 +1100
MIME-Version: 1.0
In-Reply-To: <87a8da2edy.fsf@linux.vnet.ibm.com>
Content-Type: text/plain; charset=windows-1252
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 09/11/16 02:13, Aneesh Kumar K.V wrote:
> Balbir Singh <bsingharora@gmail.com> writes:
> 
>> AMOR should be setup in HV mode, we set it up once
>> and let the generic kernel handle IAMR. This patch is
>> used to enable storage keys in a following patch as
>> defined in ISA 3
>>
>> Reported-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> Signed-off-by: Balbir Singh <bsingharora@gmail.com>
>> ---
>>  arch/powerpc/mm/pgtable-radix.c | 20 ++++++++++++++++++++
>>  1 file changed, 20 insertions(+)
>>
>> diff --git a/arch/powerpc/mm/pgtable-radix.c b/arch/powerpc/mm/pgtable-radix.c
>> index ed7bddc..0fdd8ed 100644
>> --- a/arch/powerpc/mm/pgtable-radix.c
>> +++ b/arch/powerpc/mm/pgtable-radix.c
>> @@ -320,6 +320,25 @@ static void update_hid_for_radix(void)
>>  		cpu_relax();
>>  }
>>  
>> +/*
>> + * In HV mode, we init AMOR so that the hypervisor
>> + * and guest can setup IMAR, enable key 0 and set
>> + * it to 1
>> + * AMOR = 1100....00 (Mask for key 0 is 11)
>> + */
>> +static void __init radix_init_amor(void)
>> +{
>> +	unsigned long amor_mask = 0xc000000000000000;
>> +	unsigned long amor = mfspr(SPRN_AMOR);
>> +
>> +	if (cpu_has_feature(CPU_FTR_POWER9_DD1))
>> +		return;
> 
> Why is DD1 excluded ?
> 
>> +
>> +	amor |= amor_mask;
>> +
> 
> Can't we just init it with the constant 0xc000000000000000;
> I can understand kvm code wanting to do the '|' above, but does the host
> init code need to look at the previous value there ?
> 
> 
>> +	mtspr(SPRN_AMOR, amor);
>> +}
>> +
>>  void __init radix__early_init_mmu(void)
>>  {
>>  	unsigned long lpcr;
>> @@ -376,6 +395,7 @@ void __init radix__early_init_mmu(void)
>>  		lpcr = mfspr(SPRN_LPCR);
>>  		mtspr(SPRN_LPCR, lpcr | LPCR_UPRT | LPCR_HR);
>>  		radix_init_partition_table();
>> +		radix_init_amor();
>>  	}
>>  
>>  	radix_init_pgtable();
> 
> What about secondaries ? Don't we need to init AMOR there ?

My bad, I should have checked and caught this

Balbir Singh
