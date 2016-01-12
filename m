Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp04.in.ibm.com (e28smtp04.in.ibm.com [125.16.236.4])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id C13F51A17BD
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 18:17:07 +1100 (AEDT)
Received: from localhost
 by e28smtp04.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 12 Jan 2016 12:47:05 +0530
Received: from d28relay04.in.ibm.com (d28relay04.in.ibm.com [9.184.220.61])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 3D45A1258069
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:47:50 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay04.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0C7GWER58327252
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:46:33 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0C7GSjx013867
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:46:29 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 15/33] powerpc/mm: Use helper for finding pte filter
 mask for gup
Date: Tue, 12 Jan 2016 12:45:50 +0530
Message-Id: <1452582968-22669-16-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1452582968-22669-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1452582968-22669-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 8 ++++++++
 arch/powerpc/include/asm/book3s/64/hash.h    | 9 +++++++++
 arch/powerpc/include/asm/nohash/pgtable.h    | 9 +++++++++
 arch/powerpc/mm/hugetlbpage.c                | 5 +----
 4 files changed, 27 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index 77adada2f3b4..c0898e26ed4a 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -483,6 +483,14 @@ static inline unsigned long pte_io_cache_bits(void)
 	return _PAGE_NO_CACHE | _PAGE_GUARDED;
 }
 
+static inline unsigned long gup_pte_filter(int write)
+{
+	unsigned long mask;
+	mask = _PAGE_PRESENT | _PAGE_USER;
+	if (write)
+		mask |= _PAGE_RW;
+	return mask;
+}
 #endif /* !__ASSEMBLY__ */
 
 #endif /*  _ASM_POWERPC_BOOK3S_32_PGTABLE_H */
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 1b27c0c8effa..ee8dd7e561b0 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -583,6 +583,15 @@ static inline unsigned long pte_io_cache_bits(void)
 	return _PAGE_NO_CACHE | _PAGE_GUARDED;
 }
 
+static inline unsigned long gup_pte_filter(int write)
+{
+	unsigned long mask;
+	mask = _PAGE_PRESENT | _PAGE_USER;
+	if (write)
+		mask |= _PAGE_RW;
+	return mask;
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 				   pmd_t *pmdp, unsigned long old_pmd);
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index 8c4bb8fda0de..e4173cb06e5b 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -229,6 +229,15 @@ static inline unsigned long pte_io_cache_bits(void)
 	return _PAGE_NO_CACHE | _PAGE_GUARDED;
 }
 
+static inline unsigned long gup_pte_filter(int write)
+{
+	unsigned long mask;
+	mask = _PAGE_PRESENT | _PAGE_USER;
+	if (write)
+		mask |= _PAGE_RW;
+	return mask;
+}
+
 #ifdef CONFIG_HUGETLB_PAGE
 static inline int hugepd_ok(hugepd_t hpd)
 {
diff --git a/arch/powerpc/mm/hugetlbpage.c b/arch/powerpc/mm/hugetlbpage.c
index 26fb814f289f..4e970f58f8d9 100644
--- a/arch/powerpc/mm/hugetlbpage.c
+++ b/arch/powerpc/mm/hugetlbpage.c
@@ -417,10 +417,7 @@ int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		end = pte_end;
 
 	pte = READ_ONCE(*ptep);
-	mask = _PAGE_PRESENT | _PAGE_USER;
-	if (write)
-		mask |= _PAGE_RW;
-
+	mask = gup_pte_filter(write);
 	if ((pte_val(pte) & mask) != mask)
 		return 0;
 
-- 
2.5.0
