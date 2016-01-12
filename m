Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e28smtp01.in.ibm.com (e28smtp01.in.ibm.com [125.16.236.1])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A793B1A17C1
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 18:16:44 +1100 (AEDT)
Received: from localhost
 by e28smtp01.in.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Tue, 12 Jan 2016 12:46:42 +0530
Received: from d28relay02.in.ibm.com (d28relay02.in.ibm.com [9.184.220.59])
 by d28dlp03.in.ibm.com (Postfix) with ESMTP id 163F5125801E
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:47:27 +0530 (IST)
Received: from d28av02.in.ibm.com (d28av02.in.ibm.com [9.184.220.64])
 by d28relay02.in.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u0C7GTva53936238
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:46:29 +0530
Received: from d28av02.in.ibm.com (localhost [127.0.0.1])
 by d28av02.in.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u0C7GQfs013463
 for <linuxppc-dev@lists.ozlabs.org>; Tue, 12 Jan 2016 12:46:27 +0530
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au,
 Michael Neuling <mikey@neuling.org>
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [RFC PATCH V1 18/33] powerpc/mm: Add helper for update page flags
 during ioremap
Date: Tue, 12 Jan 2016 12:45:53 +0530
Message-Id: <1452582968-22669-19-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

They differ between radix and hash. Hence we need a helper

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/32/pgtable.h | 11 +++++++++++
 arch/powerpc/include/asm/book3s/64/hash.h    | 11 +++++++++++
 arch/powerpc/include/asm/nohash/pgtable.h    | 20 ++++++++++++++++++++
 arch/powerpc/mm/pgtable_64.c                 | 16 +---------------
 4 files changed, 43 insertions(+), 15 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgtable.h b/arch/powerpc/include/asm/book3s/32/pgtable.h
index c0898e26ed4a..b53d7504d6f6 100644
--- a/arch/powerpc/include/asm/book3s/32/pgtable.h
+++ b/arch/powerpc/include/asm/book3s/32/pgtable.h
@@ -491,6 +491,17 @@ static inline unsigned long gup_pte_filter(int write)
 		mask |= _PAGE_RW;
 	return mask;
 }
+
+static inline unsigned long ioremap_prot_flags(unsigned long flags)
+{
+	/* writeable implies dirty for kernel addresses */
+	if (flags & _PAGE_RW)
+		flags |= _PAGE_DIRTY;
+
+	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
+	flags &= ~(_PAGE_USER | _PAGE_EXEC);
+	return flags;
+}
 #endif /* !__ASSEMBLY__ */
 
 #endif /*  _ASM_POWERPC_BOOK3S_32_PGTABLE_H */
diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index d51709dad729..4f0fdb9a5d19 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -592,6 +592,17 @@ static inline unsigned long gup_pte_filter(int write)
 	return mask;
 }
 
+static inline unsigned long ioremap_prot_flags(unsigned long flags)
+{
+	/* writeable implies dirty for kernel addresses */
+	if (flags & _PAGE_RW)
+		flags |= _PAGE_DIRTY;
+
+	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
+	flags &= ~(_PAGE_USER | _PAGE_EXEC);
+	return flags;
+}
+
 #ifdef CONFIG_TRANSPARENT_HUGEPAGE
 extern void hpte_do_hugepage_flush(struct mm_struct *mm, unsigned long addr,
 				   pmd_t *pmdp, unsigned long old_pmd);
diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index e4173cb06e5b..8861ec146985 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -238,6 +238,26 @@ static inline unsigned long gup_pte_filter(int write)
 	return mask;
 }
 
+static inline unsigned long ioremap_prot_flags(unsigned long flags)
+{
+	/* writeable implies dirty for kernel addresses */
+	if (flags & _PAGE_RW)
+		flags |= _PAGE_DIRTY;
+
+	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
+	flags &= ~(_PAGE_USER | _PAGE_EXEC);
+
+#ifdef _PAGE_BAP_SR
+	/* _PAGE_USER contains _PAGE_BAP_SR on BookE using the new PTE format
+	 * which means that we just cleared supervisor access... oops ;-) This
+	 * restores it
+	 */
+	flags |= _PAGE_BAP_SR;
+#endif
+
+	return flags;
+}
+
 #ifdef CONFIG_HUGETLB_PAGE
 static inline int hugepd_ok(hugepd_t hpd)
 {
diff --git a/arch/powerpc/mm/pgtable_64.c b/arch/powerpc/mm/pgtable_64.c
index 21a9a171c267..aa8ff4c74563 100644
--- a/arch/powerpc/mm/pgtable_64.c
+++ b/arch/powerpc/mm/pgtable_64.c
@@ -188,21 +188,7 @@ void __iomem * ioremap_prot(phys_addr_t addr, unsigned long size,
 {
 	void *caller = __builtin_return_address(0);
 
-	/* writeable implies dirty for kernel addresses */
-	if (flags & _PAGE_RW)
-		flags |= _PAGE_DIRTY;
-
-	/* we don't want to let _PAGE_USER and _PAGE_EXEC leak out */
-	flags &= ~(_PAGE_USER | _PAGE_EXEC);
-
-#ifdef _PAGE_BAP_SR
-	/* _PAGE_USER contains _PAGE_BAP_SR on BookE using the new PTE format
-	 * which means that we just cleared supervisor access... oops ;-) This
-	 * restores it
-	 */
-	flags |= _PAGE_BAP_SR;
-#endif
-
+	flags = ioremap_prot_flags(flags);
 	if (ppc_md.ioremap)
 		return ppc_md.ioremap(addr, size, flags, caller);
 	return __ioremap_caller(addr, size, flags, caller);
-- 
2.5.0
