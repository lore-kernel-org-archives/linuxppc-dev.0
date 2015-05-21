Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp05.au.ibm.com (e23smtp05.au.ibm.com [202.81.31.147])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 568171A0B01
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 17:02:54 +1000 (AEST)
Received: from /spool/local
 by e23smtp05.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 21 May 2015 17:02:39 +1000
Received: from d23relay08.au.ibm.com (d23relay08.au.ibm.com [9.185.71.33])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id C58FB3578053
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 17:02:33 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay08.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4L72OYb9306296
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 17:02:33 +1000
Received: from d23av02.au.ibm.com (localhost [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4L7209G026318
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 21 May 2015 17:02:00 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Andrew Morton <akpm@linux-foundation.org>
Cc: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 kirill.shutemov@linux.intel.com, aarcange@redhat.com,
 schwidefsky@de.ibm.com, linux-mm@kvack.org,
 linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Subject: Re: [PATCH V5 2/3] powerpc/mm: Use generic version of pmdp_clear_flush
In-Reply-To: <20150520124428.9bab9007d7d589ec4b615ee6@linux-foundation.org>
References: <1431704550-19937-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1431704550-19937-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20150520124428.9bab9007d7d589ec4b615ee6@linux-foundation.org>
Date: Thu, 21 May 2015 12:31:31 +0530
Message-ID: <87382q5s8k.fsf@linux.vnet.ibm.com>
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

Andrew Morton <akpm@linux-foundation.org> writes:

> On Fri, 15 May 2015 21:12:29 +0530 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com> wrote:
>
>> Also move the pmd_trans_huge check to generic code.
>> 
>> ...
>>
>> --- a/include/asm-generic/pgtable.h
>> +++ b/include/asm-generic/pgtable.h
>> @@ -196,7 +196,12 @@ static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
>>  					unsigned long address,
>>  					pmd_t *pmdp)
>>  {
>> -	return pmdp_clear_flush(vma, address, pmdp);
>> +	pmd_t pmd;
>> +	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
>> +	VM_BUG_ON(pmd_trans_huge(*pmdp));
>> +	pmd = pmdp_get_and_clear(vma->vm_mm, address, pmdp);
>> +	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
>> +	return pmd;
>>  }
>
> x86_64 allmodconfig:
>
> In file included from ./arch/x86/include/asm/pgtable.h:878,
>                  from include/linux/mm.h:53,
>                  from include/linux/suspend.h:8,
>                  from arch/x86/kernel/asm-offsets.c:12:
> include/asm-generic/pgtable.h: In function 'pmdp_collapse_flush':
> include/asm-generic/pgtable.h:199: error: 'HPAGE_PMD_MASK' undeclared (first use in this function)
> include/asm-generic/pgtable.h:199: error: (Each undeclared identifier is reported only once
> include/asm-generic/pgtable.h:199: error: for each function it appears in.)
> include/asm-generic/pgtable.h:202: error: implicit declaration of function 'flush_tlb_range'
> include/asm-generic/pgtable.h:202: error: 'HPAGE_PMD_SIZE' undeclared (first use in this function)
>

Sorry for the build break. I was mostly focusing on the ppc64 build with
different platforms and was hoping that will include all thp/enable
disable configs. Unfortunately, we needed a config that is thp enabled and
use generic pgtable.h. Will make sure that I test build and boot test on
x86 before sending patch next time.


>
> Including linux/huge_mm.h doesn't work.  A suitable fix would be to
> move this into a .c file.


that helped.

commit 3ef98ff8092789f7b58f3662297a80eff8d757ea
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Mon May 11 15:53:21 2015 +0530

    powerpc/mm: Use generic version of pmdp_clear_flush
    
    Also move the pmd_trans_huge check to generic code.
    
    Acked-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 129c67ebc81a..55f06a381dd7 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -557,10 +557,6 @@ extern int pmdp_clear_flush_young(struct vm_area_struct *vma,
 extern pmd_t pmdp_get_and_clear(struct mm_struct *mm,
 				unsigned long addr, pmd_t *pmdp);
 
-#define __HAVE_ARCH_PMDP_CLEAR_FLUSH
-extern pmd_t pmdp_clear_flush(struct vm_area_struct *vma, unsigned long address,
-			      pmd_t *pmdp);
-
 #define __HAVE_ARCH_PMDP_SET_WRPROTECT
 static inline void pmdp_set_wrprotect(struct mm_struct *mm, unsigned long addr,
 				      pmd_t *pmdp)
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 9171c1a37290..d37b9d1a1813 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -554,17 +554,6 @@ unsigned long pmd_hugepage_update(struct mm_struct *mm, unsigned long addr,
 	return old;
 }
 
-pmd_t pmdp_clear_flush(struct vm_area_struct *vma, unsigned long address,
-		       pmd_t *pmdp)
-{
-	pmd_t pmd;
-
-	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
-	VM_BUG_ON(!pmd_trans_huge(*pmdp));
-	pmd = pmdp_get_and_clear(vma->vm_mm, address, pmdp);
-	return pmd;
-}
-
 pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
 			  pmd_t *pmdp)
 {
diff --git a/arch/s390/include/asm/pgtable.h b/arch/s390/include/asm/pgtable.h
index fc642399b489..17627f73a032 100644
--- a/arch/s390/include/asm/pgtable.h
+++ b/arch/s390/include/asm/pgtable.h
@@ -1548,6 +1548,14 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
 	}
 }
 
