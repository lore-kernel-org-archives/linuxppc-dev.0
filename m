Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e23smtp06.au.ibm.com (e23smtp06.au.ibm.com [202.81.31.148])
 (using TLSv1 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 8AA1D1A0600
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 13:57:13 +1000 (AEST)
Received: from /spool/local
 by e23smtp06.au.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Fri, 29 May 2015 13:57:13 +1000
Received: from d23relay06.au.ibm.com (d23relay06.au.ibm.com [9.185.63.219])
 by d23dlp03.au.ibm.com (Postfix) with ESMTP id 7A8C83578048
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 13:57:10 +1000 (EST)
Received: from d23av03.au.ibm.com (d23av03.au.ibm.com [9.190.234.97])
 by d23relay06.au.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 t4T3tlAr39190644
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 13:55:55 +1000
Received: from d23av03.au.ibm.com (localhost [127.0.0.1])
 by d23av03.au.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 t4T3tM6d020913
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 May 2015 13:55:23 +1000
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org, hmyneni@gmail.com,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 3/3] powerpc/mm: Change the swap encoding in pte.
Date: Fri, 29 May 2015 09:24:52 +0530
Message-Id: <1432871692-707-3-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1432871692-707-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1432871692-707-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Current swap encoding in pte can't support large pfns
above 4TB. Change the swap encoding such that we put
the swap type in the PTE bits. Also add build checks
to make sure we don't overlap with HPTEFLAGS.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/pgtable-ppc64.h | 26 +++++++++++++++++++++-----
 arch/powerpc/include/asm/pte-book3e.h    |  1 +
 arch/powerpc/include/asm/pte-hash64.h    |  1 +
 3 files changed, 23 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/pgtable-ppc64.h b/arch/powerpc/include/asm/pgtable-ppc64.h
index 43e6ad424c7f..954ae1201e42 100644
--- a/arch/powerpc/include/asm/pgtable-ppc64.h
+++ b/arch/powerpc/include/asm/pgtable-ppc64.h
@@ -347,11 +347,27 @@ static inline void __ptep_set_access_flags(pte_t *ptep, pte_t entry)
 	pr_err("%s:%d: bad pgd %08lx.\n", __FILE__, __LINE__, pgd_val(e))
 
 /* Encode and de-code a swap entry */
-#define __swp_type(entry)	(((entry).val >> 1) & 0x3f)
-#define __swp_offset(entry)	((entry).val >> 8)
-#define __swp_entry(type, offset) ((swp_entry_t){((type)<< 1)|((offset)<<8)})
-#define __pte_to_swp_entry(pte)	((swp_entry_t){pte_val(pte) >> PTE_RPN_SHIFT})
-#define __swp_entry_to_pte(x)	((pte_t) { (x).val << PTE_RPN_SHIFT })
+#define MAX_SWAPFILES_CHECK() do { \
+	BUILD_BUG_ON(MAX_SWAPFILES_SHIFT > SWP_TYPE_BITS); \
+	/*							\
+	 * Don't have overlapping bits with _PAGE_HPTEFLAGS	\
+	 * We filter HPTEFLAGS on set_pte.			\
+	 */							\
+	BUILD_BUG_ON(_PAGE_HPTEFLAGS & (0x1f << _PAGE_BIT_SWAP_TYPE)); \
+	} while (0)
+/*
+ * on pte we don't need handle RADIX_TREE_EXCEPTIONAL_SHIFT;
+ */
+#define SWP_TYPE_BITS 5
+#define __swp_type(x)		(((x).val >> _PAGE_BIT_SWAP_TYPE) \
+				& ((1UL << SWP_TYPE_BITS) - 1))
+#define __swp_offset(x)		((x).val >> PTE_RPN_SHIFT)
+#define __swp_entry(type, offset)	((swp_entry_t) { \
+					((type) << _PAGE_BIT_SWAP_TYPE) \
+					| ((offset) << PTE_RPN_SHIFT) })
+
+#define __pte_to_swp_entry(pte)		((swp_entry_t) { pte_val((pte)) })
+#define __swp_entry_to_pte(x)		__pte((x).val)
 
 void pgtable_cache_add(unsigned shift, void (*ctor)(void *));
 void pgtable_cache_init(void);
diff --git a/arch/powerpc/include/asm/pte-book3e.h b/arch/powerpc/include/asm/pte-book3e.h
index 91a704952ca1..8d8473278d91 100644
--- a/arch/powerpc/include/asm/pte-book3e.h
+++ b/arch/powerpc/include/asm/pte-book3e.h
@@ -11,6 +11,7 @@
 /* Architected bits */
 #define _PAGE_PRESENT	0x000001 /* software: pte contains a translation */
 #define _PAGE_SW1	0x000002
+#define _PAGE_BIT_SWAP_TYPE	2
 #define _PAGE_BAP_SR	0x000004
 #define _PAGE_BAP_UR	0x000008
 #define _PAGE_BAP_SW	0x000010
diff --git a/arch/powerpc/include/asm/pte-hash64.h b/arch/powerpc/include/asm/pte-hash64.h
index fc852f7e7b3a..ef612c160da7 100644
--- a/arch/powerpc/include/asm/pte-hash64.h
+++ b/arch/powerpc/include/asm/pte-hash64.h
@@ -16,6 +16,7 @@
  */
 #define _PAGE_PRESENT		0x0001 /* software: pte contains a translation */
 #define _PAGE_USER		0x0002 /* matches one of the PP bits */
+#define _PAGE_BIT_SWAP_TYPE	2
 #define _PAGE_EXEC		0x0004 /* No execute on POWER4 and newer (we invert) */
 #define _PAGE_GUARDED		0x0008
 /* We can derive Memory coherence from _PAGE_NO_CACHE */
-- 
2.1.4
