Return-Path: <paulus@samba.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id A67511A08C6
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 20 Feb 2016 17:13:10 +1100 (AEDT)
From: Paul Mackerras <paulus@samba.org>
To: linuxppc-dev@lists.ozlabs.org
Cc: Michael Ellerman <mpe@ellerman.id.au>,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>,
 Paul Mackerras <paulus@samba.org>
Subject: [RFC PATCH 1/9] powerpc/mm/book3s-64: Clean up some obsolete or
 misleading comments
Date: Sat, 20 Feb 2016 17:12:32 +1100
Message-Id: <1455948760-24710-2-git-send-email-paulus@samba.org>
In-Reply-To: <1455948760-24710-1-git-send-email-paulus@samba.org>
References: <1455948760-24710-1-git-send-email-paulus@samba.org>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

No code changes.

Signed-off-by: Paul Mackerras <paulus@samba.org>
---
 arch/powerpc/include/asm/book3s/64/hash.h | 13 ++++++-------
 arch/powerpc/mm/hash64_64k.c              |  3 +--
 arch/powerpc/mm/hash_utils_64.c           | 10 +++++-----
 3 files changed, 12 insertions(+), 14 deletions(-)

diff --git a/arch/powerpc/include/asm/book3s/64/hash.h b/arch/powerpc/include/asm/book3s/64/hash.h
index 8d1c816..9a0a4ef 100644
--- a/arch/powerpc/include/asm/book3s/64/hash.h
+++ b/arch/powerpc/include/asm/book3s/64/hash.h
@@ -4,8 +4,7 @@
 
 /*
  * Common bits between 4K and 64K pages in a linux-style PTE.
- * These match the bits in the (hardware-defined) PowerPC PTE as closely
- * as possible. Additional bits may be defined in pgtable-hash64-*.h
+ * Additional bits may be defined in pgtable-hash64-*.h
  *
  * Note: We only support user read/write permissions. Supervisor always
  * have full read/write to pages above PAGE_OFFSET (pages below that
@@ -14,13 +13,13 @@
  * We could create separate kernel read-only if we used the 3 PP bits
  * combinations that newer processors provide but we currently don't.
  */
-#define _PAGE_PTE		0x00001
+#define _PAGE_PTE		0x00001	/* distinguishes PTEs from pointers */
 #define _PAGE_PRESENT		0x00002 /* software: pte contains a translation */
 #define _PAGE_BIT_SWAP_TYPE	2
-#define _PAGE_USER		0x00004 /* matches one of the PP bits */
-#define _PAGE_EXEC		0x00008 /* No execute on POWER4 and newer (we invert) */
-#define _PAGE_GUARDED		0x00010
-/* We can derive Memory coherence from _PAGE_NO_CACHE */
+#define _PAGE_USER		0x00004 /* page may be accessed by userspace */
+#define _PAGE_EXEC		0x00008 /* execute permission */
+#define _PAGE_GUARDED		0x00010 /* G: guarded (side-effect) page */
+/* M (memory coherence) is always set in the HPTE, so we don't need it here */
 #define _PAGE_COHERENT		0x0
 #define _PAGE_NO_CACHE		0x00020 /* I: cache inhibit */
 #define _PAGE_WRITETHRU		0x00040 /* W: cache write-through */
diff --git a/arch/powerpc/mm/hash64_64k.c b/arch/powerpc/mm/hash64_64k.c
index b389572..b2d659c 100644
--- a/arch/powerpc/mm/hash64_64k.c
+++ b/arch/powerpc/mm/hash64_64k.c
@@ -249,8 +249,7 @@ int __hash_page_64K(unsigned long ea, unsigned long access,
 			return 0;
 		/*
 		 * Try to lock the PTE, add ACCESSED and DIRTY if it was
-		 * a write access. Since this is 4K insert of 64K page size
-		 * also add _PAGE_COMBO
+		 * a write access.
 		 */
 		new_pte = old_pte | _PAGE_BUSY | _PAGE_ACCESSED;
 		if (access & _PAGE_RW)
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index ba59d59..47a0bc1 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -168,11 +168,11 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
 		rflags |= HPTE_R_N;
 	/*
 	 * PP bits:
-	 * Linux use slb key 0 for kernel and 1 for user.
-	 * kernel areas are mapped by PP bits 00
-	 * and and there is no kernel RO (_PAGE_KERNEL_RO).
-	 * User area mapped by 0x2 and read only use by
-	 * 0x3.
+	 * Linux uses slb key 0 for kernel and 1 for user.
+	 * kernel areas are mapped with PP=00
+	 * and there is no kernel RO (_PAGE_KERNEL_RO).
+	 * User area is mapped with PP=0x2 for read/write
+	 * or PP=0x3 for read-only (including writeable but clean pages).
 	 */
 	if (pteflags & _PAGE_USER) {
 		rflags |= 0x2;
-- 
2.5.0
