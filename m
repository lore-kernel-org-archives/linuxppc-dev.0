Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [122.248.162.4])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e28smtp04.in.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id 2274C2C00AB
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 02:14:44 +1000 (EST)
Received: from /spool/local
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 12 May 2013 21:39:47 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp02.in.ibm.com (Postfix) with ESMTP id 929953940053
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 May 2013 21:44:40 +0530 (IST)
Received: from d28av03.in.ibm.com (d28av03.in.ibm.com [9.184.220.65])
 by d28relay04.in.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r4CGEYeu6881670
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 12 May 2013 21:44:34 +0530
Received: from d28av03.in.ibm.com (loopback [127.0.0.1])
 by d28av03.in.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r4CGEcpE023620
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 13 May 2013 02:14:39 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, dwg@au1.ibm.com
Subject: [PATCH -V8 16/18] powerpc/THP: Enable THP on PPC64
Date: Sun, 12 May 2013 21:44:23 +0530
Message-Id: <1368375265-19593-17-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1368375265-19593-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1368375265-19593-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

We enable only if the we support 16MB page size.

Reviewed-by: David Gibson <dwg@au1.ibm.com>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable-ppc64.h |  3 +--
 arch/powerpc/mm/pgtable_64.c             | 29 +++++++++++++++++++++++++++++
 2 files changed, 30 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 69cb52b..d046289 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -429,8 +429,7 @@ static inline int pmd_trans_splitting(pmd_t pmd)
 	return 0;
 }
 
-/* We will enable it in the last patch */
-#define has_transparent_hugepage() 0
+extern int has_transparent_hugepage(void);
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
 
 static inline pte_t pmd_pte(pmd_t pmd)
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 2ff92aa..1abf9cd 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -818,4 +818,33 @@ pmd_t pmdp_get_and_clear(struct mm_struct *mm,
 	memset(pgtable, 0, PTE_FRAG_SIZE);
 	return old_pmd;
 }
+
+int has_transparent_hugepage(void)
+{
+	if (!mmu_has_feature(MMU_FTR_16M_PAGE))
+		return 0;
+	/*
+	 * We support THP only if PMD_SIZE is 16MB.
+	 */
+	if (mmu_psize_defs[MMU_PAGE_16M].shift != PMD_SHIFT)
+		return 0;
+	/*
+	 * We need to make sure that we support 16MB hugepage in a segement
+	 * with base page size 64K or 4K. We only enable THP with a PAGE_SIZE
+	 * of 64K.
+	 */
+	/*
+	 * If we have 64K HPTE, we will be using that by default
+	 */
+	if (mmu_psize_defs[MMU_PAGE_64K].shift &&
+	    (mmu_psize_defs[MMU_PAGE_64K].penc[MMU_PAGE_16M] == -1))
+		return 0;
+	/*
+	 * Ok we only have 4K HPTE
+	 */
+	if (mmu_psize_defs[MMU_PAGE_4K].penc[MMU_PAGE_16M] == -1)
+		return 0;
+
+	return 1;
+}
 #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
-- 
1.8.1.2
