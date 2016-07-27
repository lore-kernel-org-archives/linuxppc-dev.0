Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [103.22.144.67])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rzxtc361xzDrLR
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 28 Jul 2016 00:18:48 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: Benjamin Herrenschmidt <benh@kernel.crashing.org>,
 aneesh.kumar@linux.vnet.ibm.com, haokexin@gmail.com
Subject: [PATCH v3 10/21] powerpc/mm: Define radix_enabled() in one place &
 use static inline
Date: Thu, 28 Jul 2016 00:18:06 +1000
Message-Id: <1469629097-30859-10-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
References: <1469629097-30859-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

Currently we have radix_enabled() three times, twice in asm/book3s/64/mmu.h
and then a fallback in asm/mmu.h.

Consolidate them in asm/mmu.h. While we're at it convert them to be
static inlines, and change the fallback case to returning a bool, like
mmu_has_feature().

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu.h |  7 -------
 arch/powerpc/include/asm/mmu.h           | 16 ++++++++++++----
 2 files changed, 12 insertions(+), 11 deletions(-)

v3: New.

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index ad2d501cddcf..70c995870297 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -23,13 +23,6 @@ struct mmu_psize_def {
 };
 extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 
-#ifdef CONFIG_PPC_RADIX_MMU
-#define radix_enabled() mmu_has_feature(MMU_FTR_TYPE_RADIX)
-#else
-#define radix_enabled() (0)
-#endif
-
-
 #endif /* __ASSEMBLY__ */
 
 /* 64-bit classic hash table MMU */
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index eb942a446969..f413b3213a3b 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -163,6 +163,18 @@ static inline void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 }
 #endif /* !CONFIG_DEBUG_VM */
 
+#ifdef CONFIG_PPC_RADIX_MMU
+static inline bool radix_enabled(void)
+{
+	return mmu_has_feature(MMU_FTR_TYPE_RADIX);
+}
+#else
+static inline bool radix_enabled(void)
+{
+	return false;
+}
+#endif
+
 #endif /* !__ASSEMBLY__ */
 
 /* The kernel use the constants below to index in the page sizes array.
@@ -230,9 +242,5 @@ static inline void mmu_early_init_devtree(void) { }
 #  include <asm/mmu-8xx.h>
 #endif
 
-#ifndef radix_enabled
-#define radix_enabled() (0)
-#endif
-
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_MMU_H_ */
-- 
2.7.4
