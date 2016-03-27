Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqq96p4qzDqFX
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:25:25 +1100 (AEDT)
Received: from localhost
 by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:25:24 -0600
Received: from b03cxnp07028.gho.boulder.ibm.com
 (b03cxnp07028.gho.boulder.ibm.com [9.17.130.15])
 by d03dlp02.boulder.ibm.com (Postfix) with ESMTP id 31E843E4003B
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:25:21 -0600 (MDT)
Received: from d03av01.boulder.ibm.com (d03av01.boulder.ibm.com [9.17.195.167])
 by b03cxnp07028.gho.boulder.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8PLpe46334014
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 01:25:21 -0700
Received: from d03av01.boulder.ibm.com (localhost [127.0.0.1])
 by d03av01.boulder.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8PKHs026452
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:25:21 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 25/65] powerpc/mm/radix: Dummy radix_enabled()
Date: Sun, 27 Mar 2016 13:53:33 +0530
Message-Id: <1459067053-10835-25-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1459067053-10835-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
