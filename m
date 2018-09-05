Return-Path: <christophe.leroy@c-s.fr>
Received: from pegase1.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 42539l1SrkzF36g
 for <linuxppc-dev@lists.ozlabs.org>; Wed,  5 Sep 2018 22:36:58 +1000 (AEST)
Message-Id: <d078b40c8f5015611d983d229594a84e1e21d331.1535913369.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1535913369.git.christophe.leroy@c-s.fr>
References: <cover.1535913369.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [RFC PATCH v1 02/17] powerpc/mm: remove direct use of flags related
 to cache
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 npiggin@gmail.com, aneesh.kumar@linux.vnet.ibm.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed,  5 Sep 2018 12:36:55 +0000 (UTC)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As already done for PPC64, use pgprot_cache() helpers
instead of flags in ioremap() derived functions.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/nohash/pgtable.h |  2 ++
 arch/powerpc/mm/pgtable_32.c              | 15 +++++++++------
 2 files changed, 11 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/nohash/pgtable.h b/arch/powerpc/include/asm/nohash/pgtable.h
index b321c82b3624..5b82e44c4231 100644
--- a/arch/powerpc/include/asm/nohash/pgtable.h
+++ b/arch/powerpc/include/asm/nohash/pgtable.h
@@ -197,6 +197,8 @@ extern int ptep_set_access_flags(struct vm_area_struct *vma, unsigned long addre
 #if _PAGE_WRITETHRU != 0
 #define pgprot_cached_wthru(prot) (__pgprot((pgprot_val(prot) & ~_PAGE_CACHE_CTL) | \
 				            _PAGE_COHERENT | _PAGE_WRITETHRU))
+#else
+#define pgprot_cached_wthru(prot)	pgprot_noncached(prot)
 #endif
 
 #define pgprot_cached_noncoherent(prot) \
diff --git a/arch/powerpc/mm/pgtable_32.c b/arch/powerpc/mm/pgtable_32.c
index 528999738645..f983ffa24aa0 100644
--- a/arch/powerpc/mm/pgtable_32.c
+++ b/arch/powerpc/mm/pgtable_32.c
@@ -76,24 +76,27 @@ pgtable_t pte_alloc_one(struct mm_struct *mm, unsigned long address)
 void __iomem *
 ioremap(phys_addr_t addr, unsigned long size)
 {
-	return __ioremap_caller(addr, size, _PAGE_NO_CACHE | _PAGE_GUARDED,
-				__builtin_return_address(0));
+	unsigned long flags = pgprot_val(pgprot_noncached(__pgprot(0)));
+
+	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap);
 
 void __iomem *
 ioremap_wc(phys_addr_t addr, unsigned long size)
 {
-	return __ioremap_caller(addr, size, _PAGE_NO_CACHE,
-				__builtin_return_address(0));
+	unsigned long flags = pgprot_val(pgprot_noncached_wc(__pgprot(0)));
+
+	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap_wc);
 
 void __iomem *
 ioremap_wt(phys_addr_t addr, unsigned long size)
 {
-	return __ioremap_caller(addr, size, _PAGE_WRITETHRU,
-				__builtin_return_address(0));
+	unsigned long flags = pgprot_val(pgprot_cached_wthru(__pgprot(0)));
+
+	return __ioremap_caller(addr, size, flags, __builtin_return_address(0));
 }
 EXPORT_SYMBOL(ioremap_wt);
 
-- 
2.13.3
