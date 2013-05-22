Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [122.248.162.1])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp01.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id D00912C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 02:58:29 +1000 (EST)
Received: from /spool/local
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 22 May 2013 22:22:36 +0530
Received: from d28relay03.in.ibm.com (d28relay03.in.ibm.com [9.184.220.60])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id C98913940058
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 22:28:26 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay03.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4MGwHxL11796888
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 22 May 2013 22:28:17 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4MGwMSA020867
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 23 May 2013 02:58:24 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, dwg@au1.ibm.com
Subject: [PATCH -V9 19/20] powerpc: use smp_rmb when looking at deposisted
 pgtable to store hash index
Date: Wed, 22 May 2013 22:27:51 +0530
Message-Id: <1369241872-15700-20-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1369241872-15700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1369241872-15700-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
index e430766..c3ba3d5 100644
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
index 8dd7c83..19d6734 100644
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
