Return-Path: <khandual@linux.vnet.ibm.com>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8472D1A1A40
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 29 Jul 2015 17:10:51 +1000 (AEST)
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by ozlabs.org (Postfix) with ESMTPS id BF640140774
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 17:10:50 +1000 (AEST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@ozlabs.org> from <khandual@linux.vnet.ibm.com>;
 Wed, 29 Jul 2015 12:40:49 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 2C75E125807B
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:43:49 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t6T7A76552822186
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:40:08 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t6T7A6dd001153
 for <linuxppc-dev@ozlabs.org>; Wed, 29 Jul 2015 12:40:07 +0530
From: Anshuman Khandual <khandual@linux.vnet.ibm.com>
To: linuxppc-dev@ozlabs.org
Cc: mpe@ellerman.id.au, mikey@neuling.org
Subject: [PATCH 2/8] powerpc/slb: Rename all the 'slot' occurrences to 'entry'
Date: Wed, 29 Jul 2015 12:39:59 +0530
Message-Id: <1438153805-31828-2-git-send-email-khandual@linux.vnet.ibm.com>
In-Reply-To: <1438153805-31828-1-git-send-email-khandual@linux.vnet.ibm.com>
References: <1438153805-31828-1-git-send-email-khandual@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

These are essentially SLB individual slots with entries what we are
dealing with in these functions. Usage of both 'entry' and 'slot'
synonyms makes it real confusing sometimes. This patch makes it
uniform across the file by replacing all those 'slot's with 'entry's.

Signed-off-by: Anshuman Khandual <khandual@linux.vnet.ibm.com>
---
 arch/powerpc/mm/slb.c | 7 +++----
 1 file changed, 3 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/mm/slb.c b/arch/powerpc/mm/slb.c
index 62fafb3..faf9f0c 100644
--- a/arch/powerpc/mm/slb.c
+++ b/arch/powerpc/mm/slb.c
@@ -41,9 +41,9 @@ static void slb_allocate(unsigned long ea)
 	(((ssize) == MMU_SEGSIZE_256M)? ESID_MASK: ESID_MASK_1T)
 
 static inline unsigned long mk_esid_data(unsigned long ea, int ssize,
-					 unsigned long slot)
+					 unsigned long entry)
 {
-	return (ea & slb_esid_mask(ssize)) | SLB_ESID_V | slot;
+	return (ea & slb_esid_mask(ssize)) | SLB_ESID_V | entry;
 }
 
 static inline unsigned long mk_vsid_data(unsigned long ea, int ssize,
@@ -308,12 +308,11 @@ void slb_initialize(void)
 	lflags = SLB_VSID_KERNEL | linear_llp;
 	vflags = SLB_VSID_KERNEL | vmalloc_llp;
 
-	/* Invalidate the entire SLB (even slot 0) & all the ERATS */
+	/* Invalidate the entire SLB (even entry 0) & all the ERATS */
 	asm volatile("isync":::"memory");
 	asm volatile("slbmte  %0,%0"::"r" (0) : "memory");
 	asm volatile("isync; slbia; isync":::"memory");
 	create_shadowed_slbe(PAGE_OFFSET, mmu_kernel_ssize, lflags, 0);
-
 	create_shadowed_slbe(VMALLOC_START, mmu_kernel_ssize, vflags, 1);
 
 	/* For the boot cpu, we're running on the stack in init_thread_union,
-- 
2.1.0
