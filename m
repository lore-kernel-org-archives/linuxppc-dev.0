Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp06.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 7AB2D2C00D7
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 05:07:46 +1000 (EST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 4 May 2013 05:01:38 +1000
Received: from d23relay04.au.ibm.com (d23relay04.au.ibm.com [9.190.234.120])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 84C47357804E
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  4 May 2013 05:07:22 +1000 (EST)
Received: from d23av04.au.ibm.com (d23av04.au.ibm.com [9.190.235.139])
 by d23relay04.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r43IraG412058674
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 4 May 2013 04:53:36 +1000
Received: from d23av04.au.ibm.com (loopback [127.0.0.1])
 by d23av04.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r43J7Lk0027120
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 4 May 2013 05:07:22 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: David Gibson <dwg@au1.ibm.com>
Subject: Re: [PATCH -V7 10/10] powerpc: disable assert_pte_locked
In-Reply-To: <20130503053027.GV13041@truffula.fritz.box>
References: <1367178711-8232-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1367178711-8232-11-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130503053027.GV13041@truffula.fritz.box>
Date: Sat, 04 May 2013 00:37:18 +0530
Message-ID: <87d2t751cp.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

David Gibson <dwg@au1.ibm.com> writes:

> On Mon, Apr 29, 2013 at 01:21:51AM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> With THP we set pmd to none, before we do pte_clear. Hence we can't
>> walk page table to get the pte lock ptr and verify whether it is locked.
>> THP do take pte lock before calling pte_clear. So we don't change the locking
>> rules here. It is that we can't use page table walking to check whether
>> pte locks are help with THP.
>> 
>> NOTE: This needs to be re-written. Not to be merged upstream.
>
> So, rewrite it..


That is something we need to discuss more. We can't do the pte_locked
assert the way we do now. Because as explained above, thp collapse
depend on setting pmd to none before doing pte_clear. So we clearly
cannot walk the page table and fine the ptl to check whether we are
holding that lock. But yes, these asserts are valid. Those function
should be called holding ptl locks. I still haven't found an alternative
way to do those asserts. Any suggestions ?


>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  arch/powerpc/mm/pgtable.c | 2 ++
>>  1 file changed, 2 insertions(+)
>> 
>> diff --git a/arch/powerpc/mm/pgtable.c b/arch/powerpc/mm/pgtable.c
>> index 214130a..d77f94f 100644
>> --- a/arch/powerpc/mm/pgtable.c
>> +++ b/arch/powerpc/mm/pgtable.c
>> @@ -224,6 +224,7 @@ int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long address,
>>  #ifdef CONFIG_DEBUG_VM
>>  void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
>>  {
>> +#if 0
>>  	pgd_t *pgd;
>>  	pud_t *pud;
>>  	pmd_t *pmd;
>> @@ -237,6 +238,7 @@ void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
>>  	pmd = pmd_offset(pud, addr);
>>  	BUG_ON(!pmd_present(*pmd));
>>  	assert_spin_locked(pte_lockptr(mm, pmd));
>> +#endif
>>  }
>>  #endif /* CONFIG_DEBUG_VM */
>>  
>

-aneesh