+static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
+					unsigned long address,
+					pmd_t *pmdp)
+{
+	return pmdp_get_and_clear(vma->vm_mm, address, pmdp);
+}
+#define pmdp_collapse_flush pmdp_collapse_flush
+
 #define pfn_pmd(pfn, pgprot)	mk_pmd_phys(__pa((pfn) << PAGE_SHIFT), (pgprot))
 #define mk_pmd(page, pgprot)	pfn_pmd(page_to_pfn(page), (pgprot))
 
diff --git a/include/asm-generic/pgtable.h b/include/asm-generic/pgtable.h
index 2c3ca89e9aee..3b5a89ab4103 100644
--- a/include/asm-generic/pgtable.h
+++ b/include/asm-generic/pgtable.h
@@ -191,13 +191,8 @@ extern void pmdp_splitting_flush(struct vm_area_struct *vma,
 
 #ifndef pmdp_collapse_flush
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
-static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
-					unsigned long address,
-					pmd_t *pmdp)
-{
-	return pmdp_clear_flush(vma, address, pmdp);
-}
-#define pmdp_collapse_flush pmdp_collapse_flush
+extern pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
+				 unsigned long address, pmd_t *pmdp);
 #else
 static inline pmd_t pmdp_collapse_flush(struct vm_area_struct *vma,
 					unsigned long address,
diff --git a/mm/pgtable-generic.c b/mm/pgtable-generic.c
index c25f94b33811..7f2314f9e16f 100644
--- a/mm/pgtable-generic.c
+++ b/mm/pgtable-generic.c
@@ -126,6 +126,7 @@ pmd_t pmdp_clear_flush(struct vm_area_struct *vma, unsigned long address,
 {
 	pmd_t pmd;
 	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
+	VM_BUG_ON(!pmd_trans_huge(*pmdp));
 	pmd = pmdp_get_and_clear(vma->vm_mm, address, pmdp);
 	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
 	return pmd;
@@ -198,3 +199,18 @@ void pmdp_invalidate(struct vm_area_struct *vma, unsigned long address,
 }
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 #endif
+
+#ifndef pmdp_collapse_flush
+#ifdef CONFIG_TRANSPARENT_HUGEPAGE
+pmd_t pmdp_collapse_flush(struct vm_area_struct *vma, unsigned long address,
+			  pmd_t *pmdp)
+{
+	pmd_t pmd;
+	VM_BUG_ON(address & ~HPAGE_PMD_MASK);
+	VM_BUG_ON(pmd_trans_huge(*pmdp));
+	pmd = pmdp_get_and_clear(vma->vm_mm, address, pmdp);
+	flush_tlb_range(vma, address, address + HPAGE_PMD_SIZE);
+	return pmd;
+}
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+#endif
