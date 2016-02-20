Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id E4FFD1A0331
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 01:34:36 +1100 (AEDT)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 20 Feb 2016 09:34:34 -0500
Received: from b01cxnp22035.gho.pok.ibm.com (b01cxnp22035.gho.pok.ibm.com
 [9.57.198.25])
 by d01dlp02.pok.ibm.com (Postfix) with ESMTP id 41D1B6E803F
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 09:21:23 -0500 (EST)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22035.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1KEYVHK26738796
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 14:34:31 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1KEYU4R021342
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 09:34:31 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Balbir Singh <bsingharora@gmail.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm/hash: Clear the invalid slot information
 correctly
In-Reply-To: <56C6FCDD.8010302@gmail.com>
References: <1455813884-8283-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <56C6FCDD.8010302@gmail.com>
Date: Sat, 20 Feb 2016 20:04:27 +0530
Message-ID: <8737sne9ho.fsf@linux.vnet.ibm.com>
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

...........
............

>> diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
>> index 49b152b0f926..8424f46c2bf7 100644
>> --- a/arch/powerpc/mm/hugepage-hash64.c
>> +++ b/arch/powerpc/mm/hugepage-hash64.c
>> @@ -78,9 +78,14 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
>>  		 * base page size. This is because demote_segment won't flush
>>  		 * hash page table entries.
>>  		 */
>> -		if ((old_pmd & _PAGE_HASHPTE) && !(old_pmd & _PAGE_COMBO))
>> +		if ((old_pmd & _PAGE_HASHPTE) && !(old_pmd & _PAGE_COMBO)) {
>>  			flush_hash_hugepage(vsid, ea, pmdp, MMU_PAGE_64K,
>>  					    ssize, flags);
>> +			/*
>> +			 * clear the old slot information 
>> +			 */
> Redundant comment, something more useful? why clear it?
>> +			memset(hpte_slot_array, 0, PTE_FRAG_SIZE);
>> +		}
>>  	}
>>  

explained in the commit message. 


 With THP, we also clear the slot information with respect to all
 the 64K hash pte mapping that 16MB page. They are all invalid
 now. This make sure we don't find the slot valid when we fault with
 4k base page size. Finding the slot valid should not result in any wrong
 behavior because we do check again in hash page table for the validity.
 But we can avoid that check completely.



>>  	valid = hpte_valid(hpte_slot_array, index);
