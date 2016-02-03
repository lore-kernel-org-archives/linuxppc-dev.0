Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (pegase1.c-s.fr [93.17.236.30])
 by lists.ozlabs.org (Postfix) with ESMTP id 7948F1A0244
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  4 Feb 2016 09:54:37 +1100 (AEDT)
Message-Id: <42371b0c28fe411a5956701edf10b343cf7fc7a4.1454538979.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1454538974.git.christophe.leroy@c-s.fr>
References: <cover.1454538974.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH v5 19/23] powerpc32: Remove clear_pages() and define
 clear_page() inline
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 Scott Wood <oss@buserror.net>
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org
Date: Wed,  3 Feb 2016 23:54:33 +0100 (CET)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

clear_pages() is never used expect by clear_page, and PPC32 is the
only architecture (still) having this function. Neither PPC64 nor
any other architecture has it.

This patch removes clear_pages() and moves clear_page() function
inline (same as PPC64) as it only is a few isns

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
v2: no change
v3: no change
v4: no change
v5: no change

 arch/powerpc/include/asm/page_32.h | 17 ++++++++++++++---
 arch/powerpc/kernel/misc_32.S      | 16 ----------------
 arch/powerpc/kernel/ppc_ksyms_32.c |  1 -
 3 files changed, 14 insertions(+), 20 deletions(-)

diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
index 68d73b2..6a8e179 100644
--- a/arch/powerpc/include/asm/page_32.h
+++ b/arch/powerpc/include/asm/page_32.h
@@ -1,6 +1,8 @@
 #ifndef _ASM_POWERPC_PAGE_32_H
 #define _ASM_POWERPC_PAGE_32_H
 
+#include <asm/cache.h>
+
 #if defined(CONFIG_PHYSICAL_ALIGN) && (CONFIG_PHYSICAL_START != 0)
 #if (CONFIG_PHYSICAL_START % CONFIG_PHYSICAL_ALIGN) != 0
 #error "CONFIG_PHYSICAL_START must be a multiple of CONFIG_PHYSICAL_ALIGN"
@@ -36,9 +38,18 @@ typedef unsigned long long pte_basic_t;
 typedef unsigned long pte_basic_t;
 #endif
 
-struct page;
-extern void clear_pages(void *page, int order);
-static inline void clear_page(void *page) { clear_pages(page, 0); }
+/*
+ * Clear page using the dcbz instruction, which doesn't cause any
+ * memory traffic (except to write out any cache lines which get
+ * displaced).  This only works on cacheable memory.
+ */
+static inline void clear_page(void *addr)
+{
+	unsigned int i;
+
+	for (i = 0; i < PAGE_SIZE / L1_CACHE_BYTES; i++, addr += L1_CACHE_BYTES)
+		dcbz(addr);
+}
 extern void copy_page(void *to, void *from);
 
 #include <asm-generic/getorder.h>
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 7d1284f..181afc1 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -517,22 +517,6 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 #endif /* CONFIG_BOOKE */
 
 /*
- * Clear pages using the dcbz instruction, which doesn't cause any
- * memory traffic (except to write out any cache lines which get
- * displaced).  This only works on cacheable memory.
- *
- * void clear_pages(void *page, int order) ;
- */
-_GLOBAL(clear_pages)
-	li	r0,PAGE_SIZE/L1_CACHE_BYTES
-	slw	r0,r0,r4
-	mtctr	r0
-1:	dcbz	0,r3
-	addi	r3,r3,L1_CACHE_BYTES
-	bdnz	1b
-	blr
-
-/*
  * Copy a whole page.  We use the dcbz instruction on the destination
  * to reduce memory traffic (it eliminates the unnecessary reads of
  * the destination into cache).  This requires that the destination
diff --git a/arch/powerpc/kernel/ppc_ksyms_32.c b/arch/powerpc/kernel/ppc_ksyms_32.c
index 30ddd8a..2bfaafe 100644
--- a/arch/powerpc/kernel/ppc_ksyms_32.c
+++ b/arch/powerpc/kernel/ppc_ksyms_32.c
@@ -10,7 +10,6 @@
 #include <asm/pgtable.h>
 #include <asm/dcr.h>
 
-EXPORT_SYMBOL(clear_pages);
 EXPORT_SYMBOL(ISA_DMA_THRESHOLD);
 EXPORT_SYMBOL(DMA_MODE_READ);
 EXPORT_SYMBOL(DMA_MODE_WRITE);
-- 
2.1.0
