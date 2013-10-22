Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp07.in.ibm.com (e28smtp07.in.ibm.com [122.248.162.7])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp07.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 8F1152C00AD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 23:34:58 +1100 (EST)
Received: from /spool/local
 by e28smtp07.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 22 Oct 2013 18:04:56 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 4060B3942972
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 16:58:16 +0530 (IST)
Received: from d28av04.in.ibm.com (d28av04.in.ibm.com [9.184.220.66])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r9MBSWjt33423390
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 16:58:33 +0530
Received: from d28av04.in.ibm.com (localhost [127.0.0.1])
 by d28av04.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 r9MBSYBG023208
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 22 Oct 2013 16:58:35 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, linux-mm@kvack.org
Subject: [RFC PATCH 6/9] powerpc: mm: book3s: Disable hugepaged pmd format for
 book3s
Date: Tue, 22 Oct 2013 16:58:17 +0530
Message-Id: <1382441300-1513-7-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1382441300-1513-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1382441300-1513-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

After commit e2b3d202d1dba8f3546ed28224ce485bc50010be we have the
below possible formats for pmd entry

(1) invalid (all zeroes)
(2) pointer to next table, as normal; bottom 6 bits == 0
(3) leaf pte for huge page, bottom two bits != 00
(4) hugepd pointer, bottom two bits == 00, next 4 bits indicate size of table

On book3s we don't really use the (4).  For Numa balancing we need to
tag pmd entries that are pointer to next table with _PAGE_NUMA for
performance reason (9532fec118d485ea37ab6e3ea372d68cd8b4cd0d). This
patch enables that by disabling hugepd support for book3s if
NUMA_BALANCING is enabled. We ideally want to get rid of hugepd pointer
completely.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/page.h | 11 +++++++++++
 arch/powerpc/mm/hugetlbpage.c   |  8 +++++++-
 2 files changed, 18 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/page.h b/arch/powerpc/include/asm/page.h
index b9f4262..791ab56 100644
--- a/arch/powerpc/include/asm/page.h
+++ b/arch/powerpc/include/asm/page.h
@@ -369,11 +369,22 @@ typedef struct { signed long pd; } hugepd_t;
 #ifdef CONFIG_PPC_BOOK3S_64
 static inline int hugepd_ok(hugepd_t hpd)
 {
+#ifdef CONFIG_NUMA_BALANCING
+	/*
+	 * In order to enable batch handling of pte numa faults, Numa balancing
+	 * code use the _PAGE_NUMA bit even on pmd that is pointing to PTE PAGE.
+	 * 9532fec118d485ea37ab6e3ea372d68cd8b4cd0d. After commit
+	 * e2b3d202d1dba8f3546ed28224ce485bc50010be we really don't need to
+	 * support hugepd for ppc64.
+	 */
+	return 0;
+#else
 	/*
 	 * hugepd pointer, bottom two bits == 00 and next 4 bits
 	 * indicate size of table
 	 */
 	return (((hpd.pd & 0x3) == 0x0) && ((hpd.pd & HUGEPD_SHIFT_MASK) != 0));
+#endif
 }
 #else
 static inline int hugepd_ok(hugepd_t hpd)
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index d67db4b..71bd214 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -235,8 +235,14 @@ pte_t *huge_pte_alloc(struct mm_struct *mm, unsigned long addr, unsigned long sz
 	if (!hpdp)
 		return NULL;
 
+#ifdef CONFIG_NUMA_BALANCING
+	/*
+	 * We cannot support hugepd format with numa balancing support
+	 * enabled.
+	 */
+	return NULL;
+#endif
 	BUG_ON(!hugepd_none(*hpdp) && !hugepd_ok(*hpdp));
-
 	if (hugepd_none(*hpdp) && __hugepte_alloc(mm, hpdp, addr, pdshift, pshift))
 		return NULL;
 
-- 
1.8.3.2
