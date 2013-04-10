Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp02.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 002F42C00AC
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 04:27:37 +1000 (EST)
Received: from /spool/local
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 11 Apr 2013 04:20:07 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id BAE32357804E
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 04:27:35 +1000 (EST)
Received: from d23av02.au.ibm.com (d23av02.au.ibm.com [9.190.235.138])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r3AIQt0512124538
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 04:26:55 +1000
Received: from d23av02.au.ibm.com (loopback [127.0.0.1])
 by d23av02.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r3AIQxkM014609
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 11 Apr 2013 04:27:00 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Michael Ellerman <michael@ellerman.id.au>
Subject: Re: [PATCH -V5 19/25] powerpc/THP: Differentiate THP PMD entries from
 HUGETLB PMD entries
In-Reply-To: <20130410072122.GC24786@concordia>
References: <1365055083-31956-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <1365055083-31956-20-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
 <20130410072122.GC24786@concordia>
Date: Wed, 10 Apr 2013 23:56:56 +0530
Message-ID: <878v4qnswf.fsf@linux.vnet.ibm.com>
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

Michael Ellerman <michael@ellerman.id.au> writes:

> On Thu, Apr 04, 2013 at 11:27:57AM +0530, Aneesh Kumar K.V wrote:
>> From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
>> 
>> HUGETLB clear the top bit of PMD entries and use that to indicate
>> a HUGETLB page directory. Since we store pfns in PMDs for THP,
>> we would have the top bit cleared by default. Add the top bit mask
>> for THP PMD entries and clear that when we are looking for pmd_pfn.
>> 
>> @@ -44,6 +44,14 @@ struct mm_struct;
>>  #define PMD_HUGE_RPN_SHIFT	PTE_RPN_SHIFT
>>  #define HUGE_PAGE_SIZE		(ASM_CONST(1) << 24)
>>  #define HUGE_PAGE_MASK		(~(HUGE_PAGE_SIZE - 1))
>> +/*
>> + * HugeTLB looks at the top bit of the Linux page table entries to
>> + * decide whether it is a huge page directory or not. Mark HUGE
>> + * PMD to differentiate
>> + */
>> +#define PMD_HUGE_NOT_HUGETLB	(ASM_CONST(1) << 63)
>> +#define PMD_ISHUGE		(_PMD_ISHUGE | PMD_HUGE_NOT_HUGETLB)
>> +#define PMD_HUGE_PROTBITS	(0xfff | PMD_HUGE_NOT_HUGETLB)
>>  
>>  #ifndef __ASSEMBLY__
>>  extern void hpte_need_hugepage_flush(struct mm_struct *mm, unsigned long addr,
>> @@ -84,7 +93,8 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
>>  	/*
>>  	 * Only called for hugepage pmd
>>  	 */
>> -	return pmd_val(pmd) >> PMD_HUGE_RPN_SHIFT;
>> +	unsigned long val = pmd_val(pmd) & ~PMD_HUGE_PROTBITS;
>> +	return val  >> PMD_HUGE_RPN_SHIFT;
>>  }
>
> This is breaking the 32-bit build for me (pmac32_defconfig):
>
> arch/powerpc/include/asm/pgtable.h:123:2: error: left shift count >= width of type [-Werror]
>



diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 5617dee..30c765a 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -110,11 +110,6 @@ static inline int has_transparent_hugepage(void)
 	return 1;
 }
 
-#else
-#define pmd_large(pmd)		0
-#define has_transparent_hugepage() 0
-#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-
 static inline unsigned long pmd_pfn(pmd_t pmd)
 {
 	/*
@@ -124,6 +119,11 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
 	return val  >> PMD_HUGE_RPN_SHIFT;
 }
 
+#else
+#define pmd_large(pmd)		0
+#define has_transparent_hugepage() 0
+#endif /* CONFIG_TRANSPARENT_HUGEPAGE */
+
 static inline int pmd_young(pmd_t pmd)
 {
 	return pmd_val(pmd) & PMD_HUGE_ACCESSED;
