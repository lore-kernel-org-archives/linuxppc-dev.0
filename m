Return-Path: <paulus@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 103051A03DF
 for <linuxppc-dev@lists.ozlabs.org>; Mon, 22 Feb 2016 13:41:31 +1100 (AEDT)
From: Paul Mackerras <paulus@ozlabs.org>
To: linuxppc-dev@ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 9/9] powerpc/mm/book3s-64: Expand the real page number field
 of the Linux PTE
Date: Mon, 22 Feb 2016 13:41:20 +1100
Message-Id: <1456108880-27464-10-git-send-email-paulus@ozlabs.org>
In-Reply-To: <1456108880-27464-1-git-send-email-paulus@ozlabs.org>
References: <1456108880-27464-1-git-send-email-paulus@ozlabs.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: Paul Mackerras <paulus@samba.org>

Now that other PTE fields have been moved out of the way, we can
expand the RPN field of the PTE on 64-bit Book 3S systems and align
it with the RPN field in the radix PTE format used by PowerISA v3.0
CPUs in radix mode.  For 64k page size, this means we need to move
the _PAGE_COMBO and _PAGE_4K_PFN bits.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/book3s/64/hash-4k.h  |  4 ++--
 arch/powerpc/include/asm/book3s/64/hash-64k.h | 12 ++++++------
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash-4k.h b/arch/powerpc/include/asm/book3s/64/hash-4k.h
index 0425d3e..7f60f7e 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-4k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-4k.h
@@ -52,8 +52,8 @@
 			 _PAGE_F_SECOND | _PAGE_F_GIX)
 
 /* shift to put page number into pte */
-#define PTE_RPN_SHIFT	(18)
-#define PTE_RPN_SIZE	(39)	/* gives 51-bit real addresses */
+#define PTE_RPN_SHIFT	(12)
+#define PTE_RPN_SIZE	(45)	/* gives 57-bit real addresses */
 
 #define _PAGE_4K_PFN		0
 #ifndef __ASSEMBLY__
diff --git a/arch/powerpc/include/asm/book3s/64/hash-64k.h b/arch/powerpc/include/asm/book3s/64/hash-64k.h
index ed390e1..8bb0325 100644
--- a/arch/powerpc/include/asm/book3s/64/hash-64k.h
+++ b/arch/powerpc/include/asm/book3s/64/hash-64k.h
@@ -25,8 +25,8 @@
 #define PGDIR_SIZE	(1UL << PGDIR_SHIFT)
 #define PGDIR_MASK	(~(PGDIR_SIZE-1))
 
-#define _PAGE_COMBO	0x00040000 /* this is a combo 4k page */
-#define _PAGE_4K_PFN	0x00080000 /* PFN is for a single 4k page */
+#define _PAGE_COMBO	0x00001000 /* this is a combo 4k page */
+#define _PAGE_4K_PFN	0x00002000 /* PFN is for a single 4k page */
 /*
  * Used to track subpage group valid if _PAGE_COMBO is set
  * This overloads _PAGE_F_GIX and _PAGE_F_SECOND
@@ -39,11 +39,11 @@
 
 /* Shift to put page number into pte.
  *
- * That gives us a max RPN of 37 bits, which means a max of 53 bits
- * of addressable physical space, or 49 bits for the special 4k PFNs.
+ * That gives us a max RPN of 41 bits, which means a max of 57 bits
+ * of addressable physical space, or 53 bits for the special 4k PFNs.
  */
-#define PTE_RPN_SHIFT	(20)
-#define PTE_RPN_SIZE	(37)
+#define PTE_RPN_SHIFT	(16)
+#define PTE_RPN_SIZE	(41)
 
 /*
  * we support 16 fragments per PTE page of 64K size.
-- 
2.6.4
