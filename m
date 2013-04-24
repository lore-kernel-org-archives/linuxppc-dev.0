Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp05.in.ibm.com (e28smtp05.in.ibm.com [122.248.162.5])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp05.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2CD5D2C00BE
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 19:08:13 +1000 (EST)
Received: from /spool/local
 by e28smtp05.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 24 Apr 2013 14:34:35 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 78D6D1258055
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 14:39:41 +0530 (IST)
Received: from d28av01.in.ibm.com (d28av01.in.ibm.com [9.184.220.63])
 by d28relay02.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3O981775767438
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 14:38:01 +0530
Received: from d28av01.in.ibm.com (loopback [127.0.0.1])
 by d28av01.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3O984Cs027577
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 24 Apr 2013 09:08:05 GMT
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH -V6 18/27] mm/THP: withdraw the pgtable after pmdp related
 operations
In-Reply-To: <20130422154901.GC13442@redhat.com>
References: <1366624861-24948-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1366624861-24948-19-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130422154901.GC13442@redhat.com>
Date: Wed, 24 Apr 2013 14:38:01 +0530
Message-ID: <87a9oo2t5a.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 David Gibson <dwg@au1.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Andrea Arcangeli <aarcange@redhat.com> writes:

> Hi,
>
> On Mon, Apr 22, 2013 at 03:30:52PM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> For architectures like ppc64 we look at deposited pgtable when
>> calling pmdp_get_and_clear. So do the pgtable_trans_huge_withdraw
>> after finishing pmdp related operations.
>> 
>> Cc: Andrea Arcangeli <aarcange@redhat.com>
>> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
>> ---
>>  mm/huge_memory.c |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>> 
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 84f3180..2a43782 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1363,9 +1363,10 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
>>  		struct page *page;
>>  		pgtable_t pgtable;
>>  		pmd_t orig_pmd;
>> -		pgtable = pgtable_trans_huge_withdraw(tlb->mm, pmd);
>> +
>>  		orig_pmd = pmdp_get_and_clear(tlb->mm, addr, pmd);
>>  		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
>> +		pgtable = pgtable_trans_huge_withdraw(tlb->mm, pmd);
>>  		if (is_huge_zero_pmd(orig_pmd)) {
>>  			tlb->mm->nr_ptes--;
>>  			spin_unlock(&tlb->mm->page_table_lock);
>
> I think here a comment inline (not only in the commit msg) is in
> order. Otherwise it's hard to imagine others to be aware of this arch
> detail when they will read the code later. So it would be prone to
> break later without a comment.

How about ?

>From 7444a5eda33c00eea465b51c405cb830c57513b7 Mon Sep 17 00:00:00 2001
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Date: Wed, 6 Mar 2013 12:50:37 +0530
Subject: [PATCH] mm/THP: withdraw the pgtable after pmdp related operations

For architectures like ppc64 we look at deposited pgtable when
calling pmdp_get_and_clear. So do the pgtable_trans_huge_withdraw
after finishing pmdp related operations.

Cc: Andrea Arcangeli <aarcange@redhat.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 mm/huge_memory.c |    8 +++++++-
 1 file changed, 7 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 84f3180..21c5ebd 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -1363,9 +1363,15 @@ int zap_huge_pmd(struct mmu_gather *tlb, struct vm_area_struct *vma,
 		struct page *page;
 		pgtable_t pgtable;
 		pmd_t orig_pmd;
-		pgtable = pgtable_trans_huge_withdraw(tlb->mm, pmd);
+		/*
+		 * For architectures like ppc64 we look at deposited pgtable
+		 * when calling pmdp_get_and_clear. So do the
+		 * pgtable_trans_huge_withdraw after finishing pmdp related
+		 * operations.
+		 */
 		orig_pmd = pmdp_get_and_clear(tlb->mm, addr, pmd);
 		tlb_remove_pmd_tlb_entry(tlb, pmd, addr);
+		pgtable = pgtable_trans_huge_withdraw(tlb->mm, pmd);
 		if (is_huge_zero_pmd(orig_pmd)) {
 			tlb->mm->nr_ptes--;
 			spin_unlock(&tlb->mm->page_table_lock);
-- 
1.7.10
