Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3tPZ1g4P5QzDw65
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 20:40:07 +1100 (AEDT)
Received: from pps.filterd (m0098414.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.17/8.16.0.17) with SMTP id
 uAO9cceM124938
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 04:40:05 -0500
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 by mx0b-001b2d01.pphosted.com with ESMTP id 26wt6ucqth-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Thu, 24 Nov 2016 04:40:04 -0500
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Thu, 24 Nov 2016 04:40:03 -0500
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH] powerpc/mm: Fixup kernel read only mapping
Date: Thu, 24 Nov 2016 15:09:54 +0530
Message-Id: <20161124093954.12051-1-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

With commit e58e87adc8bf9 ("powerpc/mm: Update _PAGE_KERNEL_RO") we started
using the ppp value 0b110 to map kernel readonly. But that facility
was only added as part of ISA 2.04. For earlier ISA version only supported ppp
bit value for readonly mapping is 0b011. (This implies both user and kernel
get mapped using the same ppp bit value for readonly mapping.).

Update the code such that for earlier architecture version we use ppp value
0b011 for readonly mapping. We don't differentiate between power5+ and power5
here and apply the new ppp bits only from power6 (ISA 2.05). This keep the
changes minimal.

This fixes issue with PS3 spu usage reported at
https://lkml.kernel.org/r/rep.1421449714.geoff@infradead.org

Fixes: e58e87adc8bf9 ("powerpc/mm: Update _PAGE_KERNEL_RO")
Tested-by: Geoff Levand <geoff@infradead.org>
Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu.h  | 13 +++++++++----
 arch/powerpc/mm/hash_utils_64.c |  8 ++++++--
 2 files changed, 15 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index e88368354e49..c13242bf3098 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -27,6 +27,11 @@
 /*
  * Individual features below.
  */
+/*
+ * kernel read only support
+ * We added the ppp value 0b110 in ISA 2.04
+ */
+#define MMU_FTR_KERNEL_RO		ASM_CONST(0x00004000)
 
 /*
  * We need to clear top 16bits of va (from the remaining 64 bits )in
@@ -103,10 +108,10 @@
 #define MMU_FTRS_POWER4		MMU_FTRS_DEFAULT_HPTE_ARCH_V2
 #define MMU_FTRS_PPC970		MMU_FTRS_POWER4 | MMU_FTR_TLBIE_CROP_VA
 #define MMU_FTRS_POWER5		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
-#define MMU_FTRS_POWER6		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
-#define MMU_FTRS_POWER7		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
-#define MMU_FTRS_POWER8		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
-#define MMU_FTRS_POWER9		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
+#define MMU_FTRS_POWER6		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_KERNEL_RO
+#define MMU_FTRS_POWER7		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_KERNEL_RO
+#define MMU_FTRS_POWER8		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_KERNEL_RO
+#define MMU_FTRS_POWER9		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_KERNEL_RO
 #define MMU_FTRS_CELL		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \
 				MMU_FTR_CI_LARGE_PAGE
 #define MMU_FTRS_PA6T		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \
diff --git a/arch/powerpc/mm/hash_utils_64.c b/arch/powerpc/mm/hash_utils_64.c
index 5503078090cd..78dabf065ba9 100644
--- a/arch/powerpc/mm/hash_utils_64.c
+++ b/arch/powerpc/mm/hash_utils_64.c
@@ -193,8 +193,12 @@ unsigned long htab_convert_pte_flags(unsigned long pteflags)
 		/*
 		 * Kernel read only mapped with ppp bits 0b110
 		 */
-		if (!(pteflags & _PAGE_WRITE))
-			rflags |= (HPTE_R_PP0 | 0x2);
+		if (!(pteflags & _PAGE_WRITE)) {
+			if (mmu_has_feature(MMU_FTR_KERNEL_RO))
+				rflags |= (HPTE_R_PP0 | 0x2);
+			else
+				rflags |= 0x3;
+		}
 	} else {
 		if (pteflags & _PAGE_RWX)
 			rflags |= 0x2;
-- 
2.10.2
