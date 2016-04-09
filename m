Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e19.ny.us.ibm.com (e19.ny.us.ibm.com [129.33.205.209])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qhmKY39jLzDqGH
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 16:15:45 +1000 (AEST)
Received: from localhost
 by e19.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sat, 9 Apr 2016 02:15:43 -0400
Received: from b01cxnp22034.gho.pok.ibm.com (b01cxnp22034.gho.pok.ibm.com
 [9.57.198.24])
 by d01dlp01.pok.ibm.com (Postfix) with ESMTP id 15ACD38C8039
 for <linuxppc-dev@lists.ozlabs.org>; Sat,  9 Apr 2016 02:15:41 -0400 (EDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22034.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u396FcIb36962392
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 06:15:40 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u396Fbsp010590
 for <linuxppc-dev@lists.ozlabs.org>; Sat, 9 Apr 2016 02:15:38 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 27/68] powerpc/mm/radix: Dummy radix_enabled()
Date: Sat,  9 Apr 2016 11:43:23 +0530
Message-Id: <1460182444-2468-28-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1460182444-2468-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

In this patch we add the radix Kconfig and conditional check.
radix_enabled is written to always return 0 here. Once we have
all needed radix changes added, we will update this to mmu_feature
check.

We need to addt this early so that we can get it all build in the early
stage.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>

radix kconfig variable
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 2 ++
 arch/powerpc/include/asm/mmu.h           | 3 +++
 arch/powerpc/platforms/Kconfig.cputype   | 4 ++++
 3 files changed, 9 insertions(+)

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
index 142dff5e96d6..53299182dba9 100644
--- a/arch/powerpc/platforms/Kconfig.cputype
+++ b/arch/powerpc/platforms/Kconfig.cputype
@@ -331,6 +331,10 @@ config PPC_STD_MMU_64
 	def_bool y
 	depends on PPC_STD_MMU && PPC64
 
+config PPC_RADIX_MMU
+        def_bool y
+        depends on PPC_BOOK3S_64
+
 config PPC_MMU_NOHASH
 	def_bool y
 	depends on !PPC_STD_MMU
-- 
2.5.0
