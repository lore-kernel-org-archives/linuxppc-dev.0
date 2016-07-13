Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from mx0a-001b2d01.pphosted.com (mx0b-001b2d01.pphosted.com
 [148.163.158.5])
 (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rqDGs6GnTzDqK6
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 19:36:05 +1000 (AEST)
Received: from pps.filterd (m0098419.ppops.net [127.0.0.1])
 by mx0b-001b2d01.pphosted.com (8.16.0.11/8.16.0.11) with SMTP id
 u6D9YDQK014769
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:36:03 -0400
Received: from e37.co.us.ibm.com (e37.co.us.ibm.com [32.97.110.158])
 by mx0b-001b2d01.pphosted.com with ESMTP id 24567bwq0b-1
 (version=TLSv1.2 cipher=AES256-SHA bits=256 verify=NOT)
 for <linuxppc-dev@lists.ozlabs.org>; Wed, 13 Jul 2016 05:36:03 -0400
Received: from localhost
 by e37.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 13 Jul 2016 03:36:02 -0600
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH for-4.8 05/12] powerpc/mm: Clear top 16 bits of va only on
 older cpus
Date: Wed, 13 Jul 2016 15:05:24 +0530
In-Reply-To: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1468402531-4914-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
Message-Id: <1468402531-4914-6-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
List-Id: Linux on PowerPC Developers Mail List <linuxppc-dev.lists.ozlabs.org>
List-Unsubscribe: <https://lists.ozlabs.org/options/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=unsubscribe>
List-Archive: <http://lists.ozlabs.org/pipermail/linuxppc-dev/>
List-Post: <mailto:linuxppc-dev@lists.ozlabs.org>
List-Help: <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=help>
List-Subscribe: <https://lists.ozlabs.org/listinfo/linuxppc-dev>,
 <mailto:linuxppc-dev-request@lists.ozlabs.org?subject=subscribe>

As per ISA, we need to do this only for architecture version 2.02 and
earlier. This continued to work even for 2.07. But let's not do this for
anything after 2.02. ISA 3.0 requires these top bits to be not cleared.

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu.h   | 9 +++++++--
 arch/powerpc/kernel/cputable.c   | 4 ++--
 arch/powerpc/mm/hash_native_64.c | 6 ++++--
 3 files changed, 13 insertions(+), 6 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index e53ebebff474..54471228f7b8 100644
--- a/arch/powerpc/include/asm/mmu.h
+++ b/arch/powerpc/include/asm/mmu.h
@@ -24,6 +24,11 @@
 /*
  * This is individual features
  */
+/*
+ * We need to clear top 16bits of va (from the remaining 64 bits )in
+ * tlbie* instructions
+ */
+#define MMU_FTR_TLBIE_CROP_VA		ASM_CONST(0x00008000)
 
 /* Enable use of high BAT registers */
 #define MMU_FTR_USE_HIGH_BATS		ASM_CONST(0x00010000)
@@ -97,7 +102,7 @@
 #define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
 	MMU_FTR_HPTE_TABLE | MMU_FTR_PPCAS_ARCH_V2
 #define MMU_FTRS_POWER4		MMU_FTRS_DEFAULT_HPTE_ARCH_V2
-#define MMU_FTRS_PPC970		MMU_FTRS_POWER4
+#define MMU_FTRS_PPC970		MMU_FTRS_POWER4 | MMU_FTR_TLBIE_CROP_VA
 #define MMU_FTRS_POWER5		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
 #define MMU_FTRS_POWER6		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
 #define MMU_FTRS_POWER7		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
@@ -124,7 +129,7 @@ enum {
 		MMU_FTR_USE_TLBRSRV | MMU_FTR_USE_PAIRED_MAS |
 		MMU_FTR_NO_SLBIE_B | MMU_FTR_16M_PAGE | MMU_FTR_TLBIEL |
 		MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_CI_LARGE_PAGE |
-		MMU_FTR_1T_SEGMENT |
+		MMU_FTR_1T_SEGMENT | MMU_FTR_TLBIE_CROP_VA |
 #ifdef CONFIG_PPC_RADIX_MMU
 		MMU_FTR_RADIX |
 #endif
diff --git a/arch/powerpc/kernel/cputable.c b/arch/powerpc/kernel/cputable.c
index eeeacf6235a3..d81f826d1029 100644
--- a/arch/powerpc/kernel/cputable.c
+++ b/arch/powerpc/kernel/cputable.c
@@ -137,7 +137,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER4 (gp)",
 		.cpu_features		= CPU_FTRS_POWER4,
 		.cpu_user_features	= COMMON_USER_POWER4,
-		.mmu_features		= MMU_FTRS_POWER4,
+		.mmu_features		= MMU_FTRS_POWER4 | MMU_FTR_TLBIE_CROP_VA,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
@@ -152,7 +152,7 @@ static struct cpu_spec __initdata cpu_specs[] = {
 		.cpu_name		= "POWER4+ (gq)",
 		.cpu_features		= CPU_FTRS_POWER4,
 		.cpu_user_features	= COMMON_USER_POWER4,
-		.mmu_features		= MMU_FTRS_POWER4,
+		.mmu_features		= MMU_FTRS_POWER4 | MMU_FTR_TLBIE_CROP_VA,
 		.icache_bsize		= 128,
 		.dcache_bsize		= 128,
 		.num_pmcs		= 8,
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index b0e0fdbe0273..70521ef171fc 100644
--- a/arch/powerpc/mm/hash_native_64.c
+++ b/arch/powerpc/mm/hash_native_64.c
@@ -64,7 +64,8 @@ static inline void __tlbie(unsigned long vpn, int psize, int apsize, int ssize)
 	 * Older versions of the architecture (2.02 and earler) require the
 	 * masking of the top 16 bits.
 	 */
-	va &= ~(0xffffULL << 48);
+	if (mmu_has_feature(MMU_FTR_TLBIE_CROP_VA))
+		va &= ~(0xffffULL << 48);
 
 	switch (psize) {
 	case MMU_PAGE_4K:
@@ -113,7 +114,8 @@ static inline void __tlbiel(unsigned long vpn, int psize, int apsize, int ssize)
 	 * Older versions of the architecture (2.02 and earler) require the
 	 * masking of the top 16 bits.
 	 */
-	va &= ~(0xffffULL << 48);
+	if (mmu_has_feature(MMU_FTR_TLBIE_CROP_VA))
+		va &= ~(0xffffULL << 48);
 
 	switch (psize) {
 	case MMU_PAGE_4K:
-- 
2.7.4
