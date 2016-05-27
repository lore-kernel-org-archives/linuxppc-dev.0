Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rGGLk63qFzDqYC
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 16:29:02 +1000 (AEST)
Received: from pps.filterd (m0082756.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u4R6OJCs007146
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 02:29:01 -0400
Message-Id: <201605270629.u4R6OJCs007146@mx0a-001b2d01.pphosted.com>
Received: from e23smtp02.au.ibm.com (e23smtp02.au.ibm.com [202.81.31.144])
 by mx0a-001b2d01.pphosted.com with ESMTP id 236b6t04ev-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 02:29:00 -0400
Received: from localhost
 by e23smtp02.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 27 May 2016 16:28:58 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp01.au.ibm.com (Postfix) with ESMTP id 69A362CE805F
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 16:28:46 +1000 (EST)
Received: from d23av01.au.ibm.com (d23av01.au.ibm.com [9.190.234.96])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u4R6SJHO54263918
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 16:28:41 +1000
Received: from d23av01.au.ibm.com (localhost [127.0.0.1])
 by d23av01.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u4R6RCCJ013066
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 27 May 2016 16:27:13 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Hugh Dickins <hughd@google.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm/hash: Fix the reference bit update when handling
 hash fault
Date: Fri, 27 May 2016 11:56:11 +0530
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

When we converted the asm routines to C functions, we missed updating
HPTE_R_R based on _PAGE_ACCESSED. ASM code used to copy over the lower
bits from pte via.

andi.	r3,r30,0x1fe		/* Get basic set of flags */

Fixes: 'commit 89ff725051d1 ("powerpc/mm: Convert __hash_page_64K to C")'

We also don't set C bit always with this patch. This was added by
'commit c5cf0e30bf3d8 ("[PATCH] powerpc: Fix buglet with MMU hash management")'

With hash64, we need to make sure that hardware doesn't do a pte update
directly. This is because we do end up with entries in TLB with no hash
page table entry. This happens because when we find hash bucket full,
we "evict" a more/less random entry from it. When we do that we don't
invalidate the TLB (hpte_remove) because we assume the old translation
is still technically "valid". For more info look at
'commit 0608d692463(" powerpc/mm: Always invalidate tlb on hpte invalidate and
update")'. Now that implies that hardware should never do a writeback to
update 'R' or 'C' hpte bits.

Commitc 5cf0e30bf3d8 did that for 'C' bit by enabling 'C' bit always.
We don't really need to do that because we never map a RW pte entry
without setting 'C' bit. on READ fault on a RW pte entry, we still map
it READ only, hence a store update in the page will still cause a hash
pte fault.

This patch reverts the 'C' update part of the c5cf0e30bf3d8
("[PATCH] powerpc: Fix buglet with MMU hash management") and retain
the updatepp part.
- If we hit the updatepp path on native, the old code without that
  commit, would fail to set C bcause native_hpte_updatepp()
  was implemented to filter the same bits as H_PROTECT and not let C
  through thus we would "upgrade" a RO HPTE to RW without setting C
  thus causing the bug. So the real fix in that commit was the change
  to native_hpte_updatepp

Signed-off-by: Benjamin Herrenschmidt <benh@kernel.crashing.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/mm/hash_utils_64.c | 22 ++++++++++++++++++++--
 1 file changed, 20 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 9c594ea99149..76fa5f3eb450 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -159,6 +159,19 @@ static struct mmu_psize_def mmu_psize_defaults_gp[] = {
 	},
 };
 
+/*
+ * 'R' and 'C' update notes:
+ *  - Under pHyp or KVM, the updatepp path will not set C, thus it *will*
+ *     create writeable HPTEs without C set, because the hcall H_PROTECT
+ *     that we use in that case will not update C
+ *  - The above is however not a problem, because we also don't do that
+ *     fancy "no flush" variant of eviction and we use H_REMOVE which will
+ *     do the right thing and thus we don't have the race I described earlier
+ *
+ *    - Under bare metal,  we do have the race, so we need R and C set
+ *    - We make sure R is always set and never lost
+ *    - C is _PAGE_DIRTY, and *should* always be set for a writeable mapping
+ */
 unsigned long htab_convert_pte_flags(unsigned long pteflags)
 {
 	unsigned long rflags = 0;
@@ -186,9 +199,14 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
 			rflags |= 0x1;
 	}
 	/*
-	 * Always add "C" bit for perf. Memory coherence is always enabled
+	 * We can't allow hardware to update hpte bits. Hence always
+	 * set 'R' bit and set 'C' if it is a write fault
+	 * Memory coherence is always enabled
 	 */
-	rflags |=  HPTE_R_C | HPTE_R_M;
+	rflags |=  HPTE_R_R | HPTE_R_M;
+
+	if (pteflags & _PAGE_DIRTY)
+		rflags |= HPTE_R_C;
 	/*
 	 * Add in WIG bits
 	 */
-- 
2.7.4
