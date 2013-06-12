Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 38B892C008A
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 16:30:24 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 12 Jun 2013 11:54:29 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 95209125804E
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 11:59:09 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r5C6UCWG22478894
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 12:00:12 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r5C6UEKQ023804
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Jun 2013 16:30:16 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: Scott Wood <scottwood@freescale.com>, Scott Wood <scottwood@freescale.com>
Subject: Re: [PATCH -V7 09/18] powerpc: Switch 16GB and 16MB explicit
 hugepages to a different page table format
In-Reply-To: <1370991027.18413.33@snotra>
References: <87obbgpmk3.fsf@linux.vnet.ibm.com> <1370984023.18413.30@snotra>
 <1370991027.18413.33@snotra>
Date: Wed, 12 Jun 2013 12:00:13 +0530
Message-ID: <8738snj0y2.fsf@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: linux-mm@kvack.org, paulus@samba.org, linuxppc-dev@lists.ozlabs.org,
 dwg@au1.ibm.com
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Scott Wood <scottwood@freescale.com> writes:

> On 06/11/2013 03:53:43 PM, Scott Wood wrote:
>> On 06/08/2013 11:57:48 AM, Aneesh Kumar K.V wrote:
>>> With the config shared I am not finding anything wrong, but I can't  
>>> test
>>> these configs. Also can you confirm what you bisect this to
>>> 
>>> e2b3d202d1dba8f3546ed28224ce485bc50010be
>>> powerpc: Switch 16GB and 16MB explicit hugepages to a different page  
>>> table format
>> 
>>> 
>>> or
>>> 
>>> cf9427b85e90bb1ff90e2397ff419691d983c68b "powerpc: New hugepage  
>>> directory format"
>> 
>> It's e2b3d202d1dba8f3546ed28224ce485bc50010be.
>> 
>> It turned out to be the change from "pmd_none" to  
>> "pmd_none_or_clear_bad".  Making that change triggers the "bad pmd"  
>> messages even when applied to v3.9 -- so we had bad pmds all along,  
>> undetected.  Now I get to figure out why. :-(
>
> So, for both pud and pgd we only call "or_clear_bad" when is_hugepd  
> returns false.  Why is it OK to do it unconditionally for pmd?
>

Ok, that could be the issue. Now the reason why we want to call
pmd_clear is to take care of explicit hugepage pte saved in the
pmd slot. We should already find the slot cleared otherwise it
is a corruption. How about the below ? The current code is broken
in that we will never take that free_hugepd_range call at all.

commit a09f59fe477242a3ebd153e618a705ac8f6c1b89
Author: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Date:   Wed Jun 12 11:32:58 2013 +0530

    powerpc: Fix bad pmd error with FSL config
    
    FSL uses the hugepd at PMD level and don't encode pte directly
    at the pmd level. So it will find the lower bits of pmd set
    and the pmd_bad check throws error. Infact the current code
    will never take the free_hugepd_range call at all because it will
    clear the pmd if it find a hugepd pointer.
    
    Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index f2f01fd..315fbd4 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -536,19 +536,28 @@ static void hugetlb_free_pmd_range(struct mmu_gather *tlb, pud_t *pud,
 	do {
 		pmd = pmd_offset(pud, addr);
 		next = pmd_addr_end(addr, end);
-		if (pmd_none_or_clear_bad(pmd))
-			continue;
+		if (!is_hugepd(pmd)) {
+			/*
+			 * if it is not hugepd pointer, we should already find
+			 * it cleared.
+			 */
+			if (!pmd_none_or_clear_bad(pmd))
+				WARN_ON(1);
+		} else {
+			if (pmd_none(*pmd))
+				continue;
 #ifdef CONFIG_PPC_FSL_BOOK3E
-		/*
-		 * Increment next by the size of the huge mapping since
-		 * there may be more than one entry at this level for a
-		 * single hugepage, but all of them point to
-		 * the same kmem cache that holds the hugepte.
-		 */
-		next = addr + (1 << hugepd_shift(*(hugepd_t *)pmd));
+			/*
+			 * Increment next by the size of the huge mapping since
+			 * there may be more than one entry at this level for a
+			 * single hugepage, but all of them point to
+			 * the same kmem cache that holds the hugepte.
+			 */
+			next = addr + (1 << hugepd_shift(*(hugepd_t *)pmd));
 #endif
-		free_hugepd_range(tlb, (hugepd_t *)pmd, PMD_SHIFT,
-				  addr, next, floor, ceiling);
+			free_hugepd_range(tlb, (hugepd_t *)pmd, PMD_SHIFT,
+					  addr, next, floor, ceiling);
+		}
 	} while (addr = next, addr != end);
 
 	start &= PUD_MASK;
