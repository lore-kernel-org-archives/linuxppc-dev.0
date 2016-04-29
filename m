Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDyK1xGTzDqBZ
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:21 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 43/70] powerpc/mm/radix: Add MMU_FTR_RADIX
Date: Fri, 29 Apr 2016 23:26:06 +1000
Message-Id: <1461936393-10131-43-git-send-email-mpe@ellerman.id.au>
In-Reply-To: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
References: <1461936393-10131-1-git-send-email-mpe@ellerman.id.au>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>

We are going to add asm changes in the follow up patches. Add the
feature bit now so that we can get it all build.

mpe: Note that if CONFIG_PPC_RADIX_MMU=n we define MMU_FTR_RADIX to
zero. This has the effect of turning all the radix_enabled() checks into
if (0), which the compiler is smart enough to elide completely.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Acked-by: Balbir Singh <bsingharora@gmail.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 3 ++-
 arch/powerpc/include/asm/mmu.h           | 9 +++++++++
 2 files changed, 11 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index 94d52ff49bbe..5854263d4d6e 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -23,7 +23,8 @@ struct mmu_psize_def {
 };
 extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
 
-#define radix_enabled() (0)
+#define radix_enabled() mmu_has_feature(MMU_FTR_RADIX)
+
 #endif /* __ASSEMBLY__ */
 
 /* 64-bit classic hash table MMU */
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 34070e982f1d..d91dc886c90f 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -88,6 +88,15 @@
  */
 #define MMU_FTR_1T_SEGMENT		ASM_CONST(0x40000000)
 
+/*
+ * Radix page table available
+ */
+#ifdef CONFIG_PPC_RADIX_MMU
+#define MMU_FTR_RADIX                  ASM_CONST(0x80000000)
+#else
+#define MMU_FTR_RADIX                  ASM_CONST(0)
+#endif
+
 /* MMU feature bit sets for various CPUs */
 #define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
 	MMU_FTR_HPTE_TABLE | MMU_FTR_PPCAS_ARCH_V2
-- 
2.5.0
