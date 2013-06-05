Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp08.in.ibm.com (e28smtp08.in.ibm.com [122.248.162.8])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp08.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id B6B452C013D
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  6 Jun 2013 01:28:54 +1000 (EST)
Received: from /spool/local
 by e28smtp08.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 5 Jun 2013 20:51:03 +0530
Received: from d28relay05.in.ibm.com (d28relay05.in.ibm.com [9.184.220.62])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 643901258053
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Jun 2013 21:00:58 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay05.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r55FSiOm6095220
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 5 Jun 2013 20:58:45 +0530
Received: from d28av02.in.ibm.com (loopback [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r55FSl4I007099
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 6 Jun 2013 01:28:49 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V10 14/15] powerpc: use smp_rmb when looking at deposisted
 pgtable to store hash index
Date: Wed,  5 Jun 2013 20:58:38 +0530
Message-Id: <1370446119-8837-15-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1370446119-8837-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We need to use smb_rmb when looking at hpte slot array. Otherwise we could
reorder the hpte_slot array load bfore even we marked the pmd trans huge.
Related smb_wmb()s is done in pgtable_trans_huge_deposit when we deposit
a pgtable.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable-ppc64.h | 15 +++++++++++++++
 arch/powerpc/mm/hugepage-hash64.c        |  6 +-----
 arch/powerpc/mm/pgtable_64.c             |  6 +-----
 3 files changed, 17 insertions(+), 10 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index d046289..46db094 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -10,6 +10,7 @@
 #else
 #include <asm/pgtable-ppc64-4k.h>
 #endif
+#include <asm/barrier.h>
 
 #define FIRST_USER_ADDRESS	0
 
@@ -393,6 +394,20 @@ static inline void mark_hpte_slot_valid(unsigned char *hpte_slot_array,
 	hpte_slot_array[index] = hidx << 4 | 0x1 << 3;
 }
 
+static inline char *get_hpte_slot_array(pmd_t *pmdp)
+{
+	/*
+	 * The hpte hindex is stored in the pgtable whose address is in the
+	 * second half of the PMD
+	 *
+	 * Order this load with the test for pmd_trans_huge in the caller
+	 */
+	smp_rmb();
+	return *(char **)(pmdp + PTRS_PER_PMD);
+
+
+}
+
 extern void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 				   pmd_t *pmdp);
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
diff --git a/arch/powerpc/mm/hugepage-hash64.c b/arch/powerpc/mm/hugepage-hash64.c
index 5241784..34de9e0 100644
--- a/arch/powerpc/mm/hugepage-hash64.c
+++ b/arch/powerpc/mm/hugepage-hash64.c
@@ -84,11 +84,7 @@ int __hash_page_thp(unsigned long ea, unsigned long access, unsigned long vsid,
 
 	vpn = hpt_vpn(ea, vsid, ssize);
 	hash = hpt_hash(vpn, shift, ssize);
-	/*
-	 * The hpte hindex are stored in the pgtable whose address is in the
-	 * second half of the PMD
-	 */
-	hpte_slot_array = *(char **)(pmdp + PTRS_PER_PMD);
+	hpte_slot_array = get_hpte_slot_array(pmdp);
 
 	valid = hpte_valid(hpte_slot_array, index);
 	if (valid) {
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 8501aa3..bbecac4 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -701,11 +701,7 @@ void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 	 * Flush all the hptes mapping this hugepage
 	 */
 	s_addr = addr & HPAGE_PMD_MASK;
-	/*
-	 * The hpte hindex are stored in the pgtable whose address is in the
-	 * second half of the PMD
-	 */
-	hpte_slot_array = *(char **)(pmdp + PTRS_PER_PMD);
+	hpte_slot_array = get_hpte_slot_array(pmdp);
 	/*
 	 * IF we try to do a HUGE PTE update after a withdraw is done.
 	 * we will find the below NULL. This happens when we do
-- 
1.8.1.2
