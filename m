Return-Path: <R65777@freescale.com>
Received: from co1outboundpool.messaging.microsoft.com
 (co1ehsobe004.messaging.microsoft.com [216.32.180.187])
 (using TLSv1 with cipher AES128-SHA (128/128 bits))
 (Client CN "mail.global.frontbridge.com",
 Issuer "MSIT Machine Auth CA 2" (not verified))
 by ozlabs.org (Postfix) with ESMTPS id DC27C2C01BF
 for <linuxppc-dev@lists.ozlabs.org>; Tue,  6 Aug 2013 21:37:09 +1000 (EST)
From: Bharat Bhushan <r65777@freescale.com>
To: <scottwood@freescale.com>, <benh@kernel.crashing.org>, <agraf@suse.de>,
 <paulus@samba.org>, <kvm@vger.kernel.org>, <kvm-ppc@vger.kernel.org>,
 <linuxppc-dev@lists.ozlabs.org>
Subject: [PATCH 4/6 v3] powerpc: move linux pte/hugepte search to more generic
 file
Date: Tue, 6 Aug 2013 17:01:12 +0530
Message-ID: <1375788674-13140-5-git-send-email-Bharat.Bhushan@freescale.com>
In-Reply-To: <1375788674-13140-1-git-send-email-Bharat.Bhushan@freescale.com>
References: <1375788674-13140-1-git-send-email-Bharat.Bhushan@freescale.com>
MIME-Version: 1.0
Content-Type: text/plain
Cc: Bharat Bhushan <bharat.bhushan@freescale.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Linux pte search functions find_linux_pte_or_hugepte() and
find_linux_pte() have nothing specific to 64bit anymore.
So they are move from pgtable-ppc64.h to asm/pgtable.h

Signed-off-by: Bharat Bhushan <bharat.bhushan@freescale.com>
---
v2->v3
 - no change
v1->v2
 - This is a new change in this version
 
 arch/powerpc/include/asm/pgtable-ppc64.h |   36 -----------------------------
 arch/powerpc/include/asm/pgtable.h       |   37 ++++++++++++++++++++++++++++++
 2 files changed, 37 insertions(+), 36 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index e3d55f6..d257d98 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -340,42 +340,6 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
 void pgtable_cache_init(void);
 
-/*
- * find_linux_pte returns the address of a linux pte for a given
- * effective address and directory.  If not found, it returns zero.
- */
-static inline pte_t *find_linux_pte(pgd_t *pgdir, unsigned long ea)
-{
-	pgd_t *pg;
-	pud_t *pu;
-	pmd_t *pm;
-	pte_t *pt = NULL;
-
-	pg = pgdir + pgd_index(ea);
-	if (!pgd_none(*pg)) {
-		pu = pud_offset(pg, ea);
-		if (!pud_none(*pu)) {
-			pm = pmd_offset(pu, ea);
-			if (pmd_present(*pm))
-				pt = pte_offset_kernel(pm, ea);
-		}
-	}
-	return pt;
-}
-
-#ifdef CONFIG_HUGETLB_PAGE
-pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
-				 unsigned *shift);
-#else
-static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
-					       unsigned *shift)
-{
-	if (shift)
-		*shift = 0;
-	return find_linux_pte(pgdir, ea);
-}
-#endif /* !CONFIG_HUGETLB_PAGE */
-
 #endif /* __ASSEMBLY__ */
 
 #endif /* _ASM_POWERPC_PGTABLE_PPC64_H_ */
diff --git a/arch/powerpc/include/asm/pgtable.h b/arch/powerpc/include/asm/pgtable.h
index b6293d2..690c8c2 100644
--- a/arch/powerpc/include/asm/pgtable.h
+++ b/arch/powerpc/include/asm/pgtable.h
@@ -217,6 +217,43 @@ extern int gup_hugepd(hugepd_t *hugepd, unsigned pdshift, unsigned long addr,
 
 extern int gup_hugepte(pte_t *ptep, unsigned long sz, unsigned long addr,
 		       unsigned long end, int write, struct page **pages, int *nr);
+
+/*
+ * find_linux_pte returns the address of a linux pte for a given
+ * effective address and directory.  If not found, it returns zero.
+ */
+static inline pte_t *find_linux_pte(pgd_t *pgdir, unsigned long ea)
+{
+	pgd_t *pg;
+	pud_t *pu;
+	pmd_t *pm;
+	pte_t *pt = NULL;
+
+	pg = pgdir + pgd_index(ea);
+	if (!pgd_none(*pg)) {
+		pu = pud_offset(pg, ea);
+		if (!pud_none(*pu)) {
+			pm = pmd_offset(pu, ea);
+			if (pmd_present(*pm))
+				pt = pte_offset_kernel(pm, ea);
+		}
+	}
+	return pt;
+}
+
+#ifdef CONFIG_HUGETLB_PAGE
+pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
+				 unsigned *shift);
+#else
+static inline pte_t *find_linux_pte_or_hugepte(pgd_t *pgdir, unsigned long ea,
+					       unsigned *shift)
+{
+	if (shift)
+		*shift = 0;
+	return find_linux_pte(pgdir, ea);
+}
+#endif /* !CONFIG_HUGETLB_PAGE */
+
 #endif /* __ASSEMBLY__ */
 
 #endif /* __KERNEL__ */
-- 
1.7.0.4
