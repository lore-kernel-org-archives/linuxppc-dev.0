Return-Path: <mpe@ellerman.id.au>
Received: from ozlabs.org (bilbo.ozlabs.org [203.11.71.1])
 (using TLSv1.2 with cipher ADH-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41qJxq5gGMzF0Qs
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Aug 2018 14:09:03 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: Alexey Kardashevskiy <aik@ozlabs.ru>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>, npiggin@gmail.com,
 benh@kernel.crashing.org, paulus@samba.org
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/powernv/idle: Fix build error
In-Reply-To: <48a5eb4c-66db-ba47-dd71-4bb898a958ee@ozlabs.ru>
References: <20180809133720.16406-1-aneesh.kumar@linux.ibm.com>
 <87k1oy8znu.fsf@concordia.ellerman.id.au>
 <48a5eb4c-66db-ba47-dd71-4bb898a958ee@ozlabs.ru>
Date: Tue, 14 Aug 2018 14:09:01 +1000
Message-ID: <87ftzhlhcy.fsf@concordia.ellerman.id.au>
MIME-Version: 1.0
Content-Type: text/plain
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Alexey Kardashevskiy <aik@ozlabs.ru> writes:
> On 10/08/2018 17:10, Michael Ellerman wrote:
>> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>> 
>>> Fix the below build error using strlcpy instead of strncpy
>>>
>>> In function 'pnv_parse_cpuidle_dt',
>>>     inlined from 'pnv_init_idle_states' at arch/powerpc/platforms/powernv/idle.c:840:7,
>>>     inlined from '__machine_initcall_powernv_pnv_init_idle_states' at arch/powerpc/platforms/powernv/idle.c:870:1:
>>> arch/powerpc/platforms/powernv/idle.c:820:3: error: 'strncpy' specified bound 16 equals destination size [-Werror=stringop-truncation]
>>>    strncpy(pnv_idle_states[i].name, temp_string[i],
>>>    ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
>>>     PNV_IDLE_NAME_LEN);
>> 
>> I'm curious why I haven't seen this? What compiler are you using?
>
> gcc 8 does this.

Yeah you're right. It was hidden by another build failure in my build
scripts :/

cheers
