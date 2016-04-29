Return-Path: <michael@ozlabs.org>
Received: from ozlabs.org (ozlabs.org [IPv6:2401:3900:2:1::2])
 (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qxDy53MLrzDqBS
 for <linuxppc-dev@lists.ozlabs.org>; Fri, 29 Apr 2016 23:27:09 +1000 (AEST)
From: Michael Ellerman <mpe@ellerman.id.au>
To: <linuxppc-dev@ozlabs.org>
Cc: aneesh.kumar@linux.vnet.ibm.com, bsingharora@gmail.com,
 Paul Mackerras <paulus@samba.org>
Subject: [PATCH v3 30/70] powerpc/mm/radix: Add dummy radix_enabled()
Date: Fri, 29 Apr 2016 23:25:53 +1000
Message-Id: <1461936393-10131-30-git-send-email-mpe@ellerman.id.au>
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

In this patch we add the radix Kconfig and conditional check.
radix_enabled() is written to always return 0 here. Once we have all
needed radix changes added, we will update this to an mmu_feature check.

We need to add this early so that we can get it all build in the early
stage.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 2 ++
 arch/powerpc/include/asm/mmu.h           | 3 +++
 arch/powerpc/platforms/Kconfig.cputype   | 9 +++++++++
 3 files changed, 14 insertions(+)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index b86786f2521c..593d9e3ce8e7 100644
--- a/arch/powerpc/include/asm/book3s/64/mmu.h
+++ b/arch/powerpc/include/asm/book3s/64/mmu.h
@@ -19,6 +19,8 @@ struct mmu_psize_def {
 	unsigned long	sllp;	/* SLB L||LP (exact mask to use in slbmte) */
 };
 extern struct mmu_psize_def mmu_psize_defs[MMU_PAGE_COUNT];
+
+#define radix_enabled() (0)
 #endif /* __ASSEMBLY__ */
 
 /* 64-bit classic hash table MMU */
diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index 5f55024f9522..decde4c4870d 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -204,6 +204,9 @@ static inline void assert_pte_locked(struct mm_struct *mm, unsigned long addr)
 #  include <asm/mmu-8xx.h>
 #endif
 
+#ifndef radix_enabled
+#define radix_enabled() (0)
+#endif
 
 #endif /* __KERNEL__ */
 #endif /* _ASM_POWERPC_MMU_H_ */
diff --git a/arch/powerpc/platforms/Kconfig.cputype b/arch/powerpc/platforms/Kconfig.cputype
index 142dff5e96d6..8d2cfb8cd64e 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -331,6 +331,15 @@ config PPC_STD_MMU_64
 	def_bool y
 	depends on PPC_STD_MMU && PPC64
 
+config PPC_RADIX_MMU
+	bool "Radix MMU Support"
+	depends on PPC_BOOK3S_64
+	default y
+	help
+	  Enable support for the Power ISA 3.0 Radix style MMU. Currently this
+	  is only implemented by IBM Power9 CPUs, if you don't have one of them
+	  you can probably disable this.
+
 config PPC_MMU_NOHASH
 	def_bool y
 	depends on !PPC_STD_MMU
-- 
2.5.0
