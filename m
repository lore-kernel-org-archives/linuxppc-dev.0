Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 40ZCrw3tcTzF25k
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 15:34:05 +1000 (AEST)
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w3U5XrNt048925
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 01:34:02 -0400
Received: from e06smtp11.uk.ibm.com (e06smtp11.uk.ibm.com [195.75.94.107])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2hnt3bwj1c-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 30 Apr 2018 01:34:01 -0400
Received: from localhost
 by e06smtp11.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 30 Apr 2018 06:34:00 +0100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 benh@kernel.crashing.org, paulus@samba.org
Cc: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>,
 linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/8xx: Build fix with Hugetlbfs enabled
In-Reply-To: <87in8poysu.fsf@concordia.ellerman.id.au>
References: <20180416112724.9677-1-aneesh.kumar@linux.ibm.com>
 <20180416112724.9677-2-aneesh.kumar@linux.ibm.com>
 <87in8poysu.fsf@concordia.ellerman.id.au>
Date: Mon, 30 Apr 2018 11:03:53 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87y3h5ntq6.fsf@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:
>
>> 8xx use slice code when hugetlbfs is enabled. We missed a header include on
>> 8xx which resulted in the below build failure.
>>
>> config: mpc885_ads_defconfig + CONFIG_HUGETLBFS
>>
>>    CC      arch/powerpc/mm/slice.o
>> arch/powerpc/mm/slice.c: In function 'slice_get_unmapped_area':
>> arch/powerpc/mm/slice.c:655:2: error: implicit declaration of function 'need_extra_context' [-Werror=implicit-function-declaration]
>> arch/powerpc/mm/slice.c:656:3: error: implicit declaration of function 'alloc_extended_context' [-Werror=implicit-function-declaration]
>> cc1: all warnings being treated as errors
>> make[1]: *** [arch/powerpc/mm/slice.o] Error 1
>> make: *** [arch/powerpc/mm] Error 2
>>
>> on PPC64 the mmu_context.h was included via linux/pkeys.h
>>
>> CC: Christophe LEROY <christophe.leroy@c-s.fr>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
>> ---
>>  arch/powerpc/mm/slice.c | 1 +
>>  1 file changed, 1 insertion(+)
>>
>> diff --git a/arch/powerpc/mm/slice.c b/arch/powerpc/mm/slice.c
>> index 9cd87d11fe4e..205fe557ca10 100644
>> --- a/arch/powerpc/mm/slice.c
>> +++ b/arch/powerpc/mm/slice.c
>> @@ -35,6 +35,7 @@
>>  #include <asm/mmu.h>
>>  #include <asm/copro.h>
>>  #include <asm/hugetlb.h>
>> +#include <asm/mmu_context.h>
>
> I already merged this, didn't I?
>

yes. This patch was wrongly included in this series.

-aneesh
