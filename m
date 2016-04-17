Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp03.in.ibm.com (e28smtp03.in.ibm.com [125.16.236.3])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qp3FM66FhzDq5k
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 06:45:27 +1000 (AEST)
Received: from localhost
 by e28smtp03.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Mon, 18 Apr 2016 01:05:00 +0530
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u3HJYshT65667188
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 01:04:54 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u3HJYtH0014474
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 18 Apr 2016 01:04:56 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V2 23/68] powerpc/mm: Make page table size a variable
In-Reply-To: <570C5437.1070900@gmail.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1460182444-2468-24-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <570C5437.1070900@gmail.com>
Date: Sun, 17 Apr 2016 15:57:11 +0530
Message-ID: <87fuuka5ts.fsf@skywalker.in.ibm.com>
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

Balbir Singh <bsingharora@gmail.com> writes:

>> index 2f818cbd8aa6..dcb9d6e94a0c 100644
>> --- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
>> +++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
>> @@ -5,48 +5,20 @@
>>   * for each page table entry.  The PMD and PGD level use a 32b record for
>>   * each entry by assuming that each entry is page aligned.
>>   */
>> -#define PTE_INDEX_SIZE  9
>> -#define PMD_INDEX_SIZE  7
>> -#define PUD_INDEX_SIZE  9
>> -#define PGD_INDEX_SIZE  9
>> +#define H_PTE_INDEX_SIZE  9
>> +#define H_PMD_INDEX_SIZE  7
>> +#define H_PUD_INDEX_SIZE  9
>> +#define H_PGD_INDEX_SIZE  9
>>  
>
> Any comments on where these numbers came from?
>
> From these numbers for 4K pages we have
>
> Each PMD is 2M
> Each PUD is 256M
> Each PGD is 128G

I am not sure I understand. We are updating linux page table details for
hash config here. This patch doesn't make any functionality change, it
just make sure few #defines are marked as a variable.


-aneesh
