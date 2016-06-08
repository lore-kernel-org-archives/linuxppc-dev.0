Return-Path: <aneesh.kumar@linux.vnet.ibm.com>
Received: from e17.ny.us.ibm.com (e17.ny.us.ibm.com [129.33.205.207])
 (using TLSv1.2 with cipher CAMELLIA256-SHA (256/256 bits))
 (No client certificate requested)
 by lists.ozlabs.org (Postfix) with ESMTPS id 3rPrNb1Xr6zDr1g
 for <linuxppc-dev@lists.ozlabs.org>; Thu,  9 Jun 2016 00:26:54 +1000 (AEST)
Received: from localhost
 by e17.ny.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only!
 Violators will be prosecuted
 for <linuxppc-dev@lists.ozlabs.org> from <aneesh.kumar@linux.vnet.ibm.com>;
 Wed, 8 Jun 2016 10:26:53 -0400
From: "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
To: benh@kernel.crashing.org, paulus@samba.org, mpe@ellerman.id.au
Cc: linuxppc-dev@lists.ozlabs.org,
 "Aneesh Kumar K.V" <aneesh.kumar@linux.vnet.ibm.com>
Subject: [PATCH V2 08/10] powerpc/mm: Clear top 16 bits of va only on older
 cpus
Date: Wed,  8 Jun 2016 19:55:56 +0530
Message-Id: <1465395958-21349-9-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
In-Reply-To: <1465395958-21349-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
References: <1465395958-21349-1-git-send-email-aneesh.kumar@linux.vnet.ibm.com>
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
anything after 2.02

Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.vnet.ibm.com>
---
 arch/powerpc/include/asm/mmu.h   | 12 +++++++++---
 arch/powerpc/mm/hash_native_64.c |  6 ++++--
 2 files changed, 13 insertions(+), 5 deletions(-)

diff --git a/arch/powerpc/include/asm/mmu.h b/arch/powerpc/include/asm/mmu.h
index e53ebebff474..616575fcbcc7 100644
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
@@ -96,8 +101,9 @@
 /* MMU feature bit sets for various CPUs */
 #define MMU_FTRS_DEFAULT_HPTE_ARCH_V2	\
 	MMU_FTR_HPTE_TABLE | MMU_FTR_PPCAS_ARCH_V2
-#define MMU_FTRS_POWER4		MMU_FTRS_DEFAULT_HPTE_ARCH_V2
-#define MMU_FTRS_PPC970		MMU_FTRS_POWER4
+#define MMU_FTRS_POWER4		MMU_FTRS_DEFAULT_HPTE_ARCH_V2 | \
+				MMU_FTR_TLBIE_CROP_VA
+#define MMU_FTRS_PPC970		MMU_FTRS_POWER4 | MMU_FTR_TLBIE_CROP_VA
 #define MMU_FTRS_POWER5		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
 #define MMU_FTRS_POWER6		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
 #define MMU_FTRS_POWER7		MMU_FTRS_POWER4 | MMU_FTR_LOCKLESS_TLBIE
@@ -124,7 +130,7 @@ enum {
 		MMU_FTR_USE_TLBRSRV | MMU_FTR_USE_PAIRED_MAS |
 		MMU_FTR_NO_SLBIE_B | MMU_FTR_16M_PAGE | MMU_FTR_TLBIEL |
 		MMU_FTR_LOCKLESS_TLBIE | MMU_FTR_CI_LARGE_PAGE |
-		MMU_FTR_1T_SEGMENT |
+		MMU_FTR_1T_SEGMENT | MMU_FTR_TLBIE_CROP_VA |
 #ifdef CONFIG_PPC_RADIX_MMU
 		MMU_FTR_RADIX |
 #endif
diff --git a/arch/powerpc/mm/hash_native_64.c b/arch/powerpc/mm/hash_native_64.c
index e37916cbc18d..4c6b68ef571c 100644
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
