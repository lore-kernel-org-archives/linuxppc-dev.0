Return-Path: <aneesh.kumar@linux.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com
 [148.163.156.1])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 41bL5n1N0NzDrVP
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 26 Jul 2018 02:19:25 +1000 (AEST)
Received: from pps.filterd (m0098409.ppops.net [127.0.0.1])
 by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id
 w6PGFdbw079108
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 12:19:23 -0400
Received: from e13.ny.us.ibm.com (e13.ny.us.ibm.com [129.33.205.203])
 by mx0a-001b2d01.pphosted.com with ESMTP id 2keu8fkyw4-1
 (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 25 Jul 2018 12:19:22 -0400
Received: from localhost
 by e13.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.ibm.com>;
 Wed, 25 Jul 2018 12:19:20 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
To: npiggin@gmail.com, benh@kernel.crashing.org, paulus@samba.org,
 mpe@ellerman.id.au, Naoya Horiguchi <n-horiguchi@ah.jp.nec.com>
Cc: linuxppc-dev@lists.ozlabs.org, linux-mm@kvack.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Subject: [PATCH V2 2/6] powerpc/mm/hugetlb/book3s: add _PAGE_PRESENT to hugepd
 pointer.
Date: Wed, 25 Jul 2018 21:48:59 +0530
In-Reply-To: <20180725161903.31257-1-aneesh.kumar@linux.ibm.com>
References: <20180725161903.31257-1-aneesh.kumar@linux.ibm.com>
Message-Id: <20180725161903.31257-2-aneesh.kumar@linux.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

This make hugetlb directory pointer similar to other page able entries. A hugepd
entry is identified by lack of _PAGE_PTE bit set and directory size stored in
HUGEPD_SHIFT_MASK. We update that to also look at _PAGE_PRESENT

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h | 2 +-
 arch/powerpc/include/asm/book3s/64/hugetlb.h | 3 +++
 arch/powerpc/mm/hugetlbpage.c                | 2 +-
 3 files changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 9a3798660cef..15bc16b1dc9c 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -66,7 +66,7 @@ static inline int hash__hugepd_ok(hugepd_t hpd)
 	 * if it is not a pte and have hugepd shift mask
 	 * set, then it is a hugepd directory pointer
 	 */
-	if (!(hpdval & _PAGE_PTE) &&
+	if (!(hpdval & _PAGE_PTE) && (hpdval & _PAGE_PRESENT) &&
 	    ((hpdval & HUGEPD_SHIFT_MASK) != 0))
 		return true;
 	return false;
diff --git a/arch/powerpc/include/asm/book3s/64/hugetlb.h b/arch/powerpc/include/asm/book3s/64/hugetlb.h
index 50888388a359..5b0177733994 100644
--- a/arch/powerpc/include/asm/book3s/64/hugetlb.h
+++ b/arch/powerpc/include/asm/book3s/64/hugetlb.h
@@ -39,4 +39,7 @@ static inline bool gigantic_page_supported(void)
 }
 #endif
 
+/* hugepd entry valid bit */
+#define HUGEPD_VAL_BITS		(0x8000000000000000UL)
+
 #endif
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index f425b5b37d58..7ae5e4bfd318 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -95,7 +95,7 @@ static int __hugepte_alloc(struct mm_struct *mm, hugepd_t *hpdp,
 			break;
 		else {
 #ifdef CONFIG_PPC_BOOK3S_64
-			*hpdp = __hugepd(__pa(new) |
+			*hpdp = __hugepd(__pa(new) | HUGEPD_VAL_BITS |
 					 (shift_to_mmu_psize(pshift) << 2));
 #elif defined(CONFIG_PPC_8xx)
 			*hpdp = __hugepd(__pa(new) | _PMD_USER |
-- 
2.17.1
