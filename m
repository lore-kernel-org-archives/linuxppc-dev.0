Return-Path: <rpm@xenomai.org>
Received: from smtp2-g21.free.fr (smtp2-g21.free.fr [212.27.42.2])
	by ozlabs.org (Postfix) with ESMTP id 7EDEBDDEE7
	for <linuxppc-dev@ozlabs.org>; Fri, 13 Feb 2009 09:18:53 +1100 (EST)
Received: from smtp2-g21.free.fr (localhost [127.0.0.1])
	by smtp2-g21.free.fr (Postfix) with ESMTP id B36214B00CE
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 23:18:47 +0100 (CET)
Received: from [192.168.0.7] (lgp44-6-88-185-217-115.fbx.proxad.net
	[88.185.217.115])
	by smtp2-g21.free.fr (Postfix) with ESMTP id B01FB4B0126
	for <linuxppc-dev@ozlabs.org>; Thu, 12 Feb 2009 23:18:44 +0100 (CET)
Message-ID: <4994A046.2080806@xenomai.org>
Date: Thu, 12 Feb 2009 23:18:46 +0100
From: Philippe Gerum <rpm@xenomai.org>
MIME-Version: 1.0
To: linuxppc-dev@ozlabs.org
Subject: [PATCH] powerpc: Fix _PAGE_CHG_MASK
Content-Type: text/plain; charset=UTF-8
Reply-To: rpm@xenomai.org
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.ozlabs.org>
List-Unsubscribe: <https://ozlabs.org/mailman/options/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=unsubscribe>
List-Archive: <http://ozlabs.org/pipermail/linuxppc-dev>
List-Post: <mailto:linuxppc-dev@ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@ozlabs.org?subject=help>
List-Subscribe: <https://ozlabs.org/mailman/listinfo/linuxppc-dev>,
	<mailto:linuxppc-dev-request@ozlabs.org?subject=subscribe>


Fix _PAGE_CHG_MASK so that pte_modify() does not affect the _PAGE_SPECIAL bit.

Signed-off-by: Philippe Gerum <rpm@xenomai.org>

--

 arch/powerpc/include/asm/pgtable-4k.h    |    2 +-
 arch/powerpc/include/asm/pgtable-64k.h   |    2 +-
 arch/powerpc/include/asm/pgtable-ppc32.h |    4 ++--
 3 files changed, 4 insertions(+), 4 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-4k.h b/arch/powerpc/include/asm/pgtable-4k.h
index 6b18ba9..1dbca4e 100644
--- a/arch/powerpc/include/asm/pgtable-4k.h
+++ b/arch/powerpc/include/asm/pgtable-4k.h
@@ -60,7 +60,7 @@
 /* It should be preserving the high 48 bits and then specifically */
 /* preserving _PAGE_SECONDARY | _PAGE_GROUP_IX */
 #define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY | \
-                         _PAGE_HPTEFLAGS)
+                         _PAGE_HPTEFLAGS | _PAGE_SPECIAL)

 /* Bits to mask out from a PMD to get to the PTE page */
 #define PMD_MASKED_BITS		0
diff --git a/arch/powerpc/include/asm/pgtable-64k.h b/arch/powerpc/include/asm/pgtable-64k.h
index 07b0d8f..7389003 100644
--- a/arch/powerpc/include/asm/pgtable-64k.h
+++ b/arch/powerpc/include/asm/pgtable-64k.h
@@ -114,7 +114,7 @@ static inline struct subpage_prot_table *pgd_subpage_prot(pgd_t *pgd)
  * pgprot changes
  */
 #define _PAGE_CHG_MASK	(PTE_RPN_MASK | _PAGE_HPTEFLAGS | _PAGE_DIRTY | \
-                         _PAGE_ACCESSED)
+                         _PAGE_ACCESSED | _PAGE_SPECIAL)

 /* Bits to mask out from a PMD to get to the PTE page */
 #define PMD_MASKED_BITS		0x1ff
diff --git a/arch/powerpc/include/asm/pgtable-ppc32.h b/arch/powerpc/include/asm/pgtable-ppc32.h
index 75dded6..8298afc 100644
--- a/arch/powerpc/include/asm/pgtable-ppc32.h
+++ b/arch/powerpc/include/asm/pgtable-ppc32.h
@@ -428,8 +428,8 @@ extern int icache_44x_need_flush;
 #define PMD_PAGE_SIZE(pmd)	bad_call_to_PMD_PAGE_SIZE()
 #endif

-#define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY | _PAGE_SPECIAL)
-
+#define _PAGE_CHG_MASK	(PAGE_MASK | _PAGE_ACCESSED | _PAGE_DIRTY | \
+			 _PAGE_SPECIAL)

 #define PAGE_PROT_BITS	(_PAGE_GUARDED | _PAGE_COHERENT | _PAGE_NO_CACHE | \
 			 _PAGE_WRITETHRU | _PAGE_ENDIAN | \

-- 
Philippe.
