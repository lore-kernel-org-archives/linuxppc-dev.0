Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp04.au.ibm.com (e23smtp04.au.ibm.com [202.81.31.146])
 (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
 (Client CN "e23smtp04.au.ibm.com", Issuer "GeoTrust SSL CA" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id EC4A42C0315
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:06:13 +1100 (EST)
Received: from /spool/local
 by e23smtp04.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 26 Feb 2013 17:56:47 +1000
Received: from d23relay03.au.ibm.com (d23relay03.au.ibm.com [9.190.235.21])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id D643E3578050
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:06:11 +1100 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay03.au.ibm.com (8.13.8/8.13.8/NCO v10.0) with ESMTP id
 r1Q869jQ7078188
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:06:09 +1100
Received: from d23av03.au.ibm.com (loopback [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.13.1/NCO v10.0 AVout) with ESMTP id
 r1Q86AOk008941
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 26 Feb 2013 19:06:11 +1100
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org
Subject: [PATCH -V1 24/24] powerpc/THP: Enable THP on PPC64
Date: Tue, 26 Feb 2013 13:35:14 +0530
Message-Id: <1361865914-13911-25-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1361865914-13911-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1361865914-13911-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Cc: linux-mm@kvack.org, linuxppc-dev@lists.ozlabs.org,
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

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable.h |   30 ++++++++++++++++++++++++++++--
 1 file changed, 28 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index 09f3a77..17120c3 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -107,8 +107,34 @@ static inline int pmd_trans_huge(pmd_t pmd)
 	return ((pmd_val(pmd) & PMD_ISHUGE) ==  PMD_ISHUGE);
 }
 
-/* We will enable it in the last patch */
-#define has_transparent_hugepage() 0
+static inline int has_transparent_hugepage(void)
+{
+	if (!mmu_has_feature(MMU_FTR_16M_PAGE))
+		return 0;
+	/*
+	 * We support THP only if HPAGE_SHIFT is 16MB.
+	 */
+	if (!HPAGE_SHIFT || (HPAGE_SHIFT != mmu_psize_defs[MMU_PAGE_16M].shift))
+		return 0;
+	/*
+	 * We need to make sure that we support 16MB huge page in a segement
+	 * with base page size 64K or 4K. We only enable THP with a PAGE_SIZE
+	 * of 64K.
+	 */
+	/*
+	 * If we have 64K HPTE, we will be using that by default
+	 */
+	if (mmu_psize_defs[MMU_PAGE_64K].shift &&
+	    ((signed int)mmu_psize_defs[MMU_PAGE_64K].penc[MMU_PAGE_16M] == -1))
+		return 0;
+	/*
+	 * Ok we only have 4K HPTE
+	 */
+	if (mmu_psize_defs[MMU_PAGE_4K].penc[MMU_PAGE_16M] == -1)
+		return 0;
+
+	return 1;
+}
 
 static inline pmd_t pmd_mkold(pmd_t pmd)
 {
-- 
1.7.10
