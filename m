Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e38.co.us.ibm.com (e38.co.us.ibm.com [32.97.110.159])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3qXqql399MzDqGV
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 19:25:55 +1100 (AEDT)
Received: from localhost
 by e38.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Sun, 27 Mar 2016 02:25:53 -0600
Received: from b01cxnp22033.gho.pok.ibm.com (b01cxnp22033.gho.pok.ibm.com
 [9.57.198.23])
 by d03dlp03.boulder.ibm.com (Postfix) with ESMTP id EA31119D803E
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 02:13:43 -0600 (MDT)
Received: from d01av03.pok.ibm.com (d01av03.pok.ibm.com [9.56.224.217])
 by b01cxnp22033.gho.pok.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id
 u2R8PopJ21495846
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 08:25:50 GMT
Received: from d01av03.pok.ibm.com (localhost [127.0.0.1])
 by d01av03.pok.ibm.com (8.14.4/8.14.4/NCO v10.0 AVout) with ESMTP id
 u2R8Pnew019925
 for <linuxppc-dev@lists.ozlabs.org>; Sun, 27 Mar 2016 04:25:49 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH 38/65] powerpc/mm/radix: Add MMU_FTR_RADIX
Date: Sun, 27 Mar 2016 13:53:46 +0530
Message-Id: <1459067053-10835-38-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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

We are going to add asm changes in the follow up patches. Add the
feature bit now so that we can get it all build. We will enable radix
in the last patch using cpu table.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/book3s/64/mmu.h | 3 ++-
 arch/powerpc/include/asm/mmu.h           | 4 ++++
 2 files changed, 6 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/include/asm/book3s/64/mmu.h b/arch/powerpc/include/asm/book3s/64/mmu.h
index a526642f1c02..0835a8f9904b 100644
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
index 34070e982f1d..9e8c05f9c562 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -87,6 +87,10 @@
 /* 1T segments available
  */
 #define MMU_FTR_1T_SEGMENT		ASM_CONST(0x40000000)
+/*
+ * Radix page table available
+ */
+#define MMU_FTR_RADIX                  ASM_CONST(0x80000000)
 
 /* MMU feature bit sets for various CPUs */
 #define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
-- 
2.5.0
