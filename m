Return-Path: <christophe.leroy@c-s.fr>
Received: from mailhub1.si.c-s.fr (2.236.17.93.rev.sfr.net [93.17.236.2])
 by lists.ozlabs.org (Postfix) with ESMTP id 1FF2E1A1D47
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 12 Aug 2015 23:41:31 +1000 (AEST)
Message-Id: <e4f3c64207bdb53478cd747c9a754723b1bf9d70.1439382637.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1439382631.git.christophe.leroy@c-s.fr>
References: <cover.1439382631.git.christophe.leroy@c-s.fr>
From: Christophe Leroy <christophe.leroy@c-s.fr>
Subject: [PATCH 17/20] powerpc32: Remove clear_pages()
To: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 Paul Mackerras <paulus@samba.org>, Michael Ellerman <mpe@ellerman.id.au>,
 scottwood@freescale.com
Cc: linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
 Joakim Tjernlund <joakim.tjernlund@transmode.se>
Date: Wed, 12 Aug 2015 15:41:27 +0200 (CEST)
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

clear_pages() is never used, and PPC32 is the only architecture
(still) having this function. Neither PPC64 nor any other
architecture has it.

Signed-off-by: Christophe Leroy <christophe.leroy@c-s.fr>
---
 arch/powerpc/include/asm/page_32.h | 3 +--
 arch/powerpc/kernel/misc_32.S      | 7 +++----
 arch/powerpc/kernel/ppc_ksyms_32.c | 1 -
 3 files changed, 4 insertions(+), 7 deletions(-)

diff --git a/arch/powerpc/include/asm/page_32.h b/arch/powerpc/include/asm/page_32.h
index 68d73b2..cc2ebe8 100644
--- a/arch/powerpc/include/asm/page_32.h
+++ b/arch/powerpc/include/asm/page_32.h
@@ -37,8 +37,7 @@ typedef unsigned long pte_basic_t;
 #endif
 
 struct page;
-extern void clear_pages(void *page, int order);
-static inline void clear_page(void *page) { clear_pages(page, 0); }
+void clear_page(void *page);
 extern void copy_page(void *to, void *from);
 
 #include <asm-generic/getorder.h>
diff --git a/arch/powerpc/kernel/misc_32.S b/arch/powerpc/kernel/misc_32.S
index 72fd7a7..62f0487 100644
--- a/arch/powerpc/kernel/misc_32.S
+++ b/arch/powerpc/kernel/misc_32.S
@@ -517,15 +517,14 @@ END_FTR_SECTION_IFSET(CPU_FTR_COHERENT_ICACHE)
 #endif /* CONFIG_BOOKE */
 
 /*
- * Clear pages using the dcbz instruction, which doesn't cause any
+ * Clear page using the dcbz instruction, which doesn't cause any
  * memory traffic (except to write out any cache lines which get
  * displaced).  This only works on cacheable memory.
  *
- * void clear_pages(void *page, int order) ;
+ * void clear_page(void *page) ;
  */
-_GLOBAL(clear_pages)
+_GLOBAL(clear_page)
 	li	r0,PAGE_SIZE/L1_CACHE_BYTES
-	slw	r0,r0,r4
 	mtctr	r0
 1:	dcbz	0,r3
 	addi	r3,r3,L1_CACHE_BYTES
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
