Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3vN1sK3YzMzDqr8
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 23:27:49 +1100 (AEDT)
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.20/8.16.0.20) with SMTP id
 v1ECNdHQ107240
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 07:27:47 -0500
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 by mx0a-001b2d01.pphosted.com with ESMTP id 28kk8ns5ts-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 07:27:47 -0500
Received: from localhost
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 14 Feb 2017 22:27:44 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 040402CE8057
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 23:27:42 +1100 (EST)
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v1ECRXCO33947818
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 23:27:41 +1100
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v1ECR9Hd026706
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 14 Feb 2017 23:27:09 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <mpe@ellerman.id.au>, akpm@linux-foundation.org,
 Rik van Riel <riel@surriel.com>,
 Mel Gorman <mgorman@techsingularity.net>, paulus@ozlabs.org,
 benh@kernel.crashing.org
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
 linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 2/2] powerpc/mm/autonuma: Switch ppc64 to its own
 implementeation of saved write
In-Reply-To: <87y3x9kp8e.fsf@concordia.ellerman.id.au>
References: <1487050314-3892-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1487050314-3892-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <87y3x9kp8e.fsf@concordia.ellerman.id.au>
Date: Tue, 14 Feb 2017 17:56:44 +0530
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87d1elufej.fsf@skywalker.in.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Michael Ellerman <mpe@ellerman.id.au> writes:

> "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> writes:
>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> index 0735d5a8049f..8720a406bbbe 100644
>> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>> @@ -16,6 +16,9 @@
>>  #include <asm/page.h>
>>  #include <asm/bug.h>
>>  
>> +#ifndef __ASSEMBLY__
>> +#include <linux/mmdebug.h>
>> +#endif
>
> I assume that's for the VM_BUG_ON() you add below. But if so wouldn't
> the #include be better placed in book3s/64/pgtable.h also?

mmu-hash.h has got a hack that is explained below

#ifndef __ASSEMBLY__
#include <linux/mmdebug.h>
#endif
/*
 * This is necessary to get the definition of PGTABLE_RANGE which we
 * need for various slices related matters. Note that this isn't the
 * complete pgtable.h but only a portion of it.
 */
#include <asm/book3s/64/pgtable.h>

This is the only place where we do that book3s/64/pgtable.h include this
way. Everybody should include asm/pgable.h which picks the righ version
based on different config option.

#
>
>> diff --git a/arch/powerpc/include/asm/book3s/64/pgtable.h b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> index fef738229a68..c684ef6cbd10 100644
>> --- a/arch/powerpc/include/asm/book3s/64/pgtable.h
>> +++ b/arch/powerpc/include/asm/book3s/64/pgtable.h
>> @@ -512,6 +512,32 @@ static inline pte_t pte_mkhuge(pte_t pte)
>>  	return pte;
>>  }
>>  
>> +#define pte_mk_savedwrite pte_mk_savedwrite
>> +static inline pte_t pte_mk_savedwrite(pte_t pte)
>> +{
>> +	/*
>> +	 * Used by Autonuma subsystem to preserve the write bit
>> +	 * while marking the pte PROT_NONE. Only allow this
>> +	 * on PROT_NONE pte
>> +	 */
>> +	VM_BUG_ON((pte_raw(pte) & cpu_to_be64(_PAGE_PRESENT | _PAGE_RWX | _PAGE_PRIVILEGED)) !=
>> +		  cpu_to_be64(_PAGE_PRESENT | _PAGE_PRIVILEGED));
>> +	return __pte(pte_val(pte) & ~_PAGE_PRIVILEGED);
>> +}
>> +
>
>
> cheers

-aneesh
