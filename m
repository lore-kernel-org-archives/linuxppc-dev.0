Return-Path: <aik@ozlabs.ru>
Received: from mail-pf1-x441.google.com (mail-pf1-x441.google.com
 [IPv6:2607:f8b0:4864:20::441])
 (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41pm3S22MfzDr5t
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 Aug 2018 16:26:59 +1000 (AEST)
Received: by mail-pf1-x441.google.com with SMTP id y10-v6so7224564pfn.8
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 Aug 2018 23:26:59 -0700 (PDT)
Subject: Re: [PATCH] powerpc/powernv/idle: Fix build error
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
References: <20180809133720.16406-1-aneesh.kumar@linux.ibm.com>
 <87k1oy8znu.fsf@concordia.ellerman.id.au>
From: Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <48a5eb4c-66db-ba47-dd71-4bb898a958ee@ozlabs.ru>
Date: Mon, 13 Aug 2018 16:26:50 +1000
MIME-Version: 1.0
In-Reply-To: <87k1oy8znu.fsf@concordia.ellerman.id.au>
Content-Type: text/plain; charset=utf-8
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>



On 10/08/2018 17:10, Michael Ellerman wrote:
> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
> 
>> Fix the below build error using strlcpy instead of strncpy
>>
>> In function 'pnv_parse_cpuidle_dt',
>>     inlined from 'pnv_init_idle_states' at arch/powerpc/platforms/powernv/idle.c:840:7,
>>     inlined from '__machine_initcall_powernv_pnv_init_idle_states' at arch/powerpc/platforms/powernv/idle.c:870:1:
>> arch/powerpc/platforms/powernv/idle.c:820:3: error: 'strncpy' specified bound 16 equals destination size [-Werror=stringop-truncation]
>>    strncpy(pnv_idle_states[i].name, temp_string[i],
>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>     PNV_IDLE_NAME_LEN);
> 
> I'm curious why I haven't seen this? What compiler are you using?


gcc 8 does this.


> 
> cheers
> 
>> diff --git a/arch/powerpc/platforms/powernv/idle.c b/arch/powerpc/platforms/powernv/idle.c
>> index ecb002c5db83..35f699ebb662 100644
>> --- a/arch/powerpc/platforms/powernv/idle.c
>> +++ b/arch/powerpc/platforms/powernv/idle.c
>> @@ -817,7 +817,7 @@ static int pnv_parse_cpuidle_dt(void)
>>  		goto out;
>>  	}
>>  	for (i = 0; i < nr_idle_states; i++)
>> -		strncpy(pnv_idle_states[i].name, temp_string[i],
>> +		strlcpy(pnv_idle_states[i].name, temp_string[i],
>>  			PNV_IDLE_NAME_LEN);
>>  	nr_pnv_idle_states = nr_idle_states;
>>  	rc = 0;
>> -- 
>> 2.17.1

-- 
Alexey
