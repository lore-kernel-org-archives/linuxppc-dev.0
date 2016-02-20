Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e35.co.us.ibm.com (e35.co.us.ibm.com [32.97.110.153])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 001531A070C
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 21 Feb 2016 02:14:06 +1100 (AEDT)
Received: from localhost
 by e35.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 20 Feb 2016 08:14:05 -0700
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d03dlp01.boulder.ibm.com (Postfix) with ESMTP id 9D98F1FF0023
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 08:02:12 -0700 (MST)
Received: from d01av04.pok.ibm.com (d01av04.pok.ibm.com [9.56.224.64])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u1KFE2Vo32309480
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 15:14:02 GMT
Received: from d01av04.pok.ibm.com (localhost [127.0.0.1])
 by d01av04.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u1KFE2uA022487
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 10:14:02 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Anshuman Khandual <khandual@linux.vnet.ibm.com>, benh@kernel.crashing.org,
 paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH] powerpc/mm/hash: Clear the invalid slot information
 correctly
In-Reply-To: <56C6ADC6.5000603@linux.vnet.ibm.com>
References: <1455813884-8283-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <56C6ADC6.5000603@linux.vnet.ibm.com>
Date: Sat, 20 Feb 2016 20:43:58 +0530
Message-ID: <877fhz8le1.fsf@linux.vnet.ibm.com>
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

Anshuman Khandual <khandual@linux.vnet.ibm.com> writes:

> On 02/18/2016 10:14 PM, Aneesh Kumar K.V wrote:
>> We can get a hash pte fault with 4k base page size and find the pte
>> already inserted with 64K base page size. In that case we need to clear
>
> Can you please elaborate on this ? What are those situations when we
> have 64K base page size on the PTE but we had inserted HPTE with base
> page size as 4K ?

when we demote a segment.

>
>> the existing slot information from the old pte. Fix this correctly
>> 
>> With THP, we also clear the slot information with respect to all
>> the 64K hash pte mapping that 16MB page. They are all invalid
>> now. This make sure we don't find the slot valid when we fault with
>> 4k base page size. Finding the slot valid should not result in any wrong
>> behavior because we do check again in hash page table for the validity.
>> But we can avoid that check completely.
>
> Makes sense.
>
>> 
>> Fixes: a43c0eb8364c022 ("powerpc/mm: Convert 4k hash insert to C")
>> 
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/mm/hash64_4k.c       |  2 +-
>>  arch/powerpc/mm/hash64_64k.c      | 12 +++++++++---
>>  arch/powerpc/mm/hugepage-hash64.c |  7 ++++++-
>>  3 files changed, 16 insertions(+), 5 deletions(-)
>> 
>> diff --git a/arch/powerpc/mm/hash64_4k.c b/arch/powerpc/mm/hash64_4k.c
>> index e7c04542ba62..e3e76b929f33 100644
>> --- a/arch/powerpc/mm/hash64_4k.c
>> +++ b/arch/powerpc/mm/hash64_4k.c
>> @@ -106,7 +106,7 @@ repeat:
>>  			}
>>  		}
>>  		/*
>> -		 * Hypervisor failure. Restore old pmd and return -1
>> +		 * Hypervisor failure. Restore old pte and return -1
>
> This change is not relevant here. Should be a separate patch.
>
>>  		 * similar to __hash_page_*
>>  		 */
>>  		if (unlikely(slot == -2)) {
>> diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
>> index 0762c1e08c88..b3895720edb0 100644
>> --- a/arch/powerpc/mm/hash64_64k.c
>> +++ b/arch/powerpc/mm/hash64_64k.c
>> @@ -111,7 +111,13 @@ int __hash_page_4K(unsigned long ea, unsigned long access, unsigned long vsid,
>>  	 */
>>  	if (!(old_pte & _PAGE_COMBO)) {
>>  		flush_hash_page(vpn, rpte, MMU_PAGE_64K, ssize, flags);
>> -		old_pte &= ~_PAGE_HASHPTE | _PAGE_F_GIX | _PAGE_F_SECOND;
>> +		/*
>> +		 * clear the old slot details from the old and new pte.
>> +		 * On hash insert failure we use old pte value and we don't
>> +		 * want slot information there if we have a insert failure.
>> +		 */
>> +		old_pte &= ~(_PAGE_HASHPTE | _PAGE_F_GIX | _PAGE_F_SECOND);
>> +		new_pte &= ~(_PAGE_HASHPTE | _PAGE_F_GIX | _PAGE_F_SECOND);
>
> But why we need clear the bits on new_pte as well ?

we use new pte when updating the actual pte towards the end of that function.


>
>>  		goto htab_insert_hpte;
>>  	}
>>  	/*
>> @@ -182,7 +188,7 @@ repeat:
>>  		}
>>  	}
>>  	/*
>> -	 * Hypervisor failure. Restore old pmd and return -1
>> +	 * Hypervisor failure. Restore old pte and return -1
>
> This change is not relevant here. Should be a separate patch.
>
>
>>  	 * similar to __hash_page_*
>>  	 */
>>  	if (unlikely(slot == -2)) {
>> @@ -305,7 +311,7 @@ repeat:
>>  			}
>>  		}
>>  		/*
>> -		 * Hypervisor failure. Restore old pmd and return -1
>> +		 * Hypervisor failure. Restore old pte and return -1
>>  		 * similar to __hash_page_*
>
> Ditto.

-anessh
