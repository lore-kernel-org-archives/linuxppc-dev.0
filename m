Return-Path: <khandual@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3x6KTW3xXQzDqb4
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 21:23:43 +1000 (AEST)
Received: from pps.filterd (m0098394.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.21/8.16.0.21) with SMTP id
 v6BBJYvu078174
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 07:23:41 -0400
Received: from e23smtp07.au.ibm.com (e23smtp07.au.ibm.com [202.81.31.140])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2bmc3gkp6b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 07:23:41 -0400
Received: from localhost
 by e23smtp07.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Tue, 11 Jul 2017 21:23:38 +1000
Received: from d23av05.au.ibm.com (d23av05.au.ibm.com [9.190.234.119])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 v6BBNSnO20119768
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 21:23:36 +1000
Received: from d23av05.au.ibm.com (localhost [127.0.0.1])
 by d23av05.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 v6BBN1Vv015768
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 11 Jul 2017 21:23:04 +1000
Subject: Re: [RFC v5 31/38] powerpc: introduce get_pte_pkey() helper
To: Ram Pai <linuxram@us.ibm.com>,
 Anshuman Khandual <khandual@linux.vnet.ibm.com>
References: <1499289735-14220-1-git-send-email-linuxram@us.ibm.com>
 <1499289735-14220-32-git-send-email-linuxram@us.ibm.com>
 <58e0d9ff-727f-c960-5c5f-16d19a89e181@linux.vnet.ibm.com>
 <20170710055502.GC5713@ram.oc3035372033.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
 linux-arch@vger.kernel.org, linux-mm@kvack.org, x86@kernel.org,
 linux-doc@vger.kernel.org, linux-kselftest@vger.kernel.org,
 benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 dave.hansen@intel.com, hbabu@us.ibm.com, arnd@arndb.de,
 akpm@linux-foundation.org, corbet@lwn.net, mingo@redhat.com
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
Date: Tue, 11 Jul 2017 16:52:40 +0530
MIME-Version: 1.0
In-Reply-To: <20170710055502.GC5713@ram.oc3035372033.ibm.com>
Content-Type: text/plain; charset=windows-1252
Message-Id: <94b76f58-1002-b3a7-7269-67129c795f25@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

On 07/10/2017 11:25 AM, Ram Pai wrote:
> On Mon, Jul 10, 2017 at 08:41:30AM +0530, Anshuman Khandual wrote:
>> On 07/06/2017 02:52 AM, Ram Pai wrote:
>>> get_pte_pkey() helper returns the pkey associated with
>>> a address corresponding to a given mm_struct.
>>>
>>> Signed-off-by: Ram Pai <linuxram@us.ibm.com>
>>> ---
>>>  arch/powerpc/include/asm/book3s/64/mmu-hash.h |    5 ++++
>>>  arch/powerpc/mm/hash_utils_64.c               |   28 +++++++++++++++++++++++++
>>>  2 files changed, 33 insertions(+), 0 deletions(-)
>>>
>>> diff --git a/arch/powerpc/include/asm/book3s/64/mmu-hash.h b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>>> index f7a6ed3..369f9ff 100644
>>> --- a/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>>> +++ b/arch/powerpc/include/asm/book3s/64/mmu-hash.h
>>> @@ -450,6 +450,11 @@ extern int hash_page(unsigned long ea, unsigned long access, unsigned long trap,
>>>  int __hash_page_huge(unsigned long ea, unsigned long access, unsigned long vsid,
>>>  		     pte_t *ptep, unsigned long trap, unsigned long flags,
>>>  		     int ssize, unsigned int shift, unsigned int mmu_psize);
>>> +
>>> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>>> +u16 get_pte_pkey(struct mm_struct *mm, unsigned long address);
>>> +#endif /* CONFIG_PPC64_MEMORY_PROTECTION_KEYS */
>>> +
>>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>>  extern int __hash_page_thp(unsigned long ea, unsigned long access,
>>>  			   unsigned long vsid, pmd_t *pmdp, unsigned long trap,
>>> diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
>>> index 1e74529..591990c 100644
>>> --- a/arch/powerpc/mm/hash_utils_64.c
>>> +++ b/arch/powerpc/mm/hash_utils_64.c
>>> @@ -1573,6 +1573,34 @@ void hash_preload(struct mm_struct *mm, unsigned long ea,
>>>  	local_irq_restore(flags);
>>>  }
>>>  
>>> +#ifdef CONFIG_PPC64_MEMORY_PROTECTION_KEYS
>>> +/*
>>> + * return the protection key associated with the given address
>>> + * and the mm_struct.
>>> + */
>>> +u16 get_pte_pkey(struct mm_struct *mm, unsigned long address)
>>> +{
>>> +	pte_t *ptep;
>>> +	u16 pkey = 0;
>>> +	unsigned long flags;
>>> +
>>> +	if (REGION_ID(address) == VMALLOC_REGION_ID)
>>> +		mm = &init_mm;
>>
>> IIUC, protection keys are only applicable for user space. This
>> function is getting used to populate siginfo structure. Then how
>> can we ever request this for any address in VMALLOC region.
> 
> make sense. this check is not needed.
> 
>>
>>> +
>>> +	if (!mm || !mm->pgd)
>>> +		return 0;
>>
>> Is this really required at this stage ?
> 
> its a sanity check to gaurd against bad inputs. See a problem?


I mean its okay, thought it to be unnecessary. Your call.
