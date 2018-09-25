Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42KRsk1yC9zF13P
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 26 Sep 2018 02:51:06 +1000 (AEST)
Message-Id: <d6acec4c128db91426dee61c1374860560b4bc09.1537892499.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1537892498.git.christophe.leroy@c-s.fr>
References: <cover.1537892498.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 12/22] powerpc/mm: inline pte_alloc_one() and
 pte_alloc_one_kernel() in PPC32
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Tue, 25 Sep 2018 16:51:02 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As in PPC64, inline pte_alloc_one() and pte_alloc_one_kernel()
in PPC32. This will allow to switch nohash/32 to pte_fragment
without impacting hash/32.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/book3s/32/pgalloc.h | 22 ++++++++++++++++++++--
 arch/powerpc/include/asm/nohash/32/pgalloc.h | 22 ++++++++++++++++++++--
 arch/powerpc/mm/pgtable_32.c                 | 21 ---------------------
 3 files changed, 40 insertions(+), 25 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/32/pgalloc.h b/arch/powerpc/include/asm/book3s/32/pgalloc.h
index 4ddc7df20381..a4cf0de10931 100644
--- a/arch/powerpc/include/asm/book3s/32/pgalloc.h
+++ b/arch/powerpc/include/asm/book3s/32/pgalloc.h
@@ -80,8 +80,26 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 #define pmd_pgtable(pmd) pmd_page(pmd)
 #endif
 
-extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
-extern pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr);
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+{
+	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+}
+
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
+{
+	struct page *ptepage;
+
+	gfp_t flags = GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT;
+
+	ptepage = alloc_pages(flags, 0);
+	if (!ptepage)
+		return NULL;
+	if (!pgtable_page_ctor(ptepage)) {
+		__free_page(ptepage);
+		return NULL;
+	}
+	return ptepage;
+}
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
diff --git a/arch/powerpc/include/asm/nohash/32/pgalloc.h b/arch/powerpc/include/asm/nohash/32/pgalloc.h
index da8fdfc76418..78367855a4f3 100644
--- a/arch/powerpc/include/asm/nohash/32/pgalloc.h
+++ b/arch/powerpc/include/asm/nohash/32/pgalloc.h
@@ -81,8 +81,26 @@ static inline void pmd_populate(struct mm_struct *mm, pmd_t *pmdp,
 #define pmd_pgtable(pmd) pmd_page(pmd)
 #endif
 
-extern pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long addr);
-extern pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long addr);
+static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
+{
+	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
+}
+
+static inline pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
+{
+	struct page *ptepage;
+
+	gfp_t flags = GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT;
+
+	ptepage = alloc_pages(flags, 0);
+	if (!ptepage)
+		return NULL;
+	if (!pgtable_page_ctor(ptepage)) {
+		__free_page(ptepage);
+		return NULL;
+	}
+	return ptepage;
+}
 
 static inline void pte_free_kernel(struct mm_struct *mm, pte_t *pte)
 {
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index ea4442dde0d5..745f2f30d4e9 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -43,27 +43,6 @@ EXPORT_SYMBOL(ioremap_bot);	/* aka VMALLOC_END */
 
 extern char etext[], _stext[], _sinittext[], _einittext[];
 
-pte_t *pte_alloc_one_kernel(struct mm_struct *mm, unsigned long address)
-{
-	return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
-}
-
-pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
-{
-	struct page *ptepage;
-
-	gfp_t flags = GFP_KERNEL | __GFP_ZERO | __GFP_ACCOUNT;
-
-	ptepage = alloc_pages(flags, 0);
-	if (!ptepage)
-		return NULL;
-	if (!pgtable_page_ctor(ptepage)) {
-		__free_page(ptepage);
-		return NULL;
-	}
-	return ptepage;
-}
-
 void __iomem *
 ioremap(phys_addr_t addr, unsigned long size)
 {
-- 
2.13.3
